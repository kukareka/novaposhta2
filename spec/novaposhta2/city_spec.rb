require 'spec_helper'

module Novaposhta2
  describe City do
    before do
      @city_ref = '8d5a980d-391c-11dd-90d9-001a92567626'
      @city_name = 'Київ'

      @person_ref = '892dfe37-959d-11e4-acce-0050568002cf'
      @person_contact_ref = '6573d9f1-95a3-11e4-acce-0050568002cf'
    end


    describe '::all' do
      it 'returns list of cities' do
        expect(City.all.count).to be > 100
      end
    end

    describe '::match' do
      it 'returns cities matching name' do
        expect(City.match(@city_name).first.ref).to eq @city_ref
      end

      it 'returns multiple cities' do
        expect(City.match('Кі').count).to be > 1
      end

      it 'returns empty array if no cities found' do
        expect(City.match('Москва').count).to be 0
      end
    end

    describe '::find_by_ref' do
      it 'finds city by ref' do
        expect(City.find_by_ref(@city_ref).description).to eq @city_name
      end

      it 'returns nil if city ref was not found' do
        expect(City.find_by_ref('8d5a980d-391c-11dd-90d9-001a92567627')).to be_nil
      end
    end

    describe '::find' do
      it 'finds city by name' do
        expect(City.find(@city_name).ref).to eq @city_ref
      end

      it 'returns nil if more than 1 city match' do
        expect(City.find('К')).to be_nil
      end
    end

    describe '::[]' do
      it 'is shortcut for find' do
        expect(City[@city_name].ref).to eq @city_ref
      end
    end

    describe '#warehouses' do
      it 'returns list of warehouses in the city' do
        expect(City.find_by_ref(@city_ref).warehouses.count).to be > 10
      end

      it 'returns warehouse by number' do
        expect(City[@city_name][1].number).to eq 1
        expect(City[@city_name][2].number).to eq 2
      end

      it 'returns nil if there is no such warehouse' do
        expect(City[@city_name][1000]).to be_nil
        expect(City[@city_name][2000]).to be_nil
      end

    end

    describe '#[]' do
      it 'is shortcut for warehouses' do
        expect(City[@city_name][1].number).to eq 1
        expect(City[@city_name][2].number).to eq 2
      end
    end

    describe '#person' do
      it 'creates new person in the city' do
        p = City[@city_name].person('Олег', 'Кукарека', '380639599676')
        expect(p.ref).to eq @person_ref
        expect(p.contact_ref).to eq @person_contact_ref
        q = City[@city_name].person('Олег', 'Кукарека', '380639599676')
        expect(q.ref).to eq p.ref
        expect(q.contact_ref).to eq p.contact_ref
      end
    end

  end
end



