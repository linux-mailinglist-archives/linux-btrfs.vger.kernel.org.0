Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2EA86E9F
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 01:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404943AbfHHX4f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 19:56:35 -0400
Received: from m9a0001g.houston.softwaregrp.com ([15.124.64.66]:46803 "EHLO
        m9a0001g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404428AbfHHX4e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Aug 2019 19:56:34 -0400
Received: FROM m9a0001g.houston.softwaregrp.com (15.121.0.191) BY m9a0001g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Thu,  8 Aug 2019 23:56:19 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 8 Aug 2019 23:55:40 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 8 Aug 2019 23:55:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fc3xu17iYWYYxiinXJdrq3kIl9DZ1I427pzKg78+o2HygrQGPzw8HYFEQAGFe/wZajGbPv7jzzs5X9HcDDct05DpIML+H+DKipFy2UlNjoE07K2VQmemM2ozI529T+PbiYJXj7WJMfXectQelgytIIePz3QNgimnb2K0J3jQhsBgq4M1eOyUP2bMdlySWyBEJU3j1I3mZfy3zcB/XHTap05SmEc7yt2Sq2Q9T4CQsC2e7IJcPVksST+41N3YTSYN7vOyGxb3N5W6i4q5WLluMRn4Q2J22yJ+t0vDvS22Q8HRN9T0TEp3Lyb9wG8j+XfaRhHI05UGbpAYMv8Q2T+opQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V314AOjqzwbcB8f3Jjj9ElzUOgq+8F5yKpp1GhUksxo=;
 b=W2HOFAulQfb57ZvM09DllpMfaHvB5thwWlsyIQ/my90dVnR6fW+KlCAnrtTsuV5DAAw0JvUR7yw/dkW6Yezi9uvtgedjYTqPYEV7ZyQEKvnjuihsr9usxGiIJZLUPhT0i6Waq45dJ6NBruhcqCQTlzS7vBsfQiK98iTIDZvezrP06H+QWAygMEiPPsKO57EjcBha9tgzVvb4guoDFJkLnG8lw6MJ3ma4Ob3sDX0VbmcXHMmnPmUNYhRlQFGFHNOOc6Y9qX/Ad0f7w40PqMfXlrLIEzEtHReHpnI53Mviawghwz9wKTwokGAlNN7xFszzdulixUaz6XZTX5CkkPpDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3091.namprd18.prod.outlook.com (10.255.136.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Thu, 8 Aug 2019 23:55:38 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::e94d:d625:c907:d8a0]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::e94d:d625:c907:d8a0%4]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 23:55:37 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v1.1 1/3] btrfs: tree-checker: Add EXTENT_ITEM and
 METADATA_ITEM check
Thread-Topic: [PATCH v1.1 1/3] btrfs: tree-checker: Add EXTENT_ITEM and
 METADATA_ITEM check
Thread-Index: AQHVTfkehTuiaQagY0apuwFrqygshKbx7YgA
Date:   Thu, 8 Aug 2019 23:55:37 +0000
Message-ID: <23a97139-f304-5e01-6d42-5a05d9f5b62b@suse.com>
References: <20190807140843.2728-1-wqu@suse.com>
 <20190807140843.2728-2-wqu@suse.com> <20190808145407.GA8267@twin.jikos.cz>
