Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374B3403B38
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 16:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbhIHOJ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 10:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhIHOJ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 10:09:58 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F2AC061575
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 07:08:50 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id b4so1974549qtx.0
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Sep 2021 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=5edT1bXtoFavd/DRg2aLktGyjwCn42b2ECuqH+aRjFw=;
        b=jz6eTasz2N2nQ7J2SFK+Ic0Ksu7Bvg9HDj4Sc/T8NLG/SM4XcK5XkigGa64mVWgq6R
         XHI1/KcxmSoew772MvOLOPkM1WTws+pOrjoFeiw/MKnQSrjdLVKA/nvr/eqeFlkmi1BE
         gwZ0hmDlrnqcrD0dyQ+fAil8SZb3jCV7V9xVqtZE5sq66v6dX0VTeT1qzaVimtN3Fgs/
         yve+t67Y33HYoOgOVbD++qGfilKvoFv4Y4x5CD4awe21kefU6G/nWQ6+nbmkOP6/H5m4
         T1Wg3wrFqnEw9RfiTCiPBBDFVbV2+zGkNzehHP0p8NtGY2SuS+D67INezZ2bWG00BRx4
         qgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=5edT1bXtoFavd/DRg2aLktGyjwCn42b2ECuqH+aRjFw=;
        b=dnwpTgIev+C2/5kukSV0QqRVtQEibmPPxGkjmSnHK332IRYfdXkj/8uMjypNo6lGYt
         /W4jUwYpCWfFpAkXBVchHs9g2VDJ6B7rMnFpFz3XtwzGwucVlkdZlqnQbWceL6KuA5KW
         j3zst35RUuNEg/EOukwZpxAylGFsxuyPI8n8g2CnHWmwDQ43gjwYc8LZh50BQe3bhSk5
         7a/t7v1J7V4XRVb2C9I9MRvYHd2bk2VDsljmcStItygmav+XDLK5dcD5zsx+DV4R6uYy
         TuXXrriAPidkM5CDQ11ZD1GwH/6sU9LGXajn4YBo1kobY5i/6cwYk+ri+iw0ks1b4ZRn
         LLlw==
X-Gm-Message-State: AOAM531rTcypeL1GJzyfPsrViAVMEuvk8HbVUpn4jHdZReQAjRymSbs0
        1goTT5rxCNu0MrnQxx+Hl7XghxsGKi/FztCxgZnHt0YTBjM=
X-Google-Smtp-Source: ABdhPJwmXLLCiUSVO6fKOVkSNRoUr67NnqYDGlouUzcVa8DQeeLv3XiNC4RJ7UReqq0csO3QS98T8Tf0vo0ic5Zvo44=
X-Received: by 2002:ac8:7354:: with SMTP id q20mr3872918qtp.329.1631110129596;
 Wed, 08 Sep 2021 07:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210908135135.1474055-1-nborisov@suse.com>
In-Reply-To: <20210908135135.1474055-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 8 Sep 2021 15:08:13 +0100
Message-ID: <CAL3q7H5bLtZZwmBpD_ijH4vvNm3MorjZmrTTLWOy61_j6Kg_2A@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: Remove received information from snapshot on
 ro->rw switch
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 8, 2021 at 2:53 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
> Currently when a read-only snapshot is received and subsequently its
> ro property is set to false i.e. switched to rw-mode the
> received_uuid/stime/rtime/stransid/rtransid of that subvol remains
> intact. However, once the received volume is switched to RW mode we
> cannot guaranteee that it contains the same data, so it makes sense
> to remove those fields which indicate this volume was ever
> send/received. Additionally, sending such volume can cause conflicts
> due to the presence of received_uuid.
>
> Preserving the received_uuid (and related fields) after transitioning the
> snapshot from RO to RW and then changing the snapshot has a potential for
> causing send to fail in many unexpected ways if we later turn it back to
> RO and use it for an incremental send operation.
>
> A recent example, in the thread to which the Link tag below points to, we
> had a user with a filesystem that had multiple snapshots with the same
> received_uuid but with different content due to a transition from RO to R=
W
> and then back to RO. When an incremental send was attempted using two of
> those snapshots, it resulted in send emitting a clone operation that was
> intended to clone from the parent root to the send root - however because
> both roots had the same received_uuid, the receiver ended up picking the
> send root as the source root for the clone operation, which happened to
> result in the clone operation to fail with -EINVAL, due to the source and
> destination offsets being the same (and on the same root and file). In th=
is
> particular case there was no harm, but we could end up in a case where th=
e
> clone operation succeeds but clones wrong data due to picking up an
> incorrect root - as in the case of multiple snapshots with the same
> received_uuid, it has no way to know which one is the correct one if they
> have different content.
>
> Link: https://lore.kernel.org/linux-btrfs/CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkE=
VXCdihawH1PgS6TiMchQ@mail.gmail.com/
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Suggested-by: David Sterba <dsterba@suse.cz>

