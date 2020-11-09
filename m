Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0102AB4A0
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 11:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgKIKTa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 05:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIKTa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Nov 2020 05:19:30 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29000C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 02:19:30 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id p12so5584350qtp.7
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Nov 2020 02:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=8w/kAbGJPffJWQgBvljwMkjuG6sSv9yED2DWfCFWkV0=;
        b=sX1Jw6i3h/LADm2xQA/hlLRQXc2ojB9MZf1DoE6QxbSqQk72siCyqd1X+wpk4rAFY7
         Sn2F3I2bGFx6JPxHlhDFgAvcx/L4J7sEmWjfO9cnWtV+NdAceh6MmujjsydIijdHbXNm
         lZZgB3f/TuWqhrlVai1O5fw6jz1j6R5U1Rz1Mb/BQeYBakiWpIZdvx+MN7Gu9GUw9Kak
         UXGncpdCZ+ufo0aHB22kUa6DTOFixYoBSFMMXxhInRUmCT4AHYSGj76HHjG+6FZYGJLi
         jcfQKKMHxFOdV+/6O29hHitKhpp7zc0raoNGD5AGjxkf7gNCTkpcdnYATqAGVT7k3o2K
         qyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=8w/kAbGJPffJWQgBvljwMkjuG6sSv9yED2DWfCFWkV0=;
        b=r6ZWBP1wXf3UXI7P3V5459ZFdDhYWV6M/9paBK/B3/TwINFWmv/fiudgEaI+8eTfSO
         krkOLbdQI7E5cuZwyXMJJZPBplmVbvvKiV3gw2zyYjDkhU61yTvc94xvlI3LzUEhBXq1
         sdkEkA8MQ1grztTcZBbNq0BfWYGBI/GHkttkfy8Ox/WPK7ieFBurtqSx+dtgIHus8Sp4
         pkeabO6Lxj3/GtGYeJr0zH7Hgb7ibX0DyDExhNhYX/pqO8skLjD1jkMeJGUN5Jgin1XR
         SSN4IvciBVnT9pbbEuCnltXPox9tNCA+NWUdekYTBi06564IynFLbsh3AmGq8aqjeSNW
         yGWg==
X-Gm-Message-State: AOAM531fnf1BICHJ7xScYSA+cSoDHIqXafOXFqIlZ1c0LjsZGpKw/6uy
        42RGu4Uw1QP05iDldsbRRXFIAZPE5HH8YKPoXIE=
X-Google-Smtp-Source: ABdhPJx0D4d8hZz4kOsD/sEZsaSAFL26Js18vCCHdyTxLcyhhmsJBY0CMCIRbcBLJwhzQgvSnm+lT3CMey3dNB/g+6M=
X-Received: by 2002:ac8:832:: with SMTP id u47mr12535186qth.376.1604917169447;
 Mon, 09 Nov 2020 02:19:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604697895.git.josef@toxicpanda.com> <589c1ff532c06d75b9c7c74d03c48467aef3e394.1604697895.git.josef@toxicpanda.com>
In-Reply-To: <589c1ff532c06d75b9c7c74d03c48467aef3e394.1604697895.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 9 Nov 2020 10:19:18 +0000
Message-ID: <CAL3q7H7PA9HPGU4r5Tw+g=Xc824940=5qvmhNeuXOUF=ikPDKQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] btrfs: kill path->recurse
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 6, 2020 at 9:29 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> With my async free space cache loading patches we no longer have a user
> of path->recurse.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ctree.c | 4 ++--
>  fs/btrfs/ctree.h | 1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index dcd17f7167d1..cdd86ced917a 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2588,7 +2588,7 @@ static struct extent_buffer *btrfs_search_slot_get_=
root(struct btrfs_root *root,
>                  * We don't know the level of the root node until we actu=
ally
>                  * have it read locked
>                  */
> -               b =3D __btrfs_read_lock_root_node(root, p->recurse);
> +               b =3D __btrfs_read_lock_root_node(root, 0);
>                 level =3D btrfs_header_level(b);
>                 if (level > write_lock_level)
>                         goto out;
> @@ -2858,7 +2858,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>                                 p->locks[level] =3D BTRFS_WRITE_LOCK;
>                         } else {
>                                 __btrfs_tree_read_lock(b, BTRFS_NESTING_N=
ORMAL,
> -                                                      p->recurse);
> +                                                      0);
>                                 p->locks[level] =3D BTRFS_READ_LOCK;
>                         }
>                         p->nodes[level] =3D b;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index dc5d36aa4d28..4442e872d873 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -374,7 +374,6 @@ struct btrfs_path {
>         unsigned int search_commit_root:1;
>         unsigned int need_commit_sem:1;
>         unsigned int skip_release_on_error:1;
> -       unsigned int recurse:1;
>  };
>  #define BTRFS_MAX_EXTENT_ITEM_SIZE(r) ((BTRFS_LEAF_DATA_SIZE(r->fs_info)=
 >> 4) - \
>                                         sizeof(struct btrfs_item))
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
