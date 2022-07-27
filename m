Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61262581DB7
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 04:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiG0CtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 22:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiG0CtC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 22:49:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFE126558;
        Tue, 26 Jul 2022 19:49:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8AF995C00A7;
        Tue, 26 Jul 2022 22:49:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 26 Jul 2022 22:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1658890140; x=1658976540; bh=3rz63sAiMz
        pyL5f8ngbQQ0M0uyLoyHhjwSB4LWtPJ88=; b=gXkc/ibfAbRka8xioZoTMu2Q/e
        Cv7HZChPaRapPhJP7S2w+gTtjP0iu6QC+8osQCYstcYpWyoekgVCGvh1vZyKqym/
        RERrnASZ3Cel1o0ZJuCltUQm9MjI3F85igm2HefXjJOmCJvfm0P79PFXDeWkXKXp
        bIIDMXlApks3IFJEIBenzLcc+3KfZ36ArqgsE+5qNSm2OaR1HRFXMsPQRA7XADDr
        ioCprkt8tTlXLTc5naB8NcsQJo06SBuXO7dym1K0akqFO1ZbTSO/7x2wBxoUyYEk
        eaaX6q0yYsSLx7YtxOnFIV/h309gr6BteXbxysxMahUTDDCpFcuP+Aan0jzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658890140; x=1658976540; bh=3rz63sAiMzpyL5f8ngbQQ0M0uyLo
        yHhjwSB4LWtPJ88=; b=erH7ZddbsI67DC9VpAsRa/pnok3s4uTqBHoxTXN8QbAS
        crBz5ewo0FKepL4YsCxNrMtLU3AZLdQhXUViVAiGdUl+TWPCAcx1FnXIvgkdu2vn
        tP4+ZGglOjvREzlk+EDEEOrNpcfYfmqIr8sQc+Omy8ITQWe+3q/TribLGkj5Y1KE
        pb1I75zSzYHQ7Jg049fQ+282bWYBpFHfNi/jvTyO30ueZU6LhlMx4wVl59o77JZU
        zaKfQUcQ+dTN+AEm3WWG3EGhV21UX9vZZli+FrUdcpOjO/fVApT5JzhX4YghSHYZ
        dw/yPdYo4eM10vy+6eu9kqUjiet78IVnkv1Pf2bgEA==
X-ME-Sender: <xms:nKfgYuHdwS0qI6kQkhsxnVduv5KylOxLx1IC6CpqRViiXDJiHE0JYQ>
    <xme:nKfgYvW6RZqezPQCc9Sj7KcRHMYuYWVbHo4YYTiXBWPUsCxKk38I-jsVbsrS2TRwQ
    tXUsT7sggO-h1kpP6s>
X-ME-Received: <xmr:nKfgYoIQ5RxMNnb9nYqgrhQnSbjZf2EZDIcbVfqfxcPZO0f7VhpHVoRvHxAHpn4a-y7cKtobfyRBRztwdLwxoxSwKvsCcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduuddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:nKfgYoE_GFMuvvhFwW3JFZVC8FJvYunr-EFD7BUTzCRZyCcwfv1VjA>
    <xmx:nKfgYkW0kM9oCX2slzU7p6jbMl6IspFDwSgZi7z8mB9z-zPyYJMuCA>
    <xmx:nKfgYrNbFenpdSYEihE-1e2S8q_qy3Plki5OsSvOpsAZYHZLENe1BQ>
    <xmx:nKfgYhglYkfmmbn_mpm8ux5w0BQzF0CbU9MnZMu5bLypFTsEPGEmOg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 22:48:59 -0400 (EDT)
Date:   Tue, 26 Jul 2022 19:49:38 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: add test case to make sure btrfs can handle one
 corrupted device
Message-ID: <YuCnwgjL0BfTh9Qw@zen>
References: <20220726062948.56315-1-wqu@suse.com>
 <YuB0RD9fx5nBnv2m@zen>
 <340382bc-6428-ffc3-1b1f-82d8408a5883@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <340382bc-6428-ffc3-1b1f-82d8408a5883@gmx.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 27, 2022 at 09:39:46AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/7/27 07:09, Boris Burkov wrote:
