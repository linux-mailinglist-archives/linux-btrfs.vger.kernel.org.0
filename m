Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4402A8706
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 20:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbgKETYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 14:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKETYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 14:24:24 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B391C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 11:24:22 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id h15so414930qkl.13
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 11:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/KNi3rlIBNjOmqfJnRHeUhr1cnLqniWMytvEejKLIYk=;
        b=Zbw6QVmzh/3zyBbAJwYuXjPqqxtaNouJWAKs+aQ6ONqBU3uDvmz4D8C9NCXPBuWEbv
         HKeJj4B1gmFUlGKl6YVBrXMwJ2lQn2vk3CqTTpuZr/BkDOx2g53Y01SJ0Jlo7ZnoMtk0
         dBFKHwDbkaHpTap1AFtmy/zrWVB56S8c+g1Yy2C4SIpfJnM+8NSW0wdavzjAboYDIc87
         1Ev4wmGSDelbc0mVB0xjRxopO0xO7J6zQTPfP1al6T3JePpZk23IGe2OdC0d3Bi2i229
         qChqMVNOsbrreAhopppOKTeawXKHOvlYqOLhoPKD8iEONn3PQ51DRjYQNm5bOwCXNinf
         SkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/KNi3rlIBNjOmqfJnRHeUhr1cnLqniWMytvEejKLIYk=;
        b=MK+7bOaBOIzdJFW2ZKiwnMk9a6x7N7Fuo2Lgjkt6u+cFyZ+cIsVl42y1kCvGSCvb7B
         uJHeKqPfmsyeDAZ5qHsEtDAsMpkYgOj2cSbf8uJMd1KcYDS0R77tpyMPcbnGkY+odjz0
         VPWsnLC3/Ig7Vy0xDvbR6bLuhdTqX052yBi7Xfrdsv2xQByVRymxarvlgyGAwfmSaYcv
         F3lNXJCWxXSBDVt+dD/kg7erKbzPHlYSF5UBC4cywqlyoBGW1uTPYl8KgFRr3bBCQYVu
         oZdWJ83Y6Iigh4OLgXWvzKzECBnolZJPIyiKv6lxQjNBUBhy8jl3H9oc+5FekIz4ycDu
         PAGA==
X-Gm-Message-State: AOAM53295nObc1BRHK52avm58iusxwGBMyOLOOuXO7LSZFUDPTVvYYCI
        Fh16C49e7RYqbgEJgUJ43l6ppqrUd9I+S2jw
X-Google-Smtp-Source: ABdhPJz6aFG19lGXFaaY1RpyV15ir7Ok1RXhE7vLKHsG/1Py/WAnlDVSLiN9zlTL8j50FVNhsLczTQ==
X-Received: by 2002:a37:be83:: with SMTP id o125mr3710944qkf.2.1604604261182;
        Thu, 05 Nov 2020 11:24:21 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b8sm1620004qkn.133.2020.11.05.11.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 11:24:20 -0800 (PST)
Subject: Re: [PATCH 4/4] btrfs: update the number of bytes used by an inode
 atomically
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1604486892.git.fdmanana@suse.com>
 <aeebaf45f19779b8f869cc16db0bcfe8ba4dcf2d.1604486892.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <df80c13e-f42d-4074-cca7-c71ced6a789a@toxicpanda.com>
