Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686BF485C6C
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 00:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbiAEXsY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 18:48:24 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36349 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245498AbiAEXsU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 18:48:20 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B5C15C013B;
        Wed,  5 Jan 2022 18:48:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 05 Jan 2022 18:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=28iXSOFrmo0xP1EhuIShpivFWXi
        iQ0a3a6arLLr+b+w=; b=dNMktG7tL2+EKqZBWZR2hAJEWuLL3+ViZyrwuLrObMz
        W9tK58f1h6mzwRkG1VD21YgwQCSkKtG+FDOo+1Ini4UJ6A800Q9z88T5+9/7BH4w
        eSreM0iz8vg7dix2BtCEfmq01r64MUOCMuY5qido07xBallZRan2W2MQfNnAtj/s
        sr3Ky/ZLO47JlI6e2ur+ANc5lbJNfhhsiwSxhDYKWiD4GEymnEVNtIuIEznnzWI3
        nBzfqwTng8AyLJf32WRanoZceW82q+MaZZsJhcCUFp2eWNiaW6h04O0tBOStGsEk
        4wC0Dki8IEcPZCj3NPmM11qxSjBCjBtUh6W6ptgGbyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=28iXSO
        Frmo0xP1EhuIShpivFWXiiQ0a3a6arLLr+b+w=; b=IjJwK1/7RjfszHhgM/v9gb
        quziWIzaTHccuwIGBZVM5eXNpx91BKw2v6zHpvpoe4dGvztlMmVq6nrR+PcZaEaV
        Z+0jDmB7NV8KIv/QNPjgmJ1bMLKGl1+aZZr/iXQ6k2Uw4vtt2TFTKvutaaqITU3F
        r56xFWYaTkr+ab9CYkZ+5sBWv3RiXvg8ReYczjiD3dvKobgYms4x8ZqQH9s5JxTB
        aFRbDILXO7raVAxp4jeYJFkVDR6q1+q7jMEQNX+Z+H5W/fmfh7EteBmQd1ga9bcp
        nvxW7XUbrZ3MF/Ac6FpgfF8ndfpEJYzh5fLh8XpK2OIVKT8JVJOVK9cpyFZwUygQ
        ==
X-ME-Sender: <xms:Qi7WYT1y1FDvq6fBxh6-p5aZdR-sU8RyhYiog5_1yw6CEa-Z4FY9ZQ>
    <xme:Qi7WYSGOSccyiMGrC50z21-TmfadaKKhxmdvezXNgGFer6SY5NhJHeF4zhSYKbDrh
    _WAAix2biuPdo6jk48>
X-ME-Received: <xmr:Qi7WYT6Cz4s0VEVkdMFvgZsvbJ_iEc1CtGojFyu7BtLYQo1FKIHTaJSVyfaNxH0l9mRDxD554Lfgqyyd7dUdZvGPu_sEgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    duveelkeeiteelveeiuefhudehtdeigfehkeeffeegledvueevgefgudeuveefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:Qi7WYY2UaRBTmzTJK9lbSPW36HSsRBYzXS9Qim-WPw2ASo5McwlKvQ>
    <xmx:Qi7WYWGyqkzH5x2Vll1LtRNrnW2KsHrPHpbaVX2rpVczmLtEyKIaoA>
    <xmx:Qi7WYZ-1QxEHv0sWH4R1RfnHZTKsKaeiPxqFh9tQDoL34LjxvaZTtA>
    <xmx:Qy7WYb7g5n1xWyWG_dQn77Rgp-bmiOA-YUxs9CO6FL1L6P-gmyRVAw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 18:48:18 -0500 (EST)
Date:   Wed, 5 Jan 2022 15:48:16 -0800
From:   Boris Burkov <boris@bur.io>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 4/6] btrfs: add allocation_hint mode
Message-ID: <YdYuQIFF/yXa4z43@zen>
References: <cover.1639766364.git.kreijack@inwind.it>
 <c9f492a7ff1a0e4f0addc6cd451848404f0438db.1639766364.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9f492a7ff1a0e4f0addc6cd451848404f0438db.1639766364.git.kreijack@inwind.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 17, 2021 at 07:47:20PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> The chunk allocation policy is modified as follow.
