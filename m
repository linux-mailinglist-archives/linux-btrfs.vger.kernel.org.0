Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA7812D1C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 17:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfL3QOT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 11:14:19 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38602 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfL3QOT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 11:14:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so26576290qki.5
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2019 08:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vj3HV/eLAKoFMPK+oUmHqSysAIljW0r3YQwv4mdkbcQ=;
        b=amsbIxJwL3xJXknXu87kWA7oIgSE3m9VK/yB0faMrSOabUGLiFhb1fN9btIBKbHNNu
         vda2Qdx7UHK/lQ+IypsRtk/3ZvcjSjHWVqoyosh1Gvyv21Cs6VTi0vNlDOjAqmfCG2Ot
         VltrLBGMpDRUFs/EHhGILYD0FQRlyeZiMUIiOPsuOqxntxThTUMCr9TEplVDVHUy2q5O
         kWxeFrc25zHEX7kynvhpm2Gzvk6hfoK35ii02dnqP+PnCP6a0dec0pq4ENWCYWqc31Kw
         J+1ceAfD0lv6MITVmDwPi4BwCHGKbMUF0Ckcw2B51bTjoyQ2DfGiQgXQfNEVumrDX+Jj
         KJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vj3HV/eLAKoFMPK+oUmHqSysAIljW0r3YQwv4mdkbcQ=;
        b=lEEhVkNwiXvWbodMwGQXjvbLp/RPfVPrv9eGJHUhXTJby6m63ysBBjU2mWyL9lRNI9
         A84egbEXzvDFifHXayS6wtY8W7bOwLGVh1oChfedJ1uMrCRrlBakZ2xF2+WME0O9qLJ/
         XG4p0nkbAxIKlh5fjKIYnBx1tDiAwk9ANeI+TV84WWuuyD29ooZSkRJO66Tdi2sj6N50
         AwozRFMcuC/h7JXLA2a4T3O2DNKiT9UiY+kTP3KdAC81pszNzfSmjUVQpcgXONRhhszt
         SBv2ZyG2dhYgxsjCJaZRavCPDgQm6jdSqYTzI+rl5wfdwHl6BkINadBsg/Njqnxa7iWq
         7FPA==
X-Gm-Message-State: APjAAAX6Bl4Hw4wtKrseAnciaoAn/l5YzICis8TjJGcmJsYYPru2TnjW
        WlJasrpe2KoGZ379RKBsBdDy1yccW1mJsg==
X-Google-Smtp-Source: APXvYqz777ohF8EdAQQFr8tKER+S5EMbYs/LQ3mTDMZJqEff1AckQEelMGYcnPhCBiKWA3mVLDUdXw==
X-Received: by 2002:a37:bc04:: with SMTP id m4mr56223051qkf.224.1577722456391;
        Mon, 30 Dec 2019 08:14:16 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::2e4b])
        by smtp.gmail.com with ESMTPSA id i14sm12506593qkl.133.2019.12.30.08.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 08:14:15 -0800 (PST)
Subject: Re: [PATCH RFC 1/3] btrfs: Introduce per-profile available space
 facility
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191225133938.115733-1-wqu@suse.com>
 <20191225133938.115733-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ab05c368-d1ff-1002-0d83-5a8d33973233@toxicpanda.com>
Date:   Mon, 30 Dec 2019 11:14:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191225133938.115733-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/25/19 8:39 AM, Qu Wenruo wrote:
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
> This patch will introduce the skeleton of per-profile available space
> calculation, which can more-or-less get to the point of chunk allocator.
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
> The code code looks like:
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
> As we always select the device with least free space (just like chunk
> allocator), for above 1T + 10T device, we will allocate a 1T virtual chunk
> in the first iteration, then run out of device in next iteration.
> 
> Thus only get 1T free space for RAID1 type, just like what chunk
> allocator would do.
> 
> This patch is just the skeleton, we only do the per-profile chunk
> calculation at mount time.
> 
> Later commits will update per-profile available space at other proper
> timings.
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
