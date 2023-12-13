Return-Path: <linux-btrfs+bounces-938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A775811874
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 16:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDCB281E21
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853F185377;
	Wed, 13 Dec 2023 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UMMwQuoO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mx9mKqHk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638EEAC
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 07:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702483060; x=1734019060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=fkYMg6B6KJLP1j3uM4gQsC1VSrU/Cc+gTfN+5DR+syU=;
  b=UMMwQuoOdNl73fZimekKE5+3VJbjlt2aoRNRknaROKwTYtBY5z7ECapX
   V4icmLfiHDr6X3MxMOWgdNW7VvZemrPNVQHq8JjBbB5xpA2N292nDXzpa
   XBGTp6v9/tvbjcj2vOmVsaWO27+FwC8a3JHa9s9yAo3EwdLkrgG4f+aMF
   3PAxzceyfB6xnYKvfNB6Ww6ywTysvB2IdOzVHlKuHcHcRXPkVRP6sRSXX
   BM0Dz8JgVMCs8zOdw4H7SOI82EP8nIZgF4zzavpYZsIDCPBWOWLL6UI2/
   ZCpf8UI1UJHzFwpbI3wCBKkXVlXwQh2nPWw6qtapLgePXJT7QgqyjdBjP
   Q==;
X-CSE-ConnectionGUID: HaVeQDsUR0qfdZ92nM0bvA==
X-CSE-MsgGUID: 4Q98p9CsRHiLDufhMLEDCg==
X-IronPort-AV: E=Sophos;i="6.04,273,1695657600"; 
   d="png'150?scan'150,208,150";a="4808214"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 23:57:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dqzu19L37Oh0hngXQb7roOaThuI9ScOCNO3BbjatuxXTaD1CrqF2R+PVQHXdjIi6/3KR3qMgFEGpqFp0z8ML9lgemdOc6OwOB+twcdx1nnCAV+xNio+csZiDJXB45mEAkzHJUV3O6OCwQj96ep1UtadGPXh9qrv4Mc7lvM8wqXqNPEH44Uu/U5ucHXp9n7OuPwvUO3/WjbFSMs3Wdu8jvorzGk4vv06uHT0wrDPi6xxUATRvJtIP2r+r0uTJaTreh9Ecfi1Jt9xGpdtfukRKazEdjLoogNV26u28njESFOpNKbqUKXVFXIOr1hmA+AesPc2Ky61+QzmBYeuVuEw/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soqCBATvEH5xhgiKdxB0lVNiTGa4aODTByFR5bEuDXA=;
 b=dICtB2mYcgpjVPC6PBe8oruYARxT75ImPUeSVIs98wvTc4J1XrtI8kLal9ZpzxbAORrPUWlHYlwtEnR83LMBJ324+fGSYD+zZtjIFTYsVzCDgAOkkqMZr5tUigv+/xPOg/uG4sVeg1LRiH/mBQzu+zyhhyZFYE/gmBrdLdK5C/zIWJ3uB2mGZEyA1mBxC6WS0wi6AAR9EKkMtJMBCBnc8K42JFogxUjNMVmo21bHTwrF11rUWbfdvN6fvCQa9h9m/UQndg1qjrHvaKdCgAGenXL3Hl6FQcb701z6nPowl+1DHjgVnjwsJGVBf6aV6rIAU4SNOC3fYQVRsAb3WwbOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soqCBATvEH5xhgiKdxB0lVNiTGa4aODTByFR5bEuDXA=;
 b=mx9mKqHk966zGK6Q2le/X7RxXBWkDjwNyNIHTYRBf7kF8Xy3uwy0vJpYnaI7HdevJmqcYVLXk9vHoMpwb8MVyzXVjTJaJCyevSfq901yLahoMXzAM/d7Ua6pQoKj6tVtJNMMiOunuduRSCOmG88On1DNtm0y+zNEnfyZUDfc9Ac=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH2PR04MB6982.namprd04.prod.outlook.com (2603:10b6:610:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:57:36 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9511:64b5:654e:7a8a]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9511:64b5:654e:7a8a%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:57:36 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Linux
 regressions mailing list <regressions@lists.linux.dev>
CC: Wang Yugui <wangyugui@e16-tech.com>, Chris Mason <clm@meta.com>, Christoph
 Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Thread-Topic: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Thread-Index:
 AQHZw4DAgsPQz2oUI0eGPNKq+QLraK/UtyoAgABoNQCAAAXhAIAAAcIAgAAIF4CAAAfKAIAAM2iAgAAgUgCAAA5yAIAAAX+AgACIYoCAAJzmgIAOd/MAgAAH/ICAAtBzAIAZI9wAgJvkJ4CACxrwgA==
Date: Wed, 13 Dec 2023 15:57:36 +0000
Message-ID: <p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae>
References: <20230811222321.2AD2.409509F4@e16-tech.com>
 <20ab0be0-e7d0-632b-b94c-89d76911f1ed@meta.com>
 <20230813175032.AA17.409509F4@e16-tech.com>
 <4108c514-77ff-a247-d6e1-2c12a5dea295@leemhuis.info>
 <149bf20e-538b-4051-9ee3-a9d98e09c3bd@leemhuis.info>
