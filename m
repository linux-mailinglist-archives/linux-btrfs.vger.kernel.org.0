Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B05A3CCBC0
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2019 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfJERo1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Oct 2019 13:44:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36218 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfJERo1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Oct 2019 13:44:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id j11so4699246plk.3;
        Sat, 05 Oct 2019 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+R6jKmVTU/8ai1c2Z75q8TncsQzvMvEOIpYtin0xBFI=;
        b=kjj1gq8BvQV99PxCtApiXD625iQrHfTDlV6/ty7KOR1fmpI4X2VOFzu1j/j7ai//4I
         J9dVqvDCRLI3Cv8i8FcHVqfaAlLpQi+OoeGJjrQFn7r+YYCAU7id5JtG8+ik0JEzyvil
         dYxuWK+bgepsQ6oyBHp1wpDNRj/lr4vwnyS7p6c/Q8w7dSSydVJZrI6lSSVGdrESt3jA
         aC4K62F1XqwEYDFpM5Wwa8ae6N0jxgVUpsEbkcPFybk7ibPC/uptt1JeYXWdXniCZMOS
         3WfdyX6u+Aa3fIOAVLL8dJvGDYCWli1f9/zesenVuDj6GYYZPKI+jelIbzHGzgsqn3YE
         RuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+R6jKmVTU/8ai1c2Z75q8TncsQzvMvEOIpYtin0xBFI=;
        b=AfuHSu6X4e/YQu0BQiVK/QwCSovlNMMi6O9hJxpWHkX47GLGW1ihffxk2kSrPmEkQS
         folfkZa9uO+4k0WiXs3D3yjwDk0wqv6bSJbp9O36AHKi1ZK5go9njVTrqBx8pl/wRg5e
         2/jJosLL15oSROFks0HMV2QGbeiyadvp+LGsbx6bbX1YxOnJBglM2TgZxS2DvQIe8C6/
         kfLT6kHii4qlmqx6KPzAEZ7X5oxtnTerxrHULfw2vNcHLHxAmXkJ2Wk+SlM44YlQXxJH
         xMkhXVf65kHAnQULlmt41/Ine2zzgT/iQ11YuC5dyh/Lj97QBKJMbVg8CGOYmaX8+3xF
         KkWA==
X-Gm-Message-State: APjAAAXLrsPLivy0m5TWfs6DOvTtGm2TViR5bwucJOR2LgBpRK9sCo4o
        Yp4n7ruUDmD8qUcjBsMakkU=
X-Google-Smtp-Source: APXvYqwA+R9SItGTQfSUzjOEoMvyfV0NvR9luACM+jBS6gKo/gPFkio+30ckurbDRgblwDnZAAbidg==
X-Received: by 2002:a17:902:848c:: with SMTP id c12mr19942303plo.120.1570297465913;
        Sat, 05 Oct 2019 10:44:25 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id 20sm11512153pfp.153.2019.10.05.10.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 10:44:25 -0700 (PDT)
