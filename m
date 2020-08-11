Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753CB241FB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 20:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgHKSdV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 14:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgHKSdU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 14:33:20 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5397FC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:33:20 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s16so10184269qtn.7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SXG+E6Ebf+H8MF0fu9S4M8BFoyPeeUWeqhcieDlOe8g=;
        b=q1vHhhb3d9jj+rqUhl6SsG0s1Rw4hAwKK3ZtbZQE7O4RCVmw1grlODn9Ez0oPSR4m8
         IEG1y/oMxgH7+1STsBy6P7jWchqtbdi5FXVRxgZ6ek46jaZkoBcIB52Y3XtPeftNurbO
         fPVNqbxoj1kAprM4hKcMNPHIWia5T61RrmyM/z1FK/vrvo4kN/gbBBFknsNf3fD6AmBa
         ECOPwgBZpWCLrAfdaUuBYAFW94Vb+WZtArjwM5hiegmVQqpM/+AyBqPMXwUC0fujoFSS
         i0zFExgolXoc+m5ElXx4Z6MXRibr90d15Qw9Z+LeJ9s95WIocRwuG+MXLLGDqVjTLYlg
         LgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SXG+E6Ebf+H8MF0fu9S4M8BFoyPeeUWeqhcieDlOe8g=;
        b=U524iMuXKNvF79E6IgiMTNhsHIQABkVN20otL368HvptfDd7NHni+yE/qNCQzbwVd+
         92wxOCcHXQLpB69kigOcwSIE5y6P89/6WrdDWJdE/3E0DK7lSRJuXm+6NdctzGMYKRRW
         xwMY4HY/aCRALwEJXbP0yEofwrF12lRd8/ZXfTson3b8Wk3ep9rBSF/RG6Law0X559YW
         LbJsvoT1YDNAQZvWDBuNhvkZg/JKyXz2hdY/ILctfCU5IizarmsGWK39w+XkXCfLU+c9
         sixjX5I2noYJDE/wPG8s6TBjJ1ootQ61pzYZ8+UkSWwacU/YSJbRqtUYpchiAD0EAFdb
         HgCA==
X-Gm-Message-State: AOAM530gFmwu8mo1IncjdQyAeG8uqlqH8B5A1DUgCZy8nu4YK9vOEZsv
        LhO4qmDDaJMPPpcis8/r28m2pcwjlwn8pg==
X-Google-Smtp-Source: ABdhPJzOnhhoA16QAift/zklA4RbIGBkTym6OiyyuLCvlS8s9g8F9vsz0ks197pkQUW85RNON7ecxg==
X-Received: by 2002:ac8:1c82:: with SMTP id f2mr2563334qtl.305.1597170799172;
        Tue, 11 Aug 2020 11:33:19 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i30sm21854958qte.30.2020.08.11.11.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 11:33:18 -0700 (PDT)
Subject: Re: [PATCH 2/3] btrfs: do not commit logs and transactions during
 link and rename operations
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200811114348.692115-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <32fd7959-4ea4-6930-74e5-e57c30a51733@toxicpanda.com>
Date:   Tue, 11 Aug 2020 14:33:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811114348.692115-1-fdmanana@kernel.org>
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
> Since commit d4682ba03ef618 ("Btrfs: sync log after logging new name") we
> started to commit logs, and fallback to transaction commits when we failed
> to log the new names or commit the logs, after link and rename operations
> when the target inodes (or their parents) were previously logged in the
> current transaction. This was to avoid losing directories despite an
> explicit fsync on them when they are ancestors of some inode that got a
> new named logged, due to a link or rename operation. However that adds the
> cost of starting IO and waiting for it to complete, which can cause higher
> latencies for applications.
> 
> Instead of doing that, just make sure that when we log a new name for an
> inode we don't mark any of its ancestors as logged, so that if any one
> does an fsync against any of them, without doing any other change on them,
> the fsync commits the log. This way we only pay the cost of a log commit
> (or a transaction commit if something goes wrong or a new block group was
> created) if the application explicitly asks to fsync any of the parent
> directories.
> 
> Using dbench, which mixes several filesystems operations including renames,
> revealed some significant latency gains. The following script that uses
> dbench was used to test this:
> 
>    #!/bin/bash
> 
>    DEV=/dev/nvme0n1
>    MNT=/mnt/btrfs
>    MOUNT_OPTIONS="-o ssd -o space_cache=v2"
>    MKFS_OPTIONS="-m single -d single"
>    THREADS=16
> 
>    echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>    mkfs.btrfs -f $MKFS_OPTIONS $DEV
>    mount $MOUNT_OPTIONS $DEV $MNT
> 
>    dbench -t 300 -D $MNT $THREADS
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
>   NTCreateX    10750455     0.011   155.088
>   Close        7896674     0.001     0.243
>   Rename        455222     2.158  1101.947
>   Unlink       2171189     0.067   121.638
>   Deltree          256     2.425     7.816
>   Mkdir            128     0.002     0.003
>   Qpathinfo    9744323     0.006    21.370
>   Qfileinfo    1707092     0.001     0.146
>   Qfsinfo      1786756     0.001    11.228
>   Sfileinfo     875612     0.003    21.263
>   Find         3767281     0.025     9.617
>   WriteX       5356924     0.011   211.390
>   ReadX        16852694     0.003    9.442
>   LockX          35008     0.002     0.119
>   UnlockX        35008     0.001     0.138
>   Flush         753458     4.252  1102.249
> 
> Throughput 1128.35 MB/sec  16 clients  16 procs  max_latency=1102.255 ms
> 
> Results after this patch:
> 
> 16 clients, after
> 
>   Operation      Count    AvgLat    MaxLat
>   ----------------------------------------
>   NTCreateX    11471098     0.012   448.281
>   Close        8426396     0.001     0.925
>   Rename        485746     0.123   267.183
>   Unlink       2316477     0.080    63.433
>   Deltree          288     2.830    11.144
>   Mkdir            144     0.003     0.010
>   Qpathinfo    10397420     0.006    10.288
>   Qfileinfo    1822039     0.001     0.169
>   Qfsinfo      1906497     0.002    14.039
>   Sfileinfo     934433     0.004     2.438
>   Find         4019879     0.026    10.200
>   WriteX       5718932     0.011   200.985
>   ReadX        17981671     0.003    10.036
>   LockX          37352     0.002     0.076
>   UnlockX        37352     0.001     0.109
>   Flush         804018     5.015   778.033
> 
> Throughput 1201.98 MB/sec  16 clients  16 procs  max_latency=778.036 ms
> (+6.5% throughput, -29.4% max latency, -75.8% rename latency)
> 
> Test case generic/498 from fstests tests the scenario that the previously
> mentioned commit fixed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Man this took me a while to grok, but I think I've got it.  The only thing is 
this patch doesn't apply to current (as of today) misc-next.  Thanks,

Josef
