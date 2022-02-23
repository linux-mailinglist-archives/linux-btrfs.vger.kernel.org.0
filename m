Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F714C1281
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 13:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiBWMNS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 07:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbiBWMNR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 07:13:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB37D9AD86;
        Wed, 23 Feb 2022 04:12:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A1D7B81F09;
        Wed, 23 Feb 2022 12:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200DFC340E7;
        Wed, 23 Feb 2022 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645618367;
        bh=L8t9CItoBz7aAv46NoemG9ez6m9l783jUKZLOc4kQWE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hn59DPsxhurR4DMyTcvNE+00oMwS/G9oxXlzwND/w03DMlMoTtlZLlHW080d8A488
         h+ntQ3c4nrcEV+fMwtK4wYANXAf4QEItbUAx+TzTL3eFud8dctwaTumED7b/RjNEye
         I/HOr5QlBzli0tB+7MXNbSg14yG3i7+6Gp85V31ZCpG92PBKF0NLgQOuHLDF+8ObPh
         i2SV+uScqxPAcGjp162XuDvi3upjxl0sqQkBPzT38zZRlbm6jX5q1X4VAbTqCPq2Ow
         Ln4TX+uzqQXgf4NHuiOcwjtOXMkpwi3F8+qgxYTl809u6WsiqtnINGCOAsq06PpIdB
         LCTUOSiX1JZhg==
Received: by mail-qk1-f179.google.com with SMTP id g24so4136378qkl.3;
        Wed, 23 Feb 2022 04:12:47 -0800 (PST)
X-Gm-Message-State: AOAM530tX+at6joj9a1s8L5f0LZc+FqK1jTJKjFE4fFm9R9x9rSHtH5K
        M9RVhWnL1angLdXrr3dNpi8N3HtK7QIMGl9iMpI=
X-Google-Smtp-Source: ABdhPJx+dvgZWvXr2FCskA76tagYYsUPwzBwqiRxyIeFlZ6q+J5wIEIGTJIaN0KB3O2+PWsgLLTitlazxrE/JPrBJ5U=
X-Received: by 2002:a37:aa02:0:b0:47e:826e:7d4e with SMTP id
 t2-20020a37aa02000000b0047e826e7d4emr18216848qke.9.1645618366093; Wed, 23 Feb
 2022 04:12:46 -0800 (PST)
MIME-Version: 1.0
References: <abbc821350c8ef515e0a0317b5cbd64e3c5b81ab.1645099449.git.fdmanana@suse.com>
 <20220222234432.GF3061737@dread.disaster.area>
In-Reply-To: <20220222234432.GF3061737@dread.disaster.area>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 23 Feb 2022 12:12:10 +0000
X-Gmail-Original-Message-ID: <CAL3q7H41wY_GWStRUxuOWwPcgqX9zx-WZxEySaRAUrMtcE666w@mail.gmail.com>
Message-ID: <CAL3q7H41wY_GWStRUxuOWwPcgqX9zx-WZxEySaRAUrMtcE666w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test log replay after fsync of file with prealloc
 extents beyond eof
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
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

On Tue, Feb 22, 2022 at 11:44 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Feb 17, 2022 at 12:14:21PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that after a full fsync of a file with preallocated extents beyond
> > the file's size, if a power failure happens, the preallocated extents
> > still exist after we mount the filesystem.
> >
> > This test currently fails and there is a patch for btrfs that fixes this
> > issue and has the following subject:
> >
> >   "btrfs: fix lost prealloc extents beyond eof after full fsync"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/btrfs/261     | 79 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/261.out | 10 ++++++
>
> What is btrfs specific about this test?

The comments that explain the steps are very btrfs specific.
Without them it would be hard to understand why the test uses that
specific file size, block size, mention of the btrfs inode's full sync
bit, etc.

Some years ago, when you maintained fstests, you complained once about
this type of "too btrfs specific" comments on generic tests.


>
> Cheers,
>
> Dave.
>
> --
> Dave Chinner
> david@fromorbit.com
