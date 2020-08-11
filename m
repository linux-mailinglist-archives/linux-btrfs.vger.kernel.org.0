Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CA8241CAA
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgHKOqv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 10:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbgHKOqv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 10:46:51 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51985C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 07:46:51 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e5so9578316qth.5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cWx5iP3jD/PqKjy9oIP8HK3KfR1sVCfHvbsl5h5/Su8=;
        b=c9iFVm6IuG+p4lK4U5fG6vBjdKI9zW2J95LDyQ83e+B+D59wmCouNodolj3JnkTJOO
         LnsuE2Y2g11QUnj58wfk2fdbKAYBqif+tlNdkj/PXQeGiti0pfy7HxM1xYP1sPmSSeNM
         sxPfJskarQjnv/JjFoyvafYcj6XfREs029+CiwZKM1lLKK2OR9JNRRq/qaSut+iSoV9F
         eJbPaxZ/G9K5/UNrfseTwk91/6u5zg6GBCDmBdEbMKKy+59tUz8y6PL9dr2HJm8W7qmf
         UIorqd9O6rHxSGfi+qMifWDS5Hb+LurvPvJm1l75IcGsP2uymJKT1GQQ2+M+hsUd21Xw
         30eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cWx5iP3jD/PqKjy9oIP8HK3KfR1sVCfHvbsl5h5/Su8=;
        b=hv9FRjzkmRq6SzvawuYWd6chEbfyxV7WtNMzzHH3XCACf/dmXgIz2BNJIkMWzxKTsu
         a8erttro1TSD6mYSrXSGMjF9YWJaNfCiW5TnImG+DYvTsqpyAuz6xGQasElM8Cz2mILD
         AnByqLkyUw/YILnBXbm48optTxeTsp7ghcnod7ZThtNQV9IcWo1uJbcW6N20fHqZeLCK
         51/6aIejUlJScWubiMge+h+OnBRBP5110aHEPaTN8lNlZ+KGxdvaNW18Nvc8hDJg7kEK
         jZ+OccNbLJU5zfg3OiZlbfawyrhkdd/bYfKQldX9nkZ8TPKsmQSBDp9jbdMX9LGpSdn4
         ozzQ==
X-Gm-Message-State: AOAM531GWD1yvab9ytVtpZwdmZd+aQpRTBUDSG/4NuADrOB5VNieqcBa
        zTcT9cXPINifnwR7fnEo7cSoXRSKdm7vJg==
X-Google-Smtp-Source: ABdhPJxHEiycPx2BfNcn2LaftBCqsmN3P6CotwVro5HtycNKxHnsv6Iz4QOz0k1EtIw8rMjNRxriWw==
X-Received: by 2002:ac8:45c7:: with SMTP id e7mr1424314qto.187.1597157208701;
        Tue, 11 Aug 2020 07:46:48 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y3sm13574514qkd.132.2020.08.11.07.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 07:46:48 -0700 (PDT)
Subject: Re: [PATCH 1/3] btrfs: do not take the log_mutex of the subvolume
 when pinning the log
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200811114337.689881-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f06846d9-7d89-560a-5ea6-bb78619086bf@toxicpanda.com>
Date:   Tue, 11 Aug 2020 10:46:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811114337.689881-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/11/20 7:43 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During a rename we pin the log to make sure no one commits a log that
> reflects an ongoing rename operation, as it might result in a committed
> log where it recorded the unlink of the old name without having recorded
> the new name. However we are taking the subvolume's log_mutex before
> incrementing the log_writers counter, which is not necessary since that
> counter is atomic and we only remove the old name from the log and add
> the new name to the log after we have incremented log_writers, ensuring
> that no one can commit the log after we have removed the old name from
> the log and before we added the new name to the log.
> 
> By taking the log_mutex lock we are just adding unnecessary contention on
> the lock, which can become visible for workloads that mix renames with
> fsyncs, writes for files opened with O_SYNC and unlink operations (if the
> inode or its parent were fsynced before in the current transaction).
> 
> So just remove the lock and unlock of the subvolume's log_mutex at
> btrfs_pin_log_trans().
> 
> Using dbench, which mixes different types of operations that end up taking
> that mutex (fsyncs, renames, unlinks and writes into files opened with
> O_SYNC) revealed some small gains. The following script that calls dbench
> was used:
> 
>    #!/bin/bash
> 
>    DEV=/dev/nvme0n1
>    MNT=/mnt/btrfs
>    MOUNT_OPTIONS="-o ssd -o space_cache=v2"
>    MKFS_OPTIONS="-m single -d single"
>    THREADS=32
> 
>    echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>    mkfs.btrfs -f $MKFS_OPTIONS $DEV
>    mount $MOUNT_OPTIONS $DEV $MNT
> 
>    dbench -s -t 600 -D $MNT $THREADS
> 
>    umount $MNT
> 
> The test was run on bare metal, no virtualization, on a box with 12 cores
> (Intel i7-8700), 64Gb of RAM and using a NVMe device, with a kernel
> configuration that is the default of typical distributions (debian in this
> case), without debug options enabled (kasan, kmemleak, slub debug, debug
> of page allocations, lock debugging, etc).
> 
> Results before this patch:
> 
>   Operation      Count    AvgLat    MaxLat
>   ----------------------------------------
>   NTCreateX    4410848     0.017   738.640
>   Close        3240222     0.001     0.834
>   Rename        186850     7.478  1272.476
>   Unlink        890875     0.128   785.018
>   Deltree          128     2.846    12.081
>   Mkdir             64     0.002     0.003
>   Qpathinfo    3997659     0.009    11.171
>   Qfileinfo     701307     0.001     0.478
>   Qfsinfo       733494     0.002     1.103
>   Sfileinfo     359362     0.004     3.266
>   Find         1546226     0.041     4.128
>   WriteX       2202803     7.905  1376.989
>   ReadX        6917775     0.003     3.887
>   LockX          14392     0.002     0.043
>   UnlockX        14392     0.001     0.085
>   Flush         309225     0.128  1033.936
> 
> Throughput 231.555 MB/sec (sync open)  32 clients  32 procs  max_latency=1376.993 ms
> 
> Results after this patch:
> 
> Operation      Count    AvgLat    MaxLat
>   ----------------------------------------
>   NTCreateX    4603244     0.017   232.776
>   Close        3381299     0.001     1.041
>   Rename        194871     7.251  1073.165
>   Unlink        929730     0.133   119.233
>   Deltree          128     2.871    10.199
>   Mkdir             64     0.002     0.004
>   Qpathinfo    4171343     0.009    11.317
>   Qfileinfo     731227     0.001     1.635
>   Qfsinfo       765079     0.002     3.568
>   Sfileinfo     374881     0.004     1.220
>   Find         1612964     0.041     4.675
>   WriteX       2296720     7.569  1178.204
>   ReadX        7213633     0.003     3.075
>   LockX          14976     0.002     0.076
>   UnlockX        14976     0.001     0.061
>   Flush         322635     0.102   579.505
> 
> Throughput 241.4 MB/sec (sync open)  32 clients  32 procs  max_latency=1178.207 ms
> (+4.3% throughput, -14.4% max latency)
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
