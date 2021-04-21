Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825BB36733E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 21:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245424AbhDUTOR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 15:14:17 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54329 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240378AbhDUTOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 15:14:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 774985C00E5;
        Wed, 21 Apr 2021 15:13:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Apr 2021 15:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=HaNcDj2Dy45Ew1bbGSpgh9uPCI8
        reXGG9hVynycGfqU=; b=WPEd/NT3TYSeVIpbA2tQVA1k3Av2XE9hNyfjnt6TMW2
        wdD7Gf0SRqnZlpe47CkhEHnEW4Q4azcEKUTljD2Rt7p5gki2gNH87gcCmM6kiUHC
        RwvCRNPwk2/Yh+nIIQ9fL1kkVigAcV4kEoS/HvcpZ9Unv2kmdf9N0LulFmiNQyk3
        Jyvo/tnXss6RoLLNxM8y7aD4VAAwgEAz37V/sFYMeK9sqTPf69+y4gsU5SSg3SXu
        rqXgng3mft4u4+osTr9pZZy1v5DQFjBGRNxE3NIM1yD+Ep+KpL1K3MqnMLk1gFdC
        731f6lBGAVPYKrrVko7Z7NkomTpRBvw/GdQae/rp6Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=HaNcDj
        2Dy45Ew1bbGSpgh9uPCI8reXGG9hVynycGfqU=; b=PfyK0eaVETPxuAZkOzx5hc
        /JEatK72zBJ1tuX957+xz/CB5YmGAN63JO3S5uGSShG2uudAFutogksCuX7NvLDK
        acUFFA3gaMeo48r5fzIXwf0Epcu3wLt6RN9ZvlpKcf7BWHwEw7/cS3w1Z+Fg9jd/
        WqOukwxYw5djAUnTGZpjUB/8Zjp4Ddy0PqzNw96EKEU15pQjsxCUp+rpfkqYt8hi
        huvoS6OVc089++Pb4z7SSCiNIAEVtHCHfqm/0co6HAhNAinCFTcsSpPGpGvLYZrl
        hDOUQdnBKBwDH7VPiJwisKZsf3pk1p/yHoL4sV63u6G8S4GrwVz19eWVTC1zC92Q
        ==
X-ME-Sender: <xms:X3mAYM3Usm0lXfy6j3tR_gGUuioK7KZTiZR3_cFfOSMZ8nBs7XMrFA>
    <xme:X3mAYDHHCDS4lkTgTKSyOP08iDVu4C5YVUaLAcMwevIYZjCmH9evchlUdbg8ov4p2
    SMJO82ASM-2UH-lmJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtkedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    dtvdfftddvveduieejtedufeeuudefueefhfdujedutdegtddtffffiefgtefgtdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdejrdehfedrvdehfedrjeenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhs
    segsuhhrrdhioh
X-ME-Proxy: <xmx:X3mAYHEmoqxhDhD136Q6huNTXjV_soASbZQVU99H3IVVsJjpCySoCw>
    <xmx:X3mAYG7Ec9BCnbWePtE962cOZuu3qWjzENT33sDguWW3u6TNMz0e8w>
    <xmx:X3mAYMxLS8S7ivRGOvqZEwsmB6voMOEGmIc9ESRxEhP_hvxxoFN5rA>
    <xmx:X3mAYMjbdND41xEfcLvIvRVqhDByJXPNC25JyJsvuFcCJBe8zvkWJw>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0D9BE240067;
        Wed, 21 Apr 2021 15:13:34 -0400 (EDT)
Date:   Wed, 21 Apr 2021 12:13:33 -0700
From:   Boris Burkov <boris@bur.io>
To:     Eryu Guan <guan@eryu.me>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic: test fiemap offsets and < 512 byte ranges
Message-ID: <YIB5XbY2PX4J5dlN@zen>
References: <20210407161046.GY1670408@magnolia>
 <c2f49fdead29fd7eb979b83028eb9fcf56d2457c.1617826068.git.boris@bur.io>
 <YHMBzw/9tUVMS66G@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHMBzw/9tUVMS66G@desktop>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 11, 2021 at 10:03:59PM +0800, Eryu Guan wrote:
> On Wed, Apr 07, 2021 at 01:13:26PM -0700, Boris Burkov wrote:
> > btrfs trims fiemap extents to the inputted offset, which leads to
> > inconsistent results for most inputs, and downright bizarre outputs like
> > [7..6] when the trimmed extent is at the end of an extent and shorter
> > than 512 bytes.
> > 
> > The test writes out one extent of the file system's block size and tries
> > fiemaps at various offsets. It expects that all the fiemaps return the
> > full single extent.
> > 
> > I ran it under the following fs, block size combinations:
> > ext2: 1024, 2048, 4096
> > ext3: 1024, 2048, 4096
> > ext4: 1024, 2048, 4096
> > xfs: 512, 1024, 2048, 4096
> > f2fs: 4096
> > btrfs: 4096
> > 
> > This test is fixed for btrfs by:
> > btrfs: return whole extents in fiemap
> > (https://lore.kernel.org/linux-btrfs/274e5bcebdb05a8969fc300b4802f33da2fbf218.1617746680.git.boris@bur.io/)
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> generic/473, which tests fiemap, has been marked as broken, as fiemap
> behavior is not consistent across filesystems, and the specific behavior
> tested by generic/473 is not defined and filesystems could have
> different implementations.
> 
> I'm not sure if this test fits into the undefined-behavior fiemap
> categary. I think it's fine if it tests a well-defined & consistent
> behavior.
> 

Interesting, I didn't know about that test being marked as broken.

I was worried about this problem to some extent and attempted to
mitigate it by only requiring that all the output be the same, rather
than matching some specific standard.

Thinking about it further, I think this test is portable only so long as
the step where it writes a file with one extent is portable.

If "pwrite 0 block-size" ends up as a file with multiple extents, then
it is possible one of the partial fiemaps will only intersect with a
subset of the extents and rightly return those. In fact, that was broken
in the original version of the test which explicitly used 4096 instead of
being detecting the block size.

I do think it is nice to have this as a regression test for btrfs, since
we have pretty complicated logic for fiemap and it was so broken in this
case. If you prefer, I can make this a btrfs specific test.

Thanks for the review,
Boris

> > ---
> > v3: make the block size more generic, use test dev instead of scratch,
> > cleanup style issues.
> > v2: fill out copyright and test description
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
> > index 00000000..a5ef369a
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
> > +	rm -f $fiemap_file
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
> > +_require_xfs_io_command "fiemap"
> > +
> > +rm -f $seqres.full
> > +
> > +fiemap_file=$TEST_DIR/foo.$$
> > +
> > +do_fiemap() {
> > +	off=$1
> > +	len=$2
> > +	echo $off $len >> $seqres.full
> > +	$XFS_IO_PROG -c "fiemap $off $len" $fiemap_file | tee -a $seqres.full
> > +}
> > +
> > +check_fiemap() {
> > +	off=$1
> > +	len=$2
> > +	actual=$(do_fiemap $off $len)
> > +	[ "$actual" == "$expected" ] || _fail "unexpected fiemap on $off $len"
> > +}
> > +
> > +# write a file with one extent
> > +block_size=$(_get_block_size $TEST_DIR)
> > +$XFS_IO_PROG -f -s -c "pwrite -S 0xcf 0 $block_size" $fiemap_file >/dev/null
> > +
> > +# since the exact extent location is unpredictable especially when
> > +# varying file systems, just test that they are all equal, which is
> > +# what we really expect.
> > +expected=$(do_fiemap)
> > +
> > +mid=$((block_size / 2))
> > +almost=$((block_size - 5))
> > +past=$((block_size + 1))
> > +
> > +check_fiemap 0 $mid
> > +check_fiemap 0 $block_size
> > +check_fiemap 0 $past
> > +check_fiemap $mid $almost
> > +check_fiemap $mid $block_size
> > +check_fiemap $mid $past
> > +check_fiemap $almost 5
> > +check_fiemap $almost 6
> > +
> > +# fiemap output explicitly deals in 512 byte increments,
> > +# so exercise some cases where len is 512.
> > +# Naturally, some of these can't work if block size is 512.
> > +one_short=$((block_size - 512))
> > +check_fiemap 0 512
> > +check_fiemap $one_short 512
> > +check_fiemap $almost 512
> > +
> > +_test_unmount
> 
> Any reason to umount TEST_DEV?
> 
> Thanks,
> Eryu
> 
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
