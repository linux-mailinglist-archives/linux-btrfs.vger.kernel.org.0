Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AA04C9C9D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 05:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiCBEoY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 23:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiCBEoX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 23:44:23 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7C2B0D13;
        Tue,  1 Mar 2022 20:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646196220; x=1677732220;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A6RfOMlP+Ny4aQtwwRtS3rd4TtVbyOMvX3wGgQZIb5s=;
  b=Atjh0Fj2qOmjbh69h99jVMVXPXPr42SxsrB7rtVLEwZIF4ERmntgBG34
   SLkI7C+3L6dzT+qaT4+Hfm15jGGu1jKdtBHzOY+ywr1IA/MeLZkHz28P/
   5TyHMRmelZH2KPmaftSqGtn1Yny5HB9NmtVjFiwaNbL7kyTcuoP7P1vAS
   o2Feno7svQWB+kQVR732WzZw4aaKEvaiy+r1HW2TACEuibQLjSMT0QV33
   2zwPCggy71QsOk9uXQbnH/iQ2DDFSntAVfxuI2J2gfmxryI4F9jRx+66L
   hKxa8Dvhoz41Vz7gR4W+cEtQgehvCYCleeR0ikCSrcnKzevjbsxU7UDU2
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,148,1643644800"; 
   d="scan'208";a="193186276"
Received: from mail-bn8nam08lp2048.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.48])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2022 12:43:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNLV2ulEXImnmo83QzmxOjWY1RyVj8vS2He0KaFUpryN9vK0qJjZnHHSR5nkUw+5nNNW2xHWvQRsQ9aXL1FkZ1jmwnT6MpXAYK4Lnb8lmaKDMZ9qV7GTcuqclNFXzea6Bu9KTcr17jE3agS0QxEW69Ea2hcO+NpvGiwXSLj16u1G3VEIHBckHKEsNaIiElc8d1OmaHaEQ7qbOgtNSR58ntzTWrBZtGgLbAM4Caw+9wbWmV9T8C70AE4pdjJa2PsuduCDgShJ8ZCzvCBwgVerF3Qmo7v9lYSp+6uEHSXVnIQWux6l64GZMXP3mxKWCuZlB4apnpYn/MCgv+DNFyiU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92TNitHFtj1h4FXIPBFG3rv/AoTdGi/bg2GTSJ75I3Q=;
 b=gbwlN6OYDOOvfW/BjthXf72/Mfo4/BPjFhAo8YjIzksAXSync2P7748YP3mjickU7025PDFifGeYEHjzX9e8+xXu+NoKsQmJTqJKaxWbp7Fzj7Wp8ZC4hO4WBUkk1QoKh1Olz17qWWKaRi8ux16AQVp0B97dhbWEFIHaNcGZm6OE+e9oWP525OYvNs5LDY7wYucwsh+OKo2Vm5iyoAIMtQRHW5iX9Zf5fY0QGBCuCDnxzlb95QHyLKVnDe063+BrOggTdDX0HTkFV5WbRKOQ5XqWml5q/b8YAOo7gvF3jKUCUVB41QNmnti7hC994GwC2jcCSyqwHDxZ/FNnQwh/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92TNitHFtj1h4FXIPBFG3rv/AoTdGi/bg2GTSJ75I3Q=;
 b=pBtXhLJIdbunnZNK9hFf2+G74qTsDy1Hy0dQpIYrQa54wJ3Mf6UR2J3GCvHmReGf5+yheoRNySkPvumokowftvSnTpL75Z+DNBm4H5mtdiW45Ao5NUWVxDL7pUEdv3Amr95qHNqLZiVjXGi3Mzx81fUNjJ3uEbUI/SUzGOXV8bw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN7PR04MB5300.namprd04.prod.outlook.com (2603:10b6:408:3d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Wed, 2 Mar 2022 04:43:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17%8]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 04:43:36 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sidong Yang <realwakka@gmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: add test for enable/disable quota and
 create/destroy qgroup repeatedly
