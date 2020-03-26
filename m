Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED6194058
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 14:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCZNve (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 09:51:34 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33277 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZNvd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 09:51:33 -0400
Received: by mail-vs1-f67.google.com with SMTP id y138so3877408vsy.0
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=6eNlm4u0hFFS2Z0SlwlkENMEKenje0kyY7uBD4RBXME=;
        b=OuXeh9jVxiKs0Nwsz41vhkE+mXCoSE/IinZjgKgo93wD+zgfc8e0Y1+MZFReLCs+Zs
         BIjEoNJDvAIITXbn9Sdw9vo2oDBWcXDE3OkNy/RuTlGIZnw/uU+QCDPkIRZs3WbREfi0
         HlIlO0QknjktDRMoaj4UgAKde6eUe3YPt5JF4vaAsP3OUtuZenWI9/tKSzjZhWxHaRhB
         QLaG9UlILg68oSLl0ENQeoIT7J8dZTCSykuR0lQwQ+wA8EZ5gl1+IET6pN8PK+rYLXVY
         LOLkt7sku6yRjCbk7vWIt7Stgq8dSpZXZFJ32lnER2j506Q3Kwrrzn3bBGO1MV3sKXGd
         JLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=6eNlm4u0hFFS2Z0SlwlkENMEKenje0kyY7uBD4RBXME=;
        b=OWQ4OGsG0mOz/RTFbEVtup6KWH4cDXdb9DubcLk8uQXcqq75fJZYCDjBLRndZdFwUe
         u34TM2QV3q8A1Y7C1QdR0Em3l5uiOvUYXWmM6Ifhm+ecB11lpnj2J45naO9IU3DwmFy8
         4OKdiWnPPSvuoxABgqh//dGpUyWGOAA78Es2sKCEkHuAcD4zNsUNi0xbhQewe3D+GPx9
         VpWZg9uXy38uGSJ9Wpnp0r6esATSOxeuJHJjf3czURAEnYzDgHcXLiu/fDebWjuATThs
         7sSNZbmnyXqtTQLfh3UVfM/HhwhJoHuBk+kqjW6jNcuhUgDo6FmDQ67q/v0IjZBn4uo7
         OowA==
X-Gm-Message-State: ANhLgQ2pGPg8n63vqZNlrjsoy8VVo8duX0BxWNvqIDhpFLtAkAQZhEix
        fsj7A87Wjkoe86QbIldhry0wl7rvycFTz8PDl04=
X-Google-Smtp-Source: ADFU+vtm5OTmSYW6LOyq7ghR65dNCiDEE1EBHe8BZflayhFJgQ5q2BxU1mE6Itps3leH02WArng5kyoAiDZawQAqJVI=
X-Received: by 2002:a67:7c8f:: with SMTP id x137mr6182829vsc.99.1585230691891;
 Thu, 26 Mar 2020 06:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200325015251.28838-1-marcos@mpdesouza.com>
In-Reply-To: <20200325015251.28838-1-marcos@mpdesouza.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 26 Mar 2020 13:51:20 +0000
Message-ID: <CAL3q7H5y_i1czDe9ftp5U-SNFO1fOG8DJPoNToaMLJwjX-D-kw@mail.gmail.com>
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

On Wed, Mar 25, 2020 at 1:52 AM Marcos Paulo de Souza
<marcos@mpdesouza.com> wrote:
>
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>
> [PROBLEM]
> When doing incremental send with a file with capabilities, there is a
> situation where the capability can be lost in the receiving side. The
> sequence of actions bellow show the problem:
>
> $ mount /dev/sda fs1
> $ mount /dev/sdb fs2
>
> $ touch fs1/foo.bar
> $ setcap cap_sys_nice+ep fs1/foo.bar
> $ btrfs subvol snap -r fs1 fs1/snap_init
> $ btrfs send fs1/snap_init | btrfs receive fs2
>
> $ chgrp adm fs1/foo.bar
> $ setcap cap_sys_nice+ep fs1/foo.bar
>
> $ btrfs subvol snap -r fs1 fs1/snap_complete
> $ btrfs subvol snap -r fs1 fs1/snap_incremental
>
> $ btrfs send fs1/snap_complete | btrfs receive fs2
> $ btrfs send -p fs1/snap_init fs1/snap_incremental | btrfs receive fs2
>
> At this point fs/snap_increment/foo.bar lost the capability, since a
> chgrp was emitted by "btrfs send". The current code only checks for the
> items that changed, and as the XATTR kept the value only the chgrp change
> is emitted.

So, the explanation could be a bit more clear.

First the send stream emits a "chown" command (and not a "chgrp"
command), that's what is used to change both users and groups.

Then mentioning that changing the group of a file causes the
capability xattr to be deleted is crucial - that's why the receiving
side ends up losing the capability, because we send an operation to
change the group but we don't send an operation to set the capability
xattr, since the value of the xattr is the same in both snapshots.

>
> [FIX]
> In order to fix this issue, check if the uid/gid of the inode change,
> and if yes, emit all XATTR again, including the capability.
>
> Fixes: https://github.com/kdave/btrfs-progs/issues/202

The Fixes: tag is used to identify commits, in the kernel, that
introduced some problem.
A "Link:" tag is more appropriate to point to the btrfs-progs github issue.

>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  I'm posting this patch as a RFC because I had some questions
>  * Is this the correct place to fix?

Nop, see below.

>  * Also, emitting all XATTR of the inode seems overkill...

Yes, but I wouldn't worry much - first it's not common for files to
have many xattrs, second they are small values and are layed out
sequentially in the btree, and above all, uids/gids are mostly static
and don't change often.
But that can be avoided, see below.

>  * Should it be fixed in userspace?

No.

Send should emit a sequence of operations that produces correct
results in the receiving side. It should never result in any data or
metadata loss, crashes, etc.

This is no different from rename dependencies for example, where we
make send change the order of rename and other operations so that the
receiving side doesn't fail - otherwise we would have to add a lot of
intelligence and complicated code to btrfs receive in progs - which
brings us to another point - any consumer of a send stream would have
to be changed - btrfs receive from btrfs-progs, is the most well
known, and very few people will use anything else, but there may be
other consumers of send streams out there.

>
>  fs/btrfs/send.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index c5f41bd86765..5cffe5da91cf 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6187,6 +6187,14 @@ static int changed_inode(struct send_ctx *sctx,
>                 sctx->cur_inode_mode =3D btrfs_inode_mode(
>                                 sctx->right_path->nodes[0], right_ii);
>         } else if (result =3D=3D BTRFS_COMPARE_TREE_CHANGED) {
> +               u64 left_uid =3D btrfs_inode_uid(sctx->left_path->nodes[0=
],
> +                                       left_ii);
> +               u64 left_gid =3D btrfs_inode_gid(sctx->left_path->nodes[0=
],
> +                                       left_ii);
> +               u64 right_uid =3D btrfs_inode_uid(sctx->right_path->nodes=
[0],
> +                                       right_ii);
> +               u64 right_gid =3D btrfs_inode_gid(sctx->right_path->nodes=
[0],
> +                                       right_ii);
>                 /*
>                  * We need to do some special handling in case the inode =
was
>                  * reported as changed with a changed generation number. =
This
> @@ -6236,15 +6244,12 @@ static int changed_inode(struct send_ctx *sctx,
>                         sctx->send_progress =3D sctx->cur_ino + 1;
>
>                         /*
> -                        * Now process all extents and xattrs of the inod=
e as if
> +                        * Now process all extents of the inode as if
>                          * they were all new.
>                          */
>                         ret =3D process_all_extents(sctx);
>                         if (ret < 0)
>                                 goto out;
> -                       ret =3D process_all_new_xattrs(sctx);
> -                       if (ret < 0)
> -                               goto out;
>                 } else {
>                         sctx->cur_inode_gen =3D left_gen;
>                         sctx->cur_inode_new =3D 0;
> @@ -6255,6 +6260,22 @@ static int changed_inode(struct send_ctx *sctx,
>                         sctx->cur_inode_mode =3D btrfs_inode_mode(
>                                         sctx->left_path->nodes[0], left_i=
i);
>                 }
> +
> +               /*
> +                * Process all XATTR of the inode if the generation or ow=
ner
> +                * changed.
> +                *
> +                * If the inode changed it's uid/gid, but kept a
> +                * security.capability xattr, only the uid/gid will be em=
itted,
> +                * causing the related xattr to deleted. For this reason =
always
> +                * emit the XATTR when an inode has changed.
> +                */
> +               if (sctx->cur_inode_new_gen || left_uid !=3D right_uid ||
> +                   left_gid !=3D right_gid) {
> +                       ret =3D process_all_new_xattrs(sctx);

So the correct place for fixing this issue is at
send.c:finish_inode_if_needed(), in the following place:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/=
btrfs/send.c?h=3Dv5.6-rc7#n6000

If a chown operation is sent, then just send the xattr - and instead
if sending all xattrs, just send the xattr with the name
"security.capability" - check first if there are any other
capabilities that use other xattr names - if there are, just emit
set_xattr operations for all xattrs with a "security." prefix in their
name.

Thanks.


> +                       if (ret < 0)
> +                               goto out;
> +               }
>         }
>
>  out:
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
