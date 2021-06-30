Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059E93B7E45
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 09:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhF3HmA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 03:42:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39302 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbhF3Hl7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 03:41:59 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 57C012045B;
        Wed, 30 Jun 2021 07:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625038770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENgYi+Uyc0WHz/3/frP46KpSv1i4qQgN4oslA9u8rWc=;
        b=GePpEUiATSG3IqgRFVYIWpfqth3Hqk+IofO0PxJnvqMTC8VrTLzbh05h40K9lsv6YHaazJ
        XLG8ubMFTmH9BCKv5vR2R1rGEWV3kCazT0vaUkFgOv3qK7coPDfNdW6CgT3JUbkBxFqzJW
        kydq/xUWWTr12t+e8py8ZW5laRWP1I4=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 224D411906;
        Wed, 30 Jun 2021 07:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625038770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENgYi+Uyc0WHz/3/frP46KpSv1i4qQgN4oslA9u8rWc=;
        b=GePpEUiATSG3IqgRFVYIWpfqth3Hqk+IofO0PxJnvqMTC8VrTLzbh05h40K9lsv6YHaazJ
        XLG8ubMFTmH9BCKv5vR2R1rGEWV3kCazT0vaUkFgOv3qK7coPDfNdW6CgT3JUbkBxFqzJW
        kydq/xUWWTr12t+e8py8ZW5laRWP1I4=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 75dfBbIf3GCzJAAALh3uQQ
        (envelope-from <nborisov@suse.com>); Wed, 30 Jun 2021 07:39:30 +0000
Subject: Re: [PATCH] btrfs: Stop kmalloc'ing btrfs_path in
 btrfs_lookup_bio_sums
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20210628150609.2833435-1-nborisov@suse.com>
 <06554f93-68e1-b706-07be-62f6cdbf150e@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3724ac1b-bb8e-eaf3-17fd-98e42d5b9bb6@suse.com>
Date:   Wed, 30 Jun 2021 10:39:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <06554f93-68e1-b706-07be-62f6cdbf150e@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.06.21 г. 14:56, Qu Wenruo wrote:
> 
> 
> On 2021/6/28 下午11:06, Nikolay Borisov wrote:
>> While doing some performance characterization of a workoad reading ~80g
>> split among 4mb files via DIO I observed that btrfs_lookup_bio_sums was
>> using rather excessive cpu cycles:
>>
>> 95.97%--ksys_pread64
>> 95.96%--new_sync_read
>> 95.95%--iomap_dio_rw
>> 95.89%--iomap_apply
>> 72.25%--iomap_dio_bio_actor
>> 55.19%--iomap_dio_submit_bio
>> 55.13%--btrfs_submit_direct
>> 20.72%--btrfs_lookup_bio_sums
>> 7.44%-- kmem_cache_alloc
>>
>> Timing the workload yielded:
>> real 4m41.825s
>> user 0m14.321s
>> sys 10m38.419s
>>
>> Turns out this kmem_cache_alloc corresponds to the btrfs_path allocation
>> that happens in btrfs_lookup_bio_sums. Nothing in btrfs_lookup_bio_sums
>> warrants having the path be heap allocated. Just turn this allocation
>> into a stack based one. After the change performance changes
>> accordingly:
>>
>> real 4m21.742s
>> user 0m13.679s
>> sys 9m8.889s
>>
>> All in all there's a 20 seconds (~7%) reductino in real run time as well
>> as the time spent in the kernel is reduced by 1:30 minutes (~14%). And
>> btrfs_lookup_bio_sums ends up accounting for only 7.91% of cycles rather
>> than 20% before.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> 
> I'm surprised that btrfs_path in kernel no longer needs any initialization.
> 
> I guess we can do a lot of more such conversion to use stack btrfs_path,
> just like what we did in btrfs-progs.
> 
> But I'm not that sure if 112 bytes stack memory usage increase is OK or
> not for other locations.
> 
> But since this one get a pretty good performance increase, and this
> function itself doesn't have much stack memory usage anyway, it looks ok
> to me.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 

Actually this patch makes most sense when SLUB debugging is enabled as
it would seem btrfs is hit pretty hard when debugging is enabled. IN
real world with SLUB debugging disabled it didn't make any noticeable
difference. In this case the fact that I'm adding 112 bytes on the stack
might bring more harm than good so I guess this patch can be dropped.

<snip>
