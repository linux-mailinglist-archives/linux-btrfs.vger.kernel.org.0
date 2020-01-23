Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0DFC146801
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 13:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgAWMbS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 07:31:18 -0500
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:53594 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbgAWMbR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 07:31:17 -0500
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.146) BY m4a0073g.houston.softwaregrp.com WITH ESMTP;
 Thu, 23 Jan 2020 12:29:16 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 23 Jan 2020 12:28:56 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 23 Jan 2020 12:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKsb40vXx5vjEkbPCmsZXph8lAo+Q2Md5KmlC6kaoFZGlJTlD0mRc3IYUMg4NoQdoEwUz+LewJ9uKc/uObp767IqINpnp1MycQo8LU6pIg53VXO+dqVPUBcJNvhP3SSMBvwNsbWMhdVKRPHEfR5CFZ3joJfhbMSHU+YOf2ghGInAHa/THf1u3Pq2vMix7+VgoVvUvGPYwN5xvAAtAFN2thlo3/8AzT0upbj1x5JnGBo/3uZVX4y3Nwc6CjO2IleesoEYXf77ZmTRIHCe9MSQtMtGBy4K477TFStqv5c+lT4ww662oEKZaQzXVgu/hqpgzkX3wyKttTSEYlF9s5bKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us8xj6QPPQd8rR6mVTBVYEDKut+vujwWXgZ2w6wFKw0=;
 b=CUqEOtoTZqxefTOn+inyJRhhFQY9Q/u4Mii/OzTOBojnWimk6EanJ/Zyh2ppY3T3mTmHom9pmZuOZhqGVZS+wJ4s8Skc5j1mfWVo2dinM5TmGMoh7tmdgWj0q6FG66M/kCS2euXnewtOAneVrBnYpV004wCZykpOSaev8uH2ZWF4ZkbLW0bSTtAMwG3KWzH3GrLQrm1zgXsNMJAMZenH6ZblbsNgCTjHlRzg+Ux4vgx9OwU9RW/Nm2/yz1qJv9TSH9AvLiMBxVD8qX61L5NIzceoAoPJ43GAzCicYodmU2ntAu7vXwUIpaj0mt50oJGp/xY6o88o8E0plISa7BXgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3091.namprd18.prod.outlook.com (10.255.136.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 12:28:55 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 12:28:54 +0000
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:e0::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Thu, 23 Jan 2020 12:28:53 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <FdManana@suse.com>
Subject: Re: [PATCH] btrfs: scrub: Require mandatory block group RO for
 dev-replace
Thread-Topic: [PATCH] btrfs: scrub: Require mandatory block group RO for
 dev-replace
Thread-Index: AQHV0eW82uMOazu5JEeqEEiIRnvNt6f4LYkA
Date:   Thu, 23 Jan 2020 12:28:54 +0000
Message-ID: <9e202c2d-b715-ef02-4895-0529ad127449@suse.com>
References: <20200123073759.23535-1-wqu@suse.com>
 <CAL3q7H4ed9PtALC_xjPeaiKDDhAN1oNzgM0yd=buF_C5r+x7wA@mail.gmail.com>
In-Reply-To: <CAL3q7H4ed9PtALC_xjPeaiKDDhAN1oNzgM0yd=buF_C5r+x7wA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::45) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.28.201.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8153d4f9-67cd-48d9-20e4-08d79fffcf8b
x-ms-traffictypediagnostic: BY5PR18MB3091:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB30919694D7D3C61F8F5E193AD60F0@BY5PR18MB3091.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(189003)(199004)(81166006)(81156014)(66476007)(66946007)(26005)(16526019)(8676002)(956004)(6706004)(52116002)(86362001)(64756008)(31686004)(66446008)(2616005)(6916009)(31696002)(71200400001)(54906003)(4326008)(6486002)(107886003)(186003)(16576012)(8936002)(36756003)(5660300002)(66556008)(498600001)(53546011)(2906002)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3091;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YVgxRBzRGcY3xcXpZcj+omawBReXw7KE9Qkud8nEbCzmtn0i9wvVRpsv96XvlDhRdW2qlEOXCwLlKfHxr9FxlPFBA3NgpXPxKXvruP8NRpwmF6GNjKuhfZNAXMNOe9vu07/9vI1rl9h/eljREaxTgIu8xMZXoAMMZ19ohwnmlU7/Hh3oT+wpYacmE6AfwodFGfoQOVmc4mFRqT96J9gR2fiFpbCyrs1IEwHDHXi9C156CYimOzNZHsmm2ldeZrW4W4++0IJadfhX4CABHa/833jB7SsjYHby/uAyGvBtMts6+e6t4Yt4VussMCTxfX3F2KPNKfUswDMR5fZRteRFgiFbg6gzGw5YN71xX8gi/CD5UZFBJQMBBT5CiW1YsEGM7AHGBv0Xhz1fHFr0nF0q/RInF61zqzaBc8B0CsmBph3ersdZCQnRDsGjeqtpKahRqxm49Dtxsawwkw/P/sHql3cSIpVin05HxF7an+ges3ACXL7zMxcKDoVjD+NyDW2w
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B3C00380FF22243929654C922DAF95D@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8153d4f9-67cd-48d9-20e4-08d79fffcf8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 12:28:54.7121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqR5gvj3X90rexXm+nCebAYq5BF7P6kDGpuPmlE2FztX+55ntBfLT3rVXx2tlPtE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3091
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMjAvMS8yMyDkuIvljYg4OjA2LCBGaWxpcGUgTWFuYW5hIHdyb3RlOg0KPiBPbiBU
aHUsIEphbiAyMywgMjAyMCBhdCA3OjM4IEFNIFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPiB3cm90
ZToNCj4+DQo+PiBbQlVHXQ0KPj4gRm9yIGRldi1yZXBsYWNlIHRlc3QgY2FzZXMgd2l0aCBmc3N0
cmVzcywgbGlrZSBidHJmcy8wNls0NV0gYnRyZnMvMDcxLA0KPj4gbG9vcGVkIHJ1bnMgY2FuIGxl
YWQgdG8gcmFuZG9tIGZhaWx1cmUsIHdoZXJlIHNjcnViIGZpbmRzIGNzdW0gZXJyb3IuDQo+Pg0K
Pj4gVGhlIHBvc3NpYmlsaXR5IGlzIG5vdCBoaWdoLCBhcm91bmQgMS8yMCB0byAxLzEwMCwgYnV0
IGl0J3MgY2F1c2luZyBkYXRhDQo+PiBjb3JydXB0aW9uLg0KPj4NCj4+IFRoZSBidWcgaXMgb2Jz
ZXJ2YWJsZSBhZnRlciBjb21taXQgYjEyZGU1Mjg5NmMwICgiYnRyZnM6IHNjcnViOiBEb24ndA0K
Pj4gY2hlY2sgZnJlZSBzcGFjZSBiZWZvcmUgbWFya2luZyBhIGJsb2NrIGdyb3VwIFJPIikNCj4+
DQo+PiBbQ0FVU0VdDQo+PiBEZXYtcmVwbGFjZSBoYXMgdHdvIHNvdXJjZSBvZiB3cml0ZXM6DQo+
PiAtIFdyaXRlIGR1cGxpY2F0aW9uDQo+PiAgIEFsbCB3cml0ZXMgdG8gc291cmNlIGRldmljZSB3
aWxsIGFsc28gYmUgZHVwbGljYXRlZCB0byB0YXJnZXQgZGV2aWNlLg0KPj4NCj4+ICAgQ29udGVu
dDogICAgICBMYXRlc3QgZGF0YS9tZXRhDQo+IA0KPiBJIGZpbmQgdGhlIHRlcm0gImxhdGVzdCIg
YSBiaXQgY29uZnVzaW5nLCBwZXJoYXBzICJub3QgeWV0IHBlcnNpc3RlZA0KPiBkYXRhIGFuZCBt
ZXRhZGF0YSIgaXMgbW9yZSBjbGVhci4NCj4gDQo+Pg0KPj4gLSBTY3J1YiBjb3B5DQo+PiAgIERl
di1yZXBsYWNlIHJldXNlZCBzY3J1YiBjb2RlIHRvIGl0ZXJhdGUgdGhyb3VnaCBleGlzdGluZyBl
eHRlbnRzLCBhbmQNCj4+ICAgY29weSB0aGUgdmVyaWZpZWQgZGF0YSB0byB0YXJnZXQgZGV2aWNl
Lg0KPj4NCj4+ICAgQ29udGVudDogICAgICBEYXRhL21ldGEgaW4gY29tbWl0IHJvb3QNCj4gDQo+
IEFuZCBzbyBoZXJlICJwcmV2aW91c2x5IHBlcnNpc3RlZCBkYXRhIGFuZCBtZXRhZGF0YSIuDQo+
IA0KPj4NCj4+IFRoZSBkaWZmZXJlbmNlIGluIGNvbnRlbnRzIG1ha2VzIHRoZSBmb2xsb3dpbmcg
cmFjZSBwb3NzaWJsZToNCj4+ICAgICAgICAgUmVndWxhciBXcml0ZXIgICAgICAgICAgfCAgICAg
ICBEZXYtcmVwbGFjZQ0KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgXiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfA0KPj4gICB8IFByZWFsbG9jYXRlIG9uZSBkYXRhIGV4dGVudCB8DQo+PiAgIHwgYXQg
Ynl0ZW5yIFgsIGxlbiAxTSAgICAgICAgIHwNCj4+ICAgdiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfA0KPj4gICBeIENvbW1pdCB0cmFuc2FjdGlvbiAgICAgICAgICB8DQo+PiAgIHwgTm93
IGV4dGVudCBbWCwgWCsxTSkgaXMgaW4gIHwNCj4+ICAgdiBjb21taXQgcm9vdCAgICAgICAgICAg
ICAgICAgfA0KPj4gID09PT09PT09PT09PT09PT09PSBEZXYgcmVwbGFjZSBzdGFydHMgPT09PT09
PT09PT09PT09PT09PT09PT09PQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
IF4NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCB8IFNjcnViIGV4dGVudCBb
WCwgWCsxTSkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCB8IFJlYWQgW1gs
IFgrMU0pDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgfCAoVGhlIGNvbnRl
bnQgYXJlIG1vc3RseSBnYXJiYWdlDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgfCAgc2luY2UgaXQncyBwcmVhbGxvY2F0ZWQpDQo+PiAgIF4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgdg0KPj4gICB8IFdyaXRlIGJhY2sgaGFwcGVucyBmb3IgICAgICB8DQo+PiAg
IHwgZXh0ZW50IFtYLCBYKzUxMkspICAgICAgICAgIHwNCj4+ICAgfCBOZXcgZGF0YSB3cml0ZXMg
dG8gYm90aCAgICAgfA0KPj4gICB8IHNvdXJjZSBhbmQgdGFyZ2V0IGRldi4gICAgICB8DQo+PiAg
IHYgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCBeDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgfCBT
Y3J1YiB3cml0ZXMgYmFjayBleHRlbnQgW1gsIFgrMU0pDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgfCB0byB0YXJnZXQgZGV2aWNlLg0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8IHwgVGhpcyB3aWxsIG92ZXIgd3JpdGUgdGhlIG5ldyBkYXRhIGluDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgfCBbWCwgWCs1MTJLKQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IHYNCj4+DQo+PiBUaGlzIHJhY2UgY2FuIG9u
bHkgaGFwcGVuIGZvciBub2NvdyB3cml0ZXMuIFRodXMgbWV0YWRhdGEgYW5kIGRhdGEgY293DQo+
PiB3cml0ZXMgYXJlIHNhZmUsIGFzIENPVyB3aWxsIG5ldmVyIG92ZXJ3cml0ZSBleHRlbnRzIG9m
IHByZXZpb3VzIHRyYW5zDQo+PiAoaW4gY29tbWl0IHJvb3QpLg0KPj4NCj4+IFRoaXMgYmVoYXZp
b3IgY2FuIGJlIGNvbmZpcm1lZCBieSBkaXNhYmxpbmcgYWxsIGZhbGxvY2F0ZSByZWxhdGVkIGNh
bGxzDQo+PiBpbiBmc3N0cmVzcyAoKiksIHRoZW4gYWxsIHJlbGF0ZWQgdGVzdHMgY2FuIHBhc3Mg
YSAyMDAwIHJ1biBsb29wLg0KPj4NCj4+ICo6IEZTU1RSRVNTX0FWT0lEPSItZiBmYWxsb2NhdGU9
MCAtZiBhbGxvY3NwPTAgLWYgemVybz0wIC1mIGluc2VydD0wIFwNCj4+ICAgICAgICAgICAgICAg
ICAgICAtZiBjb2xsYXBzZT0wIC1mIHB1bmNoPTAgLWYgcmVzdnNwPTAiDQo+PiAgICBJIGRpZG4n
dCBleHBlY3QgcmVzdnNwIGlvY3RsIHdpbGwgZmFsbGJhY2sgdG8gZmFsbG9jYXRlIGluIFZGUy4u
Lg0KPj4NCj4+IFtGSVhdDQo+PiBNYWtlIGRldi1yZXBsYWNlIHRvIHJlcXVpcmUgbWFuZGF0b3J5
IGJsb2NrIGdyb3VwIFJPLCBhbmQgd2FpdCBmb3IgY3VycmVudA0KPj4gbm9jb3cgd3JpdGVzIGJl
Zm9yZSBjYWxsaW5nIHNjcnViX2NodW5rKCkuDQo+Pg0KPj4gVGhpcyBwYXRjaCB3aWxsIG1vc3Rs
eSByZXZlcnQgY29tbWl0IDc2YThlZmExNzFiZiAoImJ0cmZzOiBDb250aW51ZSByZXBsYWNlDQo+
PiB3aGVuIHNldF9ibG9ja19ybyBmYWlsZWQiKSBmb3IgZGV2LXJlcGxhY2UgcGF0aC4NCj4+DQo+
PiBFTk9TUEMgZm9yIGRldi1yZXBsYWNlIGlzIHN0aWxsIG11Y2ggYmV0dGVyIHRoYW4gZGF0YSBj
b3JydXB0aW9uLg0KPiANCj4gVGVjaG5pY2FsbHkgaWYgd2UgZmxhZyB0aGUgYmxvY2sgZ3JvdXAg
Uk8gd2l0aG91dCBiZWluZyBhYmxlIHRvDQo+IHBlcnNpc3QgdGhhdCBkdWUgdG8gRU5PU1BDLCBp
dCdzIHN0aWxsIG9rLg0KDQpSaWdodCwgSSB3aWxsIGNoYW5nZSB0aGUgd29yZHMsIHNpbmNlIGl0
IG9ubHkgc2xpZ2h0bHkgaW5jcmVhc2UgdGhlDQpwb3NzaWJpbGl0eSBvZiBFTk9TUEMsIG5vdCBl
bnN1cmVkIHRvIGNhdXNlIEVOT1NQQyBhbmQgYWJvcnQgcmVwbGFjZS4NCg0KPiBXZSBqdXN0IHdh
bnQgdG8gcHJldmVudCBub2NvdyB3cml0ZXMgcmFjaW5nIHdpdGggc2NydWIgY29weWluZw0KPiBw
cm9jZWR1cmUuIEJ1dCB0aGF0J3Mgc29tZXRoaW5nIGZvciBzb21lIG90aGVyIHRpbWUsIGFuZCB0
aGlzIGlzIGZpbmUNCj4gdG8gbWUuDQo+IA0KPj4NCj4+IFJlcG9ydGVkLWJ5OiBGaWxpcGUgTWFu
YW5hIDxmZG1hbmFuYUBzdXNlLmNvbT4NCj4+IEZpeGVzOiA3NmE4ZWZhMTcxYmYgKCJidHJmczog
Q29udGludWUgcmVwbGFjZSB3aGVuIHNldF9ibG9ja19ybyBmYWlsZWQiKQ0KPj4gRml4ZXM6IGIx
MmRlNTI4OTZjMCAoImJ0cmZzOiBzY3J1YjogRG9uJ3QgY2hlY2sgZnJlZSBzcGFjZSBiZWZvcmUg
bWFya2luZyBhIGJsb2NrIGdyb3VwIFJPIikNCj4+IFNpZ25lZC1vZmYtYnk6IFF1IFdlbnJ1byA8
d3F1QHN1c2UuY29tPg0KPj4gLS0tDQo+PiBDaGFuZ2Vsb2c6DQo+PiBSRkMtPnYxOg0KPj4gLSBS
ZW1vdmUgdGhlIFJGQyB0YWcNCj4+ICAgU2luY2UgdGhlIGNhdXNlIGlzIHBpbm5lZCBhbmQgdmVy
aWZpZWQsIG5vIG5lZWQgZm9yIFJGQy4NCj4+DQo+PiAtIE9ubHkgd2FpdCBmb3Igbm9jb3cgd3Jp
dGVzIGZvciBkZXYtcmVwbGFjZQ0KPj4gICBDb1cgd3JpdGVzIGFyZSBzYWZlIGFzIHRoZXkgd2ls
bCBuZXZlciBvdmVyd3JpdGUgZXh0ZW50cyBpbiBjb21taXQNCj4+ICAgcm9vdC4NCj4+DQpbLi4u
XQ0KPj4gKyAgICAgICAgICAgICAgIC8qDQo+PiArICAgICAgICAgICAgICAgICogTm93IHRoZSB0
YXJnZXQgYmxvY2sgaXMgbWFya2VkIFJPLCB3YWl0IGZvciBub2NvdyB3cml0ZXMgdG8NCj4+ICsg
ICAgICAgICAgICAgICAgKiBmaW5pc2ggYmVmb3JlIGRldi1yZXBsYWNlLg0KPj4gKyAgICAgICAg
ICAgICAgICAqIENPVyBpcyBmaW5lLCBhcyBDT1cgbmV2ZXIgb3ZlcndyaXRlcyBleHRlbnRzIGlu
IGNvbW1pdCB0cmVlLg0KPj4gKyAgICAgICAgICAgICAgICAqLw0KPj4gKyAgICAgICAgICAgICAg
IGlmIChzY3R4LT5pc19kZXZfcmVwbGFjZSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJ0
cmZzX3dhaXRfbm9jb3dfd3JpdGVycyhjYWNoZSk7DQo+IA0KPiBTbyB0aGlzIG9ubHkgd2FpdHMg
Zm9yIG5vY293IG9yZGVyZWQgZXh0ZW50cyB0byBiZSBjcmVhdGVkIC0gaXQNCj4gZG9lc24ndCB3
YWl0IGZvciB0aGVtIHRvIGNvbXBsZXRlLg0KPiBBZnRlciB0aGF0IHlvdSBzdGlsbCBuZWVkIHRv
IGNhbGw6DQo+IA0KPiBidHJmc193YWl0X29yZGVyZWRfcm9vdHMoZnNfaW5mbywgVTY0X01BWCwg
Y2FjaGUtPnN0YXJ0LCBjYWNoZS0+bGVuZ3RoKTsNCg0KRm9yZ290IHRoYXQsIGFsdGhvdWdoIDEw
MDAgcnVucyBkb2Vzbid0IGV4cG9zZSBhbnkgcHJvYmxlbSB5b3UgYXJlDQpjb21wbGV0ZWx5IHJp
Z2h0Lg0KDQpJJ2xsIHVwZGF0ZSB0aGUgcGF0Y2ggdG8gYWRkcmVzcyBhbGwgbWVudGlvbmVkIGNv
bW1lbnRzLg0KDQpUaGFua3MsDQpRdQ0KDQo+IA0KPiBPdGhlciB0aGFuIHRoYXQsIGxvb2tzIGdv
b2QgdG8gbWUuDQo+IA0KPiBUaGFua3MuDQo+IA0KPj4gKw0KPj4gKyAgICAgICAgICAgICAgIHNj
cnViX3BhdXNlX29mZihmc19pbmZvKTsNCj4+ICAgICAgICAgICAgICAgICBkb3duX3dyaXRlKCZk
ZXZfcmVwbGFjZS0+cndzZW0pOw0KPj4gICAgICAgICAgICAgICAgIGRldl9yZXBsYWNlLT5jdXJz
b3JfcmlnaHQgPSBmb3VuZF9rZXkub2Zmc2V0ICsgbGVuZ3RoOw0KPj4gICAgICAgICAgICAgICAg
IGRldl9yZXBsYWNlLT5jdXJzb3JfbGVmdCA9IGZvdW5kX2tleS5vZmZzZXQ7DQo+PiAtLQ0KPj4g
Mi4yNS4wDQo+Pg0KPiANCj4gDQo=
