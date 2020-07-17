Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB331223F8E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGQP0n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 11:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgGQP0n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 11:26:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F186FC0619D2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 08:26:42 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id r22so9049169qke.13
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pZySdq8QygAVSHuN7NoaldhIiRM+udeNAurgAxhK0EE=;
        b=LYlwHsnNoKbwywTw4jLCLtHsQF+czesRiIq42qZiv8fKL/PP42ovaGJU89toOzVcD1
         JmTY/2oEGzMK903EPed2s/ZDNBYUYaS9Mk1mETJ5jCx3mmfjzA9tzs+n2UqhTTp32T4p
         KEpIp9Z+2rCvA1UfrxWsVNLwLgLXuDcns4fcrgso57N96+4m71C2jC5Ut706Dk22ZN5m
         Xkd2exN2b6p2KqVUH8CW3C7is5TcjZyD4NebB5rlVqcoNTVw02t4DEUaZfILufn7l3Mp
         1pnOQWa7qyJvIcshakXamTQDpCYy82B2Nhr97f04ZtvzKpQA6GYYCVx4Y10PYVVTbBjQ
         p6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pZySdq8QygAVSHuN7NoaldhIiRM+udeNAurgAxhK0EE=;
        b=n4arA/wD8+pdoQhosApVFU/GkRnb7sZaukSHcKNfndOZSK0r+YVckQmT84RgSSq1yB
         pzz1isl/GWDUvaf1eD2Ytx6mRrYCZuEAlmHbyOUEtbCHZj2aFPojU69EoYrX3Nushf1y
         dOn0Y+jDS/2+UuTObEn08NNAOT0Y5RaNmz9R1RsZJbEqT5G6/5bRnlFWAHGmB2gBzw97
         jPrki2TlkuDMe4D0Nn3ulkfKmjNfjPIgsw0LHCCqo2sOBeRQK6VEIRKYB7HaJWJMKxq0
         j8pQtxdMfSzGoFqLu9QXXmWvI8qV8pEwJ82keKQ3N/7ElkkyZe3+CxIj9Uc1+0tU3SUf
         EouA==
X-Gm-Message-State: AOAM5317mg7MWsCfCPqaiBYmBYvQasCpzLmTw2Mg3A5Ef1LZYtMLFG0W
        M95x8uIMQQ0KftZsixgA+on1pk+adxITrw==
X-Google-Smtp-Source: ABdhPJwZ/GWMkexJNlerDTDVK9vCIX+cqIna2+mQHb/Y2MegY4GDHN2L6ypMzGnZbcMHCouK+yqNjA==
X-Received: by 2002:a37:6150:: with SMTP id v77mr9596415qkb.173.1594999601568;
        Fri, 17 Jul 2020 08:26:41 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w18sm10711749qtn.3.2020.07.17.08.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 08:26:40 -0700 (PDT)