Thread-Topic: [PATCH] btrfs: add test for enable/disable quota and
 create/destroy qgroup repeatedly
Thread-Index: AQHYLX/HTsdi+5TEU02xRSwX5mWddayrhSYA
Date:   Wed, 2 Mar 2022 04:43:35 +0000
Message-ID: <20220302044334.ojz2crbcc6eapvex@shindev>
References: <20220301151930.1315-1-realwakka@gmail.com>
In-Reply-To: <20220301151930.1315-1-realwakka@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10d89721-2390-410e-5bd2-08d9fc073690
x-ms-traffictypediagnostic: BN7PR04MB5300:EE_
x-microsoft-antispam-prvs: <BN7PR04MB53007F4D2036AD4F49760EDAED039@BN7PR04MB5300.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9pdBXNQ9JnlJhoY3qULv5ucsCLhZreuTlD4nFCAaMk4L6pXRdjbCVJWajf0lHfQptgf4tC0gnwpU0kkafg9cLb3Zh8AhTN0bQspps9kqdWk7fulxMvqZciG4h6JEows/Fr7DEbMGLDOAW3jZMfYu0WIvJf5kvtzlagcR2/SiufDqm7gTO+4cBgJ+ZQv8uuR3VV404wiEisk/kxucXpCFjkrY9JZTTwAWmL1+Jy4GySBO0S+OhyK7Ir2tocSFjctXK93s+KDYC4HeAQedU+Gaq0yl6nStgspEdQnDoMm5uOKpNoZSZSbpUGwj1qXZKo/wYNLFOIYUmQIyQFK/nMqlPaHAcFaVzXiEdsXAkQLyLaQ9dZt7Z8kqrFpxvYiBBkJuVPbtv29n2Vu64c0uPqS15G2UPUPHZ6PFGVOJ4DFTKM+T1OkzMN5INT/FlNUc9tYtDQVDnGe0XlDfxd5gtcFTi40NxcAL9bBTmIPRtbKzTsx2jZSBIM2M3pOXiR2QfVjhxBbmgdha7oyiP21vOWvA0ZNP67l21nJ1zuh5Z5ts+S7jgMUAK/b87LqSvaPu+ELsnfOe2891IBkGXQWOOR++ld/7lWdCG3qoe1hFhpkJXymHw1/Lj1cLRj43D+1AZQ6cTCih8VdEh0vw8GFxpkUDvYtvViVfeIERHEPY3UAL5mA8TiZ/jyXjMZaB7hmXON59y9ZgeydhPn8CjQREJnjWdceEDHmsZz162LpVjY1zr+NmAKNKKBqJyz7J+cOupoyYP0POko31VnkPUHCI7bUIBdGL27KeTMjRhERROqXF/Xg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(54906003)(6512007)(6506007)(38070700005)(5660300002)(44832011)(8936002)(316002)(2906002)(4326008)(66946007)(71200400001)(83380400001)(9686003)(33716001)(26005)(122000001)(8676002)(186003)(6486002)(82960400001)(86362001)(966005)(15650500001)(64756008)(66446008)(66476007)(91956017)(76116006)(66556008)(508600001)(1076003)(38100700002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IVaCYrG5jrSZD9dR17fsB5MtoPSFKPglgmFxcGYC5EaWS5uyJNP08AycYvb1?=
 =?us-ascii?Q?SAhFxyz7cOgejJ7jK+b1qZCwUnYKeh59kdr1CVkzVGVVlhVnjb1mLxaFxjcl?=
 =?us-ascii?Q?d3UJoVAt1RjSgsuVcRNOMLIh2lMNbA6LZ87dbO7fhlZHFDoExrzgUCL3IBxS?=
 =?us-ascii?Q?g7HD/4AQN6yzAraQKu3z6CHNLsxwLjjUPl5gSylU9NEQiZ89lJLAE5RuVZSo?=
 =?us-ascii?Q?GLwl9Ml2E4a3Vd/BjA6/1Yl2YerW+dbcABs6kJiaW2Uv8Stt6c19/6J21nll?=
 =?us-ascii?Q?6GBAOH8WVzYHhq+mcI530tiwkfJERQ6fuRig+YjU2mKOQjuy8samzBjn16sh?=
 =?us-ascii?Q?nXKrJVniSUErEsLNP5O4dxabbZ2rhJyncokaLcB657XT5/hdIileVpv+NKx4?=
 =?us-ascii?Q?AkUCdIbohXg+JeMz88A34kAe4Fggp7tjhhFb/6AWE0u/LiCir+OCrqZK0pud?=
 =?us-ascii?Q?MLFFRciea91r43RK25k+qD0ZSdpSJrlJNkp8gs806mfoIzXd+HffCTAXb5U4?=
 =?us-ascii?Q?IzN38znGHq47ckNQ5RV1iu/CRsUqAZdometHH6tDEKdYkoCGIPP8miC5zkzk?=
 =?us-ascii?Q?KTkKXyL5+no0EiTNCziLCGBAPSkAFJDzpcVuIhL3vu0fJIbi/mkT315DTCYM?=
 =?us-ascii?Q?vjOsAKoQEVz5J130aRtGQrfVBsNu8pt0NXDtcIwm0Y+hSsXCJR8i7HthjNOa?=
 =?us-ascii?Q?F2ZU6Hu16bmp1iJHzikkqg9ZdEfANJb5m7fF+yYGI2AlYwgyyiYs7th10h04?=
 =?us-ascii?Q?wrJu+F53L8BPQMa9xoDIor6uYwpESqpw5vt57R+sHDOAlbXyBXVdO1zNlB3k?=
 =?us-ascii?Q?htw9scRwdlCdkXcsE50or6Khbdryj+xlE258gF3SzcYuyNisfA0ZVdDyeiNW?=
 =?us-ascii?Q?kX+23/PZH3KLtLX8nHGV3HwCstmdA+LyWccac0jMFIWIINC6RLnMYg90PKlT?=
 =?us-ascii?Q?Cx5KUDuRChtDK4g+Tu8Ns2sIdgt9/33YiVaOglepqThkrt8nFxEBwDJ4+7vE?=
 =?us-ascii?Q?NFz1JBSMteMVmpuvvmJVd9QTjJ8ErXMPtVqW4ofI4y5+yHpTb+3NDrxCnDyN?=
 =?us-ascii?Q?iUv0+Iy/meBk+uDKjPnWwXi5TWR72FgQSZusL0Prc9dBqmlUVl6Cy5UUUiDf?=
 =?us-ascii?Q?SmxPRFyziUHw7vwBlrbGfbkKOeALW5EbfUweYpJ7rESnOcizjLBaSeucykbK?=
 =?us-ascii?Q?8H4gn9AhfE/sM0UpP+i5ca0rNr+RO7mhSpJ0n6hbLiwoWBcnZ/o3bsqDAUk/?=
 =?us-ascii?Q?FsKVZrQFHAQKdF4FkNNhzyEo05/V8huAnp+Ur6QbEFxbAdRBfya3R5gaJP4Y?=
 =?us-ascii?Q?dMAGqoQCxfzCEdIsWfFYVCDqsBovfFRak2IZC+RagGF1+js0kwZ15wX9k8Av?=
 =?us-ascii?Q?ApTpUZdFlpSa64BzI8wZ6Mk1Sbjdn2hMCg47CMZWh0LH3DpvjW/HcbSBKUQd?=
 =?us-ascii?Q?I7rKIQNhCd8a0K2pthIsMCb1ta3uEJpaA/GD6vIczFb8zPdAAZ2zbJ/qHQ5y?=
 =?us-ascii?Q?cFMnOLIJiDmrhLB4z6q8zsRDY70gWebY3iZp/j1SY6xCqIoj9oPRkfk+79LT?=
 =?us-ascii?Q?ZL/tVbJpa+VuorVvw7jitubDytE5VBql1l4s+JmFupXU1FoOvjgFOL9q7F7h?=
 =?us-ascii?Q?K/7Ish/qvwudjYIV+HSDSgs44FF/Eoo6OtUf5sJGftpjLukHS4sl36csKCIY?=
 =?us-ascii?Q?QSSUEq8k58/4TetBzCRQjBjiS7U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E4BF0E8A8669045B1D7B281EE82BA80@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d89721-2390-410e-5bd2-08d9fc073690
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 04:43:35.9255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X1CGPNlV1b0NEOqSntOnksAS8wNg/BVgfaChIcXSMMbaXH79UNfK7OIsu8zEO6oF1UKBiHtCf6A0i6z/zhEvGAO5u8zsrPTXdr403Z7y620=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5300
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Sidong,

I tried this patch and observed that it recreates the hang and confirms the=
 fix.
Thanks. Here's my comments for improvements.

On Mar 01, 2022 / 15:19, Sidong Yang wrote:
> Test enabling/disable quota and creating/destroying qgroup repeatedly

nit: gerund (...ing) and base form are mixed. Base form would be the better=
 to
be same as the code comment.

> in asynchronous and confirm it does not cause kernel hang. This is a
> regression test for the problem reported to linux-btrfs list [1].
>=20
> The hang was recreated using the test case and fixed by kernel patch
> titled
>=20
>   btrfs: qgroup: fix deadlock between rescan worker and remove qgroup
>=20
> [1] https://lore.kernel.org/linux-btrfs/20220228014340.21309-1-realwakka@=
gmail.com/
>=20
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  tests/btrfs/262     | 54 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/262.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/btrfs/262
>  create mode 100644 tests/btrfs/262.out
>=20
> diff --git a/tests/btrfs/262 b/tests/btrfs/262
> new file mode 100755
> index 00000000..9be380f9
> --- /dev/null
> +++ b/tests/btrfs/262
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 YOUR NAME HERE.  All Rights Reserved.

It's the better to put your name there :)

> +#
> +# FS QA Test 262
> +#
> +# Test the deadlock between qgroup and quota commands
> +#
> +. ./common/preamble
> +_begin_fstest auto qgroup
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.

Can we remove this comment?

> +_supported_fs btrfs
> +
> +_require_scratch
> +
> +# Run command that enable/disable quota and create/destroy qgroup asynch=
ronously
> +qgroup_deadlock_test()
> +{
> +	_scratch_mkfs > /dev/null 2>&1
> +	_scratch_mount
> +	echo "=3D=3D=3D qgroup deadlock test =3D=3D=3D" >> $seqres.full
> +
> +	pids=3D()
> +	for ((i =3D 0; i < 200; i++)); do
> +		$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT 2>> $seqres.full &
> +		pids+=3D($!)
> +		$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT 2>> $seqres.full &
> +		pids+=3D($!)
> +		$BTRFS_UTIL_PROG qgroup destroy 1/0 $SCRATCH_MNT 2>> $seqres.full &
> +		pids+=3D($!)
> +		$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT 2>> $seqres.full &
> +		pids+=3D($!)	=09

Trailing tabs in the line above.

> +	done
> +
> +	for pid in "${pids[@]}"; do
> +		wait $pid
> +	done

I think simple "wait" command does what the for loop does.

> +
> +	_scratch_unmount
> +	_check_scratch_fs

I think _scratch_unmount and _check_scratch_fs are required only when
the test case repeats scratch mount and unmount. This test case looks
simple for me and the qgroup_deadlock_test function may not be necessary.

> +}
> +
> +qgroup_deadlock_test
> +
> +# success, all done
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/262.out b/tests/btrfs/262.out
> new file mode 100644
> index 00000000..404badc3
> --- /dev/null
> +++ b/tests/btrfs/262.out
> @@ -0,0 +1,2 @@
> +QA output created by 262
> +Silence is golden
> --=20
> 2.25.1
>=20

--=20
Best Regards,
Shin'ichiro Kawasaki=