> 
> Each disk may have one of the following tags:
> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> - BTRFS_DEV_ALLOCATION_DATA_ONLY
> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)
> 
> During a *mixed data/metadata* chunk allocation, BTRFS works as
> usual.
> 
> During a *data* chunk allocation, the space are searched first in
> BTRFS_DEV_ALLOCATION_DATA_ONLY and BTRFS_DEV_ALLOCATION_PREFERRED_DATA
> tagged disks. If no space is found or the space found is not enough (eg.
> in raid5, only two disks are available), then also the disks tagged
> BTRFS_DEV_ALLOCATION_PREFERRED_METADATA are evaluated. If even in this
> case this the space is not sufficient, -ENOSPC is raised.
> A disk tagged with BTRFS_DEV_ALLOCATION_METADATA_ONLY is never considered
> for a data BG allocation.
> 
> During a *metadata* chunk allocation, the space are searched first in
> BTRFS_DEV_ALLOCATION_METADATA_ONLY and BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
> tagged disks. If no space is found or the space found is not enough (eg.
> in raid5, only two disks are available), then also the disks tagged
> BTRFS_DEV_ALLOCATION_PREFERRED_DATA are considered. If even in this
> case this the space is not sufficient, -ENOSPC is raised.
> A disk tagged with BTRFS_DEV_ALLOCATION_DATA_ONLY is never considered
> for a metadata BG allocation.
> 
> By default the disks are tagged as BTRFS_DEV_ALLOCATION_PREFERRED_DATA,
> so the default behavior happens. If the user prefer to store the
> metadata in the faster disks (e.g. the SSD), he can tag these with
> BTRFS_DEV_ALLOCATION_PREFERRED_DATA: in this case the data BG go in the

is this a typo? I would expect they should mark the disk with
METADATA_PREFERRED to get metadata to go there. Also, that value is
already the default, so setting it should be a no-op.

> BTRFS_DEV_ALLOCATION_PREFERRED_DATA disks and the metadata BG in the
> others, until there is enough space. Only if one disks set is filled,

I think this may be another typo: "is not enough space" seems to make
more sense.

> the other is occupied.
> 
> WARNING: if the user tags a disk with BTRFS_DEV_ALLOCATION_DATA_ONLY,
> this means that this disk will never be used for allocating metadata
> increasing the likelihood of exhausting the metadata space.
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  fs/btrfs/volumes.c | 94 +++++++++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/volumes.h |  1 +
>  2 files changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 806b599c6a46..beee7d1ae79d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -184,6 +184,16 @@ enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags
>  	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
>  }
>  
> +#define BTRFS_DEV_ALLOCATION_HINT_COUNT (1ULL << \
> +		BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT)
> +

This logic with -1..2 and then negating the hint is quite clever. I
would add a comment to make it obvious what's happening, or a helper
static function that sets a hint given the device_info, the ctl, and the
device. You could also consider numbering from to 3 and flipping the
order by doing (count - hint), which keeps things positive, at least.

I think your algorithm is fine, though.

