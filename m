Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13B16019F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 09:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfGEHni (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 03:43:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38640 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfGEHnh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 03:43:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so3948182pfn.5;
        Fri, 05 Jul 2019 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u5ITceGTHxApOqnthKBhSDomj3X1ETZSFM423bBrnIM=;
        b=bpQA78ag63BLPRxlYjHaEYuSLbNAOtDU6r/qxsJkEqHZ01UBcRedZnf8unD53sGlza
         h+YPVfB5zq2huE2WsnEGKLKX9FI9ADCkkVUyhWUiUwbV8OJrcoiCUnHzmVejTypuVTvm
         ZUgUzzotSJSmVVg+JOLgFmKoygm8IrOKJmB0zhT637X2C7FjnwxJ4e/4ZO0fIYaF1oCY
         9tnKn5od6VEmH2Uc59ZgicZGcnXivt127jh6K6nIwu/o39ZOji4J+l9iF3/p4w3XSaKs
         dRROYhPI2dYdvh/CiPjtRFw5UfdRS6qkoX7rgHtKuxq1tte04GoflHVSxNZxkmCGD9SD
         d88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u5ITceGTHxApOqnthKBhSDomj3X1ETZSFM423bBrnIM=;
        b=m4sa+J9rHk4szemk9qkjKK5/KisvceRx59yvV6J37A8sZpp+RBPJCaX23h0QePE0ps
         e8Sc9DRP9h+58oLRWOBczX+/bPbDemVr+t81S/f7DmqrY/Ftt47wbUR1FBIXB3SV/9Le
         dO9WYZyS5ciAQYYejmFn0SMVWwyzzPvtaFCHqkxMaN/LmTeVG5v/GtDyBKS2zNm6PbqC
         UM9/3vAaojwuOXmW92VqyLUPMN7Rt8V4U6UMJFPR3rfsrdj47sycNq39dStlc/xf4bbA
         +/UrA+3s+uK59wRpX/4Ij2SnrrzZ1tkDX0vM5k04AABdaHZFzBTg6ncsoh3EPCpN/krj
         umDQ==
X-Gm-Message-State: APjAAAVv0MJLm9aQprGCMgrEnUspcmQTl3uJ9DaMYqWIZdSFnR9eLO85
        Z1YxtLU3wg4jJhYXoHljC4s=
X-Google-Smtp-Source: APXvYqy7vL5XlO/K4/Kh/6oA+3ZBFT0U+JvKtZu+NlZ79Xq4fX8Em0rrm47Pmw1HdBKyCX+NQKN9tA==
X-Received: by 2002:a63:a41:: with SMTP id z1mr3537878pgk.290.1562312616336;
        Fri, 05 Jul 2019 00:43:36 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id x8sm7066599pfa.46.2019.07.05.00.43.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 00:43:35 -0700 (PDT)
Date:   Fri, 5 Jul 2019 15:43:27 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] generic: test cloning large exents to a file with
 many small extents
Message-ID: <20190705074327.GF7943@desktop>
References: <20190627170030.6149-1-fdmanana@kernel.org>
 <20190628220836.16096-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628220836.16096-1-fdmanana@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 28, 2019 at 11:08:36PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we clone a file with some large extents into a file that has
> many small extents, when the fs is nearly full, the clone operation does
> not fail and produces the correct result.
> 
> This is motivated by a bug found in btrfs wich is fixed by the following
> patches for the linux kernel:
> 
>  [PATCH 1/2] Btrfs: factor out extent dropping code from hole punch handler
>  [PATCH 2/2] Btrfs: fix ENOSPC errors, leading to transaction aborts, when
>              cloning extents
> 
> The test currently passes on xfs.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Use _scratch_cycle_mount instead of _scratch_remount, as we want to see
>     if the operation was durably persisted (otherwise we are seeing content
>     from the page cache).
>     Use _reflink instead of calling xfs_io with the reflink command.
>     Make the comment before filling the filesystem more clear about why it
>     is done the way it is instead of using _fill_fs.
> 
>  tests/generic/558     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/558.out |  5 ++++
>  tests/generic/group   |  1 +
>  3 files changed, 86 insertions(+)
>  create mode 100755 tests/generic/558
>  create mode 100644 tests/generic/558.out
> 
> diff --git a/tests/generic/558 b/tests/generic/558
> new file mode 100755
> index 00000000..f982930d
> --- /dev/null
> +++ b/tests/generic/558
> @@ -0,0 +1,80 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FSQA Test No. 558
> +#
> +# Test that if we clone a file with some large extents into a file that has
> +# many small extents, when the fs is nearly full, the clone operation does
> +# not fail and produces the correct result.
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
> +. ./common/reflink
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch_reflink
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
> +_scratch_mount
> +
> +file_size=$(( 128 * 1024 * 1024 )) # 128Mb
> +extent_size=4096
> +num_extents=$(( $file_size / $extent_size ))
> +
> +# Create a file with many small extents.
> +for ((i = 0; i < $num_extents; i++)); do
> +	offset=$(( $i * $extent_size ))
> +	$XFS_IO_PROG -f -s -c "pwrite -S 0xe5 $offset $extent_size" \
> +		$SCRATCH_MNT/foo >>/dev/null
> +done