Subject: Re: [PATCH] btrfs: reduce contention on log trees when logging
 checksums
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200715113043.3192206-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f82d7a79-5be8-339e-2a8a-2f19c585edae@toxicpanda.com>
Date:   Fri, 17 Jul 2020 11:26:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715113043.3192206-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/15/20 7:30 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The possibility of extents being shared (through clone and deduplication
> operations) requires special care when logging data checksums, to avoid
> having a log tree with different checksum items that cover ranges which
> overlap (which resulted in missing checksums after replaying a log tree).
> Such problems were fixed in the past by the following commits:
> 
> commit 40e046acbd2f ("Btrfs: fix missing data checksums after replaying a
>                        log tree")
> 
> commit e289f03ea79b ("btrfs: fix corrupt log due to concurrent fsync of
>                        inodes with shared extents")
> 
> Test case generic/588 exercises the scenario solved by the first commit
> (purely sequential and deterministic) while test case generic/457 often
> triggered the case fixed by the second commit (not deterministic, requires
> specific timings under concurrency).
> 
> The problems were addressed by deleting, from the log tree, any existing
> checksums before logging the new ones. And also by doing the deletion and
> logging of the cheksums while locking the checksum range in an extent io
> tree (root->log_csum_range), to deal with the case where we have concurrent
> fsyncs against files with shared extents.
> 
> That however causes more contention on the leaves of a log tree where we
> store checksums (and all the nodes in the paths leading to them), even
> when we do not have shared extents, or all the shared extents were created
> by past transactions. It also adds a bit of contention on the spin lock of
> the log_csums_range extent io tree of the log root.
> 
> This change adds a 'last_reflink_trans' field to the inode to keep track
> of the last transaction where a new extent was shared between inodes
> (through clone and deduplication operations). It is updated for both the
> source and destination inodes of reflink operations whenever a new extent
> (created in the current transaction) becomes shared by the inodes. This
> field is kept in memory only, not persisted in the inode item, similar
> to other existing fields (last_unlink_trans, logged_trans).
> 
> When logging checksums for an extent, if the value of 'last_reflink_trans'
> is smaller then the current transaction's generation/id, we skip locking
> the extent range and deletion of checksums from the log tree, since we
> know we do not have new shared extents. This reduces contention on the
> log tree's leaves where checksums are stored.
> 
> The following script, which uses fio, was used to measure the impact of
> this change:
> 
>    $ cat test-fsync.sh
>    #!/bin/bash
> 
>    DEV=/dev/sdk
>    MNT=/mnt/sdk
>    MOUNT_OPTIONS="-o ssd"
>    MKFS_OPTIONS="-d single -m single"
> 
>    if [ $# -ne 3 ]; then
>        echo "Use $0 NUM_JOBS FILE_SIZE FSYNC_FREQ"
>        exit 1
>    fi
> 
>    NUM_JOBS=$1
>    FILE_SIZE=$2
>    FSYNC_FREQ=$3
> 
>    cat <<EOF > /tmp/fio-job.ini
>    [writers]
>    rw=write
>    fsync=$FSYNC_FREQ
>    fallocate=none
>    group_reporting=1
>    direct=0
>    bs=64k
>    ioengine=sync
>    size=$FILE_SIZE
>    directory=$MNT
>    numjobs=$NUM_JOBS
>    EOF
> 
>    echo "Using config:"
>    echo
>    cat /tmp/fio-job.ini
>    echo
> 
>    mkfs.btrfs -f $MKFS_OPTIONS $DEV
>    mount $MOUNT_OPTIONS $DEV $MNT
>    fio /tmp/fio-job.ini
>    umount $MNT
> 
> The tests were performed for different numbers of jobs, file sizes and
> fsync frequency. A qemu VM using kvm was used, with 8 cores (the host has
> 12 cores, with cpu governance set to performance mode on all cores), 16Gb
> of ram (the host has 64Gb) and using a NVMe device directly (without an
> intermediary filesystem in the host). While running the tests, the host
> was not used for anything else, to avoid disturbing the tests.
> 
> The obtained results were the following (the last line of fio's output was
> pasted). Starting with 16 jobs is where a significant difference is
> observable in this particular setup and hardware (differences highlighted
> below). The very small differences for tests with less than 16 jobs are
> possibly just noise and random.
> 
>      **** 1 job, file size 1G, fsync frequency 1 ****
> 
> before this change:
> 
> WRITE: bw=23.8MiB/s (24.9MB/s), 23.8MiB/s-23.8MiB/s (24.9MB/s-24.9MB/s), io=1024MiB (1074MB), run=43075-43075msec
> 
> after this change:
> 
> WRITE: bw=24.4MiB/s (25.6MB/s), 24.4MiB/s-24.4MiB/s (25.6MB/s-25.6MB/s), io=1024MiB (1074MB), run=41938-41938msec
> 
>      **** 2 jobs, file size 1G, fsync frequency 1 ****
> 
> before this change:
> 
> WRITE: bw=37.7MiB/s (39.5MB/s), 37.7MiB/s-37.7MiB/s (39.5MB/s-39.5MB/s), io=2048MiB (2147MB), run=54351-54351msec
> 
> after this change:
> 
> WRITE: bw=37.7MiB/s (39.5MB/s), 37.6MiB/s-37.6MiB/s (39.5MB/s-39.5MB/s), io=2048MiB (2147MB), run=54428-54428msec
> 
>      **** 4 jobs, file size 1G, fsync frequency 1 ****
> 
> before this change:
> 
> WRITE: bw=67.5MiB/s (70.8MB/s), 67.5MiB/s-67.5MiB/s (70.8MB/s-70.8MB/s), io=4096MiB (4295MB), run=60669-60669msec
> 
> after this change:
> 
> WRITE: bw=68.6MiB/s (71.0MB/s), 68.6MiB/s-68.6MiB/s (71.0MB/s-71.0MB/s), io=4096MiB (4295MB), run=59678-59678msec
> 
>      **** 8 jobs, file size 1G, fsync frequency 1 ****
> 
> before this change:
> 
> WRITE: bw=128MiB/s (134MB/s), 128MiB/s-128MiB/s (134MB/s-134MB/s), io=8192MiB (8590MB), run=64048-64048msec
> 
> after this change:
> 
> WRITE: bw=129MiB/s (135MB/s), 129MiB/s-129MiB/s (135MB/s-135MB/s), io=8192MiB (8590MB), run=63405-63405msec
> 
>      **** 16 jobs, file size 1G, fsync frequency 1 ****
> 
> before this change:
> 
> WRITE: bw=78.5MiB/s (82.3MB/s), 78.5MiB/s-78.5MiB/s (82.3MB/s-82.3MB/s), io=16.0GiB (17.2GB), run=208676-208676msec
> 
> after this change:
> 
> WRITE: bw=110MiB/s (115MB/s), 110MiB/s-110MiB/s (115MB/s-115MB/s), io=16.0GiB (17.2GB), run=149295-149295msec
> (+40.1% throughput, -28.5% runtime)
> 
>      **** 32 jobs, file size 1G, fsync frequency 1 ****
> 
> before this change:
> 
> WRITE: bw=58.8MiB/s (61.7MB/s), 58.8MiB/s-58.8MiB/s (61.7MB/s-61.7MB/s), io=32.0GiB (34.4GB), run=557134-557134msec
> 
> after this change:
> 
> WRITE: bw=76.1MiB/s (79.8MB/s), 76.1MiB/s-76.1MiB/s (79.8MB/s-79.8MB/s), io=32.0GiB (34.4GB), run=430550-430550msec
> (+29.4% throughput, -22.7% runtime)
> 
>      **** 64 jobs, file size 512M, fsync frequency 1 ****
> 
> before this change:
> 
> WRITE: bw=65.8MiB/s (68.0MB/s), 65.8MiB/s-65.8MiB/s (68.0MB/s-68.0MB/s), io=32.0GiB (34.4GB), run=498055-498055msec
> 
> after this change:
> 
> WRITE: bw=85.1MiB/s (89.2MB/s), 85.1MiB/s-85.1MiB/s (89.2MB/s-89.2MB/s), io=32.0GiB (34.4GB), run=385116-385116msec
> (+29.3% throughput, -22.7% runtime)
> 
>      **** 128 jobs, file size 256M, fsync frequency 1 ****
> 
> before this change:
> 
> WRITE: bw=54.7MiB/s (57.3MB/s), 54.7MiB/s-54.7MiB/s (57.3MB/s-57.3MB/s), io=32.0GiB (34.4GB), run=599373-599373msec
> 
> after this change:
> 
> WRITE: bw=121MiB/s (126MB/s), 121MiB/s-121MiB/s (126MB/s-126MB/s), io=32.0GiB (34.4GB), run=271907-271907msec
> (+121.2% throughput, -54.6% runtime)
> 
>      **** 256 jobs, file size 256M, fsync frequency 1 ****
> 
> before this change:
> 
> WRITE: bw=69.2MiB/s (72.5MB/s), 69.2MiB/s-69.2MiB/s (72.5MB/s-72.5MB/s), io=64.0GiB (68.7GB), run=947536-947536msec
> 
> after this change:
> 
> WRITE: bw=121MiB/s (127MB/s), 121MiB/s-121MiB/s (127MB/s-127MB/s), io=64.0GiB (68.7GB), run=541916-541916msec
> (+74.9% throughput, -42.8% runtime)
> 
>      **** 512 jobs, file size 128M, fsync frequency 1 ****
> 
> before this change:
> 
> WRITE: bw=85.4MiB/s (89.5MB/s), 85.4MiB/s-85.4MiB/s (89.5MB/s-89.5MB/s), io=64.0GiB (68.7GB), run=767734-767734msec
> 
> after this change:
> 
> WRITE: bw=141MiB/s (147MB/s), 141MiB/s-141MiB/s (147MB/s-147MB/s), io=64.0GiB (68.7GB), run=466022-466022msec
> (+65.1% throughput, -39.3% runtime)
> 
>      **** 1024 jobs, file size 128M, fsync frequency 1 ****
> 
> before this change:
> 
> WRITE: bw=115MiB/s (120MB/s), 115MiB/s-115MiB/s (120MB/s-120MB/s), io=128GiB (137GB), run=1143775-1143775msec
> 
> after this change:
> 
> WRITE: bw=171MiB/s (180MB/s), 171MiB/s-171MiB/s (180MB/s-180MB/s), io=128GiB (137GB), run=764843-764843msec
> (+48.7% throughput, -33.1% runtime)
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Looks good,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
