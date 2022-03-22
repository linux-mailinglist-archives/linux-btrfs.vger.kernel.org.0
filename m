Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5464E46E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 20:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiCVTta (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 15:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiCVTt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 15:49:29 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF50F633A
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 12:47:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id v2so15352235qtc.5
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 12:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A6nv8D7mSHFgMdtULBXvzhdc0d9lYKGl1Va2BMc+oSQ=;
        b=7MksQC9wbTeZjUicVVdytILvYiTu2M0NwwKzDqS3ly51hhq9Aseke+OE6a0kcKWfea
         vAz1p1p0dNo6RWTb4FsjbNjI//PAkA+yNoXajoqNgclvbZuVzUy6w0He7CnnxHTInjPf
         2NDlcJHYJy3Kh9nUGn2q6Wci+9dYbmd7KfwOkmnRWNwlJU1dNdSaif6ww+/tdnruN3s7
         SSnrBeyC1OiIooWMVDIciDA4Nce2bNXM2chWzWlfp1b7pg+rocKKh1iHs3mYfF+LXVVb
         oE5cYE/BnKp9Uj7N4ldkHm9bE154atSUxYAxKbw2wt+x5G/llaIHR7y2nqeaaTnjdfTF
         QpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A6nv8D7mSHFgMdtULBXvzhdc0d9lYKGl1Va2BMc+oSQ=;
        b=gO5AYJSUKxiC/PjH4734WuZWHJ8pmvKPl9opo2wr8nuFD+kJvE9Vtodjssn8EdvILN
         1x4JdjAhfBn8Nf0xSg9MdR1U5zefdjk1PtYGX9yRWGrG2nD8G9QFNlwK9HW7qjyoyuNA
         1+ENIC6YdQrf7kQopKbKfrB4KOeKMwp0ZnC3Pw7ugs7RI5emM+pggKvuXeAx6D/fzk7R
         Pks2tx3WAuR0IPF2ejr8VwFUmmkFzdTWOv4KfwJ9xbPrOfL8gD17kwg/94sulXhEJAPs
         F1OUnbkks4SLon6NEtZP7Tbi5pe4yu4sGlrx0CuT/rT8QGJIFHK5WCcIBs/cuFRIk43b
         HaNA==
X-Gm-Message-State: AOAM5312zZ+wpWTX/sMi2bI6vKWv+wz/Ux1Sj1HHDksdii1Pvmp2zNmx
        k34chDBrXwAdXCHbG8DOgUeAVvuYUUeYQw==
X-Google-Smtp-Source: ABdhPJylyuTD0F8GaWzjrXCoVxRADu6F6ZTqosbfDXf6OG8B/DuqLxaqib07W/C3kAm6nOGnHkkxiQ==
X-Received: by 2002:a05:622a:24e:b0:2e2:139c:3f1b with SMTP id c14-20020a05622a024e00b002e2139c3f1bmr8795143qtx.209.1647978477732;
        Tue, 22 Mar 2022 12:47:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s19-20020a05622a179300b002e1ceeb21d0sm14441788qtk.97.2022.03.22.12.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 12:47:57 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:47:56 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 4/5] btrfs: add allocation_hint mode
Message-ID: <Yjon7DClcBkw2V9i@localhost.localdomain>
References: <cover.1646589622.git.kreijack@inwind.it>
 <2291ba747c6c9701952fa75140684535cfe4ab3e.1646589622.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2291ba747c6c9701952fa75140684535cfe4ab3e.1646589622.git.kreijack@inwind.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 06, 2022 at 07:14:42PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> The chunk allocation policy is modified as follow.
