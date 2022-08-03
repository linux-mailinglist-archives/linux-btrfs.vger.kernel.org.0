Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39EC589447
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 00:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiHCWJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 18:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHCWJl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 18:09:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075EA1D31C
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 15:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659564574;
        bh=BVEKQxq4vNBAS9rE90DlQBKGcR3KOPNlxmeYSY59DxY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=AKYOiu0g71R5UdYWB30IziLnHoGBRJOif8jJ2/36/27nuqr2V76LzoaWdYn74Di4Q
         ekQDYdxoTqbJK5YMwQyJQXpPDSSjO3j1JCouEAnzA/JwsauAmsLZPb74uG2soi4PGf
         MxhwwjDPvUeq5Vm6ex9DIy2lJ/ngHWaSycuKcquU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMofc-1o2ndp1r64-00IpqG; Thu, 04
 Aug 2022 00:09:34 +0200
Message-ID: <a0f908d8-a6ee-4fe5-83b4-090b555dd324@gmx.com>
Date:   Thu, 4 Aug 2022 06:09:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs: check for overlapping extent items in tree checker
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <0a9f7ca2717c0378acf77d71a0d1b680d4d5d6b9.1659551313.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <0a9f7ca2717c0378acf77d71a0d1b680d4d5d6b9.1659551313.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VIwwZ6mOeBuDV+PGxGQq5a6rHQn05/c8ukaOj0fSKGDHt8AM/9S
 3YI3AgNpIXVJ2QpORWDjCtQnS17q7xKaCrbXXI/KIyGYq7ztQNNIabku9rmzE7PrMRsCKVu
 WGeZM19b/T0jgXBz9aOl+B8OP4UKG1dqB8poKK7fcalDDwsWInGQL2pQsuEgFIP4yjfsogW
 1zAa1ZWtj4mBAnmcr0UyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c/NKG/KJ59M=:Q0kfIGeoGfq0NiF8iqVSuj
 pEF7bdrW3bs/X9fQ64s3HWPEubK6VDSgovdrLCuZZVdwCBao94OflV4/nAA5Ce1UxHYmTNYZj
 TFRcdjEGhT3t6DlbzlL7a7sdkXTMX8PtSvvzyctT9W1K8C3TUY4Iw7RONdRgOWimcfMFerli5
 nr3INFj575CQuPgmdJUAtIxCfGKYnSvnjA47BCOYhK2PErd757ocqES4ZbK0xUr6Z6efLysqq
 GlTPi+77zNti42Fe28rISLK8f3z7HiYdjQghkCibogIg8E6hIjIKezRMFCzCywKRTdB5SBssJ
 vc1trDxXIVU2GaxsZBGxrTXhdfzT9uv7UaW1avONdUv5wVlXY/QmAPCtNi4fpRkE+dRg3+Tu4
 65OSfJDLH8SOaHZKDVykGdVSOegcJZP3uUQn+MVOt3wtG8VrImqGhlculmXVpT9xnaS4eVCaU
 EehBt12qGI7tl15gKKpwIYo3unR36c2QRLyXLTQBIST02B5o6MsOeqIFNx/FabFELQz1+4vub
 l9iq5oo7bBTOQPCpJzqcMOPc2+u256w/Y8vN0UNG2LvN+WJR36JHvE7QfOxeU1ALP/D073OVo
 Sukbjs7T9Mza5HdzYZA9ZJCI5LN54Xc09Aeo/RvTTn+2b9RT55GP/PcKfTESKpTb1m4VOY4rq
 O2FpRHJclylTPbffSNvhMUjJQ8zpfSXOCHYKKziPELJdMZ1DgJHtloI1uZ+gaaQfC8+mPu9z6
 AoK8nR6gA+0uR5Ksx0BenxRLejO9cqli91envJ3va3ZGeIsUmbnEtAxfB/X5TzozhTLrZWC6t
 ssRZ28xCoQEb58JmHXBghA5gk/SbxCsUz9KgxfCy7sTvIc4MuVFqx2Et/HljtXN/ugE9tJ1eg
 qaTjxqEW0Y3z1fqVrbmbEXMyetRAFUfnLU1MpTAA9oq+S20PfaSWsI1M4XCL6JWnv+y0fCSrO
 KS/vkvmiwYoyNAcB1WE6IfTb+n84We/1PuyK0lpCrb1P7/ujzbq1aFE0UGm+f8aHv5PUms5+Z
 Vm1tlya6IGbnDLA+irCz327aWjLzphQQn99zywN3UmTA4xOQ8+kVfcivQewkcQgJoHKQj3qNn
 5CjmgExhdIGH9Vgf2s5GhYWKXzpvqmCzSPpK8Y5BAjug2QXYd3VOBk61w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/4 02:28, Josef Bacik wrote:
> We're seeing a weird problem in production where we have overlapping
> extent items in the extent tree.  It's unclear where these are coming
> from, and in debugging we realized there's no check in the tree checker
> for this sort of problem.  Add a check to the tree-checker to make sure
> that the extents do not overlap each other.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/tree-checker.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 9e0e0ae2288c..43f905ab0a18 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1233,7 +1233,8 @@ static void extent_err(const struct extent_buffer =
*eb, int slot,
>   }
>
>   static int check_extent_item(struct extent_buffer *leaf,
> -			     struct btrfs_key *key, int slot)
> +			     struct btrfs_key *key, int slot,
> +			     struct btrfs_key *prev_key)
>   {
>   	struct btrfs_fs_info *fs_info =3D leaf->fs_info;
>   	struct btrfs_extent_item *ei;
> @@ -1453,6 +1454,26 @@ static int check_extent_item(struct extent_buffer=
 *leaf,
>   			   total_refs, inline_refs);
>   		return -EUCLEAN;
>   	}
> +
> +	if ((prev_key->type =3D=3D BTRFS_EXTENT_ITEM_KEY) ||
> +	    (prev_key->type =3D=3D BTRFS_METADATA_ITEM_KEY)) {
> +		u64 prev_end =3D prev_key->objectid;
> +
> +		if (prev_key->type =3D=3D BTRFS_METADATA_ITEM_KEY)
> +			prev_end +=3D fs_info->nodesize;
> +		else
> +			prev_end +=3D prev_key->offset;
> +
> +		if (unlikely(prev_end > key->objectid)) {
> +			extent_err(leaf, slot,
> +	"previous extent [%llu %u %llu] overlaps current extent [%llu %u %llu]=
",
> +				   prev_key->objectid, prev_key->type,
> +				   prev_key->offset, key->objectid, key->type,
> +				   key->offset);
> +			return -EUCLEAN;
> +		}
> +	}
> +
>   	return 0;
>   }
>
> @@ -1621,7 +1642,7 @@ static int check_leaf_item(struct extent_buffer *l=
eaf,
>   		break;
>   	case BTRFS_EXTENT_ITEM_KEY:
>   	case BTRFS_METADATA_ITEM_KEY:
> -		ret =3D check_extent_item(leaf, key, slot);
> +		ret =3D check_extent_item(leaf, key, slot, prev_key);
>   		break;
>   	case BTRFS_TREE_BLOCK_REF_KEY:
>   	case BTRFS_SHARED_DATA_REF_KEY:
