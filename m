Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8321331B7C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Feb 2021 12:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhBOLG2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Feb 2021 06:06:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhBOLG0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Feb 2021 06:06:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF06C64D9D
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Feb 2021 11:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613387145;
        bh=ulPemHLRcbQB/9/2Fm2UKACHBPe3D+lwdD0pewiUfiM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qWItrbcxYtxPAy8USCu+UNVfbAE6owotzyIoVUPCTF4k2GX6Q0XB5VOWM3McxExk/
         EMQuZYRo7O08dd4CR3itJPy9JLadXp0LejlkWn7+kPQs/7raPmYePf90v+2qqBSAU/
         EjYkxbcDp8+GKgD8x7Im38X+ykYn8CfImzWNTms/3JCgzCGYL+hpLApd7mOeUQHMPc
         dplWU6tcc1bRg43hxwNI0OXxJymGONd1zw9TkuSgMY2bclWY4xD8C9Adrux/73+QF/
         ldF3eJJKZzStf+NSBpsIaCwHpLqQREEHDMvrbv4dS/dD7RllejSDaFVCeTKF35NSj9
         t59LqdI88yHkQ==
Received: by mail-qk1-f173.google.com with SMTP id m144so5945795qke.10
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Feb 2021 03:05:45 -0800 (PST)
X-Gm-Message-State: AOAM533kZeXQVIEoFoAEgvYWFiXxai0CmudE3EVnH9J5Q1/+B5tDzWTZ
        iay6vkGZW2jG9j1syIAVq4OJGUBn1jHrJPBSi7Y=
X-Google-Smtp-Source: ABdhPJx7ZcwJ8wacHHXJ6tjpbvD811ljHAy8vLEfFeqTO8a6pTDiU0hPjImFVjjboX2XErGE4Jr+UbHdASbanNYaCzo=
X-Received: by 2002:a05:620a:118e:: with SMTP id b14mr14609756qkk.438.1613387144845;
 Mon, 15 Feb 2021 03:05:44 -0800 (PST)
MIME-Version: 1.0
References: <94663c8a2172dc96b760d356a538d45c36f46040.1613062764.git.fdmanana@suse.com>
 <20210213090416.926A.409509F4@e16-tech.com>
In-Reply-To: <20210213090416.926A.409509F4@e16-tech.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 15 Feb 2021 11:05:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H45VddXz+OVcFG8uDM2WJJsdCn0VuTVfJAb28HzU78J6w@mail.gmail.com>
Message-ID: <CAL3q7H45VddXz+OVcFG8uDM2WJJsdCn0VuTVfJAb28HzU78J6w@mail.gmail.com>
Subject: Re: [PATCH 5.10.x] btrfs: fix crash after non-aligned direct IO write
 with O_DSYNC
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 13, 2021 at 1:07 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> > This bug only affects 5.10 kernels, and the regression was introduced in
> > 5.10-rc1 by commit 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround").
> > The bug does not exist in 5.11 kernels due to commit ecfdc08b8cc65d
> > ("btrfs: remove dio iomap DSYNC workaround"), which depends on other
> > changes that went into the merge window for 5.11. So this is a fix only
> > for 5.10.x stable kernels, as there are people hitting this.
>
> It is OK too to backport commit ecfdc08b8cc65d
>  ("btrfs: remove dio iomap DSYNC workaround") to 5.10 for this problem?
>
> the iomap issue for commit 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround")
> is already fixed in 5.10?

Quoting the changelog:

"commit ecfdc08b8cc65d
("btrfs: remove dio iomap DSYNC workaround"), which depends on other
changes that went into the merge window for 5.11."

All the changes, are (at least):

commit ecfdc08b8cc65d737eebc26a1ee1875a097fd6a0   --> 5.11-rc1
Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
Date:   Thu Sep 24 11:39:21 2020 -0500

    btrfs: remove dio iomap DSYNC workaround

commit a42fa643169d2325602572633fcaa16862990e28
Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
Date:   Thu Sep 24 11:39:20 2020 -0500

    btrfs: call iomap_dio_complete() without inode_lock

commit 502756b380938022c848761837f8fa3976906aa1
Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
Date:   Thu Sep 24 11:39:19 2020 -0500

    btrfs: remove btrfs_inode::dio_sem

commit e9adabb9712ef9424cbbeeaa027d962ab5262e19
Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
Date:   Thu Sep 24 11:39:18 2020 -0500

    btrfs: use shared lock for direct writes within EOF

commit c352370633400d13765cc88080c969799ea51108
Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
Date:   Thu Sep 24 11:39:17 2020 -0500

    btrfs: push inode locking and unlocking into buffered/direct write

commit a14b78ad06aba0fa7e76d2bc13c5ba581a7f331a
Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
Date:   Thu Sep 24 11:39:16 2020 -0500

    btrfs: introduce btrfs_inode_lock()/unlock()

commit b8d8e1fd570a194904f545b135efc880d96a41a4
Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
Date:   Thu Sep 24 11:39:15 2020 -0500

    btrfs: introduce btrfs_write_check()

That's probably too much to add to stable at once, plus I'm assuming
all required iomap dependencies are in 5.10 already (it seems so,
unless I missed something).

Usually we don't add patches to stable that didn't go through Linus'
tree either (there were 1 or 2 very rare exceptions in the past I
think), but when a backport depends on so many patches, and not all
from the same patchset, the risk of getting something wrong is
significant. That's why I opted to send this patch, which is much more
simple.

David has more experience on that and it's up to him to decide.



>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/02/13
>
>
> > Fixes: 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround")
> > CC: stable@vger.kernel.org # 5.10 (and only 5.10)
> > Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1181605
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/inode.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index acc47e2ffb46..b536d21541a9 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -8026,8 +8026,12 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> >       bool relock = false;
> >       ssize_t ret;
> >
> > -     if (check_direct_IO(fs_info, iter, offset))
> > +     if (check_direct_IO(fs_info, iter, offset)) {
> > +             ASSERT(current->journal_info == NULL ||
> > +                    current->journal_info == BTRFS_DIO_SYNC_STUB);
> > +             current->journal_info = NULL;
> >               return 0;
> > +     }
> >
> >       count = iov_iter_count(iter);
> >       if (iov_iter_rw(iter) == WRITE) {
> > --
> > 2.28.0
>
>
