Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C726112E41F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 10:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgABJAf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 04:00:35 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:59063 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727842AbgABJAe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 04:00:34 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Thu,  2 Jan 2020 08:59:33 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 2 Jan 2020 08:57:23 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 2 Jan 2020 08:57:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBZ9/EYVj+L10gOohzL2XiR9r1eDGi/S52wBOisUeSrOqWvqVeczO0rIT7P4ZcpS5QjCofkfWN8ua3/SygRrCbpuSe8YR4yQ8B5dGkrpLNI3Q0k6nLFPbXDGsjr6Fh51mRqxKZRZAQlgJBLyB0n0pj9s1OlJhYlnoOJ2TCo0jCiPrapmXOW1p9b3kuH9E7oLC9onymtuHpig4PhGsstYha21NerLOV+hmj2PaOM9C3tRDVVWKhH8IsRG8gf4PkVxXN2xPcowN4cbI3MPPOM6h+YFSkF8FqPeuZq8zQHDSjBMK0j9ZUReKVUB15ET1YzkKmw9IVL6DdfVyTP/MHJzgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgTzxmiZTn04ZL2RwrBVIuSKyz0dhw3E+EqQbcBs23U=;
 b=fMsowUYKNaT7EHMfJW+rbKh/XojMXDMkqiY4cDj6JxO6TawKXjjsFHsN+9CN2MXxVaqx2URuw8/axPzUkmbrcdKoCXhw3HNStisfsA+XRs/2HTCGhhY52T3LnHQT7OVvQleZnQ02umt198EY5VFrxkIGJTjxmokbXVaEvsPp7w+VEHIyLaLDfxlZ2AQaNVyBTxWEUT5DLr0/Q1zhDD9ZYI02F5FFAMiH6ZVGi7YYzCACxC3byIe+aEHf/EH63FYsqJ7+yeCl7FZo5m2o+bWPhyav3gi7Hjc3AOaIGDwNhNyb2nqUjOEH7D8vBKf67DhUAAnnILMGaH5Rv/dHwugQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3186.namprd18.prod.outlook.com (10.255.139.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Thu, 2 Jan 2020 08:57:22 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::c9ec:d898:8be0:9f69]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::c9ec:d898:8be0:9f69%5]) with mapi id 15.20.2581.014; Thu, 2 Jan 2020
 08:57:21 +0000
Received: from [0.0.0.0] (149.28.201.231) by BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12 via Frontend Transport; Thu, 2 Jan 2020 08:57:20 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] Introduce per-profile available space array to avoid
 over-confident can_overcommit()
Thread-Topic: [PATCH 0/4] Introduce per-profile available space array to avoid
 over-confident can_overcommit()
