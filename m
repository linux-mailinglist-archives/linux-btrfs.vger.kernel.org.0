Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B620613DFBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgAPQOm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 11:14:42 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36179 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgAPQOm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 11:14:42 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so19627403qkc.3
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 08:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ib7KlwO5w2vjHaS8oeyUDHUbSwJunHfY/gYb/VCCmAI=;
        b=eP0ts1+a0uTSZHw/9RPHTpV0ocJ74LnnrJyZmoevwzFZ4DQn52sPJEmo/krTBXoI4R
         Q3xXKmZ4g4M5WL8b/2enybZscYBVD+qTT4l2crFfxbcOaSyk62a8Rx/JFV/FoWsMtXoO
         DXwq58uZwreC803p9Rxbg9nOUTKzDFOhUF/oM+PwrAgA4Y87ZpziqSZ8MvmtsIeW8r+q
         5Je2EF5svU4OVNvB0zNF3Zv4aqVTua07uJ6PhEK+oQjLeQJfxl7koWq6MNfsRpxGXrxH
         I8N0cBmmH/1+XVVQ3GpSIJwbYiyj4P4QcuABO9D1EihyHXdNZ7ZPmsvWMMiZUT8OQ0gs
         2YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ib7KlwO5w2vjHaS8oeyUDHUbSwJunHfY/gYb/VCCmAI=;
        b=JxsqU7/MSuy8sDIvoh59TDvz2iCoYu8ZzawNfdCrNxMk3ftJEpVIDlW3OKxkes3lF1
         2mJtfyZRkcYRqUH4MPk4RYJNTLsWiBGhR/JWRQcOtrNBXqFf/VLCdRQeI8ULqFwAzrsA
         uZtyVsqYzgGNsl8SHZHCW8m0T0CB9ggBWUs2f+RVaXvYT/NITSnoB00H9sPoZe7nM5oJ
         okAzE+GzV6mpOIIIxoMiyXcydbGk5OcH6Leo5iqBUS7CgksHA7r52R1VV75/eYQ88t5Q
         OpYWupiLGcJmYvpgtQa2uBKP/ZjjXXtuKvG8lArpuLpYYhpIPTgxs3Cc2kpYTDQ92uhf
         B/eQ==
X-Gm-Message-State: APjAAAUzPH2yyJ+7aa9w/SyFFDRX/ulvjcyc+yvjhoHNQTnMHI/STdKv
        ljiweEP6G2keegPXh5alMo7dVtjU8tZz2A==
X-Google-Smtp-Source: APXvYqy5ZOZUqvEHdDMrWQzEnyy9RNObo84kvMbgSLlKkryv2GAsRGNYdduvqLST4Gxpmo+WrJ1j/w==
X-Received: by 2002:a05:620a:142c:: with SMTP id k12mr34060142qkj.207.1579191280482;
        Thu, 16 Jan 2020 08:14:40 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6813])
        by smtp.gmail.com with ESMTPSA id a14sm3507110qta.97.2020.01.16.08.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:14:39 -0800 (PST)
Subject: Re: [PATCH v6 1/5] btrfs: Introduce per-profile available space
 facility
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200116060404.95200-1-wqu@suse.com>
 <20200116060404.95200-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <49727617-91d3-9cff-c772-19d7cd371b55@toxicpanda.com>
