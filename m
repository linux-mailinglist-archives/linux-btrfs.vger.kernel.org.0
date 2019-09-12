Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF4BB0D2E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 12:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfILKsg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 06:48:36 -0400
Received: from m9a0001g.houston.softwaregrp.com ([15.124.64.66]:53720 "EHLO
        m9a0001g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730470AbfILKsf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 06:48:35 -0400
Received: FROM m9a0001g.houston.softwaregrp.com (15.121.0.191) BY m9a0001g.houston.softwaregrp.com WITH ESMTP;
 Thu, 12 Sep 2019 10:47:36 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 12 Sep 2019 10:32:15 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 12 Sep 2019 10:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kW4MoBxAGfqJEF879Wu5Ctlyqlfm2yJxYnTgosV8NgLj+0UZfPoscSCmAl8gfj7huSAd6ybmzoW7DmaBXwJRYR9Yq6sQyS/25QiAGdnxn1n5pt9azwXKJGvHIQvgVqrTnp4CKmwWZS/6g7KmfO8wLvZv4gCRUrVfSPrvqWbbZJRyDBK/S/bNzyraaL5HVw72Iy6iWpO3VBELgY2mJY1gVqdEdpiwV7XT80SDDcg15y2hRsZpxC8o3gDGyDjYgVGqctjN7oGgl0Hb7e0Xzn1Z+rw5ze7O4zE1lYuyFCf7l7vxwABDDETJqgvA+aKABeC90TT75PyZlIHc6RcSQ0QDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OClLW7gpKbCu0KuDjAZTSlkUoyHWEcpV4743RO6+SUM=;
 b=V8tS3/y33xqFaZOwHEFtWhygznS/OLNGDMTC7YrN7F1ozQquG3H2460nbhIELrnjrfRFkzNNKRkDoHBUTv0FTBJ0PNDqf+AYeVpMGzmvnIBAQRBcgktqCIK+C1tHOmdChvBVW8v371Jjsax6xNZnf42A2fi5iTrGM0Va9YyqWGyqXBU0x2OJPkQwISLZ50p3kpRiIO3NGC6jM2XbvFaXRyaXGTPTKY9xREw7ojEl9xVBhzJLKIybbc2XT4xNtx+sNsWpUBZYiSgUeR9RMKxkyUdmOguk5mZwKbuSf+jpKXxwSgpuhetauuvI066MG9p7PetizVwJ64tnPYqibg/CCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3090.namprd18.prod.outlook.com (10.255.138.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 12 Sep 2019 10:32:09 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::3993:1f66:bd4:83cc]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::3993:1f66:bd4:83cc%5]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 10:32:09 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: volumes: Allow missing devices to be writeable
Thread-Topic: [PATCH] btrfs: volumes: Allow missing devices to be writeable
Thread-Index: AQHVaVSrv5HVTv4sg0OdBx9N7oyxYqcn1+yA
Date:   Thu, 12 Sep 2019 10:32:09 +0000
Message-ID: <25e93ff4-6252-1e39-f60a-89134129c00d@suse.com>
References: <20190829071731.11521-1-wqu@suse.com>
 <7e9294de-1859-886a-3ac3-9659e70463d7@oracle.com>