Date:   Thu, 5 Nov 2020 14:24:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <aeebaf45f19779b8f869cc16db0bcfe8ba4dcf2d.1604486892.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/4/20 6:07 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are several occasions where we do not update the inode's number of
> used bytes atomically, resulting in a concurrent stat(2) syscall to report
> a value of used blocks that does not correspond to a valid value, that is,
> a value that does not match neither what we had before the operation nor
> what we get after the operation completes.
> 
> In extreme cases it can result in stat(2) reporting zero used blocks, which
> can cause problems for some userspace tools where they can consider a file
> with a non-zero size and zero used blocks as completely sparse and skip
> reading data, as reported/discussed a long time ago in some threads like
> the following:
> 
>    https://lists.gnu.org/archive/html/bug-tar/2016-07/msg00001.html
> 
> The cases where this can happen are the following:
> 
> -> Case 1
> 
> If we do a write (buffered or direct IO) against a file region for which
> there is already an allocated extent (or multiple extents), then we have a
> short time window where we can report a number of used blocks to stat(2)
> that does not take into account the file region being overwritten. This
> short time window happens when completing the ordered extent(s).
> 
> This happens because when we drop the extents in the write range we
> decrement the inode's number of bytes and later on when we insert the new
> extent(s) we increment the number of bytes in the inode, resulting in a
> short time window where a stat(2) syscall can get an incorrect number of
> used blocks.
> 
> If we do writes that overwrite an entire file, then we have a short time
> window where we report 0 used blocks to stat(2).
> 
> Example reproducer:
> 
>    $ cat reproducer-1.sh
>    #!/bin/bash
> 
>    MNT=/mnt/sdi
>    DEV=/dev/sdi
> 
>    stat_loop()
>    {
>        trap "wait; exit" SIGTERM
>        local filepath=$1
>        local expected=$2
>        local got
> 
>        while :; do
>            got=$(stat -c %b $filepath)
>            if [ $got -ne $expected ]; then
>               echo -n "ERROR: unexpected used blocks"
>               echo " (got: $got expected: $expected)"
>            fi
>        done
>    }
> 
>    mkfs.btrfs -f $DEV > /dev/null
>    # mkfs.xfs -f $DEV > /dev/null
>    # mkfs.ext4 -F $DEV > /dev/null
>    # mkfs.f2fs -f $DEV > /dev/null
>    # mkfs.reiserfs -f $DEV > /dev/null
>    mount $DEV $MNT
> 
>    xfs_io -f -s -c "pwrite -b 64K 0 64K" $MNT/foobar >/dev/null
>    expected=$(stat -c %b $MNT/foobar)
> 
>    # Create a process to keep calling stat(2) on the file and see if the
>    # reported number of blocks used (disk space used) changes, it should
>    # not because we are not increasing the file size nor punching holes.
>    stat_loop $MNT/foobar $expected &
>    loop_pid=$!
> 
>    for ((i = 0; i < 50000; i++)); do
>        xfs_io -s -c "pwrite -b 64K 0 64K" $MNT/foobar >/dev/null
>    done
> 
>    kill $loop_pid &> /dev/null
>    wait
> 
>    umount $DEV
> 
>    $ ./reproducer-1.sh
>    ERROR: unexpected used blocks (got: 0 expected: 128)
>    ERROR: unexpected used blocks (got: 0 expected: 128)
>    (...)
> 
> Note that since this is a short time window where the race can happen, the
> reproducer may not be able to always trigger the bug in one run, or it may
> trigger it multiple times.
> 
> -> Case 2
> 
> If we do a buffered write against a file region that does not have any
> allocated extents, like a hole or beyond eof, then during ordered extent
> completion we have a short time window where a concurrent stat(2) syscall
> can report a number of used blocks that does not correspond to the value
> before or after the write operation, a value that is actually larger than
> the value after the write completes.
> 
> This happens because once we start a buffered write into an unallocated
> file range we increment the inode's 'new_delalloc_bytes', to make sure
> any stat(2) call gets a correct used blocks value before delalloc is
> flushed and completes. However at ordered extent completion, after we
> inserted the new extent, we increment the inode's number of bytes used
> with the size of the new extent, and only later, when clearing the range
> in the inode's iotree, we decrement the inode's 'new_delalloc_bytes'
> counter with the size of the extent. So this results in a short time
> window where a concurrent stat(2) syscall can report a number of used
> blocks that accounts for the new extent twice.
> 
> Example reproducer:
> 
>    $ cat reproducer-2.sh
>    #!/bin/bash
> 
>    MNT=/mnt/sdi
>    DEV=/dev/sdi
> 
>    stat_loop()
>    {
>        trap "wait; exit" SIGTERM
>        local filepath=$1
>        local expected=$2
>        local got
> 
>        while :; do
>            got=$(stat -c %b $filepath)
>            if [ $got -ne $expected ]; then
>                echo -n "ERROR: unexpected used blocks"
>                echo " (got: $got expected: $expected)"
>            fi
>        done
>    }
> 
>    mkfs.btrfs -f $DEV > /dev/null
>    # mkfs.xfs -f $DEV > /dev/null
>    # mkfs.ext4 -F $DEV > /dev/null
>    # mkfs.f2fs -f $DEV > /dev/null
>    # mkfs.reiserfs -f $DEV > /dev/null
>    mount $DEV $MNT
> 
>    touch $MNT/foobar
>    write_size=$((64 * 1024))
>    for ((i = 0; i < 16384; i++)); do
>       offset=$(($i * $write_size))
>       xfs_io -c "pwrite -S 0xab $offset $write_size" $MNT/foobar >/dev/null
>       blocks_used=$(stat -c %b $MNT/foobar)
> 
>       # Fsync the file to trigger writeback and keep calling stat(2) on it
>       # to see if the number of blocks used changes.
>       stat_loop $MNT/foobar $blocks_used &
>       loop_pid=$!
>       xfs_io -c "fsync" $MNT/foobar
> 
>       kill $loop_pid &> /dev/null
>       wait $loop_pid
>    done
> 
>    umount $DEV
> 
>    $ ./reproducer-2.sh
>    ERROR: unexpected used blocks (got: 265472 expected: 265344)
>    ERROR: unexpected used blocks (got: 284032 expected: 283904)
>    (...)
> 
> Note that since this is a short time window where the race can happen, the
> reproducer may not be able to always trigger the bug in one run, or it may
> trigger it multiple times.
> 
> -> Case 3
> 
> Another case where such problems happen is during other operations that
> replace extents in a file range with other extents. Those operations are
> extent cloning, deduplication and fallocate's zero range operation.
> 
> The cause of the problem is similar to the first case. When we drop the
> extents from a range, we decrement the inode's number of bytes, and later
> on, after inserting the new extents we increment it. Since this is not
> done atomically, a concurrent stat(2) call can see and return a number of
> used blocks that is smaller than it should be, does not match the number
> of used blocks before or after the clone/deduplication/zero operation.
> 
> Like for the first case, when doing a clone, deduplication or zero range
> operation against an entire file, we end up having a time window where we
> can report 0 used blocks to a stat(2) call.
> 
> Example reproducer:
> 
>    $ cat reproducer-3.sh
>    #!/bin/bash
> 
>    MNT=/mnt/sdi
>    DEV=/dev/sdi
> 
>    mkfs.btrfs -f $DEV > /dev/null
>    # mkfs.xfs -f -m reflink=1 $DEV > /dev/null
>    mount $DEV $MNT
> 
>    extent_size=$((64 * 1024))
>    num_extents=16384
>    file_size=$(($extent_size * $num_extents))
> 
>    # File foo has many small extents.
>    xfs_io -f -s -c "pwrite -S 0xab -b $extent_size 0 $file_size" $MNT/foo \
>        > /dev/null
>    # File bar has much less extents and has exactly the same data as foo.
>    xfs_io -f -c "pwrite -S 0xab 0 $file_size" $MNT/bar > /dev/null
> 
>    expected=$(stat -c %b $MNT/foo)
> 
>    # Now deduplicate bar into foo. While the deduplication is in progres,
>    # the number of used blocks/file size reported by stat should not change
>    xfs_io -c "dedupe $MNT/bar 0 0 $file_size" $MNT/foo > /dev/null  &
>    dedupe_pid=$!
>    while [ -n "$(ps -p $dedupe_pid -o pid=)" ]; do
>        used=$(stat -c %b $MNT/foo)
>        if [ $used -ne $expected ]; then
>            echo "Unexpected blocks used: $used (expected: $expected)"
>        fi
>    done
> 
>    umount $DEV
> 
>    $ ./reproducer-3.sh
>    Unexpected blocks used: 2076800 (expected: 2097152)
>    Unexpected blocks used: 2097024 (expected: 2097152)
>    Unexpected blocks used: 2079872 (expected: 2097152)
>    (...)
> 
> Note that since this is a short time window where the race can happen, the
> reproducer may not be able to always trigger the bug in one run, or it may
> trigger it multiple times.
> 
> So fix this by:
> 
> 1) Making btrfs_drop_extents() not decrement the vfs inode's number of
>     bytes, and instead return the number of bytes;
> 
> 2) Making any code that drops extents and adds new extents update the
>     inode's number of bytes atomically, while holding the btrfs inode's
>     spinlock, which is also used by the stat(2) callback to get the inode's
>     number of bytes;
> 
> 3) For ranges in the inode's iotree that are marked as 'delalloc new',
>     corresponding to previously unallocated ranges, increment the inode's
>     number of bytes when clearing the 'delalloc new' bit from the range,
>     in the same critical section that decrements the inode's
>     'new_delalloc_bytes' counter, delimited by the btrfs inode's spinlock.
> 
> An alternative would be to have btrfs_getattr() wait for any IO (ordered
> extents in progress) and locking the whole range (0 to (u64)-1) while it
> it computes the number of blocks used. But that would mean blocking
> stat(2), which is a very used syscall and expected to be fast, waiting
> for writes, clone/dedupe, fallocate, page reads, fiemap, etc.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
