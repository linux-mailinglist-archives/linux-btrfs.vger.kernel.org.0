Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A8B49F9BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 13:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiA1Moc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 07:44:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36954 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiA1Moc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 07:44:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A7ADB8258E
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 12:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42D3C340E8
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 12:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643373869;
        bh=AsSZ1r7tsI3ztzDTKthGViQ0rSVTyCVrk7sMeZ8Zd74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o8/euecxuIbjylI6P7AcsfUwVdNq9cR4a4vmFG5C62h2UWaZ2PPV+TkrDv+TdE1Oi
         uWiH2fwuszqG5fwLriYXivi2JjM5vV3a0HhabZncFCDn8utiEcj8rPwcIfsTinqhNu
         /ERrc4UHyNppwB4jntdu+Cbd63q/HObXf4SIayUALSWy9MTWtUtNY4qgOTPa/QXMCc
         CmZXRLC8rtkXsqV1ftEb1tmc/4OWNG0vcIBPMpvgsNTLLzbzJStwKFl8Mj952WtzC2
         F/4eT2Snda8ZcE9MN1aMHeW8Q6nJPdsheB5skDJZMFy5DWqg3HRkwrTKxUlIzE5SzS
         GJ5g8jj3YzC3w==
Received: by mail-qt1-f177.google.com with SMTP id k14so4993901qtq.10
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 04:44:29 -0800 (PST)
X-Gm-Message-State: AOAM533VNOsWMsGqm+13jrz1Lhax0BkAuPDAOp+M7CDBKk/t6nHrjnxw
        x/AIyktz5MjOdO/RnBoWREhtyNiIc085gBgRtis=
X-Google-Smtp-Source: ABdhPJwDJfRzdfbiptefYZsbRRlgSQaiLRs+Ovt9V7H12GxKj5i4JKZCZ5ZI2lGkHBZyyqs+ASwreQvFaOZSAdjlEHU=
X-Received: by 2002:ac8:6605:: with SMTP id c5mr5900021qtp.522.1643373868742;
 Fri, 28 Jan 2022 04:44:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643354254.git.wqu@suse.com> <YfPe6EeJ3Tr0p0zq@debian9.Home>
 <398c9f67-5b33-c107-cd38-500c102cd7a0@gmx.com>
In-Reply-To: <398c9f67-5b33-c107-cd38-500c102cd7a0@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 28 Jan 2022 12:43:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4A5JQeTjN6yKevfvzd4ZUaDjbWnaX-uXFCYmEZzibOkw@mail.gmail.com>
Message-ID: <CAL3q7H4A5JQeTjN6yKevfvzd4ZUaDjbWnaX-uXFCYmEZzibOkw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] btrfs: fixes for defrag_check_next_extent()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 12:38 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/1/28 20:17, Filipe Manana wrote:
> > On Fri, Jan 28, 2022 at 03:21:19PM +0800, Qu Wenruo wrote:
> >> That function is reused between older kernels (v5.15) and the refactored
> >> defrag code (v5.16+).
> >>
> >> However that function has one long existing bugs affecting defrag to
> >> handle preallocated range.
> >>
> >> And it can not handle compressed extent well neither.
> >>
> >> Finally there is an ambiguous check which doesn't make much sense by
> >> itself, and can be related by enhanced extent capacity check.
> >>
> >> This series will fix all the 3 problem mentioned above.
> >>
> >> Changelog:
> >> v2:
> >> - Use @extent_thresh from caller to replace the harded coded threshold
> >>    Now caller has full control over the extent threshold value.
> >>
> >> - Remove the old ambiguous check based on physical address
> >>    The original check is too specific, only reject extents which are
> >>    physically adjacent, AND too large.
> >>    Since we have correct size check now, and the physically adjacent check
> >>    is not always a win.
> >>    So remove the old check completely.
> >>
> >> v3:
> >> - Split the @extent_thresh and physicall adjacent check into other
> >>    patches
> >>
> >> - Simplify the comment
> >>
> >> v4:
> >> - Fix the @em usage which should be @next.
> >>    As it will fail the submitted test case.
> >>
> >> Qu Wenruo (3):
> >>    btrfs: defrag: don't try to merge regular extents with preallocated
> >>      extents
> >>    btrfs: defrag: don't defrag extents which is already at its max
> >>      capacity
> >>    btrfs: defrag: remove an ambiguous condition for rejection
> >>
> >>   fs/btrfs/ioctl.c | 35 ++++++++++++++++++++++++++++-------
> >>   1 file changed, 28 insertions(+), 7 deletions(-)
> >
> > There's something screwed up in the series:
> >
> > $ b4 am cover.1643354254.git.wqu@suse.com
> > Looking up https://lore.kernel.org/r/cover.1643354254.git.wqu%40suse.com
> > Grabbing thread from lore.kernel.org/all/cover.1643354254.git.wqu%40suse.com/t.mbox.gz
> > Analyzing 5 messages in the thread
> > Checking attestation on all messages, may take a moment...
> > ---
> >    [PATCH v4 1/3] btrfs: defrag: don't try to merge regular extents with preallocated extents
> >      + Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >    [PATCH v4 2/3] btrfs: defrag: don't defrag extents which is already at its max capacity
> >    [PATCH v4 3/3] btrfs: defrag: remove an ambiguous condition for rejection
> >    ---
> >    NOTE: install dkimpy for DKIM signature verification
> > ---
> > Total patches: 3
> > ---
> > Cover: ./v4_20220128_wqu_btrfs_fixes_for_defrag_check_next_extent.cover
> >   Link: https://lore.kernel.org/r/cover.1643354254.git.wqu@suse.com
> >   Base: not specified
> >         git am ./v4_20220128_wqu_btrfs_fixes_for_defrag_check_next_extent.mbx
> >
> > $ git am ./v4_20220128_wqu_btrfs_fixes_for_defrag_check_next_extent.mbx
> > Applying: btrfs: defrag: don't try to merge regular extents with preallocated extents
> > Applying: btrfs: defrag: don't defrag extents which is already at its max capacity
> > error: patch failed: fs/btrfs/ioctl.c:1229
> > error: fs/btrfs/ioctl.c: patch does not apply
> > Patch failed at 0002 btrfs: defrag: don't defrag extents which is already at its max capacity
> > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> >
> > Trying to manually pick patches 1 by 1 from patchwork, also results in the
> > same failure when applying patch 2/3.
>
> My bad, I'm still using the old branch where I did all my test, it lacks
> patches which are already in misc-next.
>
> The missing patch of my base is "btrfs: fix deadlock when reserving
> space during defrag", that makes the new lines in
> defrag_collect_targets() to have some differences.
>
> As in my base, it's
>
>         if (em->len >= extent_thresh)
>
> But now in misc-next, it's
>
>         if (range_len >= extent_thresh)
>
>
> This also makes me wonder, should we compare range_len to extent_thresh
> or em->len?

In this case I think em->len is fine.
Using range_len, which can be shorter for the first extent map in the
range, could trigger defrag of an extent at the maximum possible size.

Thanks.

>
> One workaround users in v5.15 may use is to pass "-t 128k" for btrfs fi
> defrag, so extents at 128K will not be defragged.
>
> Won't the modified range_len check cause us to defrag extents which is
> already 128K but the cluster boundary just ends inside the compressed
> extent, and at the next cluster, we will choose to defrag part of the
> extent.
>
> Thanks,
> Qu
>
>
>
> >
> > Not sure why it failed, but I was able to manually apply the diffs.
> >
> > Thanks.
> >
> >>
> >> --
> >> 2.34.1
> >>
