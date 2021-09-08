Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEB84038CC
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 13:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349199AbhIHLeD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 07:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbhIHLeC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 07:34:02 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3263AC061575
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 04:32:55 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t4so1829820qkb.9
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Sep 2021 04:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mAoUKoVd8FJVih7yRN6p881Dc0av+zeq8uv+OxjrAkM=;
        b=QfaTPgeW93wWjl1YFB0bbnH/aSwPbZO60JcNPbEt/onN1iBr9nPvdeYb3LQp7VodGV
         VZES6zmWpYPvAEZPdoSWRmQrHCaleMHlEy7sU5Zd6EkORmSFD5qEeCiWroazcs/Y8T02
         RnAGPRJRKNKmYh5ikD4yXb6xxKoUxGR8BhfmkgcApZ3SuBMfPdhtzrzEiTO/avDOsu/r
         dBv3RzU20XZhWzgCE5nsdPhImIsfBtfsxDJOnnlBK6n1sEhnhwNRpvzlVydEAOxOa5GD
         Vin3VaP6/5oHKD9jH4Ooi9WN7tCbqFuFVUgVNEYI+f/tc5sh8Jj6dBparm/Leq4Y/McX
         JY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mAoUKoVd8FJVih7yRN6p881Dc0av+zeq8uv+OxjrAkM=;
        b=P5Ou+sGlxecaGqZb2T92RMQbqP5eL0diN2PhYblVv4ZHSuEZ1fFGP/0cw8FT4a1Xq5
         QKJrqvQwGXoIVNc7TBg94vXTxIko2WqLTCpZVqtTqba6kCD/kMINqjMbttCoL6kKeo2u
         Elj67MZULlRfHvpmZ7rjv4NF67KqxA3gIg4VzBMMGxJ2TWo3UInxjWM0+4zqKg+nyqA6
         pGTLwLElLr2o+/O76N1RN1BANehxjHkETGUYGwjvcZueE38AbsAj6pJYdxidlW2NS3Bn
         okNkA1Ak0SycIhx7hBMS8oBu6ntTF6vZIM9cypoyo0iyZRGQMO6hQhFvlzAds0MiUnyT
         6+iw==
X-Gm-Message-State: AOAM530Epb8vonHQDqT4z0XElFSeDUUJac2IFiWF/yU346nY+9/6fEuo
        1khrhrgolVN/MUsUG7eWQO8r7QhiM0hrKdlwuL3OanAPR/UTBQ==
X-Google-Smtp-Source: ABdhPJyBo2GTeWZlmtR5NynfhKIzB44aLO9Y1uyvzC6fUKUGHrbWVHQHrbs/MMHjawXsPjnc7zStbvd0xh/xOJ8CBeE=
X-Received: by 2002:a37:ab12:: with SMTP id u18mr2781240qke.516.1631100774306;
 Wed, 08 Sep 2021 04:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200403134436.9095-1-nborisov@suse.com>
In-Reply-To: <20200403134436.9095-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 8 Sep 2021 12:32:18 +0100
Message-ID: <CAL3q7H4jnds5wjX5hWB=T5x_zHkTBMSYCc2ePgVG0mW6vG5Y4g@mail.gmail.com>
Subject: Re: [RESEND PATCH] btrfs: Remove received information from snapshot
 on ro->rw switch
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 3, 2020 at 2:45 PM Nikolay Borisov <nborisov@suse.com> wrote:
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
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Suggested-by: David Sterba <dsterba@suse.cz>
> ---
>
> I've been carrying this patch in my tree for around 2.5 years. It stems f=
rom
> multiple reports on the mailing list about people changing the RO->RW mod=
e on
> a received snapshot and getting unexpected behavior. AFAIR this patch res=
olved
> that.

I agree with it, and this sporadically causes problems that get
reported on the list.
I spent a bunch of time back and forth with a user that ran into a
problem caused by switching snapshots from RO to RW.

So I would like to add the following paragraphs and Link tag to the changel=
og:

"
Preserving the received_uuid (and related fields) after transitioning the
snapshot from RO to RW and then changing the snapshot has a potential for
causing send to fail in many unexpected ways if we later turn it back to
RO and use it for an incremental send operation.