Thanks, looks good.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/ioctl.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9eb0c1eb568e..67709d274489 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1927,9 +1927,11 @@ static noinline int btrfs_ioctl_subvol_setflags(st=
ruct file *file,
>         struct inode *inode =3D file_inode(file);
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>         struct btrfs_root *root =3D BTRFS_I(inode)->root;
> +       struct btrfs_root_item *root_item =3D &root->root_item;
>         struct btrfs_trans_handle *trans;
>         u64 root_flags;
>         u64 flags;
> +       bool clear_received_state =3D false;
>         int ret =3D 0;
>
>         if (!inode_owner_or_capable(file_mnt_user_ns(file), inode))
> @@ -1960,9 +1962,9 @@ static noinline int btrfs_ioctl_subvol_setflags(str=
uct file *file,
>         if (!!(flags & BTRFS_SUBVOL_RDONLY) =3D=3D btrfs_root_readonly(ro=
ot))
>                 goto out_drop_sem;
>
> -       root_flags =3D btrfs_root_flags(&root->root_item);
> +       root_flags =3D btrfs_root_flags(root_item);
>         if (flags & BTRFS_SUBVOL_RDONLY) {
> -               btrfs_set_root_flags(&root->root_item,
> +               btrfs_set_root_flags(root_item,
>                                      root_flags | BTRFS_ROOT_SUBVOL_RDONL=
Y);
>         } else {
>                 /*
> @@ -1971,9 +1973,10 @@ static noinline int btrfs_ioctl_subvol_setflags(st=
ruct file *file,
>                  */
>                 spin_lock(&root->root_item_lock);
>                 if (root->send_in_progress =3D=3D 0) {
> -                       btrfs_set_root_flags(&root->root_item,
> +                       btrfs_set_root_flags(root_item,
>                                      root_flags & ~BTRFS_ROOT_SUBVOL_RDON=
LY);
>                         spin_unlock(&root->root_item_lock);
> +                       clear_received_state =3D true;
>                 } else {
>                         spin_unlock(&root->root_item_lock);
>                         btrfs_warn(fs_info,
> @@ -1984,14 +1987,40 @@ static noinline int btrfs_ioctl_subvol_setflags(s=
truct file *file,
>                 }
>         }
>
> -       trans =3D btrfs_start_transaction(root, 1);
> +       /*
> +        * 1 item for updating the uuid root in the root tree
> +        * 1 item for actually removing the uuid record in the uuid tree
> +        */
> +       trans =3D btrfs_start_transaction(root, 2);
>         if (IS_ERR(trans)) {
>                 ret =3D PTR_ERR(trans);
>                 goto out_reset;
>         }
>
> -       ret =3D btrfs_update_root(trans, fs_info->tree_root,
> -                               &root->root_key, &root->root_item);
> +       if (clear_received_state &&
> +           !btrfs_is_empty_uuid(root_item->received_uuid)) {
> +
> +               ret =3D btrfs_uuid_tree_remove(trans, root_item->received=
_uuid,
> +                                            BTRFS_UUID_KEY_RECEIVED_SUBV=
OL,
> +                                            root->root_key.objectid);
> +
> +               if (ret && ret !=3D -ENOENT) {
> +                       btrfs_abort_transaction(trans, ret);
> +                       btrfs_end_transaction(trans);
> +                       goto out_reset;
> +               }
> +
> +               memset(root_item->received_uuid, 0, BTRFS_UUID_SIZE);
> +               btrfs_set_root_stransid(root_item, 0);
> +               btrfs_set_root_rtransid(root_item, 0);
> +               btrfs_set_stack_timespec_sec(&root_item->stime, 0);
> +               btrfs_set_stack_timespec_nsec(&root_item->stime, 0);
> +               btrfs_set_stack_timespec_sec(&root_item->rtime, 0);
> +               btrfs_set_stack_timespec_nsec(&root_item->rtime, 0);
> +       }
> +
> +       ret =3D btrfs_update_root(trans, fs_info->tree_root, &root->root_=
key,
> +                               root_item);
>         if (ret < 0) {
>                 btrfs_end_transaction(trans);
>                 goto out_reset;
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
