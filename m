Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2215D3F12F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 07:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhHSFzU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 01:55:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:47887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhHSFzU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 01:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629352480;
        bh=HMDWUbctEXYMFWgov2uTlFJPprWj9xFZLuL00fKd7Fk=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=YNh+1akptWSM4Yl9fTX+7WfCnshLMcQneCz3Pq0STAlO6tCxCMcAhTK4nWdch+Wu+
         wwAvASz/lC5F19Fsc1OWo4/uJFiTPSYrX8K6jpqVEtHUSStU9d2OgkwQdlBKj7D9CJ
         PdhOAMhuy/STTdchpXxvlD2sW/nwhUfHRScRmmcA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPXhA-1mUG0T2ZBi-00MfnO; Thu, 19
 Aug 2021 07:54:40 +0200
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629322156.git.josef@toxicpanda.com>
 <9b24d30f3703d7d714c4bb37ce817d1eaa92980b.1629322156.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 08/12] btrfs-progs: make check detect and fix invalid
 used for block groups
Message-ID: <592d1d7f-d9e5-c96b-1f89-39cf0aa80775@gmx.com>
Date:   Thu, 19 Aug 2021 13:54:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9b24d30f3703d7d714c4bb37ce817d1eaa92980b.1629322156.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sBTms47CTyKOhoXSINtDqpL+XaA25ut4uz+xhcHTi+c7+WOZhln
 qhy+QgajRKRkj5+PYAtACe5mpFpWNljoMRtMAxgtpMRkSUNnWOTG4XGO+2I5rydhujb0bQn
 nS4CXMnVCYorRp61HUq64rAWAaDAMt85Lbqp7XtzDh4CnaIgc2WlV2mw+UUAYRG0hmM1WDG
 ZeVhWSnv4fy4L0L+Lf3XA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AN+EQzD7ovQ=:CFZMEFaTRD/g9MKExAkWTp
 nNCzB2/WRfzy5cCc8SlIUWJBzhdMhYbvX/2OtesTz2U0dv0167smYpGsIoW473U/wA48p8pL4
 7Vwa3hqitAL/9S8B+hGlOiTuYP5OqEPeS2NoM9L7DuN2AkVGaMD/j8JaSYxndcD4Wjiv97+3t
 l2wo0skWs3OTWkinvYQDAVzZ1E9ifPascjTRI4b3crV0Gx6kb9q8aClkGiLFVh3Y9tPw7eujY
 kafgWLATIuZ/+ymM+b4AN5Ozt0B1GJCQqkghoMDFEt2vFAt1ZncEFFQVmGnqFZNyg6ZeizKwk
 55uSN53ntilBvQ8/VyDFeu/2x1G4G134Uepwskv88mNVF1oSeGNQJGOv2W9nyQqbhQ1RA8lOj
 CykBpc2xFf42wKLArprBYaCH5Mpcwl+ZcgYKgTyE1NsGzgroF6u2T1gD/o1fcaWQx85/8inxF
 CTzZ53O+ib/ysYfpnp0ku9D379k3mj/oV08Hfp247Dim6x7enReGYQNiOpAoaA7KWmqgTfGMB
 2MVI9Y1woDyEHN7oLN41GS86kvVoV0HoOvSFDz0vLO+26sbI2XKZFvg0xiR8jjTImsBlQ5PWD
 vXZscg+wjEjRQ+Ry7F2ya43WwUcYQM2SzXPTmGxdUIUE3n9hte7WdVXpF+GZHazD1siHixbc7
 TUydLWd/IITJu+y/SwftKCVWEeThYo+1eeHdJMD351BKQyqUxqapD+k71/DKXmsQa8xwDOQXm
 OIBaFsVkKDKdOAEiWv2d3Y3CeIvu+vBl4lFG40ZJj+t/5xrtXy6p257omwrrwc8XjW91NwMZ5
 HcyOAjOKESWK8p6IUsAE3m1d0CNG4TmmPUwvC2k0eLXqix7SDCRh9j1MurzTkDAmx5uMSOSv5
 tn0RS8T1VfMxHUS5UBD+4AKarmbiJICjDWQFXNzOJXe7VVvb1QhdynkQR0D8U+3Z56RsQBN1r
 ouiExSO8ox3vUTmYvfoPDtSP9Wb8uyrhmQg8QMMwhdpAlDRSvs7CtLYuZgMWpMzjML9kh1SD1
 uU2vm+gWO9UH97xv7Ycpv8sHFiDYZCHDT34eQF3p47FjyCp3+/cKTDL6PwQebpROYOJnKRZXJ
 sLbHYdyGQlMNKriIhXWPzFczbB0M/04BbN+QOCHpSJEky3D+CEWO+kcSA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/19 =E4=B8=8A=E5=8D=885:33, Josef Bacik wrote:
> The lowmem mode validates the used field of the block group item, but
> the normal mode does not.  Fix this by keeping a running tally of what
> we think the used value for the block group should be, and then if it
> mismatches report an error and fix the problem if we have repair set.
> We have to keep track of pending extents because we process leaves as we
> see them, so it could be much later in the process that we find the
> block group item to associate the extents with.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   check/common.h |  5 +++
>   check/main.c   | 89 +++++++++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 90 insertions(+), 4 deletions(-)
>
> diff --git a/check/common.h b/check/common.h
> index e72379a0..ba4e291e 100644
> --- a/check/common.h
> +++ b/check/common.h
> @@ -37,10 +37,14 @@ struct block_group_record {
>   	u64 offset;
>
>   	u64 flags;
> +
> +	u64 disk_used;
> +	u64 actual_used;
>   };
>
>   struct block_group_tree {
>   	struct cache_tree tree;
> +	struct extent_io_tree pending_extents;
>   	struct list_head block_groups;
>   };
>
> @@ -141,6 +145,7 @@ u64 calc_stripe_length(u64 type, u64 length, int num=
_stripes);
>   static inline void block_group_tree_init(struct block_group_tree *tree=
)
>   {
>   	cache_tree_init(&tree->tree);
> +	extent_io_tree_init(&tree->pending_extents);
>   	INIT_LIST_HEAD(&tree->block_groups);
>   }
>
> diff --git a/check/main.c b/check/main.c
> index 3f6db8f8..af9e0ff3 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -5083,9 +5083,27 @@ static void free_block_group_record(struct cache_=
extent *cache)
>
>   void free_block_group_tree(struct block_group_tree *tree)
>   {
> +	extent_io_tree_cleanup(&tree->pending_extents);
>   	cache_tree_free_extents(&tree->tree, free_block_group_record);
>   }
>
> +static void update_block_group_used(struct block_group_tree *tree,
> +				    u64 bytenr, u64 num_bytes)
> +{
> +	struct cache_extent *bg_item;
> +	struct block_group_record *bg_rec;
> +
> +	bg_item =3D lookup_cache_extent(&tree->tree, bytenr, num_bytes);
> +	if (!bg_item) {
> +		set_extent_dirty(&tree->pending_extents, bytenr,
> +				 bytenr + num_bytes - 1);
> +		return;
> +	}

I guess this is to handle cases where the extent item shows up before we
reached the block group item.

So we set the pending_extents range dirty, and waiting for the block
group item to show up.

But I'm not sure if we really need to handle them like this.

Can't we just set the range dirty and call it a day, then check the tree
to calculate the actual used space for each block group item after we
iterated the whole extent tree?

Thanks,
Qu

> +	bg_rec =3D container_of(bg_item, struct block_group_record,
> +			      cache);
> +	bg_rec->actual_used +=3D num_bytes;
> +}
> +
>   int insert_device_extent_record(struct device_extent_tree *tree,
>   				struct device_extent_record *de_rec)
>   {
> @@ -5270,6 +5288,7 @@ btrfs_new_block_group_record(struct extent_buffer =
*leaf, struct btrfs_key *key,
>
>   	ptr =3D btrfs_item_ptr(leaf, slot, struct btrfs_block_group_item);
>   	rec->flags =3D btrfs_block_group_flags(leaf, ptr);
> +	rec->disk_used =3D btrfs_block_group_used(leaf, ptr);
>
>   	INIT_LIST_HEAD(&rec->list);
>
> @@ -5281,6 +5300,7 @@ static int process_block_group_item(struct block_g=
roup_tree *block_group_cache,
>   				    struct extent_buffer *eb, int slot)
>   {
>   	struct block_group_record *rec;
> +	u64 start, end;
>   	int ret =3D 0;
>
>   	rec =3D btrfs_new_block_group_record(eb, key, slot);
> @@ -5289,6 +5309,22 @@ static int process_block_group_item(struct block_=
group_tree *block_group_cache,
>   		fprintf(stderr, "Block Group[%llu, %llu] existed.\n",
>   			rec->objectid, rec->offset);
>   		free(rec);
> +		return ret;
> +	}
> +
> +	while (!find_first_extent_bit(&block_group_cache->pending_extents,
> +				      rec->objectid, &start, &end,
> +				      EXTENT_DIRTY)) {
> +		u64 len;
> +
> +		if (start >=3D rec->objectid + rec->offset)
> +			break;
> +		start =3D max(start, rec->objectid);
> +		len =3D min(end - start + 1,
> +			  rec->objectid + rec->offset - start);
> +		rec->actual_used +=3D len;
> +		clear_extent_dirty(&block_group_cache->pending_extents, start,
> +				   start + len - 1);
>   	}
>
>   	return ret;
> @@ -5352,6 +5388,7 @@ process_device_extent_item(struct device_extent_tr=
ee *dev_extent_cache,
>
>   static int process_extent_item(struct btrfs_root *root,
>   			       struct cache_tree *extent_cache,
> +			       struct block_group_tree *block_group_cache,
>   			       struct extent_buffer *eb, int slot)
>   {
>   	struct btrfs_extent_item *ei;
> @@ -5380,6 +5417,8 @@ static int process_extent_item(struct btrfs_root *=
root,
>   		num_bytes =3D key.offset;
>   	}
>
> +	update_block_group_used(block_group_cache, key.objectid, num_bytes);
> +
>   	if (!IS_ALIGNED(key.objectid, gfs_info->sectorsize)) {
>   		error("ignoring invalid extent, bytenr %llu is not aligned to %u",
>   		      key.objectid, gfs_info->sectorsize);
> @@ -6348,13 +6387,13 @@ static int run_next_block(struct btrfs_root *roo=
t,
>   				continue;
>   			}
>   			if (key.type =3D=3D BTRFS_EXTENT_ITEM_KEY) {
> -				process_extent_item(root, extent_cache, buf,
> -						    i);
> +				process_extent_item(root, extent_cache,
> +						    block_group_cache, buf, i);
>   				continue;
>   			}
>   			if (key.type =3D=3D BTRFS_METADATA_ITEM_KEY) {
> -				process_extent_item(root, extent_cache, buf,
> -						    i);
> +				process_extent_item(root, extent_cache,
> +						    block_group_cache, buf, i);
>   				continue;
>   			}
>   			if (key.type =3D=3D BTRFS_EXTENT_CSUM_KEY) {
> @@ -8619,6 +8658,41 @@ static int deal_root_from_list(struct list_head *=
list,
>   	return ret;
>   }
>
> +static int check_block_groups(struct block_group_tree *bg_cache)
> +{
> +	struct btrfs_trans_handle *trans;
> +	struct cache_extent *item;
> +	struct block_group_record *bg_rec;
> +	int ret =3D 0;
> +
> +	for (item =3D first_cache_extent(&bg_cache->tree); item;
> +	     item =3D next_cache_extent(item)) {
> +		bg_rec =3D container_of(item, struct block_group_record,
> +				      cache);
> +		if (bg_rec->disk_used =3D=3D bg_rec->actual_used)
> +			continue;
> +		fprintf(stderr,
> +			"block group[%llu %llu] used %llu but extent items used %llu\n",
> +			bg_rec->objectid, bg_rec->offset, bg_rec->disk_used,
> +			bg_rec->actual_used);
> +		ret =3D -1;
> +	}
> +
> +	if (!repair || !ret)
> +		return ret;
> +
> +	trans =3D btrfs_start_transaction(gfs_info->extent_root, 1);
> +	if (IS_ERR(trans)) {
> +		ret =3D PTR_ERR(trans);
> +		fprintf(stderr, "Failed to start a transaction\n");
> +		return ret;
> +	}
> +
> +	ret =3D btrfs_fix_block_accounting(trans);
> +	btrfs_commit_transaction(trans, gfs_info->extent_root);
> +	return ret ? ret : -EAGAIN;
> +}
> +
>   /**
>    * parse_tree_roots - Go over all roots in the tree root and add each =
one to
>    *		      a list.
> @@ -8910,6 +8984,13 @@ again:
>   		goto out;
>   	}
>
> +	ret =3D check_block_groups(&block_group_cache);
> +	if (ret) {
> +		if (ret =3D=3D -EAGAIN)
> +			goto loop;
> +		goto out;
> +	}
> +
>   	ret =3D check_devices(&dev_cache, &dev_extent_cache);
>   	if (ret && err)
>   		ret =3D err;
>
