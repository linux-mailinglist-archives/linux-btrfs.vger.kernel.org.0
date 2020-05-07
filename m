Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE591C8708
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 12:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgEGKk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 06:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726029AbgEGKk4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 06:40:56 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DB7C061A10
        for <linux-btrfs@vger.kernel.org>; Thu,  7 May 2020 03:40:56 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id h30so3039796vsr.5
        for <linux-btrfs@vger.kernel.org>; Thu, 07 May 2020 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=cgP/X43HQpfE6oHSMUzqOkhqj2QoazbFw4zC8klZr8M=;
        b=P/fA5beo81VetjpZbe1nTQS6eBrfPJ+iMqE7VEH0n/httlYINjEkJLZpsG5QHL5aPl
         g5d04kfawQgdFI/Syi0fSxbdTd4rTiTM2fE+4PEKNZYjFpJ/RD11VXjETjoLQE0BVHw7
         nuVOQhTaOeRjI/NNbQpoPSKkmUxl3NgkeIfu7XdfG+Zn061WQYWtHN9LsXBdtdFvRBnZ
         AfGnS78C0j3oRpKPD8P/i7Df1Ew4q0oqnctQcRRmVZX/SKWZhDki5lbeMXqihdNH0jSs
         0WVKrgKl5Bx5DivwMuWFjR/CHBjLiYK1u2VmocCtOwtlCZWTit6n2L5gjh2OPlzPDSzd
         aQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=cgP/X43HQpfE6oHSMUzqOkhqj2QoazbFw4zC8klZr8M=;
        b=NF/Vlp73GOnznFTwC/R6kFt1djNJRQucUZfINvf0nM9dTjf8ZKWWPW1duNNNUgw25D
         MYpJwuARFZiI2s6cGNX7ariPVvlliWjChBVG5oca7ptDQeM6pDImuyv5n0Veh0NXAvdE
         aX6nVwb6dxsCT8OWXW+1TNjqO/cUJx7RK3BBFMzWiReytrYSAxIsC3os6F/+CgrasAu7
         gyfQ2tTeLrgZVk7QYFXkXg1mnyCyFxQX0mC3PaQbvGEPEssSLw+6EKSfLWQFOKsvrgSR
         q2k4OT9h8xoz8KFtFNWhplWW2XXFUIYKo6W7d743UCoWSQLznLsESqcOom6jeWDcKjqa
         UHag==
X-Gm-Message-State: AGi0PuYpuSa3HEFyc/p8NnPedavYD27O/2GhP25iob5w2mCcejq2u+cU
        qftGCEo/SynBiKZ/i43SetIBWjpH49PovFitEN+7f/63
X-Google-Smtp-Source: APiQypK1QOF0uOMrFrlw0b+0WLZNTSP3oWvUX6T5m06JGtKdtVe1krWNjXGCesun3Nj7jOcVN8qEuvd7M8gW9D2G2wI=
X-Received: by 2002:a67:407:: with SMTP id 7mr11291302vse.95.1588848054523;
 Thu, 07 May 2020 03:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200507025440.6619-1-robbieko@synology.com>
In-Reply-To: <20200507025440.6619-1-robbieko@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 7 May 2020 11:40:43 +0100
Message-ID: <CAL3q7H4ebPEJy2jB3jYkzzx+U7SeN_UwoSQPc8hYn2WPK1bHcQ@mail.gmail.com>
Subject: Re: [PATCH v2] Btrfs : improve the speed of compare orphan item and
 dead roots with tree root when mount
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 7, 2020 at 4:27 AM robbieko <robbieko@synology.com> wrote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> When mounting, we handle deleted subvol and orphan items.
> First, find add orphan roots, then add them to fs_root radix tree.
> Second, in tree-root, process each orphan item, skip if it is dead root.
>
> The original algorithm is based on the list of dead_roots,
> one by one to visit and check whether the objectid is consistent,
> the time complexity is O (n ^ 2).
> When processing 50000 deleted subvols, it takes about 120s.
>
> Because btrfs_find_orphan_roots has already ran before us,
> and added deleted subvol to fs_roots radix tree.
>
> The fs root will only be removed from the fs_roots radix tree
> after the cleaner is processed, and the cleaner will only start
> execution after the mount is complete.
>
> btrfs_orphan_cleanup can be called during the whole filesystem mount
> lifetime, but only "tree root" will be used in this section of code,
> and only mount time will be brought into tree root.
>
> So we can quickly check whether the orphan item is dead root
> through the fs_roots radix tree.
>
> Signed-off-by: Robbie Ko <robbieko@synology.com>

"Btrfs : improve the speed of compare orphan item and dead roots with
tree root when mount"

That's a really long subject and confusing - compare orphan item? All
we do is check whether a root is dead or not.
So I would suggest some shorter and clear:

"Btrfs: speedup dead root detection during orphan cleanup"

Other than that, looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
> Changes in v2:
> - update changelog
> ---
>  fs/btrfs/inode.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 320d1062068d..1becf5c63e5a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3000,18 +3000,16 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
>                          * orphan must not get deleted.
>                          * find_dead_roots already ran before us, so if t=
his
>                          * is a snapshot deletion, we should find the roo=
t
> -                        * in the dead_roots list
> +                        * in the fs_roots radix tree.
>                          */
> -                       spin_lock(&fs_info->trans_lock);
> -                       list_for_each_entry(dead_root, &fs_info->dead_roo=
ts,
> -                                           root_list) {
> -                               if (dead_root->root_key.objectid =3D=3D
> -                                   found_key.objectid) {
> -                                       is_dead_root =3D 1;
> -                                       break;
> -                               }
> -                       }
> -                       spin_unlock(&fs_info->trans_lock);
> +
> +                       spin_lock(&fs_info->fs_roots_radix_lock);
> +                       dead_root =3D radix_tree_lookup(&fs_info->fs_root=
s_radix,
> +                                                        (unsigned long)f=
ound_key.objectid);
> +                       if (dead_root && btrfs_root_refs(&dead_root->root=
_item) =3D=3D 0)
> +                               is_dead_root =3D 1;
> +                       spin_unlock(&fs_info->fs_roots_radix_lock);
> +
>                         if (is_dead_root) {
>                                 /* prevent this orphan from being found a=
gain */
>                                 key.offset =3D found_key.objectid - 1;
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
