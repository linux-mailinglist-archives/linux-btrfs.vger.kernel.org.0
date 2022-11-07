Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC6561ED1D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 09:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiKGIm7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 03:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiKGIm6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 03:42:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458E615718;
        Mon,  7 Nov 2022 00:42:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB71B60F3C;
        Mon,  7 Nov 2022 08:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410E0C433C1;
        Mon,  7 Nov 2022 08:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667810574;
        bh=YgMQqbAMZgofF1VeQpbBgOGUwi0ouvRpEbUg5UqfH/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qqLD5BLhNzn2Hzhe0ft1mfsU/s6heIBxr6ktMQzKXz9mPRYAWT1VD7rJXr+R6ij45
         o/IPZ3Nv+0fxKW9kewn3Rp9qBmGSQ5OWrM+xuOah/Jlo5A6KURkAO9WrEZYFTHUij6
         CQGz1MMPVvBo7IjPLuZCEFfsDAzlorZZRznNRjCuvzuKpimEuvLZBJ5+1Qv4aunXlb
         e5XqYRflUlxxWHPw+27aR4QRF/G3HOebYnpZF2PIfWTtCrlEfXcc6O3BxRd8bK5xtD
         mjuOua4i2HS+nBsxU/yNlwQUyxc0SpZVoFmTqgZnzIwbZMk0g0L6KtW1lN1r1ZNwTy
         YcKDDdUpzb+bg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso11864277fac.13;
        Mon, 07 Nov 2022 00:42:54 -0800 (PST)
X-Gm-Message-State: ACrzQf1rKy6baYZb8ryaLDC6IjCcmREasv3w50eYzsWHmBUMxk0m4Nu8
        8jqVld7yaTQCARdIvz+3T9gBe+Mly1EpWbuo05A=
X-Google-Smtp-Source: AMsMyM6CqImD7vn53rhmFhfpqYgJHnVlaWeJgG9h3oAijA8M3gAvm4hCFL+a06zlQQKEZfDGuAWOJHfmbiqs6XfhrFM=
X-Received: by 2002:a05:6870:2052:b0:132:7b2:2fe6 with SMTP id
 l18-20020a056870205200b0013207b22fe6mr29425733oad.98.1667810573397; Mon, 07
 Nov 2022 00:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20221106235348.9732-1-wqu@suse.com> <20221107032500.lfzr3h3lqqomu26c@zlang-mailbox>
