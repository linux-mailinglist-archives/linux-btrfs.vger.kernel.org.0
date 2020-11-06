Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5D2A95C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgKFLxB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgKFLxA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:53:00 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CBFC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:53:00 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id h12so510918qtc.9
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=M8INxRlGb/ZV3yo6c1+WRn/G6N5Ji3E3wti0mYv4Sqc=;
        b=ZEyLVYuyxc2qQ4pN23zRzY4Aoi2P0GwZeyyIQjczvx/U+nN/zBxScoe8bPBFAhqbwG
         MpwlZnf44ko9swhM7/3MNkVjQHziAu7EL5iQMgcCGSS5aZBYudaz1f60hHlVVPNxyt4L
         39VAw0X7xk9hJrdq03PMbbTUihYFNsYQGQDy1ehA42grEhwh1BqgJgOEJbwWqb/9WNPJ
         Mz+d9Bq+iff9/23t6xp5NYEcAmY7WYDzsEx7rQqebnVRL9JAn0S72Io9UPFhh56zSuYR
         t2dpMLTQYrnk3/NscTYO7Uyo3UJTOC9oKMjMoyTXpjmtMM8Q85Tu0Z9OD4fok6wDFTKD
         0rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=M8INxRlGb/ZV3yo6c1+WRn/G6N5Ji3E3wti0mYv4Sqc=;
        b=aT548D3RCr7M8Q3KQ8eqwHjHvPblItg2RiVwYyK4T7hkOVGImHOMomGZparX5wiTfZ
         87P6Xww4kPAjRJrr0F2eIZzsdmC6io9Cuzh8IZ9eTv5LIOksmShi4Kpod5K4F47njvb9
         sN/zdT9Jk9nGGh1Sjx4vJA5s4/7pv4sZUh/9W3FyKpmEwLQyehrvCtYs9NXtcCjYa2Mc
         D8a1XmwpzTLhGhcSH4kNEsa2hr/WdBVDJ76bMkVCocjdJFyDXAAMXfFa1CwQwjJJ0W/e
         kl5XQG5jH/07NxE+pv4RqZOr6Zk8zOaE2FunnCw6y8OMg+RSE8SdQE4idvSGbiP2Sjjp
         X1cQ==
X-Gm-Message-State: AOAM532FP6Bj4/TrSvy1VlUziN5dsDNCvpWNjIeTSxYTQRpjkrJ294Ab
        tZdsYK/YY2h4qnF40dsCBHzAr+Oup2yqYIImnYjLfEQc6C8=
X-Google-Smtp-Source: ABdhPJy1j70QSnLbs8m5xmoRlYnIghFUXbOSn9ZDuJpJjIhgN/Usk12ouuZitmAxSLIVoxePQ65f+PhyTEVzGExsv04=
X-Received: by 2002:aed:30e2:: with SMTP id 89mr1081933qtf.259.1604663579933;
 Fri, 06 Nov 2020 03:52:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <673095c14fc04a76cb5b189505d23bf33003b5ce.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <673095c14fc04a76cb5b189505d23bf33003b5ce.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:52:48 +0000
Message-ID: <CAL3q7H5ZZMsuEHWuzocmeG4-VGecViB+uY3ZdAzCj=mJkbPbgg@mail.gmail.com>
Subject: Re: [PATCH 05/14] btrfs: use btrfs_read_node_slot in do_relocation
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 5, 2020 at 3:47 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We're open coding btrfs_read_node_slot in do_relocation, replace this
> with the proper helper.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I couldn't get anymore the lockdep splat I reported before (after
applying the whole patchset of course), it used to happen very often
with btrfs/033.

Looks good, thanks.

> ---
>  fs/btrfs/relocation.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d327b5b4f1cd..4d5cb593b674 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2191,7 +2191,6 @@ static int do_relocation(struct btrfs_trans_handle =
*trans,
>                          struct btrfs_key *key,
>                          struct btrfs_path *path, int lowest)
>  {
> -       struct btrfs_fs_info *fs_info =3D rc->extent_root->fs_info;
>         struct btrfs_backref_node *upper;
>         struct btrfs_backref_edge *edge;
>         struct btrfs_backref_edge *edges[BTRFS_MAX_LEVEL - 1];
> @@ -2199,7 +2198,6 @@ static int do_relocation(struct btrfs_trans_handle =
*trans,
>         struct extent_buffer *eb;
>         u32 blocksize;
>         u64 bytenr;
> -       u64 generation;
>         int slot;
>         int ret;
>         int err =3D 0;
> @@ -2209,7 +2207,6 @@ static int do_relocation(struct btrfs_trans_handle =
*trans,
>         path->lowest_level =3D node->level + 1;
>         rc->backref_cache.path[node->level] =3D node;
>         list_for_each_entry(edge, &node->upper, list[LOWER]) {
> -               struct btrfs_key first_key;
>                 struct btrfs_ref ref =3D { 0 };
>
>                 cond_resched();
> @@ -2282,17 +2279,10 @@ static int do_relocation(struct btrfs_trans_handl=
e *trans,
>                 }
>
>                 blocksize =3D root->fs_info->nodesize;
> -               generation =3D btrfs_node_ptr_generation(upper->eb, slot)=
;
> -               btrfs_node_key_to_cpu(upper->eb, &first_key, slot);
> -               eb =3D read_tree_block(fs_info, bytenr, generation,
> -                                    upper->level - 1, &first_key);
> +               eb =3D btrfs_read_node_slot(upper->eb, slot);
>                 if (IS_ERR(eb)) {
>                         err =3D PTR_ERR(eb);
>                         goto next;
> -               } else if (!extent_buffer_uptodate(eb)) {
> -                       free_extent_buffer(eb);
> -                       err =3D -EIO;
> -                       goto next;
>                 }
>                 btrfs_tree_lock(eb);
>
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