> > On Tue, Jul 26, 2022 at 02:29:48PM +0800, Qu Wenruo wrote:
> > > The new test case will verify that btrfs can handle one corrupted device
> > > without affecting the consistency of the filesystem.
> > > 
> > > Unlike a missing device, one corrupted device can return garbage to the fs,
> > > thus btrfs has to utilize its data/metadata checksum to verify which
> > > data is correct.
> > 
> > > 
> > > The test case will:
> > > 
> > > - Create a small fs
> > >    Mostly to speedup the test
> > > 
> > > - Fill the fs with a regular file
> > > 
> > > - Use fsstress to create some contents
> > > 
> > > - Save the fssum for later verification
> > > 
> > > - Corrupt one device with garbage but keep the primary superblock
> > >    untouched
> > > 
> > > - Run fssum verification
> > > 
> > > - Run scrub to fix the fs
> > > 
> > > - Run scrub again to make sure the fs is fine
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > Works for me, and looks like a nice test to complement btrfs/027.
> > Reviewed-by: Boris Burkov <boris@bur.io>
> > 
> > > ---
> > >   tests/btrfs/261     | 94 +++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/btrfs/261.out |  2 +
> > >   2 files changed, 96 insertions(+)
> > >   create mode 100755 tests/btrfs/261
> > >   create mode 100644 tests/btrfs/261.out
> > > 
> > > diff --git a/tests/btrfs/261 b/tests/btrfs/261
> > > new file mode 100755
> > > index 00000000..15218e28
> > > --- /dev/null
> > > +++ b/tests/btrfs/261
> > > @@ -0,0 +1,94 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test 261
> > > +#
> > > +# Make sure btrfs raid profiles can handling one corrupted device
> > > +# without affecting the consistency of the fs.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest raid
> > > +
> > > +. ./common/filter
> > > +. ./common/populate
> > > +
> > > +_supported_fs btrfs
> > > +_require_scratch_dev_pool 4
> > > +_require_fssum
> > > +
> > > +prepare_fs()
> > > +{
> > > +	local profile=$1
> > > +
> > > +	# We don't want too large fs which can take too long to populate
> > > +	# And the extra redirection of stderr is to avoid the RAID56 warning
> > > +	# message to polluate the golden output
> > > +	_scratch_pool_mkfs -m $profile -d $profile -b 1G >> $seqres.full 2>&1
> > > +	if [ $? -ne 0 ]; then
> > > +		echo "mkfs $mkfs_opts failed"
> > > +		return
> > > +	fi
> > > +
> > > +	# Disable compression, as compressed read repair is known to have problems
> > > +	_scratch_mount -o compress=no
> > > +
> > > +	# Fill some part of the fs first
> > > +	$XFS_IO_PROG -f -c "pwrite -S 0xfe 0 400M" $SCRATCH_MNT/garbage > /dev/null 2>&1
> > > +
> > > +	# Then use fsstress to generate some extra contents.
> > > +	# Disable setattr related operations, as it may set NODATACOW which will
> > > +	# not allow us to use btrfs checksum to verify the content.
> > > +	$FSSTRESS_PROG -f setattr=0 -d $SCRATCH_MNT -w -n 3000 > /dev/null 2>&1
> > > +	sync
> > > +
> > > +	# Save the fssum of this fs
> > > +	$FSSUM_PROG -A -f -w $tmp.saved_fssum $SCRATCH_MNT
> > > +	$BTRFS_UTIL_PROG fi show $SCRATCH_MNT >> $seqres.full
> > > +	_scratch_unmount
> > > +}
> > > +
> > > +workload()
> > > +{
> > > +	local target=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> > > +	local profile=$1
> > > +	local num_devs=$2
> > > +
> > > +	_scratch_dev_pool_get $num_devs
> > > +	echo "=== Testing profile $profile ===" >> $seqres.full
> > > +	rm -f -- $tmp.saved_fssum
> > > +	prepare_fs $profile
> > > +
> > > +	# Corrupt the target device, only keep the superblock.
> > > +	$XFS_IO_PROG -c "pwrite 1M 1023M" $target > /dev/null 2>&1
> > > +
> > > +	_scratch_mount
> > > +
> > > +	# All content should be fine
> > > +	$FSSUM_PROG -r $tmp.saved_fssum $SCRATCH_MNT > /dev/null
> > > +
> > > +	# Scrub to fix the fs, this is known to report various correctable
> > > +	# errors
> > > +	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
> > > +
> > > +	# Make sure above scrub fixed the fs
> > > +	$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full
> > > +	if [ $? -ne 0 ]; then
> > > +		echo "scrub failed to fix the fs for profile $profile"
> > > +	fi
> > > +	_scratch_unmount
> > > +	_scratch_dev_pool_put
> > > +}
> > > +
> > > +workload raid1 2
> > > +workload raid1c3 3
> > > +workload raid1c4 4
> > > +workload raid10 4
> > > +workload raid5 3
> > > +workload raid6 4
> > 
> > Speaking of 027,
> > 
> > Can you implement this with _btrfs_profile_configs?
> 
> In fact _btrfs_profile_configs() is what I went initially, but the
> following factors prevent it from being used:
> 
> - No way to specify the number of devices
>   That's not a big deal though.
> 
> - No way to skip unsupported profiles
>   Like DUP/SINGLE can not meet the duplication requirement.

It takes an argument and if you pass "replace-missing" I think it does
what you want. You could also add another string it accepts for
different semantics.

> 
> 
> And since _btrfs_profiles_configs() directly provides the mkfs options,
> it's not easy to just pick what we need.
> 
> Personally speaking, it would be much easier if we make
> _btrfs_profiles_configs() to just return a profile, not full mkfs options.

Giving the caller more flexibility with their call to mkfs does seem
like a good idea to me.

> 
> > 
> > Further, you could imagine writing a more generic test that does:
> > for raid in raids:
> >          create-fs raid
> >          screw-up disk(s)
> >          check-condition
> 
> I have seen some helper in `common/populate`, but unfortunately it only
> supports XFS and EXT4.
> 
> It may be a good idea to enhance that file though.

Cool, never noticed that before. Would be interesting to make it work
with btrfs.

> 
> Thanks,
> Qu
> 
> > 
> > and make 027 and this new one (and others?) special cases of that.
> > I think this might fall under YAGNI.. Food for thought :)
> > 
> > > +
> > > +echo "Silence is golden"
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/261.out b/tests/btrfs/261.out
> > > new file mode 100644
> > > index 00000000..679ddc0f
> > > --- /dev/null
> > > +++ b/tests/btrfs/261.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 261
> > > +Silence is golden
> > > --
> > > 2.36.1
> > > 
