Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F73D124567
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 12:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfLRLL2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 18 Dec 2019 06:11:28 -0500
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:48578 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbfLRLL2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 06:11:28 -0500
X-Greylist: delayed 1630 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Dec 2019 06:11:27 EST
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.146) BY m4a0072g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Wed, 18 Dec 2019 11:10:31 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 18 Dec 2019 10:30:43 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.8.12) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 18 Dec 2019 10:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HM4AGmvvJraB4ixcNV2XmZyREXFq1o3CRpBGUdJn5shYNXDTMKKFQxDGdt4DnJ39mFDzC92DCC6YnB4tUFs0b10d193B11wp9R1ZnqfYzl7nutTzwK2/KuNbnWCVnbNVWyg4xN9ID3rmjMCoTxf/YdvxdF6/zeYZ/WlwnPhtvwUOS39qFsiNC86W3gcy7L1u2PnCx7KmUEWelkTVX+OSnujdHXleOOlVa37XS4RQ4XAuDSeq2K31IllKqDtUL2W9Ulc02Pm5K9Ue1SNT6AKYVw4BZSPIDTIHuNKKo7RIhTzGqNyOvzEV/rTwEMH4PnqgqZvLCuLkbZ/5cr222fl2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=Ce8RJmULBZGM6AaltZvPktw3Z54xtkneJwTodtFO1DBfppf8us4elTFshzUr7ysdYklJnvpVZzbe2yWeiSv1dQVUV6l7xaB6kQDLURg94+wPeftIS9Euku3lQQuvkJW+RbwMIWdwzniCPJNPZIPhz37cxSUgR2Y15PQ2vVLqGoMHRq7x5wpTpnel5oyHV0fdnn+stBmHCe7V+8+uriC6w6fI7OkB+cKlbu4y7RAaYUK2x7SE8KQE9o35Z6y0RPbNmbkYeSkFEbs0Pj1CtdcfvvKE/szQSJuXwZzrw55JE5wt/Y85kJKmnlz2Lnn0UW9I+c5oleX7+tQdLgVpEWtSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from MN2PR18MB2685.namprd18.prod.outlook.com (20.179.82.223) by
 MN2PR18MB2495.namprd18.prod.outlook.com (20.179.83.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 10:30:42 +0000
Received: from MN2PR18MB2685.namprd18.prod.outlook.com
 ([fe80::b47f:8d41:b41f:5308]) by MN2PR18MB2685.namprd18.prod.outlook.com
 ([fe80::b47f:8d41:b41f:5308%6]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 10:30:42 +0000
From:   Long An <lan@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: [PATCH] btrfs-progs: fix path for btrfs-corrupt-block
Thread-Topic: [PATCH] btrfs-progs: fix path for btrfs-corrupt-block
Thread-Index: AQHVtY4zdM4hdE+tGE6GxRti7p5S/A==
Date:   Wed, 18 Dec 2019 10:30:42 +0000
Message-ID: <1576665041.3774.6.camel@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=lan@suse.com; 
x-originating-ip: [45.122.156.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa31a6d8-22a0-4952-de0a-08d783a555d3
x-ms-traffictypediagnostic: MN2PR18MB2495:
x-microsoft-antispam-prvs: <MN2PR18MB2495BDBB0884EF4A416A5E8EC6530@MN2PR18MB2495.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(8676002)(81156014)(81166006)(103116003)(478600001)(36756003)(316002)(26005)(86362001)(6506007)(73894004)(621065003)(6512007)(64756008)(66446008)(66556008)(4270600006)(66476007)(76116006)(91956017)(186003)(66946007)(8936002)(2906002)(2616005)(6486002)(6916009)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR18MB2495;H:MN2PR18MB2685.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h1HHqwYohg6rmZeWgc+fLd9DPGw5hdcdhz6Da9Hs2A4ucBxiPH+OCuF3PXJwJc2wIWiJr45j9xnTHscGLuSWWA52SFUPIjPz0MT4uZnOPaiT3XdiXzj5+AatSFAxq09OypE5cADZLx2lPOmueQbKYwiWOrxtZWrVY0VCFbgMyBb5mmgcpaR9S2kUDCYjar8xM/LCKP3AMkMOUpxzcA6KwX0k50aZS+kfC1Pvu587BXWX4u9HS3Ec9tMXQ0txl7y+o3xkA4BA0pMgQWCyGr3tkOFf1PGKfzvPpzI5KKwzqNjNi7rGVxfcJFv316YQ7vRz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fa31a6d8-22a0-4952-de0a-08d783a555d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 10:30:42.7606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/Wyeig4VbRVx7kwlSiRx6tylV6BXM/97v4gCfykxcy+KzzmxY5kVpQsOrnSOdM0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2495
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


