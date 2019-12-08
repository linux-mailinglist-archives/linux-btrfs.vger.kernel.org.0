Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C66E116019
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2019 02:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfLHBWU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Dec 2019 20:22:20 -0500
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:42338 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbfLHBWU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Dec 2019 20:22:20 -0500
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.146) BY m4a0039g.houston.softwaregrp.com WITH ESMTP;
 Sun,  8 Dec 2019 01:21:09 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sun, 8 Dec 2019 01:21:26 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Sun, 8 Dec 2019 01:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISD3WUS1arPII3cUrxtn1b0bsRm7jVG6Qi2eLdKkZbp6sudPQHh21jzgtXRK+NrPpoyPqHLMWi25yvoyS3LeHwh4Zw+gCMCQPryA9/ztIrcBnLmJpXFHCLXGU+U1nW4JYdTKelEHEKBOrK79OpTSj1/7SayC+2IDPiHWyAHMDw0hL5cmQJX+S4/ZUeVQxhJE0cRtqBViOjox4khGMy3GmFEBfnBVsrG1CnGEDuBJN1HCCbq95NIU+yKG/8sadq85GHJKGKE6SXvI4IUboi6k7OnsNFcp8ILrQ6If2YNl6/vH6cC3mtzEf2pp2fzfc5D0DkDq0SD6ciOzxBruNUOMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHiUzIJEnCG+UGRTPURCCHPFBojglBsG6iA+VAq5qa4=;
 b=n/iCCnI4acvUhpWqNY8XZUOx4D4CCQv2eNiSXNesRCA6ZxLGxpQ2biKqGALDnsFqFLSzDLjwF6nZJRiYq5sJeFm3+HKaJI0ko84wnDvryqkTx7+lchyvmfkn1XmDtzJ5uyuOd13OHxPUzPql6pmpQsHQM20Vc3jho3+9QJiPSk62/3yC95nVWUs6mtwBF0u9My4ycGdRNMPVYvGJxmT8uS7uSn/DaKcI8cc8YYBYErF0fJwQElTYvw+ptJN07McFim4Wcu0wgUntQMBShgb8wS4TCpAHc9Pcl9Vw0xer1/J1qZ8J9fIbNDg6vc9rDqzOaELyrKWLGWtpVlIWu+hV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3364.namprd18.prod.outlook.com (10.255.136.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Sun, 8 Dec 2019 01:21:23 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::c9ec:d898:8be0:9f69]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::c9ec:d898:8be0:9f69%5]) with mapi id 15.20.2516.018; Sun, 8 Dec 2019
 01:21:23 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     Christian Wimmer <telefonchris@icloud.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: Skip device tree when we failed to read it
Thread-Topic: [PATCH] btrfs-progs: Skip device tree when we failed to read it
Thread-Index: AQHVq/xC+dx/2LdZ/Eq8Tf2kyejniqetTcsAgACSDQCAACouAIAADFAAgACPOgCAABK8gIAAKvwAgACQToA=
Date:   Sun, 8 Dec 2019 01:21:23 +0000
Message-ID: <e461ee1a-dc24-dcde-34b5-2ddd53bb1827@suse.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <BF872461-4D5F-4125-85E6-719A42F5BD0F@icloud.com>
 <e8b667ab-6b71-7cd8-632a-5483ec4386d8@gmx.com>
 <6538780A-6160-4400-A997-E8324DB61F69@icloud.com>
In-Reply-To: <6538780A-6160-4400-A997-E8324DB61F69@icloud.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0078.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::18) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ca8625b-b1a3-4b3b-2bcb-08d77b7ceff0
x-ms-traffictypediagnostic: BY5PR18MB3364:
x-microsoft-antispam-prvs: <BY5PR18MB3364B58313821BD7666C2D04D6590@BY5PR18MB3364.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0245702D7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(4326008)(36756003)(2906002)(8936002)(102836004)(31686004)(26005)(8676002)(6512007)(76176011)(186003)(229853002)(5660300002)(71200400001)(71190400001)(4744005)(6506007)(81166006)(81156014)(2616005)(66446008)(64756008)(110136005)(316002)(66556008)(54906003)(99286004)(52116002)(66946007)(66476007)(305945005)(31696002)(6486002)(86362001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3364;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QHR50LJB7XoGvsdvbM+VvgT1CGADm4XGCQ/tZhlp1CaBi5L97ByXL4hoGH4jwKTI1UyGigWNNhlv7viKw1GMgSLGBnxrcM5U2bzRLHt2zrOQIe70ADu0ymZs7u9wtqKanJdz+XLzc92EBjy/uW+8Xjx8vqHiIEs/aV0yCkZn7rduuiTUCGLSjo4PcydyorjnSGcvf0NKE6dC9nA9T6ZPBrD1ty8OaRL2+Zvg+rfDNNix9t2ZxAR+foZHFPYgMc7updZASzK6P5LaTRWc+MzubTWnV6qaIzqoGyKUWIIR/hrjcoxIny+z5+CJDgfsptB0lXq3CLDSCtSd7gjFFkaHRBKGcD3MUwglAv8RqRZbWlxmnKcQix878s8fSpte6j269QDaoxvdoG8uDthLIB0wZHWMgQF5/uZ0wAunJCh7LdBaM70II3pR1i6pMGj8aPKs
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A455CC352243F419D1976ECFB9C4E96@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca8625b-b1a3-4b3b-2bcb-08d77b7ceff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2019 01:21:23.2427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkeACFcnCzYTAp/mpPcos4pfrfkii6JglUYa6Fg7Sg5gzjTmjEVcjAJWjOaD7M+9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3364
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvMTIvOCDkuIrljYgxMjo0NCwgQ2hyaXN0aWFuIFdpbW1lciB3cm90ZToNCj4g
SGkgUXUsDQo+IA0KPiBJIHdhcyByZWFkaW5nIGFib3V0IGNodW5rLXJlY292ZXIuIERvIHlvdSB0
aGluayB0aGlzIGNvdWxkIGJlIHdvcnRoIGEgdHJ5Pw0KDQpOb3BlLCB5b3VyIGNodW5rIHRyZWUg
aXMgZ29vZCwgc28gdGhhdCBtYWtlcyBubyBzZW5zZS4NCg0KPiANCj4gSXMgdGhlcmUgYW55IG90
aGVyIGNvbW1hbmQgdGhhdCBjYW4gc2VhcmNoIGZvciBmaWxlcyB0aGF0IG1ha2Ugc2Vuc2UgdG8g
cmVjb3Zlcj8NCg0KVGhlIG9ubHkgc2FuZSBiZWhhdmlvciBoZXJlIGlzIHRvIHNlYXJjaCB0aGUg
d2hvbGUgZGlzayBhbmQgZ3JhYg0KYW55dGhpbmcgbG9va3MgbGlrZSBhIHRyZWUgYmxvY2ssIGFu
ZCB0aGVuIGV4dHJhY3QgZGF0YSBmcm9tIGl0Lg0KDQpUaGlzIGlzIG5vdCBzb21ldGhpbmcgc3Vw
cG9ydGVkIGJ5IGJ0cmZzLXByb2dzIHlldCwgc28gcmVhbGx5IG5vdCBtdWNoDQptb3JlIGNhbiBi
ZSBkb25lIGhlcmUuDQoNClRoYW5rcywNClF1DQoNCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBDaHJp
cw0KPiANCg==
