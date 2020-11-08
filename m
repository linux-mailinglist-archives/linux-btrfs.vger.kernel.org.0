Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F712AAA3C
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Nov 2020 10:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgKHJRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Nov 2020 04:17:17 -0500
Received: from out20-14.mail.aliyun.com ([115.124.20.14]:42876 "EHLO
        out20-14.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgKHJRQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Nov 2020 04:17:16 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0748932|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0348434-0.000312966-0.964844;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Iu2wzla_1604827033;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Iu2wzla_1604827033)
          by smtp.aliyun-inc.com(10.147.44.145);
          Sun, 08 Nov 2020 17:17:13 +0800
Date:   Sun, 8 Nov 2020 17:17:07 +0800
From:   Eryu Guan <guan@eryu.me>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/2] generic: test for non-zero used blocks while writing
 into a file
Message-ID: <20201108091707.GH3853@desktop>
References: <cover.1604487838.git.fdmanana@suse.com>
 <97125f898446b152fd759eba2f2c5963d3daadc0.1604487838.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97125f898446b152fd759eba2f2c5963d3daadc0.1604487838.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 04, 2020 at 11:13:53AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we keep overwriting an entire file, either with buffered
> writes or direct IO writes, the number of used blocks reported by stat(2)
> is never zero while the writes and writeback are in progress.
> 
> This is motivated by a bug in btrfs and currently fails on btrfs only. It
> is fixed a patchset for btrfs that has the following patches:
> 
>   btrfs: fix missing delalloc new bit for new delalloc ranges
>   btrfs: refactor btrfs_drop_extents() to make it easier to extend
>   btrfs: fix race when defragging that leads to unnecessary IO
>   btrfs: update the number of bytes used by an inode atomically
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/615     | 77 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/615.out |  3 ++
>  tests/generic/group   |  1 +
>  3 files changed, 81 insertions(+)
>  create mode 100755 tests/generic/615
>  create mode 100644 tests/generic/615.out
> 
> diff --git a/tests/generic/615 b/tests/generic/615
> new file mode 100755
> index 00000000..e392c4a5
> --- /dev/null
> +++ b/tests/generic/615
> @@ -0,0 +1,77 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. 615
> +#
> +# Test that if we keep overwriting an entire file, either with buffered writes
> +# or direct IO writes, the number of used blocks reported by stat(2) is never
> +# zero while the writes and writeback are in progress.
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
> +
> +rm -f $seqres.full
> +
> +stat_loop()
> +{
> +	trap "wait; exit" SIGTERM
> +	local filepath=$1
> +	local blocks
> +
> +	while :; do
> +		blocks=$(stat -c %b $filepath)
> +		if [ $blocks -eq 0 ]; then
> +		    echo "error: stat(2) reported zero blocks"
> +		fi
> +	done
> +}
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +$XFS_IO_PROG -f -s -c "pwrite -b 64K 0 64K" $SCRATCH_MNT/foo >>$seqres.full
> +
> +stat_loop $SCRATCH_MNT/foo &
> +loop_pid=$!
> +
> +echo "Testing buffered writes"
> +
> +# Now keep overwriting the entire file, triggering writeback after each write,
> +# while another process is calling stat(2) on the file. We expect the number of
> +# used blocks reported by stat(2) to be always greater than 0.
> +for ((i = 0; i < 5000; i++)); do
> +	$XFS_IO_PROG -s -c "pwrite -b 64K 0 64K" $SCRATCH_MNT/foo >>$seqres.full
> +done

Test 5000 loops of sync write takes 3 mins to 5 mins for me on my test
vm, which has 2 vcpus and 8G memory.

I think we could reduce the test time by
- lower the loop count, maybe 2000, in my test it usually reproduces
  within 1000 iterations.
- drop "-s" option, it speeds up the test from ~180s to ~25s, and btrfs
  still reproduces the bug. But it seems dropping "-s" make it harder to
  hit the bug, perhaps 3000-5000 iteration should be fine.
- reduce the write buffer size, a 16K write still reproduce the bug on
  btrfs for me. But if we want to cover 64K page size env, I think 64K
  buffer is fine, as long as "-s" is dropped.

Further, I think we could exit early when "zero blocks" is found, e.g.
call "_fail" instead of "echo" in stat_loop() and in the write loop,
check for $loop_pid before every write, and break the loop if $loop_pid
died. So we could report failure as soon as possible. For example

for ((i = 0; i < 5000; i++)); do
	if ! kill -s 0 $loop_pid; then
		echo "Bug reproduced at iteration $i"
		break
	fi
	$XFS_IO_PROG -s -c "pwrite -b 64K 0 64K" $SCRATCH_MNT/foo >>$seqres.full
done

Thanks,
Eryu

> +echo "Testing direct IO writes"
> +
> +# Now similar to what we did before but for direct IO writes.
> +for ((i = 0; i < 5000; i++)); do
> +	$XFS_IO_PROG -d -c "pwrite -b 64K 0 64K" $SCRATCH_MNT/foo >>$seqres.full
> +done
> +
> +kill $loop_pid &> /dev/null
> +wait
> +
> +status=0
> +exit
> diff --git a/tests/generic/615.out b/tests/generic/615.out
> new file mode 100644
> index 00000000..3b549e96
> --- /dev/null
> +++ b/tests/generic/615.out
> @@ -0,0 +1,3 @@
> +QA output created by 615
> +Testing buffered writes
> +Testing direct IO writes
> diff --git a/tests/generic/group b/tests/generic/group
> index ab8ae74e..fb3c638c 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -617,3 +617,4 @@
>  612 auto quick clone
>  613 auto quick encrypt
>  614 auto quick rw
> +615 auto rw
> -- 
> 2.28.0