> 
> Each disk may have one of the following tags:
> - BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> - BTRFS_DEV_ALLOCATION_DATA_ONLY
> - BTRFS_DEV_ALLOCATION_DATA_PREFERRED (default)
> 
> During a *mixed data/metadata* chunk allocation, BTRFS works as
> usual.
> 
> During a *data* chunk allocation, the space are searched first in
> BTRFS_DEV_ALLOCATION_DATA_ONLY. If the space found is not enough (eg.
> in raid5, only two disks are available), then the disks tagged
> BTRFS_DEV_ALLOCATION_DATA_PREFERRED are considered. If the space is not
> enough again, the disks tagged BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
> are also considered. If even in this case the space is not
> sufficient, -ENOSPC is raised.
> A disk tagged with BTRFS_DEV_ALLOCATION_METADATA_ONLY is never considered
> for a data BG allocation.
> 
> During a *metadata* chunk allocation, the same algorithm applies swapping
> _DATA_ and _METADATA_.
> 
> By default the disks are tagged as BTRFS_DEV_ALLOCATION_DATA_PREFERRED,
> so BTRFS behaves as usual.
> 
> If the user prefers to store the metadata in the faster disks (e.g. SSD),
> he can tag these with BTRFS_DEV_ALLOCATION_METADATA_PREFERRED: in this
> case the metadata BG go in the BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
> disks and the data BG in the others ones. When a disks set is filled, the
> other is considered.
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  fs/btrfs/volumes.c | 113 +++++++++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/volumes.h |   1 +
>  2 files changed, 111 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d4ac90f5c949..7b37db9bb887 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -184,6 +184,27 @@ enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags
>  	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
>  }
>  
> +#define BTRFS_DEV_ALLOCATION_HINT_COUNT (1ULL << \
> +		BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT)
> +
> +/*
> + *	The order of BTRFS_DEV_ALLOCATION_HINT_* values are not
> + *	good, because BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED is 0
> + *	(for backward compatibility reason), and the other
> + *	values are greater (because the field is unsigned). So we
> + *	need a map that rearranges the order giving to _DATA_PREFERRED
> + *	an intermediate priority.
> + *	These values give to METADATA_ONLY the highest priority, and are
> + *	valid for metadata BG allocation. When a data
> + *	BG is allocated we negate these values to reverse the priority.
> + */
> +static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_HINT_COUNT] = {
> +	[BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY] = -1,
> +	[BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED] = 0,
> +	[BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED] = 1,
> +	[BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY] = 2,
> +};

This should be const int, not const char.  Also the formatting for the comment
is awkward, it's 1 space between the * and the word, so

/*
 * The order of ....
 *
 * These values give METADATA_ONLY the highest priority...
 */

Also the -1 thing is weird and unclear.  In fact I think it's problematic, I'll
explain below.

> +
>  const char *btrfs_bg_type_to_raid_name(u64 flags)
>  {
>  	const int index = btrfs_bg_flags_to_raid_index(flags);
> @@ -5030,13 +5051,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
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

This is making things awkward, instead I think we change this to sort_r, which
uses cmp(a, b, priv).  You pass in priv which is the type we want, DATA or
METADATA or whatever.  Then you can do

if (priv == data) {
	/* do the sorting so DATA_ONLY is on top, then DATA_PREFERRED, etc. */
} else {
	/* do the METADATA thing instead. */
}

>  	if (di_a->max_avail > di_b->max_avail)
>  		return -1;
>  	if (di_a->max_avail < di_b->max_avail)
> @@ -5199,6 +5225,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>  	int ndevs = 0;
>  	u64 max_avail;
>  	u64 dev_offset;
> +	int hint;
>  
>  	/*
>  	 * in the first pass through the devices list, we gather information
> @@ -5251,17 +5278,95 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
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
> +			 * if a metadata chunk must be allocated,
> +			 * sort also by hint (metadata hint
> +			 * higher priority)
> +			 */
> +			devices_info[ndevs].alloc_hint = alloc_hint_map[hint];
> +		}
> +

Shouldn't we be doing this before adding the device to devices_info?  That way
for _ONLY we just don't even add the disk to the devices_info.

>  		++ndevs;
>  	}
>  	ctl->ndevs = ndevs;
>  
> +	return 0;
> +}
> +
> +static void sort_and_reduce_device_info(struct alloc_chunk_ctl *ctl,
> +					struct btrfs_device_info *devices_info)
> +{
> +	int ndevs, hint, i;
> +
> +	ndevs = ctl->ndevs;
>  	/*
> -	 * now sort the devices by hole size / available space
> +	 * now sort the devices by hint / hole size / available space
>  	 */
>  	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>  	     btrfs_cmp_device_info, NULL);
>  
> -	return 0;
> +	/*
> +	 * select the minimum set of disks grouped by hint that
> +	 * can host the chunk
> +	 */
> +	ndevs = 0;
> +	while (ndevs < ctl->ndevs) {
> +		hint = devices_info[ndevs++].alloc_hint;
> +		while (ndevs < ctl->ndevs) {
> +			if (devices_info[ndevs].alloc_hint != hint)
> +				break;
> +			ndevs++;
> +		}
> +		if (ndevs >= ctl->devs_min)
> +			break;
> +	}
> +
> +	ctl->ndevs = ndevs;
> +
> +	/*
> +	 * the next layers require the devices_info ordered by
> +	 * max_avail. If we are returning two (or more) different
> +	 * group of alloc_hint, this is not always true. So sort
> +	 * these again.
> +	 */
> +
> +	for (i = 0 ; i < ndevs ; i++)
> +		devices_info[i].alloc_hint = 0;
> +
> +	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +	     btrfs_cmp_device_info, NULL);

With my sort_r suggestion I think we no longer need the second sort.  It'll get
you the devices you want in order of most preferred alloc hint, and with the
max_avail.  I'd double check with printk's, but you should be able to drop all
this.  Thanks,

Josef
