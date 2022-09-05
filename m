Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3D5ACEB6
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 11:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbiIEJWI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 05:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbiIEJWD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 05:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A613DBFB;
        Mon,  5 Sep 2022 02:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0C276115A;
        Mon,  5 Sep 2022 09:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31354C433C1;
        Mon,  5 Sep 2022 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662369721;
        bh=3sOKZKEVIWB5f18fA7rYTqUHTTu67DPs3jVzIYz9O8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FykKsa8aIXIJ0WxISMTsmXVw2AND0OF2hBv1iysN+LUrP25zkRWeqSWmK5ejFxL0x
         pvj/VrR7Su5Lrq9gGZP7g0hZm+y5qtR6YUaqlXbJ8lHoV6ILS7z37gL2KL0W0iRHGc
         dc22TMTPyaQpznv6NY3gtfVwXBAnlGDxymeeiqRzWewdZ8GSqfWTakXJqkOEBoTun4
         OLnLd2esvF2xkvP1iu066ZKdIQdxbPvwMqEQPDKakQahw69SqcT2kunAZR4g2VCesy
         6l49YIPEa+c78CegkmsoPByEcxPDPw8OCJ6AIxH/EqAZSubmZLQ95Re+2C275ugtsw
         uJjRVuRAkZKkA==
Received: by mail-ot1-f53.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so5767199otd.12;
        Mon, 05 Sep 2022 02:22:01 -0700 (PDT)
X-Gm-Message-State: ACgBeo2u77pmHDXQDMc3mWmvir06cYY9L9V5tqMMUyPRQu+BvfaBts7Z
        qV7n2b01IgGo2GqI0u69jpmN5mSZtoSwa44UYjU=
X-Google-Smtp-Source: AA6agR5FYKxFY0yuLdqPnAsZoqlmE6UmRRFYwqoWXSksAqYJ97n3RVllCgTHlPJLZe0aDJX1P+/BqJTohLyoYkIluDU=
X-Received: by 2002:a9d:6f08:0:b0:638:8a51:2e46 with SMTP id
 n8-20020a9d6f08000000b006388a512e46mr19814515otq.363.1662369720323; Mon, 05
 Sep 2022 02:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <0bc9cd4abfbde3f76b981628942f94631cef7162.1662110839.git.fdmanana@suse.com>
 <20220903004401.xobe5elurx3bkh3f@zlang-mailbox>
In-Reply-To: <20220903004401.xobe5elurx3bkh3f@zlang-mailbox>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 5 Sep 2022 10:21:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6zb9HzEUbHb-mjLEsHo_mQRM15qo101MdHLMCXyzEoXg@mail.gmail.com>
Message-ID: <CAL3q7H6zb9HzEUbHb-mjLEsHo_mQRM15qo101MdHLMCXyzEoXg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: test that we can not delete a subvolume with an
 active swap file
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 3, 2022 at 1:44 AM Zorro Lang <zlang@redhat.com> wrote:
>
> On Fri, Sep 02, 2022 at 10:30:32AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Verify that we can not delete a subvolume that has an active swap file,
> > and that after disabling the swap file, we can delete it.
> >
> > This tests a fix done by kernel commit 60021bd754c6ca ("btrfs: prevent
> > subvol with swapfile from being deleted"), which landed in kernel 5.18.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >
> > V2: Add _cleanup() override to make sure swapfile is disabled in case
> >     the test is interrupted.
>
> Thanks for doing this cleanup, now it's good to me.

Great.
Is there any reason why the test wasn't merged in yesterday's update?

Thanks.

>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
>
> >
> >  tests/btrfs/274     | 58 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/274.out |  6 +++++
> >  2 files changed, 64 insertions(+)
> >  create mode 100755 tests/btrfs/274
> >  create mode 100644 tests/btrfs/274.out
> >
> > diff --git a/tests/btrfs/274 b/tests/btrfs/274
> > new file mode 100755
> > index 00000000..c0594e25
> > --- /dev/null
> > +++ b/tests/btrfs/274
> > @@ -0,0 +1,58 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 274
> > +#
> > +# Test that we can not delete a subvolume that has an active swap file.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick swap subvol
> > +
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -f $tmp.*
> > +     test -n "$swap_file" && swapoff $swap_file &> /dev/null
> > +}
> > +
> > +. ./common/filter
> > +
> > +_supported_fs btrfs
> > +_fixed_by_kernel_commit 60021bd754c6ca \
> > +    "btrfs: prevent subvol with swapfile from being deleted"
> > +_require_scratch_swapfile
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount
> > +
> > +swap_file="$SCRATCH_MNT/subvol/swap"
> > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol | _filter_scratch
> > +
> > +echo "Creating and activating swap file..."
> > +_format_swapfile $swap_file $(($(get_page_size) * 32)) >> $seqres.full
> > +_swapon_file $swap_file
> > +
> > +echo "Attempting to delete subvolume with swap file enabled..."
> > +# Output differs with different btrfs-progs versions and some display multiple
> > +# lines on failure like this for example:
> > +#
> > +#   ERROR: Could not destroy subvolume/snapshot: Operation not permitted
> > +#   WARNING: deletion failed with EPERM, send may be in progress
> > +#   Delete subvolume (no-commit): '/home/fdmanana/btrfs-tests/scratch_1/subvol'
> > +#
> > +# So just redirect all output to the .full file and check the command's exit
> > +# status instead.
> > +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/subvol >> $seqres.full 2>&1 && \
> > +    echo "subvolume deletion successful, expected failure!"
> > +
> > +echo "Disabling swap file..."
> > +swapoff $swap_file
> > +
> > +echo "Attempting to delete subvolume after disabling swap file..."
> > +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/subvol >> $seqres.full 2>&1 || \
> > +   echo "subvolume deletion failure, expected success!"
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/274.out b/tests/btrfs/274.out
> > new file mode 100644
> > index 00000000..66e0de25
> > --- /dev/null
> > +++ b/tests/btrfs/274.out
> > @@ -0,0 +1,6 @@
> > +QA output created by 274
> > +Create subvolume 'SCRATCH_MNT/subvol'
> > +Creating and activating swap file...
> > +Attempting to delete subvolume with swap file enabled...
> > +Disabling swap file...
> > +Attempting to delete subvolume after disabling swap file...
> > --
> > 2.35.1
> >
>
