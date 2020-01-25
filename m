Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B464F14956E
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 13:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgAYMKY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jan 2020 07:10:24 -0500
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:53671 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbgAYMKX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jan 2020 07:10:23 -0500
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.191) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Sat, 25 Jan 2020 12:09:41 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 25 Jan 2020 12:09:48 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Sat, 25 Jan 2020 12:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUqBImOmzDbK6tIwRgGD2RMZcU88Ol/whXAxUeMVGAIWwQtoWecGV0XgXgDTCOJGDHXTP+M1mCXjpI67jSUIZr5l5VWAM8C2TgyxKvSkVTNDJqc7VnTRI0a3K1/ILs6a8i6I9lCseOCv6O6Vm0VjB8bBP/OVQVM0tMesIr4wewULtsjG/cRHQZ93S/9NL5La0vJHzMfqdN8kbfRd6ILeptqOmmhiU2BzrIoo4roXt9Ymf8hsROlzYZ0aS86d4vEukgDDKr+z04S61aLvfndNE8fevpWKErP6xTmEHTWNi14MFeM5se6C9KhRQ3Ubx5reMFu+SSb9+Kctu4o14ZIPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvqWJwhyQJSTBCjWRCuetbbd1k4wIWLhQ18x6nIJ3po=;
 b=Kw9hTgK/2fF6/HaUz60hqUuidwsmh3ScEla//h+K6XWebYfWORwIRM4Qhus3clBTklKIiWEvwnU1MR2t2Kkx9vQqGHNIv5z7qa1WTPew1FUfOT0hPCUk8JYEu6TFEArrQBrHhqj8P2xv9Dsh/F+Unn+ckA2J7cNKLdiXsM0IHuBy3XE5g+nfcKSCYUlPYKxGNxcLq1Z/VZUhXP6h8RwzeFZSgxHnNHYqRo17PYmg/Fet36iVq42d7VUGwDsVsd2pEZJRWvpJB3A/ON9btx/meBNs5lt5cCDTqkwcHCY60CItwPkYG0u5TbmWFaYifVbc/BR1gerOi2IZfslKu7A3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3171.namprd18.prod.outlook.com (10.255.137.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Sat, 25 Jan 2020 12:09:46 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2644.028; Sat, 25 Jan 2020
 12:09:46 +0000
