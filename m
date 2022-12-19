Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA496507F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 08:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLSHFX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 02:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiLSHFT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 02:05:19 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3085763C9
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Dec 2022 23:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671433517; x=1702969517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=REquAmW1H2JJ3mw02AxRujIlFYOZ5NPuf5f4lZ0fBRs=;
  b=eaMJr4GbtTNdW1DMiI6KTIN0v4iS78c9pG+cLw7YF6aGlGCn6TBrJTkR
   aAUX05GHOsW9HB14Y6cuznQEXTF44C/xU18J2M/Zqm7vVIwS53u2xjLtp
   nu45kuWAzYHv8WZvp2BBrXKbY9BTkNewrsVRqcAX+1S4hTgbREj+JX4vk
   u+DLtb/vtlk2BNsTqO6+k80PN+xKXlphzf7uJ4e/oAsOB7eSXIZWt3hx5
   39WN7SRLhrHrPjY1H+siPJMYZns11Y187/S9ey1zKKvvgGI6wS5yEWlDZ
   NOq0+bnoELtdsmf8XHc2BjxAPGagdE7cJWjTiIxXt/J9bfCFG6Wc9Tu5E
   g==;
X-IronPort-AV: E=Sophos;i="5.96,255,1665417600"; 
   d="scan'208";a="331070699"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2022 15:05:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cuqvy9ZoS6r5+R6M+tC4zO7llf00gB7Ddymfm6ThNIUSfYCpLjkweU6ITOZG+dLc0GHBXftWN/+mXkg9uSlmpx2Z1j0E4CEM+kgMiG+AS0DMjp9sjyWdkKtcCyle9DFYqIvfBBnZ8vh6qDM0vz0CjjQESL4arMBqfIFoi2xosYQZ1Ty4uTlNFm9O/YN5TPS1cHmziUs2qYvTUCq29rgwlNUQ92rBGW+3KtG7PFm66YbC6AXd5R/4dLFH0mWw7U0m0ec1eN1aMmhLWoFjRPVqIZk6TVUydFl5M3il7OXxJMeiaZ+JtGaRcwCwZSan3q+kJhbHbZezf4BYwV1C25fyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6035zrH65ZqqwOIhiWbI/MeUC5MKusUNwqG67R8/V0=;
 b=AhFP2lLaJoGlhPVMokCnEm/SMvMI+soviMI39K0LsEUb7J0MYzDDuBecXUYKSAB1ZJgofbbqL+mvhq7uEw8F+jSX9PNUBzDiKroGd9yBwQmVRldjqg1D87FT6ZmHMr65XCTKpaJInywmDi9styVkCQuEkTRdcKbYrgOxIyAjE+vqAffBqn/Qp5ie18fyBm9ItEFdA+kJj78ZEBHKNMF9D45WlYysKPxgHtAy/AZTAGUwxAMuc2oqNmEy/ZEI+njmJsSy9d7oUnCcr3F3XH5OC2w0OuLtOK3cWMK2vfWNkubqO9IDZrtGr6ZDkcGnQu6GI/+EWhFEVmVVru8F4mBrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6035zrH65ZqqwOIhiWbI/MeUC5MKusUNwqG67R8/V0=;
 b=SRFF9HmfFEbuzkRUnvtsLuSxTyqV6VfikN1586MzOXQuxhinWazUTAR1IruOehUKoKFsEqUlG0D3Zw6sMSXsgMrPe3sDXysNonvdfw/BeGAQK7Nc8NkvygaM3ydctP5uUV6aE3jTJ4PzF0CzH2Gq6TMUkq9FpvqecF0aSoV/jXg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH0PR04MB7905.namprd04.prod.outlook.com (2603:10b6:610:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 07:05:15 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::c080:1687:4429:ed73]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::c080:1687:4429:ed73%9]) with mapi id 15.20.5924.019; Mon, 19 Dec 2022
 07:05:15 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 6/8] btrfs: extract out zone cache usage into it's own
 helper
Thread-Topic: [PATCH 6/8] btrfs: extract out zone cache usage into it's own
 helper
