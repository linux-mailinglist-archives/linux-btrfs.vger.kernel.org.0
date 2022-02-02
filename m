Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835364A6993
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 02:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243288AbiBBBSh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 20:18:37 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56557 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiBBBSg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 20:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643764716; x=1675300716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ITCecikmyl+INlXWaAVHuPvq1yB3hyWIm/DhtSNrIV0=;
  b=KVnqTEsduaQzNUHCnrPBkyT+5aa7/T81VGbSqzfg71szIOxnqTrKR+BH
   d991I3SB0Aw3x3zCYjo+Uqgk0LQNOcAc+eMk8Ri4XzEGqgRxfxpaQAw5Q
   eTzbALNqtAG/OegrHxyHsPigD10OVeMKFrBjpX7qF276VbD1I1MiRNBhx
   vztFP6Ko0+iOOtHFYcnD7FubyrtN9pW+Z/rYta0OGuLJSxG8ZQ9cxRjgR
   YDKFNQxvkOSmsFUNdSJtOYXUViBXvPrK+umn3F/9PZbiD3dR0YuqSoz+q
   P26oksYgsmEwmEH/+L3EC2X8HH/5K0yb6N9j+FSkorUwItH5ns5r8VCFF
   w==;
X-IronPort-AV: E=Sophos;i="5.88,335,1635177600"; 
   d="scan'208";a="296022304"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2022 09:18:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IchkCWi3AJe1aLdYYPW05tDheRG6y7IqbnNP4SJBccFaryrSl55k+UPj7yOGAru4oHL7+JZDbJZZoD1JsM265G5t2W/svnsqWmjCmRnf4hI7BZDEUI5gSMW4irumiaohOpTNOxulAXvbYR2VcTll8Zs9qWQq9TjQxxVhfNDgp40cOzATW066HR1T+RonrDLIqcAdobCQix/JMMbb1S+tE9fZlkjAg4hjMfGikALrGE+KRu2ROEFblQYQJxspPBQq6+oPPCcb6E4lMYUCgF/zmDjpKf52zbUOZY9eRfBtDp+JfGoEYsOcj0xwL8vxDuvSfeD47V3NrW+9EK72SZoq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be7ZCuTcXdOX/i0bJjk5EcpaOOEUr2eFdEd0b1lVW6E=;
 b=PmT8pxXgnpnOTjcw9TuxajC6834c8oKvaWxqQ1/taMKo/bmIxCT0x/E6EhAZrxfVfD4PjlovNux5j3Auyw/bdTk4UNLYdZls7A+LCaV7zWe3oCAQF3F1LjmdJRJ71OX/a2zBfr8e8FmKi1soJOvVrHkb3ZAnkbCO3QdQW+FnRADMNAdohiMc9mKIVzSZS/RW6gceguhSm8rbRFsRdhzF2iM34VpmTBuZnMO5BgPJLqw5c9EsRmZFqLyZG4WXFINSMxB+aP0iY55SLW/JzoEciEGCF60kkXb1g6c455DvIUhXSnHrpv4T1nYbqsMRhnnf0Ivjh8758RYLTVnU+4IjwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be7ZCuTcXdOX/i0bJjk5EcpaOOEUr2eFdEd0b1lVW6E=;
 b=nVE6Anb1k8FEmIOIkTzlhtU2fyXh2LlhzUcSTt4HCbbbvrvz4Mcl8QCzmJ/4C7Zy6VGvtWZg891dEhoj7d4MeLlKHrNYTvxg81j9JRlRSB/uFmjI4kUWFYtQ5ljkByJ+LmetuOhNsTQR1yEBi9udyOZBPMBRDUBF94fsMopfBnQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB8038.namprd04.prod.outlook.com (2603:10b6:8:9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.18; Wed, 2 Feb 2022 01:18:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::8c78:3992:975a:f89]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::8c78:3992:975a:f89%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 01:18:34 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/7] fstests: fix _scratch_mkfs_sized failure handling
