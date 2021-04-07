Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51273571EA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 18:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhDGQLA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 12:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234685AbhDGQK4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Apr 2021 12:10:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3258F61177;
        Wed,  7 Apr 2021 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617811847;
        bh=cfjTNNcfMV2EZ8jzkfMHX6PEPiiao9YRDMix6sx1swk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U66MlCYDE3TKWSG3kQ04n30Cq3Do67fa0AxbEUaCZriOakhcXnS1d4nEgFq+Vke9K
         2TNJbWNJM0qZTgeRqIwWq83/B2qmHKnRhDaJVwctjqdDjiMK+PaKQOl2wNPizBuYpc
         FwKn2AzGFguU7jI6npOBmBPUpbiB2Zf5PYP2iJeL6UIQ0wxFIoo1ilf4LyUiPBW8Kq
         vC790OX0TgtVaDW6DSlGHbBR+tM9v71XbP2BV28YdDR704I8wPjlGFXq88ldcz7kfO
         B+i/7rFdwjPp7EMK5Jhu3MXN2krr+g0gq7NbfjXvQrtCSvPkX9k6WE+cvNfZ6+tCGa
         TlEKBOBBNebEw==
Date:   Wed, 7 Apr 2021 09:10:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic: test fiemap offsets and < 512 byte ranges
Message-ID: <20210407161046.GY1670408@magnolia>
References: <4098b7c2a597f2f6d624ce1b3f2741a381c588b7.1617749158.git.boris@bur.io>
 <189e96b6dfccc54ec44879456488977c95b3efda.1617749523.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <189e96b6dfccc54ec44879456488977c95b3efda.1617749523.git.boris@bur.io>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 06, 2021 at 03:54:29PM -0700, Boris Burkov wrote:
> btrfs trims fiemap extents to the inputted offset, which leads to
> inconsistent results for most inputs, and downright bizarre outputs like
> [7..6] when the trimmed extent is at the end of an extent and shorter
> than 512 bytes.
> 
> This test covers a bunch of cases like that and ensures that file
> systems always return the full extent without trimming it.
> 
> I also ran it under ext2, ext3, ext4, f2fs, and xfs successfully, but I
> suppose it's no guarantee that every file system will store a 4k synced
> write in a single extent. For that reason, this might be a bit fragile.

Does it work with 64k fs blocks?  Or 512b blocks? :)

Also... is there an xfs_io fix to go with this?

> 
> This test is fixed for btrfs by:
> btrfs: return whole extents in fiemap
> (https://lore.kernel.org/linux-btrfs/274e5bcebdb05a8969fc300b4802f33da2fbf218.1617746680.git.boris@bur.io/)
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> 
> --
> v2: fill out copyright and test description
> 
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
> index 00000000..85ef68f6
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
> +_require_scratch
> +_require_xfs_io_command "fiemap"
> +
> +rm -f $seqres.full
> +
> +_do_fiemap() {
> +	off=$1
> +	len=$2
> +	$XFS_IO_PROG -c "fiemap $off $len" $SCRATCH_MNT/foo
> +}
> +
> +_check_fiemap() {

Only helper functions in common/ need to be prefixed with "_".

> +	off=$1
> +	len=$2
> +	actual=$(_do_fiemap $off $len | tee -a $seqres.full)
> +	[ "$actual" == "$expected" ] || _fail "unexpected fiemap on $off $len"
> +}
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount

You could probably accomplish this by creating a file on the test
device, which means this test would run on configurations where there's
no scratch device; and run faster since there's no longer any need for
mkfs.

--D

> +
> +# write a file with one extent
> +$XFS_IO_PROG -f -s -c "pwrite -S 0xcf 0 4K" $SCRATCH_MNT/foo >/dev/null
> +
> +# since the exact extent location is unpredictable especially when
> +# varying file systems, just test that they are all equal, which is
> +# what we really expect.
> +expected=$(_do_fiemap)
> +
> +# start to mid-extent
> +_check_fiemap 0 2048
> +# start to end
> +_check_fiemap 0 4096
> +# start to past-end
> +_check_fiemap 0 4097
> +# mid-extent to mid-extent
> +_check_fiemap 1024 2048
> +# mid-extent to end
> +_check_fiemap 2048 4096
> +# mid-extent to past-end
> +_check_fiemap 2048 4097
> +
> +# to end; len < 512
> +_check_fiemap 4091 5
> +# to end; len == 512
> +_check_fiemap 3584 512
> +# past end; len < 512
> +_check_fiemap 4091 500
> +# past end; len == 512
> +_check_fiemap 4091 512
> +
> +_scratch_unmount
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
> 