Thread-Index: AQHVwUqkAExdElYLiE6qDsEDle/yaA==
Date:   Thu, 2 Jan 2020 08:57:21 +0000
Message-ID: <2fb1c0be-11d8-885a-f711-d3f171c9060f@suse.com>
References: <20200102074705.136348-1-wqu@suse.com>
In-Reply-To: <20200102074705.136348-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34)
 To BY5PR18MB3266.namprd18.prod.outlook.com (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.28.201.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1c7a9e8-f34a-4373-2955-08d78f61c72e
x-ms-traffictypediagnostic: BY5PR18MB3186:
x-microsoft-antispam-prvs: <BY5PR18MB318615F398916C3FD801F6A3D6200@BY5PR18MB3186.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(396003)(136003)(346002)(39850400004)(54534003)(199004)(189003)(8676002)(31696002)(8936002)(86362001)(6706004)(6486002)(81166006)(81156014)(52116002)(186003)(66946007)(2616005)(956004)(31686004)(2906002)(36756003)(66446008)(316002)(478600001)(66476007)(66556008)(64756008)(16576012)(71200400001)(16526019)(6916009)(26005)(5660300002)(78286006)(131093003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3186;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VNC72w31/zdzQIVKWA+DmS3uwXaZKVnxim5g7R1ok46orRU29dpOQwQkUHR2FbroCwnCaJ1V/MB8UPZgVw9aWSkGXwjTEOYQx4y/HSQWYvqf/xlXagl9WpWlDayge84xq4VmyVNkDtg1jQwj4vQZtRu+TvLzXP+74GY5bTUwnMe+bRDpahrMu8JPdxKUmvnGJX8JtQH/psQbYpmKYZ+sF9FmaXncxFJ3NwJceEHAmxvFxZ2GxLfaGFXCuOkDlZyTsqTaCoSoT9dBpOCpC9WX/MIlr336ujwm57TP564FvrRipMpBCTHHQseNWzewrCWy2ioOyl0jiXAEvUvbsHaRzbRw/WECSeMKjXi2ej39XvIRYd3/UauCv0GVZbMMdQPzxJyJ7oGPPsIRORVGyweRL3X53KFhKqREdHt0ch3jOl5M/8zpVkaYgNWydvXgN5MdWW3i2sVCi+/lehVHGCQvqd5KSzdia1fhyft8mmJgKU2J5GYW57TdH05iEBcH4MG131N//GMOBDRBsg7voUB3FbpR0KiEt1ecdKCs1CIMqUk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6443794ABC48384CA44FE2E64C529668@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c7a9e8-f34a-4373-2955-08d78f61c72e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 08:57:21.5293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EEuxj/l1qnGmBjxVrYza4MMfUDf2zjj5gJiBANCqwKOX2pW8YrAA/gp8ndma0Gox
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3186
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMjAvMS8yIOS4i+WNiDM6NDcsIFF1IFdlbnJ1byB3cm90ZToNCj4gVGhlcmUgYXJl
IHNldmVyYWwgYnVnIHJlcG9ydHMgb2YgRU5PU1BDIGVycm9yIGluDQo+IGJ0cmZzX3J1bl9kZWxh
bGxvY19yYW5nZSgpLg0KPiANCj4gV2l0aCBzb21lIGV4dHJhIGluZm8gZnJvbSBvbmUgcmVwb3J0
ZXIsIGl0IHR1cm5zIG91dCB0aGF0DQo+IGNhbl9vdmVyY29tbWl0KCkgaXMgdXNpbmcgYSB3cm9u
ZyB3YXkgdG8gY2FsY3VsYXRlIGFsbG9jYXRhYmxlIG1ldGFkYXRhDQo+IHNwYWNlLg0KPiANCj4g
VGhlIG1vc3QgdHlwaWNhbCBjYXNlIHdvdWxkIGxvb2sgbGlrZToNCj4gICBkZXZpZCAxIHVuYWxs
b2NhdGVkOgkxRw0KPiAgIGRldmlkIDIgdW5hbGxvY2F0ZWQ6ICAxMEcNCj4gICBtZXRhZGF0YSBw
cm9maWxlOglSQUlEMQ0KPiANCj4gSW4gYWJvdmUgY2FzZSwgd2UgY2FuIGF0IG1vc3QgYWxsb2Nh
dGUgMUcgY2h1bmsgZm9yIG1ldGFkYXRhLCBkdWUgdG8NCj4gdW5iYWxhbmNlZCBkaXNrIGZyZWUg
c3BhY2UuDQo+IEJ1dCBjdXJyZW50IGNhbl9vdmVyY29tbWl0KCkgdXNlcyBmYWN0b3IgYmFzZWQg
Y2FsY3VsYXRpb24sIHdoaWNoIG5ldmVyDQo+IGNvbnNpZGVyIHRoZSBkaXNrIGZyZWUgc3BhY2Ug
YmFsYW5jZS4NCj4gDQo+IA0KPiBUbyBhZGRyZXNzIHRoaXMgcHJvYmxlbSwgaGVyZSBjb21lcyB0
aGUgcGVyLXByb2ZpbGUgYXZhaWxhYmxlIHNwYWNlDQo+IGFycmF5LCB3aGljaCBnZXRzIHVwZGF0
ZWQgZXZlcnkgdGltZSBhIGNodW5rIGdldCBhbGxvY2F0ZWQvcmVtb3ZlZCBvciBhDQo+IGRldmlj
ZSBnZXQgZ3Jvd24gb3Igc2hydW5rLg0KPiANCj4gVGhpcyBwcm92aWRlcyBhIHF1aWNrIHdheSBm
b3IgaG90dGVyIHBsYWNlIGxpa2UgY2FuX292ZXJjb21taXQoKSB0byBncmFiDQo+IGFuIGVzdGlt
YXRpb24gb24gaG93IG1hbnkgYnl0ZXMgaXQgY2FuIG92ZXItY29tbWl0Lg0KPiANCj4gVGhlIHBl
ci1wcm9maWxlIGF2YWlsYWJsZSBzcGFjZSBjYWxjdWxhdGlvbiB0cmllcyB0byBrZWVwIHRoZSBi
ZWhhdmlvcg0KPiBvZiBjaHVuayBhbGxvY2F0b3IsIHRodXMgaXQgY2FuIGhhbmRsZSB1bmV2ZW4g
ZGlza3MgcHJldHR5IHdlbGwuDQo+IA0KPiBBbHRob3VnaCBwZXItcHJvZmlsZSBpcyBub3QgY2xl
dmVyIGVub3VnaCB0byBoYW5kbGUgZXN0aW1hdGlvbiB3aGVuIGJvdGgNCj4gZGF0YSBhbmQgbWV0
YWRhdGEgY2h1bmtzIG5lZWQgdG8gYmUgY29uc2lkZXJlZCwgaXRzIHZpcnR1YWwgY2h1bmsNCj4g
aW5mcmFzdHJ1Y3R1cmUgaXMgZmxleCBlbm91Z2ggdG8gaGFuZGxlIHN1Y2ggY2FzZS4NCj4gDQo+
IFNvIGZvciBzdGF0ZnMoKSwgd2UgYWxzbyByZS11c2UgdmlydHVhbCBjaHVuayBhbGxvY2F0b3Ig
dG8gaGFuZGxlDQo+IGF2YWlsYWJsZSBkYXRhIHNwYWNlLCB3aXRoIG1ldGFkYXRhIG92ZXItY29t
bWl0IHNwYWNlIGNvbnNpZGVyZWQuDQo+IFRoaXMgYnJpbmdzIGFuIHVuZXhwZWN0ZWQgYWR2YW50
YWdlLCBub3cgd2UgY2FuIGhhbmRsZSBSQUlENS82IHByZXR0eSBPSw0KPiBpbiBzdGF0ZnMoKS4N
Cj4gDQo+IENoYW5nZWxvZzoNCj4gdjE6DQo+IC0gRml4IGEgYnVnIHdoZXJlIHdlIGZvcmdvdCB0
byB1cGRhdGUgcGVyLXByb2ZpbGUgYXJyYXkgYWZ0ZXIgYWxsb2NhdGluZw0KPiAgIGEgY2h1bmsu
DQo+ICAgVG8gYXZvaWQgQUJCQSBkZWFkbG9jaywgdGhpcyBpbnRyb2R1Y2UgYSBzbWFsbCB3aW5k
b3dzIGF0IHRoZSBlbmQNCj4gICBfX2J0cmZzX2FsbG9jX2NodW5rKCksIGl0J3Mgbm90IGVsZWdh
bnQgYnV0IHNob3VsZCBiZSBnb29kIGVub3VnaA0KPiAgIGJlZm9yZSB3ZSByZXdvcmsgY2h1bmsg
YW5kIGRldmljZSBsaXN0IG11dGV4Lg0KTXkgcGVyc2lzdGVuY2Ugb24gZGV2aWNlX2xpc3RfbXV0
ZXggZG9lc24ndCB0dXJuIG91dCB0byBiZSBnb29kLg0KSXQgY2F1c2VzIGRlYWQgbG9jayBpbiBi
dHJmcy8xMjQuDQoNCkknbGwgcmV3b3JrIHRoaXMgbG9jayBwYXJ0IHRvIHNvbHZlIHRoZW0uDQoN
ClRoYW5rcywNClF1DQoNCj4gICANCj4gLSBNYWtlIHN0YXRmcygpIHRvIHVzZSB2aXJ0dWFsIGNo
dW5rIGFsbG9jYXRvciB0byBkbyBiZXR0ZXIgZXN0aW1hdGlvbg0KPiAgIE5vdyBzdGF0ZnMoKSBj
YW4gcmVwb3J0IG5vdCBvbmx5IG1vcmUgYWNjdXJhdGUgcmVzdWx0LCBidXQgY2FuIGFsc28NCj4g
ICBoYW5kbGUgUkFJRDUvNiBiZXR0ZXIuDQo+IA0KPiBRdSBXZW5ydW8gKDQpOg0KPiAgIGJ0cmZz
OiBJbnRyb2R1Y2UgcGVyLXByb2ZpbGUgYXZhaWxhYmxlIHNwYWNlIGZhY2lsaXR5DQo+ICAgYnRy
ZnM6IFVwZGF0ZSBwZXItcHJvZmlsZSBhdmFpbGFibGUgc3BhY2Ugd2hlbiBkZXZpY2Ugc2l6ZS91
c2VkIHNwYWNlDQo+ICAgICBnZXQgdXBkYXRlZA0KPiAgIGJ0cmZzOiBzcGFjZS1pbmZvOiBVc2Ug
cGVyLXByb2ZpbGUgYXZhaWxhYmxlIHNwYWNlIGluIGNhbl9vdmVyY29tbWl0KCkNCj4gICBidHJm
czogc3RhdGZzOiBVc2UgdmlydHVhbCBjaHVuayBhbGxvY2F0aW9uIHRvIGNhbGN1bGF0aW9uIGF2
YWlsYWJsZQ0KPiAgICAgZGF0YSBzcGFjZQ0KPiANCj4gIGZzL2J0cmZzL3NwYWNlLWluZm8uYyB8
ICAxNSArKy0NCj4gIGZzL2J0cmZzL3N1cGVyLmMgICAgICB8IDE5MCArKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZnMvYnRyZnMvdm9sdW1lcy5jICAgIHwgMjIzICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiAgZnMvYnRyZnMvdm9sdW1l
cy5oICAgIHwgIDE0ICsrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAyOTMgaW5zZXJ0aW9ucygrKSwg
MTQ5IGRlbGV0aW9ucygtKQ0KPiANCg==
