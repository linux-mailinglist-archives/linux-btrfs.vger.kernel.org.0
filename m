Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F4B529BC0
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 10:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbiEQIGm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 04:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiEQIGk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 04:06:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CBA24F13
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652774793;
        bh=+Hrp0zlKWFbiJhD5VwUX1/jBNuAtWK0LFVqCCFTnkYg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=gTwG/2hKjKTxmtg4rT+OpqcEw2lDJSdRX8RgExbyW9EXoReb2NwcKdl8b4c1FsqHe
         J7Ms6xie+6pcRk7qiJKZU7oS7T4wbDHkwXySH3zYgzijxkisur1A7l0PtOvNIh9814
         sbC4m412aT2AKMhl8c4d8ezNBztruIpYCt7e6w+8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Ml6mE-1nTx0m0O5M-00lYRK; Tue, 17
 May 2022 10:06:32 +0200
Message-ID: <d16c5465-2c24-1ce1-9b51-be85cd96259b@gmx.com>
Date:   Tue, 17 May 2022 16:06:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 5/8] btrfs: add code to delete raid extent
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <b018704727883c27c3368f1cd3ba84daf682b733.1652711187.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b018704727883c27c3368f1cd3ba84daf682b733.1652711187.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wbi/RfaWMSGqiGj9IopKjC4vItIyJbx4DGixkZLm/mhY20NsCEA
 OnBHsGpQfUV33/o6SkrJhdjYWFeZz4tSLS0/KsO/Bvbl4vb6qk5dmAzh3s77jRiIeYqKWxY
 p9QFeWTSbudDAPq1JASVXnZkK7URh0S7u2YHdnqoJYRuyj1xq8xhg9t1fZuldID0HO3Qa+u
 ty8gDcw5DhkeYwVx/eyLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pg8rV7g0+iY=:CbouqOPxhIAZCQ+w+sOJQC
 pDmNNP2fy3d6tFxeOgEyhIO2WVncqM7K3hE2mnHdBcUlRabzTRoziZQawA3JZ1cOvlPoKt26d
 st+rYp3iCQa9Tj1UidxNc06ieBXSvSv/rd10+B6gc8x4zgSJiqGCbc40tXibQyTK2lSw6H9yF
 zqWiBBRkReloAQsameAHjKGPNDRbSJAgT7ksuI8UIx/X0VSy71EB6qvUOb1rCCBHAn2B358z0
 1Xpqj0GSOxcMG1fT4te1cbpPBRWt1JkBU47IJS3Ud9CWyWfAsrWXAC+PSfdJqqf6OUXMoDNdc
 PCLRkZ9o7jupFBY4VSDK84uFHkwgJUD1l7cXEuK76udKzYn2cuTH5SP5qgpdYUEtwM4eXsjYl
 sRneHR4NYWFZpg4Un/Ex0UP4cmEliwsqWsMgOynI0zwO57sAtHI1iGinLObvJZBbsv9P2WYDn
 PWcVDEM5noEhop0SziAgTkwKJhWoVwiGS09fjlthUYlzSE8yh0q/f9lkv7SUdSqf6is29M6zg
 ymsvXkQbwv/CCupGPh19FkzjY+sa5EFiSLBiimyo44Vb5HGYUQ73m6Oi4Qq64FqqoXf3Oj42T
 3zVAXvUszJkMgjXr6sY50yXoHVrJxMxv0kZ80KDq38JIWnNwVsdctrflmeoHmZICXECvo3YyU
 LIlFBtqf/LBPPwjdp40sDJDVqYDFZM8OafIRMZbFBh5AjQH5ysCSphhDJN0xpVIfhmAy290B0
 FSw5LAGu0lIVAvp4YCx6jdpjKpaAp2H+ZGmmmwKtOJL3bO63ia0KBXvA9OXKDyTbrImDEWmaa
 jgf8HdrATuI9OVovI7ofZk7QMI63oNMQM3pYC+79CRFWWzBRFhdWM4o61N1U2BaNrEh60Z0sj
 Ze0Wn6Z3KP1iz/Ffmc6KobtX6RzAnQFb+1vKUSINMHaKJ3Te7/r2WIe8z8Z2UFruO2EzoZUeP
 F8XFYlCji1eo2JJYdIjYpcltb6bJpC0xVb9KxJWqw/ljs8kbk+ORgufxeYUqp6/2X9oTLR+rQ
 ejg1KhacuRbFrwaeqczb2W1qUcKlg+Hq9re9Ct+Ta4vbk0UlDkk3zq+5AyPdwcIdPKegvoKuc
 phFamhX9ArtcxZCmzH9YJzrqbsj8azmRw+kowfAuQ9qzEdinDvIA7ZaMQ==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/16 22:31, Johannes Thumshirn wrote:
