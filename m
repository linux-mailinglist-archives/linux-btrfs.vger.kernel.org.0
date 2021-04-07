Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026A6357601
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 22:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356085AbhDGU1y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 16:27:54 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:35499 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346653AbhDGU1a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Apr 2021 16:27:30 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 37D7C1617;
        Wed,  7 Apr 2021 16:27:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Apr 2021 16:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=tCimCVJAnxLonZBtA/9HgfrO5V/
        YZBQJy8VpwTiQeSc=; b=Barjoru/V672AN+cRVG9fM6THLYU/x2pXsdRqRm8wlT
        EeV6nCFlFoiYava8WuC4FdCRSoAS3DyC//qpnnWlFJpVw7dD7suuotnyFoJ1Z1mB
        WzBbgMSc712bmqpxtA5Gb1z3osWD4v0KfQ3EV+DVj3VcZfdk1xynLnLi1/EL57Wl
        lsH2ymYLMZ+hSoR42PewnuFR10JLgT+BGegwcsLUoXO2h2zHGfDSDYzK3I3ZJcIW
        Ul5nDW4mB104YnldPQ+qmVBTkEl0o/3u2Wste0y0DYo0dm3xceb6IDI9AiaXIbvt
        CJoObJVyPM1AxBsWhWG2/SCVCnqWUp0JDtYcoY3ne6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=tCimCV
        JAnxLonZBtA/9HgfrO5V/YZBQJy8VpwTiQeSc=; b=HLyLTnYcbkrcCnt2paOpMS
        5eKgSDX9Hj/6kuIxjrQO3HTcb931SGxwUotQXlTctv7Sv1eWBzWJR8dwrchJs8mB
        ov0LGr3CbMmFiieFwWnr4vgGFDsTczM7kqRkNXD09d/Y0+brJ+FAXbYy5FFxR+OU
        1Q+UweYKmMBl9I9NgvimWDwFAV3p3Me2hKGV47H0M+G4mObX5xsrgfa2HNL1YYx9
        DvqfuF7Neb+mVmUcFZTFR4BACFsmmxoBteNv6co/eg70IFsOfGJ3SFnNr+w3FEVM
        ZbLEk7T+CiQYITmx1zZthuTl2k3BLo5C7MLgNVd66AMmEftIzwWSaq0Pfvl93GdQ
        ==
X-ME-Sender: <xms:pxVuYBkNZgj_c2P9kk8_tOI6ylYZQes1CGYhpJKumHY25lW3kBgLcQ>
    <xme:pxVuYKxRfVr8sGmHy5TqYBazYP7KeIFfTwgt2u33yRaVj7on3ux2mX3RFv1S9rYVY
    qoJrOMKjf__WQSdzp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejjedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    dtvdfftddvveduieejtedufeeuudefueefhfdujedutdegtddtffffiefgtefgtdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdejrdehfedrvdehfedrjeenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhs
    segsuhhrrdhioh
X-ME-Proxy: <xmx:pxVuYJ-PvYj7TihmUnDbgNvhfDaZGZcUkGbVze3wYYlHF6iTK_dnCQ>
    <xmx:pxVuYGJbFhn7fPSX4Z3UZytHwVsrUx6_SEYOrHSyFsh_lGL-IPK8VA>
    <xmx:pxVuYHdk5OJUOZK4FgaFcaw6eVmbk54MSoT5Cn-RnnRfy1Nl-cBSiA>
    <xmx:pxVuYOEGaozyZRClah5TKiVbM7xL0PBluLR8kIcuNUgCPgf7VOMwvA>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7C82724005D;
        Wed,  7 Apr 2021 16:27:19 -0400 (EDT)
Date:   Wed, 7 Apr 2021 13:27:18 -0700
From:   Boris Burkov <boris@bur.io>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic: test fiemap offsets and < 512 byte ranges
Message-ID: <YG4VkCWy3BK2zwnr@zen>
References: <4098b7c2a597f2f6d624ce1b3f2741a381c588b7.1617749158.git.boris@bur.io>
 <189e96b6dfccc54ec44879456488977c95b3efda.1617749523.git.boris@bur.io>
 <20210407161046.GY1670408@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407161046.GY1670408@magnolia>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 07, 2021 at 09:10:46AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 06, 2021 at 03:54:29PM -0700, Boris Burkov wrote:
> > btrfs trims fiemap extents to the inputted offset, which leads to
> > inconsistent results for most inputs, and downright bizarre outputs like
> > [7..6] when the trimmed extent is at the end of an extent and shorter
> > than 512 bytes.
> > 
> > This test covers a bunch of cases like that and ensures that file
> > systems always return the full extent without trimming it.
> > 
> > I also ran it under ext2, ext3, ext4, f2fs, and xfs successfully, but I
> > suppose it's no guarantee that every file system will store a 4k synced
> > write in a single extent. For that reason, this might be a bit fragile.
> 
> Does it work with 64k fs blocks?  Or 512b blocks? :)
> 

I don't have easy access to a means of testing with 64k blocks, but I
did test the more flexible v3 on 512, 1024, 2048, and 4096 byte blocks.

> Also... is there an xfs_io fix to go with this?
> 

Since the xfs_bmap manpage says that it outputs in 512 byte chunks and
the xfs_io manpage says fiemap should output the full extent, I figured
this was a case of garbage-in-garbage-out.

Do you think xfs_io fiemap should handle these <=512 byte cases more
permissively? With xfs and -b size=512, I got:
0: [0..0]: 11..11
which might really be a bug.

> > 
> > This test is fixed for btrfs by:
> > btrfs: return whole extents in fiemap
> > (https://lore.kernel.org/linux-btrfs/274e5bcebdb05a8969fc300b4802f33da2fbf218.1617746680.git.boris@bur.io/)
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > 
> > --
> > v2: fill out copyright and test description
> > 
> > ---
> >  tests/generic/623     | 94 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/623.out |  2 +
> >  tests/generic/group   |  1 +
> >  3 files changed, 97 insertions(+)
> >  create mode 100755 tests/generic/623
> >  create mode 100644 tests/generic/623.out
> > 
> > diff --git a/tests/generic/623 b/tests/generic/623
> > new file mode 100755
> > index 00000000..85ef68f6
> > --- /dev/null
> > +++ b/tests/generic/623
> > @@ -0,0 +1,94 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Facebook.  All Rights Reserved.
> > +#
> > +# FS QA Test 623
> > +#
> > +# Test fiemaps with offsets into small parts of extents.
> > +# Expect to get the whole extent, anyway.
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_require_test
> > +_require_scratch
> > +_require_xfs_io_command "fiemap"
> > +
> > +rm -f $seqres.full
> > +
> > +_do_fiemap() {
> > +	off=$1
> > +	len=$2
> > +	$XFS_IO_PROG -c "fiemap $off $len" $SCRATCH_MNT/foo
> > +}
> > +
> > +_check_fiemap() {
> 
> Only helper functions in common/ need to be prefixed with "_".
> 
> > +	off=$1
> > +	len=$2
> > +	actual=$(_do_fiemap $off $len | tee -a $seqres.full)
> > +	[ "$actual" == "$expected" ] || _fail "unexpected fiemap on $off $len"
> > +}
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> 
> You could probably accomplish this by creating a file on the test
> device, which means this test would run on configurations where there's
> no scratch device; and run faster since there's no longer any need for
> mkfs.
> 
> --D
> 

Thanks for the review,
Boris

> > +
> > +# write a file with one extent
> > +$XFS_IO_PROG -f -s -c "pwrite -S 0xcf 0 4K" $SCRATCH_MNT/foo >/dev/null
> > +
> > +# since the exact extent location is unpredictable especially when
> > +# varying file systems, just test that they are all equal, which is
> > +# what we really expect.
> > +expected=$(_do_fiemap)
> > +
> > +# start to mid-extent
> > +_check_fiemap 0 2048
> > +# start to end
> > +_check_fiemap 0 4096
> > +# start to past-end
> > +_check_fiemap 0 4097
> > +# mid-extent to mid-extent
> > +_check_fiemap 1024 2048
> > +# mid-extent to end
> > +_check_fiemap 2048 4096
> > +# mid-extent to past-end
> > +_check_fiemap 2048 4097
> > +
> > +# to end; len < 512
> > +_check_fiemap 4091 5
> > +# to end; len == 512
> > +_check_fiemap 3584 512
> > +# past end; len < 512
> > +_check_fiemap 4091 500
> > +# past end; len == 512
> > +_check_fiemap 4091 512
> > +
> > +_scratch_unmount
> > +
> > +echo "Silence is golden"
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/623.out b/tests/generic/623.out
> > new file mode 100644
> > index 00000000..6f774f19
> > --- /dev/null
> > +++ b/tests/generic/623.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 623
> > +Silence is golden
> > diff --git a/tests/generic/group b/tests/generic/group
> > index b10fdea4..39e02383 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -625,3 +625,4 @@
> >  620 auto mount quick
> >  621 auto quick encrypt
> >  622 auto shutdown metadata atime
> > +623 auto quick
> > -- 
> > 2.30.2
> > 
