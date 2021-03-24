Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6863473D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Mar 2021 09:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhCXImk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Mar 2021 04:42:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43638 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbhCXImU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Mar 2021 04:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616575339; x=1648111339;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YBRsqFFBpNbZXSI5IqqpgPQmuxko83xz91OvD9VDUhg=;
  b=qIaLzkxRH6o1sHvTUafnmJKzRHnmwn0zmeELMn1DMCy5fQ/4mR4sJOrW
   H0jWaZBklm2nMV2sRkPxYP31sXOA3JBMnfSzAo5LgiuMkl9Vo4vstWDxr
   eeLXrIYHMLFkTQRKNmdX6HPeNvKL80wnR4nany10wWDMXaAgZiPjke528
   ouJ1bOMPH9m16XXWWlU6k69yV6DBAmgukpvSOX5UN7d4ddadySYSsAHUD
   zGDj+VN/djPboX8em4y1h15rqTyelloxSdb4Ul/64A/pjMemkt3WXAzlT
   ZzGNuW4Y9k5cQr2hnSKdu/H1xaaOPf41xqvRxbWiXCdU8r1tlLK9TcWTS
   A==;
IronPort-SDR: iGEDz95HocggO0yvOxSOyKApWvQd3HPNcICRNmOCzNiFQXPF2Z+7XHR/kmzV5bXMY8s1vkaTOB
 4HiK+8fEkNu2mjJO3N+oXRM7KtGtYzsJFTikBL7xjv8NIDq/tQl2H0DJNZ07+ftAF0jd0wqHDf
 Nq31atW+/JjtWTT8vZ1f3SkAg9X3ZS2lgb2MZGznCdxHSZsoGIf7spYlw39spo/6CO3NLFMQZB
 haJt9tXp4++BRcOYJZIEqcUe3U2jDYJgWN4tCglNizuSJpAje56tieGZN0Wnq5okhHo5oKAnqp
 G/k=
