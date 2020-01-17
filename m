Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A946140D6E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 16:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAQPIa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 10:08:30 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33497 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgAQPI3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 10:08:29 -0500
Received: by mail-vs1-f68.google.com with SMTP id n27so15010009vsa.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 07:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=p+e5txQ6Ks/IBfyW4BvfdVdQA89YXgy8LunCrz8gJio=;
        b=W0n9HbF0wreFsGuacBrEOfaVXSi7C30qVP++jseLYkFcF7muKFEva2rMdo4YOfwbN+
         YRQPPEPeISJlbZNkMwyvT8qjNId1ExEtI0LM3nKJPm9/xuBI4XYUexaG0TVg1y4PQMDJ
         kAzF+fcph9keyVi+0j1I57kxA0h6ax+TES/Ps2AktRKGypxdLwbdSHUXtpsSMHACY14u
         wqvjBUe1m+5hG4Rm72QhRnlHfekWQHl9VNpPMU/RhqqGIjtscaeCiiA+ee/aehJg23XL
         SnNu2gqqR0tPWZx+CpRN04GoLtAEE0enVflWCA2uAT7IJl4iduLFQSq4gSTrkjZlfPer
         ENcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=p+e5txQ6Ks/IBfyW4BvfdVdQA89YXgy8LunCrz8gJio=;
        b=OD+biP7U4b0wNVfgINSrhG9ZnLFsrezfFzK0fJV8ppK2BFtBBRQ53DT4JwI+YWuEWi
         SNCCr2fwcruljW3/Vl8aSpzyUe79ZP+2lqowU0E99jw+6iiHKv1clqooSOLRTPF9eQdk
         FF8HEeCAh5m0uCN1SVRpT3XvXN9MDB8fd8DcV6d+BLUndCvryojKxkk6sNI4sJCFJOg4
         XZe6UXnvcdgxe0KQQJqIlfbBlXsuV3R8of4WOkejrTpgQz83ll0qplg8/3Rq35bLnq/P
         AgThR2j9MCfBLTwk1uCW7hijzrO4hXQktDe+Y/Yp93aPBIdJ+ys3D5FLudbmMvoqLuRV
         vhKQ==
X-Gm-Message-State: APjAAAX+/5A6HelH88YBoGckT9gyu3c1O4wzbbhTjkZqYeBaDZYonwL4
        EeNlvljlIiaZJL8b1cb6MI3puoAjWifYi2pdJrnvSNlM
X-Google-Smtp-Source: APXvYqzS/ND5fL3DKN0XW2fGmF514Hm4bFiuGl8LDkAr9C5ovekqcrypCJUxhNFMzRGgE/XZr2GfLNMqEZAQ4PhoJ38=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr4885910vsq.206.1579273708765;
 Fri, 17 Jan 2020 07:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20200117140224.42495-1-josef@toxicpanda.com> <20200117140224.42495-3-josef@toxicpanda.com>
In-Reply-To: <20200117140224.42495-3-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 17 Jan 2020 15:08:17 +0000
Message-ID: <CAL3q7H4gHMzE-dgaDnjZ1UVwxR6w3gga5NOCg=b8J=-0kv-MSQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] btrfs: don't use path->leave_spinning for truncate
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 2:03 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> The only time we actually leave the path spinning is if we're truncating
> a small amount and don't actually free an extent, which is not a common
> occurrence.  We have to set the path blocking in order to add the
> delayed ref anyway, so the first extent we find we set the path to
> blocking and stay blocking for the duration of the operation.  With the
> upcoming file extent map stuff there will be another case that we have
> to have the path blocking, so just swap to blocking always.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/inode.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 10087e1a5946..4bdd412182ae 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4066,7 +4066,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>                 goto out;
>         }
>
> -       path->leave_spinning =3D 1;
>         ret =3D btrfs_search_slot(trans, root, &key, path, -1, 1);
>         if (ret < 0)
>                 goto out;
> @@ -4218,7 +4217,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>                      root =3D=3D fs_info->tree_root)) {
>                         struct btrfs_ref ref =3D { 0 };
>
> -                       btrfs_set_path_blocking(path);
>                         bytes_deleted +=3D extent_num_bytes;
>
>                         btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_R=
EF,
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
