Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01A5284C0E
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgJFMz5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Oct 2020 08:55:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:51060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgJFMz5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Oct 2020 08:55:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601988955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=bXjgSnFYuwn9+naTuFNonTHoLqr2w+AoSi9jRLfJXCM=;
        b=knlMT+bhgG+c1M50zqCQujBWGyMfBnhQXKA5IRHLxGNEHxcrLFRLyC8BI9GCJXb0cF+R8k
        32jZWFhc77NYBCl/psGz4QaHVBQNfH6CegvaII8kS7j93Kl0IOjbZl8t0cJ18+z1tNuKZZ
        Mi6BBDHYHgvaLZiNHQZYjqW9L3U3x0E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDB45ACC6;
        Tue,  6 Oct 2020 12:55:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 0/9] Improve preemptive ENOSPC flushing
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1601495426.git.josef@toxicpanda.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4ad555d4-70a9-e3a7-3b16-bbf77f123a3e@suse.com>
Date:   Tue, 6 Oct 2020 15:55:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1601495426.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.09.20 г. 23:01 ч., Josef Bacik wrote:
> Hello,
> 
> A while ago Nikolay started digging into a problem where they were seeing an
> around 20% regression on random writes, and he bisected it down to
> 
>   btrfs: don't end the transaction for delayed refs in throttle
> 
> However this wasn't actually the cause of the problem.
> 
> This patch removed the code that would preemptively end the transactions if we
> were low on space.  Because we had just introduced the ticketing code, this was
> no longer necessary and was causing a lot of transaction commits.
> 
> And in Nikolay's testing he validated this, we would see like 100x more
> transaction commits without that patch than with it, but the write regression
> clearly appeared when this patch was applied.
> 
> The root cause of this is that the transaction commits were essentially
> happening so quickly that we didn't end up needing to wait on space in the
> ENOSPC ticketing code as much, and thus were able to write pretty quickly.  With
> this gone, we now were getting a sawtoothy sort of behavior where we'd run up,
> stop while we flushed metadata space, run some more, stop again etc.
> 
> When I implemented the ticketing infrastructure, I was trying to get us out of
> excessively flushing space because we would sometimes over create block groups,
> and thus short circuited flushing if we no longer had tickets.  This had the
> side effect of breaking the preemptive flushing code, where we attempted to
> flush space in the background before we were forced to wait for space.
> 
> Enter this patchset.  We still have some of this preemption logic sprinkled
> everywhere, so I've separated it out of the normal ticketed flushing code, and
> made preemptive flushing it's own thing.
> 
> The preemptive flushing logic is more specialized than the standard flushing
> logic.  It attempts to flush in whichever pool has the highest usage.  This
> means that if most of our space is tied up in pinned extents, we'll commit the
> transaction.  If most of the space is tied up in delalloc, we'll flush delalloc,
> etc.
> 
> To test this out I used the fio job that Nikolay used, this needs to be adjusted
> so the overall IO size is at least 2x the RAM size for the box you are testing
> 
> fio --direct=0 --ioengine=sync --thread --directory=/mnt/test --invalidate=1 \
>         --group_reporting=1 --runtime=300 --fallocate=none --ramp_time=10 \
>         --name=RandomWrites-async-64512-4k-4 --new_group --rw=randwrite \
>         --size=2g --numjobs=4 --bs=4k --fsync_on_close=0 --end_fsync=0 \
>         --filename_format=FioWorkloads.\$jobnum
> 
> I got the following results
> 
> misc-next:	bw=13.4MiB/s (14.0MB/s), 13.4MiB/s-13.4MiB/s (14.0MB/s-14.0MB/s), io=4015MiB (4210MB), run=300323-300323msec
> pre-throttling:	bw=16.9MiB/s (17.7MB/s), 16.9MiB/s-16.9MiB/s (17.7MB/s-17.7MB/s), io=5068MiB (5314MB), run=300069-300069msec
> my patches:	bw=18.0MiB/s (18.9MB/s), 18.0MiB/s-18.0MiB/s (18.9MB/s-18.9MB/s), io=5403MiB (5666MB), run=300001-300001msec
> 
> Thanks,
> 
> Josef
> 
> Josef Bacik (9):
>   btrfs: add a trace point for reserve tickets
>   btrfs: improve preemptive background space flushing
>   btrfs: rename need_do_async_reclaim
>   btrfs: check reclaim_size in need_preemptive_reclaim
>   btrfs: rework btrfs_calc_reclaim_metadata_size
>   btrfs: simplify the logic in need_preemptive_flushing
>   btrfs: implement space clamping for preemptive flushing
>   btrfs: adjust the flush trace point to include the source
>   btrfs: add a trace class for dumping the current ENOSPC state
> 
>  fs/btrfs/ctree.h             |   1 +
>  fs/btrfs/disk-io.c           |   1 +
>  fs/btrfs/space-info.c        | 216 +++++++++++++++++++++++++++++------
>  fs/btrfs/space-info.h        |   3 +
>  include/trace/events/btrfs.h | 112 +++++++++++++++++-
>  5 files changed, 292 insertions(+), 41 deletions(-)
> 



Here are my results from testing misc-next/your patches/4.19 for buffered io: 

