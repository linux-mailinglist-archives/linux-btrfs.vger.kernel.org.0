Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D690C4DDDEB
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Mar 2022 17:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbiCRQKP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Mar 2022 12:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbiCRQJ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Mar 2022 12:09:56 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0228CCF2
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Mar 2022 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647619717; x=1679155717;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k2Tf2vylqPsEZSjxuibTyFxHtsZn+lRKixqWdbGqLXM=;
  b=qIU1li7y/osI31vtM8fyOV6VPcm1NG/Vscxa+CBRuIP6RpCEL94MCzG0
   OgUXmk2QCTDTcoDtbn+LrVG4V6CRyMl4XooZgTGcV0P/KZUMXOr+VGMY8
   VagwuQkZs7dODWNBxynM3SkBmVa0uGpMjudZOzFDH2k3I80qMYkv25T6G
   zDrEE+ug6pi1E64fmrRgRvHyAFvSds/17IImDR4aWDVPGYQ9jyPH/LWGZ
   t7Hd1pgb6NPDsAPsYGBMkNZ6jeg1mx2MYsscBll9IVghzJxZmbr9gVRRH
   7mQUJUhWGfve0PNsvkWDJkKJEh58ZLzDHQcT8eaVUUJyZbko6DrKsqKo4
   w==;
X-IronPort-AV: E=Sophos;i="5.90,192,1643644800"; 
   d="scan'208";a="299860274"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2022 00:08:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTR+6PM8notoDwv0QHGa+vgAjR2MXNp88U9f/tKABEKmNrGEj4/g9RKIuywg59iPeVps+3Z6D92oXMV7LaM34kX1vhA7ghb2NtmvM9RcW1UDUPTNHrefszLRgW4WOaZ4LqJcpjrs1mwtlP4NrHQtVaL6l398ochLu/qISEci9HD13UmInx87lAqZwHKVqrS8y138eqfqxBakxGsl63o1E6mxCD3wxRV82udNVfaJLB6/AXplfY7Kg/QQUlJB0UgEcBfBrgF8xQ7XTZAK/df4XWV4x1hjkleemHW+7uHK/DF+tgEZT979nb83kl9zZSC4ytptvs21Nswec3+TJDtJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUsYMx8F4OTeuuugVOHkCS9e3aZEfxeacbWC5yZdKrk=;
 b=FylgM4Wvty3B/5kUsYS9at7cQqX4sdvllSKIHiGrnq9FVGdqozxK8OT/NDGUubojo9Dom1AWLrcfdpKymd3i8WdZq2NZZmturyVVMpUbqO4duyY6Afx7gcNMsUQYuV32pfvgAosMo9Wybr+sM8EfUBivVRwhKSrlh175bfqkeWjVySBdjKjW6ydefltVyaZMx5YBXoaGNsA2k4yYrznRJa1LB1rB8xebB8VX8KFraqBTQZJA8u/xzZdtBFu3gIqvVWOod3DObyEd7qgkVls3zmzG+FRPvbeJSFiDIjB8Bww/VjiUG9n7lAO4GUx4wR+HjiXPm3yaRoo+//TqO+zNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUsYMx8F4OTeuuugVOHkCS9e3aZEfxeacbWC5yZdKrk=;
 b=BgfpVo3EycJMceSbPlzKi1eYSbofQaLJmkMBkeSJ8UNhTa82uMYqBt7tFym5BEOt7bvC58M9VvU7DSk/AMc6mnmgUzAcbKHjfBS9oHzurWYa/vPRAACclv+Ls5hTnIxCkRFIl25/Ox9xGIS0eSA6U4TNx46sH75fmPEIEkawN3w=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB5947.namprd04.prod.outlook.com (2603:10b6:5:172::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 16:08:34 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 16:08:33 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 2/2] btrfs: zoned: activate block group only for extent
 allocation
Thread-Topic: [PATCH 2/2] btrfs: zoned: activate block group only for extent
 allocation
