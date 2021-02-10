Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460F4316AD7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 17:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhBJQNh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 11:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhBJQNf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 11:13:35 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485AEC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 08:12:54 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d3so1865068qtr.10
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K9tnxtZwCqsz9oGln619YQ5Y0TWJycwZoM23htX18Nc=;
        b=D7nq4iI7mA0Xg72dpda0qcNFEGFrBvAwhesDlluCG4luIRTNBIq7cmcs1QvpT6mh+G
         321cqP0aGw5004LwFh6wrMjAnQMmaC9tQa4Zl5DxPOAlGdk5loOA/ZfkatpW1U0lZoYB
         r+dJRJxfInxO3x+TgOCHt7rpWcFUkvqB57unhsbcl/k8VcGVADOViLKjs5IHO7BiAqee
         nh76qRWiUAsrjL4W6HAmdwtWY6L6cTtJiovWkX7tv+vWLILJnLEVZRGCN0SR4HXMcNd0
         0ke9b+CekcXuZkGRbLJ+cLP3m4JM99DeGA6C1s++xPDFU0kR2DlA277Qg5iycWCItrU5
         CCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K9tnxtZwCqsz9oGln619YQ5Y0TWJycwZoM23htX18Nc=;
        b=MusJ64rUrEfnfPak0YI+yxbF3FDprERt2HJ0vwaSkavh47QE+/iD7PlLIa9L9EjiNd
         XO+Gdx8LZznccSu+xd2UFjs7nHLKSYcqtiNv9qdZyoS2RNTSQtxLI00c7MXDc0/WjG9V
         pjACisCgtHs+DpXa7QgwVhQ2wn8tnfF7ElYAf/QqdaUxvc4+42olkupov50WUYXOGRob
         +E6q5P7vh+6RhIabYjkYaN25iZh14rVz8ucYed1Os5OKE50oGUzq50IVlfMFZzDsuPn5
         NZcL4zG9oDB0Y+spdT7kbF6jfomp38Yzq8WfeWo41gnJw1lI16R8lwbWL2qt/IsjvPEd
         r25Q==
X-Gm-Message-State: AOAM533fHYqTdEHhBXezcGNxSyDtV1Q6XfWxFoisrMHkTpHSrSJ8KOvx
        jl32Vqz0zxJnOP6+yJh8F9yczA==
X-Google-Smtp-Source: ABdhPJzvjRqbutD/F2QbT1xfmTJyE4AuXeTvP7tFZ6/ZAYAlI+rHuHqTFkBHuBvgHZDhHgJrbQnU/w==
X-Received: by 2002:aed:3443:: with SMTP id w61mr1069716qtd.89.1612973573378;
        Wed, 10 Feb 2021 08:12:53 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c126sm1724519qkg.16.2021.02.10.08.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 08:12:52 -0800 (PST)
Subject: Re: [PATCH 5/5] btrfs: add allocator_hint mode
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20210201212820.64381-1-kreijack@libero.it>
 <20210201212820.64381-6-kreijack@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e1610b05-433c-cd17-759a-743ed3abdf7d@toxicpanda.com>
