Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB67DB908
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 12:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjJ3Led (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 07:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3Lec (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 07:34:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DAAC2
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 04:34:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00782C433CD
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698665670;
        bh=/13hD/bMEJcroPVdFC7AyyKXGhv/fkLj3lfLAMZjD3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RrQ0vjXpengGgYxU9Toern47hbmBHupZ/lacHtmCEP6OQ7ZlB9sw7KshG7B2NH8p/
         ddSSbB6+RUbgRblzsT/TONPvett+UPXCVe/NJnmN0JuJEeYKKQVPtE/mg4D1q+3OKr
         0SuQ9rcdecVbH4s3TNPXRlQIBrFno9Klxvqv0cAz6PIoO0XSkKwQ6nxQs041SPjnTG
         DAsrIbKWTgd0Yt/GHwSA34WasXjSdaND1q5LS10ZRV0aKMUFJdX793EqgvG4vgI1Q/
         FokQ0hruYL1atPGAe1jTJ1fThqTonqMzvy9JwKBuHmqCpMwL+hSGT0oD8QFU7f76Vs
         fOJKhnZTbm9OA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so651581466b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 04:34:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YwyMDCC6D+QqLros7mLTqt2hjDstOU40lPUxujoM48dZOoLeq0t
        kRcM/e3VAz4Dsuy8uwpEbWJxJaCFT+w4Wu1Uxl4=
X-Google-Smtp-Source: AGHT+IFA71HZh0bHlFDkCUVzjWzREpcEazZCSXtZmRY5o8efRNw71LRyUJjTQ9IkEPw+KhQIBa3YBj5smJhSClcCkGg=
X-Received: by 2002:a17:907:9384:b0:9d2:20ee:b1d0 with SMTP id
 cm4-20020a170907938400b009d220eeb1d0mr3132782ejc.53.1698665668457; Mon, 30
 Oct 2023 04:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <bb0503f5f3838fed86bdabf8d15ce71561a307fd.1698658344.git.wqu@suse.com>
In-Reply-To: <bb0503f5f3838fed86bdabf8d15ce71561a307fd.1698658344.git.wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 30 Oct 2023 11:33:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7VuCx1AYAWvTDBnrOUiyu3ob8P7jf-LOY-51ewOU7GCQ@mail.gmail.com>
Message-ID: <CAL3q7H7VuCx1AYAWvTDBnrOUiyu3ob8P7jf-LOY-51ewOU7GCQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not utilize goto to implement delayed inode ref deletion
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 30, 2023 at 9:36=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> ---
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
> index c640f87038a6..efbbe5e0ee6e 100644
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
> +       } else {
> +               path->slots[0]++;
> +       }
> +       leaf =3D path->nodes[0];

The assignment of the leaf should be inside the if statement, because
otherwise we're in the
same leaf, so it's confusing to see it reassigned here.

Otherwise it looks fine to me, thanks.

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