In-Reply-To: <20221107032500.lfzr3h3lqqomu26c@zlang-mailbox>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 7 Nov 2022 08:42:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6TfL9eReF_SWAJ6V0QTZK83LH=3RVtuT4GR7ht2JxfUA@mail.gmail.com>
Message-ID: <CAL3q7H6TfL9eReF_SWAJ6V0QTZK83LH=3RVtuT4GR7ht2JxfUA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: add a regression test case to make sure
 scrub can detect errors
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 7, 2022 at 3:36 AM Zorro Lang <zlang@redhat.com> wrote:
>
> On Mon, Nov 07, 2022 at 07:53:48AM +0800, Qu Wenruo wrote:
> > There is a regression in v6.1-rc kernel, which will prevent btrfs scrub
> > from detecting corruption (thus no repair either).
> >
> > The regression is caused by commit 786672e9e1a3 ("btrfs: scrub: use
> > larger block size for data extent scrub").
> >
> > The new test case will:
> >
> > - Create a data extent with 2 sectors
> > - Corrupt the second sector of above data extent
> > - Scrub to make sure we detect the corruption
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  tests/btrfs/278     | 66 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/278.out |  2 ++
> >  2 files changed, 68 insertions(+)
> >  create mode 100755 tests/btrfs/278
> >  create mode 100644 tests/btrfs/278.out
> >
> > diff --git a/tests/btrfs/278 b/tests/btrfs/278
> > new file mode 100755
> > index 00000000..ebbf207a
> > --- /dev/null
> > +++ b/tests/btrfs/278
> > @@ -0,0 +1,66 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 278
> > +#
> > +# A regression test for offending commit 786672e9e1a3 ("btrfs: scrub: use
> > +# larger block size for data extent scrub"), which makes btrfs scrub unable
> > +# to detect corruption if it's not the first sector of an data extent.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick scrub
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +. ./common/btrfs
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +
> > +# Need to use 4K as sector size
> > +_require_btrfs_support_sectorsize 4096
> > +_require_scratch
>
> Hi Darrick,
>
> I noticed that you created some scrub helpers in common/fuzzy:
>   # Do we have an online scrub program?
>   _require_scrub() {
>         case "${FSTYP}" in
>         "xfs")
>                 test -x "$XFS_SCRUB_PROG" || _notrun "xfs_scrub not found"
>                 ;;
>         *)
>                 _notrun "No online scrub program for ${FSTYP}."
>                 ;;
>         esac
>   }
>
>   # Scrub the scratch filesystem metadata (online)
>   _scratch_scrub() {
>         case "${FSTYP}" in
>         "xfs")
>                 $XFS_SCRUB_PROG -d -T -v "$@" $SCRATCH_MNT
>                 ;;
>         *)
>                 _fail "No online scrub program for ${FSTYP}."
>                 ;;
>         esac
>   }
>
> and common/xfs:
>   _supports_xfs_scrub()
>
> (PS: How about change _require_scrub to _require_scrub_command, and then calls
> _supports_xfs_scrub in _require_scrub to check kernel part? Or combine kernel
> and userspace checking all into _require_scrub? )
>
> From the code logic, they're only support xfs now. But we can see btrfs support
> scrub too. Did you plan to make them to be common helpers, or just for xfs fuzzy
> test inside?
>
> Hi btrfs folks, do you think if btrfs need _require_scrub and _scratch_scrub?

I don't think that provides any value for btrfs.

The scrub feature has existed for well over a decade, and I don't
think anyone is running fstests with kernels and btrfs-progs versions
that don't have scrub.
Even SLE11-SP2+ kernels (first SUSE enterprise distros supporting
btrfs) have scrub...

Plus I don't recall ever anyone complaining that fstests failed
because the underlying kernel or btrfs-progs had no support for scrub.


>
> Thanks,
> Zorro
>
> > +
> > +_scratch_mkfs >> $seqres.full
> > +_scratch_mount
> > +
> > +# Create a data extent with 2 sectors
> > +$XFS_IO_PROG -fc "pwrite -S 0xff 0 8k" $SCRATCH_MNT/foobar >> $seqres.full
> > +sync
> > +
> > +first_logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> > +echo "logical of the first sector: $first_logical" >> $seqres.full
> > +
> > +second_logical=$(( $first_logical + 4096 ))
> > +echo "logical of the second sector: $second_logical" >> $seqres.full
> > +
> > +second_physical=$(_btrfs_get_physical $second_logical 1)
> > +echo "physical of the second sector: $second_physical" >> $seqres.full
> > +
> > +second_dev=$(_btrfs_get_device_path $second_logical 1)
> > +echo "device of the second sector: $second_dev" >> $seqres.full
> > +
> > +_scratch_unmount
> > +
> > +# Corrupt the second sector of the data extent.
> > +$XFS_IO_PROG -c "pwrite -S 0x00 $second_physical 4k" $second_dev >> $seqres.full
> > +_scratch_mount
> > +
> > +# Redirect stderr and stdout, as if btrfs detected the unrepairable corruption,
> > +# it will output an error message.
> > +$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT &> $tmp.output
> > +cat $tmp.output >> $seqres.full
> > +_scratch_unmount
> > +
> > +if ! grep -q "csum=1" $tmp.output; then
> > +     echo "Scrub failed to detect corruption"
> > +fi
> > +
> > +echo "Silence is golden"
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/278.out b/tests/btrfs/278.out
> > new file mode 100644
> > index 00000000..b4c4a95d
> > --- /dev/null
> > +++ b/tests/btrfs/278.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 278
> > +Silence is golden
> > --
> > 2.38.0
> >
>
