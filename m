Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 528FCECD9C
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Nov 2019 07:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfKBG0d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Nov 2019 02:26:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34668 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKBG0c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Nov 2019 02:26:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id e4so7811973pgs.1;
        Fri, 01 Nov 2019 23:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ffar5Bpso3EE7eRyIlkDnabkFXSapyh8sFlP5SxpdWk=;
        b=lbyMkmOyCAjgvk0tUyE/oAA92HIAL93mfjn74WtQW6WNclv1qvIq/neQk93bkZIBXA
         JepMKkEo+gtuOrilmyw7wx7d1S+ttgQzc8Gtn5En1J20JnmgeuodGCXFP3vXAxlqg3ad
         Dxr2GBPWMztTTU8MX4xom16RkAmjk4n2PXxs9ya47B5troDOzSEpaLURHrwMEFqhg7f3
         brCW3WqeluDjqwmQh0fAsiHzQ0Q4fvXqSdUjmh4VAhKenBcZ4Tz1+y7jGmdXRO+M5LQN
         LFgEBbtiuoa4+tQhu0jbdB+ws7n6yl3oPhHmNP+LX9WDgbByPcMenXKfNEaHi22kkAIy
         79aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ffar5Bpso3EE7eRyIlkDnabkFXSapyh8sFlP5SxpdWk=;
        b=ZKud+QwPH+a7j4aDH1ol3dQ74P8KZBVoVtOEPPEaovGYEiuei/xTRBDdfPsyXr7S8n
         ypnWV481U9+P9DVAeqs3mwL8qWvVvvzP2z1kgwOtYQjR/gSZaUKVXaA1eXoY51ziw3fI
         ZAc9v5R4ssH6P+XGFoMUmrzCE0X2Hcmi4l4GfB4fzzasSy4NIO7Z4EGyWdzc/YOjmV/k
         NP4bwf648laOXpkrQ1aIWbqxml6owdKmB6qB1KdPevGg9AvpRYAxCR/SvYziiZVwkV10
         gebzsdJRY6NzuwbXPKq5IqndMufNmW0suTS9MR+nQsGqInugJAD/e3IDZ3zMaUhedZyC
         OWIg==
X-Gm-Message-State: APjAAAVA2wMmnwxMFv0RDFFwFTx90ApINKzVRkwZd1j0B/B7euwTZ+3r
        +osPpAFLaXh2fmQ/txeDcSM=
X-Google-Smtp-Source: APXvYqxQx9SaR4TLi5IFspQNz14x8S3GBx8s8cEF6sNSOjDrtyc1qwErlt36hIySEKeV7wOVyCf2ng==
X-Received: by 2002:a63:1242:: with SMTP id 2mr17853894pgs.288.1572675991748;
        Fri, 01 Nov 2019 23:26:31 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id w6sm8627035pfw.84.2019.11.01.23.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 23:26:30 -0700 (PDT)
Date:   Sat, 2 Nov 2019 14:26:25 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test that send can issue clone operations within
 the same file
Message-ID: <20191102062625.GG2543@desktop>
References: <20191030122741.11073-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030122741.11073-1-fdmanana@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 30, 2019 at 12:27:41PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Verify that both full and incremental send operations can issue clone
> operations when a file has extents that are shared with itself (at
> different offsets of course).
> 
> This currently fails on btrfs but is addressed by a patch for the
> kernel titled:
> 
>   "Btrfs: send, allow clone operations within the same file"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/200     | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/200.out |  17 +++++++
>  tests/btrfs/group   |   1 +
>  3 files changed, 151 insertions(+)
>  create mode 100755 tests/btrfs/200
>  create mode 100644 tests/btrfs/200.out
> 
> diff --git a/tests/btrfs/200 b/tests/btrfs/200
> new file mode 100755
> index 00000000..e7853c4b
> --- /dev/null
> +++ b/tests/btrfs/200
> @@ -0,0 +1,133 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. 200
> +#
> +# Check that send operations (full and incremental) are able to issue clone
> +# operations for extents that are shared between the same file.
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
> +	rm -fr $send_files_dir
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/reflink
> +. ./common/punch
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_fssum
> +_require_test
> +_require_scratch_reflink
> +_require_xfs_io_command "fiemap"
> +
> +count_extents()
> +{
> +	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | wc -l
> +}

There's a similar in common/rc called _count_extents(), but it opens
file with rw permission. Perhaps you could just update the existing
helper? (And add '-r' to _count_holes() and _count_attr_extents()?)