Thread-Index: AQHYOT90klpZFESWw0S9tSp7xuCw4KzFUlWA
Date:   Fri, 18 Mar 2022 16:08:33 +0000
Message-ID: <20220318160833.u66t5k53qdwz7vpk@naota-xeon>
References: <cover.1647437890.git.naohiro.aota@wdc.com>
 <186ca14c007ed18db3221bb883df19d3f0fcd8e8.1647437890.git.naohiro.aota@wdc.com>
In-Reply-To: <186ca14c007ed18db3221bb883df19d3f0fcd8e8.1647437890.git.naohiro.aota@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5a89045-a9b2-4564-af18-08da08f98d7a
x-ms-traffictypediagnostic: DM6PR04MB5947:EE_
x-microsoft-antispam-prvs: <DM6PR04MB59476148BF154BB8AE9920808C139@DM6PR04MB5947.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ijDqC0sPopngeEfc8YF9JZbrO1MBDtrs41TWqrWo+9oPKFJkidMuUtMMDl/NXtYcbDn+HUUwkcTGijcndWMLYMN35BdLbw3JU/JfTvDZHQW5Wye41ZpNr2RVFMGIF5Iv2nNERstpmz7kBIoosjBoshdigXha1ej6v/qMc6fTRD7gB4ftWXrXQaX77TTa05NraPrQoGffcaVhcNOJWhZ6JEavCeOeNf11OC4H5fNe6yMVx7JHmie0j0LNvL74/JCe/tgY2VEQ28WnA27KvctL6yq24u/F0tqbHD9s3IzX6XejDC8rKG6RriXTaZO4qUjFjRLIQmXKi306r+40ANT/OChz1eRNzkrPCAqlfYRjdvhU5CE4pCM/PaXasYOAnDAjGqjW+gYikrfjHyeq50C0RHkYCdniV+ZOwISfwQDD7Dqz1AxY33n8IcAqHTfsARcT7WTxzMmiUAW8ggydKWVCsrY3zu9TEnH2WRKRKZIpWK7CPlVLbfEyQ+Y70YzBgd4qoCmDcd9HnT9pVWspaK2PB1wkrjEzg3OzvNw6eYCgVE72naV8/VIpK2Dh9a7uZ61CHib91/Wve+uOna+zL5bxYQnCHAzC+2di5yBAOe24uFIkTMJUVVXtymdzncfe41KpEjgyqX83ed5twPXB5hl3rvrPBu/2qDVgFHpCJd8125sFPMwjOG2cCTS/f3KsKWahiTZ4dNhwh8zXcVR/z7GIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(4326008)(38070700005)(186003)(26005)(83380400001)(2906002)(5660300002)(8936002)(33716001)(64756008)(66476007)(66446008)(66946007)(76116006)(508600001)(8676002)(91956017)(66556008)(1076003)(6512007)(316002)(6506007)(86362001)(9686003)(82960400001)(38100700002)(122000001)(6486002)(71200400001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iky15FAOm/YQgfJogigyjT8xRFvCBR5mkSAMcTlMvhln+W5gFfGjaM12b0wQ?=
 =?us-ascii?Q?zOM0q5zVGl42nf/xpSUjfabmJcnOQiNg8tSoWT0Mti9U0chlJCdcGMN8XeF4?=
 =?us-ascii?Q?DnfAh+wTRp+TzPukd8G8uZlCwsq4SDRREyivN9qGbHJoUnQ6uIkXLGaAnLLI?=
 =?us-ascii?Q?97v2+iolVYYk0eje9BBsZ1dWwuwbpveacNnQ/QHokPHiA8rnWpTM0kongAgJ?=
 =?us-ascii?Q?RttPHpPe0IlFaL9YOed2sa2cpkw8B8gXw3QlJgPjVI/ttIv3uPalqoYBFbaV?=
 =?us-ascii?Q?3/dbmqJ0K0Sper8s0g6tdRwUlAXxt/oxbuGvM/a9cLXnRfzpzgSREC37/6xv?=
 =?us-ascii?Q?FnGg0Zsn/jIhebkMtwluXAfNc5ODbJjR/5y51K8z1XvseRtYncOv//IIM4AQ?=
 =?us-ascii?Q?qPqFTd10en3VJS395HOUKF94trXMx6pETI6lV72SEJyd/3XGnbIUBQtX77hB?=
 =?us-ascii?Q?/3tvWycj7lu6ar7X81HYYbUgbkcjmALF77+HFjmqbAzAIbbD5DfAldcGeAGV?=
 =?us-ascii?Q?qGdUymq8dCnq4RuulTDIGWLS3/WMoaJFJ6PgGqGNsPD+0wHYokZK1sf4Zw40?=
 =?us-ascii?Q?seT+iLwWOFUVNg7/ptTz++65Mws3+BpM3mkkiQ+viWADN0MZFmjTAdS9G0gm?=
 =?us-ascii?Q?jtjLxuqOFrMj9xwF4E2Y8RTzAFkBBnsyBt1EFF5wbhGhg8gu2BNSaS0YWfGb?=
 =?us-ascii?Q?yn01Pxz9LSjrO0L23cfTVibscj4dJwHx4cTM65+q7EKSk3QljTYQu/S2VM6J?=
 =?us-ascii?Q?8v+lF3fR5v4imuoRnh+39Op1zJOuQekIgcu2TGe8F33wEcq8UYdJ02ZZxgPY?=
 =?us-ascii?Q?RKfEmIJJtq2XKssp4jPmcVGmyqVMHYn1qLTsSIgThvaBqUQPNVGvLl/aIFBF?=
 =?us-ascii?Q?NOdlRZpV30OoRX4ES5xgollJecydRlHoZl2CooELWKiBIH8OTy3uBaRwvfIm?=
 =?us-ascii?Q?pGuKVo5tIWy/ASAMI48ADwHLyY7oJj+yh5qh7VZl740gkI3xDM66DEdw9Yn3?=
 =?us-ascii?Q?UgCo1UXxkC1obWRo9UcqvTT/81dgKi0RsdfK628G/TbEuWnphrKd9Tj5rZsb?=
 =?us-ascii?Q?Fd2VLVVECSgX0fYnDiJZ3euNRLx1uqiyrTvYD2WNPJa3RG4AzpQGYr8wZYWT?=
 =?us-ascii?Q?ViVc2245X1DdEZR655KjyO3DYkV1DhzgrT6qNuvUnHWCW2SFGQKsf2KcPm2j?=
 =?us-ascii?Q?IyBvw6KkKe7KM8yTASP6oNRgIfzQ8m3UzqWgWIfB38vWdT9E9cNxexkZC6ba?=
 =?us-ascii?Q?F0yjTttXS2Nnzv/b3EptYlxLnUuCG7cpvbl0TwqyoMoRhPakAGGmu/APT0YI?=
 =?us-ascii?Q?p72f2rxHFi5AxNML/6vEqb04+9xkSNabFr1vad9oU6DB0x+Y1GyFD6vVFsvq?=
 =?us-ascii?Q?h9naqx+0zVYtmNMKy/vi84C5IOGxstulhfeP//I7l1Fk+AhCHMUeOxA4qosz?=
 =?us-ascii?Q?yOJF4ANP7DYMgnqPkfpgzrm7rCnwVSf4zyqtV17UKy2M6UxClR/H0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E9D5DAE77D91B4ABE7CB2D79B257BE8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a89045-a9b2-4564-af18-08da08f98d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 16:08:33.8603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+zS8h2sRtEdzdbnroZVYiAy8VuTJpepgn3Zr53SI7CXz3YJL5xmmD1lFrnUGpIqmqILb4bHIZiMWRGWEp8oiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5947
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 16, 2022 at 11:09:12PM +0900, Naohiro Aota wrote:
> In btrfs_make_block_group(), we activate the allocated block group,
> expecting that the block group is soon used for allocation. However, the
> chunk allocation from flush_space() context broke the assumption. There c=
an
> be a large time gap between the chunk allocation time and the extent
> allocation time from the chunk.
>=20
> Activating the empty block groups pre-allocated from flush_space() contex=
t
> can exhaust the active zone counter of a device. Once we use all the acti=
ve
> zone counts for empty pre-allocated BGs, we cannot activate new BG for th=
e
> other things: metadata, tree-log, or data relocation BG. That failure
> results in a fake -ENOSPC.
>=20
> This patch introduces CHUNK_ALLOC_FORCE_FOR_EXTENT to distinguish the chu=
nk
> allocation from find_free_extent(). Now, the new block group is activated
> only in that context.
>=20
> Fixes: eb66a010d518 ("btrfs: zoned: activate new block group")
> Cc: stable@vger.kernel.org # 5.16+: c7d1b9109dd0: btrfs: return allocated=
 block group from do_chunk_alloc()
> Cc: stable@vger.kernel.org # 5.16+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/block-group.c | 24 ++++++++++++++++--------
>  fs/btrfs/block-group.h |  1 +
>  fs/btrfs/extent-tree.c |  2 +-
>  3 files changed, 18 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index d4ac1c76f539..6caa86c8eb12 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2481,12 +2481,6 @@ struct btrfs_block_group *btrfs_make_block_group(s=
truct btrfs_trans_handle *tran
>  		return ERR_PTR(ret);
>  	}
> =20
> -	/*
> -	 * New block group is likely to be used soon. Try to activate it now.
> -	 * Failure is OK for now.
> -	 */
> -	btrfs_zone_activate(cache);
> -
>  	ret =3D exclude_super_stripes(cache);
>  	if (ret) {
>  		/* We may have excluded something, so call this just in case */
> @@ -3642,8 +3636,14 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *t=
rans, u64 flags,
>  	struct btrfs_block_group *ret_bg;
>  	bool wait_for_alloc =3D false;
>  	bool should_alloc =3D false;
> +	bool from_extent_allocation =3D false;
>  	int ret =3D 0;
> =20
> +	if (force =3D=3D CHUNK_ALLOC_FORCE_FOR_EXTENT) {
> +		from_extent_allocation =3D true;
> +		force =3D CHUNK_ALLOC_FORCE;
> +	}
> +
>  	/* Don't re-enter if we're already allocating a chunk */
>  	if (trans->allocating_chunk)
>  		return -ENOSPC;
> @@ -3736,9 +3736,17 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *t=
rans, u64 flags,
>  	ret_bg =3D do_chunk_alloc(trans, flags);
>  	trans->allocating_chunk =3D false;
> =20
> -	if (IS_ERR(ret_bg))
> +	if (IS_ERR(ret_bg)) {
>  		ret =3D PTR_ERR(ret_bg);
> -	else
> +	} else if (!from_extent_allocation) {

Please ignore this series as this condition is flipped.

> +		/*
> +		 * New block group is likely to be used soon. Try to activate
> +		 * it now. Failure is OK for now.
> +		 */
> +		btrfs_zone_activate(ret_bg);
> +	}
> +
> +	if (!ret)
>  		btrfs_put_block_group(ret_bg);
> =20
>  	spin_lock(&space_info->lock);
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 93aabc68bb6a..9c822367c432 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -40,6 +40,7 @@ enum btrfs_chunk_alloc_enum {
>  	CHUNK_ALLOC_NO_FORCE,
>  	CHUNK_ALLOC_LIMITED,
>  	CHUNK_ALLOC_FORCE,
> +	CHUNK_ALLOC_FORCE_FOR_EXTENT,
>  };
> =20
>  struct btrfs_caching_control {
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index f477035a2ac2..6aa92f84f465 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4082,7 +4082,7 @@ static int find_free_extent_update_loop(struct btrf=
s_fs_info *fs_info,
>  			}
> =20
>  			ret =3D btrfs_chunk_alloc(trans, ffe_ctl->flags,
> -						CHUNK_ALLOC_FORCE);
> +						CHUNK_ALLOC_FORCE_FOR_EXTENT);
> =20
>  			/* Do not bail out on ENOSPC since we can do more. */
>  			if (ret =3D=3D -ENOSPC)
> --=20
> 2.35.1
> =