> Add boilerplate code to delete entries from the raid-stripe-tree if the
> corresponding file extent got deleted.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/ctree.c            |   1 +
>   fs/btrfs/extent-tree.c      |   9 +++
>   fs/btrfs/file.c             |   1 -
>   fs/btrfs/raid-stripe-tree.c | 111 ++++++++++++++++++++++++++++++++++++
>   fs/btrfs/raid-stripe-tree.h |   8 +++
>   5 files changed, 129 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 1e24695ede0a..b7b4e421e9b8 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -3623,6 +3623,7 @@ static noinline int setup_leaf_for_split(struct bt=
rfs_trans_handle *trans,
>   	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>
>   	BUG_ON(key.type !=3D BTRFS_EXTENT_DATA_KEY &&
> +	       key.type !=3D BTRFS_RAID_STRIPE_KEY &&
>   	       key.type !=3D BTRFS_EXTENT_CSUM_KEY);
>
>   	if (btrfs_leaf_free_space(leaf) >=3D ins_len)
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index f477035a2ac2..00af3e469881 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -36,6 +36,7 @@
>   #include "rcu-string.h"
>   #include "zoned.h"
>   #include "dev-replace.h"
> +#include "raid-stripe-tree.h"
>
>   #undef SCRAMBLE_DELAYED_REFS
>
> @@ -3199,6 +3200,14 @@ static int __btrfs_free_extent(struct btrfs_trans=
_handle *trans,
>   			}
>   		}

