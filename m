Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFC6134213
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 13:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgAHMol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 07:44:41 -0500
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:35210 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727263AbgAHMol (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 07:44:41 -0500
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.146) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Wed,  8 Jan 2020 12:43:29 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 8 Jan 2020 12:38:33 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 8 Jan 2020 12:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iq3EwYxU2RPErlHxmaO0iSOu7QHzFs26rsh3mnM3LqhT8t3QDUSr2T7QLG7ZYzszByXSsULg4f7y26QkF7TafgJYKFOp/q3TqYo5xs1D+tSBkSVzPI4livcC9ibmga5OTeJipebPPdqwLGSVc6sPLXDQDgt1Cwg06YxZnTRDxVO47cfIYb22yo2kx9Nky3kYIhEEtvjDuEY4SH/EU9e9g9iuIgogd5IjmwkRODDqAhPUQSoZu+0O6F3RNxouJHlVJ0mUolF4zAzy4V0MsCV6HT6Uqc/92YVs81wGmUMErv1/5Il1p/jce+ZKtI9OwU8PQskprj128EuQQfT3djpsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVbr1U4jYSZt+JcoVdRL8J/GI07wlt2xJt60rI0vE4E=;
 b=lzvKu1DKqE8uVn5iCfxIHsRTjOyLcxYEcoOm27F8qYMpRqM9GgAALCIbCedg6b/MXC6aSFFQPbsxoR24OhL2uVfB1LPQ58imctsY3Bvro7BkXLJYzf8K7T2k3PuFBRZu12+nD8RyKq6iTCrLHw8wNTpf9EMxDINjVTy/Oy5gTJEMD6b+jZ+ZkW5n2TJC97eR6J4eZn9Bf7HilAOcFN/0JArkfI2b80raztmF6KDHRFrlLJrPJBtw2KEKB6rG3pQvGdoecNC0+4O+ImbWAD+8zxvVMP6RD17nO71gxS5dKcvZNo5rtJnvTWqPR+cHTi0LLyGO4+f4dbLgvyAhOQMuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3217.namprd18.prod.outlook.com (10.255.138.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 8 Jan 2020 12:38:32 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2623.008; Wed, 8 Jan 2020
 12:38:32 +0000
Received: from [0.0.0.0] (149.28.201.231) by BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 12:38:27 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <DSterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix memory leak in qgroup accounting
Thread-Topic: [PATCH] btrfs: fix memory leak in qgroup accounting
Thread-Index: AQHVxhxFFkpkqXe9u0uAO+AZlRtQz6fgrquAgAAELgCAAAH3AA==
Date:   Wed, 8 Jan 2020 12:38:32 +0000
Message-ID: <991a7197-b934-90a3-c15f-d21832b76782@suse.com>
References: <20200108120732.30451-1-johannes.thumshirn@wdc.com>
 <af99596c-c11d-932a-5a79-be71d2857c8e@gmx.com>
 <CDF75408-0B51-4DBD-ACC8-4EF35A5460DE@wdc.com>
In-Reply-To: <CDF75408-0B51-4DBD-ACC8-4EF35A5460DE@wdc.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.28.201.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72e71eca-7ae1-4ae7-6776-08d79437abfa
x-ms-traffictypediagnostic: BY5PR18MB3217:
x-ld-processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR18MB321795956782D93CACD29ED6D63E0@BY5PR18MB3217.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(199004)(189003)(66556008)(64756008)(2616005)(81166006)(66476007)(81156014)(36756003)(2906002)(4326008)(86362001)(52116002)(66446008)(956004)(6666004)(186003)(16526019)(6636002)(6706004)(31696002)(26005)(53546011)(4744005)(5660300002)(66946007)(8676002)(8936002)(316002)(6486002)(110136005)(71200400001)(16576012)(31686004)(478600001)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3217;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mFAzB0jkYkaQdLQRdRMMOR+lbY3vBLyVgEWLEqSmkf/lWxzfXTxQbbFX73EOCEjfc3F37/pT39YHahLcmejS+AbsQx1uqijv4V235CmWdBWDA/89PY1EwDOVvUOg5rSlG6hmbND8d3e1Hu9qFoNY6HeJNR4HzdEwusKizqucCjVHEYsJ6b81/s1VYgxtL7iVqWuO/u00Y5E6n6jMr2wUOyvX9o20EUBTt/SVa8CA/K14GXDx34a0IDzuGVmzc7TQOJaJ3H5rFylXBy5nt+1yuk5CMvT+2TahzuliBBFzoSmtM8v2/5ypdPmxfBzcxGEugmowA5XOoex1vb3mOBXu/Yzh03YSpk3au0z4ntaQFfMU9OQN9sKgCpKguky+BbXZkML+HlTEXokua6aVtvHKYglOYAu11xcTVV8p28qFQ2RS4YhR9ZJuNo/NnePL6iiRtSobYy8ZVnub1PA6z+loImErNZ0gtho7ejW9xJD732I2vmJLutFXn1Yp2LkdcwB+
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD47C4718814814EBFFB509936479CBA@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e71eca-7ae1-4ae7-6776-08d79437abfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 12:38:32.7400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yar5caUsy/ImmfctWtbpO0rXXG/cwthDFWzs+nBevXVk2rrLqsCVwM1TEEaAEqCv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3217
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMjAvMS84IOS4i+WNiDg6MzEsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4g
T24gMDgvMDEvMjAyMCwgMTM6MTYsICJRdSBXZW5ydW8iIDxxdXdlbnJ1by5idHJmc0BnbXguY29t
PiB3cm90ZToNCj4gWy4uLl0gICAgICAgDQo+IA0KPiAgICAgVGhlIHBhdGNoIGl0c2VsZiBpcyBP
Sy4NCj4gICAgIA0KPiAgICAgUmV2aWV3ZWQtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0K
PiAgICAgDQo+ICAgICANCj4gICAgIFRoaXMgbWVhbnMgdGhlIHFncm91cCBnZXQgZGlzYWJsZWQg
d2hlbiByZXNjYW4gaXMgc3RpbGwgcnVubmluZy4NCj4gICAgIFNvIEknbSBhIGxpdHRsZSBjdXJp
b3VzLCBjb3VsZCB3ZSBqdXN0IGNhbmNlbCB0aGUgcnVubmluZyByZXNjYW4gYW5kDQo+ICAgICB3
YWl0IGZvciBpdCBiZWZvcmUgZGlzYWJsaW5nIHFncm91cD8NCj4gICAgIA0KPiAgICAgDQo+IE1h
eWJlLiBJJ20gc3RpbGwgbm90IDEwMCUgY2VydGFpbiB3aGF0J3MgdGhlIGFjdHVhbCB0cmlnZ2Vy
LiBJIHNlZSBpdCBtb3N0IG9mIHRoZSB0aW1lDQo+IHdpdGggYnRyZnMvMTE3LCBidXQgcnVubmlu
ZyBidHJmcy8xMTcgYWxvbmUgZG9lc24ndCB0cmlnZ2VyIHRoZSBtZW1sZWFrIHJlcG9ydC4NCj4g
SSBhbHNvIHNhdyB0aGUgbWVtbGVhayByZXBvcnQgb25jZSB3aXRoIGJ0cmZzLzExNiwgYnV0IG9u
bHkgb25jZSBvdXQgb2YgfjIwIHJ1bnMuDQo+IFRoZSBnb29kIHRoaW5nIHRob3VnaCBpcywgaXQn
cyAxMDAlIHJlcHJvZHVjaWJsZSB0aGF0IHdlIGdldCB0aGUgbWVtbGVhayByZXBvcnQgd2hlbg0K
PiBydW5uaW5nIHRoZSBmaXJzdCAxMjAgYnRyZnMgZnN0ZXN0cy4NCg0KTm8gcHJvYmxlbSwgc2lu
Y2UgdGhlIHBhdGNoIGl0c2VsZiBpcyBhbHJlYWR5IGdvb2QgZW5vdWdoIHRvIHNvbHZlIGFsbA0K
dGhlIGNhc2VzLg0KDQo+IA0KPiBQLlMuOiBTb3JyeSBmb3IgdGhlIGJyb2tlbiBxdW90aW5nIGlu
IHRoZSByZXBseSwgSSBzdGlsbCBoYXZlbid0IGNvbmZpZ3VyZWQgbXkgbWFpbCBjbGllbnQgY29y
cmVjdGx5Lg0KDQpIYXZlIGZ1biBpbiBXREMhDQoNClRoYW5rcywNClF1DQoNCj4gDQo+IEJ5dGUs
DQo+IAlKb2hhbm5lcw0KPiANCg==
