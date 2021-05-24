Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAF238E657
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 14:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhEXMM3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 08:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhEXMM3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 08:12:29 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2298DC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 24 May 2021 05:11:00 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id i19so13893998qtw.9
        for <linux-btrfs@vger.kernel.org>; Mon, 24 May 2021 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dvdyKjZgTAW6EwSYzWhHjZpWjhxS85/H4i2oAFN4nT8=;
        b=GITjaYmZtBKAeJKMpNVHR0PdWyyf0fJRUlXsgS/0OAcXPnXAAuXDA6I13iL527Quwa
         3/MMFYIgomgKk8muvR9p35tDpF/wfzRSDP09m3jts7D93MnsoW2tBLVarC0grUK/j5X+
         8eWZC2DVPCbpMidY01uLDBGul5+5f6I8XxjTOxx4v2iDyZ1c04yqaVx888oOi4yuHYCC
         G5aEQFMvVL5eFxK2kN1K8/xIgooOY+ZdqWgM3V8xV40c+ATDz3pBDDC+WGc1+fTFD/eR
         2IJtJx2ITgSSbOFV6L1HE3axyY4YbR2Lwx04hYxJyURjSfJ189dj+2w4an/8XUjUZqir
         V7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dvdyKjZgTAW6EwSYzWhHjZpWjhxS85/H4i2oAFN4nT8=;
        b=pytljlMdKR+TZvaO6bb5QMFZ66dbV6BVDTc4y1PlQqhXGBYIVZ0dqJqCsW8B3mv7Ep
         GgahCyuG02sbLyQ3yLO2bbiF6ONR1mCJyhv6B2K6BDu/oj+mc+DBei5IT52XQzyRjH8z
         hKf3bRFKt8XwnoHeZPprXs/jYbH+SpH3Vvq5MOq6yMDC/qn22SOwC/TJHUCeCUxX7Z1s
         zI9t6nnwNs5lNVq9oEWELz0CIUinsxZIIawhu+oZAC9d53Xp3nnnFYtohgWiI0bNSpEr
         XWoDzXOKQfLrxY1RxcshXeVJq+RikCXjcmxrKfK/I0cdSb7EYqwYn1WGzx6l6e3cINO8
         /Rsw==
X-Gm-Message-State: AOAM533yp5Zu9Cv6ryzROPTJk4NDdYJ/4+4AxrQbvhjEEmoBg2CTI9Oq
        fyfAB2KyAo3YRbheJoHBFOlw/bWU9lAKrujujbQ=
X-Google-Smtp-Source: ABdhPJyC2xz/L7B9YVcCoEaT74OINfrqh4zHwJ5wayyRB4dHvcJFwyrK41l1LYuKtWKj3zpLcRYzxAoqzWXSYmzQIDo=
X-Received: by 2002:ac8:6605:: with SMTP id c5mr27156466qtp.21.1621858259229;
 Mon, 24 May 2021 05:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210521064050.191164-1-wqu@suse.com> <20210521064050.191164-28-wqu@suse.com>
 <CAL3q7H7jC+WL6LnqR+6uQ_fvjBOX2-w82z9ATE8XrkXa34C7gg@mail.gmail.com> <97d5af7a-eb3f-3730-f013-a7890ec76d9b@gmx.com>
In-Reply-To: <97d5af7a-eb3f-3730-f013-a7890ec76d9b@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 24 May 2021 13:10:48 +0100
Message-ID: <CAL3q7H6OHycoYK6hxM2shV12W0L55EnYrSir+pK7W=BKrtc-VQ@mail.gmail.com>
Subject: Re: [PATCH v3 27/31] btrfs: fix a crash caused by race between
 prepare_pages() and btrfs_releasepage()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 24, 2021 at 12:58 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/5/24 =E4=B8=8B=E5=8D=886:56, Filipe Manana wrote:
> > On Fri, May 21, 2021 at 9:08 PM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [BUG]
> >> When running generic/095, there is a high chance to crash with subpage
> >> data RW support:
> >>   assertion failed: PagePrivate(page) && page->private, in fs/btrfs/su=
bpage.c:171
> >>   ------------[ cut here ]------------
> >>   kernel BUG at fs/btrfs/ctree.h:3403!
> >>   Internal error: Oops - BUG: 0 [#1] SMP
> >>   CPU: 1 PID: 3567 Comm: fio Tainted: G         C O      5.12.0-rc7-cu=
stom+ #17
> >>   Hardware name: Khadas VIM3 (DT)
> >>   Call trace:
> >>    assertfail.constprop.0+0x28/0x2c [btrfs]
> >>    btrfs_subpage_assert+0x80/0xa0 [btrfs]
> >>    btrfs_subpage_set_uptodate+0x34/0xec [btrfs]
> >>    btrfs_page_clamp_set_uptodate+0x74/0xa4 [btrfs]
> >>    btrfs_dirty_pages+0x160/0x270 [btrfs]
> >>    btrfs_buffered_write+0x444/0x630 [btrfs]
> >>    btrfs_direct_write+0x1cc/0x2d0 [btrfs]
> >>    btrfs_file_write_iter+0xc0/0x160 [btrfs]
> >>    new_sync_write+0xe8/0x180
> >>    vfs_write+0x1b4/0x210
> >>    ksys_pwrite64+0x7c/0xc0
> >>    __arm64_sys_pwrite64+0x24/0x30
> >>    el0_svc_common.constprop.0+0x70/0x140
> >>    do_el0_svc+0x28/0x90
> >>    el0_svc+0x2c/0x54
> >>    el0_sync_handler+0x1a8/0x1ac
> >>    el0_sync+0x170/0x180
> >>   Code: f0000160 913be042 913c4000 955444bc (d4210000)
> >>   ---[ end trace 3fdd39f4cccedd68 ]---
> >>
> >> [CAUSE]
> >> Although prepare_pages() calls find_or_create_page(), which returns th=
e
> >> page locked, but in later prepare_uptodate_page() calls, we may call
> >> btrfs_readpage() which unlocked the page.
> >>
> >> This leaves a window where btrfs_releasepage() can sneak in and releas=
e
> >> the page.
> >>
> >> This can be proven by the dying ftrace dump:
> >>   fio-3567 : prepare_pages: r/i=3D5/257 page_offset=3D262144 private=
=3D1 after set extent map
> >>   fio-3536 : __btrfs_releasepage.part.0: r/i=3D5/257 page_offset=3D262=
144 private=3D1 clear extent map
> >>   fio-3567 : prepare_uptodate_page.part.0: r/i=3D5/257 page_offset=3D2=
62144 private=3D0 after readpage
> >>   fio-3567 : btrfs_dirty_pages: r/i=3D5/257 page_offset=3D262144 priva=
te=3D0  NOT PRIVATE
> >
> > Pasting here the tracing results form some custom tracepoints you
> > added for your own debugging does not add that much value IMHO, anyone
> > reading this will not know the exact places where the tracepoints were
> > added,
> > plus the previous explanation is clear enough.
>
> Fair enough, will no longer add custom trace output in the future.
> >
> >>
> >> [FIX]
> >> In prepare_uptodate_page(), we should not only check page->mapping, bu=
t
> >> also PagePrivate() to ensure we are still hold a correct page which ha=
s
> >> proper fs context setup.
> >>
> >> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> >> Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/file.c | 12 +++++++++++-
> >>   1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> >> index 6ef44afa939c..a4c092028bb6 100644
> >> --- a/fs/btrfs/file.c
> >> +++ b/fs/btrfs/file.c
> >> @@ -1341,7 +1341,17 @@ static int prepare_uptodate_page(struct inode *=
inode,
> >>                          unlock_page(page);
> >>                          return -EIO;
> >>                  }
> >> -               if (page->mapping !=3D inode->i_mapping) {
> >> +
> >> +               /*
> >> +                * Since btrfs_readpage() will get the page unlocked, =
we have
> >> +                * a window where fadvice() can try to release the pag=
e.
> >> +                * Here we check both inode mapping and PagePrivate() =
to
> >> +                * make sure the page is not released.
> >> +                *
> >> +                * The priavte flag check is essential for subpage as =
we need
> >> +                * to store extra bitmap using page->private.
> >> +                */
> >> +               if (page->mapping !=3D inode->i_mapping || !PagePrivat=
e(page)) {
> >
> > My comments from v1 still apply here:
> >
> > https://lore.kernel.org/linux-btrfs/CAL3q7H5P79kEqWUnN2QKG92N3u7+G0uWbm=
eC0yT1LypV63MAYA@mail.gmail.com/
>
> My bad memory...
>
> Now fixed and pushed to github.

Took a look at it, missing something like "there is" before "a window
..." and "make sure the page is not released" should be "... was not
released".
Other than that, it looks good.

With that, you can add

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Thanks,
> Qu
> >
> > The code looks good.
> > Thanks.
> >
> >>                          unlock_page(page);
> >>                          return -EAGAIN;
> >>                  }
> >> --
> >> 2.31.1
> >>
> >
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
