Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA05728F67C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389459AbgJOQN6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 12:13:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:49872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388461AbgJOQN6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 12:13:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48CA4AF63;
        Thu, 15 Oct 2020 16:13:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 07DE21E133E; Thu, 15 Oct 2020 18:13:56 +0200 (CEST)
Date:   Thu, 15 Oct 2020 18:13:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, jack@suse.cz,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test the correctness of several cases of
 RWF_NOWAIT writes
Message-ID: <20201015161355.GI7037@quack2.suse.cz>
References: <aa8318c5beb380a9e99142d1b5e776b739d04bdb.1602774113.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8318c5beb380a9e99142d1b5e776b739d04bdb.1602774113.git.fdmanana@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu 15-10-20 16:36:38, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Verify some attempts to write into a file using RWF_NOWAIT:
> 
> 1) Writing into a fallocated extent that starts at eof should work;

Why? We need to update i_size which requires transaction start and e.g.
ext4 does not support that in non-blocking mode...

								Honza

> 2) Writing into a hole should fail;
> 3) Writing into a range that is partially allocated should fail.
> 
> This is motivated by several bugs that btrfs and ext4 had and were fixed
> by the following kernel commits:
> 
>   4b1946284dd6 ("btrfs: fix failure of RWF_NOWAIT write into prealloc extent beyond eof")
>   260a63395f90 ("btrfs: fix RWF_NOWAIT write not failling when we need to cow")
>   0b3171b6d195 ("ext4: do not block RWF_NOWAIT dio write on unallocated space")
> 
> At the moment, on a 5.9-rc6 kernel at least, ext4 is failing for case 1),
> but when I found and fixed case 1) in btrfs, around kernel 5.7, it was not
> failing on ext4, so some regression happened in the meanwhile. For xfs and
> btrfs on a 5.9 kernel, all the three cases pass.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/613     | 74 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/613.out | 19 +++++++++++
>  tests/generic/group   |  1 +
>  3 files changed, 94 insertions(+)
>  create mode 100755 tests/generic/613
>  create mode 100644 tests/generic/613.out
> 
> diff --git a/tests/generic/613 b/tests/generic/613
> new file mode 100755
> index 00000000..931876dc
> --- /dev/null
> +++ b/tests/generic/613
> @@ -0,0 +1,74 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. 613
> +#
> +# Verify some attempts to write into a file using RWF_NOWAIT:
> +#
> +# 1) Writing into a fallocated extent that starts at eof should work;
> +# 2) Writing into a hole should fail;
> +# 3) Writing into a range that is partially allocated should fail.
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
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_scratch
> +_require_odirect
> +_require_xfs_io_command pwrite -N
> +_require_xfs_io_command falloc -k
> +_require_xfs_io_command fpunch
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +echo "Creating file"
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 512K" $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Now add an unwritten extent using fallocate without bumping the file size and
> +# then attempt to do a  RWF_NOWAIT write into this extent. It should not fail.
> +echo "Writing into fallocated extent at eof"
> +$XFS_IO_PROG -c "falloc -k 512K 512K" \
> +	     -d -c "pwrite -N -V 1 -S 0xcd -b 512K 512K 512K" \
> +	     $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Now punch a hole and try a RWF_NOWAIT write into the hole. It should fail.
> +echo "Writing into a hole"
> +$XFS_IO_PROG -c "fpunch 0 256K" \
> +	     -d -c "pwrite -N -V 1 -S 0xff -b 128K 0 128K" \
> +	     $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Allocate an extent for the first half of the hole, then attempt to write into
> +# a range that covers the new extent and the hole. It should fail.
> +echo "Writing into a range partially allocated (ending with a hole)"
> +$XFS_IO_PROG -c "falloc 0 128K" \
> +	     -d -c "pwrite -N -V 1 -S 0xef -b 256K 0 256K" \
> +	     $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Just double check none of the writes above that should fail did not change the
> +# file data in an unexpected way. First 256K of file data should be all zeros,
> +# the range from 256K to 512K should have all bytes with a value of 0xab and the
> +# range from 512K to 1M should have all bytes with a value of 0xcd.
> +echo "Final file content:"
> +od -A d -t x1 $SCRATCH_MNT/foo
> +
> +status=0
> +exit
> diff --git a/tests/generic/613.out b/tests/generic/613.out
> new file mode 100644
> index 00000000..a542fa5b
> --- /dev/null
> +++ b/tests/generic/613.out
> @@ -0,0 +1,19 @@
> +QA output created by 613
> +Creating file
> +wrote 524288/524288 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Writing into fallocated extent at eof
> +wrote 524288/524288 bytes at offset 524288
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Writing into a hole
> +pwrite: Resource temporarily unavailable
> +Writing into a range partially allocated (ending with a hole)
> +pwrite: Resource temporarily unavailable
> +Final file content:
> +0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +*
> +0262144 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> +*
> +0524288 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> +*
> +1048576
> diff --git a/tests/generic/group b/tests/generic/group
> index 8054d874..b8bf8ec1 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -615,3 +615,4 @@
>  610 auto quick prealloc zero
>  611 auto quick attr
>  612 auto quick clone
> +613 auto quick rw prealloc punch
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