In-Reply-To: <149bf20e-538b-4051-9ee3-a9d98e09c3bd@leemhuis.info>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH2PR04MB6982:EE_
x-ms-office365-filtering-correlation-id: 9e947e2a-d5c7-40c7-7c17-08dbfbf439c9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nDsEupCYuiT5+DAlPLiHCFocmQ3X7A5/AAKhEBpRtG45yT+LDOJotY8h2GeXLb2r27bnW1o25WElLQi6bf6uVVYhzF2hgWhp7dxUII/7vkOu9SNqjxGBD8jEzN23EhVCX0gD5AFVv2Xnx99G/IMn5XrZywwgAldjOSCtO034bY92/b5kn/j4AI4ZDLLP9h2rNRHtLWNDuGyKmU6bb78o9MqpRLhqW3/Q0jhGHG3cWzZvH0FfgTzlA5ym6fkpjvRnrewp+vp0tqlAJifiV1/2St5flZ9chr6z2blK1S4PVN/QWUKhk5ksg9F8TEMmP44OYOYJRIEz0NI1QOH+rC/kdZiJKYHbngtbbAN4visSBHxRk6t+0FbDAtl79CrW6Xv6w8v3dYFK5Ri6FEp5HxCdmYghqYLRHKUf1AVWm6kKKmG2G28QTvBK8YVgE+lW/g4Yfvj8AooNju3sOy8fLK34rzO1U87pNZSob9RHYKMtLBHKYSn9RA0bH+UD4y2WfDEKqf564vA3sgXgdGaSYJ6UtbLqulR5MPcRDcRmVz8pajRI6B9xeTgNT+JZ316ni46v340mbHNJjMFfUzvgKdlZXv87UFJ1Ndy7XysuMO6Tyuk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6512007)(9686003)(53546011)(6506007)(4326008)(8676002)(8936002)(5660300002)(41300700001)(2906002)(6486002)(966005)(19627235002)(71200400001)(33716001)(478600001)(316002)(54906003)(64756008)(110136005)(66946007)(76116006)(91956017)(66476007)(66556008)(86362001)(66446008)(122000001)(99936003)(38100700002)(82960400001)(38070700009)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5GXkYvd2owbpRLBUTcZJawwssap2LQ2V5DsqeggIqx6N/brHIo/b3Y0alKvI?=
 =?us-ascii?Q?wssAJDR7UyEVAfgL7FB4h7Rq9NEcLU5RyfIXfn8SO2bTODN4Ko8N3c1LQNEL?=
 =?us-ascii?Q?e6J+lYofjUol1RHos3T4nGS8rucp6w3rIOEcRCvK+ijdTdr2x/vrhOfeQGxz?=
 =?us-ascii?Q?q2dwOLf6scSQENgiOdguTvDmyJn6LKITDpBwKztTuHVqmMSQihPk+KXH9FWd?=
 =?us-ascii?Q?qTM7S1g3VisO9coHDsOtmm/SuQ9i7hFqySuhbsn8+y14sWY9bcbjcHOVnqlO?=
 =?us-ascii?Q?tUlfgDN9DJoglSdgYO3ITOKRiSx6rGGGv9a/FpiLFs+ZHGndmQ1blQ25HjuO?=
 =?us-ascii?Q?q0me/b33WIYh3iVIFMDTy//RU04o3pE2yv5jB38TnD1WmxkGOLEAAPgZ8XTV?=
 =?us-ascii?Q?1o/2vwS3icyMlgdH2JdJqX/mF5FBlzOi9e9/i7Iex2Xb755Iyych322JjCcU?=
 =?us-ascii?Q?TVqXzYDDaVTRbFK3Pf9oNeF+NW0LaUEeTNHV/F8rWSn53oM/xlB/AOjlWxUV?=
 =?us-ascii?Q?CmTg6aAQUdI8Bod4o7M7hjjhhR4p5aIODtn4N3nvrKtbnrQX+9CXAA/7xeAT?=
 =?us-ascii?Q?yzmgd7S+09UGoRimXLuMpedTR4UhZ6A9NM/2T4z/OE4LXnCF8cF++egdeEFX?=
 =?us-ascii?Q?4fKfJXSG2EGy3WydKCPJfH2dw3wsipVKH5cZQNkIMc2ZNukUAlz407ib5GOh?=
 =?us-ascii?Q?HnPZV3NCT4Rj986nyPsre0ME6Jmi+1pKPVQ0xB3Y+1BgzZcHs+UwQTisIVR8?=
 =?us-ascii?Q?X4wg6TG3PWG+kqenSKiYXqNJ/yOoyJsR4qQe4DxkXDvbg76KiIjOFqMv/PVK?=
 =?us-ascii?Q?iGluaUbax4Lez3ffGgjClxl0g/DVR6+7DbL/2EvKC1s5ub81KjaK5T0e/EIB?=
 =?us-ascii?Q?eUPe1pKCnLqlFav6n8hiN3ZdFfAWjZmopOhI3cPyqnGHOs7eAb8dgJuMiM95?=
 =?us-ascii?Q?2/5m5eGyPWLNMdUEHWaLJH5ARlDgbnu43TlIWTg4C10L0cDZJVWjaxwl1LUG?=
 =?us-ascii?Q?WPiAbQb0J3rwJ9LnFW1AOTml+6Woo+2qvxoKG8iH4P6ifT1w5dB0uQUQ9JvU?=
 =?us-ascii?Q?psZwmNH9lYWqqAnj8daxJtRcywZcsIqb78BTiTBcMQxm7XozA8VKTN/pWMmP?=
 =?us-ascii?Q?8d84gRHTOoHNNF+HlqyrKMEA0ZEq6bx2RK52L9QceofqcE9ID9tgnSrWxPwO?=
 =?us-ascii?Q?q4lkx2CTo8vHSDPaWv+BTs7HscnTm8nSohbbXDvUseHOGjm9kvWuQC2FF2oi?=
 =?us-ascii?Q?/hmzkcNw8H0jk92iC21GxyQ1to7kG2wT+i0Efayf7UP6vAASKwM0NzKU8SPi?=
 =?us-ascii?Q?KdfbIXJFbM+Ii7x+V183B8if1kd54rusGh70YnOh/3SeF8W3t6D7Y5xseJc8?=
 =?us-ascii?Q?cr3skejaWIqItcDcNypGN/elyp2Rj5LTAecFEDDkZqBSQFsGUHCEO9aLx3bc?=
 =?us-ascii?Q?FWvqPlTWMANKwWRf8xtgoEJY43yNpzE9ClV8CzWQnY16+qtu+MxU+SCq6MIv?=
 =?us-ascii?Q?/QHMyepS8pXZ9gQwgO2CTCSZO8FiLMKt6yre9bg/2whC5HmMFW9BQzNnvJ0m?=
 =?us-ascii?Q?POtng9yrmOpfQ23Id1yXMRBCgjJ2innkNBEKvF5ly8dfhN2jO3p0BLNOMczC?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_003_p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7kxzaxc_"
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T7vJfLHiXgvRN4mmuyNhEfeghns8PnDR7oAs+EnKFJCMpv7/663WoYJ7R940Ohmy8vze5ZpeWn6J2uwdiE9FpwT4vF+To0qCBt9XfYvyuRKI+utcCR0B6KKXJaDuCwnbVtyGV6rxbqGilBDiTiBJFCKUqJtVYn9AAyp7bzv806sltWrzyTL1/Z/pm8l3oYNZM3c9m9RTOv2DZZVY1K28qbfiDMRRZPjauiFIhH7EB4l2ShD6aGMfppACZWY/+87VIC8N/k1OBOcziGKcytEaeskPiDwb+QEfelxcBFacIE11ITSynlkt4yP4Rdd5wuBQMXBrSR5ZgpnybcOiFMHtBaFVbMOjoTk4x6n7td7836P1yP6CkNi0gbnm+TSluswwRE6vUpgd+SemTMRGBB/YcT5XbLqWcupHnE6yy/lq2AGh1H2Xb+M4z1QxDcb6Y9ck+RiUrg8lAxoXMyjmj7SGEKFUPpU3MUqYtKblIS5Nbr2SbdHO7Nmg3yUea+9MRH2fYE+nJTdh+4H7FwouRw5cSe4cltKIBrIQ/ebAlWbsC9gXWNA96M4gxzA4YUifS3A5CRztgafjYTPrBz6eJw5Ply+GDZ5+3FWLI65OKFD0nvCt/pxjAxJ5tPS21wrZzTKo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e947e2a-d5c7-40c7-7c17-08dbfbf439c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 15:57:36.2535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7rIIcFhb71OKeZ6YMr+ahurHw53V1qDoVJx1xl/+4eChw2zpex6PzdmdshVhoSNFbz/EsCVQ8pea/tvWK2evg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6982

--_003_p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7kxzaxc_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7403A74C67A53E4FB859CFCB9489B167@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

Recently, I came across a similar issue with this. I was running a fio
command doing buffered IO on RAIO0 btrfs on SMR (zoned) devices and found
ignoring BTRFS_FS_CSUM_IMPL_FAST in should_async_write() improves the
performance.

I ran the same experiment on regular SSDs and on SMR HDDs, varying the
number of devices. In both case, increasing the number of devices results
in better performance for ignoring BTRFS_FS_CSUM_IMPL_FAST (disabling
inline csum).

Here is a detail I did.

Environment:
  CPU: 96 CPUs, 2 NUMA nodes
  mem: 1024GB

mkfs: mkfs.btrfs -d raid0 -m raid0 ${devs}

fio command:
fio --group_reporting --eta=3Dalways --eta-interval=3D10s --eta-newline=3D1=
0s \
     --rw=3Dwrite --fallocate=3Dnone \
     --direct=3D0 --ioengine=3Dlibaio --iodepth=3D32 --end_fsync=3D1 \
     --filesize=3D200G bs=3D$((64 * ${njobs}))k \
     --time_based --runtime=3D300s=20
     --directory=3D/mnt --name=3Dwriter --numjobs=3D${njobs}

* Results on SSDs

njobs=3D6 for this setup.

- baseline: with inline checksum =3D misc-next
  - numdevs 1: WRITE: bw=3D442MiB/s (464MB/s), 442MiB/s-442MiB/s (464MB/s-4=
64MB/s), io=3D302GiB (324GB), run=3D698553-698553msec
  - numdevs 2: WRITE: bw=3D873MiB/s (915MB/s), 873MiB/s-873MiB/s (915MB/s-9=
15MB/s), io=3D425GiB (457GB), run=3D499052-499052msec
  - numdevs 3: WRITE: bw=3D1162MiB/s (1218MB/s), 1162MiB/s-1162MiB/s (1218M=
B/s-1218MB/s), io=3D491GiB (527GB), run=3D432872-432872msec
  - numdevs 4: WRITE: bw=3D1261MiB/s (1322MB/s), 1261MiB/s-1261MiB/s (1322M=
B/s-1322MB/s), io=3D493GiB (530GB), run=3D400496-400496msec
  - numdevs 5: WRITE: bw=3D1331MiB/s (1395MB/s), 1331MiB/s-1331MiB/s (1395M=
B/s-1395MB/s), io=3D494GiB (531GB), run=3D380279-380279msec
  - numdevs 6: WRITE: bw=3D1391MiB/s (1458MB/s), 1391MiB/s-1391MiB/s (1458M=
B/s-1458MB/s), io=3D499GiB (536GB), run=3D367312-367312msec

- without inline checksum
  - numdevs 1: WRITE: bw=3D437MiB/s (459MB/s), 437MiB/s-437MiB/s (459MB/s-4=
59MB/s), io=3D299GiB (321GB), run=3D699787-699787msec
  - numdevs 2: WRITE: bw=3D850MiB/s (892MB/s), 850MiB/s-850MiB/s (892MB/s-8=
92MB/s), io=3D419GiB (450GB), run=3D504463-504463msec
  - numdevs 3: WRITE: bw=3D1259MiB/s (1320MB/s), 1259MiB/s-1259MiB/s (1320M=
B/s-1320MB/s), io=3D539GiB (579GB), run=3D438666-438666msec
  - numdevs 4: WRITE: bw=3D1597MiB/s (1675MB/s), 1597MiB/s-1597MiB/s (1675M=
B/s-1675MB/s), io=3D636GiB (683GB), run=3D408050-408050msec
  - numdevs 5: WRITE: bw=3D2021MiB/s (2119MB/s), 2021MiB/s-2021MiB/s (2119M=
B/s-2119MB/s), io=3D759GiB (815GB), run=3D384534-384534msec
  - numdevs 6: WRITE: bw=3D2106MiB/s (2208MB/s), 2106MiB/s-2106MiB/s (2208M=
B/s-2208MB/s), io=3D760GiB (816GB), run=3D369705-369705msec

