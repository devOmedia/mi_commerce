class ProductDetailsModel {
  String? status;
  int? statusCode;
  Data? data;
  String? error;

  ProductDetailsModel({this.status, this.statusCode, this.data, this.error});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    error = json['error'];
  }
}

class Data {
  int? id;
  Brand? brand;
  String? image;
  Charge? charge;
  List<Images>? images;
  String? slug;
  String? productName;
  String? model;
  String? commissionType;
  String? amount;
  String? tag;
  String? description;
  String? note;
  String? embaddedVideoLink;
  int? maximumOrder;
  int? stock;
  bool? isBackOrder;
  String? specification;
  String? warranty;
  bool? preOrder;
  int? productReview;
  bool? isSeller;
  bool? isPhone;
  bool? willShowEmi;
  dynamic badge;
  bool? isActive;
  String? sackEquivalent;
  String? createdAt;
  String? updatedAt;
  dynamic language;
  String? seller;
  dynamic combo;
  String? createdBy;
  dynamic updatedBy;
  List<int>? category;

  Data(
      {this.id,
      this.brand,
      this.image,
      this.charge,
      this.images,
      this.slug,
      this.productName,
      this.model,
      this.commissionType,
      this.amount,
      this.tag,
      this.description,
      this.note,
      this.embaddedVideoLink,
      this.maximumOrder,
      this.stock,
      this.isBackOrder,
      this.specification,
      this.warranty,
      this.preOrder,
      this.productReview,
      this.isSeller,
      this.isPhone,
      this.willShowEmi,
      this.badge,
      this.isActive,
      this.sackEquivalent,
      this.createdAt,
      this.updatedAt,
      this.language,
      this.seller,
      this.combo,
      this.createdBy,
      this.updatedBy,
      this.category,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'] != null ?  Brand.fromJson(json['brand']) : null;
    image = json['image'];
    charge =
        json['charge'] != null ?  Charge.fromJson(json['charge']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add( Images.fromJson(v));
      });
    }
    slug = json['slug'];
    productName = json['product_name'];
    model = json['model'];
    commissionType = json['commission_type'];
    amount = json['amount'];
    tag = json['tag'];
    description = json['description'];
    note = json['note'];
    embaddedVideoLink = json['embadded_video_link'];
    maximumOrder = json['maximum_order'];
    stock = json['stock'];
    isBackOrder = json['is_back_order'];
    specification = json['specification'];
    warranty = json['warranty'];
    preOrder = json['pre_order'];
    productReview = json['product_review'];
    isSeller = json['is_seller'];
    isPhone = json['is_phone'];
    willShowEmi = json['will_show_emi'];
    badge = json['badge'];
    isActive = json['is_active'];
    sackEquivalent = json['sack_equivalent'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    language = json['language'];
    seller = json['seller'];
    combo = json['combo'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    category = json['category'].cast<int>();
    
  }
}

class Brand {
  String? name;
  String? image;
  String? headerImage;
  String? slug;

  Brand({this.name, this.image, this.headerImage, this.slug});

  Brand.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    headerImage = json['header_image'];
    slug = json['slug'];
  }
}

class Charge {
  int? bookingPrice;
  int? currentCharge;
  int? discountCharge;
  int? sellingPrice;
  int? profit;
  bool? isEvent;
  int? eventId;
  bool? highlight;
  int? highlightId;
  bool? groupping;
  int? grouppingId;
  int? campaignSectionId;
  bool? campaignSection;
  String? message;

  Charge(
      {this.bookingPrice,
      this.currentCharge,
      this.discountCharge,
      this.sellingPrice,
      this.profit,
      this.isEvent,
      this.eventId,
      this.highlight,
      this.highlightId,
      this.groupping,
      this.grouppingId,
      this.campaignSectionId,
      this.campaignSection,
      this.message});

  Charge.fromJson(Map<String, dynamic> json) {
    bookingPrice = json['booking_price'];
    currentCharge = json['current_charge'];
    discountCharge = json['discount_charge'];
    sellingPrice = json['selling_price'];
    profit = json['profit'];
    isEvent = json['is_event'];
    eventId = json['event_id'];
    highlight = json['highlight'];
    highlightId = json['highlight_id'];
    groupping = json['groupping'];
    grouppingId = json['groupping_id'];
    campaignSectionId = json['campaign_section_id'];
    campaignSection = json['campaign_section'];
    message = json['message'];
  }

}

class Images {
  int? id;
  String? image;
  bool? isPrimary;
  int? product;

  Images({this.id, this.image, this.isPrimary, this.product});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    isPrimary = json['is_primary'];
    product = json['product'];
  }
}
