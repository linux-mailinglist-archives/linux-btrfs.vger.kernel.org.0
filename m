Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3512E305FA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 16:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbhA0PcG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 10:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbhA0P1t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 10:27:49 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419FCC061573
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:27:08 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id u20so2030717qku.7
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=nqEPtMI1+Y96uq22bHLgQ5EtAXoJUQ18YTBUq4fmCBI=;
        b=IsyTg5MmJE/WH4/tbknwt0YKfYXCImjDPiBCAlzsS0m8jkHZWLSBToKp5lzAFek4Ws
         5NxS64dPGrmf27jqbbDdxaSCXKeZVAXMIeUzSEBJogDOf6bU1msWNF27ek5DhxdIN2+9
         vFWUR2EpIdfEiNlwDW+siApAuJ9lofowMGhWjYE8BKko5tojM/e6y3lhgQOdqpg8j7Gk
         DHMxG34I9J8KrdlckkhV9JdY0oXP87VYL1RqgF9TAc9zu7RnPCzYuEF506vuuuuwcJ5S
         aMHZlbmiDDlYsdpWPrJa9PQ7jMPfplCY4IVg6cDfFrxlWGcPU681YdVLUaoZr4nd5G/z
         KfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nqEPtMI1+Y96uq22bHLgQ5EtAXoJUQ18YTBUq4fmCBI=;
        b=RNHVQGdGc3xCyXmrzA5tZQYpVBQNNdFgj9vEgDR/YsKqAfhfXZ6j59dKC8OT/jFO+g
         fx/pGa88VnJC5dv3pbXgOxHq+txZa8pPyJOBt+ORrQdvt5Uz+cM2aTykqitKy0rj+H6I
         u1IxVnHsQUc8in0fy8Qh3zfmIIoLQfd+JxBTi5Xb9FtIob4HsdfpgSRgMDSInB+rqVFG
         mEmb0X9ktthY0MA9r59oPxvX6ws7LFFeALa/9pHsf6kHftar5LnvNs6Te/sRh/xBxKYD
         BJiaGshrrq1fHWJ+Tu4XPQ3GtV/QUjKHmpfboBmv1zFlqt/OZIeE3pw2D52u8G94dtLr
         ljjA==
X-Gm-Message-State: AOAM533MdpDVXSmTnALl+Lw0MtriceHAV1+gsx0FQmwQ/FkLIT4C3Yfc
        WObq4RVK6SFo3Gj9KO68giY6fh1Nkq4+jryW
X-Google-Smtp-Source: ABdhPJzNwUwiv40746MlsJifERohAX8KTyRT0y3fHlGUPKLANTxdMzhIlBe2LMNObAdtCKz0rOD/Fg==
X-Received: by 2002:a37:678b:: with SMTP id b133mr6276481qkc.237.1611761225529;
        Wed, 27 Jan 2021 07:27:05 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z2sm1483614qtz.71.2021.01.27.07.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:26:48 -0800 (PST)
Subject: Re: [PATCH 7/7] btrfs: make concurrent fsyncs wait less when waiting
 for a transaction commit
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1611742865.git.fdmanana@suse.com>
 <8c391b7c0a7a6a7e827644d424cd4c343f39588e.1611742865.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0abbf39a-d65b-1f54-d654-e09533a82e47@toxicpanda.com>
