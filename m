Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4935B731
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Apr 2021 00:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhDKWVE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Apr 2021 18:21:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37830 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhDKWVB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Apr 2021 18:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618179644; x=1649715644;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9lbrrzj3lTR+ECRaxAbiWvNJk0fcFU0dkROkt5Mc06M=;
  b=lJKJ96oj2+cBeWg6FM9y4ufPPKiPBgJ1p2EFq5INBJq236dOMSJdZCrx
   66VHV4ey5cKTJrByMCpnL554zPO0Y4FV5PDcesguqhcL3SgRTtsIVHIce
   RVO6CCJO1Ho23tULl5f1If40OsrCQENqquy6CI4sWZudBoFIsJb/qZiJD
   +xmTLNt8PhAOMGbxEfyaVeo33amjPw6uMiEVi14DX1rCqafE8XRxJb2Do
   lVRzKCr8+O4BjpjFUDVmEYIXeHV3NBvAwBIXHRSsBdULY89BaCqEmONW9
   +aON9acDa7kc6Wffon4n81Y4MhJbyPt6kDIDO3yMPCQpiWdB1e6cYnAH+
   g==;
IronPort-SDR: 0/HBgBqgKXxe3r1j7t5qHJmjCgI+s597UAuRUWNidZvFsEx5/NlVvwvO7i62rc6I8b0oyyeNS4
 ptyAN8SKhFMhb+nZr1EHq36q8vFUnUGAzfZYqA+G3ztn+ThKhXNU3+J//gvH3Aclojrz6p0RvM
 WyIMf/DoEasfayF6nK+vFB9G9Sh9j4Y7gxGLGQHoQMaYHn0UO92wlcQBIEr1HxxhGJfzIu/zPT
 tfySPTPXDEHhXOsOI3ksjAr1s6NPKBecLYaYKryQtfs63i2w5wBZ6Q4MiHt8E0rhcXjcyNDfU/
 DjQ=
X-IronPort-AV: E=Sophos;i="5.82,214,1613404800"; 
   d="scan'208";a="164096644"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2021 06:20:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhgyC1AJS4K5offkbo3d8nN8e6qqUtueNZKgR3bAzxC1P0VGXqgTm3WwWv3AA2+iJ0wfVr4Y5YDQBy0nRCxYRp0jW7vWl36PL/EnNW8n8ENvsKPomR88sxzdzU95VQrFgveVRdFvMGxYXzRT1Q4ZEDWX0Q1V5BskgNVdifnsn/xpj+Ablh1uRMPFcu9LC3goWn1P/T0FPraVsr8sO/yVjjZCyBhz19WGE4OifcqPeObSg3NgD9/5xWTvYnyw9+xryEyVaJzz4p6eNNXMDslWmTjIgx7eq5o2B01Xjb0CKs8WKsYtpxlSmKwNlDy2xLddTa1xZ5iTlRa6jWL4nVpqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PiA20R91Akv3x8E9rySPcXxOUfKrcmfj+sAveujlRI=;
 b=Q865PllmPYc17vCwGciaSkIf7QDWXkpMLhOUZAzLXoHr3uEgMNrbf4nNfbxDPg8ZDCdAyqdNl2y0FOefpB2SO3cQf3joIsWtnPqESE1vdQE0UJiT6hSmAb5oL4FK1pXGg0tOARb6tlXo9bFIH8pmlyqS3Unwcvv3YdbUTGmLCiFOgebzf7FqYuasCMp41WNBkrY28/RiCx0mLvlAv2hTKjDcA5cwb6j4vuZz0kt5eZ4mFgA+LJOljoAsjxpqKWFbVZ4yF+gAm/BFvcu5ka9sdpz8HFZ4XG6ODwLGWFJR5aY9lJxOUw9NlzGlXQ0XHPUexQbAzHltbHirHlwgufhvbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PiA20R91Akv3x8E9rySPcXxOUfKrcmfj+sAveujlRI=;
 b=RF9MSC4ej3j1ZOk5G1udfLC0/rRsWclD94VJWTg+FAcG7glSNJAttyilaqWfVWKYIi8xgyR3jIDcmxWccH/veK+bt+9QSMYIZ4eQRThtZ7Gmql4rU0qpgpinxl8d0y0L6keNx+oieKqB916M4UIdyheVyrZQWug8/sMOt599zRg=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB7038.namprd04.prod.outlook.com (2603:10b6:208:1e6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Sun, 11 Apr
 2021 22:20:10 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4020.022; Sun, 11 Apr 2021
 22:20:10 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v3] btrfs: zoned: move superblock logging zone location
