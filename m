Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DBF7B0B5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjI0R4x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjI0R4u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:56:50 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA8DFB;
        Wed, 27 Sep 2023 10:56:48 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 87EC6320076F;
        Wed, 27 Sep 2023 13:56:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 27 Sep 2023 13:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695837407; x=1695923807; bh=qy
        VZsJd+mwXxo/tflL9+H6BYxxKBtPvMESzVThYup7Y=; b=pF/3Ol66PymNYoTe32
        MqPE/vtKgy+LYJpLomAO8676hNP68k20tltUupbIn0Ws8al3j57+Q+2KB/CYuueH
        HSBNO4lp69k1V40VvC1wXMkkKFptC0vn55rJYhFqhb55uRqw82CKcHMNoGBtTISu
        985MRGC3mtRcupheMuMtw6JIoVj/HQv/u1aJEZ7/0ZCDc/w3qtLCReEaH2b3Bl3O
        LqNq0jhbZya9LXgixGxh6MCzv1Po+iCqzQl2yQGKWy72XxbzXYZWHfILfz4x2tXf
        u52CCn4A6VsQ9MUOAR0QxVBNvQltCHB9Eagf0s+ZsjW0TAtLh0tLCntDzxkVx8Xj
        /9rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695837407; x=1695923807; bh=qyVZsJd+mwXxo
        /tflL9+H6BYxxKBtPvMESzVThYup7Y=; b=ieQwzGeG2BqKqUYC0E66vfIjpbLOO
        ukiFpG6YKKXCRUAkxtoZbHnm/CrbnKKJPiBwxKWO92ER5Q1LYMAhm8QTTs/h0R/2
        4XeYumYk4O+TceqLbbCW4r7f/env/CKAYJe75ZvgvurfTEeLm8SE5JINaEkVaSQg
        0aUutoeSG2YiVo1dTl+MD9Z7F9CaEdJ+lC3k4nhopMmMcHSsFAJeut7hSi/9P3Aa
        bGeX/SYwUUMLNVFlpowetGMN1CQNYDEEB4xr/aez6mUIgQrWGTBlGujJTrEcNLuE
        vfD1iWdvSFoPgJ5uNGyeRgqBmfi32InCB6T0WipGiq8YHmHIK/+jO/FQg==
X-ME-Sender: <xms:3mwUZV13Wk1bjRRyhZRHv1SOP4q2qslcIIlLJbkRsLLS1Ksz1ZE-rA>
    <xme:3mwUZcF8dC7vBRzq-A1Tb_R8Uda8ie6XnmTkh8JZr3MyGsD07GdhtC1kWG2_F9Rtv
    -oJ98Mxua79cC45rWw>
X-ME-Received: <xmr:3mwUZV7c-sYi-DQtf8sAWGKktCeyghxhi93XbUtlQKCIhlRV4h6_G-9tGOt5hXEyLatOmZrpWQ0J7ECuuAKVQddcomc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:3mwUZS20Vwoq5BtfJ7wbjwG-wrQBWs6KsCzz5_LPauFR6NHLD5Rmzg>
    <xmx:3mwUZYHp945ijxWvWTa-_PJmtO6GaoZmye2mppvVYVa0KDpyLmcspA>
    <xmx:3mwUZT_uKj1OTgDp_AAmNprVq-TbPW0QWNXtu5o3Xo-ag9tyg7qq_g>
    <xmx:32wUZdRFbAOoZzCP1RCB9FxDyg8TzHNs7XFqyXQWUH1fOpx6pZQwkw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 13:56:46 -0400 (EDT)
Date:   Wed, 27 Sep 2023 10:57:46 -0700
From:   Boris Burkov <boris@bur.io>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs/400: new test for simple quotas
Message-ID: <20230927175746.GA293293@zen.localdomain>
References: <cover.1688600422.git.boris@bur.io>
 <9df2554d5e427e47290a10cbfccf20305472c958.1688600422.git.boris@bur.io>
 <9d0abdf8-35cb-ace1-117d-dc45e7f13964@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0abdf8-35cb-ace1-117d-dc45e7f13964@oracle.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 22, 2023 at 11:40:46PM +0800, Anand Jain wrote:
> 
> 
> 
> 
> 
> On 06/07/2023 07:42, Boris Burkov wrote:
> > Test some interesting basic and edge cases of simple quotas.
> > 
> > To some extent, this is redundant with the alternate testing strategy of
> > using MKFS_OPTIONS to enable simple quotas, running the full suite and
> > relying on kernel warnings and fsck to surface issues.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   tests/btrfs/400     | 439 ++++++++++++++++++++++++++++++++++++++++++++
> >   tests/btrfs/400.out |   2 +
> >   2 files changed, 441 insertions(+)
> >   create mode 100755 tests/btrfs/400
> >   create mode 100644 tests/btrfs/400.out
> > 
> > diff --git a/tests/btrfs/400 b/tests/btrfs/400
> > new file mode 100755
> > index 000000000..c3548d42e
> > --- /dev/null
> > +++ b/tests/btrfs/400
> > @@ -0,0 +1,439 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 400
> > +#
> > +# Test common btrfs simple quotas scenarios involving sharing extents and
> > +# removing them in various orders.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick qgroup copy_range snapshot
> > +
> > +# Import common functions.
> > +# . ./common/filter
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +_require_scratch
> 
> 
> I don't see any prerequisite checking and call of notrun() on the
> systems without the kernel or progs simple-quota support. Is it not
> required?
> 
> 
> > +
> > +SUBV=$SCRATCH_MNT/subv
> > +NESTED=$SCRATCH_MNT/subv/nested
> > +SNAP=$SCRATCH_MNT/snap
> > +K=1024
> > +M=$(($K * $K))
> > +NR_FILL=1024
> > +FILL_SZ=$((8 * $K))
> > +TOTAL_FILL=$(($NR_FILL * $FILL_SZ))
> > +EB_SZ=$((16 * $K))
> > +EXT_SZ=$((128 * M))
> > +LIMIT_NR=8
> > +LIMIT=$(($EXT_SZ * $LIMIT_NR))
> 
> Style consistency requires the use of lowercase for test local
> variables.
> 

Is this documented? There are lots of counterexamples.
Will fix, of course.

> 
> > +
> > +prepare()
> > +{
> > +	echo "preparing" > /dev/kmsg
> 
> 
>  Please use $seqres.full or stdout for debugging purpose.

These messages are only helpful in dmesg, as they help to sequence test
actions with kernel logs while debugging test failures.

I personally find it to be a great pattern for writing debuggable tests
that don't end up with annoying fragile test.out files, so I would
encourage you to play with the pattern and see what you think.
Especially in vm-like environments there's really no downside, that I
can see, it's just super nice to have the test actions in dmesg.

However, I appreciate that I'm the one doing the weird thing, so I'll
remove the messages or throw them in seqres.full.

> 
> 
> > +	_scratch_mkfs >> $seqres.full
> > +	_scratch_mount
> > +	enable_quota "s"
> > +	$BTRFS_UTIL_PROG subvolume create $SUBV >> $seqres.full
> > +	set_subvol_limit 256 $LIMIT
> > +	check_subvol_usage 256 0
> > +
> > +	echo "filling" > /dev/kmsg
> > +	# Create a bunch of little filler files to generate several levels in
> > +	# the btree, to make snapshotting sharing scenarios complex enough.
> > +	$FIO_PROG --name=filler --directory=$SUBV --rw=randwrite --nrfiles=$NR_FILL --filesize=$FILL_SZ >/dev/null 2>&1
> > +	echo "filled" > /dev/kmsg
> > +	check_subvol_usage 256 $TOTAL_FILL
> > +
> > +	# Create a single file whose extents we will explicitly share/unshare.
> > +	do_write $SUBV/f $EXT_SZ
> > +	check_subvol_usage 256 $(($TOTAL_FILL + $EXT_SZ))
> > +	echo "prepared" > /dev/kmsg
> > +}
> > +
> 
> 
> 
> > +
> > +echo "Silence is golden"
> 
> We can have the echo part, like (echo 'prepared' > /dev/kmsg), directed
> to stdout; this will be useful for verification and debugging as well.
> 
> 
> Thanks, Anand
> 
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/400.out b/tests/btrfs/400.out
> > new file mode 100644
> > index 000000000..c940c6206
> > --- /dev/null
> > +++ b/tests/btrfs/400.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 400
> > +Silence is golden
> 