In-Reply-To: <7e9294de-1859-886a-3ac3-9659e70463d7@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYCPR01CA0108.jpnprd01.prod.outlook.com
 (2603:1096:405:4::24) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a949bc1d-d3e8-4b96-288d-08d7376c7748
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3090;
x-ms-traffictypediagnostic: BY5PR18MB3090:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BY5PR18MB309004C169E33C544E4BC623D6B00@BY5PR18MB3090.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(199004)(189003)(36756003)(86362001)(31696002)(31686004)(5660300002)(966005)(2501003)(256004)(6436002)(6486002)(4744005)(6512007)(6306002)(99286004)(81166006)(81156014)(8676002)(229853002)(486006)(476003)(446003)(11346002)(8936002)(2616005)(6506007)(386003)(25786009)(102836004)(76176011)(52116002)(53936002)(478600001)(71200400001)(186003)(71190400001)(26005)(66066001)(66446008)(66946007)(64756008)(66556008)(66476007)(305945005)(316002)(7736002)(2906002)(110136005)(6116002)(3846002)(14454004)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3090;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5Pf5C9n7r5ca83+e8Cq0YZQTZTY2cJljqRu23YG9n751O/HvZkDSTbXnCY7Jl2tIoz3zNg/pMuKcrRNuhdb0eeXskWOvVRAUW3y2zn/a2+i6OVGtMNyDr8fMDDeoxY0P1jSkbHJBSViIGY6j/f+s93BFSqn3W3lqyBxukWwXTGCaJk3Fu1hTj+HRxBxYwAF+8Kbpi6ErpFGQYv6/rLK+594ozRWIfYKwVfIw6VBfZk0wWq7p4sw/+jVoRkhbWeX6jKoqvclinAfoEX0ekZi6dvT+frGGME/4E0ab5IEsHIj6nTtGof8FLC+BU8X7FbSVAAzmA9QthLSjqvDOIcpRSviE+gIjG7e1WE8WmDrAAPTwOXdpiB0RZOiVqVKuCw4S/xiJGGvQUVv7GZP76Q/8z2An/YiKuEed4fH61YwfNy0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9469BBD1282CD54C9592BF139E2737F4@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a949bc1d-d3e8-4b96-288d-08d7376c7748
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 10:32:09.5126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shGprCIPEUh6NB5K3HnPpDB+wAIPzTK6gDSsGYI062BT417y1TKu2Cux4Qa4mNph
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3090
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvOS8xMiDkuIvljYg2OjI3LCBBbmFuZCBKYWluIHdyb3RlOg0KPiANCj4gDQo+
IFRoZXJlIGlzIHByZXZpb3VzIHdvcmsgWzFdDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtYnRyZnMvMTQ2MTgxMjc4MC01MzgtMS1naXQtc2VuZC1lbWFpbC1hbmFu
ZC5qYWluQG9yYWNsZS5jb20vDQo+IA0KPiANCj4gDQo+IEkgZ3Vlc3MgaXQgd2FzIG9uIHB1cnBv
c2UgdGhhdCBtaXNzaW5nIGRldmljZSBpcyBub3QgcGFydCBvZg0KPiBhbGxvYyBjaHVuaywgc28g
dG8gaGF2ZSBsZXNzZXIgaW1wYWN0IGR1ZSB0byB3cml0ZWhvbGUgYnVnLg0KPiBNeSB0YXJnZXQg
aXMgdG8gZml4IHRoZSB3cml0ZWhvbGUgZmlyc3QsIGFuZCB0aGVuIHRoaXMgYW5kDQo+IG90aGVy
IGJ1Z3MuDQo+IA0KPj4gW0ZJWF0NCj4+IEp1c3QgY29uc2lkZXIgdGhlIG1pc3NpbmcgZGV2aWNl
cyBhcyBXUklUQUJMRSwgc28gd2UgYWxsb2NhdGUgbmV3IGNodW5rcw0KPj4gb24gdGhlbSB0byBt
YWludGFpbiBvbGQgcHJvZmlsZXMuDQo+IA0KPiDCoElNTy4gSW4gYSAzLWRpc2tzIHJhaWQxIHdo
ZW4gb25lIG9mIHRoZSBkaXNrIGZhaWxzLCB3ZSBzdGlsbA0KPiDCoG5lZWQgdGhlIF9uZXcgd3Jp
dGVzXyBub3QgdG8gYmUgZGVncmFkZWQuIEp1c3QgdXNlIHR3byBhdmFpbGFibGUNCj4gwqBkaXNr
cy4gVGhpcyBmaXggZmFpbHMgdGhhdCBpZGVhIHdoaWNoIGlzIGJlaW5nIGZvbGxvd2VkIG5vdy4N
Cg0KU28gcHJpb3JpdHkgY29tZXMsIHVzZSBleGlzdGluZywgYW5kIG9ubHkgd2hlbiBpdCdzIGlt
cG9zc2libGUsIGNvbnNpZGVyDQpkZWdyYWRlZC9taXNzaW5nIGRldmljZT8NCg0KPiANCj4gVGhh
bmtzLCBBbmFuZA0KPiANCg==
