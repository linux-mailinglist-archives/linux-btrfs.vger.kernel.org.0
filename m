Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14681B0CFB
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 12:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfILKej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 06:34:39 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:40581 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730470AbfILKej (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 06:34:39 -0400
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.147) BY m4a0041g.houston.softwaregrp.com WITH ESMTP;
 Thu, 12 Sep 2019 10:32:44 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 12 Sep 2019 10:19:48 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.124.8.14) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 12 Sep 2019 10:19:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0NKSb21YkKhZliWI3K51hxcFUFMTEdh12+98IkhPoXqImxE42AHaMbLeJbATkWhGETGg337bxtV9wgxNotnTmpcq5yBVhKINBTioLm8sLRUVHjbCMuGJu66HMow+AWHd544Mmr6elvS0j01iQTqdx7fN+8V0ftGUZSWsQxvJ4jK+tlD/TqU0ax0IFoD3pr5pOuXjlMPuGUS4IwIZ5NdxH7rBP7e/9ngpTSR/8iW440Au84Q7lChmptCtPfJ9HPzh960SFtGZG107JI+ZHZsieRFaWOKzIhkmlIDRyJ6eNYe0DCpym/mniMlFvwebFHVhteaxEtBib11UC4vk6jsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHLEfH4YeItxUcEitRxZH3nTleAVpKONgyo3neF9HfQ=;
 b=NFXMxXZuZubOgyj9WD4UqKW9Isv6giJDd+cwqpzuRBgTk4kx4tABLVEREE5TUlMUkpise6IfheWKxvEsnrVGN+ZA87qeMqVHNpg2+AS2tb8SRt7b6QoZZiTFlwb1ESNmtHAzC9JChYSRvBYYpkiOKYb9am6Sk/0ZYccZKaiG3ABZvgCTCE1X5dkLo20uMUcqarzzJMjsQI/9qYs91e9GOvdsLS0ceuLgX6nbZDEwjbFV2W0xNd+2ym0wM5IkO2cQFa0ajvJ9whxQ2FCPax8w2I+q72EO0bDh2fCazfVvJserNU5irYE4B7JcOk+2IGLPHV6N+heHTLNVkvES5Dq2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3412.namprd18.prod.outlook.com (10.255.136.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 12 Sep 2019 10:19:41 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::3993:1f66:bd4:83cc]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::3993:1f66:bd4:83cc%5]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 10:19:41 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC] btrfs: Introduce btrfs child tree block verification
 system
Thread-Topic: [PATCH RFC] btrfs: Introduce btrfs child tree block verification
 system
Thread-Index: AQHVaLppm4fW933sCEGeZr4v90/J+6cnJC+OgACr65WAAAWOgA==
Date:   Thu, 12 Sep 2019 10:19:41 +0000
Message-ID: <e4457e6a-e6c0-c4b4-5758-01828d6f1c1e@suse.com>
References: <20190911074624.27322-1-wqu@suse.com>
 <20190911160202.wtprsigurzfxwtic@MacBook-Pro-91.local>
 <3993aeab-a695-3bd1-88d6-48e9743ab597@gmx.com>
 <20190912095913.gql6vbf4d6jj5p6m@MacBook-Pro-91.local>
