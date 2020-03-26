Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 965E2194087
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 14:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCZNw6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 09:52:58 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41610 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgCZNw5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 09:52:57 -0400
Received: by mail-vs1-f67.google.com with SMTP id a63so3850409vsa.8
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=WrMMRGBZmT7qflZlcBE4r2q5DijLTHFeXUloQfp22NA=;
        b=vCgXHUHRswVtCdjiDsSN3BIThf5MD7lXHVqw5SEBMrWF3n+azXhDL0ArFWSuNlsgPr
         SR4DlGIMaJcMxgEGWSiUmYVOfciF4dV9XPbvSlro0r7X/S6+bnDoitJ2ls48UUcYR25W
         h04jBVxKZEFd5zMHK2KX4lJf96cTT2OnLauxPE0dkxplbp2rn4uhfIz3ZJwz2f20vGHr
         4DwG+3Uve+WUXiYoNW5iU3n5KqYieTwaVl0ipa2bUdoibd5duw1yM5Q+OxHvErYGq77H
         p2XnFP9p/lAIueszi/nUdwOZYyN3ogG3VXzFPINd9b9aviJndHHm6HW1fFzNAYoq3y7w
         2rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=WrMMRGBZmT7qflZlcBE4r2q5DijLTHFeXUloQfp22NA=;
        b=IAx8mDHudrYxn4Acf/ZsmLuaagEL3Yz9PyI948deW5OxzMR1li4+nvF8bGcJ1205Nx
         CcAqND8Rl32PLJ/m/yeJRX/g1728cqVCRF92SjbvGZJDeN6139JVP4pTEX5v/lMHFc9P
         juQU6Xq2gz8fDctReSCFFo8EudSlBoGOHqM/Y+5f0MyvIwwfYXdjqPZR5qqlRRy5PULA
         0KXjhjPD7/6aJlbSDUmwXgfK60jcgDGDEvxxWi9DURt9saezCtUOqlQ8iH/6GEpygD3M
         aB65+hPO+fl2pNB9EOMx3Sv8JCqZPfnricYAVb+ZdZ4VqVIvB3yvaCBKVex2zsGaEgB0
         wyfg==
X-Gm-Message-State: ANhLgQ1W1xqfolRBC3DPhi41c5+P2jHazbZ91HRWYpUJfoQI4dkyhOcz
        Ld3W3ZdaErEHF/n+uxbrSsD7DrSuu70xoB/0rI4=
X-Google-Smtp-Source: ADFU+vtYTGrguDFoAfzaJi+jn0zpTDnFX/56er9OtLWW8JxsrJ+XY1i+F5U/L4PaIEAuzOMrJeo2CrySxDQwhQV1Q0c=
X-Received: by 2002:a67:ffd3:: with SMTP id w19mr6383392vsq.90.1585230775263;
 Thu, 26 Mar 2020 06:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200325015251.28838-1-marcos@mpdesouza.com> <CAL3q7H5y_i1czDe9ftp5U-SNFO1fOG8DJPoNToaMLJwjX-D-kw@mail.gmail.com>
