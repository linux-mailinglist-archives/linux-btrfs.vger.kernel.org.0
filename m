Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B453A7DCADF
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 11:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbjJaKbS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 06:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbjJaKbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 06:31:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C93B10B
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 03:31:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154E0C433C8
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698748267;
        bh=LPj1M3FHhLoMvbheFim4kAJXst7ayeqKElo0X/lyabw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iL0bAU8+tA1FuC0QgkAnjfj3PEB1dLOByNye7TohA6kp+1dpZ5f8AQhjTvKJWrZ88
         4WD7DpsTrF0bCORInu5ynZm5BX4uRGYlVdG4jm1B45hBgfaoSp6q+WibWU9prXtVyX
         6+ntYuKIGBFxwu7yIpnovPC4bY/uzIUjUVotNcgarqlHIycsE58ZgE52biCgKd4bnv
         iaZ9XLZt3FvEOzVlKTRRTgVjo7MAuVbddh4ZppQSvNtDShTAcKOvhuPTBBkHL5TV/x
         NHBGCLutpbbK/F8Y73d0DBrspeqvyPDG5Z+USTmDG2Z8YL27VRkAD8Wv/9mYVfoeE0
         +8vHjUMBfUA3g==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso2321883a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 03:31:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YwKwv97jQkzZnBgMbCcAqI6FiRcFhR5zYhPHL8qYG1dfbeap9Ti
        NYZdk0RhcUUZAmXqM5H297BsVuHUA/mgcHOOfD0=
X-Google-Smtp-Source: AGHT+IFyaHZf7cylNFlqYgwNzW6Y3uHLqhOGwu12K2h/BEZAtHe9eDxYnIW0UU6KkpQHdP7y3XPqLr9/yWmfLdMzsH8=
X-Received: by 2002:a17:907:2da4:b0:9b2:7b89:8199 with SMTP id
 gt36-20020a1709072da400b009b27b898199mr11391947ejc.53.1698748265487; Tue, 31
 Oct 2023 03:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <e81eab657c200a78dd43747fb28e942289082f98.1698698978.git.wqu@suse.com>
In-Reply-To: <e81eab657c200a78dd43747fb28e942289082f98.1698698978.git.wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 31 Oct 2023 10:30:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5i_t0EmsSCE7vafBk7n+D2BM0XP5UpN4BJsboBMLiSZQ@mail.gmail.com>
Message-ID: <CAL3q7H5i_t0EmsSCE7vafBk7n+D2BM0XP5UpN4BJsboBMLiSZQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: do not utilize goto to implement delayed inode
 ref deletion
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 30, 2023 at 9:07=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [PROBLEM]
> The function __btrfs_update_delayed_inode() is doing something not
> meeting the code standard of today:
>
>         path->slots[0]++
>         if (path->slots[0] >=3D btrfs_header_nritems(leaf))
>                 goto search;
> again:
>         if (!is_the_target_inode_ref())
>                 goto out;
>         ret =3D btrfs_delete_item();
>         /* Some cleanup. */
>         return ret;
>
> search:
>         ret =3D search_for_the_last_inode_ref();
>         goto again;
>
> With the tag named "again", it's pretty common to think it's a loop, but
> the truth is, we only need to do the search once, to locate the last
> (also the first, since there should only be one INODE_REF or
> INODE_EXTREF now) ref of the inode.
>
> [FIX]
> Instead of the weird jumps, just do them in a stream-lined fashion.
> This removes those weird tags, and add extra comments on why we can do
> the different searches.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> CHANGELOG
> v2:
> - Move the leaf assignment into the if branch where we do the search
>   This is where the leaf get updated, no need to update @leaf
>   unconditionally which can be confusing.
>
> This is just a cleanup while I was investigating a weird bug inside the
> same function.
>
> The bug is, the mentioned function returned -ENOENT and caused
> transaction abort.
> The weird part is, when that happened (btrfs_lookup_inode() failed) dump
> tree (only one case though) showed there is indeed no INODE_ITEM, but we
> still have the INODE_REF and even one EXTENT_DATA.
>
> Any clue would be very appreciated.
> ---
>  fs/btrfs/delayed-inode.c | 46 ++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index c640f87038a6..0f8fa9751b5d 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1036,14 +1036,34 @@ static int __btrfs_update_delayed_inode(struct bt=
rfs_trans_handle *trans,
>         if (!test_bit(BTRFS_DELAYED_NODE_DEL_IREF, &node->flags))
>                 goto out;
>
> -       path->slots[0]++;
> -       if (path->slots[0] >=3D btrfs_header_nritems(leaf))
> -               goto search;
> -again:
> +       /*
> +        * Now we're going to delete the INODE_REF/EXTREF, which should b=
e
> +        * the only one ref left.
> +        * Check if the next item is an INODE_REF/EXTREF.
> +        *
> +        * But if we're the last item already, release and search for the=
 last
> +        * INODE_REF/EXTREF
> +        */
> +       if (path->slots[0] + 1 >=3D btrfs_header_nritems(leaf)) {
> +               key.objectid =3D node->inode_id;
> +               key.type =3D BTRFS_INODE_EXTREF_KEY;
> +               key.offset =3D (u64)-1;
> +
> +               btrfs_release_path(path);
> +               ret =3D btrfs_search_slot(trans, root, &key, path, -1, 1)=
;
> +               if (ret < 0)
> +                       goto err_out;
> +               ASSERT(ret > 0);
> +               ASSERT(path->slots[0] > 0);
> +               ret =3D 0;
> +               path->slots[0]--;
> +               leaf =3D path->nodes[0];
> +       } else {
> +               path->slots[0]++;
> +       }
>         btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>         if (key.objectid !=3D node->inode_id)
>                 goto out;
> -
>         if (key.type !=3D BTRFS_INODE_REF_KEY &&
>             key.type !=3D BTRFS_INODE_EXTREF_KEY)
>                 goto out;
> @@ -1070,22 +1090,6 @@ static int __btrfs_update_delayed_inode(struct btr=
fs_trans_handle *trans,
>                 btrfs_abort_transaction(trans, ret);
>
>         return ret;
> -
> -search:
> -       btrfs_release_path(path);
> -
> -       key.type =3D BTRFS_INODE_EXTREF_KEY;
> -       key.offset =3D -1;
> -
> -       ret =3D btrfs_search_slot(trans, root, &key, path, -1, 1);
> -       if (ret < 0)
> -               goto err_out;
> -       ASSERT(ret);
> -
> -       ret =3D 0;
> -       leaf =3D path->nodes[0];
> -       path->slots[0]--;
> -       goto again;
>  }
>
>  static inline int btrfs_update_delayed_inode(struct btrfs_trans_handle *=
trans,
> --
> 2.42.0
>