Date:   Sun, 6 Oct 2019 01:44:19 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH][v2] btrfs/194: add a test for multi-subvolume fsyncing
Message-ID: <20191005174419.GC2622@desktop>
References: <20191002184133.21099-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002184133.21099-1-josef@toxicpanda.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 02, 2019 at 02:41:33PM -0400, Josef Bacik wrote:
> I discovered a problem in btrfs where we'd end up pointing at a block we
> hadn't written out yet.  This is triggered by a race when two different
> files on two different subvolumes fsync.  This test exercises this path
> with dm-log-writes, and then replays the log at every FUA to verify the
> file system is still mountable and the log is replayable.
> 
> This test is to verify the fix
> 
> btrfs: fix incorrect updating of log root tree
> 
> actually fixed the problem.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - added the patchname related to this test in the comments and changelog.
> - running fio makes it use 400mib of shared memory, so running 50 of them is
>   impossible on boxes that don't have hundreds of gib of RAM.  Fixed this to
>   just generate a fio config so we can run 1 fio instance with 50 threads which
>   makes it not OOM boxes with tiny amounts of RAM.
> - fixed some formatting things that Filipe pointed out.
> 
>  tests/btrfs/194     | 111 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/194.out |   2 +
>  tests/btrfs/group   |   1 +
>  3 files changed, 114 insertions(+)
>  create mode 100755 tests/btrfs/194
>  create mode 100644 tests/btrfs/194.out
> 
> diff --git a/tests/btrfs/194 b/tests/btrfs/194
> new file mode 100755
> index 00000000..b98064e2
> --- /dev/null
> +++ b/tests/btrfs/194
> @@ -0,0 +1,111 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 194
> +#
> +# Test multi subvolume fsync to test a bug where we'd end up pointing at a block
> +# we haven't written.  This was fixed by the patch
> +#
> +# btrfs: fix incorrect updating of log root tree
> +#
> +# Will do log replay and check the filesystem.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +fio_config=$tmp.fio
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	_log_writes_cleanup &> /dev/null
> +	_dmthin_cleanup
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmthin
> +. ./common/dmlogwrites
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +
> +# Use thin device as replay device, which requires $SCRATCH_DEV
> +_require_scratch_nocheck
> +# and we need extra device as log device
> +_require_log_writes
> +_require_dm_target thin-pool
> +
> +cat >$fio_config <<EOF
> +[global]
> +readwrite=write
> +fallocate=none
> +bs=4k
> +fsync=1
> +size=128k
> +EOF
> +
> +for i in $(seq 0 49); do
> +	echo "[foo$i]" >> $fio_config
> +	echo "filename=$SCRATCH_MNT/$i/file" >> $fio_config
> +done
> +
> +_require_fio $fio_config
> +
> +cat $fio_config >> $seqres.full
> +
> +# Use a thin device to provide deterministic discard behavior. Discards are used
> +# by the log replay tool for fast zeroing to prevent out-of-order replay issues.
> +_test_unmount

Why umount $TEST_DEV here?

> +_dmthin_init $devsize $devsize $csize $lowspace

'devsize' 'csize' and 'lowspace' are not defined, and _dmthin_init uses
all defaults. Define them or just use the defaults?

Thanks,
Eryu

> +_log_writes_init $DMTHIN_VOL_DEV
> +_log_writes_mkfs >> $seqres.full 2>&1
> +_log_writes_mark mkfs
> +
> +_log_writes_mount
> +
> +# First create all the subvolumes
> +for i in $(seq 0 49); do
> +	$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/$i" > /dev/null
> +done
> +
> +$FIO_PROG $fio_config > /dev/null 2>&1
> +_log_writes_unmount
> +
> +_log_writes_remove
> +prev=$(_log_writes_mark_to_entry_number mkfs)
> +[ -z "$prev" ] && _fail "failed to locate entry mark 'mkfs'"
> +cur=$(_log_writes_find_next_fua $prev)
> +[ -z "$cur" ] && _fail "failed to locate next FUA write"
> +
> +while [ ! -z "$cur" ]; do
> +	_log_writes_replay_log_range $cur $DMTHIN_VOL_DEV >> $seqres.full
> +
> +	# We need to mount the fs because btrfsck won't bother checking the log.
> +	_dmthin_mount
> +	_dmthin_check_fs
> +
> +	prev=$cur
> +	cur=$(_log_writes_find_next_fua $(($cur + 1)))
> +	[ -z "$cur" ] && break
> +done
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
> new file mode 100644
> index 00000000..7bfd50ff
> --- /dev/null
> +++ b/tests/btrfs/194.out
> @@ -0,0 +1,2 @@
> +QA output created by 194
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index b92cb12c..0d0e1bba 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -196,3 +196,4 @@
>  191 auto quick send dedupe
>  192 auto replay snapshot stress
>  193 auto quick qgroup enospc limit
> +194 auto metadata log volume
> -- 
> 2.21.0
> 
