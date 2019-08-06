Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EAD82F84
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 12:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbfHFKKM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 06:10:12 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36886 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFKKM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 06:10:12 -0400
Received: by mail-vs1-f67.google.com with SMTP id v6so57983074vsq.4
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 03:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Ouq6X5xMncbAGp/Q47fk46jrPYRSiV8MS9eV4DGO6jk=;
        b=pC2VaXtZ4AX3A0bKLE/jNmUfz7Oq5ZOdAml32DEN5cWIudKsc4PklJEE0ZVQ37NamB
         sTbF5ZEqZzTJXhR+eI4gXqoX3c6leGPEs/pJbfHXqkgqpv79rFW9OgYymAU6F7acOQVs
         BEcIqojYbs/6nToxWI99mRaqRYcdDO9AAdzwoTxJmnFjxBI8msyvwYJuIrIGO7EdVl//
         o55reMkdAmG0sQW3VQKlN5sW0JiEonm69WoG5EP4vPz09bmMr4JI+KNhrHHdZU+l467F
         UMik1x/Lnq+nIBOy6RDh9ip6zsDL7cJIFkBQw46yHVUCpBHKIaIXvusaKpAlRuy4oHyz
         woSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Ouq6X5xMncbAGp/Q47fk46jrPYRSiV8MS9eV4DGO6jk=;
        b=uO0cy8wYN2mnav8WFAF8GgMeq9P/jKLj1nvvayqQQUP7X35IhJ7k7FeEFGUDxQ36/P
         uBi3uVugE8X/8ZE7TTZ1jU9rutIaVyGWwfxZ+0mUseGroTQpzumt0HwI71pX7D/SPzwV
         0mWRzqAF4iFzUQwgL7ADGVn7jvzIgPo8Dd40VPK+tSzKEAaD8KZZTSmknn7tpSZJh0fA
         EiPOS2BPSeKgIWmcBMILipm2dCjrxxfK9yVntN7My6vh638ehpHo8v5VyvxC7eM2kQ8A
         hKwsa221TSNM3z+WnarH000wJyq4I5dUSFQQw4sQNNunFED+NT9u+YL35dE9UqW4pU3U
         be3Q==
X-Gm-Message-State: APjAAAU90GWMPSEkNZCLV8ydHa5we3DjpnfLAPUHM0/rm/P9+4Vda8HU
        AUKn3SgSclVfuQg9OUpjb5gWAiylIBCTzLZGvGDWhtwI
X-Google-Smtp-Source: APXvYqz/9dEI+mFr68xoPg3vGj52adOA+oZFrXdpDSHMYrBuTMMS/oCho8Inoz0KeflAPCqFt7CyKB1j9Gh6t1hDnGQ=
X-Received: by 2002:a67:bc15:: with SMTP id t21mr1463747vsn.99.1565086210541;
 Tue, 06 Aug 2019 03:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190805144708.5432-1-nborisov@suse.com> <20190805144708.5432-3-nborisov@suse.com>
In-Reply-To: <20190805144708.5432-3-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 6 Aug 2019 11:09:59 +0100
Message-ID: <CAL3q7H7VnX7ez5VeYbKFk=W1s_1AeS0hYpmVPvZ4af4NJerjUw@mail.gmail.com>
Subject: Re: [PATCH 2/6] btrfs: Improve comments around nocow path
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 5, 2019 at 3:48 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
> run_delalloc_nocow contains numerous, somewhat subtle, checks when
> figuring out whether a particular extent should be CoW'ed or not. This
> patch explicitly states the assumptions those checks verify. As a
> result also document 2 of the more subtle checks in check_committed_ref
> as well.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/extent-tree.c |  3 +++
>  fs/btrfs/inode.c       | 50 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 163db9a560e2..1fc795fda4c2 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2868,16 +2868,19 @@ static noinline int check_committed_ref(struct bt=
rfs_root *root,
>         item_size =3D btrfs_item_size_nr(leaf, path->slots[0]);
>         ei =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_i=
tem);
>
> +       /* If extent item has more than 1 inline ref then it has referenc=
es */
>         if (item_size !=3D sizeof(*ei) +
>             btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY))
>                 goto out;
>
> +       /* If extent created before last snapshot =3D> it's definitely re=
ferenced */

