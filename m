Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3012F1A70
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 17:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbhAKQHI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 11:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbhAKQHI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 11:07:08 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC049C0617A2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 08:06:27 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id az16so7622297qvb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 08:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=K2bTH5mCENs+4FkuNWNUsITYwpSey1GTum68JgDLYAY=;
        b=DYn9wUt10fpwo3sHA1OYEQ5QY3U2gORh+msYn36YgxostfbbImezKewEhm6xBjnzej
         UcB6HhW/yQUobMd4ZCcUlnjsx4JdSmc48Kaqstr/6Rs7peZ+vWhYczQplX+WT1RyxlXX
         1nN/5b76rAR1lTcLtCWIUKilrYXAENB9sSP8NPU3grKj8YjjvBkbACog0u+jgtK6Es9n
         POboZbprXFg6x36EiveVssv2jr0f4js0MLTeIdsUZJJKXpQlA1MYEqJiRzFQB/7Xp5CQ
         AvoOEz47wg5bh5mYNqsmzy8tdBTRmJzgEl/swTyu+xIkoMU960z5mWb410fhpQ/y0C+Z
         kYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K2bTH5mCENs+4FkuNWNUsITYwpSey1GTum68JgDLYAY=;
        b=lOpjn4hvOGT9/Lr8X3yFGPwILBnT05QxELoK82HpTqU7RA1/ZgNff6DVhzp9yrlnLG
         4WlAdbJ09awF5Vs6rka3wIf4o2lAT0jnlLfFjziADXNTwRms1qUAiIHn1JOFyuXSVhl+
         PWJnMBTF42hM2UVni3IkZkIRbiz3i5RdvkG6vhFzxBf2CZZLI6GWYKInuUZpDaVhExCQ
         bbELTfZMBCOJHUpBdlGDK1GnVGd2yMO0Eip4sxY7clqXU1JyNyy7g5lZfne1AFO+lhUo
         7L9RQ+bWqEx+Ufgy/63Prdn51P60dc8g0Jup84St5d+NdhJx/5+QT6lKUgObuZmXgF33
         M9Hw==
X-Gm-Message-State: AOAM531VPe71RPfRMjnrGQzi97ovcNdDE92j4biH1Fn0m+4+ns3fIFil
        Qw7weyyjl/OHsYW7kBVYkNlCCsXVlVEXFLFX
X-Google-Smtp-Source: ABdhPJyFUz8M80HBfUzRKt/vDqLisxhXeLgwRua7SUcf+nrbRuPVudSrrXvY6zep+iA0Zjy9Ke1GjQ==
X-Received: by 2002:a0c:c688:: with SMTP id d8mr377643qvj.8.1610381186573;
        Mon, 11 Jan 2021 08:06:26 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q20sm109640qkj.49.2021.01.11.08.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 08:06:25 -0800 (PST)
