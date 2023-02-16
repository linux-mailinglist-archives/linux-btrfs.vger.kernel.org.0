Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BDE699929
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 16:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjBPPnr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 10:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjBPPnq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 10:43:46 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E034B44B6;
        Thu, 16 Feb 2023 07:43:44 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 51240320094D;
        Thu, 16 Feb 2023 10:43:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 16 Feb 2023 10:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676562220; x=1676648620; bh=2oGDTHi1in
        0xzfjQAphEBWk3BAy7eEwYkJFBhEQCiVQ=; b=lJ47lEc1y4GVOq5cBn94siNy1X
        XSH2pOjkYUn6GE64RImo9HrGphULI4qDIWjEq6D77a3YMGGtSochXOb5DprUCLfi
        1V7a+nIh6/h040WW5xOOkwXRL+yKe+i62wVZBlHdhWVYpD5NA23cA8c3txhtjor1
        hAIB3a/uGEonSTeMPpEgomuZmGRBgAD38WCpetgqMDoaZJUn7pv/9PT89g3klaRG
        2CrLcsc54KrrlVRJFXwbK7fUugV8ZkjadbNLL4jlakNEz/idsIpY4orryz4+jdtA
        IUn20sQmCKoscfu4SqfMWUjH8VjeaLCX0ZafjkdWJgUj8e9gwV9ag2TJochg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676562220; x=1676648620; bh=2oGDTHi1in0xzfjQAphEBWk3BAy7
        eEwYkJFBhEQCiVQ=; b=KkqPQvFoRT0QJc2faLTuHLT2xDkaZVoO+oNJnOOcL8gT
        o26Jrn48AfDHAfxAJiuhT1xty7y6nVgWr8MYmnUaf4EH4kvLBpxYQzWdhFiIMGYP
        nWHLO9oOuY248jGBG4dMBBf3C+p+rtna6tkv6ImNVQVupANc3XUr6A4rxDacaOPY
        7AGV7qKoEyU+nYj3r85diBMuZdQVQp/osD7P7xPY+x3rUJLfp6DrdiKhPYjq8Xnl
        BmPyT4jjFDe1AJqit1QD0pqed8yuZ/o+k2+jn732kgxCSQvhb47ppQuAQDFGKhc/
        SbsxKHcXCQPNjZ8EdjzP51ciZHKlt4Y50UMgkJvB9A==
X-ME-Sender: <xms:LE_uY5W-UXOCWut8HHBrRrRoPzx1StAA49L2peRvgnPOSnmiMilqzQ>
    <xme:LE_uY5kfWroEELGCx8F25VvIwQ-B_oiZhaKoNBZ8BjwRita_8gZxdv1NSBOWqxfDQ
    Ve4Y9zv4qukQQNaE6g>
X-ME-Received: <xmr:LE_uY1ZCLxeO5wZ5Q6hcoyPo2tqEZRxaGDdpN3GBOIwyZJ5_aFwGswiJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    fgfeefjeejvdelieejleevleehgfelvdetgfeifeeiteeutdekudfgffejhefgheenucff
    ohhmrghinheptdehrdhsohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:LE_uY8Xu41QskKPRm_go8Z-NIsuCn6rhoEqyVhcH2toWGATMYygmBw>
    <xmx:LE_uYzlscR3A8HC2wNch7tilV3Sk-HHeeR3Vde4RcdGdkVkKQbkzPw>
    <xmx:LE_uY5fm-CMKkJ3tRrv0y5aXhDdh1dAch6GfJZeWZzKnbNfERCrD5A>
    <xmx:LE_uY4xn3gUmAk_iHG4FudZyK11YXTvwTxwPrzA7HARXlORuvQYkpA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Feb 2023 10:43:39 -0500 (EST)
Date:   Thu, 16 Feb 2023 07:43:38 -0800
From:   Boris Burkov <boris@bur.io>
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v6] btrfs: test block group size class loading logic
Message-ID: <Y+5PKtUX/8gyNX/w@zen>
References: <160e7557f66a6a34fd052d6834909aa02a702956.1676503163.git.boris@bur.io>
 <CAL3q7H42GK2xu9ZSAKiDUG8ZRJzgudk-3DHE9f95Sqwc0iPKyQ@mail.gmail.com>
 <20230216144952.wcr7r3hdesu2x2le@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216144952.wcr7r3hdesu2x2le@zlang-mailbox>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 16, 2023 at 10:49:52PM +0800, Zorro Lang wrote:
> On Thu, Feb 16, 2023 at 12:11:39PM +0000, Filipe Manana wrote:
> > On Wed, Feb 15, 2023 at 11:37 PM Boris Burkov <boris@bur.io> wrote:
> > >
> > > Add a new test which checks that size classes in freshly loaded block
> > > groups after a cycle mount match size classes before going down
> > >
> > > Depends on the kernel patch:
> > > btrfs: add size class stats to sysfs
> > >
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > > Changelog:
> > > v6:
> > > Actually include changes for v5 in the commit.
> > > v5:
> > > Instead of using _fixed_by_kernel_commit, use require_fs_sysfs to handle
> > > the needed sysfs file. The test is skipped on kernels without the file
> > > and runs correctly on new ones.
> > > v4:
> > > Fix dumb typo in _fixed_by_kernel_commit (left out leading underscore
> > > copy+pasting). Re-tested happy and sad case...
> > >
> > > v3:
> > > Re-add fixed_by_kernel_commit, but for the stats patch which is
> > > required, but not a fix in the strictest sense.
> > >
> > > v2:
> > > Drop the fixed_by_kernel_commit since the fix is not out past the btrfs
> > > development tree, so the fix is getting rolled in to the original broken
> > > commit. Modified the commit message to note the dependency on the new
> > > sysfs counters.
> > >
> > >
> > >  tests/btrfs/283     | 50 +++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/btrfs/283.out |  2 ++
> > >  2 files changed, 52 insertions(+)
> > >  create mode 100755 tests/btrfs/283
> > >  create mode 100644 tests/btrfs/283.out
> > >
> > > diff --git a/tests/btrfs/283 b/tests/btrfs/283
> > > new file mode 100755
> > > index 00000000..2c26b41e
> > > --- /dev/null
> > > +++ b/tests/btrfs/283
> > > @@ -0,0 +1,50 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 283
> > > +#
> > > +# Test that mounting a btrfs filesystem properly loads block group size classes.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick mount
> > 
> > I'm still curious why the 'mount' group, and I've asked for that before.
> > 
> > We aren't testing a new mount option, so it feels weird for me.
> 
> Agree, the "mount" group looks not make sense.

My mistake, sorry for overlooking this. My reasoning is that it tests
the behavior on a fresh mount rather than while the fs is live, but it
is not specific to mounting logic. Happy to remove it.

> 
> The btrfs/283 has been taken in v2023.02.05. So please make a rebase.

Done. Is there any way we can try to script this process for the future
with placeholders or something? It's kind of a drag to deal with
in general. I'm happy to send some proposal if it's something you'd be
interested in taking.

> 
> The "fixed_by_kernel_commit xxxx" part has been added and removed several times,
> does this case need it or not? Or maybe you want a _wants_kernel_commit (just
> ask for sure) ?

Thanks for checking. I personally don't think it needs it. The commit it
wants/needs is the commit that adds the sysfs file. I think that is
adequately skipped and documented by the _require_fs_sysfs that Filipe
suggested. If someone is really interested in this behavior, it is not
too hard to find the kernel commit from the sysfs file.

> 
> Others look good to me.
> 
> Thanks,
> Zorro
> 
> > 
> > Otherwise, it looks fine now. Thanks.
> > 
> > > +
> > > +sysfs_size_classes() {
> > > +       local uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
> > > +       cat "/sys/fs/btrfs/$uuid/allocation/data/size_classes"
> > > +}
> > > +
> > > +_supported_fs btrfs
> > > +_require_scratch
> > > +_require_btrfs_fs_sysfs
> > > +_require_fs_sysfs allocation/data/size_classes
> > > +
> > > +f="$SCRATCH_MNT/f"
> > > +small=$((16 * 1024))
> > > +medium=$((1024 * 1024))
> > > +large=$((16 * 1024 * 1024))
> > > +
> > > +_scratch_mkfs >/dev/null
> > > +_scratch_mount
> > > +# Write files with extents in each size class
> > > +$XFS_IO_PROG -fc "pwrite -q 0 $small" $f.small
> > > +$XFS_IO_PROG -fc "pwrite -q 0 $medium" $f.medium
> > > +$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large
> > > +# Sync to force the extent allocation
> > > +sync
> > > +pre=$(sysfs_size_classes)
> > > +
> > > +# cycle mount to drop the block group cache
> > > +_scratch_cycle_mount
> > > +
> > > +# Another write causes us to actually load the block groups
> > > +$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large.2
> > > +sync
> > > +
> > > +post=$(sysfs_size_classes)
> > > +diff <(echo $pre) <(echo $post)
> > > +
> > > +echo "Silence is golden"
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
> > > new file mode 100644
> > > index 00000000..efb2c583
> > > --- /dev/null
> > > +++ b/tests/btrfs/283.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 283
> > > +Silence is golden
> > > --
> > > 2.39.1
> > >
> > 
> 