Received: from [0.0.0.0] (149.28.201.231) by BY5PR20CA0009.namprd20.prod.outlook.com (2603:10b6:a03:1f4::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Sat, 25 Jan 2020 12:09:44 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "fdmanana@gmail.com" <fdmanana@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <FdManana@suse.com>
Subject: Re: [PATCH] btrfs: scrub: Require mandatory block group RO for
 dev-replace
Thread-Topic: [PATCH] btrfs: scrub: Require mandatory block group RO for
 dev-replace
Thread-Index: AQHV0sS8FfRHNKiCaUGndrg+Ez7b2qf6AQKAgACIWgCAALgzgIAACYyA
Date:   Sat, 25 Jan 2020 12:09:45 +0000
Message-ID: <a1afbb5e-100e-8dbb-a211-dc15dbf091bd@suse.com>
References: <20200123235820.20764-1-wqu@suse.com>
 <20200124144409.GM3929@twin.jikos.cz>
 <CAL3q7H5+pTzLM7=5gxORWi6CcPB1YGR8=8bVUWeogq8a2rno-Q@mail.gmail.com>
 <a76b187d-678e-1b02-b388-2ab12b9c221c@gmx.com>
 <20200125113531.GR3929@twin.jikos.cz>
In-Reply-To: <20200125113531.GR3929@twin.jikos.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::22) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.28.201.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a4cfa19-b8d0-4688-faf0-08d7a18f7774
x-ms-traffictypediagnostic: BY5PR18MB3171:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB31716E6F5E7BBFBC154B4D7FD6090@BY5PR18MB3171.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0293D40691
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(6636002)(2616005)(81166006)(956004)(8676002)(81156014)(36756003)(8936002)(6706004)(71200400001)(478600001)(110136005)(6486002)(316002)(16576012)(31686004)(16526019)(2906002)(26005)(186003)(52116002)(86362001)(5660300002)(66446008)(66946007)(64756008)(66476007)(66556008)(31696002)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3171;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73i3exbUpwOAYAWUTAk9hOhFOm/gcF3B4CbcpIBsT68O/AfcJoMMuUf73dJd9wPOf4j72OdhhF/0k4R27DhZofl3KtNOX36t7oL6jVBQA+JtQAAGUcTkJqpJtHj+M7l7VcWZHHA+gU0wZqsG14mPXM6NvGwwsYFCMBEUkD5vKi8sKH+ncO0zKRdmobpZDmr5Pzqvwl4i4Am+FUfPq48NrbH9FnqWbfSFNSoiKRc0n7VJHo2B6G97vdAIu1Ad9p2G96zcnpxzyICBR7bIXU4aicz/Iq49yImccAGhYSvRtTh39F5F7xwptj+xXIgJ8cCZsgmeGoTnf1BlIrt3ze0QudDEyP8Qnh65PZFP3oPgQAkUU2wpkQGXV9CMJ3fimqucHmERAUDiNjuZ8WyR1OmkErl3D9C8Fxm2YC27Le0xKFEulPpP5zNeRc0QJgd9x0h6LPAk1ejn85oEMDCjnO9rRyBBe4Ht0vMoCxZ1lOSBRuw8PIUo0T2jMeYllv2zGl6W
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AB9D22C5305744182B95DC0218730AD@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4cfa19-b8d0-4688-faf0-08d7a18f7774
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2020 12:09:45.7112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcHOaLQUfc+7qXN/nyuIotNIvLM/1fauV5InHxY3X4JK8kXs1D58oNJJpzVlhjq/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3171
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMjAvMS8yNSDkuIvljYg3OjM1LCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+IE9uIFNh
dCwgSmFuIDI1LCAyMDIwIGF0IDA4OjM2OjE0QU0gKzA4MDAsIFF1IFdlbnJ1byB3cm90ZToNCj4+
Pj4gVGhlIHB1cnBvc2Ugc2VlbXMgdG8gYmUgdG8gY2F0Y2ggZ2VuZXJpYyBlcnJvciBjb2RlcyBv
dGhlciB0aGFuDQo+Pj4+IEVJTlBST0dSRVNTIGFuZCBFQ05BQ0VMRUQsIEkgZG9uJ3Qgc2VlIG11
Y2ggcG9pbnQgcHJpbnRpbmcgYSB3YXJuaW5nIGluDQo+Pj4+IHRoYXQgY2FzZS4gQnV0IGl0JyBh
IG5ldyBFTk9TUEMgcHJvYmxlbSwgbGlrZWx5IGNhdXNlZCBieSB0aGUNCj4+Pj4gcmVhZC1vbmx5
IHN0YXR1cyBzd2l0Y2hpbmcuDQo+Pj4+DQo+Pj4+IE15IHRlc3QgZGV2aWNlcyBhcmUgMTJHLCB0
aGVyZSdzIGZ1bGwgbG9nIG9mIHRoZSB0ZXN0IHRvIHNlZSBhdCB3aGljaA0KPj4+PiBwaGFzZSBp
dCBoYXBwZW5lZC4NCj4+Pg0KPj4+IEl0IHBhc3NlcyBmb3IgbWUgb24gMjBHIGRldmljZXMsIGhh
dmVuJ3QgdGVzdGVkIHdpdGggMTJHIGhvd2V2ZXINCj4+PiAoY2FuJ3QgYWZmb3JkIHRvIHJlYm9v
dCBhbnkgb2YgbXkgdm1zIG5vdykuDQo+Pg0KPj4gNUcgZm9yIGFsbCBzY3JhdGNoIGRldmljZXMs
IGFuZCBmYWlsZWQgdG8gcmVwcm9kdWNlIGl0Lg0KPj4gKFRoZSBmdWxsIHJ1biBiZWZvcmUgc3Vi
bWl0dGluZyB0aGUgcGF0Y2ggYWxzbyBmYWlsZWQgdG8gcmVwcm9kdWNlIGl0KQ0KPiANCj4gNUcg
aXMgbm90IGFjdHVhbGx5IGVub3VnaCB0byBydW4gc29tZSBvZiB0aGUgdGVzdHMgdGhhdCByZXF1
aXJlIGF0IGxlYXN0DQo+IDEwRyBvZiBmcmVlIHNwYWNlIChzbyB0aGUgYmxvY2sgZGV2aWNlIG5l
ZWRzIHRvIGJlIGEgYml0IGxhcmdlcikuDQoNCkJUVywgdGhhdCBFTk9TUEMgc291bmRzIGxpa2Ug
YSBtZXRhZGF0YSBvdmVyLWNvbW1pdCBidWcsIHRoZXJlIGlmIHdlIGNhbg0KYWxsb2NhdGUgMiBv
ciBtb3JlIG1ldGEgY2h1bmtzLCBhbmQgbWV0YSByc3YgYWxyZWFkeSBuZWVkcyAyIG5ldyBjaHVu
a3MsDQp0aGVuIGJ0cmZzX2luY19ibG9ja19ncm91cF9ybygpIHdpbGwgYWx3YXlzIGZhaWwgbm8g
bWF0dGVyIHdoYXRldmVyIHRoZQ0KcGFyYW1ldGVyIHdlJ3JlIHVzaW5nIGZvciBhbnkgbWV0YWRh
dGEgY2h1bmsuDQooU2luY2UgYnRyZnNfYmxvY2tfZ3JvdXBfcm8oKSBjYW4gb25seSBwcmUtYWxs
b2Mgb25lIGNodW5rLCB3aGlsZSBvdXINCmN1cnJlbnQgbWV0YSBvdmVyLWNvbW1pdCBhbGxvd3Mg
d2F5IG1vcmUgbWV0YSByc3YgdGhhbiBqdXN0IG9uZSBjaHVuaykNCg0KVGhhdCBvbmUgY2FuIGJl
IHNvbHZlZCBieSBteSBwcmV2aW91cyBwZXItcHJvZmlsZSBhdmFpbCBzcGFjZSBwYXRjaHNldC4N
Cg0KPiANCj4+PiBJIHRoaW5rIHRoYXQgaGFwcGVucyBiZWNhdXNlIGJlZm9yZSB0aGlzIHBhdGNo
IHdlIGlnbm9yZWQgRU5PU1BDDQo+Pj4gZXJyb3JzLCB3aGVuIHRyeWluZyB0byBzZXQgYSBibG9j
ayBncm91cCB0byBSTywgZm9yIGRldmljZSByZXBsYWNlIGFuZA0KPj4+IHNjcnViLg0KPj4+IEJ1
dCB3aXRoIHRoaXMgcGF0Y2ggd2UgZG9uJ3QgaWdub3JlIEVOT1NQQyBmb3IgZGV2aWNlIHJlcGxh
Y2UgYW55bW9yZQ0KPj4+IC0gdGhpcyBpcyBhY3R1YWxseSBjb3JyZWN0IGJlY2F1c2UgaWYgd2Ug
aWdub3JlIHdlIGNhbiBjb3JydXB0IG5vY293DQo+Pj4gd3JpdGVzIChpbmNsdWRpbmcgd3JpdGVz
IGludG8gcHJlYWxsb2MgZXh0ZW50cykuDQo+Pj4NCj4+PiBOb3cgaWYgaXQncyBhIHJlYWwgRU5P
U1BDIHNpdHVhdGlvbiBvciBqdXN0IGEgYnVnIGluIHRoZSBzcGFjZQ0KPj4+IG1hbmFnZW1lbnQg
Y29kZSwgaXQncyBhIGRpZmZlcmVudCB0aGluZyB0byBsb29rIGF0Lg0KPj4NCj4+IEkgdGVuZCB0
byB0YWtlIGEgbWlkZGxlIGxhbmQgb2YgdGhlIHByb2JsZW0uDQo+Pg0KPj4gRm9yIGN1cnJlbnQg
c3RhZ2UsIHRoZSBXQVJOX09OKCkgaXMgaW5kZWVkIG92ZXJraWxsZWQsIGF0IGxlYXN0IGZvciBF
Tk9TUEMuDQo+Pg0KPj4gQnV0IG9uIHRoZSBvdGhlciBoYW5kbGUsIHRoZSBmdWxsIFJPIG9mIGEg
YmxvY2sgZ3JvdXAgZm9yIHNjcnViL3JlcGxhY2UNCj4+IGlzIGFsc28gYSBsaXR0bGUgb3Zlcmtp
bGxlZC4NCj4+IEp1c3QgYXMgRmlsaXBlIG1lbnRpb25lZCwgd2Ugb25seSB3YW50IHRvIGtpbGwg
bm9jb3cgd3JpdGVzIGludG8gYSBibG9jaw0KPj4gZ3JvdXAsIGJ1dCBzdGlsbCBhbGxvdyBDT1cg
d3JpdGVzLg0KPj4NCj4+IEl0IGxvb2tzIGxpa2Ugc29tZXRoaW5nIGxpa2UgbWFya19ibG9ja19n
cm91cF9ub2Nvd19ybygpIGluIHRoZSBmdXR1cmUNCj4+IGNvdWxkIHJlZHVjZSB0aGUgcG9zc2li
aWxpdHkgaWYgbm90IGZ1bGx5IGtpbGwgaXQuDQo+IA0KPiBZZWFoIHRoaXMgc291bmRzIGRvYWJs
ZS4NCg0KQnV0IGl0IG1heSBuZWVkIG1vcmUgY29uc2lkZXJhdGlvbiBzaW5jZSB0aGUgcncgLT4g
bm9jb3dfcm8gLT4gcm8gc3RhdGUNCm1hY2hpbmUgY2FuIGJlIG1vcmUgY29tcGxleCB0aGFuIG15
IGluaXRpYWwgdGhvdWdodC4NCg0KPiANCj4+IEl0IGxvb2tzIGxpa2UgY2hhbmdpbmcgdGhlIFdB
Uk5fT04ocmV0KSB0byBXQVJOX09OKHJldCAhPSAtRU5PU1BDKSB3b3VsZA0KPj4gYmUgbmVlZGVk
IGZvciB0aGlzIHBhdGNoIGFzIGEgcXVpY2sgZml4Lg0KPiANCj4gSSdsbCByZW1vdmUgdGhlIHdh
cm5pbmcgY29tcGxldGVseSwgYXMgYSBzZXBhcmF0ZSBwYXRjaC4NCg0KVGhhdCdzIGdyZWF0Lg0K
DQpUaGFua3MsDQpRdQ0K