Date:   Thu, 16 Jan 2020 11:14:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200116060404.95200-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/20 1:04 AM, Qu Wenruo wrote:
> [PROBLEM]
> There are some locations in btrfs requiring accurate estimation on how
> many new bytes can be allocated on unallocated space.
> 
> We have two types of estimation:
> - Factor based calculation
>    Just use all unallocated space, divide by the profile factor
>    One obvious user is can_overcommit().
> 
> - Chunk allocator like calculation
>    This will emulate the chunk allocator behavior, to get a proper
>    estimation.
>    The only user is btrfs_calc_avail_data_space(), utilized by
>    btrfs_statfs().
>    The problem is, that function is not generic purposed enough, can't
>    handle things like RAID5/6.
> 
> Current factor based calculation can't handle the following case:
>    devid 1 unallocated:	1T
>    devid 2 unallocated:	10T
>    metadata type:	RAID1
> 
> If using factor, we can use (1T + 10T) / 2 = 5.5T free space for
> metadata.
> But in fact we can only get 1T free space, as we're limited by the
> smallest device for RAID1.
> 
> [SOLUTION]
> This patch will introduce per-profile available space calculation,
> which can give an estimation based on chunk-allocator-like behavior.
> 
> The difference between it and chunk allocator is mostly on rounding and
> [0, 1M) reserved space handling, which shouldn't cause practical impact.
> 
> The newly introduced per-profile available space calculation will
> calculate available space for each type, using chunk-allocator like
> calculation.
> 
> With that facility, for above device layout we get the full available
> space array:
>    RAID10:	0  (not enough devices)
>    RAID1:	1T
>    RAID1C3:	0  (not enough devices)
>    RAID1C4:	0  (not enough devices)
>    DUP:		5.5T
>    RAID0:	2T
>    SINGLE:	11T
>    RAID5:	1T
>    RAID6:	0  (not enough devices)
> 
> Or for a more complex example:
>    devid 1 unallocated:	1T
>    devid 2 unallocated:  1T
>    devid 3 unallocated:	10T
> 
> We will get an array of:
>    RAID10:	0  (not enough devices)
>    RAID1:	2T
>    RAID1C3:	1T
>    RAID1C4:	0  (not enough devices)
>    DUP:		6T
>    RAID0:	3T
>    SINGLE:	12T
>    RAID5:	2T
>    RAID6:	0  (not enough devices)
> 
> And for the each profile , we go chunk allocator level calculation:
> The pseudo code looks like:
> 
>    clear_virtual_used_space_of_all_rw_devices();
>    do {
>    	/*
>    	 * The same as chunk allocator, despite used space,
>    	 * we also take virtual used space into consideration.
>    	 */
>    	sort_device_with_virtual_free_space();
> 
>    	/*
>    	 * Unlike chunk allocator, we don't need to bother hole/stripe
>    	 * size, so we use the smallest device to make sure we can
>    	 * allocated as many stripes as regular chunk allocator
>    	 */
>    	stripe_size = device_with_smallest_free->avail_space;
> 	stripe_size = min(stripe_size, to_alloc / ndevs);
> 
>    	/*
>    	 * Allocate a virtual chunk, allocated virtual chunk will
>    	 * increase virtual used space, allow next iteration to
>    	 * properly emulate chunk allocator behavior.
>    	 */
>    	ret = alloc_virtual_chunk(stripe_size, &allocated_size);
>    	if (ret == 0)
>    		avail += allocated_size;
>    } while (ret == 0)
> 
> As we always select the device with least free space, the device with
> the most space will be the first to be utilized, just like chunk
> allocator.
> For above 1T + 10T device, we will allocate a 1T virtual chunk
> in the first iteration, then run out of device in next iteration.
> 
> Thus only get 1T free space for RAID1 type, just like what chunk
> allocator would do.
> 
> The patch will update such per-profile available space at the following
> timing:
> - Mount time
> - Chunk allocation
> - Chunk removal
> - Device grow
> - Device shrink
> 
> Those timing are all protected by chunk_mutex, and what we do are only
> iterating in-memory only structures, no extra IO triggered, so the
> performance impact should be pretty small.
> 
> For the extra error handling, the principle is to keep the old behavior.
> That's to say, if old error handler would just return an error, then we
> follow it, no matter if the caller reverts the device size.
> 
> For the proper error handling, they will be added in later patches.
> As I don't want to make the core facility bloated by the error handling
> code, especially some situation needs quite some new code to handle
> errors.

Instead of creating a weird error handling case why not just set the 
per_profile_avail to 0 on error?  This will simply disable overcommit and we'll 
flush more.  This way we avoid making a weird situation weirder, and we don't 
have to worry about returning an error from calc_one_profile_avail().  Simply 
say "hey we got enomem, metadata overcommit is going off" with a 
btrfs_err_ratelimited() and carry on.  Maybe the next one will succeed and we'll 
get overcommit turned back on.  Thanks,

Josef
