Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A724048740D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 09:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345748AbiAGIUo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 03:20:44 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63754 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbiAGIUj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jan 2022 03:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641543638; x=1673079638;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Gd8AouSaHaZjs1ZBpqaempbjaVQxK1sdDJFTXIOI150=;
  b=FN1X4jMMo9idUP5Q9o9c4V2F087bHVcjj+DAyk5SmInAcV+My4ovOIah
   0Dn5dzpIAYDHn4PKJdCrkWM2MrScwxue80EK2pSEwGSWb2kSM6J52PZiU
   1pJgUAK2eN+tEvn/R799HLEuX5ntKJLB5jkZk63+aXEon6vy9VGvyjC35
   8xmvOqZQYtiNcKjJpwUTNF0MqVlHguLj6/Yzqa/GX1zFuu2JZYjR5/If2
   AfUhqUsNOPXDE5WHNw3Ye7x0qoNYmTGKRFeqowYseIWFYCcmohSw7RR8d
   Oh8iu9qcboDb3jjkVVsTd/i6kTIL3WlJiJyzcCGvBrSYwG56Wkz7k326c
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,269,1635177600"; 
   d="scan'208";a="194713453"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2022 16:20:36 +0800
IronPort-SDR: U4cjPTi1ByKK8Ze4k2mm10+9Pd2LDpT2ndhALcuNsYC/57M2VlZYUY6cIEHSAriTT1bQRWxGRZ
 rprjAoJerGI4MC4iMcLp7bV1vcatG2xECsWc45cl4Bhtd+ysIC1RvCASHZ0ovRFHyCWHbaAZCy
 ZjcVhVR+XhnFRNati+DAggiCXuVgCHrJiJ8MswuVpLu3jz3DpacaCIso4PPJucVjtjreThw1Ni
 5wIrOloED+VqEo99ZpFmff/IqP1SpsFEwFLcxZuHqMSohntM0affdmntAsXx/47nUEnmgJob5i
 XqqALqvfdlV7hcnAO5Weep0W
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 23:54:26 -0800
IronPort-SDR: NkRVyy26a+WRocuzm+lTwQRNKob8QyoEDu5YOr2XTw8av+tKN/URg/de/fNUwaQor/6+FeH+zv
 ohga1HTBylmv/+kIFai7cYsFLtu9UnBdbmAF+2KUltyVb4FsyAIg4OQuATU+0OVaf+p9Djer2t
 22US+0oy2kDLylNWLVkGTP1x1eGr+MIF8yf61MV++sRVHqGOeHMZF03DPBcRHarAKtVq18Y36X
 52SJNopliT/Ocs1zAsN4+L9N6QN9ppVkhe9lWIGF30qzPgizFjtR+2cbbrXpZObAixqOQxOsfQ
 ltw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 00:20:38 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JVbks37vnz1VSm2
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jan 2022 00:20:37 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641543636; x=1644135637; bh=Gd8AouSaHaZjs1ZBpqaempbjaVQxK1sdDJF
        TXIOI150=; b=t1R1AmXL4ueFFrItSVlALSob6hGwsfzC6NCPUqAW1Uacn1yy/+r
        2001ZKcrgxWpgLdGfj3H1vTtrT4OxTbKWPUWTqeKb3RqAYYgcI217DMNv3ZHJGct
        6rK4JE/z8xEPqkg37uuKn/knu251NX1dwQb2As3CSaRoF7zC8JRAto0H6xsgd4iA
        EHUXz1KyTRyZFjcVJIzv1nheyiH2bfeEZoQnQm9dZvAHw0wFH6UNjFOnMglsWX2w
        e1e1chTVM2YkI6QLWtbkssyieRhl2iI3Aa9TnpVP1ngXmUq0tE0V7koDNezNzft3
        IOZDQoq8al/8cgFlbWXDk8/lof+mKJNfskg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d3iLr8_CrLWO for <linux-btrfs@vger.kernel.org>;
        Fri,  7 Jan 2022 00:20:36 -0800 (PST)
Received: from [10.225.163.44] (unknown [10.225.163.44])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JVbkr20d8z1VSkV;
        Fri,  7 Jan 2022 00:20:36 -0800 (PST)
Message-ID: <1617e7dc-57e7-0c68-a8dd-1462ed246157@opensource.wdc.com>
Date:   Fri, 7 Jan 2022 17:20:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] btrfs: refactor scrub_raid56_parity()
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220107070951.48246-1-wqu@suse.com>
 <20220107070951.48246-2-wqu@suse.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220107070951.48246-2-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/7/22 16:09, Qu Wenruo wrote:
> Currently scrub_raid56_parity() has a large double loop, handling the
> following things at the same time:
> 
> - Iterate each data stripe
> - Iterate each extent item in one data stripe
> 
> Refactor this mess by:
> 
> - Introduce a new helper to handle data stripe iteration
>   The new helper is scrub_raid56_data_stripe_for_parity(), which
>   only has one while() loop handling the extent items inside the
>   data stripe.
> 
>   The code is still mostly the same as the old code.
> 
> - Call cond_resched() for each extent
>   Previously we only call cond_resched() under a complex if () check.
>   I see no special reason to do that, and for other scrub functions,
>   like scrub_simple_mirror() we're already doing the same cond_resched()
>   after scrubbing one extent.
> 
> - Add extra comments
>   To improve the readability
> 
> Please note that, this patch is only to address the double loop, there
> are incoming patches to do extra cleanup.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 347 +++++++++++++++++++++++------------------------
>  1 file changed, 166 insertions(+), 181 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 9c6954d7f604..572852416b29 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3019,6 +3019,166 @@ static bool does_range_cross_boundary(u64 extent_start, u64 extent_len,
>  		extent_start + extent_len > boundary_start + boudary_len);
>  }
>  
> +static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
> +					       struct scrub_parity *sparity,
> +					       struct map_lookup *map,
> +					       struct btrfs_device *sdev,
> +					       struct btrfs_path *path,
> +					       u64 logical)
> +{
> +	struct btrfs_fs_info *fs_info = sctx->fs_info;
> +	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, logical);
> +	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, logical);
> +	struct btrfs_key key;
> +	int ret;
> +
> +	ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);
> +
> +	/* Path should not be populated */
> +	ASSERT(!path->nodes[0]);
> +
> +	if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
> +		key.type = BTRFS_METADATA_ITEM_KEY;
> +	else
> +		key.type = BTRFS_EXTENT_ITEM_KEY;
> +	key.objectid = logical;
> +	key.offset = (u64)-1;
> +
> +	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret > 0) {
> +		ret = btrfs_previous_extent_item(extent_root, path, 0);
> +		if (ret < 0)
> +			return ret;
> +		if (ret > 0) {
> +			btrfs_release_path(path);
> +			ret = btrfs_search_slot(NULL, extent_root, &key, path,
> +						0, 0);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	while (1) {
> +		struct btrfs_io_context *bioc = NULL;
> +		struct btrfs_device *extent_dev;
> +		struct btrfs_extent_item *ei;
> +		struct extent_buffer *l;
> +		int slot;
> +		u64 mapped_length;
> +		u64 extent_size;
> +		u64 extent_flags;
> +		u64 extent_gen;
> +		u64 extent_start;
> +		u64 extent_physical;
> +		u64 extent_mirror_num;
> +
> +		l = path->nodes[0];
> +		slot = path->slots[0];
> +		if (slot >= btrfs_header_nritems(l)) {
> +			ret = btrfs_next_leaf(extent_root, path);
> +			if (ret == 0)
> +				continue;
> +
> +			/* No more extent items or error, exit */
> +			break;
> +		}
> +		btrfs_item_key_to_cpu(l, &key, slot);
> +
> +		if (key.type != BTRFS_EXTENT_ITEM_KEY &&
> +		    key.type != BTRFS_METADATA_ITEM_KEY)
> +			goto next;
> +
> +		if (key.type == BTRFS_METADATA_ITEM_KEY)
> +			extent_size = fs_info->nodesize;
> +		else
> +			extent_size = key.offset;
> +
> +		if (key.objectid + extent_size <= logical)
> +			goto next;
> +
> +		/* Beyond this data stripe */
> +		if (key.objectid >= logical + map->stripe_len)
> +			break;
> +
> +		ei = btrfs_item_ptr(l, slot, struct btrfs_extent_item);
> +		extent_flags = btrfs_extent_flags(l, ei);
> +		extent_gen = btrfs_extent_generation(l, ei);
> +
> +		if ((extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) &&
> +		    (key.objectid < logical || key.objectid + extent_size >
> +		     logical + map->stripe_len)) {
> +			btrfs_err(fs_info,
> +				  "scrub: tree block %llu spanning stripes, ignored. logical=%llu",
> +				  key.objectid, logical);
> +			spin_lock(&sctx->stat_lock);
> +			sctx->stat.uncorrectable_errors++;
> +			spin_unlock(&sctx->stat_lock);
> +			goto next;
> +		}
> +
> +		extent_start = key.objectid;
> +		ASSERT(extent_size <= U32_MAX);
> +
> +		/* Truncate the range inside the data stripe */
> +		if (extent_start < logical) {
> +			extent_size -= logical - extent_start;
> +			extent_start = logical;
> +		}
> +		if (extent_start + extent_size > logical + map->stripe_len)
> +			extent_size = logical + map->stripe_len - extent_start;
> +
> +		scrub_parity_mark_sectors_data(sparity, extent_start, extent_size);
> +
> +		mapped_length = extent_size;
> +		ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, extent_start,
> +				      &mapped_length, &bioc, 0);
> +		if (!ret) {
> +			if (!bioc || mapped_length < extent_size)
> +				ret = -EIO;
> +		}

The double "if" looks a little weird... You can simplify this:

		if ((!ret) && (!bioc || mapped_length < extent_size))
			ret = -EIO;

> +		if (ret) {
> +			btrfs_put_bioc(bioc);
> +			scrub_parity_mark_sectors_error(sparity, extent_start,
> +							extent_size);
> +			break;
> +		}
> +		extent_physical = bioc->stripes[0].physical;
> +		extent_mirror_num = bioc->mirror_num;
> +		extent_dev = bioc->stripes[0].dev;
> +		btrfs_put_bioc(bioc);
> +
> +		ret = btrfs_lookup_csums_range(csum_root, extent_start,
> +					       extent_start + extent_size - 1,
> +					       &sctx->csum_list, 1);
> +		if (ret) {
> +			scrub_parity_mark_sectors_error(sparity, extent_start,
> +							extent_size);
> +			break;
> +		}
> +
> +		ret = scrub_extent_for_parity(sparity, extent_start,
> +					      extent_size, extent_physical,
> +					      extent_dev, extent_flags,
> +					      extent_gen, extent_mirror_num);
> +		scrub_free_csums(sctx);
> +
> +		if (ret) {
> +			scrub_parity_mark_sectors_error(sparity, extent_start,
> +							extent_size);
> +			break;
> +		}
> +

It would be nice to have the entire code above factored in one or more
functions to make reading the loop easier.

> +		cond_resched();
> +next:
> +		path->slots[0]++;
> +	}
> +	btrfs_release_path(path);
> +	return ret;
> +}
> +
>  static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
>  						  struct map_lookup *map,
>  						  struct btrfs_device *sdev,
> @@ -3026,28 +3186,12 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
>  						  u64 logic_end)
>  {
>  	struct btrfs_fs_info *fs_info = sctx->fs_info;
> -	struct btrfs_root *root = btrfs_extent_root(fs_info, logic_start);
> -	struct btrfs_root *csum_root;
> -	struct btrfs_extent_item *extent;
> -	struct btrfs_io_context *bioc = NULL;
>  	struct btrfs_path *path;
> -	u64 flags;
> +	u64 cur_logical;
>  	int ret;
> -	int slot;
> -	struct extent_buffer *l;
> -	struct btrfs_key key;
> -	u64 generation;
> -	u64 extent_logical;
> -	u64 extent_physical;
> -	/* Check the comment in scrub_stripe() for why u32 is enough here */
> -	u32 extent_len;
> -	u64 mapped_length;
> -	struct btrfs_device *extent_dev;
>  	struct scrub_parity *sparity;
>  	int nsectors;
>  	int bitmap_len;
> -	int extent_mirror_num;
> -	int stop_loop = 0;
>  
>  	path = btrfs_alloc_path();
>  	if (!path) {
> @@ -3085,173 +3229,14 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
>  	sparity->ebitmap = (void *)sparity->bitmap + bitmap_len;
>  
>  	ret = 0;
> -	while (logic_start < logic_end) {
> -		if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
> -			key.type = BTRFS_METADATA_ITEM_KEY;
> -		else
> -			key.type = BTRFS_EXTENT_ITEM_KEY;
> -		key.objectid = logic_start;
> -		key.offset = (u64)-1;
> -
> -		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +	for (cur_logical = logic_start; cur_logical < logic_end;
> +	     cur_logical += map->stripe_len) {
> +		ret = scrub_raid56_data_stripe_for_parity(sctx, sparity, map,
> +							  sdev, path, cur_logical);
>  		if (ret < 0)
> -			goto out;
> -
> -		if (ret > 0) {
> -			ret = btrfs_previous_extent_item(root, path, 0);
> -			if (ret < 0)
> -				goto out;
> -			if (ret > 0) {
> -				btrfs_release_path(path);
> -				ret = btrfs_search_slot(NULL, root, &key,
> -							path, 0, 0);
> -				if (ret < 0)
> -					goto out;
> -			}
> -		}
> -
> -		stop_loop = 0;
> -		while (1) {
> -			u64 bytes;
> -
> -			l = path->nodes[0];
> -			slot = path->slots[0];
> -			if (slot >= btrfs_header_nritems(l)) {
> -				ret = btrfs_next_leaf(root, path);
> -				if (ret == 0)
> -					continue;
> -				if (ret < 0)
> -					goto out;
> -
> -				stop_loop = 1;
> -				break;
> -			}
> -			btrfs_item_key_to_cpu(l, &key, slot);
> -
> -			if (key.type != BTRFS_EXTENT_ITEM_KEY &&
> -			    key.type != BTRFS_METADATA_ITEM_KEY)
> -				goto next;
> -
> -			if (key.type == BTRFS_METADATA_ITEM_KEY)
> -				bytes = fs_info->nodesize;
> -			else
> -				bytes = key.offset;
> -
> -			if (key.objectid + bytes <= logic_start)
> -				goto next;
> -
> -			if (key.objectid >= logic_end) {
> -				stop_loop = 1;
> -				break;
> -			}
> -
> -			while (key.objectid >= logic_start + map->stripe_len)
> -				logic_start += map->stripe_len;
> -
> -			extent = btrfs_item_ptr(l, slot,
> -						struct btrfs_extent_item);
> -			flags = btrfs_extent_flags(l, extent);
> -			generation = btrfs_extent_generation(l, extent);
> -
> -			if ((flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) &&
> -			    (key.objectid < logic_start ||
> -			     key.objectid + bytes >
> -			     logic_start + map->stripe_len)) {
> -				btrfs_err(fs_info,
> -					  "scrub: tree block %llu spanning stripes, ignored. logical=%llu",
> -					  key.objectid, logic_start);
> -				spin_lock(&sctx->stat_lock);
> -				sctx->stat.uncorrectable_errors++;
> -				spin_unlock(&sctx->stat_lock);
> -				goto next;
> -			}
> -again:
> -			extent_logical = key.objectid;
> -			ASSERT(bytes <= U32_MAX);
> -			extent_len = bytes;
> -
> -			if (extent_logical < logic_start) {
> -				extent_len -= logic_start - extent_logical;
> -				extent_logical = logic_start;
> -			}
> -
> -			if (extent_logical + extent_len >
> -			    logic_start + map->stripe_len)
> -				extent_len = logic_start + map->stripe_len -
> -					     extent_logical;
> -
> -			scrub_parity_mark_sectors_data(sparity, extent_logical,
> -						       extent_len);
> -
> -			mapped_length = extent_len;
> -			bioc = NULL;
> -			ret = btrfs_map_block(fs_info, BTRFS_MAP_READ,
> -					extent_logical, &mapped_length, &bioc,
> -					0);
> -			if (!ret) {
> -				if (!bioc || mapped_length < extent_len)
> -					ret = -EIO;
> -			}
> -			if (ret) {
> -				btrfs_put_bioc(bioc);
> -				goto out;
> -			}
> -			extent_physical = bioc->stripes[0].physical;
> -			extent_mirror_num = bioc->mirror_num;
> -			extent_dev = bioc->stripes[0].dev;
> -			btrfs_put_bioc(bioc);
> -
> -			csum_root = btrfs_csum_root(fs_info, extent_logical);
> -			ret = btrfs_lookup_csums_range(csum_root,
> -						extent_logical,
> -						extent_logical + extent_len - 1,
> -						&sctx->csum_list, 1);
> -			if (ret)
> -				goto out;
> -
> -			ret = scrub_extent_for_parity(sparity, extent_logical,
> -						      extent_len,
> -						      extent_physical,
> -						      extent_dev, flags,
> -						      generation,
> -						      extent_mirror_num);
> -
> -			scrub_free_csums(sctx);
> -
> -			if (ret)
> -				goto out;
> -
> -			if (extent_logical + extent_len <
> -			    key.objectid + bytes) {
> -				logic_start += map->stripe_len;
> -
> -				if (logic_start >= logic_end) {
> -					stop_loop = 1;
> -					break;
> -				}
> -
> -				if (logic_start < key.objectid + bytes) {
> -					cond_resched();
> -					goto again;
> -				}
> -			}
> -next:
> -			path->slots[0]++;
> -		}
> -
> -		btrfs_release_path(path);
> -
> -		if (stop_loop)
>  			break;
> -
> -		logic_start += map->stripe_len;
> -	}
> -out:
> -	if (ret < 0) {
> -		ASSERT(logic_end - logic_start <= U32_MAX);
> -		scrub_parity_mark_sectors_error(sparity, logic_start,
> -						logic_end - logic_start);
>  	}
> +
>  	scrub_parity_put(sparity);
>  	scrub_submit(sctx);
>  	mutex_lock(&sctx->wr_lock);


-- 
Damien Le Moal
Western Digital Research
