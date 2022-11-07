Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59661EAD5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 07:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiKGGOd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 01:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGGOc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 01:14:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BC55FC1
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 22:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667801617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UbNC/04CRQHsC68d2dfrTbuSu7Q+RJEH8LhssK/WOj8=;
        b=Kaj7mdm17rVpPqahvApCu0HlDMtT9AZgnoJA7Ia2ZE+r38JgmdxTBOBnPq3nkq3SslF/aV
        +Jb/9cnjnDHTX+1jsl0NIdy8DSQDQyLKBjftBI3QIYyy73u4MHR3/djAaGufoSieo7x+TG
        NIPYWlHEpsQXAIIaX6FUzN4oCudDkrA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-fEkcQ7p_MbaeJfkjnzKxIw-1; Mon, 07 Nov 2022 01:13:36 -0500
X-MC-Unique: fEkcQ7p_MbaeJfkjnzKxIw-1
Received: by mail-qk1-f200.google.com with SMTP id u6-20020a05620a430600b006e47fa02576so9478083qko.22
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Nov 2022 22:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbNC/04CRQHsC68d2dfrTbuSu7Q+RJEH8LhssK/WOj8=;
        b=X0Wf3uDiZUbIAugNcJXUUgVzDnLEWPk5TFyUGVoBI3kD9D6KsLfN0Fv7aJXd+fKk2S
         4DqaFjZ9Dsu+dQmDWfTXdcjSNGjviiVCMoN45qeTtOXiedIwnDdgGHZioiF6BIFkaPTM
         OHCeQyIoiEFfq0EsBSCW1SQfeQ9/aaPh10MWnKQRgBURvm9Qrn/KRs6VC6le42hlIYdO
         6BRQtd2itA5xLjDK/Tf9PrYQaXq0BoNBoYtV8rtAfqe7iIVZ88JkKVpX46OiKQ9ZcUkR
         0JStfzkPwAeP7vwgresl4xM2QQGskcO+KMXkMhM7Z9IqKEk5mZElrsHWH7dZ3pyjAXUY
         UEbw==
X-Gm-Message-State: ACrzQf38U7EnkxrdZqasnQ55DXtHmbw2zJVYpvjJ76AH0fXaZIEWOZDz
        9rIV7fabj63gCHdUFpS6Gt4AGOvQIr1byQsLnx1++BllNB+J3UlPZ29CM8jPitlRp7Z5hYQvVhA
        RHD6fdkGg3NWMTsX6WVPVtTE=
X-Received: by 2002:a05:620a:4091:b0:6fa:dcc:9814 with SMTP id f17-20020a05620a409100b006fa0dcc9814mr33533404qko.592.1667801614852;
        Sun, 06 Nov 2022 22:13:34 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6GuGimZis4OKLkJ6elfWeu3k8mUwVq/ZyX9t9fV3kee0W9LjTT2QTWJsM/2AeYsTp3QUUeaQ==
X-Received: by 2002:a05:620a:4091:b0:6fa:dcc:9814 with SMTP id f17-20020a05620a409100b006fa0dcc9814mr33533394qko.592.1667801614526;
        Sun, 06 Nov 2022 22:13:34 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y20-20020a37f614000000b006cfaee39ccesm5977563qkj.114.2022.11.06.22.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 22:13:33 -0800 (PST)
Date:   Mon, 7 Nov 2022 14:13:29 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs: add a regression test case to make sure
 scrub can detect errors
Message-ID: <20221107061329.w5rf6qcf4cqy6eps@zlang-mailbox>
References: <20221106235348.9732-1-wqu@suse.com>
 <20221107025843.osxx3alzzkkoxnl6@zlang-mailbox>
 <6dc410ea-c79f-809c-303c-f79cb7625ce3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dc410ea-c79f-809c-303c-f79cb7625ce3@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 07, 2022 at 12:41:34PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/11/7 10:58, Zorro Lang wrote:
> > On Mon, Nov 07, 2022 at 07:53:48AM +0800, Qu Wenruo wrote:
> > > There is a regression in v6.1-rc kernel, which will prevent btrfs scrub
> > > from detecting corruption (thus no repair either).
> > > 
> > > The regression is caused by commit 786672e9e1a3 ("btrfs: scrub: use
> > > larger block size for data extent scrub").
> > > 
> > > The new test case will:
> > > 
> > > - Create a data extent with 2 sectors
> > > - Corrupt the second sector of above data extent
> > > - Scrub to make sure we detect the corruption
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   tests/btrfs/278     | 66 +++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/btrfs/278.out |  2 ++
> > 
> > Hi,
> > 
> > btrfs/278 has been taken, please rebase on the latest for-next branch, or
> > use a big enough number.
> 
> I'm not sure if some one else has already complained about this, the idea of
> a for-next branch of a test suite is stupid (nor the weekly tags).
> 
> Fstests is a test suite, it is only for fs developers, I doubt why we need
> tags/for-next at all.

1)
I think fstests isn't only for developers, there're many people, they even
never contributed to fstests or linux, but they still need fstests to do
sanity/regression test daily/weekly for some downstream things.

2)
I don't doubt the tags are useless for most users, but as I know some people
enjoy it. And the tags don't bring in troubles to others don't use it, so why
can't I give it tags?