Subject: Re: [PATCH] btrfs: send, fix invalid clone operations when cloning
 from the same file and root
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <900493c40f7edbd42fe861ccd9a68851ea952499.1610363502.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <83c11071-2e0c-ef9d-4e6c-072b9027b166@toxicpanda.com>
Date:   Mon, 11 Jan 2021 11:06:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <900493c40f7edbd42fe861ccd9a68851ea952499.1610363502.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/11/21 6:41 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When an incremental send finds an extent that is shared, it checks which
> file extent items in the range refer to that extent, and for those it
> emits clone operations, while for others it emits regular write operations
> to avoid corruption at the destination (as described and fixed by commit
> d906d49fc5f4 ("Btrfs: send, fix file corruption due to incorrect cloning
> operations")).
> 
> However when the root we are cloning from is the send root, we are cloning
> from the inode currently being processed and the source file range has
> several extent items that partially point to the desired extent, with an
> offset smaller than the offset in the file extent item for the range we
> want to clone into, it can cause the algorithm to issue a clone operation
> that starts at the current eof of the file being processed in the receiver
> side, in which case the receiver will fail, with -EINVAL, when attempting
> to execute the clone operation.
> 
> Example reproducer:
> 
>    $ cat test-send-clone.sh
>    #!/bin/bash
> 
>    DEV=/dev/sdi
>    MNT=/mnt/sdi
> 
>    mkfs.btrfs -f $DEV >/dev/null
>    mount $DEV $MNT
> 
>    # Create our test file with a single and large extent (1M) and with
>    # different content for different file ranges that will be reflinked
>    # later.
>    xfs_io -f \
>           -c "pwrite -S 0xab 0 128K" \
>           -c "pwrite -S 0xcd 128K 128K" \
>           -c "pwrite -S 0xef 256K 256K" \
>           -c "pwrite -S 0x1a 512K 512K" \
>           $MNT/foobar
> 
>    btrfs subvolume snapshot -r $MNT $MNT/snap1
>    btrfs send -f /tmp/snap1.send $MNT/snap1
> 
>    # Now do a series of changes to our file such that we end up with
>    # different parts of the extent reflinked into different file offsets
>    # and we overwrite a large part of the extent too, so no file extent
>    # items refer to that part that was overwritten. This used to confure
>    # the algorithm used by the kernel to figure out which file ranges to
>    # clone, making it attempt to clone from a source range starting at
>    # the current eof of the file, resulting in the receiver to fail since
>    # it is an invalid clone operation.
>    #
>    xfs_io -c "reflink $MNT/foobar 64K 1M 960K" \
>           -c "reflink $MNT/foobar 0K 512K 256K" \
>           -c "reflink $MNT/foobar 512K 128K 256K" \
>           -c "pwrite -S 0x73 384K 640K" \
>           $MNT/foobar
> 
>    btrfs subvolume snapshot -r $MNT $MNT/snap2
>    btrfs send -f /tmp/snap2.send -p $MNT/snap1 $MNT/snap2
> 
>    echo -e "\nFile digest in the original filesystem:"
>    md5sum $MNT/snap2/foobar
> 
>    # Now unmount the filesystem, create a new one, mount it and try to
>    # apply both send streams to recreate both snapshots.
>    umount $DEV
> 
>    mkfs.btrfs -f $DEV >/dev/null
>    mount $DEV $MNT
> 
>    btrfs receive -f /tmp/snap1.send $MNT
>    btrfs receive -f /tmp/snap2.send $MNT
> 
>    # Must match what we got in the original filesystem of course.
>    echo -e "\nFile digest in the new filesystem:"
>    md5sum $MNT/snap2/foobar
> 
>    umount $MNT
> 
> When running the reproducer, the incremental send operation fails due to
> an invalid clone operation:
> 
>    $ ./test-send-clone.sh
>    wrote 131072/131072 bytes at offset 0
>    128 KiB, 32 ops; 0.0015 sec (80.906 MiB/sec and 20711.9741 ops/sec)
>    wrote 131072/131072 bytes at offset 131072
>    128 KiB, 32 ops; 0.0013 sec (90.514 MiB/sec and 23171.6148 ops/sec)
>    wrote 262144/262144 bytes at offset 262144
>    256 KiB, 64 ops; 0.0025 sec (98.270 MiB/sec and 25157.2327 ops/sec)
>    wrote 524288/524288 bytes at offset 524288
>    512 KiB, 128 ops; 0.0052 sec (95.730 MiB/sec and 24506.9883 ops/sec)
>    Create a readonly snapshot of '/mnt/sdi' in '/mnt/sdi/snap1'
>    At subvol /mnt/sdi/snap1
>    linked 983040/983040 bytes at offset 1048576
>    960 KiB, 1 ops; 0.0006 sec (1.419 GiB/sec and 1550.3876 ops/sec)
>    linked 262144/262144 bytes at offset 524288
>    256 KiB, 1 ops; 0.0020 sec (120.192 MiB/sec and 480.7692 ops/sec)
>    linked 262144/262144 bytes at offset 131072
>    256 KiB, 1 ops; 0.0018 sec (133.833 MiB/sec and 535.3319 ops/sec)
>    wrote 655360/655360 bytes at offset 393216
>    640 KiB, 160 ops; 0.0093 sec (66.781 MiB/sec and 17095.8436 ops/sec)
>    Create a readonly snapshot of '/mnt/sdi' in '/mnt/sdi/snap2'
>    At subvol /mnt/sdi/snap2
> 
>    File digest in the original filesystem:
>    9c13c61cb0b9f5abf45344375cb04dfa  /mnt/sdi/snap2/foobar
>    At subvol snap1
>    At snapshot snap2
>    ERROR: failed to clone extents to foobar: Invalid argument
> 
>    File digest in the new filesystem:
>    132f0396da8f48d2e667196bff882cfc  /mnt/sdi/snap2/foobar
> 
> The clone operation is invalid because its source range starts at the
> current eof of the file in the receiver, causing the receiver to get
> an -EINVAL error from the clone operation when attempting it.
> 
> For the example above, what happens is the following:
> 
> 1) When processing the extent at file offset 1M, the algorithm checks that
>     the extent is shared and can be (fully or partially) found at file
>     offset 0.
> 
>     At this point the file has a size (and eof) of 1M at the receiver;
> 
> 2) It finds that our extent item at file offset 1M has a data offset of
>     64K and, since the file extent item at file offset 0 has a data offset
>     of 0, it issues a clone operation, from the same file and root, that
>     has a source range offset of 64K, destination offset of 1M and a length
>     of 64K, since the extent item at file offset 0 refers only to the first
>     128K of the shared extent.
> 
>     After this clone operation, the file size (and eof) at the receiver is
>     increased from 1M to 1088K (1M + 64K);
> 
> 3) Now there's still 896K (960K - 64K) of data left to clone or write, so
>     it checks for the next file extent item, which starts at file offset
>     128K. This file extent item has a data offset of 0 and a length of
>     256K, so a clone operation with a source range offset of 256K, a
>     destination offset of 1088K (1M + 64K) and length of 128K is issued.
> 
>     After this operation the file size (and eof) at the receiver increases
>     from 1088K to 1216K (1088K + 128K);
> 
> 4) Now there's still 768K (896K - 128K) of data left to clone or write, so
>     it checks for the next file extent item, located at file offset 384K.
>     This file extent item points to a different extent, not the one we want
>     to clone, with a length of 640K. So we issue a write operation into the
>     file range 1216K (1088K + 128K, end of the last clone operation), with
>     a length of 640K and with a data matching the one we can find for that
>     range in send root.
> 
>     After this operation, the file size (and eof) at the receiver increases
>     from 1216K to 1856K (1216K + 640K);
> 
> 5) Now there's still 128K (768K - 640K) of data left to clone or write, so
>     we look into the file extent item, which is for file offset 1M and it
>     points to the extent we want to clone, with a data offset of 64K and a
>     length of 960K.
> 
>     However this matches the file offset we started with, the start of the
>     range to clone into. So we can't for sure find any file extent item
>     from here onwards with the rest of the data we want to clone, yet we
>     proceed and since the file extent item points to the shared extent,
>     with a data offset of 64K, we issue a clone operation with a source
>     range starting at file offset 1856K, which matches the file extent
>     item's offset, 1M, plus the amount of data cloned and written so far,
>     which is 64K (step 2) + 128K (step 3) + 640K (step 4). This clone
>     operation is invalid since the source range offset matches the current
>     eof of the file in the receiver. We should have stopped looking for
>     extents to clone at this point and instead fallback to write, which
>     would simply the contain the data in the file range from 1856K to
>     1856K + 128K.
> 
> So fix this by stopping the loop that looks for file ranges to clone at
> clone_range() when we reach the current eof of the file being processed,
> if we are cloning from the same file and using the send root as the clone
> root. This ensures any data not yet cloned will be sent to the receiver
> through a write operation.
> 
> A test case for fstests will follow soon.
> 
> Reported-by: Massimo B. <massimo.b@gmx.net>
> Link: https://lore.kernel.org/linux-btrfs/6ae34776e85912960a253a8327068a892998e685.camel@gmx.net/
> Fixes: 11f2069c113e ("Btrfs: send, allow clone operations within the same file")
> CC: stable@vger.kernel.org # 5.5+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Read the commit log like 9 times, then read the comment and understood what was 
happening.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