In-Reply-To: <20190808145407.GA8267@twin.jikos.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR0101CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::16) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [54.250.245.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59f4e437-2d27-4c40-5905-08d71c5be920
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3091;
x-ms-traffictypediagnostic: BY5PR18MB3091:
x-microsoft-antispam-prvs: <BY5PR18MB309130C49BE9280BE7B39E05D6D70@BY5PR18MB3091.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(229853002)(66476007)(7736002)(31696002)(2501003)(66946007)(14454004)(8936002)(102836004)(186003)(305945005)(55236004)(446003)(8676002)(386003)(6506007)(5660300002)(66446008)(66556008)(26005)(2906002)(25786009)(81156014)(71190400001)(6116002)(3846002)(4744005)(64756008)(71200400001)(478600001)(6246003)(6486002)(476003)(36756003)(81166006)(6512007)(316002)(6436002)(76176011)(256004)(53936002)(110136005)(486006)(99286004)(11346002)(66066001)(86362001)(31686004)(52116002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3091;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vKb7gRKgGmFLn4tYgqZ8yOl7tzaUfmD4INbnjYY/HoValOxtr2kqrO6N/LCuUkphfLazVezzaMYwUlgk0qyhvxZ/HGAOCjR4RkY6koTtynxR9Z3ECwzVqBTnZL9wqmyPxZq6VtzAQjnFCnqWINMs+9KNsNd5nafIBY4n1hTKk/piFBqIdyEHqoz6vIz+e4Zl6gVoeZ5D4Pm+mO/WpHJyThjHOX9Mv2clCX0MiSG+kB+B/0lewz6nfU2PXgSRds4mBoIoFrdummGFBVBoP4XYxQq2o61GeLiz+5qJc8JINrqhxzcsnySM+tc17azp5ZnsSQ3PESGJjkNggU8tk4ePXrdg22Z9kGhK0E5fp0Zc93WcbTECDmyR6XCQJbyKshCHksTFvsl/tw/aBKQOy+ZF+V9LPLlwDz0ufIarzo5YRmc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <103713A2AB3CAA4DB506D5E3A6924F03@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f4e437-2d27-4c40-5905-08d71c5be920
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 23:55:37.7915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0IyCFYT4Yrq1uP7eQJi74eb9J0rGf/8ADO1Jt3dnAvSh3S8EmlVBGQa0/EHOKVI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3091
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvOC84IOS4i+WNiDEwOjU0LCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+IE9uIFdl
ZCwgQXVnIDA3LCAyMDE5IGF0IDEwOjA4OjQxUE0gKzA4MDAsIFF1IFdlbnJ1byB3cm90ZToNCj4+
ICsNCj4+ICtzdGF0aWMgaW50IGNoZWNrX2V4dGVudF9pdGVtKHN0cnVjdCBleHRlbnRfYnVmZmVy
ICpsZWFmLA0KPj4gKwkJCSAgICAgc3RydWN0IGJ0cmZzX2tleSAqa2V5LCBpbnQgc2xvdCkNCj4+
ICt7DQo+PiArCXN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gbGVhZi0+ZnNfaW5mbzsN
Cj4+ICsJc3RydWN0IGJ0cmZzX2V4dGVudF9pdGVtICplaTsNCj4+ICsJYm9vbCBpc190cmVlX2Js
b2NrID0gZmFsc2U7DQo+PiArCXU2NCBwdHI7CS8qIEN1cnJlbnQgcG9pbnRlciBpbnNpZGUgaW5s
aW5lIHJlZnMgKi8NCj4gDQo+IFdoaWxlIHU2NCBpcyB3aWRlIGVub3VnaCwgSSBzdWdnZXN0IHRv
IHVzZSB1bnNpZ25lZCBsb25nIGFzIHRoZQ0KPiBpbnRlcm1lZGlhdGUgdHlwZSBmb3IgcG9pbnRl
ciBjb252ZXJzaW9ucy4NCg0KSW4gZmFjdCwgd2Ugb25seSBuZWVkIHUzMiBmb3IgcG9pbnRlci4N
Cih1MTYgaXMgZW5vdWdoIGZvciAwfjY0ay0xIGJ1dCBJJ20gbm90IHN1cmUgaWYgd2Ugd291bGQg
dXNlIDY0SyBhcyBvZmZzZXQpDQoNClNvIHJlZ3VsYXIgdW5zaWduZWQgaW50IHNob3VsZCBiZSBl
bm91Z2g/DQoNClRoYW5rcywNClF1DQo=
