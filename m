Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395FC27AE01
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgI1MjO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 08:39:14 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27065 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1MjN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 08:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601296752; x=1632832752;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=WBBqhtLrFYL7ukEyo5GtG7SW0qkYXg5I5tIaPJAhYZ58PxB2YXLnR0Df
   He//eTS9iI2mPJMAU9JVcDSIfrx6ExflEaw9n9De0TY8uuY8DBsCpl8JK
   Rps0heVRpboT+SyybIHHWmIejwDeUySJ2Q7jIaD663MBLJyYduf3JBUFY
   ssMCqGjmlpp4yk6YKtgJI07xvf8fs44qvY3DlcAIT2Uc6LVOnSJRk3KTJ
   HrW0YGc9VfLVzyMU0VtGvL1yn69B4c2TlGvDyzSLjuDbVZwSVqRz8RZGe
   VwlenPtYo0T6estw9NqSUKAgOeNIMP7lzJfhDuE0UB7t3OxkSGz5pTWDQ
   w==;
IronPort-SDR: 3YFSlgQL7rfe8x+cazIjxdzr6Bs1KXTva8HtJT30Wx12qsnSwxTVDah4e3+QA5SwYJotaLxCYh
 qIEUFBD8eKkABqpQQQ6r87qQKfnRGsVyAUULgxhkhx3o9XP4tlsn8WJIFFlidjRTSbO9HQtS54
 GBIOkE7dVXiebQrw+dqahYx6soZ5o2up1vLoVGQHpHRT9d1sZZdbJJjb8+vz4+E73i4oTOOpG/
 du2bzscqxqc+kXYVtNo1pTWvtPnM3NsspMMnlbqViyzgMgTosoexbCh3YmvXQFiWJnMxCGNeBn
 sPg=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; 
   d="scan'208";a="258163548"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 20:39:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AI5VqwpmJzDM6DUfgRfzf8JBgkVG4Xd42iKVLIhUjplYRA4L/DQJvB6qub2+hm1lolc5msc4G9+fZ1wZFWd3inqPO/JZ7sp8roaaN5uVB/eR3LsoV6ahifxXzfZbojRdFXkGYiZrU/z7Q599r4m+LrKzdmFU60B1uv+mLjfI6LuC9iXwxPHN/x3DSrps8hvii1jkE7BwKNQqC1o+zjQHkVul240qkY/thHnfv46PbkNT3JItRlPM8SFk31QZT9GKnzztj6BeQrQ/dhux0J6WGv3LVKjMCCii3j/Xr8goChkPUUrncSMzA0AyxhEOUjInKnVIkH2ahdvb8GEDyB6D0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ABk+Up1TkOkh1DzZmrp23UlEFzOt3cRc3LPLhHH+HnkVO9M+NtpsKGY5QVeEW43Xgxja4BG5tWZaFH1u6OI2SURkFBIZDUjZMR1tWKJvQOFG8IWSCJjjFWWHvlnWRiDB2r17RVBlSamgQlrQtaf9NfJ3ACZan8006Pz032ZSZ30EtzFAVdMOXK9KB31oLPuTf12TtyZ17afDL/+8OczHdvBQ+KqOO5P+XTl5hGxQRM/wdJWzNbWQjJodf2kt8ye+MnRFlTzLODZOUEWDM7qRlu9vbfZZEKyS+DkuiecwSuLr4njxI6BZX/cs4SK70yTjLglvKE+kxK5GDD0Zz+lgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=KZbmBiEJuvQIGLY+bSZ1VU3qQbI9bEFQ/BDKDKDuoZxEzfmc9qFcRh6p7Moe381wNTazYLUTttOaNy650HiNVz5y0MILC/oQf6Yb0qO2co4w74gg0MOu1BRKkPhD1SaWinvzCnuIsX3R3N6aYbBkVQgAtm58dIYZ92BlNWMmVIM=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB6459.namprd04.prod.outlook.com (2603:10b6:5:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 12:39:11 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089%7]) with mapi id 15.20.3412.026; Mon, 28 Sep 2020
 12:39:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 2/5] btrfs: push the NODATASUM check into
 btrfs_lookup_bio_sums