Thread-Topic: [PATCH 0/7] fstests: fix _scratch_mkfs_sized failure handling
Thread-Index: AQHYERMNsdBfcCqLskas/4gdSNM2gKx/g3CA
Date:   Wed, 2 Feb 2022 01:18:34 +0000
Message-ID: <20220202011833.edvx4crfkfm27jvf@shindev>
References: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c49b38d-543d-4772-7c3c-08d9e5e9eeca
x-ms-traffictypediagnostic: DM8PR04MB8038:EE_
x-microsoft-antispam-prvs: <DM8PR04MB8038C9E0CC555F01B6F11520ED279@DM8PR04MB8038.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxDcKrC4JC7WWVN+S9pj3Otk6BoBh3tfGxQfpmBHkc3J5vUqg7hlDpTXl8xJtrnlA7rlHnxzgLGhCHuvn4bvgwZIphg5jCSigmCG4N+4NxxvTdTc/F6RDHBiJQhiQsaNBLSHj8G58avrOXqXLV02at4Ls8veGEa0zJ1NCC0BG16YTiFEUC4dAOZZphesYI8sFwgw/6HnoIqURgee35XQDN/6QTKJuYZf/XEGtjhDrdEP4Q2vciRNCutPVDnCE5YrsWsH6hayhFT8rGrXcZk04tDb4lP4GqOa1+3gykmIfVO9TjYhOTW7gCXS8yfabH3DILu2Ei/iLJE/ynkYnmrNNUMpeL2Soe9ZdK1NqsGkxjbULdYvkkUpoHMnBv2t+13ZjOjxXHpV1OULtiiCKB1dmSps/4cuUcNDLIyZkW8WiD46ukajB/obMHganpg8hJyGjZ4VXjPtC0+qefHibMHT6wUifYV2wskNA7UCtn5guLBT8msOERLtn5d4xm8EP3fBt9pVFT7c5i60v20fj7PbZ0JfbQm2fIXj7wics11hSCV059HO4Vd2KvXw9izXbLLz3barwYud4yaVDOXQwnNfjykc2Zs8PmreNOOKrDQrU8uin3UR/4TlQX4nsXWVMeZxd2lXBWV9Cg6tx11A0ziej5vQS+yi6r0FDngdIWMhP73oguYW2/AzqlQc+kHeBlRl/IuScD7EI9ZPQPOEebs8kA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(44832011)(82960400001)(6916009)(33716001)(316002)(9686003)(6506007)(83380400001)(2906002)(122000001)(54906003)(6512007)(66556008)(26005)(86362001)(1076003)(186003)(5660300002)(4326008)(91956017)(450100002)(76116006)(66446008)(66476007)(64756008)(66946007)(71200400001)(8676002)(38070700005)(6486002)(38100700002)(508600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?trktLLsBZeb42i3Zt2tf0PBRuDSJvU8EAEBMcrtoxyP0vPJPlcitguqY77jq?=
 =?us-ascii?Q?sgsHk0ImhNPcyfIzdJa9J8AWTxS+Opc917YWi/xWI6re6SCbJkvESEvaJfdn?=
 =?us-ascii?Q?z2grw+adgI6HiqN27pSf+rHbR1H+y3EDKMyRRQYDHdlYh2EYlCiCOmuEFUEp?=
 =?us-ascii?Q?mJsuKwUb0ZT1D4ffibTtUDCqNUbe4TICRS/yEn0cSePS7VFD90syZ00uOFaQ?=
 =?us-ascii?Q?3H579jc6Uk+I+vgzp0/6ft9fLp3IHS4tEzULO8/J1ZdHp8UyPCDuwPPr6JcE?=
 =?us-ascii?Q?8Oi89VMA0r4nRXE+auzXLe2XuK4NuYZtdd1ufPthSBTqNqTp5PLQlhMNLuev?=
 =?us-ascii?Q?5S3BO5miInEJywfIjl5+Zk2vu+qoCDwRu1TuR70XzNOZmLekLUuvXFAoxvTt?=
 =?us-ascii?Q?OG79vywGGKNxG5hHI7u+HivqsuIYpCzAXDOi/0mr8g7cx2z4E1QCD1UH+n5y?=
 =?us-ascii?Q?gYCJWi/gTGz2VNu8MXKWxAe58huXtaPqLC7Y56C6kJyHROq664s6phUoBJ4L?=
 =?us-ascii?Q?va/XN8+67GpRySDihz017AIg2ewoZGKwb0b/ZMtZwzfRLCBbeAT7ZFXvyD5A?=
 =?us-ascii?Q?w7Y0jd3QFHWBt202sD+gwAG1cjxL1AtxviLxvWNWI0A5R2uKtLgMQLif2RXE?=
 =?us-ascii?Q?2z0trjTDM775jqWVGF3uhr4NTGzEhQQqf1/XnwWKzwyJwqD8tkZnFE0ZlaA4?=
 =?us-ascii?Q?I2BuS3S1V+dOcH5DnScdeiqWhSZ8Pt7f5lG/mj1F2wXvIJb2/2xWZKrQI/b4?=
 =?us-ascii?Q?8Ub6LAUZaBwVxaPapsWuI62Xq5l0yOTd/yj8RjkLylNnKIjQV6XcByOdiUhG?=
 =?us-ascii?Q?lzWSjxlm22TBASb9/H9g5F0X4HifUwIM5VtqEGna1aSUoFVMwy2P41ZKzskF?=
 =?us-ascii?Q?9FB/OykRdTyfNOjGYztlf7vMo81SUd3Hh04ADt3K1rMvN/hAGZ4lChZym+Yf?=
 =?us-ascii?Q?WJnF01glZ43y159dLlfWT085PZvXjWpYODgvH78PvmLiEQeYjMXfATBDsz/i?=
 =?us-ascii?Q?9ZRx5q6Q8g+vQU+PtWFrnfAfsTkKqtElh3XWh+zGStXqbAnAEO6x1dYPlW9i?=
 =?us-ascii?Q?zLIIKLpun9H4oiqNw23jprw55Oa/KSSe4XvqzUaybMUpQiW+dV+IEFa/Wofo?=
 =?us-ascii?Q?cUWBdLrdObDSlNM+ooqH7WIiH7rasvrVsiP4l4IPM21RIARTRTgpHiLTFSRE?=
 =?us-ascii?Q?9drXR4/2W92s9Bfe9aUVAY67VgJ0qZXuzbgqevm8/SdKQffR8zBquvYYCvvG?=
 =?us-ascii?Q?W8SDYxKL/HHT+QLDVfX5CWgMbducRWtHti47X2/0PHBAKTah+H9Uxe8ks6ym?=
 =?us-ascii?Q?STJ0P6FUoUDUx8RJb3uIJZyb7saHqSnJaY7m90So9iW25HPFGuzF8ZIiLRvM?=
 =?us-ascii?Q?2tCxC/DDa1wN2zcmiiEwBNBKTF/TNyrF18PmXcRl66e3w+eFtc2VS5XNalRL?=
 =?us-ascii?Q?U6VLQhZR+TZFUm+7PoDB7ZEsjksO8s68zVFBDyKZoi/lm1z+ZaB6YH4TAixD?=
 =?us-ascii?Q?uk/KwxeyPlKOcL6a/F+AI3blv8tddNlLm8rmnZqL0Kj04crxph7kEdQNVMPe?=
 =?us-ascii?Q?w6WVZM+XK8q6WctjX7Zrjpn9hAUbfglunHWCN5XfhqacDakDSP9nomlkdCMx?=
 =?us-ascii?Q?0rAhpdQB29mhbWxzlLRt/9qo4Ilb7ibuRQcIuQ9V4tv9IpV8XzGzPw5djeES?=
 =?us-ascii?Q?3c+NHYxXAsvyZxRxu9lKTSud8hE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <611AAC195F170E4FA1377B45752CC373@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c49b38d-543d-4772-7c3c-08d9e5e9eeca
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 01:18:34.5398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMvOcxVPWXX95E2kKMB857loJPImornOtgGoZZgREjSQ5RFAKiUxb/fML1/F5sa5WvHPWSCyYNlo1PFknJOhGYHaxhYoTD/3gdxXsHEFFQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8038
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Jan 24, 2022 / 20:10, Shin'ichiro Kawasaki wrote:
> When generic/204 is run for btrfs-zoned filesystem on zoned block devices=
 with
> GB size order, it takes very long time to complete. The test case creates=
 115MiB
> filesystem on the scratch device and fills files in it within decent run =
time.
> However, with btrfs-zoned condition, the test case creates filesystem as =
large
> as the device size and it takes very long time to fill it all. Three caus=
es were
> identified for the long run time, and this series addresses them.
>=20
> The first cause is mixed mode option that _scratch_mkfs_sized helper func=
tion
> adds to mkfs.btrfs. This option was added for both regular btrfs and
> zoned-btrfs. However, zoned-btrfs does not support mixed mode. The mkfs w=
ith
> mixed mode fails and results in _scratch_mkfs_sized failure. The mixed mo=
de
> shall not be specified for btrfs-zoned filesystem.
>=20
> The second cause is no check of return code from _scratch_mkfs_sized. The=
 test
> case generic/204 calls both _scratch_mkfs and _scratch_mkfs_sized, and do=
es not
> check return code from them. If _scratch_mkfs succeeds and _scratch_mkfs_=
sized
> fails, the scratch device still has valid filesystem created by _scratch_=
mkfs.
> Following test workload can be executed without failure, but the filesyst=
em
> does not have the size specified for _scratch_mkfs_sized. The return code=
 of
> _scratch_mkfs_sized shall be checked to catch the mkfs failure.
>=20
> The third cause is unnecessary call of the _scratch_mkfs helper function =
in the
> test case generic/204. This helper function is called together with _filt=
er_mkfs
> helper function to obtain block size of the test target filesystem. Howev=
er, the
> _filter_mkfs function works only for xfs, and does nothing for other file=
systems
> including btrfs. Such preparation unique to xfs shall be done only for xf=
s.
>=20
> In this series, the first patch addresses the first cause. Following thre=
e
> patches address the second cause. They cover not only generic/204 but als=
o
> other test cases which have the same problem. The last three patches addr=
ess the
> third problem. Two of them are preparation patches to clarify that the fu=
nction
> _filter_mkfs is xfs unique. And the last patch modifies generic/204 so th=
at xfs
> unique test preparation are run only for xfs.
>=20
> Shin'ichiro Kawasaki (7):
>   common/rc: fix btrfs mixed mode usage in _scratch_mkfs_sized
>   generic/{171,172,173,174,204}: check _scratch_mkfs_sized return code
>   ext4/021: check _scratch_mkfs_sized return code
>   xfs/015: check _scratch_mkfs_sized return code
>   common: rename _filter_mkfs to _xfs_filter_mkfs
>   common: move _xfs_filter_mkfs from common/filter to common/xfs
>   generic/204: do xfs unique preparation only for xfs

This is a gentle reminder to ask review by fstests community.

Let me add CC to linux-btrfs list, since the first patch is for btrfs testi=
ng.

--=20
Best Regards,
Shin'ichiro Kawasaki=
