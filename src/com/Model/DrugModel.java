package com.Model;

public class DrugModel {
	String ndc_id;
	String package_ndc_id;
	String generic_name;
	String drug_indication;
	String brand_name;
	String manufacurer_name;
	String route;
	String product_type;

	public String getNdc_id() {
		return ndc_id;
	}

	public void setNdc_id(String ndc_id) {
		this.ndc_id = ndc_id;
	}

	public String getPackage_ndc_id() {
		return package_ndc_id;
	}

	public void setPackage_ndc_id(String package_ndc_id) {
		this.package_ndc_id = package_ndc_id;
	}

	public String getGeneric_name() {
		return generic_name;
	}

	public void setGeneric_name(String generic_name) {
		this.generic_name = generic_name;
	}

	public String getDrug_indication() {
		return drug_indication;
	}

	public void setDrug_indication(String drug_indication) {
		this.drug_indication = drug_indication;
	}

	public String getBrand_name() {
		return brand_name;
	}

	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}

	public String getManufacurer_name() {
		return manufacurer_name;
	}

	public void setManufacurer_name(String manufacurer_name) {
		this.manufacurer_name = manufacurer_name;
	}

	public String getRoute() {
		return route;
	}

	public void setRoute(String route) {
		this.route = route;
	}

	public String getProduct_type() {
		return product_type;
	}

	public void setProduct_type(String product_type) {
		this.product_type = product_type;
	}
	
	 @Override
	    public boolean equals(Object obj) {
	        if (obj instanceof DrugModel) {
	            return ((DrugModel) obj).ndc_id.hashCode() == ndc_id.hashCode();
	        }
	        return false;
	    }
	    @Override
	    public int hashCode() {
	        return this.ndc_id.hashCode();
	    }

}
