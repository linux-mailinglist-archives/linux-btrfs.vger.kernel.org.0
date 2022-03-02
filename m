Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDFD4CA3D1
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 12:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbiCBLfD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 06:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiCBLfC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 06:35:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C57D9027C;
        Wed,  2 Mar 2022 03:34:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED398617F4;
        Wed,  2 Mar 2022 11:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C88FC004E1;
        Wed,  2 Mar 2022 11:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646220858;
        bh=EUbAbOtbKbHb53s+BZeDl0ZucskqRbpaz8tEIyg8WGY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VFgfn7kjiyGmPFTrOYc+0UMvyI3vcMjW4m9alGwMer8RwdckJnAUQInKbvWaD1RXv
         IO329MsuDrH3FV3641ojryruKA0DNRK9gTrvmlnZmV33qRZuOhUuul6ErGL9zdAdkV
         5gFnGWBx3AP3uE5qXxd4CyM+XP7xpzycoZ7WFB3OSSS6+IzE3ReXiipLsgSf9+Shbh
         tfxUekOczTtyH9xD6Z/k9yOvKLxSnjpg5uBQd4VxHShOxKbG+KdEa5jWv0HsUKjrRV
         Iet5C4wYsL1EFCM0wlviGypMaIDGYE4PA6chJcuVAS2r2q4wDjmzXAUv+LCaQPIByP
         zANE/uZ2qCHmg==
Received: by mail-qt1-f177.google.com with SMTP id f18so1306816qtb.3;
        Wed, 02 Mar 2022 03:34:18 -0800 (PST)
X-Gm-Message-State: AOAM532sEm8mJRinHjlrhgrDBAUb93LazqK5NFgxJonpNj3egXOuLs+0
        UqeBE/zdo3NhNxrsrNSyA7tedoWFRCtLBtRaMQA=
X-Google-Smtp-Source: ABdhPJzoSFphQumTK4OAYtEDTEQGn6c6w8jiIuSeSfZuDDiETrr+UEzJ0vkTa506qOU6HmmbWnt/26+ousx0vnQIuX0=
X-Received: by 2002:a05:622a:110:b0:2dd:461a:6126 with SMTP id
 u16-20020a05622a011000b002dd461a6126mr23718961qtw.379.1646220857301; Wed, 02
 Mar 2022 03:34:17 -0800 (PST)
MIME-Version: 1.0
References: <abbc821350c8ef515e0a0317b5cbd64e3c5b81ab.1645099449.git.fdmanana@suse.com>
 <20220222234432.GF3061737@dread.disaster.area> <CAL3q7H41wY_GWStRUxuOWwPcgqX9zx-WZxEySaRAUrMtcE666w@mail.gmail.com>
 <20220224022128.GK3061737@dread.disaster.area>
In-Reply-To: <20220224022128.GK3061737@dread.disaster.area>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 2 Mar 2022 11:33:41 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7=4g3W7J4=9=rN2FodWr387+9eSzvUYyLVnz3tRv0CFw@mail.gmail.com>
Message-ID: <CAL3q7H7=4g3W7J4=9=rN2FodWr387+9eSzvUYyLVnz3tRv0CFw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test log replay after fsync of file with prealloc
 extents beyond eof
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 24, 2022 at 2:21 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Feb 23, 2022 at 12:12:10PM +0000, Filipe Manana wrote:
> > On Tue, Feb 22, 2022 at 11:44 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Thu, Feb 17, 2022 at 12:14:21PM +0000, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Test that after a full fsync of a file with preallocated extents beyond
> > > > the file's size, if a power failure happens, the preallocated extents
> > > > still exist after we mount the filesystem.
> > > >
> > > > This test currently fails and there is a patch for btrfs that fixes this
> > > > issue and has the following subject:
> > > >
> > > >   "btrfs: fix lost prealloc extents beyond eof after full fsync"
> > > >
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > > >  tests/btrfs/261     | 79 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/btrfs/261.out | 10 ++++++
> > >
> > > What is btrfs specific about this test?
> >
> > The comments that explain the steps are very btrfs specific.
> > Without them it would be hard to understand why the test uses that
> > specific file size, block size, mention of the btrfs inode's full sync
> > bit, etc.
>
> But the behaviour and layout should end up being the same for all
> filesystems, right?

Right.

>
> We have plenty of generic tests that are designed with a
> specific configuration on a specific filesystem to reproduce a bug
> seen on that filesystem, but as long as all filesystems should be
> expected to behave the same way, it's a generic test.
>
> AFAICT, the behaviour described and exercised by the test should be
> the same for all filesystems that support preallocation beyond EOF.
> Hence it isn't btrfs specific behaviour being exercised, just a
> reproducing a bug where btrfs deviates from the correct behaviour
> that should be consistent across all filesystems.
>
> > Some years ago, when you maintained fstests, you complained once about
> > this type of "too btrfs specific" comments on generic tests.
>
> I can change my mind if I want. Besides, I'm looking at this new
> test purely on it's own merits so past discussions aren't really
> relevant. Maybe you didn't understand the context under which I was
> considering a patch to be "too fs specific" rather than generic.
>
> There's a big difference between "only btrfs will behave this way"
> and "all filesystems should get the same result, but btrfs sometimes
> fails to get that results in this specific case".  The former should
> be a btrfs-only test, the latter should be a generic test.
>
> Which class this test falls into is exactly what I'm asking here -
> should all filesystems get the same result, or is successful
> result encoded in the golden output behaviour that only btrfs will
> ever produce?

As far as I know, all filesystems supporting fallocate should behave
the same way.

Ok, I can move into the generic group.

Thanks.

>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