Considering we're already in __btrfs_free_extents(), and the branch
we're in is already for refs =3D=3D 1 case, which means we're already the
last one owning the file extent (and its stripe tree entry).
>
> +		if (is_data) {
> +			ret =3D btrfs_delete_raid_extent(trans, bytenr, num_bytes);
> +			if (ret) {
> +				btrfs_abort_transaction(trans, ret);
> +				return ret;
> +			}
> +		}
> +
>   		ret =3D btrfs_del_items(trans, extent_root, path, path->slots[0],
>   				      num_to_del);
>   		if (ret) {
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index bd329316945f..6021188dcb9a 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1009,7 +1009,6 @@ int btrfs_drop_extents(struct btrfs_trans_handle *=
trans,
>   		btrfs_release_path(path);
>   out:
>   	args->drop_end =3D found ? min(args->end, last_end) : args->end;
> -
>   	return ret;
>   }
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 426066bd7c0d..370ea68fe343 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -6,6 +6,117 @@
>   #include "raid-stripe-tree.h"
>   #include "volumes.h"
>
> +int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 star=
t,
> +			     u64 length)
> +{
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_root *stripe_root =3D fs_info->stripe_root;
> +	struct btrfs_path *path;
> +	struct btrfs_key stripe_key;
> +	struct btrfs_key found_key;
> +	struct extent_buffer *leaf;
> +	u64 end =3D start + length;
> +	u64 found_start;
> +	u64 found_end;
> +	int slot;
> +	int ret;
> +
> +	if (!stripe_root)
> +		return 0;
> +
> +	stripe_key.objectid =3D start;
> +	stripe_key.type =3D BTRFS_RAID_STRIPE_KEY;
> +	stripe_key.offset =3D end;
> +
> +	path =3D btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret =3D btrfs_search_slot(trans, stripe_root, &stripe_key, path, -1, 1=
);
> +	if (ret < 0)
> +		goto out;
> +	if (ret =3D=3D 0)
> +		goto delete;
> +
> +	leaf =3D path->nodes[0];
> +	slot =3D path->slots[0];
> +	btrfs_item_key_to_cpu(leaf, &found_key, slot);
> +	found_start =3D found_key.objectid;
> +	found_end =3D found_start + found_key.offset;
> +
> +	/*
> +	 * | -- range to drop --|
> +	 * | ---------- extent ---------- |
> +	 */

Thus I believe we don't need those complex checking.

The call site has make sure we're the last one owning the file extent,
and since raid stripe is 1:1 mapped to the full extent (not just part of
a data extent, like btrfs_file_extent_item can do), we should be safe to
just do an ASSERT() without the complex split.


Thus, I guess to be extra accurate, the 1:1 mapping is between an (data)
EXTENT_ITEM and a raid stripe?

Thanks,
Qu
> +front_split:
> +	if (start > found_start) {
> +		struct btrfs_key front_key;
> +		struct btrfs_dp_stripe *raid_stripe;
> +		struct extent_buffer *front_leaf;
> +		struct btrfs_stripe_extent *stripe_extent;
> +		int num_stripes;
> +		int i;
> +
> +		front_key.objectid =3D found_start + length;
> +		front_key.type =3D BTRFS_RAID_STRIPE_KEY;
> +		front_key.offset =3D found_end - length;
> +
> +		num_stripes =3D btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
> +
> +		ret =3D btrfs_duplicate_item(trans, stripe_root, path, &front_key);
> +		if (ret =3D=3D -EAGAIN) {
> +			btrfs_release_path(path);
> +			goto front_split;
> +		}
> +		if (ret < 0)
> +			goto out;
> +		front_leaf =3D path->nodes[0];
> +
> +		raid_stripe =3D btrfs_item_ptr(leaf, slot, struct btrfs_dp_stripe);
> +		stripe_extent =3D &raid_stripe->extents;
> +		for (i =3D 0; i < num_stripes; i++) {
> +			u64 physical;
> +
> +			physical =3D btrfs_stripe_extent_offset(leaf, stripe_extent);
> +			btrfs_set_stripe_extent_offset(front_leaf, stripe_extent,
> +							  physical + length);
> +			stripe_extent++;
> +		}
> +
> +		btrfs_mark_buffer_dirty(front_leaf);
> +	}
> +
> +	/*
> +	 *           | -- range to drop --|
> +	 * | ---------- extent ---------- |
> +	 */
> +tail_split:
> +	if (end < found_end) {
> +		struct btrfs_key tail_key;
> +
> +
> +		tail_key.objectid =3D start;
> +		tail_key.type =3D BTRFS_RAID_STRIPE_KEY;
> +		tail_key.offset =3D found_end - end;
> +
> +		ret =3D btrfs_duplicate_item(trans, stripe_root, path, &tail_key);
> +		if (ret =3D=3D -EAGAIN) {
> +			btrfs_release_path(path);
> +			goto tail_split;
> +		}
> +		if (ret < 0)
> +			goto out;
> +		btrfs_mark_buffer_dirty(path->nodes[0]);
> +	}
> +
> +delete:
> +	ret =3D btrfs_del_item(trans, stripe_root, path);
> +out:
> +	btrfs_free_path(path);
> +	return ret;
> +
> +}
> +
>   static void btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
>   				     struct btrfs_io_context *bioc)
>   {
> diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
> index 320a110ecc66..766634df8601 100644
> --- a/fs/btrfs/raid-stripe-tree.h
> +++ b/fs/btrfs/raid-stripe-tree.h
> @@ -5,8 +5,16 @@
>
>   #include "volumes.h"
>
> +int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 star=
t,
> +			     u64 length);
>   void btrfs_raid_stripe_tree_fn(struct work_struct *work);
>
> +static inline int btrfs_num_raid_stripes(u32 item_size)
> +{
> +	return item_size - offsetof(struct btrfs_dp_stripe, extents) /
> +		sizeof(struct btrfs_stripe_extent);
> +}
> +
>   static inline bool btrfs_need_stripe_tree_update(struct btrfs_io_conte=
xt *bioc)
>   {
>   	u64 type =3D bioc->map_type & BTRFS_BLOCK_GROUP_TYPE_MASK;