* Results on SMR HDDs (zoned mode)

njobs=3D30 for this setup

- baseline: with inline checksum =3D misc-next
  - numdevs  1: WRITE: bw=3D194MiB/s (204MB/s), 194MiB/s-194MiB/s (204MB/s-=
204MB/s), io=3D232GiB (249GB), run=3D1219953-1219953msec
  - numdevs  2: WRITE: bw=3D393MiB/s (412MB/s), 393MiB/s-393MiB/s (412MB/s-=
412MB/s), io=3D279GiB (299GB), run=3D725862-725862msec
  - numdevs  4: WRITE: bw=3D763MiB/s (800MB/s), 763MiB/s-763MiB/s (800MB/s-=
800MB/s), io=3D407GiB (437GB), run=3D545920-545920msec
  - numdevs  8: WRITE: bw=3D995MiB/s (1044MB/s), 995MiB/s-995MiB/s (1044MB/=
s-1044MB/s), io=3D448GiB (481GB), run=3D460426-460426msec
  - numdevs 16: WRITE: bw=3D1196MiB/s (1254MB/s), 1196MiB/s-1196MiB/s (1254=
MB/s-1254MB/s), io=3D447GiB (480GB), run=3D382588-382588msec
  - numdevs 20: WRITE: bw=3D1247MiB/s (1307MB/s), 1247MiB/s-1247MiB/s (1307=
MB/s-1307MB/s), io=3D445GiB (478GB), run=3D365526-365526msec
  - numdevs 25: WRITE: bw=3D1286MiB/s (1349MB/s), 1286MiB/s-1286MiB/s (1349=
MB/s-1349MB/s), io=3D443GiB (475GB), run=3D352474-352474msec
  - numdevs 30: WRITE: bw=3D1299MiB/s (1362MB/s), 1299MiB/s-1299MiB/s (1362=
MB/s-1362MB/s), io=3D437GiB (470GB), run=3D344890-344890msec

- without inline checksum
  - numdevs  1: WRITE: bw=3D219MiB/s (229MB/s), 219MiB/s-219MiB/s (229MB/s-=
229MB/s), io=3D236GiB (253GB), run=3D1103041-1103041msec
  - numdevs  2: WRITE: bw=3D426MiB/s (447MB/s), 426MiB/s-426MiB/s (447MB/s-=
447MB/s), io=3D297GiB (319GB), run=3D712921-712921msec
  - numdevs  4: WRITE: bw=3D734MiB/s (770MB/s), 734MiB/s-734MiB/s (770MB/s-=
770MB/s), io=3D383GiB (411GB), run=3D534348-534348msec
  - numdevs  8: WRITE: bw=3D1124MiB/s (1178MB/s), 1124MiB/s-1124MiB/s (1178=
MB/s-1178MB/s), io=3D497GiB (534GB), run=3D452973-452973msec
  - numdevs 16: WRITE: bw=3D1603MiB/s (1681MB/s), 1603MiB/s-1603MiB/s (1681=
MB/s-1681MB/s), io=3D652GiB (700GB), run=3D416390-416390msec
  - numdevs 20: WRITE: bw=3D1804MiB/s (1892MB/s), 1804MiB/s-1804MiB/s (1892=
MB/s-1892MB/s), io=3D705GiB (757GB), run=3D400029-400029msec
  - numdevs 25: WRITE: bw=3D1913MiB/s (2006MB/s), 1913MiB/s-1913MiB/s (2006=
MB/s-2006MB/s), io=3D660GiB (709GB), run=3D353584-353584msec
  - numdevs 30: WRITE: bw=3D1953MiB/s (2048MB/s), 1953MiB/s-1953MiB/s (2048=
MB/s-2048MB/s), io=3D658GiB (707GB), run=3D345082-345082msec

Also, I attached plots of ratio ("MiB/s without inline checksum" / "MiB/s
with inline checksum =3D misc-next") for these cases.

The plots shows disabling inline checksum can be better by at most 50% than
inline checksum, if we have many devices.

The result will vary depending on the environment, but the fast checksum
might not be fast enough if btrfs is served by RAID0 on multiple devices.

On Wed, Dec 06, 2023 at 03:22:19PM +0100, Linux regression tracking (Thorst=
en Leemhuis) wrote:
> On 29.08.23 11:45, Linux regression tracking (Thorsten Leemhuis) wrote:
> > On 13.08.23 11:50, Wang Yugui wrote:
> >>> On 8/11/23 10:23 AM, Wang Yugui wrote:
> >>>>> On Wed, Aug 02, 2023 at 08:04:57AM +0800, Wang Yugui wrote:
> >>>>>>> And with only a revert of
> >>>>>>>
> >>>>>>> "btrfs: submit IO synchronously for fast checksum implementations=
"?
> >>>>>> GOOD performance when only (Revert "btrfs: submit IO synchronously=
 for fast
> >>>>>> checksum implementations")=20
> >>>>> Ok, so you have a case where the offload for the checksumming gener=
ation
> >>>>> actually helps (by a lot).  Adding Chris to the Cc list as he was
> >>>>> involved with this.
> >>>>>
> >>>>>>>> -       if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->fl=
ags))
> >>>>>>>> +       if ((bbio->bio.bi_opf & REQ_META) && test_bit(BTRFS_FS_C=
SUM_IMPL_FAST, &bbio->fs_info->flags))
> >>>>>>>>                 return false;
> >>>>>>> This disables synchronous checksum calculation entirely for data =
I/O.
> >>>>>> without this fix, data I/O checksum is always synchronous?
> >>>>>> this is a feature change of "btrfs: submit IO synchronously for fa=
st checksum implementations"?
> >>>>> It is never with the above patch.
> >>>>>
> >>>>>>> Also I'm curious if you see any differents for a non-RAID0 (i.e.
> >>>>>>> single profile) workload.
> >>>>>> '-m single -d single' is about 10% slow that '-m raid1 -d raid0' i=
n this test
> >>>>>> case.
> >>>>> How does it compare with and without the revert?  Can you add the n=
umbers?
> >>>
> >>> Looking through the thread, you're comparing -m single -d single, but
> >>> btrfs is still doing the raid.
> >>>
> >>> Sorry to keep asking for more runs, but these numbers are a surprise,
> >>> and I probably won't have time today to reproduce before vacation nex=
t
> >>> week (sadly, Christoph and I aren't going together).
>=20
> FWIW, seems this thread died down and the underlying reason for the
> regression despite quite a bit of effort from the developers wasn't
> found. Haven't noticed any similar reports either. Reverting apparently
> is not a option. So in the end this afaics remains unfixed. In an ideal
> "no regressions" world this shouldn't happen, but well, we sadly don't
> live in one. So I'll stop tracking this issue, it's not worth the effort:
>=20
> #regzbot inconclusive: despite some efforts from the developers could
> not be fixed
> #regzbot ignore-activity
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.

--_003_p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7kxzaxc_
Content-Type: image/png; name="regular-raid0.png"
Content-Description: regular-raid0.png
Content-Disposition: attachment; filename="regular-raid0.png"; size=13934;
	creation-date="Wed, 13 Dec 2023 15:57:36 GMT";
	modification-date="Wed, 13 Dec 2023 15:57:36 GMT"
Content-ID: <9D54F95804C51740BB82C40836B836CA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAlgAAAFzCAYAAADi5Xe0AAA2NUlEQVR4Xu3dCZBc1X3vcZWIhAEF
kgoUIbgqVZSCVCoKG8WVkMKVpOxAUMySEFvxc/KMXgj2wyT2gxjL2FgYZECIfV+E2MwqMIvYxGYw
CAkkViEMYpG1IxBaELP3zPwf/6vcoefo9jY6Z9Q/zfdTdWqmb5/p5f763vn3udswAwAAQFTDwgkA
AADYNhRYAAAAkVFgAQAAREaBBQAAEBkFFgAAQGQUWAAAAJFRYAEAAERGgQUAABAZBRYAAEBkFFgA
AACRUWABAABERoEFAAAQGQUWAABAZBRYAAAAkVFgAQAAREaBBQAAEBkFFgAAQGQUWAAAAJFRYAEA
AERGgQUAABAZBRYAAEBkQ6rAOuWUU7LWTJ5//nm7/vrr+00788wz7brrrrOHH37YVq5c2e++nE/3
+72f9y9X9D7zaeVtypQpdvXVV9vbb7/dr2+59evXZ33POuus8K6mVzQf6hH+XXgbaYTzObydQiPP
0UjfRoSPO3PmzGy9MBADWV6L1kHbUzg/qmmkbyPCx92WTDB0UWBtR6tXr7af/vSn9uGHH/abnr9O
b75gF/Hp5f3KVZtW1H70ox/Ze++9169/bv78+VmfWbNmhXc1vaL5UI/w78LbSCOcz+HtFBp5jkb6
NiJ83A8++MB+8pOfZOuHRjW6vFZaB21P4fyoppG+jQgfd1sywdBFgbWd9PT02AUXXGB33XVXeFff
6/Rvob7y6+7u7ne/3/bpU6dOrfs9hf38+T/++ONsRezTfSSryM0335zd/8orr4R37bDCeYXBsT3m
eyPP2UjfRhQ97p133mkXXnhhtpw2opHltdo6aHsqmh+VNNK3EUWPO9BMMHRRYG0n8+bNy17L2rVr
w7v6Xuftt9+e/Vy6dGm/+320yaffeuutdb+nSv1aWlqy6V6whXp7e+3000/PRrg++eST8O4dVqV5
hbS2x3xv5Dkb6duIosdds2ZNNs3XE/VqdHmttg7anormRyWN9G1E0eMOJBMMbdELrPyDuXHjRrv4
4ouzYdUbb7yx734ffXn88cdt2rRp9uMf/9jOPvtse+SRR6xUKpU9yhYdHR12//33ZyM1P/vZz7Jv
Wt4v/PCHtytND2+7RYsWZaM3/vj+enzUyJ+zs7OzX79a76vosSvxb0D+PP44RfLHeuGFF7Kfjz76
aL/7/bZPzzcHhM9b7zTX2tqaTf/FL34R3pXt5+X3+be2cv68l1xyiZ122mlZYXbZZZfZwoUL+/Wp
pqurK8vcs/d5fs4559icOXO2+gzkr9k3X/i+Zj7Pf/7zn9sDDzyw1ahekfA91/t4lf4uvF3rcVwj
n/dK2tvbs8+kZ3TqqafaFVdcUbhvXj25hO+l0vT8tn9WZ8+enf3jPuOMM+zJJ5/M7vfX5F8AfLnx
1+Xvvd735MuWP6b/nb9WfxyfVuk1lKvnPbpGl2ufftttt2WP6fs03nfffdbW1lbYt1wj+db7vnMX
XXRR9rrrHTGptLwWqbUOqvd95a+9nmVhKGaCoS1ZgXXttddmP/3b1D333JPd59+wwn2Hyvv7/Tn/
APs/krDfLbfcstWHP7xdaXp42xfC8PHzlr/mXD696H2V31+Pt956K+vrRUWR/LE++uij7Ofll1/e
736/7dN9v4Ci561nms9r/5brw94+PSzi3K9//evsPl9Z5ubOndv3WGF75plnyv66mK/8rrrqqq3+
1ts111zTb8WVTy/fFJq3xx57rOxRi+V9w9u1Hq/S34W3az1OI5/3Svyfgv/DDP/e/0n5Jt5cvbnk
00Lh9Py2f8bDx3v55ZcLl82iz1DI880/v+XNd7Ku9Bpy9b7HgSzX5c+fNy/kqhXejeTbyPvO+UEs
Pn3JkiXhXYWKltdKqq2DGnlf+fRay8JQzQRDW7ICy7ftr1u3rt99L774YnafLyQrVqzIRjJWrVqV
fQv16T5iE/b1b85vvPFG9o35tddey/6xhB/+8Hal6eFtP4rOb/uQr39r8efwb+j585ar9r4ade+9
92aPtXjx4vCuTPnr9BXX5MmTs9E85z/9tn9LDPvmqk0ranfffXfhNzIvePx+Xxnn/JukT/N/sp6f
z7d8U4N/U6wl7+vz97e//W02zz1fv+3TfYQil78+n+f+OfHNmf6N16f5t9Na8r8Pb9d6vEp/F96u
9TiNfN4r8cLB+/oon49Q+Ihj/g+g/B9TvbmE76XS9Pz2ueeemz2vf+78H7dP8xGF8847L5vuz5MX
Yd63Fj8Sy/v6aJj/k/L8X3/99b5lseg15Op9jwNZrn294usX7+ufy2qfx1wj+TbyvnN+v0/39UU9
ipbXSqqtgxp5X/lrr7UsDNVMMLQlK7B8gQjlK4DwiJV8pMZHNnI+3BwuTO7ZZ5/d6sMf3q40Pbxd
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
igILSZGVDrLSQl46yEpHzKwosJAUWekgKy3kpYOsdMTMigILSZGVDrLSQl46yEpHzKwosJAUWekg
Ky3kpYOsdMTMigILSZGVDrLSQl46yEpHzKwosJAUWekgKy3kpYOsdMTMigILSZGVDrLSQl46yEpH
zKwosJAUWekgKy3kpYOsdMTMigILSZGVDrLSQl46yEpHzKwosJAUWekgKy3kpYOsdMTMigILSZGV
DrLSQl46yEpHzKwosJAUWekgKy3kpYOsdMTMigILSZGVDrLSQl46yEpHzKwosJAUWekgKy3kpYOs
dMTMigILSZGVDrLSQl46yEpHzKwosJAUWekgKy3kpYOsdMTMigILSZGVDrLSQl46yEpHzKwosJAU
WekgKy3kpYOsdMTMigILSZGVDrLSQl46yEpHzKwosJAUWekgKy3kpYOsdMTMigILSZGVDrLSQl46
yEpHzKwosJAUWekgKy3kpYOsdMTMigILSZGVDrLSQl46yEpHzKwosJAUWekgKy3kpYOsdMTMigIL
SZGVDrLSQl46yEpHzKwosJAUWekgKy3kpYOsdMTMigILSZGVDrLSQl46yEpHzKwosJAUWekgKy3k
pYOsdMTMigILSZGVDrLSQl46yEpHzKwosJAUWekgKy3kpYOsdMTMigILSZGVDrLSQl46yEpHzKwo
sJAUWekgKy3kpYOsdMTMigILSZGVDrLSQl46yEpHzKwosJAUWekgKy3kpYOsdMTMigILSZGVDrLS
Ql46yEpHzKwosJAUWekgKy3kpYOsdMTMKnmBtXjxYhszZoyNHDnSxo8fbwsWLAi7ZNasWWPDhg3r
1yqJOQOQFlnpICst5KWDrHTEzKpyFRPJsccea9OmTbNNmzbZ5MmTbeLEiWGXzOzZs+2oo44KJxeK
OQOQFlnpICst5KWDrHTEzCp5geWjV+vWrct+X7ZsmY0bNy7oscXpp59uZ5xxRji5UMwZgLTISgdZ
aSEvHWSlI2ZWyQusUaNGWalUyn7v6OiwXXfdNeixxRFHHGEHH3yw7bHHHnbIIYfY8uXLwy59Ys4A
pEVWOshKC3npICsdMbNKXmDttNNOfb/39vba8OHDy+79zD777GNz5szJirH58+fbkUceGXbp4zOA
RqPRaDQaLXaLJXmBteeee1pXV1f2u49g+YhWLT09Pbb77ruHk/vEnAFIi6x0kJUW8tJBVjpiZpW8
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
Onp6emz33XcPJ6NJ+K4RmzZtyn7v7OzMRrK2leTSyUpFg28aPO6446yjoyO8C03Kv735kZ9oXuFR
aawPNfgo1l577RVORpMYO3Zs9j/Ltbe32x/8wR8EPRonuWSyQml+fpqGCRMmZDu4o7n5tT+fffbZ
7FubD40ffvjhYRc0KdaFzc2PpvZNg15czZ07144//viwC5rE5MmTsyPefUDAR/K/+c1vhl0aJrl0
slJpfvvttx/fskW88MIL9oUvfCE70vOwww6zlStXhl3QpFiumpsXVwceeKDtvPPO2RfODRs2hF3Q
JPyUQt/+9rezzbh+QMLq1avDLg1j6QQAAIiMAgsAACAyCiwAAIDIKLAAAAAio8ACAACIjAILAAAg
MgosAACAyCiwAAAAIqPAAgAAiIwCCwAAIDIKLAAAgMgosAAAACKjwAIAAIiMAgsAACAyCiwAAIDI
KLAAAAAio8ACAACIjAILAAAgMgosAACAyCiwAAAAIqPAAgAAiIwCCwAAIDIKLAAAgMgosABIWLly
pX3+85/v+1nJsGGs1gBsf6yJAEi466677Otf/3rfz0oosAA0A9ZEAJqaF0yVmlu3bp195Stfsd13
392uu+66fgXWxx9/bMccc4ztscce9o//+I+2efPmbPro0aPt3XffzX5/7733bMyYMdnv99xzj40Y
McI+97nP2V/+5V/aM8880/dYANAICiwAEv7iL/7Cnn/++b6fueOOO84uv/zyrJjy38sLrB/84Ae2
aNEia29vt9tuu81OOeWUvulXXnll9vtVV13VN92LK5/e3d2djZR5IQYAA0GBBaDpdXZ22u///u9n
I1D+02/n9tlnH9u4cWP2+9KlS/sVWH/6p39qpVIp+72np8f222+/7PfHHnssG9FyPsL17LPPZr8f
euih2e0nnnjCWltbtzwIAAwABRaAphZuFgw3Ef7e7/1eNuLkvPAqL7B23nnnfv1HjhzZ1+9P/uRP
rKOjw/7sz/4sK77chx9+aH/913+d9dttt93sxRdf7HssAGgEBRaApnfhhRfaSSed1Pez3L777msf
ffRR9vuKFSv6FVh+X1dXV9/tcj6Cddppp9mkSZPCu7JNijNmzLA//uM/Du8CgLpQYAFoet/4xjds
1qxZfT/Lfe9737Pp06dn+2CdcMIJ/Qqs7373u/bqq69mI1VXX321/dVf/VXffV5AeV/fsT03btw4
u/POO7PNivkO7wAwEBRYAJpe+fmv/Ge5TZs22eGHH56NNt1www39Cqz169fb0UcfbaNGjbLx48fb
G2+80Xff6tWrbZdddrGWlpa+afPnz7cvfOEL2WZHL67Kiy8AaAQFFgAAQGQUWAAAAJFRYAEAAERG
gQUAABAZBRYAAEBkFFgAAACRUWABAABERoEFAAAQGQUWAABAZBRYAAAAkVFgAQAAREaBBQAAEBkF
FgAAQGQUWAAAAJFRYAEAAERGgQUAABAZBRYAAEBkFFgAAACRUWABAABERoEFAAAQGQUWAABAZBRY
AAAAkf1/CiaylzqEbfEAAAAASUVORK5CYII=

--_003_p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7kxzaxc_
Content-Type: image/png; name="zoned-raid0.png"
Content-Description: zoned-raid0.png
Content-Disposition: attachment; filename="zoned-raid0.png"; size=14942;
	creation-date="Wed, 13 Dec 2023 15:57:36 GMT";
	modification-date="Wed, 13 Dec 2023 15:57:36 GMT"
Content-ID: <9DDEF6596C72F54F9F9DA36C9E769E30@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAlgAAAFzCAYAAADi5Xe0AAA6JUlEQVR4Xu3deZBc1Xn3cRVEwoAC
fwSKEFyVKkpBlIrCRnElpHDlDzsmKGFxiK2kkjeR3hcTx1bKjp2AvGBhIRBiE7vEJjYbsQiziE2A
WCUkkIQRQoCEQdaGEAjts2/n5TnDHd0507dPX+npRzNnvp+qWzN9+86d6V8/3fP0Xc4d4gAAAKBq
SDgDAAAA+4YGCwAAQBkNFgAAgDIaLAAAAGU0WAAAAMposAAAAJTRYAEAACijwQIAAFBGgwUAAKCM
BgsAAEAZDRYAAIAyGiwAAABlNFgAAADKaLAAAACU0WABAAAoo8ECAABQRoMFAACgjAYLAABAGQ0W
AACAMhosAAAAZTRYAAAAymiwAAAAlNFgBc477zw/aXj11Vfd7bff3mveRRdd5G677Tb35JNPug0b
NvS6LyPz5X5ZTpbPq/T3ZfPy06RJk9xNN93k3nvvvV7L5m3dutUve8kll4R39XuVcqhF+HPhbdRH
mHN4ux7K/I4yy5YRrnfWrFn+fWFv7M3rtdJ70P4U5lFNmWXLCNe7L88JUA0NViB88e2tDz/80P38
5z93n3zySa/52fplkhd2JTI/v1xetXmVpvPPP9998MEHvZbPLF682C/zwAMPhHf1e5VyqEX4c+Ft
1EeYc3i7Hsr8jjLLlhGu9+OPP3Y/+9nP/PtDWWVfr0XvQftTmEc1ZZYtI1zvvjwnQDU0WIHwxbc3
Ojs73VVXXeXmzJkT3tWzfvkUKm9+HR0dve6X2zJ/ypQpNf8t4XLy+3fu3OnfiGW+bMmq5O677/b3
v/HGG+FdyQqzgo39kXuZ31lm2TIqrff+++9306dP96/TMsq8Xqu9B+1PlfIoUmbZMiqtd2+fE6Aa
GqxApRdfWYsWLfLr2Lx5c3hXz/rvvfde/3XNmjW97petTTL/nnvuqflvKVquoaHBz5eGLdTV1eUu
vPBCv4Vr9+7d4d3JKsoK9bU/ci/zO8ssW0al9W7atMnPk/eJWpV9vVZ7D9qfKuVRpMyyZVRa7948
J0CMeoOVFW/RlGlra3NPPfWUmzp1qvvJT37iLr30Ujdv3jzX3t6eW9ue9clmbjkmSTbl/vKXv3SP
PfZYxa0/zz77rJs2bZpfp6xbfke4TtHa2urmzp3rLr74YnfBBRf4hkfmhX+nqDSviHwCkq1T11xz
TXiXl63rtdde81+ffvrpXvfLbZmf7Q4If2+t80RjY6OfL48xJMd5yX3yqS1Pfu+1117rM5HG7Prr
r3dLly7ttUw19XheKwkfc63rK/q58HZsPaJMvRVpbm52jz76qH+OfvrTn7obb7yx4rF5tTwv4WMp
mp/dllqV14D84548ebJ77rnn/P3yN8nr4Re/+IX/u+Sx1/qYan1dhbdFLY9RrFixwm+Vlb9PcpfX
m2Qovycv+x0yf/bs2X6dckzjI4884pqamioum1fm+a31cWeuvvpq/3fXusWk6PVaSew9qNbHlf3t
tbwWBuNzAsTslwZLXiQzZ87sc59MN998c68Cz+bnd5ll0zPPPNOznHzCC49dyqZbbrnF35+R9d9w
ww19lpODQbPv8yrNK7Jq1Sq/rDQVlWTr+vTTT/1X+Tvysr9Ljguo9HtrmSePVT7lymZvmR82ceL5
55/398mbZWbhwoU96wqnl19+OffTldXjeS2SLRvejq2v6OfC27H1lKm3IvJPQf5hhj8v/6RkF2+m
1uclmxcK52e3H3rooT7r++1vf+ubvHB+pRoKlXldhbdrfYzyzzW8P5vk8eRl8/O/P5ukkavWeJd5
fss87oycxCLzV69eHd5VUaXXa5Fq70FlHlc2P/ZaGKzPCRCj3mCFZIuGfPqRwpVPHSLbfC2fnN95
5x3/ifntt9/2t2W+fJLNZC8GOZ5g48aNfreXfDLKr08sW7bMz5MX6fr16/3vleXlU7DMly1GGTlj
RObJp3Z5Mcnvf+utt/yZd0Uvvlo9/PDD/udXrlwZ3uXl1y9vXBMnTnQtLS3+tnyV2/IpMVw2U21e
penBBx+s+IlMGh65X96MM/JJUubJP1nJTz7tZc+VfFKMqcfzWiT7+fB2bH1FPxfejq2nTL0VkcZB
lpWtfLKFQrY4Zv8A8v+Yan1ewsdSND+7fdlll/nfK3Un/7hlnmxRuOKKK/x8+T1ZEybLxpR5XYW3
a32M2brkPllGfodseZN5Umd52e+QhvXNN9/0y0pdVqvHTJnnt8zjzsj9Ml/eL2pR6fVapNp7UJnH
lf3tsdfCYH1OgJi6NlhS1NmnYfmknh07MGPGDD8vPDU22y0mP5PJXgzvv/9+zzz5dC/zZBNxJnsD
Cs+YybYUyZaVTLbskiVLcku6nt12lV58tZLN8vLz8nsrya8/O85KmhAhX+W2HMwaLpupNq/SJJvt
165d22t52XIiu6MkP3mTysg/V/mZWpqDSurxvBYJc6h1fUU/F96OradMvRXJtvbJ7pWMrE/mSdOV
qfV5CR9L0fzstvxjy+zatatnfn5oj2w3cy3PSZnXVXi71sdYidSz/Kwcn5SX/Y4FCxb0mp/9880/
R+HfU+b5LfO4M9l6inbj5RW9XotUew8q87iyvz32Wqgk9ecEqEXdGixppmSfthSs/GPN71/PPkXs
2LEj9xPObd++3c+XTzeZ7MWQbeURskUmfJFkn4CKpvwnKdlCVOn3Z28e+fWWJZ+Y5Oeluawkv/6s
8ZBPhUKOQ5Db2ZtPpb+llnmyqVw+bcr65bgJeXPOD9Ug/0Bl+fDsQjnjKFuXbHWUA/BlS0al4xsq
qcfzWiRcrtb11Xo7tp4y9VYkW4c0N9XU+ryEf2PR/Oy2NE8ZqZlsfr528/Njyryuwtu1PsaM3Cf/
lGULm2xxC9cnsnlSf3lZPUq9ZsKfL/P8lnncGclY5ofj3FVS9HotUu09qMzjyubFXguZwfScALWo
S4MlL5bLL7/cF6u8WYafumQ3mNwXvnlmn3qqbXEomp+ts2iS+zOy/kq/X/b/h+stK/s7Ku2WE/n1
Z8dZXXnllf62fJXbckZLuGym1nkZ2Qwv9+WP9XriiSf8vPnz5+eW7N6dKweFygGh2TplkjercCtY
JfV4XouEy4W3i+aXvV00v0y9FcnWER4wHKr1eQn/RlGpQcpuh8eJhcvF5ofKvK7C27U+RvkHWenY
mnB9IpsX5pvVY/45Cn++zPNb5nFnskalljoper0WqfYeVOZxFf3t4fzB+JwAtVBvsGTzrZyJIYX6
61//us8LSWRbOsJPMdu2bfPz5RNYpujFEM6XrSNyO7Y1QGSf8MLfL592wvWWlf2DkC1IlYTrzz5p
ZacJSzbZP75w2TLzMvLpU+6TLVmZbBfCunXrckvuIcdRSGN233339WRVy2bzejyvRcLlwttF88ve
Lppfpt6KZOuo5bR7EXtesr8x/481+1S+N48xNj9U5nUV3s7EHmM2FpTsQpXjxuS4nPwJIZUO0g7z
zeoxO9ZRhH9Pmee3zOPOZEOo5LfqFom9XkPV3oPKPK6ivz2cPxifE6AWqg2WHHCYNQxycHX4CTmT
HZcVHquTHdRabT980fxsneE+90puvfVWv+wrr7zSa76cEh6ut6zsrDB5g6kkXH/25pQdj3XHHXcU
LltmXkY+/ct92WZv2S0kx0VIM1TpE25I3gjl52U3Y0w9ntci4XLh7aL5ZW8XzS9Tb0Wuu+46v478
wcjZ5VDyx2BVUul5yT615/95ZbuX9uYxxuaHyryuwtuVVHqM2bFa+bMspfHI1pffYpHNkwPn82QX
vMyXM88y4d9T5vkt87gzWQMS++BS9vUqqr0HlXlcRX97OH+wPSdArVQbrOwThgwPUE12SrbsM690
tln+RVH0Ygjny89k65SzQeSTsBy0+Pjjj/v5+cvSyItb5smbliwrv1/Ozsk+9VT6fbWSxlJ+Xj6F
VxKuP8si2/z94osvFi5bZp68GcsxEXIGkNyXPSfLly/3t++6665ey4tsF6U0RLLlSzJ86aWX/DxZ
T0w9ntci4XLh7aL5ZW8XzS9Tb0WyU+/leBUZEFI+Qd95551+Xv5MplqfFzmzS+bJkAqynGwVzX52
bx5jbH6ozOsqvF3rY8w+wL3++uv+H7ccqyVnGWbry/+Tz+bJ2bpyoLasU04oyN6nZEtLuGymzPNb
5nFnstfhb37zm/CuXqq9XotUew8q87iK/vZw/mB7ToBaqTZYWeFWm4TsNizaZy9bOfKf1PI/lxfO
l58pGoNJXmQfffRRz7KyZS0bOiI/yW6JcL2i0rwi2ZmAcsB6JeG6sl2D2SSnHxctG5tXNMnjly0j
InvzrTRisbxBhj+bTfLmE1OP57VIuFx4u2h+2dtF88vUWxH5B5Edq5if5B9WfitUrc+LDLgY3p81
bDJlwtt7Oz9U5nUV3q71MeYPhq80ZWfkimxe/vdnk2zhqLTrKlPm+S3zuDPZUArvvvtueFcv1V6v
Raq9B5V5XEV/ezh/sD0nQK32S4Ml5J+LHLwpx2vJrg359C2D14UHJYY/V22+HCgrg+vJ7hVZp3xK
kl1vlS4XIb9H/iFl1wSUUYXl5yutt9K8IvImIOuUf5yVhOuSN4JsC4/8HbEmpNq8/CSPX/4OeUPZ
smVLz7KSjdwfnuqckeucybgy8oYlx23J95XG0ylSj+e1knC58HbR/LK3q80vU29FpJGS50hqQHaF
yS6SSs1ZLc+LNLjyaV4aNDkOR5qr7LiSvX2M1eZXUuvrKrwtanmMsiVCtsbKY5TlpKGXBuyFF17w
65N/0pnsd8jvl4zl75HnSOqzlnos8/zW+rgz8v4gW3mKDqPIxF6vlcTeg2p9XEV/ezh/sD0nQK1U
Gyx0y/bzy6ZyAMjLrjcqW+3qhfegciyeEww+NFh1IJ+AZAww+cQEAHmyxUUOpK7nlhLeg8qxeE4w
+NBg1YkcWyWbpbMxrQDA8n3B8ncNZOSEeqHBqiM5nTh//AGAwU3eD2T3nRXeg+KsnxMMHjRYAAAA
ymiwAAAAlNFgAQAAKKPBAgAAUEaDBQAAoIwGCwAAQBkNFgAAgDIaLAAAAGU0WAAAAMposAAAAJTR
YAEAACijwQIAAFBGgwUAAKCMBgsAAEAZDRYAAICyujdYixYtcl/+8pfdwQcf7E4++WS3atWqcBFv
5cqVbuTIkW7YsGFu9OjRbsmSJeEiAAAAA0LdG6zjjjvOzZ071zU1NbmpU6e6r371q+Ei3rhx49y0
adPcjh073MSJE93YsWPDRQAAAAaEujdYeY2Nje7QQw8NZ3uy9WrLli3++7Vr17pRo0YFSwAAAAwM
pg3W+vXr3Ve+8pVwtjd8+HDX3t7uv29paXGHHHJIsAQAAMDAYNpgXXLJJe7xxx8PZ3sHHnhgz/dd
XV3ugAMOyN3b26ZNm9yyZcuYmJiYmJiYmNSm1atXhy3HXjNrsFasWOF+/OMfh7N7HHHEEa6trc1/
L1uwZIsW9o0UC+yQtz0yt0Xe9sjclmbeJg2W7Bo855xzfONU5IQTTnAbN27038vyxx9/fLAEytIs
FMSRtz0yt0Xe9sjclmbedW+wZJiGMWPG+APcq5kwYYKbMmWKa2hocJMmTXLjx48PF0FJmoWCOPK2
R+a2yNsemdvSzLvuDdaxxx7rhgwZ0mvK5L9funSpGzFihBs6dKg/o1DGxcK+0SwUxJG3PTK3Rd72
yNyWZt51b7Cw/2gWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNse
mdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgri
yNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRp
FgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28a
rIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5L
M28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97
ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnb
Im97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjb
HpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK
4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyE
aRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNv
GqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2Ru
SzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJv
e2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z
2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI
2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkW
CuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqs
hGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbksz
b5MGa+vWre6YY44JZ/eyadMmN2TIkF4T9o1moSCOvO2RuS3ytkfmtjTzrnsXs3r1anfSSSdFG6a5
c+e6M888M5yNfaBZKIgjb3tkbou87ZG5Lc28q3c9Co466ig3a9asaIN14YUXusmTJ4ezsQ80CwVx
5G2PzG2Rtz0yt6WZd/WuR8HmzZv911iDdfrpp7uTTz7ZHX744e6UU05x69atCxdBSZqFgjjytkfm
tsjbXoqZ72rqch/t6Du9/3GnW762o8+0+Hcd7ukV7X2mR19vc3e93He67YVWd9ljLX2mqY+2uB/9
urnv9Ktm9y83NPpJM+/qXY+iWIN19NFHu3nz5rn29na3ePFid8YZZ4SL9JDjtSQEJiYmJiamwTS9
uuS37pkFb/aZ5r30pnvgmXf6TPc9/Y67ee7vKk6X3re24jTxzo3u/Ds/7DP9500fu+/M/KTP9M/X
bnPfmr69zzTmst3ua5c0DKhJMtZSvetRFGuw8jo7O91hhx0WzkZJmoWCOPK2R+a2yLt2nV2uZ8vM
Ox92b5nJb4nJtrZc93T31pYpD+/ZuvJvM5r81pQzr2rs0wCkMJ11VffWonD6zq1NfbcufTb97P7m
PlujZLrmqdY+W69kuueVtj5bu2R69q32PlvH/LSuo+e50qzx2ruefVSmwZKtWEceeWQ4GyVpFgri
yNsemdtKPe/PeqKef7SrNnU3Ra+9v6cpuntB9z/wG57pbooueSTXFM3sboqkeQgbCs3ptMsa+jQm
MsnvDxsTmf7nnsrNiUx3vly5QXlyed/mRKalayo0J59N67Z09tndJ1NTqyQ6sGjWeO1dzz6KNVjH
HXec3zUozdXChQvdueeeGy6CkjQLBXHkbY/MbfXXvDd//g999UfdTdGSD/Y0Rb9aGDRFueNwxt3U
3RR9c7p+U/T1qXsaoe/f0d38/PS+Pc3OHS91NzcPLe3e2vLcyj1bVzZu7W5YdjXrblFBnGbe1bse
RZUarPw8aa5OPPFEd9BBB7kxY8a4bdu25ZbE3tAsFMSRtz0yt6WZ98c7u5ui9z5vimTrSNYUyS4e
aT5mPNvdFF2aa4rG39zdFJ19tX5TJFPWFH3v9u6maOK9e5qi21/sbop+s6S7KZqf2+W0/tPupmhn
k+5WG83MEaeZd9+uB8nQLBTEkbc9Mre1YPEbvon43ebupuj1XFM0e1F3UzRzfndTNG3unqbo/2ZN
0TX1aYr++frupui7s7qbovNn72mK5Iwy+bsefK27Kcofh7Pu86ZoR6NuU6SJGrelmTcNVsI0CwVx
5G2PzOujsbX7GKTH32h3Nz7b6hsW7ebonz5viv7jtu6m6LwKTdGcV/ccrJw1RWs/P95ne0P/bYo0
UeO2NPOmwUqYZqEgjrztkfm+aetwfmvU/JXt7ubnWt3PH+geDyhshrJpzGW7/P3nfn621//mDqC+
5fnupuj+Ck3Rmk+6m6Ktg6Qp0kSN29LMmwYrYZqFgjjytkfmten6rK+RLT8vvdvuzxy78MEWv9vu
6xWaKJnkTDXZsiQHhN+3uM0PLyAHkpO3PTK3pZk3DVbCNAsFceRtj8z7+mh7l1v0XodvjC5+pMVv
bfrbaX2bKJnkTLf/d0uT++VvWvwQBC+vaven3BdtZyJve2RuSzNvGqyEaRYK4sjb3mDOfFtDlx+O
QA7evvKJFn/W299fUbx7719vbHQXPNDsd+U9/3a7vyxJe0e41uoGc977C5nb0sybBithmoWCOPK2
Nxgyl7GQVqzvcI8s6x71+79/1ezOqjJu0z9e0+iHFpAhDmTASDlYXWvAx8GQd39D5rY086bBSphm
oSCOvO2llLk0QdIMSVMkzZE0SdIshQ1UNkmT9cO7m92181p98yVNmDRj9ZRS3gMFmdvSzJsGK2Ga
hYI48rY3EDOX3XKye05208nuOtltJ7vvwgYqm2S3n+z+u+LxFjfntTa/W1B2D+4PAzHvgY7MbWnm
TYOVMM1CQRx52+vvmcsB43LguBxALgeSywHlfzO1bxMlkxyILgeky0V/5QD1V97rcJu2759Gqkh/
zztFZG5LM28arIRpFgriyNtef8lchjCQoQykMZKhDWSIAxnqIGyiZJKhEWSIBBkqQa5HJ0MnyBAK
MpRCf9df8h5MyNyWZt40WAnTLBTEkbc968y3N3a5ZWs6/LXopj/Z4i/ie/qVxbv3ZFBOGbxTBvGU
wTxlUE8Z3HOgss4bZG5NM28arIRpFgriyNtevTLf3dzlVm7oPnPv+qdb/ajl36xy5p5cRkYuJyOX
lZHLy7z7Yae/3Exq6pU3ipG5Lc28abASplkoiCNve/uaeXObc6s/6nTz3mx3M+a3up/e1+y+fW1x
I3XmVY3uB3d1n7n38NI2t3xdh9vZlF4jVWRf80Z5ZG5LM28arIRpFgriyNterZln19x77vNr7smZ
e/9nRlOfBiqb/u7yBvefs5rc5Y+1+AsOv/Z+h/t09+BppIrUmjf0kLktzbxpsBKmWSiII297Yead
n/VAcmFhOXBcDiCPXXPv1GkN7ju3NrmLHm5xsxe1uYWrO9zGbZ291ok9wrxRf2RuSzNvGqyEaRYK
4sjb1rpPO91dT652v17Y5i56qMWd81mjdOqlfZsomfLX3JOLHUsD9vtPBsaZe/0JNW6PzG1p5k2D
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
rSKbNm3yIfTn6flXlrvLH/i9+8fp23qanL+Zutv9162b3d1PrXZLl73e52fKTk++uMJd85sP3IRb
Nrsxl+3u1VCdeulud+7MT/zf8Mjzb/f5WSYmJiYmJqa+k5bqXY+iWIN1wgknuI0bN/rv169f744/
/vhgiYFr2ZoOd9FDLe5vcxeelgE5Z73Y6j4qsTVJjuuav7LdXf5Yi79odbjb75xbmtyM+a1uyQcd
rqVNtxNHHHnbI3Nb5G2PzG1p5l2961EUa7AmTJjgpkyZ4hoaGtykSZPc+PHjw0UGPGmQ5rza5sbn
hkKQA+TPm93sh0AIx5SS4SFe/6w5k0vN/MdtfYdP+NY1jf7sxadXtLtPd/dt1DQLBXHkbY/MbZG3
PTK3pZl39a5HUaUGKz9v6dKlbsSIEW7o0KH+jEIZFytlb63v8JeUkSEesobp7Ksb3cz5re6+xW2+
6crfJ9OYyxvcxHub/VmKtVy+R7NQEEfe9sjcFnnbI3Nbmnn37XpgqqGlyz2yrK3iFiqZ5JI9tz7f
6n77+w7XVnKYLc1CQRx52yNzW+Rtj8xtaeZNg9WPyOV3ZFiFKx5vcc+/3e52NvXd7VeGZqEgjrzt
kbkt8rZH5rY086bBSphmoSCOvO2RuS3ytkfmtjTzpsFKmGahII687ZG5LfK2R+a2NPOmwUqYZqEg
jrztkbkt8rZH5rY086bBSphmoSCOvO2RuS3ytkfmtjTzpsFKmGahII687ZG5LfK2R+a2NPOmwUqY
ZqEgjrztkbkt8rZH5rY086bBSphmoSCOvO2RuS3ytkfmtjTzpsFKmGahII687ZG5LfK2R+a2NPOm
wUqYZqEgjrztkbkt8rZH5rY086bBSphmoSCOvO2RuS3ytkfmtjTzpsFKmGahII687ZG5LfK2R+a2
NPOmwUqYZqEgjrztkbkt8rZH5rY086bBSphmoSCOvO2RuS3ytkfmtjTzpsFKmGahII687ZG5LfK2
R+a2NPOmwUqYZqEgjrztkbkt8rZH5rY086bBSphmoSCOvO2RuS3ytkfmtjTzpsFKmGahII687ZG5
LfK2R+a2NPOmwUqYZqEgjrztkbkt8rZH5rY086bBSphmoSCOvO2RuS3ytkfmtjTzpsFKmGahII68
7ZG5LfK2R+a2NPOmwUqYZqEgjrztkbkt8rZH5rY086bBSphmoSCOvO2RuS3ytkfmtjTzpsFKmGah
II687ZG5LfK2R+a2NPOmwUqYZqEgjrztkbkt8rZH5rY086bBSphmoSCOvO2RuS3ytkfmtjTzpsFK
mGahII687ZG5LfK2R+a2NPOmwUqYZqEgjrztkbkt8rZH5rY086bBSphmoSCOvO2RuS3ytkfmtjTz
psFKmGahII687ZG5LfK2R+a2NPOmwUqYZqEgjrztkbkt8rZH5rY086bBSphmoSCOvO2RuS3ytkfm
tjTzpsFKmGahII687ZG5LfK2R+a2NPOmwUqYZqEgjrztkbkt8rZH5rY086bBSphmoSCOvO2RuS3y
tkfmtjTzpsFKmGahII687ZG5LfK2R+a2NPOmwUqYZqEgjrztkbkt8rZH5rY086bBSphmoSCOvO2R
uS3ytkfmtjTzpsFKmGahII687ZG5LfK2R+a2NPOmwUqYZqEgjrztkbkt8rZH5rY086bBSphmoSCO
vO2RuS3ytkfmtjTzpsFKmGahII687ZG5LfK2R+a2NPOmwUqYZqEgjrztkbkt8rZH5rY086bBSphm
oSCOvO2RuS3ytkfmtjTzpsFKmGahII687ZG5LfK2R+a2NPOmwUqYZqEgjrztkbkt8rZH5rY086bB
SphmoSCOvO2RuS3ytkfmtjTzpsFKmGahII687ZG5LfK2R+a2NPOmwUqYZqEgjrztkbkt8rZH5rY0
86bBSphmoSCOvO2RuS3ytkfmtjTzrnuDtXLlSjdy5Eg3bNgwN3r0aLdkyZJwEW/Tpk1uyJAhvSbs
G81CQRx52yNzW+Rtj8xtaeZd9y5m3Lhxbtq0aW7Hjh1u4sSJbuzYseEi3ty5c92ZZ54ZzsY+0CwU
xJG3PTK3Rd72yNyWZt51b7Bk69WWLVv892vXrnWjRo0Kluh24YUXusmTJ4ezsQ80CwVx5G2PzG2R
tz0yt6WZd90brOHDh7v29nb/fUtLizvkkEOCJbqdfvrp7uSTT3aHH364O+WUU9y6devCRVCSZqEg
jrztkbkt8rZH5rY08657g3XggQf2fN/V1eUOOOCA3L17HH300W7evHm+GVu8eLE744wzwkV6yPFa
EgITExMTExMTk+akpe4N1hFHHOHa2tr897IFS7ZoxXR2drrDDjssnI2SNAsFceRtj8xtkbc9Mrel
mXfdG6wTTjjBbdy40X+/fv16d/zxxwdL9CVbsY488shwNkrSLBTEkbc9MrdF3vbI3JZm3nVvsCZM
mOCmTJniGhoa3KRJk9z48ePDRbzjjjvO7xqU5mrhwoXu3HPPDRdBSZqFgjjytkfmtsjbHpnb0sy7
7g3W0qVL3YgRI9zQoUP9GYUyLlYmP9aVNFcnnniiO+igg9yYMWPctm3beu7D3tEsFMSRtz0yt0Xe
9sjclmbedW+wsP9oFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjb
HpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK
4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyE
aRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNv
GqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2Ru
SzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJv
e2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z
2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI
2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqshGkW
CuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbkszbxqs
hGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tkbksz
bxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsib3tk
bkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNsemdsi
b3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgriyNse
mdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRpFgri
yNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28arIRp
FgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzNvGqyEaRYK4sjbHpnbIm97ZG5LM28a
rIRpFgriyNsemdsib3tkbkszbxqshGkWCuLI2x6Z2yJve2RuSzPvujdYK1eudCNHjnTDhg1zo0eP
dkuWLAkX8WpdDrXTLBTEkbc9MrdF3vbI3JZm3nVvsMaNG+emTZvmduzY4SZOnOjGjh0bLuLVuhxq
p1koiCNve2Rui7ztkbktzbzr3mDJVqktW7b479euXetGjRoVLNGt1uVQO81CQRx52yNzW+Rtj8xt
aeZd9wZr+PDhrr293X/f0tLiDjnkkGCJbrUuh9ppFgriyNsemdsib3tkbksz77o3WAceeGDP911d
Xe6AAw7I3btHrcuhdpqFgjjytkfmtsjbHpnb0sy77g3WEUcc4dra2vz3smVKtlRVUuty4uabb3Z/
/ud/zsTExMTExMSkNl155ZVhy7HX6t5gnXDCCW7jxo3++/Xr17vjjz8+WKJbrcsBAAD0d3VvsCZM
mOCmTJniGhoa3KRJk9z48ePDRbxalwMAAOjv6t5gLV261I0YMcINHTrUnyko411lhgzZ8+urLQcA
ADCQ1L3BAgAAGGxosAAAAJTRYAEAACijwQIAAFBGg5WgTZs2+RMI8hP0bd261R1zzDHhbC5cXidF
eVPv9bFo0SL35S9/2R188MHu5JNPdqtWreq5jxrXVy1valyf1LDk/IUvfKFP3lr1zbOUoLlz57oz
zzwznA1Fq1evdieddFLFNzouXK6vWt7Ue30cd9xxPtumpiY3depU99WvfrXnPmpcX7W8qXF90sze
fvvtbufOne7aa6/1TVZGq777vlthwLvwwgvd5MmTw9lQdNRRR7lZs2ZV/IfPhcv1Vcubeq+/xsZG
d+ihh/bcpsbrK8ybGq+v3bt3+y1ZGa367vtuhQHv9NNP99344Ycf7k455RS3bt26cBHso82bN/uv
lf7hc+FyfdXypt7rT66u8ZWvfKXnNjVeX2He1Hj9yODmF1xwgTvrrLN65mnVd993Kwx4Rx99tJs3
b54vkMWLF7szzjgjXARKKv3D58Ll9VMpb+q9/i655BL3+OOP99ymxusrzJsar49du3a5P/qjP/ID
nD/66KM987Xqu++7FZLS2dnpDjvssHA2lFT6h1/mwuUop1LeedS7vhUrVrgf//jHveZR4/VTKe88
alzfvffe6774xS/23Naq7+rvVhjw5BPPkUceGc6Gkkr/8Llwef1UyjuPetcl9XvOOef4fzJ51Hh9
FOWdR43rk2Ow5OzNjFZ9V3+3woAkZ6PIZmR5IS5cuNCde+654SJQUukfPhcur59KeVPv9SHDBowZ
M8YfcB2ixvVVy5sa1ycHsi9YsMC1tra6OXPmuNNOO63nPq367vtuhQFPXognnniiO+igg/wLdtu2
beEiUFLpHz4XLq+fSnlT7/Vx7LHH+rzzU4Ya11ctb2pc32uvvea+9KUv+bM1Tz31VLdhw4ae+7Tq
u++7FQAAAPYJDRYAAIAyGiwAAABlNFgAAADKaLAAAACU0WABAAAoo8ECAABQRoMFAACgjAYLAABA
GQ0WAACAMhosAAAAZTRYAAAAymiwAAAAlNFgAQAAKKPBAgAAUEaDBQAAoIwGCwAAQBkNFgAAgDIa
LAAAAGU0WAAAAMposAAAAJTRYAEAACijwQIAAFBGgwVgQNiwYYP74he/2PO1yJAhvK0B2P94JwIw
IMyZM8d961vf6vlahAYLQH/AOxGAfk0apqJJbNmyxX3ta19zhx12mLvtttt6NVg7d+50Z599tjv8
8MPdN7/5Tbdr1y4/f8SIEe7999/333/wwQdu5MiR/vuHHnrIDR061H3hC19wf/mXf+lefvnlnnUB
QBk0WAAGhL/4i79wr776as/XzDnnnONuuOEG30zJ9/kG64c//KFbsWKFa25udrNnz3bnnXdez/wZ
M2b472fOnNkzX5ormd/R0eG3lEkjBgB7gwYLQL/X2trq/vAP/9BvgZKvcjtz9NFHu+3bt/vv16xZ
06vB+tM//VPX3t7uv+/s7HTHHnus//6ZZ57xW7SEbOFasGCB//4b3/iGvz1//nzX2NjYvRIA2As0
WAD6tXC3YLiL8A/+4A/8FichjVe+wTrooIN6LT9s2LCe5f7kT/7EtbS0uD/7sz/zzZf45JNP3F//
9V/75Q499FC3bNmynnUBQBk0WAD6venTp7sf/ehHPV/zjjnmGPfpp5/679evX9+rwZL72traem7n
yRasCy64wI0fPz68y+9SvPXWW90f//Efh3cBQE1osAD0e9/+9rfdAw880PM17/vf/767/PLL/TFY
3/ve93o1WN/97nfd8uXL/Zaqm266yf3VX/1Vz33SQMmycmB7ZtSoUe7+++/3uxWzA94BYG/QYAHo
9/LjX8nXvB07drjTTjvNb2264447ejVYW7dudWeddZYbPny4Gz16tHv77bd77vvwww/dwQcf7Boa
GnrmLV682H3pS1/yux2luco3XwBQBg0WAACAMhosAAAAZTRYAAAAymiwAAAAlNFgAQAAKKPBAgAA
UEaDBQAAoIwGCwAAQBkNFgAAgDIaLAAAAGU0WAAAAMposAAAAJTRYAEAACijwQIAAFBGgwUAAKCM
BgsAAEAZDRYAAIAyGiwAAABlNFgAAADKaLAAAACU0WABAAAoo8ECAABQ9v8Bn5cihxwW5uIAAAAA
SUVORK5CYII=

--_003_p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7kxzaxc_--

