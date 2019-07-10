Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3764589
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 13:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfGJLDZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 07:03:25 -0400
Received: from m9a0003g.houston.softwaregrp.com ([15.124.64.68]:59683 "EHLO
        m9a0003g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbfGJLDZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 07:03:25 -0400
Received: FROM m9a0003g.houston.softwaregrp.com (15.121.0.190) BY m9a0003g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Wed, 10 Jul 2019 11:03:24 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 10 Jul 2019 11:00:28 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 10 Jul 2019 11:00:28 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3379.namprd18.prod.outlook.com (10.255.136.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.21; Wed, 10 Jul 2019 11:00:27 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 11:00:27 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/5] btrfs: extent-tree: Kill BUG_ON() in
 __btrfs_free_extent() and do better comment
Thread-Topic: [PATCH 2/5] btrfs: extent-tree: Kill BUG_ON() in
 __btrfs_free_extent() and do better comment
Thread-Index: AQHVNw0Ptp1yUp6TTE+BtEINwqmHsabDrzAA
Date:   Wed, 10 Jul 2019 11:00:27 +0000
Message-ID: <2e81bdc8-f441-a10e-d776-c23e5940c091@suse.com>
References: <20190710080243.15988-1-wqu@suse.com>
 <20190710080243.15988-3-wqu@suse.com>
 <ed5a0fda-0369-e7ba-14f8-4f3b4d04add8@suse.com>
In-Reply-To: <ed5a0fda-0369-e7ba-14f8-4f3b4d04add8@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::23) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [240e:3a1:c40:c630::cac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d8cdf7e-9515-4ee9-c75d-08d70525d092
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3379;
x-ms-traffictypediagnostic: BY5PR18MB3379:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BY5PR18MB33795329789024E52E03CED7D6F00@BY5PR18MB3379.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(386003)(6506007)(31686004)(99286004)(31696002)(2501003)(11346002)(110136005)(476003)(316002)(256004)(14444005)(86362001)(25786009)(486006)(2616005)(76176011)(53936002)(478600001)(6246003)(966005)(186003)(6512007)(6306002)(5660300002)(66946007)(2906002)(66476007)(229853002)(52116002)(46003)(66556008)(64756008)(66446008)(6116002)(36756003)(6486002)(8936002)(8676002)(81166006)(81156014)(14454004)(446003)(7736002)(305945005)(71190400001)(71200400001)(102836004)(68736007)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3379;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EKfkKaYqD1wudR9hAEkiYaPJHxepXSQEZVbJzu0fjBXnwuXeXTfpf+eACnhoq9xOASA7vbw90TzxTvphcnG2Sy3xSfO3Mb2b0Emih/+I1a3NyFZGeE5yVRvKSLeW+ryIBH1Cqjp//QYMEVE7x7TFEzdZPZ4TpLC3D5cflfPIYlYTzym9qqv4vpHCKtoUH4HpMUJpkTpAc6R/CxKpKQaWmZWskgydewuI1q3U2suS3jJBN+FuYeWt9Is4QO+Y2tzl9yRmYJvyNRS/QHGeZpDYPKAVKQWf2r4U/9fPaBhnP+ITYC7Zfn4BNSDthqUNB3toyCpiMlmT0Wr1jR88ciHkWAAGOtafaIb0TKmWcyImBeOfMi9K5usHEXLIi+0suCXE7Ka043/56jdqMbmB6QGrEnbRSVdC6YWVTz3Yx2eoACM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02574D37DF245943B8AC4355283A44D0@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8cdf7e-9515-4ee9-c75d-08d70525d092
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 11:00:27.0771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqu@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3379
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvNy8xMCDkuIvljYg2OjQ4LCBOaWtvbGF5IEJvcmlzb3Ygd3JvdGU6DQo+IA0K
PiANCj4gT24gMTAuMDcuMTkg0LMuIDExOjAyINGHLiwgUXUgV2VucnVvIHdyb3RlOg0KPj4gX19i
dHJmc19mcmVlX2V4dGVudCgpIGlzIG9uZSBvZiB0aGUgYmVzdCBjYXNlcyB0byBzaG93IGhvdyBv
cHRpbWl6YXRpb24NCj4+IGNvdWxkIG1ha2UgYSBmdW5jdGlvbiBoYXJkIHRvIHJlYWQuDQo+Pg0K
Pj4gSW4gZmFjdCBfX2J0cmZzX2ZyZWVfZXh0ZW50KCkgaXMgb25seSBkb2luZyB0d28gbWFqb3Ig
d29ya3M6DQo+PiAxLiBSZWR1Y2UgdGhlIHJlZnMgbnVtYmVyIG9mIGFuIGV4dGVudCBiYWNrcmVm
DQo+PiAgICBFaXRoZXIgaXQncyBhbiBpbmxpbmVkIGV4dGVudCBiYWNrcmVmIChpbnNpZGUgRVhU
RU5UL01FVEFEQVRBIGl0ZW0pIG9yDQo+PiAgICBhIGtleWVkIGV4dGVudCBiYWNrcmVmIChTSEFS
RURfKiBpdGVtKS4NCj4+ICAgIFdlIG9ubHkgbmVlZCB0byBsb2NhdGUgdGhhdCBiYWNrcmVmIGxp
bmUsIGVpdGhlciByZWR1Y2UgdGhlIG51bWJlciBvcg0KPj4gICAgcmVtb3ZlIHRoZSBiYWNrcmVm
IGxpbmUgY29tcGxldGVseS4NCj4+DQo+PiAyLiBVcGRhdGUgdGhlIHJlZnMgY291bnQgaW4gRVhU
RU5UL01FVEFEQVRBX0lURU0NCj4+DQo+PiBCdXQgaW4gcmVhbCB3b3JsZCwgd2UgZG8gaXQgaW4g
YSBjb21wbGV4IGJ1dCBzb21ld2hhdCBlZmZpY2llbnQgd2F5Lg0KPj4gRHVyaW5nIHN0ZXAgMSks
IHdlIHdpbGwgdHJ5IHRvIGxvY2F0ZSB0aGUgRVhURU5UL01FVEFEQVRBX0lURU0gd2l0aG91dA0K
Pj4gdHJpZ2dlcmluZyBhbm90aGVyIGJ0cmZzX3NlYXJjaF9zbG90KCkgYXMgZmFzdCBwYXRoLg0K
Pj4NCj4+IE9ubHkgd2hlbiB3ZSBmYWlsZWQgdG8gbG9jYXRlIHRoYXQgaXRlbSwgd2Ugd2lsbCB0
cmlnZ2VyIGFub3RoZXINCj4+IGJ0cmZzX3NlYXJjaF9zbG90KCkgdG8gZ2V0IHRoYXQgRVhURU5U
L01FVEFEQVRBX0lURU0gYWZ0ZXIgd2UNCj4+IHVwZGF0ZWQvZGVsZXRlZCB0aGUgYmFja3JlZiBs
aW5lLg0KPj4NCj4+IEFuZCB3ZSBoYXZlIGEgbG90IG9mIHJlc3RyaWN0IGNoZWNrIG9uIHRoaW5n
cyBsaWtlIHJlZnNfdG9fZHJvcCBhZ2FpbnN0DQo+PiBleHRlbnQgcmVmcyBhbmQgc3BlY2lhbCBj
YXNlIGNoZWNrIGZvciBzaW5nbGUgcmVmIGV4dGVudC4NCj4+DQo+PiBBbGwgb2YgdGhlc2UgcmVz
dWx0czoNCj4+IC0gNyBCVUdfT04oKXMgaW4gYSBzaW5nbGUgZnVuY3Rpb24NCj4+ICAgQWx0aG91
Z2ggYWxsIHRoZXNlIEJVR19PTigpIGFyZSBkb2luZyBjb3JyZWN0IGNoZWNrLCB0aGV5J3JlIHN1
cGVyDQo+PiAgIGVhc3kgdG8gZ2V0IHRyaWdnZXJlZCBmb3IgZnV6emVkIGltYWdlcy4NCj4+ICAg
SXQncyBuZXZlciBhIGdvb2QgaWRlYSB0byBwaXNzIHRoZSBlbmQgdXNlci4NCj4+DQo+PiAtIE5l
YXIgMzAwIGxpbmVzIHdpdGhvdXQgbXVjaCB1c2VmdWwgY29tbWVudHMgYnV0IGEgbG90IG9mIGhp
ZGRlbg0KPj4gICBjb25kaXRpb25zDQo+PiAgIEkgYmVsaWV2ZSBldmVuIHRoZSBhdXRob3IgbmVl
ZHMgc2V2ZXJhbCBtaW51dGVzIHRvIHJlY2FsbCB3aGF0IHRoZQ0KPj4gICBjb2RlIGlzIGRvaW5n
DQo+PiAgIE5vdCB0byBtZW50aW9uIGEgbG90IG9mIEJVR19PTigpIGNvbmRpdGlvbnMgbmVlZHMg
dG8gZ28gYmFjayB0ZW5zIG9mDQo+PiAgIGxpbmVzIHRvIGZpbmQgb3V0IHdoeS4NCj4+DQo+PiBU
aGlzIHBhdGNoIGFkZHJlc3MgYWxsIHRoZXNlIHByb2JsZW1zIGJ5Og0KPj4gLSBJbnRyb2R1Y2Ug
dHdvIGV4YW1wbGVzIHRvIHNob3cgd2hhdCBfX2J0cmZzX2ZyZWVfZXh0ZW50KCkgaXMgZG9pbmcN
Cj4+ICAgT25lIGlubGluZWQgYmFja3JlZiBjYXNlIGFuZCBvbmUga2V5ZWQgY2FzZS4NCj4+ICAg
U2hvdWxkIGNvdmVyIG1vc3QgY2FzZXMuDQo+Pg0KPj4gLSBLaWxsIGFsbCBCVUdfT04oKXMgd2l0
aCBwcm9wZXIgZXJyb3IgbWVzc2FnZSBhbmQgb3B0aW9uYWwgbGVhZiBkdW1wDQo+Pg0KPj4gLSBB
ZGQgY29tbWVudCB0byBzaG93IHRoZSBvdmVyYWxsIHdvcmtmbG93DQo+Pg0KPj4gTGluazogaHR0
cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDI4MTkNCj4+IFsgVGhl
IHJlcG9ydCB0cmlnZ2VycyBvbmUgQlVHX09OKCkgaW4gX19idHJmc19mcmVlX2V4dGVudCgpIF0N
Cj4+IFNpZ25lZC1vZmYtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0KPj4gLS0tDQo+IA0K
PiA8c25pcD4NCj4gDQo+PiBAQCAtNjk5NywxOSArNzA2OCwyNCBAQCBzdGF0aWMgaW50IF9fYnRy
ZnNfZnJlZV9leHRlbnQoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQo+PiAgCWlm
IChvd25lcl9vYmplY3RpZCA8IEJUUkZTX0ZJUlNUX0ZSRUVfT0JKRUNUSUQgJiYNCj4+ICAJICAg
IGtleS50eXBlID09IEJUUkZTX0VYVEVOVF9JVEVNX0tFWSkgew0KPj4gIAkJc3RydWN0IGJ0cmZz
X3RyZWVfYmxvY2tfaW5mbyAqYmk7DQo+PiAtCQlCVUdfT04oaXRlbV9zaXplIDwgc2l6ZW9mKCpl
aSkgKyBzaXplb2YoKmJpKSk7DQo+PiArCQlpZiAodW5saWtlbHkoaXRlbV9zaXplIDwgc2l6ZW9m
KCplaSkgKyBzaXplb2YoKmJpKSkpIHsNCj4+ICsJCQlidHJmc19jcml0KGluZm8sDQo+PiArImlu
dmFsaWQgZXh0ZW50IGl0ZW0gc2l6ZSBmb3Iga2V5ICglbGx1LCAldSwgJWxsdSkgb3duZXIgJWxs
dSwgaGFzICV1IGV4cGVjdCA+JWx1IiwNCj4gbml0OiBzdHJheSAnPicNCg0KV2l0aCB2YWx1ZXMg
ZmlsbGVkLCBpdCB3b3VsZCBiZToNCiJpbnZhbGlkIGV4dGVudCBpdGVtIHNpemUgZm9yIGtleSAo
MTA0ODU3NSwgMTY4LCA0MDk2KSBvd25lciA3LCBoYXMgMTANCmV4cGVjdCA+MzMiDQoNCk5vdyB5
b3UnZCBzZWUgaXQncyBub3QgYSBzdHJheSAnPicuDQoNClRoYW5rcywNClF1DQo+IA0KPiA8c25p
cD4NCj4gDQo=