X-IronPort-AV: E=Sophos;i="5.81,274,1610380800"; 
   d="scan'208";a="167357411"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2021 16:42:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TU3dc0oGvBzH4NyKZEQbpWy1RmTBlLXDiXG8E7vHdQ9b9gVpJGaFA35LafG6QIwSeA6bMHSak8694C8ebf7+GdDVQMRDNh1h/bSG1UkTrCa+Npw7nA7gaELMco7ps5BRuVyDyNbwAYsLrlw5rMTd9FPXk8z73PhDxTp12g4bc6H9rJMWKPTMJRTwoEntH8vcWWjKXz3Xi4DY+OSdDY/OhK5dWNuceeC8bX6JdQwXqR8TvEYFb+O/HPysd6IilLhhSfiCmvjS2IL5FtTTl3AWWsNkq0HMsKHsm4XWVqCmZTafJggSNjGf67tJ/rGQA+7Ijx07BjLMLJecdICAP1U1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yvfk42sVqnzZlg2EMTHNDqNmMWL2cUmXAiBOmo1yMo=;
 b=PKvSvkBBLRjhrG934SUpP8mm5Jju1jOzXdetvgPLlwiatAqH7521ldLX3vfJxU7KSnZYrFzRaqBb5FASevcVTddoYEwR2pf4ZW2zxNALzIT3Ll4ooxu8Iom2hgHcqcs03jW2z528WqjKb8xwTHLi/DPWkJwQ4ffNjjEph6wyVdzekFv2x7+84VlDajPa/EGidVR2oH4HdZXryy4dYB9Q6/YKtlv0Y2wSwcOGLxJ0pgd5DmZIoUjnOC5ttmIrZmTuPhM8tVK+lDB5JtNdW9POtoY+TMdrIOw/Q1EOTeq2Lsd1+YzCyfYj/RwKOyqc6t7JQqK6Wj56+uwVHpmgmhPfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yvfk42sVqnzZlg2EMTHNDqNmMWL2cUmXAiBOmo1yMo=;
 b=l1AL3NttS1qC74xRmAPpNHU9RC1xN8PNAKqcoECCqOdpjQes977he3AVA984/NKJfM1o7lVfhWbAgelRgVJrTTIFxuDMWZN1clbP16wTe5IfuTxou0ere0BTDmE+GknYQ+w1jGo5tCe45Mre9Je+XV/BIg5YcUjgywodyYfA9u0=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4452.namprd04.prod.outlook.com (2603:10b6:208:41::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 08:42:17 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 08:42:17 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: move superblock logging zone location
Thread-Topic: [PATCH] btrfs: zoned: move superblock logging zone location
Thread-Index: AQHXGV/QOMH0xzZMGU6MkZMQLPYBHg==
Date:   Wed, 24 Mar 2021 08:42:17 +0000
Message-ID: <BL0PR04MB6514AD823248E74F533FAF7AE7639@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <cover.1615773143.git.naohiro.aota@wdc.com>
 <931d8d8a1eb757a1109ffcb36e592d2c0889d304.1615787415.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:fd75:82bb:e935:ed65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f4607b1-058b-49b1-0853-08d8eea0bb27
x-ms-traffictypediagnostic: BL0PR04MB4452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4452CA4C3991B40B4746A1C4E7639@BL0PR04MB4452.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KL94IILKpYuVJI2KqTk0eTS4r2lO4tVmAsJSLCA5PUjo1sRjK40ZBv3ZwR0YqY8mC80NM6qfnOCAqBVaBHePcwHiq51OY2JXTdGZXaEr1ypJrC9HWuggbBjhcmljKt5k3vLY7nWn6+Bqih3vCSJfyU/R1UquQ+M73ITNKdlCjBac1iVUOMjAyFC1OFemaanklxeaxZ0Ang6DpEIL2aILgbq7d7P/krHWAH/WN+oI2cVtAK6CbHlIzsaUs8djXc1V+a/k7upryspfMjs0xd0rOH7eN5vcf36yh4QkSxuxW7rn/kH25ZW9VHCM5Fo5U7OITSvcWsfiZCLJZ7Z90teU6Ixb2ZflkWYN3hDWQOtTFgbKPprmBqyW74cFJoikx1uUeimBBOHhgQCL1NEVOL4Ie948xcJEZ1I1tWN0rgWSm+4CqQRunzpRDzOVEbC7B8EVRTYyLofZ1XDf8516uZpHSBEafy2QLRMxIhsO/LKRm5jeynHwPP+RWILQsfRv2b29MpK8soEi9gceJvWSxXd9aodXtm6iYluJnJK4+k2Oa/7HlNAmjoixy5qTCKAgrQ2hjotejirMWboxl2flXxlDcXvrBAGm7YpFIzf+onHLkSJ+mEVZbSxgoRZoRFd1tA3oJNxbbkshkfbu3+eeVzASk/hY8aMrrKJPoa82m9rNNJQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(66446008)(66556008)(8936002)(66946007)(33656002)(2906002)(76116006)(91956017)(86362001)(64756008)(66476007)(83380400001)(110136005)(8676002)(316002)(53546011)(52536014)(7696005)(5660300002)(9686003)(478600001)(71200400001)(6506007)(55016002)(38100700001)(186003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lv9iJxxmUz+MiYz9daWFRbeWCtsdzxgGfiyjqlrdWO53fauw93EmAMvsNIoz?=
 =?us-ascii?Q?+eGA6chSOXhcYExK1oGNoxngsF31KHGrJLpP6Pr+gcbRPy/rMgq9vPjxqQ/q?=
 =?us-ascii?Q?YuaeM1Jyghpz9Jn1i7Je6KYQ/Dwkzb77LpYIKJG25iOWP5o7wLq8N0DSI017?=
 =?us-ascii?Q?LMznnJIliRiznNJN2gp60Z4PTe0qqG94LWuEav0HxPRpCp7WFfzTuVIqR2zv?=
 =?us-ascii?Q?gVL+IAqog/MoUl8wlPHMwDIGwfn1elsZjihtPfzDdz7FSJnql/ytn9ejqP+8?=
 =?us-ascii?Q?9IedBOSr7HttXzqAZl+UZsS4MSRCc1qTY9Su81jVhedaI0rXp6GSs4/qMKB0?=
 =?us-ascii?Q?SMCxyXJW6yfY7TLgI45YfrGZHjMcYrZXZxA7BVUz2dxlCO+RdMoL7XV3s+JL?=
 =?us-ascii?Q?pHm6ENFK3ClQac4I7cOWbteOxpsXjMuobdjc2jImil9+Mx7gmXLfGZeLCF+m?=
 =?us-ascii?Q?HAlGksbs/7rpQEh2AF3W1l1uyogIbZtD3tXY3A0Sh2u92sObo2wTcLyNbeOj?=
 =?us-ascii?Q?c0zELE85NA/2ey1ksX4UOaoH+G00PGgmX5ZDWArKOe5hVlWTy9wuKnKD4TjJ?=
 =?us-ascii?Q?gCxsFizuDAUaYRNf6XV67Mvf89VD37dNd4SiBkk8OMOh/AsxMgekMpL3ma/C?=
 =?us-ascii?Q?BvyBMxPz8vgXpsZISQeS4EbVfR7tQ5e2wWiSIMcXYxUyjssuG/E8PVPWNPgU?=
 =?us-ascii?Q?5n3FW0RZxyWXi9JooztImHWrTZS8xxGcyso0RvNbNjENtN7t0YkDCK2brPde?=
 =?us-ascii?Q?Ch0P660v1340L/etl5xkkgyRY6S0ZX2BSJQAzFGo8QwPnolL0gDZlO6aNhmx?=
 =?us-ascii?Q?xz+0aQRlhaaDUSRMw6m8Bkk+bv36Qtpqlyk4VdY37TN0+DfKOQTiSFfD8tVn?=
 =?us-ascii?Q?+CW/dsXCqS7W91GEQf5l4h2kdj6MiRrNDiXCqnQnVsp8tu2K05KaXa1BRxDO?=
 =?us-ascii?Q?kthxxC1niumGwU5mlkxZPAOgSpALRSQEXAm9zII888dFySi6NMFmi7o2fRh6?=
 =?us-ascii?Q?dLHmDzuJtWM+h3uj63RsCNKOX/RuqL/WRFCSFnQh/onF0bbY6aYz+n1pFOic?=
 =?us-ascii?Q?ppN5W2OAz00tipMtdHUm7otriPMnlXafZCIRaVl/rfRtJKvJmHPxCAPWDX4S?=
 =?us-ascii?Q?oragDphT/cT5Y7fIZhpVPqR1tNu1gvOP4gv8eaGvvj+HFn54aveWs1Kiv73d?=
 =?us-ascii?Q?LNQueZkdnb2pdTJgBGeyqhXbLPsEav2cqX/4Oa+L2/PqiNBgVF59tSeRxUco?=
 =?us-ascii?Q?2IIdlI7/oJhRG/wJPkOAq748YV7K2r/IdzESxiuGphwA6mowUMEyVrCHB1mR?=
 =?us-ascii?Q?cOlwlu5zq1yyPj1OcHMThOVF8goz8diJZE8ug2aPXHdg/6l+IQi0OIA8Wr3m?=
 =?us-ascii?Q?qNbZJZxjeGkdL7qlvwrMMNZZb3FCYnNJlEL50FudeZzg07VowQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4607b1-058b-49b1-0853-08d8eea0bb27
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 08:42:17.4552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBKZt33RDdwaB7eOzeRYUihzTvm380bu/3C3pYaylebGRnpWi3NHgn6xS2tdJCyaTb9dIdFYaIfE3iUKJsKjgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4452
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/03/15 14:55, Naohiro Aota wrote:=0A=
> This commit moves the location of superblock logging zones. The location =
of=0A=
> the logging zones are determined based on fixed block addresses instead o=
f=0A=
> on fixed zone numbers.=0A=
=0A=
David,=0A=
=0A=
Any comment on this ? It would be nice to get this settled in this cycle so=
 that=0A=
we have a stable on-disk format going forward. btrfs-tools and libblkid zon=
ed=0A=
support patches also depend on this.=0A=
=0A=
> =0A=
> By locating the superblock zones using fixed addresses, we can scan a=0A=
> dumped file system image without the zone information. And, no drawbacks=
=0A=
> exist.=0A=
> =0A=
> We use the following three pairs of zones containing fixed offset=0A=
> locations, regardless of the device zone size.=0A=
> =0A=
>   - Primary superblock: zone starting at offset 0 and the following zone=
=0A=
>   - First copy: zone containing offset 64GB and the following zone=0A=
>   - Second copy: zone containing offset 256GB and the following zone=0A=
> =0A=
> If the location of the zones are outside of disk, we don't record the=0A=
> superblock copy.=0A=
> =0A=
> These addresses are arbitrary, but using addresses that are too large=0A=
> reduces superblock reliability for smaller devices, so we do not want to=
=0A=
> exceed 1T to cover all case nicely.=0A=
> =0A=
> Also, LBAs are generally distributed initially across one head (platter=
=0A=
> side) up to one or more zones, then go on the next head backward (the oth=
er=0A=
> side of the same platter), and on to the following head/platter. Thus usi=
ng=0A=
> non sequential fixed addresses for superblock logging, such as 0/64G/256G=
,=0A=
> likely result in each superblock copy being on a different head/platter=
=0A=
> which improves chances of recovery in case of superblock read error.=0A=
> =0A=
> These zones are reserved for superblock logging and never used for data o=
r=0A=
> metadata blocks. Zones containing the offsets used to store superblocks i=
n=0A=
> a regular btrfs volume (no zoned case) are also reserved to avoid=0A=
> confusion.=0A=
> =0A=
> Note that we only reserve the 2 zones per primary/copy actually used for=
=0A=
> superblock logging. We don't reserve the ranges possibly containing=0A=
> superblock with the largest supported zone size (0-16GB, 64G-80GB,=0A=
> 256G-272GB).=0A=
> =0A=
> The first copy position is much larger than for a regular btrfs volume=0A=
> (64M).  This increase is to avoid overlapping with the log zones for the=
=0A=
> primary superblock. This higher location is arbitrary but allows supporti=
ng=0A=
> devices with very large zone size, up to 32GB. But we only allow zone siz=
es=0A=
> up to 8GB for now.=0A=
> =0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> ---=0A=
>  fs/btrfs/zoned.c | 39 +++++++++++++++++++++++++++++++--------=0A=
>  1 file changed, 31 insertions(+), 8 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
> index 43948bd40e02..6a72ca1f7988 100644=0A=
> --- a/fs/btrfs/zoned.c=0A=
> +++ b/fs/btrfs/zoned.c=0A=
> @@ -21,9 +21,24 @@=0A=
>  /* Pseudo write pointer value for conventional zone */=0A=
>  #define WP_CONVENTIONAL ((u64)-2)=0A=
>  =0A=
> +/*=0A=
> + * Location of the first zone of superblock logging zone pairs.=0A=
> + * - Primary superblock: the zone containing offset 0 (zone 0)=0A=
> + * - First superblock copy: the zone containing offset 64G=0A=
> + * - Second superblock copy: the zone containing offset 256G=0A=
> + */=0A=
> +#define BTRFS_PRIMARY_SB_LOG_ZONE 0ULL=0A=
> +#define BTRFS_FIRST_SB_LOG_ZONE (64ULL * SZ_1G)=0A=
> +#define BTRFS_SECOND_SB_LOG_ZONE (256ULL * SZ_1G)=0A=
> +#define BTRFS_FIRST_SB_LOG_ZONE_SHIFT const_ilog2(BTRFS_FIRST_SB_LOG_ZON=
E)=0A=
> +#define BTRFS_SECOND_SB_LOG_ZONE_SHIFT const_ilog2(BTRFS_SECOND_SB_LOG_Z=
ONE)=0A=
> +=0A=
>  /* Number of superblock log zones */=0A=
>  #define BTRFS_NR_SB_LOG_ZONES 2=0A=
>  =0A=
> +/* Max size of supported zone size */=0A=
> +#define BTRFS_MAX_ZONE_SIZE SZ_8G=0A=
> +=0A=
>  static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx, vo=
id *data)=0A=
>  {=0A=
>  	struct blk_zone *zones =3D data;=0A=
> @@ -111,11 +126,8 @@ static int sb_write_pointer(struct block_device *bde=
v, struct blk_zone *zones,=0A=
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
> + * Get the zone number of the first zone of a pair of contiguous zones u=
sed=0A=
> + * for superblock logging.=0A=
>   */=0A=
>  static inline u32 sb_zone_number(int shift, int mirror)=0A=
>  {=0A=
> @@ -123,8 +135,8 @@ static inline u32 sb_zone_number(int shift, int mirro=
r)=0A=
>  =0A=
>  	switch (mirror) {=0A=
>  	case 0: return 0;=0A=
> -	case 1: return 16;=0A=
> -	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);=0A=
> +	case 1: return 1 << (BTRFS_FIRST_SB_LOG_ZONE_SHIFT - shift);=0A=
> +	case 2: return 1 << (BTRFS_SECOND_SB_LOG_ZONE_SHIFT - shift);=0A=
>  	}=0A=
>  =0A=
>  	return 0;=0A=
> @@ -300,10 +312,21 @@ int btrfs_get_dev_zone_info(struct btrfs_device *de=
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
> +	/* We reject devices with a zone size larger than 8GB. */=0A=
> +	if (zone_info->zone_size > BTRFS_MAX_ZONE_SIZE) {=0A=
> +		btrfs_err_in_rcu(fs_info,=0A=
> +				 "zoned: %s: zone size %llu is too large",=0A=
> +				 rcu_str_deref(device->name),=0A=
> +				 zone_info->zone_size);=0A=
> +		ret =3D -EINVAL;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	nr_sectors =3D bdev_nr_sectors(bdev);=0A=
>  	zone_info->zone_size_shift =3D ilog2(zone_info->zone_size);=0A=
>  	zone_info->max_zone_append_size =3D=0A=
>  		(u64)queue_max_zone_append_sectors(queue) << SECTOR_SHIFT;=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
