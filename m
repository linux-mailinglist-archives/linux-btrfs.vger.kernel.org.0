Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990907A116C
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 01:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjINXIx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 19:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjINXIx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 19:08:53 -0400
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D229FE6A
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 16:08:48 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w1.tutanota.de (Postfix) with ESMTP id 807B2FBFBAC;
        Thu, 14 Sep 2023 23:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1694732927;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=l6hqtW/vW2jG8ITIxiG4P2hu8g52MDaBwuFYIocLcZY=;
        b=isF0A3TZGHDnMxxgnPtTVsb1A7nXSBsg7D4NT9HPyJyUr70+pCMXzKkhw7RJ3EhV
        FryUT90Zph47edkNDzM5h6rWcv5pdeyX5NxgD+EziV+jVOLDmeeS0yPOu1ubqAi+LpZ
        sRU7NMuLu7mDf15z3t42+TEAc1JuJuh7KD9wlOx59/tSS3885rnCktEv96WQ1DEVP8K
        hj18yeTgWT6IcHarHxDC74zphi8aRyrreZrf0jd05U+pxDrnfhFsBMQE/ZqP6vXFfxQ
        202FZuLk9qTfDNvNWYDvFF/xjI2aTGZ7oII9sUF9RVkBzXEDcT9u47/aVDWmLNd/aby
        eSikC/TbXQ==
Date:   Fri, 15 Sep 2023 01:08:47 +0200 (CEST)
From:   fdavidl073rnovn@tutanota.com
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <NeKx2tK--3-9@tutanota.com>
In-Reply-To: <bb668050-7d43-467f-8648-8bc5f2c314f1@gmx.com>
References: <NeBMdyL--3-9@tutanota.com> <4b8a10e4-4df8-4d96-9c6f-fbbe85c64575@suse.com> <NeGkwyI--3-9@tutanota.com> <bb668050-7d43-467f-8648-8bc5f2c314f1@gmx.com>
Subject: Re: Deleting large amounts of data causes system freeze due to OOM.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Sep 14, 2023, 05:12 by quwenruo.btrfs@gmx.com:

>
>
> On 2023/9/14 13:08, fdavidl073rnovn@tutanota.com wrote:
>
>> Sep 13, 2023, 05:55 by wqu@suse.com:
>>
>>>
>>>
>>> On 2023/9/13 11:58, fdavidl073rnovn@tutanota.com wrote:
>>>
>>>> Dear Btrfs Mailing List,
>>>>
>>>> Full disclosure I reported this on kernel.org but am hoping to get more exposure on the mailing list.
>>>>
>>>> When I delete several terabytes of data memory usage increases until the system becomes entirely unresponsive. This has been an issue for several kernel version since at least 5.19 and continues to be an issue up to 6.5.2-artix1-1. This is on an older computer with several hard drives, eight gigabytes of memory, and a four core x86_64 cpu. Slabtop output right before the system becomes unresponsive shows about four gigabytes used by khugepaged_mm_slot and three used by btrfs_extent_map. This happens in over the span of a couple minutes and during this time btrfs-transaction is using a moderate amount of cpu time.
>>>>
>>>
>>> This looks exactly like something caused by btrfs qgroup.
>>>
>>> Could you try to disable qgroup to see if it helps?
>>> The amount of CPU time and IO of qgroup overhead is directly related to the amount of extent being updated.
>>>
>>> For normal writes the IO itself would take most of the CPU/memory thus qgroup is not a big deal.
>>> But for massive snapshots drop or file deletion qgroup can be too large to be handled in just one transaction.
>>>
>>> For now you can disable the qgroup as a workaround.
>>>
>>> Thanks,
>>> Qu
>>>
>> I've never enabled quotas and my most recent attempt using the single profile for data was on kernel 6.4 so they would have been disabled by default. Running "btrfs qgroup show [path]" returns "ERROR: can't list qgroups: quotas not enabled".
>>
>
> OK, at least we can rule out qgroup.
>
> Mind to provide more info? Including:
>
> - How many files are involved?
>  A large file vs a ton of small files have very different workloads.
>  Any values on the average file size would also help.
>
> - Is the fs using v1 or v2 space cache?
> - Do the deleted files have any snapshot/reflink?
> - Is there any other processes reading the to-be-deleted files?
>
> One of my concern is the btrfs_extent_map usage, that's mostly used by
> regular files as an in-memory cache so that they don't need to lookup
> the tree on-disk.
>
> I just checked the code, evicting an inode won't trigger
> btrfs_extent_map usage, it's mostly read/write triggering such
> btrfs_extent_map usage.
>
> Thus there must be something else causing the unexpected
> btrfs_extent_map usage.
>
> Thanks,
> Qu
>
>>
>> Sincerely,
>> David
>>
On my latest attempt using the single profile there is about fifteen terabytes total of space used, around eight hundred and fifty thousand files, over 9000 directories, and there are three very large files (two two terabyte and one four terabyte). There are also about two terabytes of compressed files using zstd at a fifty percent ratio.

The device is using space cache version two, there are no reflink or snapshots as far as I know and nothing else is reading or happening when this occurs. The system idles at about three hundred megabytes of memory used with negligible cpu activity before this happens.

For some context the device is currently mounted with compress-force=zstd:3 and noatime. The data currently on the device was transferred via send-receive version two (and was already compressed) as a snapshot but it is the only copy of it on the disk so I am not sure if that counts as a snapshot. I do not think the snapshot is related because I have deleted a single four terabyte file (from the snapshot) as a test and the memory usage went from about three hundred megabytes to over a gigabyte before going back down. I assume that was the same thing but the system just did not run out of memory.

Sincerely,
David

