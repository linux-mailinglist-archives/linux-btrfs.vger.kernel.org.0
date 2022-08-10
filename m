Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D80958E7FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 09:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiHJHnF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiHJHnE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 03:43:04 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8F06DFB6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660117382; x=1691653382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yI4pnjTO5RkrjYcSij/hcOngUHKZ7hwZ/6QxNTSSm9Y=;
  b=nZ8Tt8EWUAHh34FPFPK+uBEnfz86eJi/rV/Wy2vuHLzamxt7NKwjaE+6
   x2s6MSLCjby8jP2RS1n3tv/hoLuDUL7lLQRLz0ML675LYwaMwcaLj0vf+
   t6h6Tt/PXJ0zgKNUNHxxoO+z/u8cB22r/8VgYj2Q6Ygi4UeSpgzSa9c7V
   J1124X8BNfo4FbRXHdDda+tSGycbQKhKr/GrjawVZ1DJ5yJhuVRlwZ1te
   zkcTQv0Nt6l2iMCTzGUCAZunPeAgH9nTZIg4D6jOIpL7If6fmcrTYfX93
   0NLsZ8oaKJZ2NjWSM2BRFff44QWvnEkn0kyUnbY3H//q4j0i/0yCimuZR
   A==;
X-IronPort-AV: E=Sophos;i="5.93,226,1654531200"; 
   d="scan'208";a="208875568"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2022 15:43:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUrX0X+kmtfL/cJxFwgJJQ5kpmq1RxWBj/U/V/ZLcG84lYVuJWNHWtBWfjGqGfImYJg4OSE6F/TvzTzpqxeSoTWiYM8FCuHzykaO20GOtgPWkshG9T3/ij6nf99VBIUOILTnkiA6sOcqlzEIZrPkk2D39gd0ypc14f4prs478NJZb8SsdDisISuslv9GrujbmexT87AFgZPGfOZBzA93f0sh31nngtgpaH/y57Vl6XfNvszs1tp7r7ZXOzFM4h9Jud1gwRUSOrW9tc/mDalqmk6nVYAYJfkxZZCCF33Wl2sK4njppY2AQTVDno9yolIqKLbjIAwN0FqsmTsJRBz3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YG0ybDNlBdRRJq1XnPj15hEHuQkGIxNfYiGw020iTkI=;
 b=R2rDjHjOBG+PZ0nKW08Jr7VNwyrXXzZ7oZEx8FDP+Kl+RjcCpsHW22Jrag8mvCigbZwEoQ8iAWjwYUhWjk4alqQ5LwCvdP3oaHMdDe1JiAFluGBwbk5PaOQXnmRW/qOGbg13BBPZNZypELaxKcXUdn6ET/pLfZTCAOT9mnKtrQELo1Qb0YdQ5ohQLcyF34JShDNsAUN7nVuHxMwzWjwzDg3JSZL80A9choZgd3iLdddSqjBK1aweclUBcAX2QEG4wLfahCo9TkJAiVaKdRsrMhTEUjJ3B49/KEwI3qUgzePE6QwhuY8vHx6JWi3pSanIgPkyMwV4ZGMucMK3PumcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG0ybDNlBdRRJq1XnPj15hEHuQkGIxNfYiGw020iTkI=;
 b=KpKx3um8Nyfk+MOCpABvogG+vAFetEtBHXecPzvsaDklAfeRJ9nOFktJapNoY47E/flij6BzFPxcNq2MzR6NKrWJHiPIfaXI+ZQexPyszGXnsdeIh6tctqSDyny/BYJX8nYo96HxQzoGHDGD4rC1IkH1u1gxWTOt4JDur4Zc2Jg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SN6PR04MB5293.namprd04.prod.outlook.com (2603:10b6:805:f9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 10 Aug
 2022 07:42:59 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e%6]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 07:42:59 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 4/9] btrfs: convert block group bit field to use bit
 helpers
Thread-Topic: [PATCH v3 4/9] btrfs: convert block group bit field to use bit
 helpers
