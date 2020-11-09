Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591F62AB464
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 11:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgKIKHF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 05:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgKIKHE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Nov 2020 05:07:04 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCB7C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 02:07:04 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id i7so5574267qti.6
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Nov 2020 02:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=GQCG9MzlHorFPk8ZIEJfuRbc9m32BwdS4ydxRR3Npxg=;
        b=RAiFoCUj9sOzjOypWB1vlovKfjMi6wmLFHeT8Jb8NCVNStWdmJM5JnDfR4CwpFgL93
         cqZOlL8DGljRqS1umWesmzES/U+UAZKFJkC2xv4JWIaHzZtUNohcZTIG5vqs6XEP5nvU
         71wJrG+2+TFZaQmcFtW7AFYfjrL07RruWFtIS76JFylUxu85GD3syVitTjwU8EfCluEL
         2WbWvl/LxLTlTi6S/XGUzmw7/N3hROiuIZlC4HfFNaDS41TASpiek6xgD+q+eQSs+aYF
         IEjjRTVXg6CrWm89JyorzZlOlzrlju7cUKzE5XkfQSiL0HzIKP8eT3uzAiku4SVpJddq
         AN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=GQCG9MzlHorFPk8ZIEJfuRbc9m32BwdS4ydxRR3Npxg=;
        b=WzcbTfUw03+nDXjpZSPIVltV6vkajS9wG7U+DWUn5WZxyxh8bNxSTFt1kllKwC1u3p
         jGQ/q7+OohrkEYSgv6sGCemlEXsq+rOA7jHjyhLYscIJ/GXyJ5nM4sHSalo8ge07XKdq
         Vbcn+htswyscBpYA2MAVJ/bn4Oo4BcoewKcUVGS9S1K70pOtyASFaTHwDhVc1SRXPqLY
         3hQgKeG2agIEaWY+E1mA0cg8iDRluNLpdKoA4CWxSzjnHKNi2f3TgHwAMEwyOF5PBCpL
         RR0NemrDn8r++snTGTLTHx2Wr0WQCGlp99quAfsiHBRJBz070sxygqwxSJrzrWDgyojA
         w6Fg==
X-Gm-Message-State: AOAM530QmBLfCsz+UPFNp2BY45vmpXD7wY64qiLRuDsFm+rwmPK9VF8k
        ydnKyRLSNIxIt903vY76KlwOylceRQGhWqhNb7o=
X-Google-Smtp-Source: ABdhPJw0dpnE3QIwZxseJHz13UxMPWBFbVyCesw9FDCr8uyj8uUJUDNjzn8qr4c2fsQGN54KMa6YQdoVvZQYUAEQw7g=
X-Received: by 2002:ac8:5942:: with SMTP id 2mr12452043qtz.183.1604916423933;
 Mon, 09 Nov 2020 02:07:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604697895.git.josef@toxicpanda.com> <74fe63263c2d9e7ffd6c0cef2a2f9ce893989638.1604697895.git.josef@toxicpanda.com>
In-Reply-To: <74fe63263c2d9e7ffd6c0cef2a2f9ce893989638.1604697895.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 9 Nov 2020 10:06:52 +0000
Message-ID: <CAL3q7H6eWuPQ=t2BVJYQPGYmYm3ZJZgPiOFwznwU5KetLMaKyw@mail.gmail.com>
Subject: Re: [PATCH 1/8] btrfs: cleanup the locking in btrfs_next_old_leaf
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 6, 2020 at 9:29 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We are carrying around this next_rw_lock from when we would do spinning
> vs blocking read locks.  Now that we have the rwsem locking we can
> simply use the read lock flag unconditionally and the read lock helpers.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ctree.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index d2d5854d51a7..3a01e6e048c0 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -5327,7 +5327,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, st=
ruct btrfs_path *path,
>         struct btrfs_key key;
>         u32 nritems;
>         int ret;
> -       int next_rw_lock =3D 0;
>
>         nritems =3D btrfs_header_nritems(path->nodes[0]);
>         if (nritems =3D=3D 0)
> @@ -5337,7 +5336,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, st=
ruct btrfs_path *path,
>  again:
>         level =3D 1;
>         next =3D NULL;
> -       next_rw_lock =3D 0;
>         btrfs_release_path(path);
>
>         path->keep_locks =3D 1;
> @@ -5401,12 +5399,11 @@ int btrfs_next_old_leaf(struct btrfs_root *root, =
struct btrfs_path *path,
>                 }
>
>                 if (next) {
> -                       btrfs_tree_unlock_rw(next, next_rw_lock);
> +                       btrfs_tree_read_unlock(next);
>                         free_extent_buffer(next);
>                 }
>
>                 next =3D c;
> -               next_rw_lock =3D path->locks[level];
>                 ret =3D read_block_for_search(root, path, &next, level,
>                                             slot, &key);
>                 if (ret =3D=3D -EAGAIN)
> @@ -5437,7 +5434,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, st=
ruct btrfs_path *path,
>                                                        BTRFS_NESTING_RIGH=
T,
>                                                        path->recurse);
>                         }
> -                       next_rw_lock =3D BTRFS_READ_LOCK;
>                 }
>                 break;
>         }
> @@ -5446,13 +5442,13 @@ int btrfs_next_old_leaf(struct btrfs_root *root, =
struct btrfs_path *path,
>                 level--;
>                 c =3D path->nodes[level];
>                 if (path->locks[level])
> -                       btrfs_tree_unlock_rw(c, path->locks[level]);
> +                       btrfs_tree_read_unlock(c);
>
>                 free_extent_buffer(c);
>                 path->nodes[level] =3D next;
>                 path->slots[level] =3D 0;
>                 if (!path->skip_locking)
> -                       path->locks[level] =3D next_rw_lock;
> +                       path->locks[level] =3D BTRFS_READ_LOCK;
>                 if (!level)
>                         break;
>
> @@ -5466,11 +5462,9 @@ int btrfs_next_old_leaf(struct btrfs_root *root, s=
truct btrfs_path *path,
>                         goto done;
>                 }
>
> -               if (!path->skip_locking) {
> +               if (!path->skip_locking)
>                         __btrfs_tree_read_lock(next, BTRFS_NESTING_RIGHT,
>                                                path->recurse);
> -                       next_rw_lock =3D BTRFS_READ_LOCK;
> -               }
>         }
>         ret =3D 0;
>  done:
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
