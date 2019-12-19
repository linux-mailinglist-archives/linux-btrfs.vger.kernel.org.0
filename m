Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34873125996
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 03:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLSC33 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 21:29:29 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:46159 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfLSC33 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 21:29:29 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Thu, 19 Dec 2019 02:28:50 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 19 Dec 2019 02:28:09 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 19 Dec 2019 02:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHGoKSQ9V13ME2XB/pbNko6jh6ukMgzhtrDRrcDgnRXisFfxkC+CoHos6zu+AK0hjQdOxfzzYWhIIwxHQgvxgdul7oSJKwm15nTuuNe8qY3wy9qJbFO1N2vxJx4clqlzwC43l4+xNwHe5+VFmfwhpHsXrp5xY6zG2ZJ1YSnexeQr6U0CK4R6YgmNJNymOPd/Fq+XPZv3DfTwVZRVmN2eLqQGkUwYjf3muGS96XdUsRhZNWag3l37MOx8kGK3rXgXAKceZ2AN/UHfrRYbJg7cXHupFd0EqpAK8/mj9zg9lveBKXVy1t/1bsLE+/e54dqxi+bBzCqlyCqRw2vYhqmeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmfhrDhBSRdARyhZeDR7zXvnDveW7AVn/q8QGF26nEs=;
 b=Q9s8oBax65kbyJt3CPjyrM6oivQbTbo12Yi5cRGPqJHWiJQnbfADod8ILXpjN9KQdz5tblc9DD9wMFGgjVW4oql3YDzdZlTdQsudRHkKJcKA3CfRWsmAx9Ve9lBHSVRgWXf/k2nQh0juVDhGDXIEWrpSGAqA1Fb9d6OX/Rc/GclCC3KPXVeh5ETPRiFbx1f/Vuys+QMWuhLAvdYZmvkUhYao+xrzUP3P6SYHexoWIhTN507ctjFXdIld52kTI5OTH3z++dN4VVz+rBPfH0oVUp0vVFiXENRYppZq+qaH1RKsUJI0qJcrN3AAMFJjvqSQpIG4PGivRb2TJywjMOFe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from MN2PR18MB2685.namprd18.prod.outlook.com (20.179.82.223) by
 MN2PR18MB3166.namprd18.prod.outlook.com (10.255.238.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 19 Dec 2019 02:28:08 +0000
Received: from MN2PR18MB2685.namprd18.prod.outlook.com
 ([fe80::b47f:8d41:b41f:5308]) by MN2PR18MB2685.namprd18.prod.outlook.com
 ([fe80::b47f:8d41:b41f:5308%6]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 02:28:08 +0000
From:   Long An <lan@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "quwenruo.btrfs@gmx.com" <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs-progs: fix path for btrfs-corrupt-block
Thread-Topic: [PATCH] btrfs-progs: fix path for btrfs-corrupt-block
Thread-Index: AQHVtY4zdM4hdE+tGE6GxRti7p5S/Ke/wM8AgAD7+AA=
Date:   Thu, 19 Dec 2019 02:28:08 +0000
Message-ID: <1576722486.3774.9.camel@suse.com>
References: <1576665041.3774.6.camel@suse.com>
         <9ec76f89-bc1a-2bdc-7ada-12c3c0a7c258@gmx.com>
In-Reply-To: <9ec76f89-bc1a-2bdc-7ada-12c3c0a7c258@gmx.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=lan@suse.com; 
x-originating-ip: [45.122.156.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8232fe9-7f7d-4d10-b663-08d7842b15e6
x-ms-traffictypediagnostic: MN2PR18MB3166:
x-microsoft-antispam-prvs: <MN2PR18MB3166AA174FC8C2BF82FA3CB1C6520@MN2PR18MB3166.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(199004)(189003)(26005)(8936002)(8676002)(81156014)(81166006)(66476007)(558084003)(478600001)(91956017)(6486002)(66446008)(64756008)(66946007)(66556008)(2616005)(6512007)(76116006)(71200400001)(36756003)(316002)(186003)(5660300002)(6506007)(4001150100001)(2906002)(86362001)(110136005)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR18MB3166;H:MN2PR18MB2685.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TeWjpo5Tt9kDaykTP2XNmtVcXVNLHZe9dc34G9Vt8VmSUwtzuWISmncXiZ2yTFjRfkLHhQAuAGpYFv9UIcf04tMvkWY4XOrogZ7qBfEpR1tP06fpri/ABOFoSPZr74fgglA3VumflmtcmmaNdR1l1kKzOZVv/vlewQ/Z/e/3nIxiJEXmaUC1S4x1xFsxlOeI0K6qVTdhPV7NSEtX1Ufg9ZuyW4F2Q9VAzWk73oILdpMKj2sTB0KE8Lk+lvPyv3M38HSUPgHL0x6/J9fi70+w2/ZtywBU6ln70WoJj+QrEgWTm2SkbzOF/K6HZjr5oFJfXZm1nRmH7d55WgBksOmlQC7ajX3TdLMFMP7f/YiVNpu33Qmz2ZTjw1o54mjcHsnEaZ+deOWXOI25XQC3sZdtlY97RFkHsKU0JOCkfQm2PqVVJiPkf3nyPjXK45FDQ73u
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE46349A5F2FC14EB805F424A1C52531@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e8232fe9-7f7d-4d10-b663-08d7842b15e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 02:28:08.1426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7W7lX2HHXJmHjk/opUnQ9McENT2Elldz1o5BI/Yj8PRZa9z+OyBpkIJ+sPJU509j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3166
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

U29ycnkgZm9yIG1pc3Rha2UuIEknbGwgcmVzZW5kIEFTQVAuDQoNCk9uIFdlZCwgMjAxOS0xMi0x
OCBhdCAxOToyNiArMDgwMCwgUXUgV2VucnVvIHdyb3RlOg0KPiBPbiAyMDE5LzEyLzE4IOS4i+WN
iDY6MzAsIExvbmcgQW4gd3JvdGU6DQo+ID4gDQo+IA0KPiBJcyB0aGF0IG9ubHkgbWU/IEkgc2Vl
IG5vdGhpbmcgYnV0IGJsYW5rLg0KPiANCj4gQW5kIHJhdyBtYWlsIHNob3dzIG5vdGhpbmcgYnV0
IGRpZmZlcmVudCBoZWFkZXJzLg0KPiANCj4gVGhhbmtzLA0KPiBRdQ0KPiANCi0tIA0KQW4gTG9u
ZyA8bGFuQHN1c2UuY29tPg0KU1VTRSBTTEUtUUEgLCBBUEFDLTIgQmVpamluZw==