Thread-Topic: [PATCH 2/5] btrfs: push the NODATASUM check into
 btrfs_lookup_bio_sums
Thread-Index: AQHWkogES96U8R0bdkCD+QZOGXIVLg==
Date:   Mon, 28 Sep 2020 12:39:11 +0000
Message-ID: <DM5PR0401MB35914BF8B77AB8B966D7C1CF9B350@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <cover.1600961206.git.josef@toxicpanda.com>
 <bdf1bf5c65679fdf39021e16a242094acd71b270.1600961206.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:dd62:96c5:79f:bf52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76857b9a-1443-470c-1a54-08d863ab8075
x-ms-traffictypediagnostic: DM6PR04MB6459:
x-microsoft-antispam-prvs: <DM6PR04MB6459B10BC1ED34115ED8B9389B350@DM6PR04MB6459.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 19md/ovmaMg/sVEIDALYjHWMXzhAcgB67Z/NeAubKmtr4nKhoOsJd3LwvZ1/IOV70JEJVIgB16fivxkGTon1s7lwbeQ0ZuH1FD4/8dxK3QKdzWqcJXpYIPbqUaTy/6Lq4K+1XLCvr3cFhHy0zXrr6aat73aCYizFbubc8bCCaIBzXrtAyggplu68oAW6tI7pktvA89Bnqq0wNfcLTw19504WQrnh8SQGEObjZ9f6oFLXZ8SIU4jB9ozsk4oTN6cUvlhSfiiCfm10aPSSKUGPNkPOjedCT280RoIYBEOfZrrjRE8ZT7IYQMY+9Lirei7tjTZ0ZYfWNpoOazyClyetznphMIcx+AsWtl8gWOoIoO4TeYB/9TuYZH3o/Eecb9z1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(33656002)(19618925003)(71200400001)(478600001)(8676002)(8936002)(4270600006)(5660300002)(66476007)(76116006)(91956017)(66946007)(55016002)(9686003)(66446008)(64756008)(66556008)(2906002)(52536014)(186003)(6506007)(316002)(110136005)(558084003)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /r3RPuvF7tTI65n8ntLc56/U0Wxzu1fOAh38rJalCU7HaJ9ukGputCQNno1SwgK8OS/DVZ61hRks6D5/S2d04dnyyQXMWc5p1mzxxDRzZAg1KffoGmdQUlDAYENhYR/Dpn9S4XhTQgJzEXaByqex9M8pprFDOSoWDdJfpjamFQDQbTVU437DRCoT5Ex48YYBCHy8sawJr3aDFoZ34TssOCzAObsJ/yTTNwYBfAmwXCIGSBaIc14bbMpWBUBjT+YNzP9AC2QdWcY0Y6nWsgEHFLAtdUrtdGG8eynyac5ZZogEcbB2TE9fPeGcCQX09Ir0tV8liIMpH/NmOQy9U+uphkjmYeQdBlDIFIAzEy03m8Pcgn93mOCfR1OhLPKweQyw7Ykru9SyKBwdkVGVixhISnK+7lQHBRPOmbEffVDnAr1lVmZydLhvOz1TOnH6Tf82yTQY8aorIuI2brLvWYc/jkYrSeo5R1JQAkCFNZEVeAtKe/cI63KoXPmJ1k32RQJcWHaEPtve2PPeYaFq2uN9YBWG9wzu6b6bnYzJsu9fjgUlHScLuv4ts0ZBqjsoVkahddSscUOrb18P5sg6r13NHQDe3tG0BGIYIhAbVIVHQn7noXpH3qUWpcX5ApCpZiPJnBAAr6AhP5FGwvncllbt4h8zBItHwtjTSkMM/FaLmeEjh32Z3DH3PHD4MEWAX9gh2Hno2vWKFHH7JsslKQnl9A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76857b9a-1443-470c-1a54-08d863ab8075
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 12:39:11.7011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMBukUwTReh/QGuiRSv78pQrsuXbY0kbeGMH4F92rz7QpZTKc1Av/7ULJJuz1RK/bbH565RbJkDPqNUzHZYyQGBW62s0Ty80EdPPYtOZ3+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6459
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
