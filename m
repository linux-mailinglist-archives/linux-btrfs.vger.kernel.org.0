Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1E1FB5E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgFPPRd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 11:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgFPPRc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 11:17:32 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96BCD208B8
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592320651;
        bh=KKOtO4b9UjcorST/ihifD0rU5llKA7pIsuqGPvGPIdQ=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=wU0Vb9RBeB7NtIt8MVwtmNj1ZhLdWT7Vz8xJMLhVj1YESCnTSN0mLFBjDVlHpQob1
         8K5k3HnfMtM1zNNxqRCJ47rdvqXxh5zeoT24O7X1J+sT/xIBEGz20BlkXlvK8Lzc+j
         YcPseCGKNkiXkHD6DhVHD1NDLv9dxeovepAUvJ1w=
Received: by mail-vs1-f54.google.com with SMTP id r11so11657477vsj.5
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 08:17:31 -0700 (PDT)
X-Gm-Message-State: AOAM532WQuOABmvijVpNGkmuYIia1G+Lau2WNnWUodc1b4XMjUy2UC4f
        dud3jjoXFN6/LY4x2UDgDBSmgFxK4pL2dwiWw5M=
X-Google-Smtp-Source: ABdhPJzQ4Pene5uUfnMfmToueS7v9rDVbejlCd3owz9XIUMPIOIaUvzzLClIrUeiDNhLxX0frXBmd7dSbYuWI05RhEw=
X-Received: by 2002:a67:f9d6:: with SMTP id c22mr1941067vsq.14.1592320650760;
 Tue, 16 Jun 2020 08:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200615174601.14559-1-fdmanana@kernel.org> <20200616143420.GC27795@twin.jikos.cz>
In-Reply-To: <20200616143420.GC27795@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 16 Jun 2020 16:17:19 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4BWscwaA4PL2wKuejHgifZ6ea4Eq+pt-cZAQenxF9s3w@mail.gmail.com>
Message-ID: <CAL3q7H4BWscwaA4PL2wKuejHgifZ6ea4Eq+pt-cZAQenxF9s3w@mail.gmail.com>
Subject: Re: [PATCH 1/4] Btrfs: fix hang on snapshot creation after RWF_NOWAIT write
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 16, 2020 at 3:34 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Jun 15, 2020 at 06:46:01PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we do a successful RWF_NOWAIT write we end up locking the snapshot lock
> > of the inode, through a call to check_can_nocow(), but we never unlock it.
> >
> > This means the next attempt to create a snapshot on the subvolume will
> > hang forever.
> >
> > Trivial reproducer:
> >
> >   $ mkfs.btrfs -f /dev/sdb
> >   $ mount /dev/sdb /mnt
> >
> >   $ touch /mnt/foobar
> >   $ chattr +C /mnt/foobar
> >   $ xfs_io -d -c "pwrite -S 0xab 0 64K" /mnt/foobar
> >   $ xfs_io -d -c "pwrite -N -V 1 -S 0xfe 0 64K" /mnt/foobar
> >
> >   $ btrfs subvolume snapshot -r /mnt /mnt/snap
> >     --> hangs
> >
> > Fix this by unlocking the snapshot lock if check_can_nocow() returned
> > success.
> >
> > Fixes: edf064e7c6fec3 ("btrfs: nowait aio support")
> > CC: stable@vger.kernel.org # 4.13+
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/file.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 2c14312b05e8..04faa04fccd1 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1914,6 +1914,8 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
> >                       inode_unlock(inode);
> >                       return -EAGAIN;
> >               }
> > +             /* check_can_nocow() locks the snapshot lock on success */
> > +             btrfs_drew_write_unlock(&root->snapshot_lock);
>
> That's quite ugly that the locking semantics of check_can_nocow is
> hidden, this should be cleaned up too.
>
> The whole condition
>
> 1909                 if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
> 1910                                               BTRFS_INODE_PREALLOC)) ||
> 1911                     check_can_nocow(BTRFS_I(inode), pos, &count) <= 0)
>
> has 2 parts and it's not obvious from the context when the lock actually is
> taken. The flags check could be pushed down to check_can_nocow, the
> same but negated condition can be found in btrfs_file_write_iter so this
> would make it something like:
>
>         if (check_can_nocow(inode, pos, &count) <= 0) {
>                 /* fallback */
>                 return ...;
>         }
>         /*
>          * the lock is taken and needs to be unlocked at the right time
>          */
>
> Suggestions to rename check_can_nocow welcome too.

Sure, I can understand it may look not obvious on first sight at least.

Here I'm only focusing on functional problems and kept this fix as
small as possible to backport to stable releases,
as this is a bug that directly impacts user experience.

Thanks.

>
>
> >       }
> >
> >       current->backing_dev_info = inode_to_bdi(inode);
> > --
> > 2.26.2
