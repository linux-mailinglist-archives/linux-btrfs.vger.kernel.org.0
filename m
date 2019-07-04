Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340995FED3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 01:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfGDXvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 19:51:49 -0400
Received: from m9a0003g.houston.softwaregrp.com ([15.124.64.68]:40787 "EHLO
        m9a0003g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727313AbfGDXvt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 19:51:49 -0400
Received: FROM m9a0003g.houston.softwaregrp.com (15.121.0.190) BY m9a0003g.houston.softwaregrp.com WITH ESMTP;
 Thu,  4 Jul 2019 23:51:47 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 4 Jul 2019 23:51:41 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 4 Jul 2019 23:51:41 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3202.namprd18.prod.outlook.com (10.255.138.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 23:51:39 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Thu, 4 Jul 2019
 23:51:39 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        James Harvey <jamespharvey20@gmail.com>
Subject: Re: [PATCH v2] btrfs: inode: Don't compress if NODATASUM or NODATACOW
 set
Thread-Topic: [PATCH v2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
Thread-Index: AQHVL8ue7nuhfXyQVU+BGsD2wENnxaa6pHuwgACCswA=
Date:   Thu, 4 Jul 2019 23:51:38 +0000
Message-ID: <7eedec47-5ab1-0d39-7cb0-e7ab75b2424a@suse.com>
References: <20190701051225.17957-1-wqu@suse.com>
 <20190704160400.GY20977@twin.jikos.cz>
In-Reply-To: <20190704160400.GY20977@twin.jikos.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0055.apcprd03.prod.outlook.com
 (2603:1096:202:17::25) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [240e:3a1:c40:c630::19f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f85667a3-0665-4632-e70a-08d700da8e1f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3202;
x-ms-traffictypediagnostic: BY5PR18MB3202:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BY5PR18MB3202F9FB6E3CB012CD921AFDD6FA0@BY5PR18MB3202.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(54534003)(6116002)(6506007)(386003)(86362001)(81156014)(8676002)(31696002)(81166006)(11346002)(6512007)(99286004)(6436002)(68736007)(6306002)(446003)(5660300002)(53936002)(14454004)(31686004)(71190400001)(71200400001)(6246003)(486006)(76176011)(25786009)(2501003)(476003)(6486002)(229853002)(2616005)(52116002)(46003)(36756003)(102836004)(2906002)(256004)(14444005)(316002)(110136005)(305945005)(64756008)(7736002)(478600001)(186003)(73956011)(66946007)(66476007)(8936002)(66446008)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3202;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BEqI64hSKB03xUmutpupWnZcSwAuZvOehXQ1WYE00kpZM9xooEUsN/qEzpbNsTud0mHQtq+lSHWKr0TEk/Lu4uxjsWqMxPRR9V8DY37RdUmQQ6gQywcICSvhXjonJ5FLSbjru7jWRfwhSTyB7ykNu6Tr39jGnNi1WY8I2PJi4WONrpTegOZ4NhvfWCg6rtd6QyGqFnRi60+bblls5YRTXtX8tABMTQ6BTU9iWOv9iZCsEDtzbH8rHF4FRpS+HXPhN+Y0LLBxtfI13hf0GE+mvpGRWMZalW4cQTPuGouUFL1Otmxq6op0NIX7VGYiM2XVSq6ChB++KcoNvLMtX5kefsyGoWz/n6iw+76jRgZ61VmCI39MdBgqEd684lOnefMnLWvGC9PHbgd4UBKZZTcW/p5C0JO4XY48dd4p5eh95SQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62A3457CDF69BB41B7CDDB4A78A61DD5@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f85667a3-0665-4632-e70a-08d700da8e1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 23:51:38.8267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqu@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3202
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvNy81IOS4iuWNiDEyOjA0LCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+IE9uIE1v
biwgSnVsIDAxLCAyMDE5IGF0IDA1OjEyOjQ2QU0gKzAwMDAsIFF1IFdlbnJ1byB3cm90ZToNCj4+
IEFzIGJ0cmZzKDUpIHNwZWNpZmllZDoNCj4+DQo+PiAJTm90ZQ0KPj4gCUlmIG5vZGF0YWNvdyBv
ciBub2RhdGFzdW0gYXJlIGVuYWJsZWQsIGNvbXByZXNzaW9uIGlzIGRpc2FibGVkLg0KPj4NCj4+
IElmIE5PREFUQVNVTSBvciBOT0RBVEFDT1cgc2V0LCB3ZSBzaG91bGQgbm90IGNvbXByZXNzIHRo
ZSBleHRlbnQuDQo+Pg0KPj4gTm9ybWFsbHkgTk9EQVRBQ09XIGlzIGRldGVjdGVkIHByb3Blcmx5
IGluIHJ1bl9kZWxhbGxvY19yYW5nZSgpIHNvDQo+PiBjb21wcmVzc2lvbiB3b24ndCBoYXBwZW4g
Zm9yIE5PREFUQUNPVy4NCj4+DQo+PiBIb3dldmVyIGZvciBOT0RBVEFTVU0gd2UgZG9uJ3QgaGF2
ZSBhbnkgY2hlY2ssIGFuZCBpdCBjYW4gY2F1c2UNCj4+IGNvbXByZXNzZWQgZXh0ZW50IHdpdGhv
dXQgY3N1bSBwcmV0dHkgZWFzaWx5LCBqdXN0IGJ5Og0KPj4gICBta2ZzLmJ0cmZzIC1mICRkZXYN
Cj4+ICAgbW91bnQgJGRldiAkbW50IC1vIG5vZGF0YXN1bQ0KPj4gICB0b3VjaCAkbW50L2Zvb2Jh
cg0KPj4gICBtb3VudCAtbyByZW1vdW50LGRhdGFzdW0sY29tcHJlc3MgJG1udA0KPj4gICB4ZnNf
aW8gLWYgLWMgInB3cml0ZSAwIDEyOEsiICRtbnQvZm9vYmFyDQo+Pg0KPj4gQW5kIGluIGZhY3Qs
IHdlIGhhdmUgYSBidWcgcmVwb3J0IGFib3V0IGNvcnJ1cHRlZCBjb21wcmVzc2VkIGV4dGVudA0K
Pj4gd2l0aG91dCBwcm9wZXIgZGF0YSBjaGVja3N1bSBzbyBldmVuIFJBSUQxIGNhbid0IHJlY292
ZXIgdGhlIGNvcnJ1cHRpb24uDQo+PiAoaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3df
YnVnLmNnaT9pZD0xOTk3MDcpDQo+Pg0KPj4gUnVubmluZyBjb21wcmVzc2lvbiB3aXRob3V0IHBy
b3BlciBjaGVja3N1bSBjb3VsZCBjYXVzZSBtb3JlIGRhbWFnZSB3aGVuDQo+PiBjb3JydXB0aW9u
IGhhcHBlbnMsIGFzIGNvbXByZXNzZWQgZGF0YSBjb3VsZCBtYWtlIHRoZSB3aG9sZSBleHRlbnQN
Cj4+IHVucmVhZGFibGUsIHNvIHRoZXJlIGlzIG5vIG5lZWQgdG8gYWxsb3cgY29tcHJlc3Npb24g
Zm9yDQo+PiBOT0RBVEFDU1VNLg0KPj4NCj4+IFRoZSBmaXggd2lsbCByZWZhY3RvciB0aGUgaW5v
ZGUgY29tcHJlc3Npb24gY2hlY2sgaW50byB0d28gcGFydHM6DQo+PiAtIGlub2RlX2Nhbl9jb21w
cmVzcygpDQo+PiAgIEFzIHRoZSBoYXJkIHJlcXVpcmVtZW50LCBjaGVja2VkIGF0IGJ0cmZzX3J1
bl9kZWxhbGxvY19yYW5nZSgpLCBzbyBubw0KPj4gICBjb21wcmVzc2lvbiB3aWxsIGhhcHBlbiBm
b3IgTk9EQVRBU1VNIGlub2RlIGF0IGFsbC4NCj4+DQo+PiAtIGlub2RlX25lZWRfY29tcHJlc3Mo
KQ0KPj4gICBBcyB0aGUgc29mdCByZXF1aXJlbWVudCwgY2hlY2tlZCBhdCBidHJmc19ydW5fZGVs
YWxsb2NfcmFuZ2UoKSBhbmQNCj4+ICAgY29tcHJlc3NfZmlsZV9yYW5nZSgpLg0KPj4NCj4+IFJl
cG9ydGVkLWJ5OiBKYW1lcyBIYXJ2ZXkgPGphbWVzcGhhcnZleTIwQGdtYWlsLmNvbT4NCj4+IFNp
Z25lZC1vZmYtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0KPj4gLS0tDQo+PiBDaGFuZ2Vs
b2c6DQo+PiB2MjoNCj4+IC0gUmVmYWN0b3IgaW5vZGVfbmVlZF9jb21wcmVzcygpIGludG8gdHdv
IGZ1bmN0aW9ucw0KPj4gLSBSZWZhY3RvciBpbm9kZV9uZWVkX2NvbXByZXNzKCkgdG8gcmV0dXJu
IGJvb2wNCj4+IC0tLQ0KPj4gIGZzL2J0cmZzL2lub2RlLmMgfCAzOCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9pbm9kZS5j
IGIvZnMvYnRyZnMvaW5vZGUuYw0KPj4gaW5kZXggYTJhYWJkYjg1MjI2Li5iZTFjYWJmMzU2ODAg
MTAwNjQ0DQo+PiAtLS0gYS9mcy9idHJmcy9pbm9kZS5jDQo+PiArKysgYi9mcy9idHJmcy9pbm9k
ZS5jDQo+PiBAQCAtMzk0LDI0ICszOTQsNDkgQEAgc3RhdGljIG5vaW5saW5lIGludCBhZGRfYXN5
bmNfZXh0ZW50KHN0cnVjdCBhc3luY19jaHVuayAqY293LA0KPj4gIAlyZXR1cm4gMDsNCj4+ICB9
DQo+PiAgDQo+PiAtc3RhdGljIGlubGluZSBpbnQgaW5vZGVfbmVlZF9jb21wcmVzcyhzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCB1NjQgc3RhcnQsIHU2NCBlbmQpDQo+PiArLyoNCj4+ICsgKiBDaGVjayBp
ZiB0aGUgaW5vZGUgY2FuIGFjY2VwdCBjb21wcmVzc2lvbi4NCj4+ICsgKg0KPj4gKyAqIFRoaXMg
Y2hlY2tzIGZvciB0aGUgaGFyZCByZXF1aXJlbWVudCBvZiBjb21wcmVzc2lvbiwgaW5jbHVkaW5n
IENvVyBhbmQNCj4+ICsgKiBjaGVja3N1bSByZXF1aXJlbWVudC4NCj4+ICsgKi8NCj4+ICtzdGF0
aWMgaW5saW5lIGJvb2wgaW5vZGVfY2FuX2NvbXByZXNzKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+
PiArew0KPj4gKwlpZiAoQlRSRlNfSShpbm9kZSktPmZsYWdzICYgQlRSRlNfSU5PREVfTk9EQVRB
Q09XIHx8DQo+PiArCSAgICBCVFJGU19JKGlub2RlKS0+ZmxhZ3MgJiBCVFJGU19JTk9ERV9OT0RB
VEFTVU0pDQo+PiArCQlyZXR1cm4gZmFsc2U7DQo+PiArCXJldHVybiB0cnVlOw0KPj4gK30NCj4+
ICsNCj4+ICsvKg0KPj4gKyAqIENoZWNrIGlmIHRoZSBpbm9kZSBuZWVkIGNvbXByZXNzaW9uLg0K
Pj4gKyAqDQo+PiArICogVGhpcyBjaGVja3MgZm9yIHRoZSBzb2Z0IHJlcXVpcmVtZW50IG9mIGNv
bXByZXNzaW9uLg0KPj4gKyAqLw0KPj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBpbm9kZV9uZWVkX2Nv
bXByZXNzKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHU2NCBzdGFydCwgdTY0IGVuZCkNCj4+ICB7DQo+
PiAgCXN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gYnRyZnNfc2IoaW5vZGUtPmlfc2Ip
Ow0KPj4gIA0KPj4gKwlpZiAoIWlub2RlX2Nhbl9jb21wcmVzcyhpbm9kZSkpIHsNCj4+ICsJCVdB
Uk4oSVNfRU5BQkxFRChDT05GSUdfQlRSRlNfREVCVUcpLA0KPj4gKwkJCUtFUk5fRVJSICJCVFJG
UzogdW5leHBlY3RlZCBjb21wcmVzc2lvbiBmb3IgaW5vICVsbHVcbiIsDQo+PiArCQkJYnRyZnNf
aW5vKEJUUkZTX0koaW5vZGUpKSk7DQo+PiArCQlyZXR1cm4gZmFsc2U7DQo+PiArCX0NCj4+ICAJ
LyogZm9yY2UgY29tcHJlc3MgKi8NCj4+ICAJaWYgKGJ0cmZzX3Rlc3Rfb3B0KGZzX2luZm8sIEZP
UkNFX0NPTVBSRVNTKSkNCj4+IC0JCXJldHVybiAxOw0KPj4gKwkJcmV0dXJuIHRydWU7DQo+PiAg
CS8qIGRlZnJhZyBpb2N0bCAqLw0KPj4gIAlpZiAoQlRSRlNfSShpbm9kZSktPmRlZnJhZ19jb21w
cmVzcykNCj4+IC0JCXJldHVybiAxOw0KPj4gKwkJcmV0dXJuIHRydWU7DQo+PiAgCS8qIGJhZCBj
b21wcmVzc2lvbiByYXRpb3MgKi8NCj4+ICAJaWYgKEJUUkZTX0koaW5vZGUpLT5mbGFncyAmIEJU
UkZTX0lOT0RFX05PQ09NUFJFU1MpDQo+PiAtCQlyZXR1cm4gMDsNCj4+ICsJCXJldHVybiBmYWxz
ZTsNCj4+ICAJaWYgKGJ0cmZzX3Rlc3Rfb3B0KGZzX2luZm8sIENPTVBSRVNTKSB8fA0KPj4gIAkg
ICAgQlRSRlNfSShpbm9kZSktPmZsYWdzICYgQlRSRlNfSU5PREVfQ09NUFJFU1MgfHwNCj4+ICAJ
ICAgIEJUUkZTX0koaW5vZGUpLT5wcm9wX2NvbXByZXNzKQ0KPj4gIAkJcmV0dXJuIGJ0cmZzX2Nv
bXByZXNzX2hldXJpc3RpYyhpbm9kZSwgc3RhcnQsIGVuZCk7DQo+PiAtCXJldHVybiAwOw0KPj4g
KwlyZXR1cm4gZmFsc2U7DQo+PiAgfQ0KPj4gIA0KPj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBpbm9k
ZV9zaG91bGRfZGVmcmFnKHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUsDQo+PiBAQCAtMTYzMCw3
ICsxNjU1LDggQEAgaW50IGJ0cmZzX3J1bl9kZWxhbGxvY19yYW5nZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBzdHJ1Y3QgcGFnZSAqbG9ja2VkX3BhZ2UsDQo+PiAgCX0gZWxzZSBpZiAoQlRSRlNfSShp
bm9kZSktPmZsYWdzICYgQlRSRlNfSU5PREVfUFJFQUxMT0MgJiYgIWZvcmNlX2Nvdykgew0KPj4g
IAkJcmV0ID0gcnVuX2RlbGFsbG9jX25vY293KGlub2RlLCBsb2NrZWRfcGFnZSwgc3RhcnQsIGVu
ZCwNCj4+ICAJCQkJCSBwYWdlX3N0YXJ0ZWQsIDAsIG5yX3dyaXR0ZW4pOw0KPj4gLQl9IGVsc2Ug
aWYgKCFpbm9kZV9uZWVkX2NvbXByZXNzKGlub2RlLCBzdGFydCwgZW5kKSkgew0KPj4gKwl9IGVs
c2UgaWYgKCFpbm9kZV9jYW5fY29tcHJlc3MoaW5vZGUpIHx8DQo+PiArCQkgICAhaW5vZGVfbmVl
ZF9jb21wcmVzcyhpbm9kZSwgc3RhcnQsIGVuZCkpIHsNCj4gDQo+IFdlbGwsIHRoYXQncyBub3Qg
ZXhjYXRseSB3aGF0IEkgZXhwZWN0ZWQsIGJ1dCBiZWNhdXNlIHRoaXMgaXMgYW4NCj4gaW1wb3J0
YW50IGZpeCBJIHdvbid0IG9iamVjdCBub3cgYW5kIGFkZCBpdCB0byA1LjMgcXVldWUuDQo+IA0K
DQpJIGtub3cgd2hhdCB5b3UgZXhwZWN0LCBzaW5nbGUgaW5vZGVfY2FuX2NvbXByZXNzKCkuDQoN
CkJ1dCBzdGlsbCwgd2Ugd2FudCB0byBhdm9pZCBoaXR0aW5nIHRoZSBjb21wcmVzc2lvbiByb3V0
aW5lLCB0aHVzIGhlcmUNCndlIGRvIGV4dHJhIGlub2RlX25lZWRfY29tcHJlc3MoKSBjaGVjayBv
dGhlciB0aGFuIGV4aXRpbmcgaW4NCmNvbXByZXNzX2ZpbGVfZXh0ZW50KCkuDQoNClRoYW5rcywN
ClF1DQo=
