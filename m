Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2241635B58F
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Apr 2021 16:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhDKOES (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Apr 2021 10:04:18 -0400
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:52468 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhDKOES (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Apr 2021 10:04:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0786061|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.293083-0.00783672-0.69908;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.JyKNO5e_1618149839;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JyKNO5e_1618149839)
          by smtp.aliyun-inc.com(10.147.41.138);
          Sun, 11 Apr 2021 22:03:59 +0800
Date:   Sun, 11 Apr 2021 22:03:59 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Boris Burkov <boris@bur.io>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic: test fiemap offsets and < 512 byte ranges
Message-ID: <YHMBzw/9tUVMS66G@desktop>
References: <20210407161046.GY1670408@magnolia>
 <c2f49fdead29fd7eb979b83028eb9fcf56d2457c.1617826068.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2f49fdead29fd7eb979b83028eb9fcf56d2457c.1617826068.git.boris@bur.io>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 07, 2021 at 01:13:26PM -0700, Boris Burkov wrote:
> btrfs trims fiemap extents to the inputted offset, which leads to
> inconsistent results for most inputs, and downright bizarre outputs like
> [7..6] when the trimmed extent is at the end of an extent and shorter
> than 512 bytes.
> 
> The test writes out one extent of the file system's block size and tries
> fiemaps at various offsets. It expects that all the fiemaps return the
> full single extent.
> 
> I ran it under the following fs, block size combinations:
> ext2: 1024, 2048, 4096
> ext3: 1024, 2048, 4096
> ext4: 1024, 2048, 4096
> xfs: 512, 1024, 2048, 4096
> f2fs: 4096
> btrfs: 4096
> 
> This test is fixed for btrfs by:
> btrfs: return whole extents in fiemap
> (https://lore.kernel.org/linux-btrfs/274e5bcebdb05a8969fc300b4802f33da2fbf218.1617746680.git.boris@bur.io/)
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

generic/473, which tests fiemap, has been marked as broken, as fiemap
behavior is not consistent across filesystems, and the specific behavior
tested by generic/473 is not defined and filesystems could have
different implementations.

I'm not sure if this test fits into the undefined-behavior fiemap
categary. I think it's fine if it tests a well-defined & consistent
behavior.

> ---
> v3: make the block size more generic, use test dev instead of scratch,
> cleanup style issues.
> v2: fill out copyright and test description
> ---
>  tests/generic/623     | 94 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/623.out |  2 +
>  tests/generic/group   |  1 +
>  3 files changed, 97 insertions(+)
>  create mode 100755 tests/generic/623
>  create mode 100644 tests/generic/623.out
> 
> diff --git a/tests/generic/623 b/tests/generic/623
> new file mode 100755
> index 00000000..a5ef369a
> --- /dev/null
> +++ b/tests/generic/623
> @@ -0,0 +1,94 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 623
> +#
> +# Test fiemaps with offsets into small parts of extents.
> +# Expect to get the whole extent, anyway.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	rm -f $fiemap_file
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_test
> +_require_xfs_io_command "fiemap"
> +
> +rm -f $seqres.full
> +
> +fiemap_file=$TEST_DIR/foo.$$
> +
> +do_fiemap() {
> +	off=$1
> +	len=$2
> +	echo $off $len >> $seqres.full
> +	$XFS_IO_PROG -c "fiemap $off $len" $fiemap_file | tee -a $seqres.full
> +}
> +
> +check_fiemap() {
> +	off=$1
> +	len=$2
> +	actual=$(do_fiemap $off $len)
> +	[ "$actual" == "$expected" ] || _fail "unexpected fiemap on $off $len"
> +}
> +
> +# write a file with one extent
> +block_size=$(_get_block_size $TEST_DIR)
> +$XFS_IO_PROG -f -s -c "pwrite -S 0xcf 0 $block_size" $fiemap_file >/dev/null
> +
> +# since the exact extent location is unpredictable especially when
> +# varying file systems, just test that they are all equal, which is
> +# what we really expect.
> +expected=$(do_fiemap)
> +
> +mid=$((block_size / 2))
> +almost=$((block_size - 5))
> +past=$((block_size + 1))
> +
> +check_fiemap 0 $mid
> +check_fiemap 0 $block_size
> +check_fiemap 0 $past
> +check_fiemap $mid $almost
> +check_fiemap $mid $block_size
> +check_fiemap $mid $past
> +check_fiemap $almost 5
> +check_fiemap $almost 6
> +
> +# fiemap output explicitly deals in 512 byte increments,
> +# so exercise some cases where len is 512.
> +# Naturally, some of these can't work if block size is 512.
> +one_short=$((block_size - 512))
> +check_fiemap 0 512
> +check_fiemap $one_short 512
> +check_fiemap $almost 512
> +
> +_test_unmount

Any reason to umount TEST_DEV?

Thanks,
Eryu

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/623.out b/tests/generic/623.out
> new file mode 100644
> index 00000000..6f774f19
> --- /dev/null
> +++ b/tests/generic/623.out
> @@ -0,0 +1,2 @@
> +QA output created by 623
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index b10fdea4..39e02383 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -625,3 +625,4 @@
>  620 auto mount quick
>  621 auto quick encrypt
>  622 auto shutdown metadata atime
> +623 auto quick
> -- 
> 2.30.2