Date:   Wed, 27 Jan 2021 10:26:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <8c391b7c0a7a6a7e827644d424cd4c343f39588e.1611742865.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/27/21 5:35 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Often an fsync needs to fallback to a transaction commit for several
> reasons (to ensure consistency after a power failure, a new block group
> was allocated or a temporary error such as ENOMEM or ENOSPC happened).
> 
> In that case the log is marked as needing a full commit and any concurrent
> tasks attempting to log inodes or commit the log will also fallback to the
> transaction commit. When this happens they all wait for the task that first
> started the transaction commit to finish the transaction commit - however
> they wait until the full transaction commit happens, which is not needed,
> as they only need to wait for the superblocks to be persisted and not for
> unpinning all the extents pinned during the transaction's lifetime, which
> even for short lived transactions can be a few thousand and take some
> significant amount of time to complete - for dbench workloads I have
> observed up to 4~5 milliseconds of time spent unpinning extents in the
> worst cases, and the number of pinned extents was between 2 to 3 thousand.
> 
> So allow fsync tasks to skip waiting for the unpinning of extents when
> they call btrfs_commit_transaction() and they were not the task that
> started the transaction commit (that one has to do it, the alternative
> would be to offload the transaction commit to another task so that it
> could avoid waiting for the extent unpinning or offload the extent
> unpinning to another task).
> 
> This patch is part of a patchset comprised of the following patches:
> 
>    btrfs: remove unnecessary directory inode item update when deleting dir entry
>    btrfs: stop setting nbytes when filling inode item for logging
>    btrfs: avoid logging new ancestor inodes when logging new inode
>    btrfs: skip logging directories already logged when logging all parents
>    btrfs: skip logging inodes already logged when logging new entries
>    btrfs: remove unnecessary check_parent_dirs_for_sync()
>    btrfs: make concurrent fsyncs wait less when waiting for a transaction commit
> 
> After applying the entire patchset, dbench shows improvements in respect
> to throughput and latency. The script used to measure it is the following:
> 
>    $ cat dbench-test.sh
>    #!/bin/bash
> 
>    DEV=/dev/sdk
>    MNT=/mnt/sdk
>    MOUNT_OPTIONS="-o ssd"
>    MKFS_OPTIONS="-m single -d single"
> 
>    echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> 
>    umount $DEV &> /dev/null
>    mkfs.btrfs -f $MKFS_OPTIONS $DEV
>    mount $MOUNT_OPTIONS $DEV $MNT
> 
>    dbench -D $MNT -t 300 64
> 
>    umount $MNT
> 
> The test was run on a physical machine with 12 cores (Intel corei7), 64G
> of ram, using a NVMe device and a non-debug kernel configuration (Debian's
> default configuration).
> 
> Before applying patchset, 32 clients:
> 
>   Operation      Count    AvgLat    MaxLat
>   ----------------------------------------
>   NTCreateX    9627107     0.153    61.938
>   Close        7072076     0.001     3.175
>   Rename        407633     1.222    44.439
>   Unlink       1943895     0.658    44.440
>   Deltree          256    17.339   110.891
>   Mkdir            128     0.003     0.009
>   Qpathinfo    8725406     0.064    17.850
>   Qfileinfo    1529516     0.001     2.188
>   Qfsinfo      1599884     0.002     1.457
>   Sfileinfo     784200     0.005     3.562
>   Find         3373513     0.411    30.312
>   WriteX       4802132     0.053    29.054
>   ReadX        15089959     0.002     5.801
>   LockX          31344     0.002     0.425
>   UnlockX        31344     0.001     0.173
>   Flush         674724     5.952   341.830
> 
> Throughput 1008.02 MB/sec  32 clients  32 procs  max_latency=341.833 ms
> 
> After applying patchset, 32 clients:
> 
> After patchset, with 32 clients:
> 
>   Operation      Count    AvgLat    MaxLat
>   ----------------------------------------
>   NTCreateX    9931568     0.111    25.597
>   Close        7295730     0.001     2.171
>   Rename        420549     0.982    49.714
>   Unlink       2005366     0.497    39.015
>   Deltree          256    11.149    89.242
>   Mkdir            128     0.002     0.014
>   Qpathinfo    9001863     0.049    20.761
>   Qfileinfo    1577730     0.001     2.546
>   Qfsinfo      1650508     0.002     3.531
>   Sfileinfo     809031     0.005     5.846
>   Find         3480259     0.309    23.977
>   WriteX       4952505     0.043    41.283
>   ReadX        15568127     0.002     5.476
>   LockX          32338     0.002     0.978
>   UnlockX        32338     0.001     2.032
>   Flush         696017     7.485   228.835
> 
> Throughput 1049.91 MB/sec  32 clients  32 procs  max_latency=228.847 ms
> 
>   --> +4.1% throughput, -39.6% max latency
> 
> Before applying patchset, 64 clients:
> 
>   Operation      Count    AvgLat    MaxLat
>   ----------------------------------------
>   NTCreateX    8956748     0.342   108.312
>   Close        6579660     0.001     3.823
>   Rename        379209     2.396    81.897
>   Unlink       1808625     1.108   131.148
>   Deltree          256    25.632   172.176
>   Mkdir            128     0.003     0.018
>   Qpathinfo    8117615     0.131    55.916
>   Qfileinfo    1423495     0.001     2.635
>   Qfsinfo      1488496     0.002     5.412
>   Sfileinfo     729472     0.007     8.643
>   Find         3138598     0.855    78.321
>   WriteX       4470783     0.102    79.442
>   ReadX        14038139     0.002     7.578
>   LockX          29158     0.002     0.844
>   UnlockX        29158     0.001     0.567
>   Flush         627746    14.168   506.151
> 
> Throughput 924.738 MB/sec  64 clients  64 procs  max_latency=506.154 ms
> 
> After applying patchset, 64 clients:
> 
>   Operation      Count    AvgLat    MaxLat
>   ----------------------------------------
>   NTCreateX    9069003     0.303    43.193
>   Close        6662328     0.001     3.888
>   Rename        383976     2.194    46.418
>   Unlink       1831080     1.022    43.873
>   Deltree          256    24.037   155.763
>   Mkdir            128     0.002     0.005
>   Qpathinfo    8219173     0.137    30.233
>   Qfileinfo    1441203     0.001     3.204
>   Qfsinfo      1507092     0.002     4.055
>   Sfileinfo     738775     0.006     5.431
>   Find         3177874     0.936    38.170
>   WriteX       4526152     0.084    39.518
>   ReadX        14213562     0.002    24.760
>   LockX          29522     0.002     1.221
>   UnlockX        29522     0.001     0.694
>   Flush         635652    14.358   422.039
> 
> Throughput 990.13 MB/sec  64 clients  64 procs  max_latency=422.043 ms
> 
>   --> +6.8% throughput, -18.1% max latency
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Funnily enough I've got a patch to async off unpinning as it drastically affects 
our WhatsApp workload.  Once that lands maybe we can undo this bit.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