3)
Although fstests is a test tool, but it still might bring in big/small
regression issues. Someone might submit lots of testing jobs after push some
changes, and happy to sleep or enjoy their weekend (wait the test done).
But when they come back, they find all test jobs are broken due to fstests
regression, they get nothing valid testing results. How despondent are they?

Some testing jobs are just automatical testing, they don't want to deal with
fstests issues manually. So the master branch trys to keep stable. The patches
will be in for-next branch at first, then merge onto master branch if no one
complains these patches.

The for-next is for fstests developers, and other developers who always want
to use lastest update, and don't mind (even enjoy) dealing with fstests issues
(if there's) manually. The master branch is for the ones who just hope to get
a stabler (relative) for their automatical testing frame.

> 
> Remember, before the whole for-next/tags things, developers just checkout
> the master branch and go ./new, no need to bother the tags/branches at all.

Now you can treat for-next branch as master branch you used before. As your
using habits, you can always base on for-next branch, master branch isn't for
developers as you now.

> 
> > 
> > >   2 files changed, 68 insertions(+)
> > >   create mode 100755 tests/btrfs/278
> > >   create mode 100644 tests/btrfs/278.out
> > > 
> > > diff --git a/tests/btrfs/278 b/tests/btrfs/278
> > > new file mode 100755
> > > index 00000000..ebbf207a
> > > --- /dev/null
> > > +++ b/tests/btrfs/278
> > > @@ -0,0 +1,66 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test 278
> > > +#
> > > +# A regression test for offending commit 786672e9e1a3 ("btrfs: scrub: use
> > > +# larger block size for data extent scrub"), which makes btrfs scrub unable
> > > +# to detect corruption if it's not the first sector of an data extent.
> > 
> > So 786672e9e1a3 is the commit which brought in this regression issue? Is there
> > a fix patch or commit by reviewed?
> 
> The fix (by reverting it) is send to btrfs mailing list, titled "Revert
> \"btrfs: scrub: use larger block size for data extent scrub\"".

OK, thanks.

> 
> > 
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick scrub
> > > +
> > > +# Import common functions.
> > > +. ./common/filter
> > > +. ./common/btrfs
> > 
> > The common/btrfs is imported automatically, so don't need to import it at here.
> > And I think this case doesn't use any filter, if so, the common/filter isn't
> > needed either.
> > 
> > > +
> > > +# real QA test starts here
> > > +
> > > +# Modify as appropriate.
> > 
> > This comment can be removed.
> 
> If you really believe removing those boilerplate makes much sense, then I'd
> say, the template should be updated to remove those completely.

Hmm... there're many comments in template should be removed when we start to
write a new case. Most of them are always removed properly, only this line
always be missed.

I don't doubt the template can be improved. But it's a tiny problem, so I
planned to improve that next time when we have chance to improve the template.
Before that, if a patch is all good, only this single line can be removed, I'll
ignore it. If a patch need to change, I'll point out this line incidentally :)

> 
> > 
> > > +_supported_fs btrfs
> > > +
> > > +# Need to use 4K as sector size
> > > +_require_btrfs_support_sectorsize 4096
> > > +_require_scratch
> > > +
> > > +_scratch_mkfs >> $seqres.full
> > 
> > Just check with you, do you need "-s 4k" so make sure sector size is 4k (even
> > if 4k is supported)?
> 
> I'll add "-s 4k" to make it more explicit for systems with larger page
> sizes.

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > +_scratch_mount
> > > +
> > > +# Create a data extent with 2 sectors
> > > +$XFS_IO_PROG -fc "pwrite -S 0xff 0 8k" $SCRATCH_MNT/foobar >> $seqres.full
> > > +sync
> > > +
> > > +first_logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> > > +echo "logical of the first sector: $first_logical" >> $seqres.full
> > > +
> > > +second_logical=$(( $first_logical + 4096 ))
> > > +echo "logical of the second sector: $second_logical" >> $seqres.full
> > > +
> > > +second_physical=$(_btrfs_get_physical $second_logical 1)
> > > +echo "physical of the second sector: $second_physical" >> $seqres.full
> > > +
> > > +second_dev=$(_btrfs_get_device_path $second_logical 1)
> > > +echo "device of the second sector: $second_dev" >> $seqres.full
> > > +
> > > +_scratch_unmount
> > > +
> > > +# Corrupt the second sector of the data extent.
> > > +$XFS_IO_PROG -c "pwrite -S 0x00 $second_physical 4k" $second_dev >> $seqres.full
> > > +_scratch_mount
> > > +
> > > +# Redirect stderr and stdout, as if btrfs detected the unrepairable corruption,
> > > +# it will output an error message.
> > > +$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT &> $tmp.output
> > > +cat $tmp.output >> $seqres.full
> > > +_scratch_unmount
> > > +
> > > +if ! grep -q "csum=1" $tmp.output; then
> > > +	echo "Scrub failed to detect corruption"
> > > +fi
> > > +
> > > +echo "Silence is golden"
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/278.out b/tests/btrfs/278.out
> > > new file mode 100644
> > > index 00000000..b4c4a95d
> > > --- /dev/null
> > > +++ b/tests/btrfs/278.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 278
> > > +Silence is golden
> > > -- 
> > > 2.38.0
> > > 
> > 
> 