This is taking too long time (1000+s) to finish when testing on XFS. I'm
wondering if we could take use of src/punch-alternating to punch out
every other block to create a file with many small extents.

i.e. with the following diffs, test runs & passes with XFS within 90s
while still reproduces the btrfs bug (note that I have to increase the
file_size to 200M to reproduce the btrfs bug, while 256M seems bring
test time back to 1000+s). Would you please check if this works for you?

Thanks,
Eryu


diff --git a/tests/generic/558 b/tests/generic/558
index f982930d65a2..40f8a7a98d3f 100755
--- a/tests/generic/558
+++ b/tests/generic/558
@@ -30,22 +30,22 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch_reflink
+_require_test_program "punch-alternating"
+_require_xfs_io_command "fpunch"

 rm -f $seqres.full

 _scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount

-file_size=$(( 128 * 1024 * 1024 )) # 128Mb
+file_size=$(( 200 * 1024 * 1024 )) # 200MB
 extent_size=4096
 num_extents=$(( $file_size / $extent_size ))

 # Create a file with many small extents.
-for ((i = 0; i < $num_extents; i++)); do
-       offset=$(( $i * $extent_size ))
-       $XFS_IO_PROG -f -s -c "pwrite -S 0xe5 $offset $extent_size" \
-               $SCRATCH_MNT/foo >>/dev/null
-done
+$XFS_IO_PROG -f -c "pwrite -S 0xe5 -b $file_size 0 $file_size" \
+       $SCRATCH_MNT/foo >>/dev/null
+$here/src/punch-alternating $SCRATCH_MNT/foo >> $seqres.full

 # Create file bar with the same size that file foo has but with large extents.
 $XFS_IO_PROG -f -c "pwrite -S 0xc7 -b $file_size 0 $file_size" \
diff --git a/tests/generic/558.out b/tests/generic/558.out
index d1e8e70f5b79..00cb5a9744aa 100644
--- a/tests/generic/558.out
+++ b/tests/generic/558.out
@@ -2,4 +2,4 @@ QA output created by 558
 File foo data after cloning and remount:
 0000000 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7
 *
-134217728
+209715200

> +
> +# Create file bar with the same size that file foo has but with large extents.
> +$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b $file_size 0 $file_size" \
> +	$SCRATCH_MNT/bar >>/dev/null
> +
> +# Fill the fs (For btrfs we are interested in filling all unallocated space
> +# and most of the existing metadata block group(s), so that after this there
> +# will be no unallocated space and metadata space will be mostly full but with
> +# more than enough free space for the clone operation below to succeed, we
> +# create files with 2Kb because that results in extents inlined in the metadata
> +# (btree leafs) and it's the fastest way to fill metadata space on btrfs, by
> +# default btrfs inlines up to 2Kb of data).
> +i=1
> +while true; do
> +	$XFS_IO_PROG -f -c "pwrite 0 2K" $SCRATCH_MNT/filler_$i &> /dev/null
> +	[ $? -ne 0 ] && break
> +	i=$(( i + 1 ))
> +done
> +
> +# Now clone file bar into file foo. This is supposed to succeed and not fail
> +# with ENOSPC for example.
> +_reflink $SCRATCH_MNT/bar $SCRATCH_MNT/foo >>$seqres.full
> +
> +# Unmount and mount the filesystem again to verify the operation was durably
> +# persisted.
> +_scratch_cycle_mount
> +
> +echo "File foo data after cloning and remount:"
> +od -A d -t x1 $SCRATCH_MNT/foo
> +
> +status=0
> +exit
> diff --git a/tests/generic/558.out b/tests/generic/558.out
> new file mode 100644
> index 00000000..d1e8e70f
> --- /dev/null
> +++ b/tests/generic/558.out
> @@ -0,0 +1,5 @@
> +QA output created by 558
> +File foo data after cloning and remount:
> +0000000 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7
> +*
> +134217728
> diff --git a/tests/generic/group b/tests/generic/group
> index 543c0627..c06c1cd1 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -560,3 +560,4 @@
>  555 auto quick cap
>  556 auto quick casefold
>  557 auto quick log
> +558 auto clone
> -- 
> 2.11.0
> 
