Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C40658D48B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiHIHaD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 03:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbiHIHaC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 03:30:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EAA21249;
        Tue,  9 Aug 2022 00:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D4D561281;
        Tue,  9 Aug 2022 07:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E078C433D6;
        Tue,  9 Aug 2022 07:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660030199;
        bh=7FDnoGOm0q9dE2qKTPazVh/OnxjGcVT2F3gW5IE2pAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzsPgOx0mE3dW0+pke/FPsIroQjfEZLt9XQ1KJJTrK6JV3heO3EtYnfhUVMRGfFa/
         eTcx/YlsuxsDk+dVqHS+9y/jN7M1ko006od9gN4pzaMtX+xWdhxM7A6Zls2j2jHLBf
         b1p9lIzBZrMc4FjhYhGNXv2rFgCpL3QT8je6dwqiWkKCgPsdZP/9NQGRrdLs3affc7
         WI6mkWU57YNSXLVexQRW1hpV+iY9uBI5ZMZgDNyRXXgdtKkKAAuBzcnl+eD5m8gv5W
         +3QgMc0Y/SyhoI/jjbxyc1lBnOzoYO2hutjvH7m3SEOE6qeGAlAcLgmdAq88xKZiU+
         5j+6egaOrTPwA==
Date:   Tue, 9 Aug 2022 08:29:56 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        djwong@kernel.org
Subject: Re: [PATCH] generic: test fsync after punching hole adjacent to an
 existing hole
Message-ID: <20220809072956.GA2067106@falcondesktop>
References: <83a74ba89e9e4ee1060b7dfa1f190d4b51691909.1659957268.git.fdmanana@suse.com>
 <20220809033551.ip3lq5kkhvabdppn@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809033551.ip3lq5kkhvabdppn@zlang-mailbox>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 09, 2022 at 11:35:51AM +0800, Zorro Lang wrote:
> On Mon, Aug 08, 2022 at 12:18:58PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Test that if we punch a hole adjacent to an existing hole, fsync the file
> > and then power fail, the new hole exists after mounting again the
> > filesystem.
> > 
> > This currently fails on btrfs with kernels 5.18 and 5.19 when not using
> > the "no-holes" feature. The "no-holes" feature is enabled by default at
> > mkfs time starting with btrfs-progs 5.15, so to trigger the issue with
> > btrfs-progs 5.15+ and kernel 5.18 or kernel 5.19, one must set
> > "-O ^no-holes" in the MKFS_OPTIONS environment variable (part of the
> > btrfs test matrix).
> > 
> > The issue is fixed for btrfs with the following kernel patch:
> > 
> >   "btrfs: update generation of hole file extent item when merging holes"
> 
> CC btrfs list

It was already in cc (and I always cc the btrfs list).

> 
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/generic/694     | 85 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/694.out | 15 ++++++++
> >  2 files changed, 100 insertions(+)
> >  create mode 100755 tests/generic/694
> >  create mode 100644 tests/generic/694.out
> > 
> > diff --git a/tests/generic/694 b/tests/generic/694
> > new file mode 100755
> > index 00000000..c034f914
> > --- /dev/null
> > +++ b/tests/generic/694
> > @@ -0,0 +1,85 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 694
> > +#
> > +# Test that if we punch a hole adjacent to an existing hole, fsync the file and
> > +# then power fail, the new hole exists after mounting again the filesystem.
> 
> Better to explain this's a known regression test at here.

So, duplicate the changelog here?

> 
> And add _fixed_by_kernel_commit later, after that kernel patch is merged and
> has a fixed commit id.

I wasn't aware we have that nowadays.
Does that mean that tests get merged only after the corresponding kernel fix
is merged in Linus' tree?

> 
> > +#
> > +. ./common/preamble
> > +_begin_fstest quick log punch
> 
> "auto" group?

Yes, forgotten when running the "new" script.

> 
> > +
> > +_cleanup()
> > +{
> > +	_cleanup_flakey
> > +	cd /
> > +	rm -r -f $tmp.*
> > +}
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +. ./common/dmflakey
> > +. ./common/punch
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
>    ^^^^
> This's just a reminder, please remove it.
> 
> > +_supported_fs generic
> > +_require_scratch
> > +_require_dm_target flakey
> > +_require_xfs_io_command "fpunch"
> > +_require_xfs_io_command "fiemap"
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_require_metadata_journaling $SCRATCH_DEV
> > +_init_flakey
> > +_mount_flakey
> > +
> > +# Create our test file with the following layout:
> > +#
> > +# [0, 2M)    - hole
> > +# [2M, 10M)  - extent
> > +# [10M, 12M) - hole
> > +$XFS_IO_PROG -f -c "truncate 12M" \
> > +	     -c "pwrite -S 0xab 2M 8M" \
> > +	     $SCRATCH_MNT/foobar | _filter_xfs_io
> > +
> > +# Persist everything, commit the filesystem's transaction.
> > +sync
> > +
> > +# Now punch two holes in the file:
> > +#
> > +# 1) For the range [2M, 4M), which is adjacent to the existing hole in the range
> > +#    [0, 2M);
> > +# 2) For the range [8M, 10M), which is adjacent to the existing hole in the
> > +#    range [10M, 12M).
> > +#
> > +# These operations start a new filesystem transaction.
> > +# Then finally fsync the file.
> > +$XFS_IO_PROG -c "fpunch 2M 2M" \
> > +	     -c "fpunch 8M 2M" \
> > +	     -c "fsync" $SCRATCH_MNT/foobar
> 
> Darrick added a new helper _require_congruent_file_oplen(), might worth
> using it. Any thoughts?

Wasn't aware of it. Seems like it's to deal with some rare xfs realtime configurations.
So I suppose, this needs:

_require_congruent_file_oplen $((2 * 1024 * 1024))

> 
> > +
> > +# Simulate a power failure and mount the filesystem to check that everything
> > +# is in the same state as before the power failure.
> > +_flakey_drop_and_remount
> > +
> > +# We expect the following file layout:
> > +#
> > +# [0, 4M)    - hole
> > +# [4M, 8M)   - extent
> > +# [8M, 12M)  - hole
> > +echo "File layout after power failure:"
> > +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar | _filter_fiemap
> > +
> > +# When reading the file we expect to get the range [4M, 8M) filled with bytes
> > +# that have a value of 0xab and 0x00 for anything outside that range.
> > +echo "File content after power failure:"
> > +od -A d -t x1 $SCRATCH_MNT/foobar
> 
> Can _hexdump in common/rc help ?

It can, I wasn't aware that helper existed. It's relatively new.
Glad to see od is being preferred over hexdump, and I have always used it in
tests over the years.

Btw, _hexdump is asking od to output file offsets in hex.
I find it a lot more friendly to read decimal values (maybe I'm weird), so
I always pass '-A d' to od. Thoughts on that?

Thanks.

> 
> > +
> > +_unmount_flakey
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/694.out b/tests/generic/694.out
> > new file mode 100644
> > index 00000000..f55212f3
> > --- /dev/null
> > +++ b/tests/generic/694.out
> > @@ -0,0 +1,15 @@
> > +QA output created by 694
> > +wrote 8388608/8388608 bytes at offset 2097152
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +File layout after power failure:
> > +0: [0..8191]: hole
> > +1: [8192..16383]: data
> > +2: [16384..24575]: hole
> > +File content after power failure:
> > +0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > +*
> > +4194304 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> > +*
> > +8388608 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > +*
> > +12582912
> > -- 
> > 2.35.1
> > 
> 