Date:   Wed, 10 Feb 2021 11:12:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201212820.64381-6-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/1/21 4:28 PM, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> When this mode is enabled, the chunk allocation policy is modified as follow.
> 
> Each disk may have a different tag:
> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> - BTRFS_DEV_ALLOCATION_DATA_ONLY
> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)
> 
> Where:
> - ALLOCATION_PREFERRED_X means that it is preferred to use this disk for the
> X chunk type (the other type may be allowed when the space is low)
> - ALLOCATION_X_ONLY means that it is used *only* for the X chunk type. This
> means also that it is a preferred choice.
> 
> Each time the allocator allocates a chunk of type X , first it takes the disks
> tagged as ALLOCATION_X_ONLY or ALLOCATION_PREFERRED_X; if the space is not
> enough, it uses also the disks tagged as ALLOCATION_METADATA_ONLY; if the space
> is not enough, it uses also the other disks, with the exception of the one
> marked as ALLOCATION_PREFERRED_Y, where Y the other type of chunk (i.e. not X).
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>   fs/btrfs/volumes.c | 81 +++++++++++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/volumes.h |  1 +
>   2 files changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 68b346c5465d..57ee3e2fdac0 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4806,13 +4806,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
>   }
>   
>   /*
> - * sort the devices in descending order by max_avail, total_avail
> + * sort the devices in descending order by alloc_hint,
> + * max_avail, total_avail
>    */
>   static int btrfs_cmp_device_info(const void *a, const void *b)
>   {
>   	const struct btrfs_device_info *di_a = a;
>   	const struct btrfs_device_info *di_b = b;
>   
> +	if (di_a->alloc_hint > di_b->alloc_hint)
> +		return -1;
> +	if (di_a->alloc_hint < di_b->alloc_hint)
> +		return 1;
>   	if (di_a->max_avail > di_b->max_avail)
>   		return -1;
>   	if (di_a->max_avail < di_b->max_avail)
> @@ -4939,6 +4944,15 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>   	int ndevs = 0;
>   	u64 max_avail;
>   	u64 dev_offset;
> +	int hint;
> +
> +	static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_MASK_COUNT] = {
> +		[BTRFS_DEV_ALLOCATION_DATA_ONLY] = -1,
> +		[BTRFS_DEV_ALLOCATION_PREFERRED_DATA] = 0,
> +		[BTRFS_DEV_ALLOCATION_METADATA_ONLY] = 1,
> +		[BTRFS_DEV_ALLOCATION_PREFERRED_METADATA] = 2
> +		/* the other values are set to 0 */
> +	};

This can be made global, up with the btrfs_raid_array definitions.

>   
>   	/*
>   	 * in the first pass through the devices list, we gather information
> @@ -4991,16 +5005,81 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>   		devices_info[ndevs].max_avail = max_avail;
>   		devices_info[ndevs].total_avail = total_avail;
>   		devices_info[ndevs].dev = device;
> +
> +		if (((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
> +		     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) ||
> +		    info->allocation_hint_mode ==
> +		     BTRFS_ALLOCATION_HINT_DISABLED) {
> +			/*
> +			 * if mixed bg or the allocator hint is
> +			 * disable, set all the alloc_hint
> +			 * fields to the same value, so the sorting
> +			 * is not affected
> +			 */
> +			devices_info[ndevs].alloc_hint = 0;
> +		} else if(ctl->type & BTRFS_BLOCK_GROUP_DATA) {
> +			hint = device->type & BTRFS_DEV_ALLOCATION_MASK;
> +
> +			/*
> +			 * skip BTRFS_DEV_METADATA_ONLY disks
> +			 */
> +			if (hint == BTRFS_DEV_ALLOCATION_METADATA_ONLY)
> +				continue;
> +			/*
> +			 * if a data chunk must be allocated,
> +			 * sort also by hint (data disk
> +			 * higher priority)
> +			 */
> +			devices_info[ndevs].alloc_hint = -alloc_hint_map[hint];
> +		} else { /* BTRFS_BLOCK_GROUP_METADATA */
> +			hint = device->type & BTRFS_DEV_ALLOCATION_MASK;
> +
> +			/*
> +			 * skip BTRFS_DEV_DATA_ONLY disks
> +			 */
> +			if (hint == BTRFS_DEV_ALLOCATION_DATA_ONLY)
> +				continue;
> +			/*
> +			 * if a data chunk must be allocated,
> +			 * sort also by hint (metadata hint
> +			 * higher priority)
> +			 */
> +			devices_info[ndevs].alloc_hint = alloc_hint_map[hint];
> +		}
> +
>   		++ndevs;
>   	}
>   	ctl->ndevs = ndevs;
>   
> +	/*
> +	 * no devices available
> +	 */
> +	if (!ndevs)
> +		return 0;
> +
>   	/*
>   	 * now sort the devices by hole size / available space
>   	 */
>   	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>   	     btrfs_cmp_device_info, NULL);
>   
> +	/*
> +	 * select the minimum set of disks grouped by hint that
> +	 * can host the chunk
> +	 */
> +	ndevs = 0;
> +	while (ndevs < ctl->ndevs) {
> +		hint = devices_info[ndevs++].alloc_hint;
> +		while (devices_info[ndevs].alloc_hint == hint &&
> +		       ndevs < ctl->ndevs)
> +				ndevs++;
> +		if (ndevs >= ctl->devs_min)
> +			break;
> +	}

Can we just adjust btrfs_cmp_device_info to take the hint info into account? 
Thanks,

Josef
