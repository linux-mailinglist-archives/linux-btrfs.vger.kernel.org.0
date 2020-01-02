Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6D512E88F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgABQNQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:13:16 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40465 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgABQNQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 11:13:16 -0500
Received: by mail-qt1-f194.google.com with SMTP id e6so34995558qtq.7
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 08:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qNuDQe4d7DjBf2kzmyoYcouYbxXmbUTSi1E7TdKAkC0=;
        b=jUDH+3KfO9N2s3TnJ2fm3pQXw8+JwGMwVZweYQXCJG4zF1u+a9ipR/y1AWudRAFicJ
         GX1zc4GUDqSBQNAL6q1QM7uiL2/ZmEi3piVbxAX6NmvZYH4XBp8N46BFPx5XVScC95TZ
         L1M3nde0a4AkMQm5+HHylNhdnQBe0fVM3gNxh5uXeyVyZ+EaudL/pA1vnLDIbZ50B7NA
         cQ+fTzCvnpOLZIu4StgQXSIREiod2/tj2Bg5adhmuWzNl7bYa9iVMxcInBrRmahn/qnR
         SwjsJepK4euCyHs/Qs7mRHUD+tGwHVye2Kc3dY4snSoceCzEL+kB6b5MXld5JKorqxaV
         2Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qNuDQe4d7DjBf2kzmyoYcouYbxXmbUTSi1E7TdKAkC0=;
        b=XYY1bd7EIq2x46uB2NfUQjr9eQbm7zZYOKo3WIOBjco5Bv7VOgDYwQO+iirHGBUNj1
         YKSE8rm2QxkL/NEvv5KxRaC0NBysb+iEiBgKoopfs9ODIAuN8+AqOCoIz5OCKQo4oimA
         xz/X7jIYMHMwOr0ir0UY6WqJEq2jAfacdROowX3idrxoSHebKprrDMBOc1aR+i/OL3yZ
         LScjeLY6luXNU6dHUAXE3wAULSEAnnnZrQafarf1QR0ilMFPIrwrTrWW5Rin9aPhzJak
         xx5+8eMZcskWijH1CD9tPZH/VNs4ue3KO/auzXSzBMN0OqIcgz6SCidnCx5vSKtSkkdw
         pe/Q==
X-Gm-Message-State: APjAAAXr3Mg4iunKtO1xbkstM8waDxVwneVg5G9WDwPuxTUubbbMPhc/
        ybuKLadFA13cXTPEXxMNzhxN4FfFbz10jQ==
X-Google-Smtp-Source: APXvYqwWcz+j83qreQJCOd+PoOGYUK01ZusXTBtO1SegfzG97QTw/mAs56PKLuTrLiYek8b55XunTg==
X-Received: by 2002:ac8:3496:: with SMTP id w22mr59706192qtb.47.1577981594488;
        Thu, 02 Jan 2020 08:13:14 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::be95])
        by smtp.gmail.com with ESMTPSA id l6sm17068056qti.10.2020.01.02.08.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 08:13:13 -0800 (PST)
Subject: Re: [PATCH v2 1/4] btrfs: Introduce per-profile available space
 facility
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200102112746.145045-1-wqu@suse.com>
 <20200102112746.145045-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2cd6c572-2f78-3c51-9e17-b8ba897c642e@toxicpanda.com>
Date:   Thu, 2 Jan 2020 11:13:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200102112746.145045-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/2/20 6:27 AM, Qu Wenruo wrote:
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