Extents are always referenced, otherwise we have a corruption, so:
referenced -> shared

>         if (btrfs_extent_generation(leaf, ei) <=3D
>             btrfs_root_last_snapshot(&root->root_item))
>                 goto out;
>
>         iref =3D (struct btrfs_extent_inline_ref *)(ei + 1);
>
> +       /* If this extent has SHARED_DATA_REF then it's referenced */

referenced -> shared

>         type =3D btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_T=
YPE_DATA);
>         if (type !=3D BTRFS_EXTENT_DATA_REF_KEY)
>                 goto out;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4393f986e5ad..aa5e017e31ab 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1345,6 +1345,11 @@ static noinline int run_delalloc_nocow(struct inod=
e *inode,
>                                                cur_offset, 0);
>                 if (ret < 0)
>                         goto error;
> +
> +               /*
> +                * If nothing found and this is the initial search get th=
e last
> +                * extent of this file

Last extent?
No, we want to check if the previous slot points to an extent item,
and if so, use it. That does not mean it's the last extent in the
file, it can be any in the middle or in the beginning.
This is hit when there's no extent that starts at the given search
offset, so we end up in the next one and we have to go 1 slot behind
because the previous one contains the search offset.

> +                */
>                 if (ret > 0 && path->slots[0] > 0 && check_prev) {
>                         leaf =3D path->nodes[0];
>                         btrfs_item_key_to_cpu(leaf, &found_key,
> @@ -1353,9 +1358,9 @@ static noinline int run_delalloc_nocow(struct inode=
 *inode,
>                             found_key.type =3D=3D BTRFS_EXTENT_DATA_KEY)
>                                 path->slots[0]--;
>                 }
> -               /* Check previous only on first pass */

Previous patch added this comment, this one removes it. Why?

>                 check_prev =3D false;
>  next_slot:
> +               /* If we are beyond end of leaf break */

No, we don't break. We iterate to the next leaf. We break only if
there isn't a next leaf (we are at the last one).

>                 leaf =3D path->nodes[0];
>                 if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
>                         ret =3D btrfs_next_leaf(root, path);
> @@ -1371,23 +1376,39 @@ static noinline int run_delalloc_nocow(struct ino=
de *inode,
>
>                 btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>
> +               /* Didn't find anything for our INO */
>                 if (found_key.objectid > ino)
>                         break;
> +               /*
> +                * Found a different inode or no extents for our file,
> +                * goto next slot

No. This does not mean that there are no extents for the file. If
there weren't any, we would break instead of iterating to the next
slot.
One example described at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D1d512cb77bdbda80f0dd0620a3b260d697fd581d

> +                */
>                 if (WARN_ON_ONCE(found_key.objectid < ino) ||
>                     found_key.type < BTRFS_EXTENT_DATA_KEY) {
>                         path->slots[0]++;
>                         goto next_slot;
>                 }
> +
> +               /* Found key is not EXTENT_DATA_KEY or starts after req r=
ange */
>                 if (found_key.type > BTRFS_EXTENT_DATA_KEY ||
>                     found_key.offset > end)
>                         break;
>
> +               /*
> +                * If the found extent starts after requested offset, the=
n
> +                * adjust extent_end to be right before this extent begin=
s
> +                */
>                 if (found_key.offset > cur_offset) {
>                         extent_end =3D found_key.offset;
>                         extent_type =3D 0;
>                         goto out_check;
>                 }
>
> +
> +               /*
> +                * Found extent which begins before our range and has the
> +                * potential to intersect it.
> +                */
>                 fi =3D btrfs_item_ptr(leaf, path->slots[0],
>                                     struct btrfs_file_extent_item);
>                 extent_type =3D btrfs_file_extent_type(leaf, fi);
> @@ -1401,19 +1422,28 @@ static noinline int run_delalloc_nocow(struct ino=
de *inode,
>                                 btrfs_file_extent_num_bytes(leaf, fi);
>                         disk_num_bytes =3D
>                                 btrfs_file_extent_disk_num_bytes(leaf, fi=
);
> +                       /*
> +                        * If extent we got ends before our range starts,
> +                        * skip to next extent
> +                        */
>                         if (extent_end <=3D start) {
>                                 path->slots[0]++;
>                                 goto next_slot;
>                         }
> +                       /* skip holes */
>                         if (disk_bytenr =3D=3D 0)
>                                 goto out_check;
> +                       /* skip compressed/encrypted/encoded extents */
>                         if (btrfs_file_extent_compression(leaf, fi) ||
>                             btrfs_file_extent_encryption(leaf, fi) ||
>                             btrfs_file_extent_other_encoding(leaf, fi))
>                                 goto out_check;
>                         /*
> -                        * Do the same check as in btrfs_cross_ref_exist =
but
> -                        * without the unnecessary search.
> +                        * If extent is created before the last volume's =
snapshot
> +                        * this implies the extent is shared, hence we ca=
n't do
> +                        * nocow. This is the same check as in
> +                        * btrfs_cross_ref_exist but without calling
> +                        * btrfs_search_slot.
>                          */
>                         if (!freespace_inode &&
>                             btrfs_file_extent_generation(leaf, fi) <=3D
> @@ -1421,6 +1451,7 @@ static noinline int run_delalloc_nocow(struct inode=
 *inode,
>                                 goto out_check;
>                         if (extent_type =3D=3D BTRFS_FILE_EXTENT_REG && !=
force)
>                                 goto out_check;
> +                       /* If extent RO, we must CoW it */
>                         if (btrfs_extent_readonly(fs_info, disk_bytenr))
>                                 goto out_check;
>                         ret =3D btrfs_cross_ref_exist(root, ino,
> @@ -1444,7 +1475,7 @@ static noinline int run_delalloc_nocow(struct inode=
 *inode,
>                         disk_bytenr +=3D cur_offset - found_key.offset;
>                         num_bytes =3D min(end + 1, extent_end) - cur_offs=
et;
>                         /*
> -                        * if there are pending snapshots for this root,
> +                        * If there are pending snapshots for this root,
>                          * we fall into common COW way.
>                          */
>                         if (!freespace_inode && atomic_read(&root->snapsh=
ot_force_cow))
> @@ -1481,12 +1512,17 @@ static noinline int run_delalloc_nocow(struct ino=
de *inode,
>                         BUG();
>                 }
>  out_check:
> +               /* Skip extents outside of our requested range */
>                 if (extent_end <=3D start) {
>                         path->slots[0]++;
>                         if (nocow)
>                                 btrfs_dec_nocow_writers(fs_info, disk_byt=
enr);
>                         goto next_slot;
>                 }
> +               /*
> +                * If nocow is false then record the beginning of the ran=
ge
> +                * that needs to be CoWed
> +                */
>                 if (!nocow) {
>                         if (cow_start =3D=3D (u64)-1)
>                                 cow_start =3D cur_offset;
> @@ -1498,6 +1534,12 @@ static noinline int run_delalloc_nocow(struct inod=
e *inode,
>                 }
>
>                 btrfs_release_path(path);
> +
> +               /*
> +                * CoW range from cow_start to found_key.offset - 1. As t=
he key
> +                * will contains the beginning of the first extent that c=
an be
> +                * NOCOW, following one which needs to be CoW'ed
> +                */
>                 if (cow_start !=3D (u64)-1) {
>                         ret =3D cow_file_range(inode, locked_page,
>                                              cow_start, found_key.offset =
- 1,
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