> +static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_HINT_COUNT] = {
> +	[BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY] = -1,
> +	[BTRFS_DEV_ALLOCATION_HINT_PREFERRED_DATA] = 0,
> +	[BTRFS_DEV_ALLOCATION_HINT_PREFERRED_METADATA] = 1,
> +	[BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY] = 2,
> +};
> +
>  const char *btrfs_bg_type_to_raid_name(u64 flags)
>  {
>  	const int index = btrfs_bg_flags_to_raid_index(flags);
> @@ -5037,13 +5047,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
>  }
>  
>  /*
> - * sort the devices in descending order by max_avail, total_avail
> + * sort the devices in descending order by alloc_hint,
> + * max_avail, total_avail
>   */
>  static int btrfs_cmp_device_info(const void *a, const void *b)
>  {
>  	const struct btrfs_device_info *di_a = a;
>  	const struct btrfs_device_info *di_b = b;
>  
> +	if (di_a->alloc_hint > di_b->alloc_hint)
> +		return -1;
> +	if (di_a->alloc_hint < di_b->alloc_hint)
> +		return 1;
>  	if (di_a->max_avail > di_b->max_avail)
>  		return -1;
>  	if (di_a->max_avail < di_b->max_avail)
> @@ -5206,6 +5221,8 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>  	int ndevs = 0;
>  	u64 max_avail;
>  	u64 dev_offset;
> +	int hint;
> +	int i;
>  
>  	/*
>  	 * in the first pass through the devices list, we gather information
> @@ -5258,16 +5275,91 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>  		devices_info[ndevs].max_avail = max_avail;
>  		devices_info[ndevs].total_avail = total_avail;
>  		devices_info[ndevs].dev = device;
> +
> +		if ((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
> +		     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) {
> +			/*
> +			 * if mixed bg set all the alloc_hint
> +			 * fields to the same value, so the sorting
> +			 * is not affected
> +			 */
> +			devices_info[ndevs].alloc_hint = 0;
> +		} else if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
> +			hint = device->type & BTRFS_DEV_ALLOCATION_HINT_MASK;
> +
> +			/*
> +			 * skip BTRFS_DEV_METADATA_ONLY disks
> +			 */
> +			if (hint == BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY)
> +				continue;
> +			/*
> +			 * if a data chunk must be allocated,
> +			 * sort also by hint (data disk
> +			 * higher priority)
> +			 */
> +			devices_info[ndevs].alloc_hint = -alloc_hint_map[hint];
> +		} else { /* BTRFS_BLOCK_GROUP_METADATA */
> +			hint = device->type & BTRFS_DEV_ALLOCATION_HINT_MASK;
> +
> +			/*
> +			 * skip BTRFS_DEV_DATA_ONLY disks
> +			 */
> +			if (hint == BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY)
> +				continue;
> +			/*
> +			 * if a data chunk must be allocated,

typo: metadata chunk

> +			 * sort also by hint (metadata hint
> +			 * higher priority)
> +			 */
> +			devices_info[ndevs].alloc_hint = alloc_hint_map[hint];
> +		}
> +
>  		++ndevs;
>  	}
>  	ctl->ndevs = ndevs;
>  
> +	/*
> +	 * no devices available
> +	 */
> +	if (!ndevs)
> +		return 0;
> +

What doesn't handle 0 devices properly? As far as I can tell, sort will
be fine, and we'll skip the while and for loops.

>  	/*
>  	 * now sort the devices by hole size / available space

modify the comment to include that this sort cares about hint.

>  	 */
>  	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>  	     btrfs_cmp_device_info, NULL);
>  

"restarting" the function here feels off to me. I'm wondering if you
could refactor your logic to make it clearer and avoid the ugly logic
reset mid function. You are going from:

- filter/prepare devices
- sort by avail

to

- filter/prepare devices
- sort by hint/avail
- take all by hint until we take enough
- sort by avail

that second step of "take by hint; sort by avail" could possibly be a
new filter function run after gather_device_info and before
decide_stripe_size. You could name it something like
"reduce_devices_by_hint" or "take_devices_by_hint".

> +	/*
> +	 * select the minimum set of disks grouped by hint that
> +	 * can host the chunk
> +	 */
> +	ndevs = 0;
> +	while (ndevs < ctl->ndevs) {
> +		hint = devices_info[ndevs++].alloc_hint;
> +		while (ndevs < ctl->ndevs &&
> +		       devices_info[ndevs].alloc_hint == hint)
> +				ndevs++;
> +		if (ndevs >= ctl->devs_min)
> +			break;
> +	}
> +
> +	BUG_ON(ndevs > ctl->ndevs);

I think this BUG_ON is overly paranoid. Is it defensive against a future
logic error with the nested while loops? (which I agree one should be
careful with...)

> +	ctl->ndevs = ndevs;
> +
> +	/*
> +	 * the next layers require the devices_info ordered by
> +	 * max_avail. If we are returing two (or more) different

typo: returning

> +	 * group of alloc_hint, this is not always true. So sort
> +	 * these gain.

typo: again

> +	 */
> +
> +	for (i = 0 ; i < ndevs ; i++)
> +		devices_info[i].alloc_hint = 0;
> +
> +	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +	     btrfs_cmp_device_info, NULL);
> +
>  	return 0;
>  }
>  
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 5097c0c12a8e..61c0cba045e9 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -406,6 +406,7 @@ struct btrfs_device_info {
>  	u64 dev_offset;
>  	u64 max_avail;
>  	u64 total_avail;
> +	int alloc_hint;
>  };
>  
>  struct btrfs_raid_attr {
> -- 
> 2.34.1
> 
