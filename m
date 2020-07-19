Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5EC2252D6
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jul 2020 18:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgGSQoZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 12:44:25 -0400
Received: from out20-134.mail.aliyun.com ([115.124.20.134]:53936 "EHLO
        out20-134.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSQoY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 12:44:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.9243609|0.8991504;BR=01201311R131S65rulernew998_84748_2000303;CH=blue;DM=|SPAM|false|;DS=CONTINUE|ham_system_inform|0.0079184-0.000475136-0.991606;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16378;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.I4MNc41_1595177058;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.I4MNc41_1595177058)
          by smtp.aliyun-inc.com(10.147.41.158);
          Mon, 20 Jul 2020 00:44:18 +0800
Date:   Mon, 20 Jul 2020 00:44:17 +0800
From:   Eryu Guan <guan@eryu.me>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test creating a snapshot after RWF_NOWAIT write
 works as expected
Message-ID: <20200719164417.GC2557159@desktop>
References: <20200615175028.15090-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615175028.15090-1-fdmanana@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 15, 2020 at 06:50:28PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that creating a snapshot after writing to a file using a RWF_NOWAIT
> works, does not hang the snapshot creation task, and we are able to read
> the data after.
> 
> Currently btrfs hangs when creating the snapshot due to a missing unlock
> of a snapshot lock, but it is fixed by a patch with the following subject:
> 
>   "btrfs: fix hang on snapshot creation after RWF_NOWAIT write"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

So sorry for the late review.. But I hit the following failure with
v5.8-rc5 kernel, which contains the mentioned fix

 QA output created by 215
 wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+pwrite: Input/output error
 Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 File data in the subvolume:
-0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
 *
 0065536
 File data in the snapshot:
-0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
 *
 0065536

And I did hit hang when testing without the fix. Is this something that
should be fixed in the test?

Thanks,
Eryu

> ---
>  tests/btrfs/214     | 66 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/214.out | 14 ++++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 81 insertions(+)
>  create mode 100755 tests/btrfs/214
>  create mode 100644 tests/btrfs/214.out
> 
> diff --git a/tests/btrfs/214 b/tests/btrfs/214
> new file mode 100755
> index 00000000..c835e844
> --- /dev/null
> +++ b/tests/btrfs/214
> @@ -0,0 +1,66 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FSQA Test No. 214
> +#
> +# Test that creating a snapshot after writing to a file using a RWF_NOWAIT
> +# works, does not hang the snapshot creation task, and we are able to read
> +# the data after.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_odirect
> +_require_xfs_io_command pwrite -N
> +_require_chattr C
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# RWF_NOWAIT writes require NOCOW
> +touch $SCRATCH_MNT/f
> +$CHATTR_PROG +C $SCRATCH_MNT/f
> +
> +$XFS_IO_PROG -d -c "pwrite -S 0xab 0 64K" $SCRATCH_MNT/f | _filter_xfs_io
> +
> +# Now do a WEF_WRITE into a range containing a NOCOWable extent.
> +$XFS_IO_PROG -d -c "pwrite -N -V 1 -S 0xfe 0 64K" $SCRATCH_MNT/f \
> +	| _filter_xfs_io
> +
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
> +	| _filter_scratch
> +
> +# Unmount, mount again and verify the file in the subvolume and snapshot has
> +# the correct data.
> +_scratch_cycle_mount
> +
> +echo "File data in the subvolume:"
> +od -A d -t x1 $SCRATCH_MNT/f
> +
> +echo "File data in the snapshot:"
> +od -A d -t x1 $SCRATCH_MNT/snap/f
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/214.out b/tests/btrfs/214.out
> new file mode 100644
> index 00000000..6cc66972
> --- /dev/null
> +++ b/tests/btrfs/214.out
> @@ -0,0 +1,14 @@
> +QA output created by 214
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> +File data in the subvolume:
> +0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> +*
> +0065536
> +File data in the snapshot:
> +0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> +*
> +0065536
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 9e48ecc1..a3706e7d 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -216,3 +216,4 @@
>  211 auto quick log prealloc
>  212 auto balance dangerous
>  213 auto balance dangerous
> +214 auto quick snapshot
> -- 
> 2.26.2
