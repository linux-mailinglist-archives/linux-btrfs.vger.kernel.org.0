Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8878715204A
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 19:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgBDSRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 13:17:20 -0500
Received: from mail.as397444.net ([69.59.18.99]:37718 "EHLO mail.as397444.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbgBDSRT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 13:17:19 -0500
Received: from [10.233.42.100] (unknown [69.59.18.156])
        by mail.as397444.net (Postfix) with ESMTPSA id 464AB194238;
        Tue,  4 Feb 2020 18:17:18 +0000 (UTC)
Subject: Re: btrfs balance start -musage=0 / eats drive space
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <526cb529-770c-9279-aad8-7632f07832b8@bluematt.me>
 <CAJCQCtTuKnsQJNKupKbmBxGpkZSqWcYXBD+36v9aT6zZAqmuhg@mail.gmail.com>
 <2353c20b-95c2-2d58-65eb-9d574ff506ee@bluematt.me>
From:   Matt Corallo <linux@bluematt.me>
Message-ID: <615c56b6-4a05-2765-ce34-c6e1992c4c6f@bluematt.me>
Date:   Tue, 4 Feb 2020 18:17:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2353c20b-95c2-2d58-65eb-9d574ff506ee@bluematt.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This appears to be some kind of race when there are a lot of pending
metadata writes in flight.

I went and unmounted/remounted again (after taking about 30 minutes of
5MB/s writes flushing an rsync with a ton of tiny files) and after the
remount the issue went away again. So I can only presume it is an issue
only when there are a million or so tiny files pending write.

Matt

On 2/4/20 3:41 AM, Matt Corallo wrote:
> Things settled a tiny bit after unmount (see last email for the errors
> that generated) and remount, and a balance -mconvert,soft worked:
> 
> [268093.588482] BTRFS info (device dm-2): balance: start
> -mconvert=raid1,soft -sconvert=raid1,soft
> ...
> [288405.946776] BTRFS info (device dm-2): balance: ended with status: 0
> 
> However, the enospc issue still appears and seems tied to a few of the
> previously-allocated metadata blocks:
> 
> # btrfs balance start -musage=0 /bigraid
> ...
> 
> [289714.420418] BTRFS info (device dm-2): balance: start -musage=0 -susage=0
> [289714.508411] BTRFS info (device dm-2): 64 enospc errors during balance
> [289714.508413] BTRFS info (device dm-2): balance: ended with status: -28
> 
> # cd /sys/fs/btrfs/e2843f83-aadf-418d-b36b-5642f906808f/allocation/ &&
> grep -Tr .
> metadata/raid1/used_bytes:	255838797824
> metadata/raid1/total_bytes:	441307889664
> metadata/disk_used:	511677595648
> metadata/bytes_pinned:	0
> metadata/bytes_used:	255838797824
> metadata/total_bytes_pinned:	999424
> metadata/disk_total:	882615779328
> metadata/total_bytes:	441307889664
> metadata/bytes_reserved:	4227072
> metadata/bytes_readonly:	65536
> metadata/bytes_may_use:	433502945280
> metadata/flags:	4
> system/raid1/used_bytes:	1474560
> system/raid1/total_bytes:	33554432
> system/disk_used:	2949120
> system/bytes_pinned:	0
> system/bytes_used:	1474560
> system/total_bytes_pinned:	0
> system/disk_total:	67108864
> system/total_bytes:	33554432
> system/bytes_reserved:	0
> system/bytes_readonly:	0
> system/bytes_may_use:	0
> system/flags:	2
> global_rsv_reserved:	536870912
> data/disk_used:	13645423230976
> data/bytes_pinned:	0
> data/bytes_used:	13645423230976
> data/single/used_bytes:	13645423230976
> data/single/total_bytes:	13661217226752
> data/total_bytes_pinned:	0
> data/disk_total:	13661217226752
> data/total_bytes:	13661217226752
> data/bytes_reserved:	117518336
> data/bytes_readonly:	196608
> data/bytes_may_use:	15064711168
> data/flags:	1
> global_rsv_size:	536870912
> 
> 
> Somewhat more frightening, this also happens on the system blocks:
> 
> [288405.946776] BTRFS info (device dm-2): balance: ended with status: 0
> [289589.506357] BTRFS info (device dm-2): balance: start -musage=5 -susage=5
> [289589.905675] BTRFS info (device dm-2): relocating block group
> 9676759498752 flags system|raid1
> [289590.807033] BTRFS info (device dm-2): found 89 extents
> [289591.300212] BTRFS info (device dm-2): 16 enospc errors during balance
> [289591.300216] BTRFS info (device dm-2): balance: ended with status: -28
> 
> Matt
> 
> On 2/3/20 9:40 PM, Chris Murphy wrote:
>> A developer might find it useful to see this reproduced with mount
>> option enospc_debug. And soon after enospc the output from:
>>
>>  cd /sys/fs/btrfs/UUID/allocation/ && grep -Tr .
>>
>> yep, space then dot at the end
>>