With your patches:
 WRITE: bw=29.1MiB/s (30.5MB/s), 29.1MiB/s-29.1MiB/s (30.5MB/s-30.5MB/s), io=8192MiB (8590MB), run=281678-281678msec
 WRITE: bw=30.0MiB/s (32.5MB/s), 30.0MiB/s-30.0MiB/s (32.5MB/s-32.5MB/s), io=8192MiB (8590MB), run=264337-264337msec
 WRITE: bw=29.6MiB/s (31.1MB/s), 29.6MiB/s-29.6MiB/s (31.1MB/s-31.1MB/s), io=8192MiB (8590MB), run=276312-276312msec
 WRITE: bw=29.8MiB/s (31.2MB/s), 29.8MiB/s-29.8MiB/s (31.2MB/s-31.2MB/s), io=8192MiB (8590MB), run=274916-274916msec
 WRITE: bw=30.4MiB/s (31.9MB/s), 30.4MiB/s-30.4MiB/s (31.9MB/s-31.9MB/s), io=8192MiB (8590MB), run=269030-269030msec

Without-misc-next:
  WRITE: bw=20.2MiB/s (21.2MB/s), 20.2MiB/s-20.2MiB/s (21.2MB/s-21.2MB/s), io=8192MiB (8590MB), run=404831-404831msec
  WRITE: bw=20.8MiB/s (21.8MB/s), 20.8MiB/s-20.8MiB/s (21.8MB/s-21.8MB/s), io=8192MiB (8590MB), run=394749-394749msec
  WRITE: bw=20.8MiB/s (21.8MB/s), 20.8MiB/s-20.8MiB/s (21.8MB/s-21.8MB/s), io=8192MiB (8590MB), run=393291-393291msec
  WRITE: bw=20.7MiB/s (21.8MB/s), 20.7MiB/s-20.7MiB/s (21.8MB/s-21.8MB/s), io=8192MiB (8590MB), run=394918-394918msec
  WRITE: bw=21.1MiB/s (22.1MB/s), 21.1MiB/s-21.1MiB/s (22.1MB/s-22.1MB/s), io=8192MiB (8590MB), run=388499-388499msec

4.19.x:
  WRITE: bw=23.3MiB/s (24.4MB/s), 23.3MiB/s-23.3MiB/s (24.4MB/s-24.4MB/s), io=6387MiB (6697MB), run=274460-274460msec
  WRITE: bw=23.3MiB/s (24.5MB/s), 23.3MiB/s-23.3MiB/s (24.5MB/s-24.5MB/s), io=6643MiB (6966MB), run=284518-284518msec
  WRITE: bw=23.4MiB/s (24.5MB/s), 23.4MiB/s-23.4MiB/s (24.5MB/s-24.5MB/s), io=6643MiB (6966MB), run=284372-284372msec
  WRITE: bw=23.6MiB/s (24.7MB/s), 23.6MiB/s-23.6MiB/s (24.7MB/s-24.7MB/s), io=6387MiB (6697MB), run=271200-271200msec
  WRITE: bw=23.4MiB/s (24.6MB/s), 23.4MiB/s-23.4MiB/s (24.6MB/s-24.6MB/s), io=6387MiB (6697MB), run=272670-272670msec

So there is indeed a net-gain in performance, however, (expectedly, due to the increased number of transaction commits) there is a regressions in DIO: 


DIO-josef:
  WRITE: bw=47.1MiB/s (49.4MB/s), 47.1MiB/s-47.1MiB/s (49.4MB/s-49.4MB/s), io=8192MiB (8590MB), run=174049-174049msec
  WRITE: bw=48.5MiB/s (50.8MB/s), 48.5MiB/s-48.5MiB/s (50.8MB/s-50.8MB/s), io=8192MiB (8590MB), run=169045-169045msec
  WRITE: bw=45.0MiB/s (48.2MB/s), 45.0MiB/s-45.0MiB/s (48.2MB/s-48.2MB/s), io=8192MiB (8590MB), run=178196-178196msec
  WRITE: bw=46.1MiB/s (48.3MB/s), 46.1MiB/s-46.1MiB/s (48.3MB/s-48.3MB/s), io=8192MiB (8590MB), run=177861-177861msec
  WRITE: bw=46.4MiB/s (48.7MB/s), 46.4MiB/s-46.4MiB/s (48.7MB/s-48.7MB/s), io=8192MiB (8590MB), run=176376-176376msec

DIO-misc-next:
  WRITE: bw=50.1MiB/s (52.6MB/s), 50.1MiB/s-50.1MiB/s (52.6MB/s-52.6MB/s), io=8192MiB (8590MB), run=163365-163365msec
  WRITE: bw=50.3MiB/s (52.8MB/s), 50.3MiB/s-50.3MiB/s (52.8MB/s-52.8MB/s), io=8192MiB (8590MB), run=162753-162753msec
  WRITE: bw=50.6MiB/s (53.1MB/s), 50.6MiB/s-50.6MiB/s (53.1MB/s-53.1MB/s), io=8192MiB (8590MB), run=161766-161766msec
  WRITE: bw=50.2MiB/s (52.7MB/s), 50.2MiB/s-50.2MiB/s (52.7MB/s-52.7MB/s), io=8192MiB (8590MB), run=163074-163074msec
  WRITE: bw=50.5MiB/s (52.9MB/s), 50.5MiB/s-50.5MiB/s (52.9MB/s-52.9MB/s), io=8192MiB (8590MB), run=162252-162252msec


With that: 

Tested-by: Nikolay Borisov <nborisov@suse.com>