In-Reply-To: <20190912095913.gql6vbf4d6jj5p6m@MacBook-Pro-91.local>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0209.jpnprd01.prod.outlook.com
 (2603:1096:404:29::29) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb5aeb9b-35cc-453b-d372-08d7376ab967
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3412;
x-ms-traffictypediagnostic: BY5PR18MB3412:
x-microsoft-antispam-prvs: <BY5PR18MB341296EA7FAE4CED3FD0839DD6B00@BY5PR18MB3412.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(52314003)(53936002)(52116002)(36756003)(110136005)(478600001)(71190400001)(2906002)(66066001)(486006)(476003)(316002)(31686004)(64756008)(66556008)(76176011)(11346002)(66446008)(2616005)(66476007)(66946007)(3846002)(5660300002)(6116002)(4326008)(229853002)(6506007)(14444005)(386003)(81166006)(81156014)(8936002)(7736002)(102836004)(25786009)(6246003)(256004)(446003)(6512007)(86362001)(6436002)(186003)(8676002)(26005)(99286004)(71200400001)(305945005)(15650500001)(14454004)(6486002)(31696002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3412;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yCTrD+PzlMjeirafyQ9wTSW9tZXruFy9zHdUwTv5Kl4YhWGUIeYoi8Lyxh5OMbfxPgDCZfr0b/G01/bSmxU0z+jgmZHXqDpeiEG/tdepRa+oqyYdanFd9oFtu38/K+wXByob/Tj4wo1nrrc6KxszVaLq/EoK2rYQkglvPQCmbA+8UzoKSjJ6lBfzqp+Aynf1p/PzdFGFH4Su9salYGdMD0J3uJlloZpguuDhcUNvPrl5s1aZKCDbDqshennyR0Vzy+E15SYT6H6hgv7PounysgcgER74Ph8ubGUQ+yHj5FbCmKs6h02uOGIjvtnwl9dYzzGdhKvLykQqKqfFcHeWFlZRpYOcwrrL/pPwxminNh6tB2AeHAhiKt/JzLKRdOJK1hrqzLk4z2gUAdRs8cgfhzhF5XyarwisF/vLKUYJ4Fs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <90294C9CA4DC204F83EEB88398276BE0@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5aeb9b-35cc-453b-d372-08d7376ab967
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 10:19:41.5103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0LaL3rh6bLUVX9t4N9sUMjHeo7RvE4zbQRSnZe0Oixvqtcthvaoi5RA9KxUkHMC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3412
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvOS8xMiDkuIvljYg1OjU5LCBKb3NlZiBCYWNpayB3cm90ZToNCj4gT24gVGh1
LCBTZXAgMTIsIDIwMTkgYXQgMDc6Mzg6MTRBTSArMDgwMCwgUXUgV2VucnVvIHdyb3RlOg0KPj4N
Cj4+DQo+PiBPbiAyMDE5LzkvMTIg5LiK5Y2IMTI6MDIsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPj4+
IE9uIFdlZCwgU2VwIDExLCAyMDE5IGF0IDAzOjQ2OjI0UE0gKzA4MDAsIFF1IFdlbnJ1byB3cm90
ZToNCj4+Pj4gQWx0aG91Z2ggd2UgaGF2ZSBidHJmc192ZXJpZnlfbGV2ZWxfa2V5KCkgZnVuY3Rp
b24gdG8gY2hlY2sgdGhlIGZpcnN0DQo+Pj4+IGtleSBhbmQgbGV2ZWwgYXQgdHJlZSBibG9jayBy
ZWFkIHRpbWUsIGl0IGhhcyBpdHMgbGltaXRhdGlvbiBkdWUgdG8gdHJlZQ0KPj4+PiBsb2NrIGNv
bnRleHQsIGl0J3Mgbm90IHJlbGlhYmxlIGhhbmRsaW5nIG5ldyB0cmVlIGJsb2Nrcy4NCj4+Pj4N
Cj4+Pg0KPj4+IEhvdyBpcyBpdCBub3QgcmVsaWFibGUgd2l0aCBuZXcgdHJlZSBibG9ja3M/DQo+
Pg0KPj4gQ3VycmVudCBidHJmc192ZXJpZnlfbGV2ZWxfa2V5KCkgc2tpcHMgZmlyc3Rfa2V5IHZl
cmlmaWNhdGlvbiBmb3IgYW55DQo+PiB0cmVlIGJsb2NrcyBuZXdlciB0aGFuIGxhc3QgY29tbWl0
dGVkLg0KPj4NCj4+Pg0KPj4+PiBTbyBidHJmc192ZXJpZnlfbGV2ZWxfa2V5KCkgaXMgZ29vZCBh
cyBhIHByZS1jaGVjaywgYnV0IGl0IGNhbid0IGVuc3VyZQ0KPj4+PiBuZXcgdHJlZSBibG9ja3Mg
YXJlIHN0aWxsIHNhbmUgYXQgcnVudGltZS4NCj4+Pj4NCj4+Pg0KPj4+IEkgbWVhbiBJIGd1ZXNz
IHRoaXMgaXMgZ29vZCwgYnV0IHdlIGhhdmUgdG8ga2VlcCB0aGUgcGFyZW50IGxvY2tlZCB3aGVu
IHdlJ3JlDQo+Pj4gYWRkaW5nIG5ldyBibG9ja3MgYW55d2F5LCBzbyBJJ20gbm90IGVudGlyZWx5
IHN1cmUgd2hhdCB0aGlzIGdhaW5zIHVzPw0KPj4NCj4+IEZvciBjYXNlcyBsaWtlIHRyZWUgc2Vh
cmNoIG9uIGN1cnJlbnQgbm9kZSwgd2hlcmUgYWxsIHRyZWUgYmxvY2tzIGNhbiBiZQ0KPj4gbmV3
bHkgQ29XZWQgdHJlZSBibG9ja3MuDQo+Pg0KPiANCj4gQnV0IGFnYWluIHdlIGhhdmUgdGhlIHBh
cmVudCBsb2NrZWQgaW4gdGhlc2UgY2FzZXMsIHNvIHdlIGNhbiBzdGlsbCBkbyB0aGUgY2hlY2sN
Cj4gZXZlbiBpZiB0aGUgcGFyZW50IGhhcyBiZWVuIGNvdydlZCwgc28gSSdtIG5vdCBjbGVhciB3
aGF0IHRoZSBwb2ludCBpcz8gIExpa2UNCj4gZm9yIHN1cmUgYWRkIGFuIGV4dHJhIGNoZWNrIGR1
cmluZyBzZWFyY2ggdG8gY2hlY2sgdGhlIGZpcnN0X2tleSBJIGd1ZXNzLCBidXQNCj4gYWxsIHRo
ZSBleHRyYSBjaGVja3Mgc2VlbSBzdXBlcmZsb3VzLg0KDQpCdXQgY2hpbGQgaXNuJ3QgbG9ja2Vk
IGlmIGl0J3MgZnJvbSB0aGUgZWIgY2FjaGUgb3RoZXIgdGhhbiByZWFkIGZyb20gZGlzay4NCldl
IGNhbiBnZXQgYSBzdGFibGUgbm9kZV9wdHJfa2V5IGZyb20gcGFyZW50IHdpdGhvdXQgYW55IHBy
b2JsZW0uDQoNCkJ1dCB0byB2ZXJpZnkgZmlyc3Rfa2V5LCB3ZSBuZWVkIHRvIGxvY2sgdGhlIGNo
aWxkIHRvIHZlcmlmeSBpdHMgZmlyc3QNCmtleSBhZ2FpbnN0IHRoZSBmaXJzdCBrZXkgd2UgZ290
IGZyb20gcGFyZW50Lg0KDQpTbyBpbiBzaG9ydCwgdGhlIHdob2xlIGZhY2lsaXR5IGFuZCBhbGwg
dGhvc2UgY2FsbHMgYXJlIGp1c3QgdG8gdmVyaWZ5DQpmaXJzdF9rZXkgYW5kIG5yaXRlbXMgKnJl
bGlhYmx5Ki4NCg0KPiANCj4+IElmIGJpdCBmbGlwIGhhcHBlbnMgYWZmZWN0aW5nIHRob3NlIG5l
dyB0cmVlIGJsb2Nrcywgd2UgY2FuIGRldGVjdCB0aGVtDQo+PiBhdCBydW50aW1lLCBhbmQgdGhh
dCdzIHRoZSBvbmx5IHRpbWUgd2UgY2FuIGNhdGNoIHN1Y2ggZXJyb3IuDQo+Pg0KPiANCj4gU3Vy
ZSBidXQgd2UgY2FuJ3QgcmVhbGx5IGRldGVjdCBiaXRmbGlwcyBpbiBsb3RzIG9mIHBsYWNlcy4g
IEknbSBub3Qgc3VyZSB0aGF0DQo+IGp1c3RpZmllcyB0aGlzIGV4dHJhIGluZnJhc3RydWN0dXJl
Lg0KDQpUaGUgZmFjaWxpdHkgaXMgb25seSB0byBjaGVjayBmaXJzdF9rZXkgYW5kIG5yaXRlbXMg
Zm9yICphbGwqIGVicywgbm90DQpvbmx5IGVicyByZWFkIGZyb20gZGlzay4NCg0KWW91IGNhbiBk
ZWZpbml0ZWx5IHJlbW92ZSB0aGUgbGV2ZWwvdHJhbnNpZCBjaGVjaywgYXMgbG9uZyBhcyB3ZSBj
aG9vc2UNCnRvIGtlZXAgdGhlIGJ0cmZzX3ZlcmlmeV9sZXZlbF9rZXkoKS4NCkJ1dCBJJ20gYWZy
YWlkIEkgdGVuZCB0byByZW1vdmUgYnRyZnNfdmVyaWZ5X2xldmVsX2tleSgpIGFuZCBtZXJnZSBh
bGwNCml0cyBjaGVjayBpbiB0aGlzIG5ldyBmYWNpbGl0eSwgYXMgd2UgY2FuIGNoZWNrIGl0IG1v
cmUgYWNjdXJhdGVseS4NCg0KPiANCj4+IFdyaXRlIHRpbWUgdHJlZSBjaGVja2VyIGRvZXNuJ3Qg
Z28gYmV5b25kIHNpbmdsZSBsZWF2ZS9ub2RlLCB0aHVzIGhhcyBubw0KPj4gd2F5IHRvIGRldGVj
dCBzdWNoIHBhcmVudC1jaGlsZCBtaXNtYXRjaCBjYXNlLg0KPj4NCj4gDQo+IFllYWggdGhhdCBJ
J2xsIGdpdmUgeW91LiAgQnV0IGFnYWluIGFzIGxvbmcgYXMgd2UgY2hlY2sgd2hpbGUgd2UncmUg
c2VhcmNoaW5nDQo+IHdlJ2xsIGJlIGZpbmUuICBUaGUgb25seSBjYXNlIHdlJ2xsIG1pc3MgaXMg
aWYgdGhlcmUncyBhIGJpdGZsaXAgaW4gYmV0d2VlbiB0aGUNCj4gdGltZSB3ZSBtb2RpZmllZCB0
aGUgdGhpbmcgYW5kIHdlIHdyaXRlIGl0IG91dC4gIFlvdXIgY29kZSBkb2Vzbid0IGNhdGNoIHRo
aXMNCj4gY2FzZSBlaXRoZXIsIGNhdXNlIGZyYW5rbHkgaXQncyBraW5kIG9mIGltcG9zc2libGUg
d2l0aG91dCBhY3R1YWxseSB3YWxraW5nIGFuZA0KPiB2ZXJpZnlpbmcgYXQgd3JpdGVvdXQgdGlt
ZS4NCj4gDQo+Pj4gIFlvdSBhcmUNCj4+PiBlc3NlbnRpYWxseSBkdXBsaWNhdGluZyB0aGUgY2hl
Y2tzIHRoYXQgd2UgYWxyZWFkeSBkbyBvbiByZWFkcywgYW5kIHRoZW4gYWRkaW5nDQo+Pj4gdGhl
IGZpcnN0X2tleSBjaGVjay4NCj4+Pg0KPj4+IEknbGwgZ28gYWxvbmcgd2l0aCB0aGUgZmlyc3Rf
a2V5IGNoZWNrIGJlaW5nIHJlbGF0aXZlbHkgdXNlZnVsLCBidXQgd2h5IGV4YWN0bHkNCj4+PiBk
byB3ZSBuZWVkIGFsbCB0aGlzIGluZnJhc3RydWN0dXJlIHdoZW4gd2UgY2FuIGp1c3QgY2hlY2sg
aXQgYXMgd2Ugd2FsayBkb3duIHRoZQ0KPj4+IHRyZWU/DQo+Pg0KPj4gWW91IGNhbid0IHJlYWxs
eSBkbyB0aGUgbnJpdGVtcyBhbmQgZmlyc3Qga2V5IGNoZWNrIGF0IHRoZSBjdXJyZW50DQo+PiB0
aW1pbmcgb2YgYnRyZnNfdmVyaWZ5X2xldmVsX2tleSgpIGZvciBuZXcgdHJlZSBibG9ja3MgZHVl
IHRvIGxvY2sgY29udGV4dC4NCj4+DQo+PiBUaGF0J3MgdGhlIG9ubHkgcmVhc29uIHRoZSBuZXcg
aW5mcmFzdHJ1Y3R1cmUgaXMgaGVyZSwgdG8gYmxvY2sgdGhlIG9ubHkNCj4+IGhvbGUgb2YgYnRy
ZnNfdmVyaWZ5X2xldmVsX2tleSgpLg0KPj4NCj4+Pg0KPj4+IDxzbmlwPg0KPj4+DQo+Pj4+IEBA
IC0yODg3LDI0ICsyOTgyLDI4IEBAIGludCBidHJmc19zZWFyY2hfc2xvdChzdHJ1Y3QgYnRyZnNf
dHJhbnNfaGFuZGxlICp0cmFucywgc3RydWN0IGJ0cmZzX3Jvb3QgKnJvb3QsDQo+Pj4+ICAJCQl9
DQo+Pj4+ICANCj4+Pj4gIAkJCWlmICghcC0+c2tpcF9sb2NraW5nKSB7DQo+Pj4+IC0JCQkJbGV2
ZWwgPSBidHJmc19oZWFkZXJfbGV2ZWwoYik7DQo+Pj4+IC0JCQkJaWYgKGxldmVsIDw9IHdyaXRl
X2xvY2tfbGV2ZWwpIHsNCj4+Pj4gKwkJCQlpZiAobGV2ZWwgLSAxIDw9IHdyaXRlX2xvY2tfbGV2
ZWwpIHsNCj4+Pj4gIAkJCQkJZXJyID0gYnRyZnNfdHJ5X3RyZWVfd3JpdGVfbG9jayhiKTsNCj4+
Pj4gIAkJCQkJaWYgKCFlcnIpIHsNCj4+Pj4gIAkJCQkJCWJ0cmZzX3NldF9wYXRoX2Jsb2NraW5n
KHApOw0KPj4+PiAgCQkJCQkJYnRyZnNfdHJlZV9sb2NrKGIpOw0KPj4+PiAgCQkJCQl9DQo+Pj4+
IC0JCQkJCXAtPmxvY2tzW2xldmVsXSA9IEJUUkZTX1dSSVRFX0xPQ0s7DQo+Pj4+ICsJCQkJCXAt
PmxvY2tzW2xldmVsIC0gMV0gPSBCVFJGU19XUklURV9MT0NLOw0KPj4+PiAgCQkJCX0gZWxzZSB7
DQo+Pj4+ICAJCQkJCWVyciA9IGJ0cmZzX3RyZWVfcmVhZF9sb2NrX2F0b21pYyhiKTsNCj4+Pj4g
IAkJCQkJaWYgKCFlcnIpIHsNCj4+Pj4gIAkJCQkJCWJ0cmZzX3NldF9wYXRoX2Jsb2NraW5nKHAp
Ow0KPj4+PiAgCQkJCQkJYnRyZnNfdHJlZV9yZWFkX2xvY2soYik7DQo+Pj4+ICAJCQkJCX0NCj4+
Pj4gLQkJCQkJcC0+bG9ja3NbbGV2ZWxdID0gQlRSRlNfUkVBRF9MT0NLOw0KPj4+PiArCQkJCQlw
LT5sb2Nrc1tsZXZlbCAtIDFdID0gQlRSRlNfUkVBRF9MT0NLOw0KPj4+PiAgCQkJCX0NCj4+Pj4g
LQkJCQlwLT5ub2Rlc1tsZXZlbF0gPSBiOw0KPj4+PiArCQkJCXAtPm5vZGVzW2xldmVsIC0gMV0g
PSBiOw0KPj4+PiAgCQkJfQ0KPj4+DQo+Pj4gVGhpcyBtYWtlcyBubyBzZW5zZSB0byBtZS4gIFdo
eSBkbyB3ZSBuZWVkIHRvIGNoYW5nZSBob3cgd2UgZG8gbGV2ZWwgaGVyZSBqdXN0DQo+Pj4gZm9y
IHRoZSBidHJmc192ZXJpZnlfY2hpbGQoKSBjaGVjaz8NCj4+DQo+PiBCZWNhdXNlIHdlIGNhbid0
IHRydXN0IHRoZSBsZXZlbCBmcm9tIEBiIHVubGVzcyB3ZSBoYXZlIHZlcmlmaWVkIGl0Lg0KPj4N
Cj4+IChBbHRob3VnaCBsZXZlbCBpcyBhbHdheXMgY2hlY2tlZCBpbiBidHJmc192ZXJpZnlfbGV2
ZWxfa2V5KCksIGJ1dCB0aGF0DQo+PiBmdW5jdGlvbiBpcyBub3QgMTAwJSBzdXJlIHRvIGJlIGtl
cHQgYXMgaXMpLg0KPiANCj4gQnV0IHdlIGhhdmUgdGhlIGxldmVsIGF0IHRoZSB0aW1lIHdlIHJl
YWQgdGhlIGJsb2NrLCB3aGljaCB3ZSB2ZXJpZnksIHNvIGl0J2xsDQo+IGFscmVhZHkgYmUgY29y
cmVjdCBoZXJlIHJpZ2h0PyAgU28gd2UncmUganVzdCBhZGRpbmcgdGhlIGZpcnN0X2tleSBjaGVj
ayBoZXJlLg0KPiBUaGFua3MsDQoNClJpZ2h0IGFzIGxvbmcgYXMgd2UncmUgbm90IHJlbW92aW5n
IGJ0cmZzX3ZlcmlmeV9sZXZlbF9rZXkoKS4NCg0KVGhhbmtzLA0KUXUNCg0KPiANCj4gSm9zZWYN
Cj4gDQo=