Thread-Topic: [PATCH v3] btrfs: zoned: move superblock logging zone location
Thread-Index: AQHXLfJi+V+rFhco10y/kPzTmZ2Fnw==
Date:   Sun, 11 Apr 2021 22:20:10 +0000
Message-ID: <BL0PR04MB651442E6ACBF48342BD00FEBE7719@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210410101223.30303-1-dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1134:9421:2151:4ee3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e4bcde7-b1a8-43f9-4aba-08d8fd37f86a
x-ms-traffictypediagnostic: MN2PR04MB7038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB703892FDDA1049C23D4CD259E7719@MN2PR04MB7038.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOFXUINMhUB22jBu+eCwL1tOQgzyWgja6azBehlBVtjGNgFLjxwBfEPkqY4CKGfe4fG58o54aL7Ddkw/dwvGfUP9kXyg27MRU0E8btMC2z8hR8pxD64xMQQLk7oEJcpJiZWWlfUwcKzPQ5xYVjOSLnHyuDKfzru13CJUT/HLU1d5+y4Xww+27xj1oEXtHrrlfbmWLSZgEYzpYnlVAhR98Htvr021hPr5kpCG/PAJyS3P22X5744n4cz+Prt5YfP+pxYFwlsmCS5fh8vARWIwIpEg/PdLqJgUrcJ2GFBd+OcYYDjGuFlhtWbO6Sfp3WUZdWUEwvumNvZ5bJemtdbZ73Iua8GmDxzdoO9GsDDFOtmExefAt4yT8G5kTqrGnZ2i03jpk5hmt0G6V55ccKY/ZyhxmMK4rK9qF3TmYk2SIlp8MjRV7m0gbWXFInK5AOVtUwHAimai74Dli9YrBqaPiJDraBFBMHEFV7iBwNPGwcNUa5VyQ8sNySTOVLr+95UjcXSb1jutKrIkoq8X8XaG6mRoBofoxOyhlw/+KjOdawHPcy7b9al6sO2WfclAW5hpCyagyhAmxddLrIkKz+C3FLlHcMWhmun8KJb7DZCMGJ7sCNvmby/Q5OwyXo1cs9ckPW0CfpikgTQlfVdEflhsdLW/a0Xk/S6uDVQLEqB9VMeHGZdvnfkLoZg0QnZWg/yj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(38100700002)(71200400001)(316002)(110136005)(4326008)(54906003)(66946007)(8676002)(53546011)(66556008)(66476007)(55016002)(66446008)(86362001)(186003)(2906002)(9686003)(8936002)(64756008)(6506007)(76116006)(5660300002)(7696005)(478600001)(966005)(83380400001)(33656002)(91956017)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YV9NfhWWkTOh5H7b9aEQWIXx+KUIxR7h4sQlpJzrvAVo8dbqCkwvXn3mhsgZ?=
 =?us-ascii?Q?D/mEEemx/fdfvziuL+l3K7lHtRqVJ5NrgCbtNPtvfYl7ARsD5qjiKAQobEnP?=
 =?us-ascii?Q?pqiaN1F+BlbZKqpRoKmoJzuE0+Wfu1MtPpWsamhH90clugSgO+oHiTUYPVPZ?=
 =?us-ascii?Q?wYkNytEL/xzVI7pOVCPJaXqn0YRb+cOJo2+n9JVLceXgZmf8imhdHCZuP4as?=
 =?us-ascii?Q?nXqXAoVnsYx5t54c6fjWAjujUlELUEYwdKozrFVTUKjnFpdERrOd6dqYuv9u?=
 =?us-ascii?Q?u21CqVoHX8CtczNeStB+xBF1yEExw3EiCoPJ8TGV6vLjUUCQmitGPXSGdOgn?=
 =?us-ascii?Q?fWq+vTsOt/e/fzUqiC5KXN/DkKevV8yeGYwJ+JtinAYxpPA7yKKWjPLvSKcB?=
 =?us-ascii?Q?T4/fRwj1y17htk3lHVq8iqH+TNV6DwjFDHFBxikyD09QoXNnxLJDoiSAy5Ok?=
 =?us-ascii?Q?47haDTo38xRaWJzlv6ctkZMdxYlUtUOHLS/ueGMzd1+8Q/l9avzmp/BqLFOm?=
 =?us-ascii?Q?ypOqhKKqB/6d8M8uyqMnqmWp3IXL+SOEs1gcevL/HEh4mo7LDwI3cByovjr5?=
 =?us-ascii?Q?pLdo52RaoZlSVecjbbWBtRlD+2xuyb9xFE395E1Gy8i4o5S+Mz7RXZjdtK66?=
 =?us-ascii?Q?mPrKeGhmdFJYYya8CMeBrxTJms3gl3kiPWatWDwiSFkAhLCDxJRgznNTdyP4?=
 =?us-ascii?Q?INbUG+Cx0cRVqH5VzCF0iuG0BuY8mf2WIpcqqDE/SeWeYfOPV/njpOZB2aw7?=
 =?us-ascii?Q?nIN0ldESJrBT8gUAdu2Hf42cTuqJOTsRNmLRcHC8YHvNH7lptOh9YWRWQLqQ?=
 =?us-ascii?Q?wWeS4Wq/RQ3vmXzcvA3H/jjsSQICOw4zQ6+u1EPwDIKlapUlDRbA/1/Qpbti?=
 =?us-ascii?Q?CqS4KqtK3D5icAfWYkrigR0sHf5vEq9gCFYkdYKRRz0Eg3ilQL0JzTq6z12S?=
 =?us-ascii?Q?tIojRVRWVl4/dkMtPDh7og6KuH5Okri1hC7Nnfwe+2DygbKLiH1Vf08LST2F?=
 =?us-ascii?Q?Nh99NgRndVjqZ43waOB7H3Y8nAASyAwbcVywN22THfRW8AByz4RzJ3e7oGKE?=
 =?us-ascii?Q?CpxJWTJ8/nyVqoEgkUBsBFjEL7+S0JfeVxOaiimIcqtwxoJhXZBAVnw/5SpH?=
 =?us-ascii?Q?16xvMNlwze1CItEGLXenFZh2kcHc0O+4nXsgDdgF8WCthXokAgADyo343KWP?=
 =?us-ascii?Q?wT/UkjYLm8/Cg1WquPA5K/CMn7k7AbjmoVtjPYiI06FTpqLfoA1Vm1S/pWDd?=
 =?us-ascii?Q?N9q3zKVWVQdA3TwS6GnT50hmkw9ymBbA3gPRlj4O1S9B303ibWk9I8uHVtcT?=
 =?us-ascii?Q?vZQDqH/PP4rSBc/fiR2PCRNgIPunyow5Jm9d5cbcMDCm5aN/40Rjs1rfZ+ph?=
 =?us-ascii?Q?lXdyIGtEblFxY15V4cm03GnzEFLOm0j2gCfdoCR/c5GDyjnnmQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4bcde7-b1a8-43f9-4aba-08d8fd37f86a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 22:20:10.4544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzJciUmkByIlmA7bMIPjWgAlDElpwV11fHBUwDcXR8vndjcCDWNEbqBcQs7OcHLDHfHshm9AOMhvlMJy2ek6bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7038
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/04/10 19:15, David Sterba wrote:=0A=
> From: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> =0A=
> Moves the location of the superblock logging zones. The new locations of=
=0A=
> the logging zones are now determined based on fixed block addresses=0A=
> instead of on fixed zone numbers.=0A=
> =0A=
> The old placement method based on fixed zone numbers causes problems when=
=0A=
> one needs to inspect a file system image without access to the drive zone=
=0A=
> information. In such case, the super block locations cannot be reliably=
=0A=
> determined as the zone size is unknown. By locating the superblock loggin=
g=0A=
> zones using fixed addresses, we can scan a dumped file system image witho=
ut=0A=
> the zone information since a super block copy will always be present at o=
r=0A=
> after the fixed known locations.=0A=
> =0A=
> Introduce the following three pairs of zones containing fixed offset=0A=
> locations, regardless of the device zone size.=0A=
> =0A=
>   - primary superblock: offset   0B (and the following zone)=0A=
>   - first copy:         offset 512G (and the following zone)=0A=
>   - Second copy:        offset   4T (4096G, and the following zone)=0A=
> =0A=
> If a logging zone is outside of the disk capacity, we do not record the=
=0A=
> superblock copy.=0A=
> =0A=
> The first copy position is much larger than for a non-zoned filesystem,=
=0A=
> which is at 64M.  This is to avoid overlapping with the log zones for=0A=
> the primary superblock. This higher location is arbitrary but allows=0A=
> supporting devices with very large zone sizes, plus some space around in=
=0A=
> between.=0A=
> =0A=
> Such large zone size is unrealistic and very unlikely to ever be seen in=
=0A=
> real devices. Currently, SMR disks have a zone size of 256MB, and we are=
=0A=
> expecting ZNS drives to be in the 1-4GB range, so this limit gives us=0A=
> room to breathe. For now, we only allow zone sizes up to 8GB. The=0A=
> maximum zone size that would still fit in the space is 256G.=0A=
> =0A=
> The fixed location addresses are somewhat arbitrary, with the intent of=
=0A=
> maintaining superblock reliability for smaller and larger devices, with=
=0A=
> the preference for the latter. For this reason, there are two superblocks=
=0A=
> under the first 1T. This should cover use cases for physical devices and=
=0A=
> for emulated/device-mapper devices.=0A=
> =0A=
> The superblock logging zones are reserved for superblock logging and=0A=
> never used for data or metadata blocks. Note that we only reserve the=0A=
> two zones per primary/copy actually used for superblock logging. We do=0A=
> not reserve the ranges of zones possibly containing superblocks with the=
=0A=
> largest supported zone size (0-16GB, 512G-528GB, 4096G-4112G).=0A=
> =0A=
> The zones containing the fixed location offsets used to store=0A=
> superblocks on a non-zoned volume are also reserved to avoid confusion.=
=0A=
> =0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> Signed-off-by: David Sterba <dsterba@suse.com>=0A=
> ---=0A=
> =0A=
> For context see replies under=0A=
> https://lore.kernel.org/linux-btrfs/2f58edb74695825632c77349b000d31f16cb3=
226.1617870145.git.naohiro.aota@wdc.com/=0A=
> =0A=
>  fs/btrfs/zoned.c | 53 ++++++++++++++++++++++++++++++++++++++----------=
=0A=
>  1 file changed, 42 insertions(+), 11 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
> index 1f972b75a9ab..eeb3ebe11d7a 100644=0A=
> --- a/fs/btrfs/zoned.c=0A=
> +++ b/fs/btrfs/zoned.c=0A=
> @@ -21,9 +21,30 @@=0A=
>  /* Pseudo write pointer value for conventional zone */=0A=
>  #define WP_CONVENTIONAL ((u64)-2)=0A=
>  =0A=
> +/*=0A=
> + * Location of the first zone of superblock logging zone pairs.=0A=
> + *=0A=
> + * - primary superblock:    0B (zone 0)=0A=
> + * - first copy:          512G (zone starting at that offset)=0A=
> + * - second copy:           4T (zone starting at that offset)=0A=
> + */=0A=
> +#define BTRFS_SB_LOG_PRIMARY_OFFSET	(0ULL)=0A=
> +#define BTRFS_SB_LOG_FIRST_OFFSET	(512ULL * SZ_1G)=0A=
> +#define BTRFS_SB_LOG_SECOND_OFFSET	(4096ULL * SZ_1G)=0A=
> +=0A=
> +#define BTRFS_SB_LOG_FIRST_SHIFT	const_ilog2(BTRFS_SB_LOG_FIRST_OFFSET)=
=0A=
> +#define BTRFS_SB_LOG_SECOND_SHIFT	const_ilog2(BTRFS_SB_LOG_SECOND_OFFSET=
)=0A=
> +=0A=
>  /* Number of superblock log zones */=0A=
>  #define BTRFS_NR_SB_LOG_ZONES 2=0A=
>  =0A=
> +/*=0A=
> + * Maximum supported zone size. Currently, SMR disks have a zone size of=
=0A=
> + * 256MiB, and we are expecting ZNS drives to be in the 1-4GiB range. We=
 do not=0A=
> + * expect the zone size to become larger than 8GiB in the near future.=
=0A=
> + */=0A=
> +#define BTRFS_MAX_ZONE_SIZE		SZ_8G=0A=
> +=0A=
>  static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx, vo=
id *data)=0A=
>  {=0A=
>  	struct blk_zone *zones =3D data;=0A=
> @@ -111,23 +132,22 @@ static int sb_write_pointer(struct block_device *bd=
ev, struct blk_zone *zones,=0A=
>  }=0A=
>  =0A=
>  /*=0A=
> - * The following zones are reserved as the circular buffer on ZONED btrf=
s.=0A=
> - *  - The primary superblock: zones 0 and 1=0A=
> - *  - The first copy: zones 16 and 17=0A=
> - *  - The second copy: zones 1024 or zone at 256GB which is minimum, and=
=0A=
> - *                     the following one=0A=
> + * Get the first zone number of the superblock mirror=0A=
>   */=0A=
>  static inline u32 sb_zone_number(int shift, int mirror)=0A=
>  {=0A=
> -	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);=0A=
> +	u64 zone;=0A=
>  =0A=
> +	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);=0A=
>  	switch (mirror) {=0A=
> -	case 0: return 0;=0A=
> -	case 1: return 16;=0A=
> -	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);=0A=
> +	case 0: zone =3D 0; break;=0A=
> +	case 1: zone =3D 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;=0A=
> +	case 2: zone =3D 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;=0A=
>  	}=0A=
>  =0A=
> -	return 0;=0A=
> +	ASSERT(zone <=3D U32_MAX);=0A=
> +=0A=
> +	return (u32)zone;=0A=
>  }=0A=
>  =0A=
>  /*=0A=
> @@ -300,10 +320,21 @@ int btrfs_get_dev_zone_info(struct btrfs_device *de=
vice)=0A=
>  		zone_sectors =3D bdev_zone_sectors(bdev);=0A=
>  	}=0A=
>  =0A=
> -	nr_sectors =3D bdev_nr_sectors(bdev);=0A=
>  	/* Check if it's power of 2 (see is_power_of_2) */=0A=
>  	ASSERT(zone_sectors !=3D 0 && (zone_sectors & (zone_sectors - 1)) =3D=
=3D 0);=0A=
>  	zone_info->zone_size =3D zone_sectors << SECTOR_SHIFT;=0A=
> +=0A=
> +	/* We reject devices with a zone size larger than 8GB */=0A=
> +	if (zone_info->zone_size > BTRFS_MAX_ZONE_SIZE) {=0A=
> +		btrfs_err_in_rcu(fs_info,=0A=
> +		"zoned: %s: zone size %llu larger than supported maximum %llu",=0A=
> +				 rcu_str_deref(device->name),=0A=
> +				 zone_info->zone_size, BTRFS_MAX_ZONE_SIZE);=0A=
> +		ret =3D -EINVAL;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	nr_sectors =3D bdev_nr_sectors(bdev);=0A=
>  	zone_info->zone_size_shift =3D ilog2(zone_info->zone_size);=0A=
>  	zone_info->max_zone_append_size =3D=0A=
>  		(u64)queue_max_zone_append_sectors(queue) << SECTOR_SHIFT;=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