Thread-Index: AQHYqNXO+iV2mzEojU22pgsnvfL3Gq2nx/IA
Date:   Wed, 10 Aug 2022 07:42:59 +0000
Message-ID: <20220810074258.vbkonou4bo5tu32h@naota-xeon>
References: <cover.1659708822.git.josef@toxicpanda.com>
 <6fd91db0572ea748ab9cd965d91dabdd8c1b5f35.1659708822.git.josef@toxicpanda.com>
In-Reply-To: <6fd91db0572ea748ab9cd965d91dabdd8c1b5f35.1659708822.git.josef@toxicpanda.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9045a26a-665e-4dec-3418-08da7aa3f296
x-ms-traffictypediagnostic: SN6PR04MB5293:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CeTvmvICzZnfnGBTj90trU6TTLgU9AlkEOhzTtocTMsPGbPkTlVNc80kAG9khm7h8DAaP0qpPeM8luP4LHfA7ErdM4sFBwVZhUK2jLeaWf2R+SIFCcIQQU0DUTtizRix+5g76+jHFRROsEtkS/T0jMFKjDH8R8YDiDrV1ipTJIAiIPPa8WM6lSPJgnw4d8Sl2w+zpH9lL91uh6/jLKZiqt815C6/xIezm1zHRLxTj7PFFOLT31v6i6O6hyyHmcENSQ65ogitvP3wmNUjC2weML0g5oW6GyhlnYlW7iDmwMcmxlC/gb8vSIxS3PxNUfoT3sQpfZs37E/w7bKbLYq3TDGf+x4exWmmA2LJXxLKTCEzrd0HKafBZpmX8zbJYnv7xCvnHC+FdMe3tEDA+PcV2NugTU6g35hAo3EN9ETn1vf13T8iAbXEMW8Hse2QC3SSaBm8WVcmD1Ec+DMxyGAQOVAlayNNnQ4nrX4864WGavPhgvmZ8pZdAq9n8Qo+G7D0IAm/WySS4LS7KkW2mL0OvEI5PoLqNZnSFMdiGGh7zsegRD2FGWGKloltP89nY6Lul8d1OIO2QnPKYgsnbuDE8ClniK120thM8Cg6TC2xyAymXesvMAnSe6++XwypQAohp8QUCxoyRlUtgvN6yc5hZWPyQb/SY+41u6HJVf8sKXwKKJjqAHnOUOffoS0+VQcnczVmC/X6jzNtXeVo+DeBkBUV3S/fW7Q2Ge9RKw0tTyYfkdfVwcMAx6qauyjMVNACxv2JD9/NpdZcWCX9t8ifwUSvjqMi0NO4kEVVufUoLjDBCsvFrjwADXfD4+ImmGtk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(6916009)(316002)(66476007)(5660300002)(76116006)(64756008)(66446008)(66946007)(66556008)(4326008)(54906003)(33716001)(91956017)(8676002)(86362001)(38100700002)(478600001)(30864003)(8936002)(2906002)(83380400001)(122000001)(38070700005)(82960400001)(71200400001)(6512007)(41300700001)(9686003)(6506007)(6486002)(186003)(1076003)(26005)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B8lQnB/sgyt8pLwWOPMAnc6en0aJSEk71ZYmANvMx86AiGGXiaADt/Hz+7dg?=
 =?us-ascii?Q?6g8IIFEm/8vINoBx8YrIVt+iMT4S7HDevMJYqCYdZknV2aaMTajtNgD4I00l?=
 =?us-ascii?Q?WM1kitRVdBieahKWui3iuFEss1+oCEo74pVdg/Nclc/CUklF9GIdUwYOvR6C?=
 =?us-ascii?Q?gIbBpOtOpmq4aHCWN1LhxwYcVVU95wjMUAGrm9EdGePi4DGQrfjrpMqNNZTk?=
 =?us-ascii?Q?Zc0CZNzmhziE6ZNm5NhNX2iSn9mKS9kfr2V9WvAQAuPEyZf5Y7f4R7UxmJWy?=
 =?us-ascii?Q?yidXNORkipyThvS79tqLuTFCDuUQMP6kF2Mbu6AD/vVd6KjGRsu4kn2qmHWc?=
 =?us-ascii?Q?+VUPmKFgm1l7CvPhh1jTg+Sgs2Oh+uOIeBOfpMs+W/k3ZQsfHr3xfwTKJST8?=
 =?us-ascii?Q?vNX2cOq6QV04igYr7R7n5lDqMG1JdbVD9DRjfvRgcBtmutC61Z3epf/aBWd1?=
 =?us-ascii?Q?RIlhvf+GhiGpehKiW4RLNk81ltVsme3+hmA+Degu3CIrnJhbXQTHElPJShLE?=
 =?us-ascii?Q?mbc8fyNR+vcSFCkkjcbLijM0VnUUKbiA5Leh98vDakpC2dYIbRPiLNCbZg7/?=
 =?us-ascii?Q?CgP0d/g28lCgwnMpBJpq68StAr+TWo8qZ1cLpmzrVo53JdZFmUV/suZXDBF0?=
 =?us-ascii?Q?lxTMAcpH8ZOCl0zl+yNbzhD0yJ/PXNOTV7e90o+IuUXSJsvmeCnRMnM7eiXY?=
 =?us-ascii?Q?nFE7rEteuNsyZzIppbgVaKAuoe88Y8UrKXOMDzfnzy4Nnlgi3JDO+tlCfN8E?=
 =?us-ascii?Q?nmrkgEY3BxHhkKQgH2dNfjITuIuT91j6X4C3111f3e24rMWeWshUbXgjDTmB?=
 =?us-ascii?Q?dUyVwPw8u6dzzoglvngUkiff2raMRouyR8o/b3Vang7Nj73d+yYO9yeknn50?=
 =?us-ascii?Q?k6MLTKOX3qxmlw8gTqurqN6uJAEunBm534g6QW5dAd8oa30Xo1lX2LXZUogh?=
 =?us-ascii?Q?e6ylC5i/McynpQLlA3giHkXyLV1lAweKrniG6q9t/1kzlOOdZUxR5GclKmUM?=
 =?us-ascii?Q?lfsT2lds2ho54Sha0SG8ac9LEl08EA4d1E4Ud0Cej97tG3lNSGe1UnZYLEOp?=
 =?us-ascii?Q?HuB9FWKY1FBEG3VoO9BV/gRDYDKosV8rhfNmSMiE5qhZvjXrf+FxVlMnOow4?=
 =?us-ascii?Q?qg86VmZZdZieuKS+9TYHnVz0nUkV35mgsLzSJ9yRfHFDho6j5SEmhsRo1YWk?=
 =?us-ascii?Q?9B+gtvnndgfHVbUIaEvOqNOw6dHFDm/+pN/ZZaAD9jqFInxiCLtHxTU06AMu?=
 =?us-ascii?Q?OkoTjUCiN+1ed+4aQYHkOrmv82dPAHpw3cestdjUBU6g/8NaLKqlfnQ0V2by?=
 =?us-ascii?Q?lMqSFxigXRR6lhDIO8U9pwADJwgzxeijiWWS0JNzdj5ZDE69xrUdrJ1jCCqz?=
 =?us-ascii?Q?MBKGl9Q+rcyV6dC72ij9USwfdyKGys6R7iAhxfEWCbZ/0lw69Qi7x0dOP86r?=
 =?us-ascii?Q?C+BXo66WZh+sA4CEl0dP3ts1JVDDKZj8jMI3TqTT09uC06uFHX8YlvUVJyVQ?=
 =?us-ascii?Q?TqsNuvzkDpQvS782nIMOJQ2YYtyJwjNmj+29OoGhlZZXdGpnbyiB7oet1knu?=
 =?us-ascii?Q?Gck7n4adfhQqtotJ5C+uCq/GZK+eesqqWSnnruX+BvKy156W2ktSiC9tZgjZ?=
 =?us-ascii?Q?fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA11CDB550B229429852437150D72ADB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9045a26a-665e-4dec-3418-08da7aa3f296
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 07:42:59.4222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tS3zI4xpAqAqdxhuWRK487n0D1nET5xmVSPvksCQfNlcXTF75LQJcr7eH+O2tH+OkSQxOjcEwsCNBhYySY2atA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5293
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 05, 2022 at 10:14:55AM -0400, Josef Bacik wrote:
> We use a bit field in the btrfs_block_group for different flags, however
> this is awkward because we have to hold the block_group->lock for any
> modification of any of these fields, and makes the code clunky for a few
> of these flags.  Convert these to a properly flags setup so we can
> utilize the bit helpers.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c      | 27 +++++++++++++++++----------
>  fs/btrfs/block-group.h      | 20 ++++++++++++--------
>  fs/btrfs/dev-replace.c      |  6 +++---
>  fs/btrfs/extent-tree.c      |  7 +++++--
>  fs/btrfs/free-space-cache.c | 18 +++++++++---------
>  fs/btrfs/scrub.c            | 13 +++++++------
>  fs/btrfs/space-info.c       |  2 +-
>  fs/btrfs/volumes.c          | 11 ++++++-----
>  fs/btrfs/zoned.c            | 34 ++++++++++++++++++++++------------
>  9 files changed, 82 insertions(+), 56 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5f062c5d3b6f..8fd54f4dd2de 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -789,7 +789,7 @@ int btrfs_cache_block_group(struct btrfs_block_group =
*cache, int load_cache_only
>  		cache->cached =3D BTRFS_CACHE_FAST;
>  	else
>  		cache->cached =3D BTRFS_CACHE_STARTED;
> -	cache->has_caching_ctl =3D 1;
> +	set_bit(BLOCK_GROUP_FLAG_HAS_CACHING_CTL, &cache->runtime_flags);
>  	spin_unlock(&cache->lock);
> =20
>  	write_lock(&fs_info->block_group_cache_lock);
> @@ -1005,11 +1005,14 @@ int btrfs_remove_block_group(struct btrfs_trans_h=
andle *trans,
>  		kobject_put(kobj);
>  	}
> =20
> -	if (block_group->has_caching_ctl)
> +
> +	if (test_bit(BLOCK_GROUP_FLAG_HAS_CACHING_CTL,
> +		     &block_group->runtime_flags))
>  		caching_ctl =3D btrfs_get_caching_control(block_group);
>  	if (block_group->cached =3D=3D BTRFS_CACHE_STARTED)
>  		btrfs_wait_block_group_cache_done(block_group);
> -	if (block_group->has_caching_ctl) {
> +	if (test_bit(BLOCK_GROUP_FLAG_HAS_CACHING_CTL,
> +		     &block_group->runtime_flags)) {
>  		write_lock(&fs_info->block_group_cache_lock);
>  		if (!caching_ctl) {
>  			struct btrfs_caching_control *ctl;
> @@ -1051,12 +1054,13 @@ int btrfs_remove_block_group(struct btrfs_trans_h=
andle *trans,
>  			< block_group->zone_unusable);
>  		WARN_ON(block_group->space_info->disk_total
>  			< block_group->length * factor);
> -		WARN_ON(block_group->zone_is_active &&
> +		WARN_ON(test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
> +				 &block_group->runtime_flags) &&
>  			block_group->space_info->active_total_bytes
>  			< block_group->length);
>  	}
>  	block_group->space_info->total_bytes -=3D block_group->length;
> -	if (block_group->zone_is_active)
> +	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_fla=
gs))
>  		block_group->space_info->active_total_bytes -=3D block_group->length;
>  	block_group->space_info->bytes_readonly -=3D
>  		(block_group->length - block_group->zone_unusable);
> @@ -1086,7 +1090,8 @@ int btrfs_remove_block_group(struct btrfs_trans_han=
dle *trans,
>  		goto out;
> =20
>  	spin_lock(&block_group->lock);
> -	block_group->removed =3D 1;
> +	set_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags);
> +
>  	/*
>  	 * At this point trimming or scrub can't start on this block group,
>  	 * because we removed the block group from the rbtree
> @@ -2426,7 +2431,8 @@ void btrfs_create_pending_block_groups(struct btrfs=
_trans_handle *trans)
>  		ret =3D insert_block_group_item(trans, block_group);
>  		if (ret)
>  			btrfs_abort_transaction(trans, ret);
> -		if (!block_group->chunk_item_inserted) {
> +		if (!test_bit(BLOCK_GROUP_FLAG_CHUNK_ITEM_INSERTED,
> +			      &block_group->runtime_flags)) {
>  			mutex_lock(&fs_info->chunk_mutex);
>  			ret =3D btrfs_chunk_alloc_add_chunk_item(trans, block_group);
>  			mutex_unlock(&fs_info->chunk_mutex);
> @@ -3972,7 +3978,8 @@ void btrfs_put_block_group_cache(struct btrfs_fs_in=
fo *info)
>  		while (block_group) {
>  			btrfs_wait_block_group_cache_done(block_group);
>  			spin_lock(&block_group->lock);
> -			if (block_group->iref)
> +			if (test_bit(BLOCK_GROUP_FLAG_IREF,
> +				     &block_group->runtime_flags))
>  				break;
>  			spin_unlock(&block_group->lock);
>  			block_group =3D btrfs_next_block_group(block_group);
> @@ -3985,7 +3992,7 @@ void btrfs_put_block_group_cache(struct btrfs_fs_in=
fo *info)
>  		}
> =20
>  		inode =3D block_group->inode;
> -		block_group->iref =3D 0;
> +		clear_bit(BLOCK_GROUP_FLAG_IREF, &block_group->runtime_flags);
>  		block_group->inode =3D NULL;
>  		spin_unlock(&block_group->lock);
>  		ASSERT(block_group->io_ctl.inode =3D=3D NULL);
> @@ -4127,7 +4134,7 @@ void btrfs_unfreeze_block_group(struct btrfs_block_=
group *block_group)
> =20
>  	spin_lock(&block_group->lock);
>  	cleanup =3D (atomic_dec_and_test(&block_group->frozen) &&
> -		   block_group->removed);
> +		   test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags));
>  	spin_unlock(&block_group->lock);
> =20
>  	if (cleanup) {
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 35e0e860cc0b..8008a391ed8c 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -46,6 +46,17 @@ enum btrfs_chunk_alloc_enum {
>  	CHUNK_ALLOC_FORCE_FOR_EXTENT,
>  };
> =20
> +enum btrfs_block_group_flags {
> +	BLOCK_GROUP_FLAG_IREF,
> +	BLOCK_GROUP_FLAG_HAS_CACHING_CTL,
> +	BLOCK_GROUP_FLAG_REMOVED,
> +	BLOCK_GROUP_FLAG_TO_COPY,
> +	BLOCK_GROUP_FLAG_RELOCATING_REPAIR,
> +	BLOCK_GROUP_FLAG_CHUNK_ITEM_INSERTED,
> +	BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
> +	BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
> +};
> +
>  struct btrfs_caching_control {
>  	struct list_head list;
>  	struct mutex mutex;
> @@ -95,16 +106,9 @@ struct btrfs_block_group {
> =20
>  	/* For raid56, this is a full stripe, without parity */
>  	unsigned long full_stripe_len;
> +	unsigned long runtime_flags;
> =20
>  	unsigned int ro;
> -	unsigned int iref:1;
> -	unsigned int has_caching_ctl:1;
> -	unsigned int removed:1;
> -	unsigned int to_copy:1;
> -	unsigned int relocating_repair:1;
> -	unsigned int chunk_item_inserted:1;
> -	unsigned int zone_is_active:1;
> -	unsigned int zoned_data_reloc_ongoing:1;
> =20
>  	int disk_cache_state;
> =20
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index f43196a893ca..f85bbd99230b 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -546,7 +546,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_i=
nfo *fs_info,
>  			continue;
> =20
>  		spin_lock(&cache->lock);
> -		cache->to_copy =3D 1;
> +		set_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags);
>  		spin_unlock(&cache->lock);
> =20
>  		btrfs_put_block_group(cache);
> @@ -577,7 +577,7 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_de=
vice *srcdev,
>  		return true;
> =20
>  	spin_lock(&cache->lock);
> -	if (cache->removed) {
> +	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &cache->runtime_flags)) {
>  		spin_unlock(&cache->lock);
>  		return true;
>  	}
> @@ -611,7 +611,7 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_de=
vice *srcdev,
> =20
>  	/* Last stripe on this device */
>  	spin_lock(&cache->lock);
> -	cache->to_copy =3D 0;
> +	clear_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags);
>  	spin_unlock(&cache->lock);
> =20
>  	return true;
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index ea3ec1e761e8..fbf10cd0155e 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3816,7 +3816,9 @@ static int do_allocation_zoned(struct btrfs_block_g=
roup *block_group,
>  	       block_group->start =3D=3D fs_info->data_reloc_bg ||
>  	       fs_info->data_reloc_bg =3D=3D 0);
> =20
> -	if (block_group->ro || block_group->zoned_data_reloc_ongoing) {
> +	if (block_group->ro ||
> +	    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
> +		     &block_group->runtime_flags)) {
>  		ret =3D 1;
>  		goto out;
>  	}
> @@ -3893,7 +3895,8 @@ static int do_allocation_zoned(struct btrfs_block_g=
roup *block_group,
>  		 * regular extents) at the same time to the same zone, which
>  		 * easily break the write pointer.
>  		 */
> -		block_group->zoned_data_reloc_ongoing =3D 1;
> +		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
> +			&block_group->runtime_flags);
>  		fs_info->data_reloc_bg =3D 0;
>  	}
>  	spin_unlock(&fs_info->relocation_bg_lock);
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 996da650ecdc..fd73327134ac 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -126,10 +126,9 @@ struct inode *lookup_free_space_inode(struct btrfs_b=
lock_group *block_group,
>  		block_group->disk_cache_state =3D BTRFS_DC_CLEAR;
>  	}
> =20
> -	if (!block_group->iref) {
> +	if (!test_and_set_bit(BLOCK_GROUP_FLAG_IREF,
> +			      &block_group->runtime_flags))
>  		block_group->inode =3D igrab(inode);
> -		block_group->iref =3D 1;
> -	}
>  	spin_unlock(&block_group->lock);
> =20
>  	return inode;
> @@ -241,8 +240,8 @@ int btrfs_remove_free_space_inode(struct btrfs_trans_=
handle *trans,
>  	clear_nlink(inode);
>  	/* One for the block groups ref */
>  	spin_lock(&block_group->lock);
> -	if (block_group->iref) {
> -		block_group->iref =3D 0;
> +	if (test_and_clear_bit(BLOCK_GROUP_FLAG_IREF,
> +			       &block_group->runtime_flags)) {
>  		block_group->inode =3D NULL;
>  		spin_unlock(&block_group->lock);
>  		iput(inode);
> @@ -2860,7 +2859,8 @@ void btrfs_dump_free_space(struct btrfs_block_group=
 *block_group,
>  	if (btrfs_is_zoned(fs_info)) {
>  		btrfs_info(fs_info, "free space %llu active %d",
>  			   block_group->zone_capacity - block_group->alloc_offset,
> -			   block_group->zone_is_active);
> +			   test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
> +				    &block_group->runtime_flags));
>  		return;
>  	}
> =20
> @@ -3992,7 +3992,7 @@ int btrfs_trim_block_group(struct btrfs_block_group=
 *block_group,
>  	*trimmed =3D 0;
> =20
>  	spin_lock(&block_group->lock);
> -	if (block_group->removed) {
> +	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags)) {
>  		spin_unlock(&block_group->lock);
>  		return 0;
>  	}
> @@ -4022,7 +4022,7 @@ int btrfs_trim_block_group_extents(struct btrfs_blo=
ck_group *block_group,
>  	*trimmed =3D 0;
> =20
>  	spin_lock(&block_group->lock);
> -	if (block_group->removed) {
> +	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags)) {
>  		spin_unlock(&block_group->lock);
>  		return 0;
>  	}
> @@ -4044,7 +4044,7 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_blo=
ck_group *block_group,
>  	*trimmed =3D 0;
> =20
>  	spin_lock(&block_group->lock);
> -	if (block_group->removed) {
> +	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags)) {
>  		spin_unlock(&block_group->lock);
>  		return 0;
>  	}
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 3afe5fa50a63..b7be62f1cd8e 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3266,7 +3266,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sc=
tx,
>  		}
>  		/* Block group removed? */
>  		spin_lock(&bg->lock);
> -		if (bg->removed) {
> +		if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags)) {
>  			spin_unlock(&bg->lock);
>  			ret =3D 0;
>  			break;
> @@ -3606,7 +3606,7 @@ static noinline_for_stack int scrub_chunk(struct sc=
rub_ctx *sctx,
>  		 * kthread or relocation.
>  		 */
>  		spin_lock(&bg->lock);
> -		if (!bg->removed)
> +		if (!test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags))
>  			ret =3D -EINVAL;
>  		spin_unlock(&bg->lock);
> =20
> @@ -3765,7 +3765,8 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
> =20
>  		if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
>  			spin_lock(&cache->lock);
> -			if (!cache->to_copy) {
> +			if (!test_bit(BLOCK_GROUP_FLAG_TO_COPY,
> +				      &cache->runtime_flags)) {
>  				spin_unlock(&cache->lock);
>  				btrfs_put_block_group(cache);
>  				goto skip;
> @@ -3782,7 +3783,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>  		 * repair extents.
>  		 */
>  		spin_lock(&cache->lock);
> -		if (cache->removed) {
> +		if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &cache->runtime_flags)) {
>  			spin_unlock(&cache->lock);
>  			btrfs_put_block_group(cache);
>  			goto skip;
> @@ -3942,8 +3943,8 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>  		 * balance is triggered or it becomes used and unused again.
>  		 */
>  		spin_lock(&cache->lock);
> -		if (!cache->removed && !cache->ro && cache->reserved =3D=3D 0 &&
> -		    cache->used =3D=3D 0) {
> +		if (!test_bit(BLOCK_GROUP_FLAG_REMOVED, &cache->runtime_flags) &&
> +		    !cache->ro && cache->reserved =3D=3D 0 && cache->used =3D=3D 0) {
>  			spin_unlock(&cache->lock);
>  			if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
>  				btrfs_discard_queue_work(&fs_info->discard_ctl,
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index f89aa49f53d4..477e57ace48d 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -305,7 +305,7 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info =
*info,
>  	ASSERT(found);
>  	spin_lock(&found->lock);
>  	found->total_bytes +=3D block_group->length;
> -	if (block_group->zone_is_active)
> +	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_fla=
gs))
>  		found->active_total_bytes +=3D block_group->length;
>  	found->disk_total +=3D block_group->length * factor;
>  	found->bytes_used +=3D block_group->used;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 22bfc7806ccb..4de09c730d3c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5592,7 +5592,7 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_t=
rans_handle *trans,
>  	if (ret)
>  		goto out;
> =20
> -	bg->chunk_item_inserted =3D 1;
> +	set_bit(BLOCK_GROUP_FLAG_CHUNK_ITEM_INSERTED, &bg->runtime_flags);
> =20
>  	if (map->type & BTRFS_BLOCK_GROUP_SYSTEM) {
>  		ret =3D btrfs_add_system_chunk(fs_info, &key, chunk, item_size);
> @@ -6151,7 +6151,7 @@ static bool is_block_group_to_copy(struct btrfs_fs_=
info *fs_info, u64 logical)
>  	cache =3D btrfs_lookup_block_group(fs_info, logical);
> =20
>  	spin_lock(&cache->lock);
> -	ret =3D cache->to_copy;
> +	ret =3D test_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags);
>  	spin_unlock(&cache->lock);
> =20
>  	btrfs_put_block_group(cache);
> @@ -8241,7 +8241,8 @@ static int relocating_repair_kthread(void *data)
>  	if (!cache)
>  		goto out;
> =20
> -	if (!cache->relocating_repair)
> +	if (!test_bit(BLOCK_GROUP_FLAG_RELOCATING_REPAIR,
> +		      &cache->runtime_flags))
>  		goto out;
> =20
>  	ret =3D btrfs_may_alloc_data_chunk(fs_info, target);
> @@ -8279,12 +8280,12 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *=
fs_info, u64 logical)
>  		return true;
> =20
>  	spin_lock(&cache->lock);
> -	if (cache->relocating_repair) {
> +	if (test_and_set_bit(BLOCK_GROUP_FLAG_RELOCATING_REPAIR,
> +			     &cache->runtime_flags)) {
>  		spin_unlock(&cache->lock);
>  		btrfs_put_block_group(cache);
>  		return true;
>  	}
> -	cache->relocating_repair =3D 1;
>  	spin_unlock(&cache->lock);
> =20
>  	kthread_run(relocating_repair_kthread, cache,
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index b150b07ba1a7..dd2704bee6b4 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1443,7 +1443,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_b=
lock_group *cache, bool new)
>  		}
>  		cache->alloc_offset =3D alloc_offsets[0];
>  		cache->zone_capacity =3D caps[0];
> -		cache->zone_is_active =3D test_bit(0, active);
> +		if (test_bit(0, active))
> +			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
> +				&cache->runtime_flags);
>  		break;
>  	case BTRFS_BLOCK_GROUP_DUP:
>  		if (map->type & BTRFS_BLOCK_GROUP_DATA) {
> @@ -1477,7 +1479,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_b=
lock_group *cache, bool new)
>  				goto out;
>  			}
>  		} else {
> -			cache->zone_is_active =3D test_bit(0, active);
> +			if (test_bit(0, active))
> +				set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
> +					&cache->runtime_flags);
>  		}
>  		cache->alloc_offset =3D alloc_offsets[0];
>  		cache->zone_capacity =3D min(caps[0], caps[1]);
> @@ -1495,7 +1499,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_b=
lock_group *cache, bool new)
>  		goto out;
>  	}
> =20
> -	if (cache->zone_is_active) {
> +	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags)) {
>  		btrfs_get_block_group(cache);
>  		spin_lock(&fs_info->zone_active_bgs_lock);
>  		list_add_tail(&cache->active_bg_list, &fs_info->zone_active_bgs);
> @@ -1863,7 +1867,8 @@ bool btrfs_zone_activate(struct btrfs_block_group *=
block_group)
> =20
>  	spin_lock(&space_info->lock);
>  	spin_lock(&block_group->lock);
> -	if (block_group->zone_is_active) {
> +	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
> +		     &block_group->runtime_flags)) {
>  		ret =3D true;
>  		goto out_unlock;
>  	}
> @@ -1889,8 +1894,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *=
block_group)
>  	}
> =20
>  	/* Successfully activated all the zones */
> -	block_group->zone_is_active =3D 1;
> -	space_info->active_total_bytes +=3D block_group->length;
> +	set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);

Here, the adding of active_total_bytes is removed maybe by mistake.

Should I send a patch to revert this line? Or, David, could you fold the
fix in the misc-next branch?

Thanks,=
