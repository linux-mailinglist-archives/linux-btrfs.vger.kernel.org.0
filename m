Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CD133FC39
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 01:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhCRA1y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 20:27:54 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245]:9030 "EHLO
        esa1.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhCRA1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 20:27:46 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2021 20:27:45 EDT
IronPort-SDR: C2h+k8a/SGAfCzWeG0Bv4N+B1xv8tjQNW8jMl2KeVp5uaLuBuDQk67HdGWs4eNjouq7p9XJpNg
 IuM1/HgeSUGG1a2CAen9TMpp5NlNDzHNtGPnGjvNFGXJOzKriDB0LAPPI0cdOH6F9dI4xY/O6R
 7L+1wkaZ7SrsADDkjgFmbA0+AGTz4MNRo1nZDRbb5EtuYNaS8YjGeD/aKVkO7Dym58CgctwZ4L
 gRLuVQRv/XwDJbcsT7njo2xPIfhb/KeCQYr3iPtf7B592PLN4S/h3PZTEHOnchZfHRt5mzM+s0
 BpI=
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="36232486"
X-IronPort-AV: E=Sophos;i="5.81,257,1610377200"; 
   d="scan'208";a="36232486"
Received: from mail-os2jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 09:20:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gccyXwFaAk/se2wV5vZf5321PK5JO2MH7Kk/KpJj4DSVSJ6xolxx4DZ48h+SXb/kRTjNeHfNwGPf+PaIk6GfqY6tgr0mbqbyVb/hgUviFlmBoZuNbllbEQFHu5mit3KHNYajMwGY9sO0tEXV5BbXFuvjLj0PNlYdXZat9NcJxATIorOL3vBxKpcoNe0cJPBVVUuHS0Gxi3OPf5AEIsCRtlTel+wZUg3mr8mrtOJMJylA0wX9K6BLL/zaWdp/YkCse3OXXCye4/yl/B3bCilTOAT0zFJUNMohalgSWuJe0fZxoJUlKkQQXxNdxDoWD102BamvJ45yrYabmrh4/qx+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga2fWaOaxUBgimHjzYOVIGAQ9HNMudOjdRoX4yMUCP4=;
 b=InLXZK6EyKNUo4hE1W7lxvxdpKaYxWV7HY1TPD/L//DP67tdfFgx7p06fxKxhB9CxCKcRl/ZtN1dyijY5SinTqV/SBuhBZ2Q1SDBdq3TC0d+l42kWuCO+JHJF3WLjiyWFF2KoKLMkF2jVCw3FcpTSoo97Z+zA1BnMZEMC4QUoiLCs83apw1Dv15We8dlN2Fa87Qp6N4Mqcop9tiYVC6aBFpeEM++zowjYs55rQ7P57ePxXWvFJsoerJpFKAeFthb+eM8vIgK3Sjc52Au8kVmUPhC3leEyF7lTyzl+x+0JQLWH5rluzPNjyRWlpiSZqRQ03BFNqlvvIMaGHq3pEXjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga2fWaOaxUBgimHjzYOVIGAQ9HNMudOjdRoX4yMUCP4=;
 b=L2XbRJncFmCDmS3z6/f/ormqXvWjWtwdnvnMM1sBc11n68xf+TkeUZZ6FkvD85uEqNty782m1psvNIcjnDo5JY82/3bIXBpK7vrDC/mG9NACeogGVLXf1gJuO4ZTuDUI3LX176KbH9wFqQyP64OZ3VXULC1WYO/7FW3SGkNzdyk=
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com (2603:1096:604:74::21)
 by OSAPR01MB2658.jpnprd01.prod.outlook.com (2603:1096:604:3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 00:20:33 +0000
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::e8ec:399a:e6ab:7056]) by OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::e8ec:399a:e6ab:7056%6]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 00:20:33 +0000
From:   "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To:     'Neal Gompa' <ngompa@fedoraproject.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Omar Sandoval <osandov@fb.com>, David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: RE: [PATCH 0/1] btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
Thread-Topic: [PATCH 0/1] btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
Thread-Index: AQHXG2h50VPqg6+wXE2GKRCWpYgZr6qI4EIQ
Date:   Thu, 18 Mar 2021 00:19:17 +0000
Deferred-Delivery: Thu, 18 Mar 2021 00:20:16 +0000
Message-ID: <OSBPR01MB45823F4E685ADDFD8B8161DCE5699@OSBPR01MB4582.jpnprd01.prod.outlook.com>
References: <20210317200144.1067314-1-ngompa@fedoraproject.org>
In-Reply-To: <20210317200144.1067314-1-ngompa@fedoraproject.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: 142d69b1ae704469a0ce0950222fb323
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: fedoraproject.org; dkim=none (message not signed)
 header.d=none;fedoraproject.org; dmarc=none action=none
 header.from=fujitsu.com;