> +
> +count_exclusive_extents()
> +{
> +	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | cut -d ' ' -f 3 \
> +		| sort | uniq | wc -l
> +}

And maybe add this one to common helper too.

Otherwise looks good to me.

Thanks,
Eryu

> +
> +send_files_dir=$TEST_DIR/btrfs-test-$seq
> +
> +rm -f $seqres.full
> +rm -fr $send_files_dir
> +mkdir $send_files_dir
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# Create our first test file, which has an extent that is shared only with
> +# itself and no other files. We want to verify a full send operation will
> +# clone the extent.
> +$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 64K 0 64K" $SCRATCH_MNT/foo \
> +	| _filter_xfs_io
> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
> +	| _filter_xfs_io
> +
> +# Create out second test file which initially, for the first send operation,
> +# only has a single extent that is not shared.
> +$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
> +	| _filter_xfs_io
> +
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
> +	| _filter_scratch
> +
> +$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
> +	| _filter_scratch
> +
> +# Now clone the existing extent in file bar to itself at a different offset.
> +# We want to verify the incremental send operation below will issue a clone
> +# operation instead of a write operation.
> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
> +	| _filter_xfs_io
> +
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
> +	| _filter_scratch
> +
> +$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
> +	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
> +
> +# Compute digests of the snapshot trees so that later we can compare against
> +# digests of the trees in the new filesystem, to see if they match (no data or
> +# metadata corruption happened).
> +$FSSUM_PROG -A -f -w $send_files_dir/base.fssum $SCRATCH_MNT/base
> +$FSSUM_PROG -A -f -w $send_files_dir/incr.fssum \
> +	-x $SCRATCH_MNT/incr/base $SCRATCH_MNT/incr
> +
> +# Now recreate the filesystem by receiving both send streams and verify we get
> +# the same file contents that the original filesystem had and that files foo
> +# and bar have shared extents.
> +_scratch_unmount
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT
> +$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT
> +
> +# Compute digests of the snapshot trees in the new filesystem and compare them
> +# to the ones in the original filesystem, they must match.
> +$FSSUM_PROG -r $send_files_dir/base.fssum $SCRATCH_MNT/base
> +$FSSUM_PROG -r $send_files_dir/incr.fssum $SCRATCH_MNT/incr
> +
> +num_extents=$(count_extents $SCRATCH_MNT/base/foo)
> +num_exclusive_extents=$(count_exclusive_extents $SCRATCH_MNT/base/foo)
> +if [ $num_extents -ne 2 ] || [ $num_exclusive_extents -ne 1 ]; then
> +	echo "File foo does not have 2 shared extents in the base snapshot"
> +	$XFS_IO_PROG -r -c "fiemap" $SCRATCH_MNT/base/foo
> +fi
> +
> +num_extents=$(count_extents $SCRATCH_MNT/incr/foo)
> +num_exclusive_extents=$(count_exclusive_extents $SCRATCH_MNT/incr/foo)
> +if [ $num_extents -ne 2 ] || [ $num_exclusive_extents -ne 1 ]; then
> +	echo "File foo does not have 2 shared extents in the incr snapshot"
> +	$XFS_IO_PROG -r -c "fiemap" $SCRATCH_MNT/incr/foo
> +fi
> +
> +num_extents=$(count_extents $SCRATCH_MNT/incr/bar)
> +num_exclusive_extents=$(count_exclusive_extents $SCRATCH_MNT/incr/bar)
> +if [ $num_extents -ne 2 ] || [ $num_exclusive_extents -ne 1 ]; then
> +	echo "File bar does not have 2 shared extents in the incr snapshot"
> +	$XFS_IO_PROG -r -c "fiemap" $SCRATCH_MNT/incr/bar
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
> new file mode 100644
> index 00000000..3eec567e
> --- /dev/null
> +++ b/tests/btrfs/200.out
> @@ -0,0 +1,17 @@
> +QA output created by 200
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +linked 65536/65536 bytes at offset 65536
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
> +At subvol SCRATCH_MNT/base
> +linked 65536/65536 bytes at offset 65536
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
> +At subvol SCRATCH_MNT/incr
> +At subvol base
> +At snapshot incr
> +OK
> +OK
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index c7ab129e..d56dcafa 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -202,3 +202,4 @@
>  197 auto quick volume
>  198 auto quick volume
>  199 auto quick trim
> +200 auto quick send clone
> -- 
> 2.11.0
> 
