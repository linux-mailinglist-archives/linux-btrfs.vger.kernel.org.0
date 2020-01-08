Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C21713501E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 00:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgAHXxr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 18:53:47 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:57902 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbgAHXxq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 18:53:46 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Wed,  8 Jan 2020 23:52:35 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 8 Jan 2020 23:53:13 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 8 Jan 2020 23:53:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHBDnEtRE/HxNuyRKtL3kBygUb2vI4mLhZwEWHrlnncHYtxIX1XeoA55IgB2X9jEwZl+QfJn0CUKvQsU3+2QY6ndUWtIsydCPBsGxhNjdl6LKmT3yrY3jmEGEYcXut+9gr1RINGkGtq6xWdIYv8P3YzhdIRel0oHQMwtHoet4v1qMCqI4gVKc2jv+eMQhOBUD8xaasX1GrggxX3w+cdyg0RL4FubzZiVwga+fnLZf/CmdW8kWstx+YtxuT4UAU3sLwiiDRuTOGEi7BZDqn2yrzE8sRpz9WHyjNLTQ3zDqo22sQfA0ieqd08faWtfA6JKdhlp6tULH4yLuG+uP6+DjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AWPmGjG8/7sbkTDOKnBsA+v3yYwe13p5mkxxg0n6mA=;
 b=LceyA5FDRjRMZCpCpjz6AbcdWB7c1qc113Oj3YWRBqyAzm46Qv00bQWTklCuitd3dIEbGwqq5Kw4oSN9eYMKVO75aGtpBoK6jAXqMun1m849UmtP3WymyiekpJAwNlV4MrFURcQ6+DLQqfTiwggfEZBai6Q33S8mTv77fPxtM+93ZqPjE5xgY5ZVdCgoMZJVe2YX70nfMPk7J08VwqArARSgcZ68hQe1sNFae9124jm1W9wlNQlIBwxRglribLgYJVr/NLiGCTeZ8IQEE+arthD+QudD+Cj6jtxGe/XZcHWkYjnVntou9Q3RTuBRtZRZ6rTS8/pkCPKSpcL2JhwLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3185.namprd18.prod.outlook.com (10.255.137.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Wed, 8 Jan 2020 23:53:11 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2623.010; Wed, 8 Jan 2020
 23:53:11 +0000
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0084.namprd05.prod.outlook.com (2603:10b6:a03:e0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.4 via Frontend Transport; Wed, 8 Jan 2020 23:53:10 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 1/3] btrfs: Introduce per-profile available space
 facility
Thread-Topic: [PATCH v3 1/3] btrfs: Introduce per-profile available space
 facility
Thread-Index: AQHVxJ5IZkfMiqbFt0+LulmbjZmcXafedu6AgAJpvYCAAJOlAA==
Date:   Wed, 8 Jan 2020 23:53:11 +0000
Message-ID: <e1fa655e-e42a-4bd4-6f83-6175c38a1219@suse.com>
References: <20200106061343.18772-1-wqu@suse.com>
 <20200106061343.18772-2-wqu@suse.com> <20200106143242.GG3929@twin.jikos.cz>
 <9c2308bb-c3ae-d502-4b27-f8dbedc25d1a@gmx.com>
 <20200108150441.GG3929@twin.jikos.cz>
In-Reply-To: <20200108150441.GG3929@twin.jikos.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::25) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.28.201.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04cc5aa8-33b5-40d3-b368-08d79495eb12
x-ms-traffictypediagnostic: BY5PR18MB3185:
x-microsoft-antispam-prvs: <BY5PR18MB31856F69ECA5477F05B70D87D63E0@BY5PR18MB3185.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(189003)(199004)(316002)(6706004)(2616005)(956004)(71200400001)(52116002)(8936002)(64756008)(66446008)(66556008)(31686004)(66476007)(16576012)(16526019)(186003)(110136005)(8676002)(26005)(81166006)(81156014)(31696002)(66946007)(86362001)(478600001)(6486002)(36756003)(5660300002)(2906002)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3185;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xDppNzkPNOkhPoRnDRqIob59XlqHwpJ+7YDatb3G8B8PbuYAXFG9mRo/U4jg4sJaeSm/MB3QHlcZiYMom8L89LpGQHoRkuv9/kDZT8KvQ0txhsWzW9/GPyFjO4vqrje18TEOHyP3FIH2KlHlQmTCNefMCAQlnll2shU2+oUv4PDFl6MNsbN+JfbXFlSGAddH8xqbGPpvUEawcpqk3yQ5SdJI8d/MdyHFn0TZUFGxTWEKfDI6viEUCNRe0wIj224QoxAEbLxX3vRdCuuSat1C6QlyQuewLr8TQa4g+xN53ofbUWAF1DQgnchCTWMIs6Z4a7p6FEtbRVpfeMkJmFZvif4ASFFPVgJckDBDBKfTcadSCNlad9e0ESdp9k8ik0omTUQKRI2OqwEjzynlb6ZdKN82+g9rpIv1XdTfzc92RTFTc5+yW+LjG00K7D3hPxSqagCo9S+fayhO3rEqpY7VGfxxuB8vH6Kih3nDhrLoaB6NrQWvb+iQ/1XhsGyShMr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <34359F259E711644874483BD37AED7B9@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cc5aa8-33b5-40d3-b368-08d79495eb12
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 23:53:11.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxxvHIXP0BeIOSZTEMwMWerqFq3TnSh7+yBmNx2xyUK8hvAVfdZD7OnAsc0RLWP8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3185
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMjAvMS84IOS4i+WNiDExOjA0LCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+IE9uIFR1
ZSwgSmFuIDA3LCAyMDIwIGF0IDEwOjEzOjQzQU0gKzA4MDAsIFF1IFdlbnJ1byB3cm90ZToNCj4+
Pj4gKwlkZXZpY2VzX2luZm8gPSBrY2FsbG9jKGZzX2RldmljZXMtPnJ3X2RldmljZXMsIHNpemVv
ZigqZGV2aWNlc19pbmZvKSwNCj4+Pj4gKwkJCSAgICAgICBHRlBfTk9GUyk7DQo+Pj4NCj4+PiBD
YWxsaW5nIGtjYWxsb2MgaXMgYW5vdGhlciBwb3RlbnRpYWwgc2xvd2Rvd24sIGZvciB0aGUgc3Rh
dGZzDQo+Pj4gY29uc2lkZXJhdGlvbnMuDQo+Pg0KPj4gVGhhdCdzIGFsc28gd2hhdCB3ZSBkaWQg
aW4gc3RhdGZzKCkgYmVmb3JlLCBzbyBpdCBzaG91bGRuJ3QgY2F1c2UgZXh0cmENCj4+IHByb2Js
ZW0uDQo+PiBGdXJ0aGVybW9yZSwgd2UgZGlkbid0IHVzZSBjYWxjX29uZV9wcm9maWxlX2F2YWls
KCkgZGlyZWN0bHkgaW4gc3RhdGZzKCkNCj4+IGRpcmVjdGx5Lg0KPj4NCj4+IEFsdGhvdWdoIEkg
Z2V0IHlvdXIgcG9pbnQsIGFuZCBwZXJzb25hbGx5IHNwZWFraW5nIHRoZSBtZW1vcnkgYWxsb2Nh
dGlvbg0KPj4gYW5kIGV4dHJhIGluLW1lbW9yeSBkZXZpY2UgaXRlcmF0aW9uIHNob3VsZCBiZSBw
cmV0dHkgZmFzdCBjb21wYXJlZCB0bw0KPj4gX19idHJmc19hbGxvY19jaHVuaygpLg0KPj4NCj4+
IFRodXMgSSBkb24ndCB0aGluayB0aGlzIG1lbW9yeSBhbGxvY2F0aW9uIHdvdWxkIGNhdXNlIGV4
dHJhIHRyb3VibGUsDQo+PiBleGNlcHQgdGhlIGVycm9yIGhhbmRsaW5nIG1lbnRpb25lZCBiZWxv
dy4NCj4gDQo+IFJpZ2h0LCBjdXJyZW50IHN0YXRmcyBhbHNvIGRvZXMgYWxsb2NhdGlvbiB2aWEN
Cj4gYnRyZnNfY2FsY19hdmFpbF9kYXRhX3NwYWNlLCBzbyBpdCdzIHRoZSBzYW1lIGFzIGJlZm9y
ZS4NCj4gDQo+PiBbLi4uXQ0KPj4+PiArCQkJcmV0ID0gY2FsY19wZXJfcHJvZmlsZV9hdmFpbChm
c19pbmZvKTsNCj4+Pg0KPj4+IEFkZGluZyBuZXcgZmFpbHVyZSBtb2Rlcw0KPj4NCj4+IEFub3Ro
ZXIgc29sdXRpb24gSSBoYXZlIHRyaWVkIGlzIG1ha2UgY2FsY19wZXJfcHJvZmlsZV9hdmFpbCgp
IHJldHVybg0KPj4gdm9pZCwgaWdub3JpbmcgdGhlIEVOT01FTSBlcnJvciwgYW5kIGp1c3Qgc2V0
IHRoZSBhZmZlY3RlZCBwcm9maWxlIHRvIDANCj4+IGF2YWlsYWJsZSBzcGFjZS4NCj4+DQo+PiBC
dXQgdGhhdCBtZXRob2QgaXMganVzdCBkZWxheWluZyBFTk9NRU0sIGFuZCB3b3VsZCBjYXVzZSBz
dHJhbmdlDQo+PiBwcmUtcHJvZmlsZSB2YWx1ZXMgdW50aWwgbmV4dCBzdWNjZXNzZnVsIHVwZGF0
ZSBvciBtb3VudCBjeWNsZS4NCj4+DQo+PiBBbnkgaWRlYSBvbiB3aGljaCBtZXRob2QgaXMgbGVz
cyB3b3JzZT8NCj4gDQo+IEJldHRlciB0byByZXR1cm4gdGhlIGVycm9yIHRoYW4gd3JvbmcgdmFs
dWVzIGluIHRoaXMgY2FzZS4gQXMgdGhlDQo+IG51bWJlcnMgYXJlIHNvcnQgb2YgYSBjYWNoZSBh
bmQgdGhlIG1vdW50IGN5Y2xlIHRvIGdldCB0aGVtIGZpeGVkIGlzIG5vdA0KPiB2ZXJ5IHVzZXIg
ZnJpZW5kbHksIHdlIG5lZWQgc29tZSBvdGhlciB3YXkuIEFzIHRoaXMgaXMgYSBnbG9iYWwgc3Rh
dGUsIGENCj4gYml0IGluIGZzX2luZm86OmZsYWdzIGNhbiBiZSBzZXQgYW5kIGZ1bGwgcmVjYWxj
dWxhdGlvbiBhdHRlbXB0ZWQgYXQNCj4gc29tZSBwb2ludCB1bnRpbCBpdCBzdWNjZWVkcy4gVGhp
cyB3b3VsZCBsZWF2ZSB0aGUgY291bnRlcnMgc3RhbGUgZm9yDQo+IHNvbWUgdGltZSBidXQgSSB0
aGluayBzdGlsbCBiZXR0ZXIgdGhhbiBpZiB0aGV5J3JlIHN1ZGRlbmx5IDAuDQo+IA0KSWYgY2Fu
X292ZXJfY29tbWl0KCkgaXMgdGhlIG9ubHkgdXNlciBvZiB0aGlzIGZhY2lsaXR5LCB0aGVuIGVp
dGhlciBhbg0KZXh0cmEgaW5kaWNhdG9yIG9yIHN1ZGRlbiAwIGlzIG5vIHByb2JsZW0uDQpBcyBp
biB0aGF0IGNhc2UsIHdlIGp1c3QgZG9uJ3Qgb3Zlci1jb21taXQgYW5kIGRvIGV4dHJhIGZsdXNo
IHRvIGZyZWUNCm1ldGEgc3BhY2UuDQoNCkJ1dCB3aGVuIHN0YXRmcygpIGlzIGdvaW5nIHRvIHVz
ZSB0aGlzIGZhY2lsaXR5LCBlaXRoZXIgc3VkZGVuIDAgbm9yDQppbmRpY2F0b3IgaXMgZ29vZC4N
Ckp1c3QgaW1hZ2Ugc2Vjb25kcyBiZWZvcmUsIHdlIHN0aWxsIGhhdmUgc2V2ZXJhbCBUaUIgZnJl
ZSBzcGFjZSwgYW5kIGFsbA0Kb2YgYSBzdWRkZW4sIGp1c3Qgc2V2ZXJhbCBHaUIgZnJlZSAoZnJv
bSBhbGxvY2F0ZWQgZGF0YSBjaHVua3MpLg0KDQpVc2VyIHdpbGwgZGVmaW5pdGVseSBjb21wbGFp
bi4NCg0KVGh1cyBJIHN0aWxsIHByZWZlciBwcm9wZXIgZXJyb3IgaGFuZGxpbmcsIGFzIHdoZW4g
d2UncmUgbG93IG9uIG1lbW9yeSwNCmEgbG90IG9mIHRoaW5ncyBjYW4gZ28gd3JvbmcgYW55d2F5
Lg0KDQpUaGFua3MsDQpRdQ0K