Thread-Index: AQHZEYt9N/X6YnnVfEGxUNqb3VHIEa50zWQA
Date:   Mon, 19 Dec 2022 07:05:15 +0000
Message-ID: <20221219070514.tgfqoiethziuwfdq@naota-xeon>
References: <cover.1671221596.git.josef@toxicpanda.com>
 <af6c527cbd8bdc782e50bd33996ee83acc3a16fb.1671221596.git.josef@toxicpanda.com>
In-Reply-To: <af6c527cbd8bdc782e50bd33996ee83acc3a16fb.1671221596.git.josef@toxicpanda.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH0PR04MB7905:EE_
x-ms-office365-filtering-correlation-id: 6a43c771-32a8-4989-732d-08dae18f610c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a9dsd+qO6EhGp8ron4VyImG+KDl8oZq1o30s80mE/HpkrNCcgpEV//GwVT/MDSOxyTESreaRl6utMWW5h3xKixz5agsPIefGrSm+MoqzoYzaXK+A79/+Qr5nuzcwybRyTtpNoD9nj7gxDm6uKPtfQAuIAzAz11FPsC0yEIyi2+QiEpvxUtIEFNEIToazB2vJe48M9M798fLO94Jk8gfj2m0aq2YXK1vwP8er/ecNS8Yc5Ud0D8y5BjunmwpMWzdWZJGtqXkrSnsvFzCyUDhX70zFeIxaBMW7KT3k6ED7UFADsnpyRLET/APzpKPMhptEC1BVV8A/8JgTMlvuNT4wu6csu/wiSKw0lpx9ma3f/yqK3uv00kHg6M58iLZYsSSFSDJ+Po67+9kRuuJnRk8FBCUB2Pj/uRoNDkFLzEPxAm/joeireOGivQEQ/TF76bT2Yw7AqeGO60+O0qnZqr3tu7u16k9NI6aqBJMN2l7s4AEe5VhuBr+4qsAMUJlQakjnaVE/XWiviR5pUSO7wKn8zWmPbRzI4Sx6q9rK1axD+pIclGv/MDKo2oN455rh32m2n67sm8DJuXDJApG5EqerOcz2CI4RaqZiWYpzHF2x/6pVeaXPZvNeKLtS7hgjPx47BQP8wk7jgSwf4VTGDVndTAKQ6uv1rG2LurR1ZTk/gguvtPwl8LenpU43rMZQZ5XKkarjeK2MPGmhtODE0nha6BQ/Ot88FeYLdOZw7nEhl5VUn0knF5/fE8DhRgcm7UhN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(41300700001)(4326008)(8676002)(1076003)(33716001)(3716004)(38100700002)(122000001)(38070700005)(5660300002)(8936002)(82960400001)(2906002)(83380400001)(71200400001)(6506007)(966005)(6486002)(478600001)(316002)(26005)(6916009)(66556008)(91956017)(76116006)(66946007)(66476007)(64756008)(54906003)(66446008)(86362001)(186003)(9686003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FtBpob9CAP8LOfCOWNcZwBCqAn6eySvEXOABSPGIzK63s+ew5sKR9NYkyoRj?=
 =?us-ascii?Q?PDaXCFnWkHxMH1sjrRXMlfq1KHLfu7FduvogJ/JU2AJR25vOHEfC+/Gn9ZWq?=
 =?us-ascii?Q?aTnOe5O3PI3361Gq7rfEEjMNG4EES6b94s3zlTH3Mvt01X/hP8zkNgnJ8IIR?=
 =?us-ascii?Q?Y1P4lkAhM+VxDf22YEBiXexkdmc0dJ1OmpL/VnE5Bd3YKBEBGACwg7oJd+Iv?=
 =?us-ascii?Q?yhM9vOd9/ez0suxSUvWIZ8bCEjGKTnej4Esktjm/YNn8DnEmV5S6GmjB8l/b?=
 =?us-ascii?Q?NcqN8N8qtk16Dzh/n385Fibobnalja8ZYF5SNXAL7Zl5FODC4cwW/fJkrUc9?=
 =?us-ascii?Q?uD2xnCJekrwsso+SRUr6PmvD5/d1nqQqN9ns2XI8daVCWj9G1fipgNJBbUMZ?=
 =?us-ascii?Q?srY5T2k6xEI+iLRyULWhRGCATtO5DbXYGP5qOzv2+X5jh+GYj38pst5CzYXV?=
 =?us-ascii?Q?jLDe0toTOv3jdVX2ieMYgHBeUrws+u1et27C/0VfHGUp3/gwCf60CeSp1X25?=
 =?us-ascii?Q?mOYt55modn8PFpIOQEwo+ag/s8cfxqXsG2VuuBaJ/GP+1Zwg7kraMNM8mvJ3?=
 =?us-ascii?Q?pyRG16/9gIWzFSgYBSW8zTVRvdU28BwMAmoJtIl4fJmTRmCYlgCdsCTYmQXR?=
 =?us-ascii?Q?Cfyun8xSPOwk/Km8i7ls88yK30wCOEtBeRiqdGtxSnWn/Zm/rnhrDrPhEXjF?=
 =?us-ascii?Q?dHfLiHezZB2vwXySi5JowkaUwzBQviNl+aXLeA+dvG2LYuYx98uicg9O1xh7?=
 =?us-ascii?Q?qWOqqLzAdC9tSNDZ7i/PI/NDVUaZYBTFDCgCUX3CNzh+1mAu6kpTLMbqb4+O?=
 =?us-ascii?Q?0woddW7ITKfzq96u6Wb4gTuQ/RqbLthNnDQ8SEJSzZcH5mj7I8ITHtW+deut?=
 =?us-ascii?Q?YHEOSPpqfMuiVfzi8czpLaoflWFwCP1B5KkhD+cw4Jll0igy9Nt4paXh5NeA?=
 =?us-ascii?Q?C8aRjN1fADb7+UfuVZgnwSY39hBWDfDkbBuJ2zNOWKqahdCXdIAZsBrh/yP0?=
 =?us-ascii?Q?Yfa2/Xi+BV8IrLoUkSfE+P54QDxtZ95rJXNVvul+VXMD+Pr//8KIxukVWXC8?=
 =?us-ascii?Q?zEdB1L6FWo0FmdDuEgWUkMThJb01jWCek2Ayqr0NM1Vkv69gE7T7MobTQz7P?=
 =?us-ascii?Q?++tO1ChqtJPUFT5QXK7WG8mKQbCxiIIpcOb3luez+wcpkfBHfp5SHTeS3SU1?=
 =?us-ascii?Q?gLlNWCYt68gPhovAziOkpHvTTjZryyN9l0vmToi943rw8B3rUh9GN7Its1tM?=
 =?us-ascii?Q?6Owi3VVSsISm/aJKicba08xWb3b6IYw+9+ursH0UP783108L2JqxNVkDZfvQ?=
 =?us-ascii?Q?ZsmizZXJ30sRo4+InUigfiEnF+XzeGeiw6rwTUIlLTBL/PZh+rQz7rPnNSLn?=
 =?us-ascii?Q?gFc9WxyEUi/4Gf/syc2LhGpvxkhoJSGBdlLw46ICL5JqF+uMD1HyS0n7Nj3N?=
 =?us-ascii?Q?kOcb7rq9oKr78QOZBlDQ4t88hdG9zbPPSXDyzL/nncdZfiFy+IZGa9t8O/Mu?=
 =?us-ascii?Q?oUR69ffGcqYQP+69jsAu8PiJ+pRGImTIJHnoKGso1z97kdPwQhPVrB5tKHUH?=
 =?us-ascii?Q?aAAb0K6J6BLifHSwM591CfLS9eDiZ0NmZLapJNlM8SysEXi+F2sm8ZeOPmsB?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8B8B8B4104B184A800BC870E9F0B682@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a43c771-32a8-4989-732d-08dae18f610c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 07:05:15.0656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRY6EMtmdMeymjw013rCxKhR1Tyi4rmDXHr9gnL9TzyRKebNIPE79lQj1kIEbWk+h5T1IV1KcAqCKcWsQIA/Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7905
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 16, 2022 at 03:15:56PM -0500, Josef Bacik wrote:
> There's a special case for loading the device zone info if we have the
> zone cache which is a fair bit of code.  Extract this out into it's own
> helper to clean up the code a little bit, and as a side effect it fixes
> an uninitialized error we get with -Wmaybe-uninitialized where it
> thought zno may have been uninitialized.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I'm going to rewrite the code around here with the following WIP branch, to
improve the zone caching.

