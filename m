Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBD8267FFE
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Sep 2020 17:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgIMPps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Sep 2020 11:45:48 -0400
Received: from out20-87.mail.aliyun.com ([115.124.20.87]:51940 "EHLO
        out20-87.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgIMPpp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Sep 2020 11:45:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437865|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0238539-0.00105393-0.975092;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07447;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.IWZm66J_1600011936;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IWZm66J_1600011936)
          by smtp.aliyun-inc.com(10.147.42.253);
          Sun, 13 Sep 2020 23:45:36 +0800
Date:   Sun, 13 Sep 2020 23:45:36 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH][v2] fstests: btrfs/219 add a test to test -o rescue=all
Message-ID: <20200913154536.GJ3853@desktop>
References: <36b3a0eafee6f43d489bf8fcfe5a1ac13a9f896a.1599654294.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36b3a0eafee6f43d489bf8fcfe5a1ac13a9f896a.1599654294.git.josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 09, 2020 at 08:25:51AM -0400, Josef Bacik wrote:
> This new mount option makes sure we can still mount the file system if
> any of the core roots are corrupted.  This test corrupts each of these
> roots and validates that it can still mount the fs and read the file.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I think patch "fstests: add a _require_scratch_mountopt helper" could be
folded into this one. So the new helper is with its usage, which should
be easier to review.

> ---
> v1->v2:
> - Sent the actual intended patch this time.
> 
>  tests/btrfs/219     | 99 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/219.out | 30 ++++++++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 130 insertions(+)
>  create mode 100755 tests/btrfs/219
>  create mode 100644 tests/btrfs/219.out
> 
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> new file mode 100755
> index 00000000..c6abc111
> --- /dev/null
> +++ b/tests/btrfs/219
> @@ -0,0 +1,99 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 219
> +#
> +# A test to exercise the various failure scenarios for -o rescue=all.  This is
> +# mainly a regression test for
> +#
> +#   btrfs: introduce rescue=all

This kernel patch is still in review, I'd wait for it to be merged, or
at least acked by other btrfs folks and/or maintainer.

> +#
> +# We simply corrupt a bunch of core roots and validate that it works the way we
> +# expect it to.
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
> +}
> +
> +_generate_fs()

Local functions don't need to be prefixed with "_".

> +{
> +	# We need single so we don't just read the duplicates
> +	_scratch_mkfs -m single -d single > $seqres.full 2>&1
> +	_scratch_mount
> +	$XFS_IO_PROG -f -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo | \
> +		_filter_xfs_io
> +	md5sum $SCRATCH_MNT/foo | _filter_scratch
> +	_scratch_unmount
> +}
> +
> +_clear_root()
> +{
> +	# Grab the bytenr for the root by dumping the tree roots, clearing up to
> +	# the key so our first column is the bytenr.  With a normal device with
> +	# single should mean that physical == logical
> +	local bytenr=$($BTRFS_UTIL_PROG inspect-internal dump-tree -r \

Add a require for this?

_require_btrfs_command inspect-internal dump-tree

> +		$SCRATCH_DEV | grep "$1" | sed 's/.*) //g'| \
> +		awk '{ print $1 }')
                ^^^ $AWK_PROG

Thanks,
Eryu

> +	dd if=/dev/zero of=$SCRATCH_DEV bs=1 seek=$bytenr count=4096 | \
> +		_filter_dd
> +}
> +
> +_test_failure()
> +{
> +	_try_scratch_mount $* > /dev/null 2>&1
> +	[ $? -eq 0 ] && _fail "We should have failed to mount"
> +}
> +
> +_test_success()
> +{
> +	_generate_fs
> +	_clear_root "$1"
> +	_test_failure
> +	_scratch_mount -o rescue=all,ro
> +	md5sum $SCRATCH_MNT/foo | _filter_scratch
> +	_scratch_unmount
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
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_scratch_mountopt "rescue=all,ro"
> +
> +# Test with the roots that should definitely pass
> +_test_success "extent tree"
> +_test_success "checksum tree"
> +_test_success "uuid tree"
> +_test_success "data reloc"
> +
> +# Now test the roots that will definitely fail
> +_generate_fs
> +_clear_root "fs tree"
> +_test_failure -o rescue=all,ro
> +
> +# We have to re-mkfs the fs because otherwise the post-test fsck will blow up
> +_scratch_mkfs > /dev/null 2>&1
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/219.out b/tests/btrfs/219.out
> new file mode 100644
> index 00000000..9a6d43c4
> --- /dev/null
> +++ b/tests/btrfs/219.out
> @@ -0,0 +1,30 @@
> +QA output created by 219
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> +4096+0 records in
> +4096+0 records out
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> +4096+0 records in
> +4096+0 records out
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> +4096+0 records in
> +4096+0 records out
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> +4096+0 records in
> +4096+0 records out
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
> +4096+0 records in
> +4096+0 records out
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 3295856d..f4dbfafb 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -221,3 +221,4 @@
>  216 auto quick seed
>  217 auto quick trim dangerous
>  218 auto quick volume
> +219 auto quick
> -- 
> 2.26.2