A recent example, in the thread to which the Link tag below points to, we
had a user with a filesystem that had multiple snapshots with the same
received_uuid but with different content due to a transition from RO to RW
and then back to RO. When an incremental send was attempted using two of
those snapshots, it resulted in send emitting a clone operation that was
intended to clone from the parent root to the send root - however because
both roots had the same received_uuid, the receiver ended up picking the
send root as the source root for the clone operation, which happened to
result in the clone operation to fail with -EINVAL, due to the source and
destination offsets being the same (and on the same root and file). In this
particular case there was no harm, but we could end up in a case where the
clone operation succeeds but clones wrong data due to picking up an
incorrect root - as in the case of multiple snapshots with the same
received_uuid, it has no way to know which one is the correct one if they
have different content.

Link: https://lore.kernel.org/linux-btrfs/CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVX=
CdihawH1PgS6TiMchQ@mail.gmail.com/
"


A few comments below as well.

>
>
>  fs/btrfs/ioctl.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 40b729dce91c..39840b654600 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1873,6 +1873,7 @@ static noinline int btrfs_ioctl_subvol_setflags(str=
uct file *file,
>         struct btrfs_trans_handle *trans;
>         u64 root_flags;
>         u64 flags;
> +       bool clear_received_state =3D false;
>         int ret =3D 0;
>
>         if (!inode_owner_or_capable(inode))
> @@ -1917,6 +1918,7 @@ static noinline int btrfs_ioctl_subvol_setflags(str=
uct file *file,
>                         btrfs_set_root_flags(&root->root_item,
>                                      root_flags & ~BTRFS_ROOT_SUBVOL_RDON=
LY);
>                         spin_unlock(&root->root_item_lock);
> +                       clear_received_state =3D true;
>                 } else {
>                         spin_unlock(&root->root_item_lock);
>                         btrfs_warn(fs_info,
> @@ -1933,6 +1935,31 @@ static noinline int btrfs_ioctl_subvol_setflags(st=
ruct file *file,
>                 goto out_reset;
>         }
>
> +       if (clear_received_state) {
> +               if (!btrfs_is_empty_uuid(root->root_item.received_uuid)) =
{

This could be combined into a single if to reduce indentation:   if
(clear_received_state && !btrfs_is_empty_uuid(...))

Also, there's here indentation weirdness due to using spaces instead
of tabs, and checkpatch complains about it:

ERROR: code indent should use tabs where possible
#80: FILE: fs/btrfs/ioctl.c:1996:
+^I        if (!btrfs_is_empty_uuid(root->root_item.received_uuid)) {$

ERROR: code indent should use tabs where possible
#83: FILE: fs/btrfs/ioctl.c:1999:
+^I                ret =3D btrfs_uuid_tree_remove(trans,$

ERROR: code indent should use tabs where possible
#84: FILE: fs/btrfs/ioctl.c:2000:
+^I                                root->root_item.received_uuid,$
(...)

> +                       struct btrfs_root_item *root_item =3D &root->root=
_item;
> +
> +                       ret =3D btrfs_uuid_tree_remove(trans,
> +                                       root->root_item.received_uuid,
> +                                       BTRFS_UUID_KEY_RECEIVED_SUBVOL,
> +                                       root->root_key.objectid);

If we reach here, we should have reserved one additional metadata item
when starting the transaction.
And add a comment about what each item is used for - 1 for updating
the root item in the root tree, another 1 for removing an item from
the uuid tree.

Also, we can use root_item there instead of root->root_item.

Other than that, it looks fine to me.

Thanks.

> +
> +                       if (ret && ret !=3D -ENOENT) {
> +                               btrfs_abort_transaction(trans, ret);
> +                               btrfs_end_transaction(trans);
> +                               goto out_reset;
> +                       }
> +
> +                       memset(root_item->received_uuid, 0, BTRFS_UUID_SI=
ZE);
> +                       btrfs_set_root_stransid(root_item, 0);
> +                       btrfs_set_root_rtransid(root_item, 0);
> +                       btrfs_set_stack_timespec_sec(&root_item->stime, 0=
);
> +                       btrfs_set_stack_timespec_nsec(&root_item->stime, =
0);
> +                       btrfs_set_stack_timespec_sec(&root_item->rtime, 0=
);
> +                       btrfs_set_stack_timespec_nsec(&root_item->rtime, =
0);
> +               }
> +       }
> +
>         ret =3D btrfs_update_root(trans, fs_info->tree_root,
>                                 &root->root_key, &root->root_item);
>         if (ret < 0) {
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