In-Reply-To: <CAL3q7H5y_i1czDe9ftp5U-SNFO1fOG8DJPoNToaMLJwjX-D-kw@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 26 Mar 2020 13:52:44 +0000
Message-ID: <CAL3q7H6HyPYUUSiFNAQyfUA1LfyU1oUoxAme5gVVp2gXSf=dLQ@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: send: Emit all xattr of an inode if the
 uid/gid changed
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 26, 2020 at 1:51 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Wed, Mar 25, 2020 at 1:52 AM Marcos Paulo de Souza
> <marcos@mpdesouza.com> wrote:
> >
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> >
> > [PROBLEM]
> > When doing incremental send with a file with capabilities, there is a
> > situation where the capability can be lost in the receiving side. The
> > sequence of actions bellow show the problem:
> >
> > $ mount /dev/sda fs1
> > $ mount /dev/sdb fs2
> >
> > $ touch fs1/foo.bar
> > $ setcap cap_sys_nice+ep fs1/foo.bar
> > $ btrfs subvol snap -r fs1 fs1/snap_init
> > $ btrfs send fs1/snap_init | btrfs receive fs2
> >
> > $ chgrp adm fs1/foo.bar
> > $ setcap cap_sys_nice+ep fs1/foo.bar
> >
> > $ btrfs subvol snap -r fs1 fs1/snap_complete
> > $ btrfs subvol snap -r fs1 fs1/snap_incremental
> >
> > $ btrfs send fs1/snap_complete | btrfs receive fs2
> > $ btrfs send -p fs1/snap_init fs1/snap_incremental | btrfs receive fs2
> >
> > At this point fs/snap_increment/foo.bar lost the capability, since a
> > chgrp was emitted by "btrfs send". The current code only checks for the
> > items that changed, and as the XATTR kept the value only the chgrp chan=
ge
> > is emitted.
>
> So, the explanation could be a bit more clear.
>
> First the send stream emits a "chown" command (and not a "chgrp"
> command), that's what is used to change both users and groups.
>
> Then mentioning that changing the group of a file causes the
> capability xattr to be deleted is crucial - that's why the receiving
> side ends up losing the capability, because we send an operation to
> change the group but we don't send an operation to set the capability
> xattr, since the value of the xattr is the same in both snapshots.
>
> >
> > [FIX]
> > In order to fix this issue, check if the uid/gid of the inode change,
> > and if yes, emit all XATTR again, including the capability.
> >
> > Fixes: https://github.com/kdave/btrfs-progs/issues/202
>
> The Fixes: tag is used to identify commits, in the kernel, that
> introduced some problem.
> A "Link:" tag is more appropriate to point to the btrfs-progs github issu=
e.
>
> >
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  I'm posting this patch as a RFC because I had some questions
> >  * Is this the correct place to fix?
>
> Nop, see below.
>
> >  * Also, emitting all XATTR of the inode seems overkill...
>
> Yes, but I wouldn't worry much - first it's not common for files to
> have many xattrs, second they are small values and are layed out
> sequentially in the btree, and above all, uids/gids are mostly static
> and don't change often.
> But that can be avoided, see below.
>
> >  * Should it be fixed in userspace?
>
> No.
>
> Send should emit a sequence of operations that produces correct
> results in the receiving side. It should never result in any data or
> metadata loss, crashes, etc.
>
> This is no different from rename dependencies for example, where we
> make send change the order of rename and other operations so that the
> receiving side doesn't fail - otherwise we would have to add a lot of
> intelligence and complicated code to btrfs receive in progs - which
> brings us to another point - any consumer of a send stream would have
> to be changed - btrfs receive from btrfs-progs, is the most well
> known, and very few people will use anything else, but there may be
> other consumers of send streams out there.
>
> >
> >  fs/btrfs/send.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index c5f41bd86765..5cffe5da91cf 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -6187,6 +6187,14 @@ static int changed_inode(struct send_ctx *sctx,
> >                 sctx->cur_inode_mode =3D btrfs_inode_mode(
> >                                 sctx->right_path->nodes[0], right_ii);
> >         } else if (result =3D=3D BTRFS_COMPARE_TREE_CHANGED) {
> > +               u64 left_uid =3D btrfs_inode_uid(sctx->left_path->nodes=
[0],
> > +                                       left_ii);
> > +               u64 left_gid =3D btrfs_inode_gid(sctx->left_path->nodes=
[0],
> > +                                       left_ii);
> > +               u64 right_uid =3D btrfs_inode_uid(sctx->right_path->nod=
es[0],
> > +                                       right_ii);
> > +               u64 right_gid =3D btrfs_inode_gid(sctx->right_path->nod=
es[0],
> > +                                       right_ii);
> >                 /*
> >                  * We need to do some special handling in case the inod=
e was
> >                  * reported as changed with a changed generation number=
. This
> > @@ -6236,15 +6244,12 @@ static int changed_inode(struct send_ctx *sctx,
> >                         sctx->send_progress =3D sctx->cur_ino + 1;
> >
> >                         /*
> > -                        * Now process all extents and xattrs of the in=
ode as if
> > +                        * Now process all extents of the inode as if
> >                          * they were all new.
> >                          */
> >                         ret =3D process_all_extents(sctx);
> >                         if (ret < 0)
> >                                 goto out;
> > -                       ret =3D process_all_new_xattrs(sctx);
> > -                       if (ret < 0)
> > -                               goto out;
> >                 } else {
> >                         sctx->cur_inode_gen =3D left_gen;
> >                         sctx->cur_inode_new =3D 0;
> > @@ -6255,6 +6260,22 @@ static int changed_inode(struct send_ctx *sctx,
> >                         sctx->cur_inode_mode =3D btrfs_inode_mode(
> >                                         sctx->left_path->nodes[0], left=
_ii);
> >                 }
> > +
> > +               /*
> > +                * Process all XATTR of the inode if the generation or =
owner
> > +                * changed.
> > +                *
> > +                * If the inode changed it's uid/gid, but kept a
> > +                * security.capability xattr, only the uid/gid will be =
emitted,
> > +                * causing the related xattr to deleted. For this reaso=
n always
> > +                * emit the XATTR when an inode has changed.
> > +                */
> > +               if (sctx->cur_inode_new_gen || left_uid !=3D right_uid =
||
> > +                   left_gid !=3D right_gid) {
> > +                       ret =3D process_all_new_xattrs(sctx);
>
> So the correct place for fixing this issue is at
> send.c:finish_inode_if_needed(), in the following place:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/f=
s/btrfs/send.c?h=3Dv5.6-rc7#n6000
>
> If a chown operation is sent, then just send the xattr - and instead
> if sending all xattrs, just send the xattr with the name
> "security.capability" - check first if there are any other
> capabilities that use other xattr names - if there are, just emit
> set_xattr operations for all xattrs with a "security." prefix in their
> name.
>
> Thanks.

Also, I would change the subject of the patch, so that it mentions
what problems it fixes and not how it fixes a problem.


>
>
> > +                       if (ret < 0)
> > +                               goto out;
> > +               }
> >         }
> >
> >  out:
> > --
> > 2.25.1
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