https://github.com/naota/linux/commits/feature/zone-cache

Specifically, this commit removes the for-loop and the "if (i =3D=3D
*nr_zones)" block you moved in this patch. So, the resulting code will be
small enough to keep it there.

https://github.com/naota/linux/commit/8d592ac744111bb2f51595a1608beecadb2c5=
d03

Could you wait for a while for me to clean-up and send the series? I'll
also check the series with -Wmaybe-uninitialized.

> ---
>  fs/btrfs/zoned.c | 73 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 45 insertions(+), 28 deletions(-)
>=20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index a759668477bb..f3640ab95e5e 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -216,11 +216,46 @@ static int emulate_report_zones(struct btrfs_device=
 *device, u64 pos,
>  	return i;
>  }
> =20
> +static int load_zones_from_cache(struct btrfs_zoned_device_info *zinfo, =
u64 pos,
> +				 struct blk_zone *zones, unsigned int *nr_zones)
> +{
> +	unsigned int i;
> +	u32 zno;
> +
> +	if (!zinfo->zone_cache)
> +		return -ENOENT;
> +
> +	ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
> +	zno =3D pos >> zinfo->zone_size_shift;
> +
> +	/*
> +	 * We cannot report zones beyond the zone end. So, it is OK to
> +	 * cap *nr_zones to at the end.
> +	 */
> +	*nr_zones =3D min_t(u32, *nr_zones, zinfo->nr_zones - zno);
> +
> +	for (i =3D 0; i < *nr_zones; i++) {
> +		struct blk_zone *zone_info;
> +
> +		zone_info =3D &zinfo->zone_cache[zno + i];
> +		if (!zone_info->len)
> +			break;
> +	}
> +
> +	if (i =3D=3D *nr_zones) {
> +		/* Cache hit on all the zones */
> +		memcpy(zones, zinfo->zone_cache + zno,
> +		       sizeof(*zinfo->zone_cache) * *nr_zones);
> +		return 0;
> +	}
> +
> +	return -ENOENT;
> +}
> +
>  static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>  			       struct blk_zone *zones, unsigned int *nr_zones)
>  {
>  	struct btrfs_zoned_device_info *zinfo =3D device->zone_info;
> -	u32 zno;
>  	int ret;
> =20
>  	if (!*nr_zones)
> @@ -233,32 +268,8 @@ static int btrfs_get_dev_zones(struct btrfs_device *=
device, u64 pos,
>  	}
> =20
>  	/* Check cache */
> -	if (zinfo->zone_cache) {
> -		unsigned int i;
> -
> -		ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
> -		zno =3D pos >> zinfo->zone_size_shift;
> -		/*
> -		 * We cannot report zones beyond the zone end. So, it is OK to
> -		 * cap *nr_zones to at the end.
> -		 */
> -		*nr_zones =3D min_t(u32, *nr_zones, zinfo->nr_zones - zno);
> -
> -		for (i =3D 0; i < *nr_zones; i++) {
> -			struct blk_zone *zone_info;
> -
> -			zone_info =3D &zinfo->zone_cache[zno + i];
> -			if (!zone_info->len)
> -				break;
> -		}
> -
> -		if (i =3D=3D *nr_zones) {
> -			/* Cache hit on all the zones */
> -			memcpy(zones, zinfo->zone_cache + zno,
> -			       sizeof(*zinfo->zone_cache) * *nr_zones);
> -			return 0;
> -		}
> -	}
> +	if (!load_zones_from_cache(zinfo, pos, zones, nr_zones))
> +		return 0;
> =20
>  	ret =3D blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zone=
s,
>  				  copy_zone_info_cb, zones);
> @@ -274,9 +285,15 @@ static int btrfs_get_dev_zones(struct btrfs_device *=
device, u64 pos,
>  		return -EIO;
> =20
>  	/* Populate cache */
> -	if (zinfo->zone_cache)
> +	if (zinfo->zone_cache) {
> +		u32 zno;
> +
> +		ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
> +		zno =3D pos >> zinfo->zone_size_shift;
> +
>  		memcpy(zinfo->zone_cache + zno, zones,
>  		       sizeof(*zinfo->zone_cache) * *nr_zones);
> +	}
> =20
>  	return 0;
>  }
> --=20
> 2.26.3
> =
