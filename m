Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EC2605462
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 02:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiJTALj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 20:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJTALi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 20:11:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3C21C4913;
        Wed, 19 Oct 2022 17:11:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4CBF8CE2465;
        Thu, 20 Oct 2022 00:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9F1C433D6;
        Thu, 20 Oct 2022 00:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666224692;
        bh=wDS9z8CGlnO6Y6swJ/5DTK2JfvC6zDDT5yljSRvxlhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1nSdEJptZOmgO6IH/LwuE6Jom5LAlUPRbFLANDuXJ9F8CdPM1TeklTNTgCjU+neF
         UPC925sSKPBmVfylOZTD0hFUSfca7b+c5TZhVyIneErur6FqvfjdwVloIV27Um7qJP
         RYdRhSvIMQvwaBAO1K4h0/ZwMXJmScsYES6HQzA0Sxqw4xiVnIQLeg50yH08ZeLVak
         txZulTTMcfIB/XfnOpEWJH3Yovh2v/K88QSf0wf3OSagy9BSSccJwL0urj7k39zzaT
         /7Dk905C1mpfu5Fq6rrUHkoXNXjMs8SlRlVipBe1JviAu1zZCNWh4mazdcOmpo2k1s
         Y0xa2N+dY3fuA==
Date:   Wed, 19 Oct 2022 17:11:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic: check if one fs can detect damage at/after fs
 thaw
Message-ID: <Y1CSNK1QHnQOYkC1@magnolia>
References: <20221019052955.30484-1-wqu@suse.com>
 <Y1AZl3o+iSqNZgMw@magnolia>
 <cb39519d-8e31-5f39-71fe-ebb0a886780e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb39519d-8e31-5f39-71fe-ebb0a886780e@gmx.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 20, 2022 at 06:52:36AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/10/19 23:36, Darrick J. Wong wrote:
> > On Wed, Oct 19, 2022 at 01:29:55PM +0800, Qu Wenruo wrote:
> > > [BACKGROUND]
> > > There is bug report from btrfs mailing list that, hiberation can allow
> > 
> > "hibernation".
> > 
> > > one to modify the frozen filesystem unexpectedly (using another OS).
> > > (https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com/)
> > > 
> > > Later btrfs adds the check to make sure the fs is not changed
> > > unexpectedly, to prevent corruption from happening.
> > > 
> > > [TESTCASE]
> > > Here the new test case will create a basic filesystem, fill it with
> > > something by using fsstress, then sync the fs, and finally freeze the fs.
> > > 
> > > Then corrupt the whole fs by overwriting the block device with 0xcd
> > > (default seed from xfs_io pwrite command).
> > > 
> > > Finally we thaw the fs, and try if we can create a new file.
> > > 
> > > for EXT4, it will detect the corruption at touch time, causing -EUCLEAN.
> > 
> > Heh, yikes.  That's pretty scary for ext4 since it still uses buffer
> > heads from the block device to read/store metadata and older kernels are
> > known to have crashing problems if (say) the feature bits in the primary
> > superblock get changed.
> > 
> > I wonder if this should force errors=remount-ro for ext4 since
> > errors=continue is dangerous and erorrs=panic will crash the test
> > machine.
> > 
> > > For Btrfs, it will detect the corruption at thaw time, marking the
> > > fs RO immediately, and later touch will return -EROFS.
> > 
> > What /does/ btrfs check, specifically?
> 
> - Read sb without using cache
> 
> - The same mount time sanity checks on the superblock
>   Which already implies an fsid check.
> 
> - Extra generation check
>   To make sure no one has touched out cake.

Ah, ok, so you compare the ondisk super with the incore version and
complain if they don't match.  Makes sense.

> >  Reading this makes me wonder if
> > xfs shouldn't re-read its primary super on thaw to check that nobody ran
> > us over with a backhoe, though that wouldn't help us in the hibernation
> > case.  (Or does it?  Is userspace/systemd finally smart enough to freeze
> > filesystems?)
> 
> I doubt if userspace/systemd is that smart, because the error report is
> running not-that-old distro.
> 
> Especially for hibernation there is really no way for anyone to know if
> our cakes are touched.

Yeah, short of encrypting the primary super. :)

> > 
> > > For XFS, it will detect the corruption at touch time, return -EUCLEAN.
> > > (Without the cache drop, XFS seems to be very happy using the cache info
> > > to do the work without any error though.)
> > 
> > Yep.
> > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   tests/generic/702     | 61 +++++++++++++++++++++++++++++++++++++++++++
> > >   tests/generic/702.out |  2 ++
> > >   2 files changed, 63 insertions(+)
> > >   create mode 100755 tests/generic/702
> > >   create mode 100644 tests/generic/702.out
> > > 
> > > diff --git a/tests/generic/702 b/tests/generic/702
> > > new file mode 100755
> > > index 00000000..fc3624e1
> > > --- /dev/null
> > > +++ b/tests/generic/702
> > > @@ -0,0 +1,61 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test 702
> > > +#
> > > +# Test if the filesystem can detect the underlying disk has changed at
> > > +# thaw time.
> > > +#
> > > +. ./common/preamble
> > > +. ./common/filter
> > > +_begin_fstest freeze quick
> > > +
> > > +# real QA test starts here
> > > +
> > > +_supported_fs generic
> > > +_fixed_by_kernel_commit a05d3c915314 \
> > > +	"btrfs: check superblock to ensure the fs was not modified at thaw time"
> > 
> > Hmmm, it's not very useful for a test failure on (say) xfs spitting
> > out a message about how this "may" get fixed with a btrfs patch.  How
> > about:
> > 
> > $FSTYP = btrfs && _fixed_by_kernel_commit a05d3c915314 \
> > 	"btrfs: check superbloc..."
> 
> That sounds pretty good.
> 
> > 
> > > +
> > > +# We will corrupt the device completely, thus should not check it after the test.
> > > +_require_scratch_nocheck
> > > +_require_freeze
> > > +
> > > +# Limit the fs to 512M so we won't waste too much time screwing it up later.
> > > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> > > +_scratch_mount
> > > +
> > > +# Populate the fs with something.
> > > +$FSSTRESS_PROG -n 500 -d $SCRATCH_MNT >> $seqres.full
> > > +
> > > +# Sync to make sure no dirty journal
> > > +sync
> > > +
> > > +# Drop all cache, so later write will need to read from disk, increasing
> > > +# the chance of detecting the corruption.
> > > +echo 3 > /proc/sys/vm/drop_caches
> > > +
> > > +$XFS_IO_PROG -x -c "freeze" $SCRATCH_MNT
> > > +
> > > +# Now screw up the block device
> > > +$XFS_IO_PROG -f -c "pwrite 0 512M" -c sync $SCRATCH_DEV >> $seqres.full
> > 
> > directio and a larger buffer size to speed this up? e.g.
> > 
> > $XFS_IO_PROG -d -c 'pwrite -b 1m 0 512M' -c sync $SCRATCH_DEV
> 
> I guess no need for directio especially we're doing a sync after the write.
> Although larger blocksize may only help a little considering by default
> it's already buffered write.

<nod>

> > 
> > > +
> > > +# Thaw the fs, it may or may not report error, we will check it manually later.
> > > +$XFS_IO_PROG -x -c "thaw" $SCRATCH_MNT
> > 
> > I'm a little surprised you don't check for btrfs returning an error
> > here...?
> 
> Great you have asked!
> 
> This is the special pitfall related to thaw error handling.
> 
> If we return an error for .unfreeze_fs hook, the VFS treats it as we
> failed to thaw the fs, and will still consider the fs frozen.
> 
> Thus for now, btrfs only output error message into dmesg during thaw,
> but always return 0 to workaround it.
> 
> We may want a better way for .unfreeze_fs hook to distinguish between
> "something really went wrong, but please consider it unfreezed" and
> "nope, please keep it frozen".

Ah, I guess it makes sense that you have to access the fs post-thaw to
find out if it's still alive.

--D

> Thanks,
> Qu
> 
> > 
> > > +# If the fs detects something wrong, it should trigger error now.
> > > +# We don't use the error message as golden output, as btrfs and ext4 use
> > > +# different error number for different reasons.
> > > +# (btrfs detects the change immediately at thaw time and mark the fs RO, thus
> > > +#  touch returns -EROFS, while ext4 detects the change at journal write time,
> > > +#  returning -EUCLEAN).
> > > +touch $SCRATCH_MNT/foobar >>$seqres.full 2>&1
> > > +if [ $? -eq 0 ]; then
> > > +	echo "Failed to detect corrupted fs"
> > > +else
> > > +	echo "Detected corrupted fs (expected)"
> > > +fi
> > 
> > But otherwise this test looks reasonable so far.
> > 
> > --D
> > 
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/702.out b/tests/generic/702.out
> > > new file mode 100644
> > > index 00000000..c29311ff
> > > --- /dev/null
> > > +++ b/tests/generic/702.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 702
> > > +Detected corrupted fs (expected)
> > > --
> > > 2.38.0
> > > 
