Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D9D49E16B
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 12:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240771AbiA0Loq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 06:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240769AbiA0Lom (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 06:44:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86890C06173B;
        Thu, 27 Jan 2022 03:44:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 431C0B82217;
        Thu, 27 Jan 2022 11:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71631C340EB;
        Thu, 27 Jan 2022 11:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643283880;
        bh=hQI3EfcCbGsSFqzdDu7D2ZyFkjeE8dMUkFGLZq0oJ94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXLKrQ9T6oL9CcOaM9sjjHNmiJ9XDxnWdm0R47whXMwFX5dC8Y8zwYCtjsv6WvbbB
         vrKICe7bA/dPcsT+y7j1kDNmQS8r4wtirGjIIv5Bagz+cbChEN6kpEhVb1ZTwlFsyB
         cwtfMnpLrYFiqfvEomJLLOrh9Fl59vq5sme+7sGK54CaFegz1BSrzPqYz/PCqTbbkX
         RuhUPtvz92giA9xGZQMebGm+KVqvuq6Zg40/TVrvX6lCS+Q0NfLEp10/vUEjawf2CL
         wXXol5HGkviz/74t2KgS/k+6MlHXQadSbDG6HOtQhkn0fN9PgDq7nGwNUhZJaNNtGO
         s071VKySI3Ydw==
Date:   Thu, 27 Jan 2022 11:44:37 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add test case to verify that btrfs won't waste
 IO/CPU to defrag compressed extents already at their max size
Message-ID: <YfKFpcV2fGjlV2XX@debian9.Home>
References: <20220127055306.30252-1-wqu@suse.com>
 <YfKECmpfxywWUGu/@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfKECmpfxywWUGu/@debian9.Home>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 27, 2022 at 11:37:46AM +0000, Filipe Manana wrote:
> On Thu, Jan 27, 2022 at 01:53:06PM +0800, Qu Wenruo wrote:
> > There is a long existing bug in btrfs defrag code that it will always
> > try to defrag compressed extents, even they are already at max capacity.
> > 
> > This will not reduce the number of extents, but only waste IO/CPU.
> > 
> > The kernel fix is titled:
> > 
> >   btrfs: defrag: don't defrag extents which is already at its max capacity
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  tests/btrfs/257     | 79 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/257.out |  2 ++
> >  2 files changed, 81 insertions(+)
> >  create mode 100755 tests/btrfs/257
> >  create mode 100644 tests/btrfs/257.out
> > 
> > diff --git a/tests/btrfs/257 b/tests/btrfs/257
> > new file mode 100755
> > index 00000000..326687dc
> > --- /dev/null
> > +++ b/tests/btrfs/257
> > @@ -0,0 +1,79 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 257
> > +#
> > +# Make sure btrfs defrag ioctl won't defrag compressed extents which are already
> > +# at their max capacity.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick defrag
> 
> Missing the 'compress' group.
> 
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +. ./common/btrfs
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +_require_scratch
> > +
> > +# Needs 4K sectorsize, as larger sectorsize can change the file layout.
> > +_require_btrfs_support_sectorsize 4096
> 
> Hum?
> I don't understand why that's needed for this test.
> The maximum size of a compressed extent is the same for all sector sizes.
> 
> > +
> > +get_extent_disk_sector()
> > +{
> > +	local file=$1
> > +	local offset=$2
> > +
> > +	$XFS_IO_PROG -c "fiemap $offset" "$file" | _filter_xfs_io_fiemap |\
> > +		head -n1 | $AWK_PROG '{print $3}'
> > +}
> 
> This is copy pasted from the previous test:
> 
> https://lore.kernel.org/linux-btrfs/20220127054543.28964-1-wqu@suse.com/T/#u
> 
> Could go somewhere into common/*, if there isn't already anything providing
> the same functionality.
> 
> > +
> > +_scratch_mkfs >> $seqres.full
> > +
> > +# Need datacow to show which range is defragged, and we're testing
> > +# autodefrag with compression
> > +_scratch_mount -o datacow,autodefrag,compress
> 
> The autodefrag is not needed. We are triggering a manual defrag below, and
> that's all that's needed to trigger the issue.

-o datacow is superfluous here, as compression forces COW.

Also, this got to be the longest commit subject I had ever seen :)

  >>> len("btrfs: add test case to verify that btrfs won't waste IO/CPU to defrag compressed extents already at their max size")
  115

Something shorter like "btrfs: test defrag with compressed extents" would be
perfectly fine, further details can be left in the changelog and comments in
the test case.

> 
> > +
> > +# Btrfs uses 128K as compressed extent max size, so this would result
> > +# exactly two extents, which are all at their max size
> > +$XFS_IO_PROG -f -c "pwrite -S 0xee 0 128k" -c sync \
> > +		-c "pwrite -S 0xff 128k 128k" -c sync \
> > +		$SCRATCH_MNT/foobar >> $seqres.full
> 
> We don't need to do a sync after every write. If you write 256K at once,
> it will result in 2 128K extents anyway. The comment and the way we are
> calling xfs_io gives the wrong idea that user space can influence the max
> extent size.
> 
> A more interesting test would be, say, to write 2M or 4M at once for
> example, which will result in many 128K extents. It would also make the
> test more robust in case the default defrag threshold changes one day
> for some reason (e.g. btrfs-progs might decide to start calling the
> ioctl with a higher threshold one day). And then just check that the
> output of fiemap is the same before and after the defrag attempt, so
> it's not even necessary to manually compare the sectors of each
> extent and use get_extent_disk_sector().
> 
> Thanks.
> 
> > +
> > +old_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
> > +old_extent1=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
> > +old_extent2=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 128k)
> > +
> > +echo "=== File extent layout before defrag ===" >> $seqres.full
> > +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> > +
> > +$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/foobar" >> $seqres.full
> > +
> > +new_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
> > +new_extent1=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
> > +new_extent2=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 128k)
> > +
> > +echo "=== File extent layout before defrag ===" >> $seqres.full
> > +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> > +
> > +if [ $new_csum != $old_csum ]; then
> > +	echo "file content changed"
> > +fi
> > +
> > +if [ $new_extent1 != $old_extent1 ]; then
> > +	echo "the first extent get defragged"
> > +fi
> > +
> > +if [ $new_extent2 != $old_extent2 ]; then
> > +	echo "the second extent get defragged"
> > +fi
> > +
> > +echo "Silence is golden"
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/257.out b/tests/btrfs/257.out
> > new file mode 100644
> > index 00000000..cc3693f3
> > --- /dev/null
> > +++ b/tests/btrfs/257.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 257
> > +Silence is golden
> > -- 
> > 2.34.1
> > 