x-originating-ip: [218.44.52.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc28876b-b1b7-43c2-0586-08d8e9a3a533
x-ms-traffictypediagnostic: OSAPR01MB2658:
x-microsoft-antispam-prvs: <OSAPR01MB2658D2AEA2888D64AA9C97DEE5699@OSAPR01MB2658.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OZhieZmVpHSTEtUif5upNKzIIK6jXq85MjjJD0CUs6Xhdlak4GMxOYEqRp/0WGQDpbXDWam4QQ/s/R0xFSnvQEPXNffTgsGdyHL4Ov2rwMtiwWumxV9saWx6+NTnX7fuqHJLPaoDynhGjA0yB9+rfA1Nw246YS9e2axX4xq577OUxUOhsL6GeKu9dU5eMdkBRJ1Z8Hv3oAV6rpD59UNW4q/BEb8ezJDLb6ZkNbg304Px8Hd/ZUeuyO7pziQlkrcYMXH0ClB6/e6CVAebMXy11ge/yDZhoDgc5w/eOTAKE041YKoU/6FEA3gEmZfMeBk7H/VH6RVRt+AieppXj3pQkXUJzqrX22MWR6VApYgoD1dFSGAyczRjCsJAuGIynQgrSAJYs+N0vhwhPkA0Ob8v0T4WiVz1vA1PNQK6cN0rFSPmMB+NhAIdNWmS5/cR2Q4JZdUU7DGSzcpzpPXjOm+EPLfg+no7WZdCLWtg9X9TL/TY7e3jyoaYrxufExPZyucN+X/7HjO2UEmU+HugoDj1XU/J3KyHyNCKo8G0Rv8X/xBOHl94GhmEEeR89JeJykbnOkpr23fyPgxf2FxdIdafmOo3IClZqWM5VT4blT3O5rtIEKjGV/zCfUKJ6+UwNPiH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4582.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66446008)(33656002)(2906002)(54906003)(7696005)(8676002)(85182001)(55016002)(86362001)(8936002)(186003)(64756008)(83380400001)(6666004)(316002)(9686003)(71200400001)(66556008)(52536014)(4326008)(66946007)(76116006)(66476007)(26005)(478600001)(110136005)(5660300002)(38100700001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?d0doN2toUEhlRVVCclNpNjA1S2ZoYTlMK1E4dU1HM0E0c2JIK1Q1MEg3?=
 =?iso-2022-jp?B?WG5OTWVMZnVsS1RlY0ZRNG83VHdmaUdRMHpwZkhtVlNsUHNsUzFoQVFt?=
 =?iso-2022-jp?B?ZWRtSEYzc1NKM0lpT1c0TVpjQkE1cCt2aDB4cjFQdzlPNXhMRjJTVXd2?=
 =?iso-2022-jp?B?dUIyWXB0N2o2ZCtQZGhBRlRpRVZpZTBDbFFIUm8wNGRHYjNidytNa2lk?=
 =?iso-2022-jp?B?Tk0rZnpMZndrUnVjZ0ZiNzkySWZlVm9XYys0VDF3UTMwaEVXSlJ6cUlD?=
 =?iso-2022-jp?B?Tmxma3QzcmVCRXNIQk5Yc0FrL1dlZ0ZwNzJ6VnZlbmJxRXVVVHgreTZL?=
 =?iso-2022-jp?B?QlN4M29IWUNJWGRQMjlsbDZRQy9ickZnRCs3bnBQRjFJNmlLUHBFWGl6?=
 =?iso-2022-jp?B?eWpJTFhGZGZmNzMrZHhpSFpiaWZxcVZDL2Y2b3VRSlc0aDRmN1lmR1lK?=
 =?iso-2022-jp?B?OUZzd2t0WDBCM240Kzl3WFMrZ3plcWVaQWU1V1RvZk84V2NDREdQVC91?=
 =?iso-2022-jp?B?R1RKT0hhdzZ6MlUzUmk2Ynp6clNFRGEyTnVqd0hEb2NKdGNVMlFBTFps?=
 =?iso-2022-jp?B?a2Z6NHV1TCtGN252Y21wTFJMdVlLangybTFwb2MvUWozKzF4NGhQWnFx?=
 =?iso-2022-jp?B?S29NMnV5VzZyZFQvUnNQOVhsUzMvS1pzUzk5a3BqTzNKNHpicWMrSXF1?=
 =?iso-2022-jp?B?R2RvZWNWOURZbGFvYlIxbE85RTdrR2E0TkFWT1c1OG5zMTlPTTJZZy9k?=
 =?iso-2022-jp?B?L21qRUo3b0Erdk54QjV4bEQ2RU14WnM0ZXdTR2NvQW5DL3hjY04wNWUz?=
 =?iso-2022-jp?B?czRVOTUrTCt3Y3ZnMDR3UjRjTE1DdmN0UnV3WWNvc25XdjM1ZThKaHBZ?=
 =?iso-2022-jp?B?SUxKcjFIM3dTdUU0K2hYdlc0bHk1cHJ2aW1UV0g5YXVJYXRqcEM0VGw3?=
 =?iso-2022-jp?B?eGcwQzU1eXFCVVhmMEtOWEx4VGo2MDVpektKN3pCWCtnZmJBek54N2lF?=
 =?iso-2022-jp?B?VElrVktNdnBzM0NZUDRBV0xQS1l5VU10bHY1NGI2RXVwS2lxRkJ2L0NB?=
 =?iso-2022-jp?B?WmY1Q0hrQXF5bksyYUREZjdNbEFoc1FCN3VGTGpubzJKNmNROCthS2Zq?=
 =?iso-2022-jp?B?cTlZU0RhbHY5RUVIVk85RXJad1dSQktHMTcxLytyWnQ0ZlVhZzBWNXMy?=
 =?iso-2022-jp?B?ZlFFa2QvTzJKUlI3aVl5ZXR6R1F6WXlYcTFXdktvWjdEOGVaOTdhd2Fr?=
 =?iso-2022-jp?B?OTZ0a0FMU29UV0lzSDV3Qk9HVXZ6dVdKU0xNbkFCbHl5WEZjWUNDOG9S?=
 =?iso-2022-jp?B?bEZFUnJnWTB4ZVJIZnhtYUx5WEE0Ry9vVHYwaWwzU3c1MGtTQ2hxR1dG?=
 =?iso-2022-jp?B?OUVUb3IrU1o0TzBKbURxUEdVVXV6M3VaUGRDc2huY2lxcWhrdklZT24w?=
 =?iso-2022-jp?B?NGlkdno3TUVKdkhrcmsrSWNGVUtUL0toblRHYmQ3emM0WGE0OWdEb0tR?=
 =?iso-2022-jp?B?Z3J1Y1dZNzZPQWFxeUN1dW0vdGJkdUxkV0MxWHpMVVM1U3F1cmhoUUxa?=
 =?iso-2022-jp?B?SGRRQjNQZXZiQkVQbkkwajJ1OGVMMXJLVTFhNXpHWlA4YlZWeFg2emky?=
 =?iso-2022-jp?B?aWlsd2dJUFVrMDBBQTdnSnVTS2owa3paSW94eW1ab2JqdzV6UFQxME9i?=
 =?iso-2022-jp?B?Y0gxUFh1Q25pN3ExTjcyT1lzM2tiemluREJYV2JLTDc5aUVUWVBlZGFY?=
 =?iso-2022-jp?B?YlMvbVZwdDc2MUlLU0h2ZkExa2wyZkNibkpWaUt4b1dqNncyZ1RqcG03?=
 =?iso-2022-jp?B?dGxSb0Z2R1FmZGNHWENJelVacFFtdG1mSFpGRDhRNHFIYlZYNzF3RG8z?=
 =?iso-2022-jp?B?MjhzeUo2VW9iZkd6Wi9RZ0xTenI0TGlQMG1TbnNsNmxRaHgxdFNTM1ps?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4582.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc28876b-b1b7-43c2-0586-08d8e9a3a533
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 00:20:33.2621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3TdUDBKd2gDjcntT0kh5q8u0Yc8P+PMw1B8XRCY+WW4GPbQW6vvn+x09iAbgLDN8y5N2y1TaXvsgyxxqp9XavjtHaADNElDc8UAKWiTG4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2658
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Subject: [PATCH 0/1] btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
>=20
> This is a patch requesting all substantial copyright owners to sign off
> on changing the license of the libbtrfsutil code to LGPLv2.1+ in order
> to resolve various concerns around the mixture of code in btrfs-progs
> with libbtrfsutil.
>=20
> Each significant (i.e. non-trivial) commit author has been CC'd to
> request their sign-off on this. Please reply to this to acknowledge
> whether or not this is acceptable for your code.

Hello,

No objections from me.=20
 Acked-by: Misono Tomhiro <misono.tomohiro@jp.fujitsu.com>

Thanks,
Misono

>=20
> Neal Gompa (1):
>   btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
>=20
>  libbtrfsutil/COPYING              | 1130 ++++++++++++-----------------
>  libbtrfsutil/COPYING.LESSER       |  165 -----
>  libbtrfsutil/btrfsutil.h          |    2 +-
>  libbtrfsutil/btrfsutil_internal.h |    2 +-
>  libbtrfsutil/errors.c             |    2 +-
>  libbtrfsutil/filesystem.c         |    2 +-
>  libbtrfsutil/python/btrfsutilpy.h |    2 +-
>  libbtrfsutil/python/error.c       |    2 +-
>  libbtrfsutil/python/filesystem.c  |    2 +-
>  libbtrfsutil/python/module.c      |    2 +-
>  libbtrfsutil/python/qgroup.c      |    2 +-
>  libbtrfsutil/python/setup.py      |    4 +-
>  libbtrfsutil/python/subvolume.c   |    2 +-
>  libbtrfsutil/qgroup.c             |    2 +-
>  libbtrfsutil/stubs.c              |    2 +-
>  libbtrfsutil/stubs.h              |    2 +-
>  libbtrfsutil/subvolume.c          |    2 +-
>  17 files changed, 495 insertions(+), 832 deletions(-)
>  delete mode 100644 libbtrfsutil/COPYING.LESSER
>=20
> --
> 2.30.2

