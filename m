Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F4F2A95D7
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgKFLy6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgKFLy6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:54:58 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C32C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:54:58 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id p12so520037qtp.7
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=SSPt9k4aY4j0TILU/AKOopJRGNx6dOG74A1CLihUt48=;
        b=RJtIst6bdegkQGglxuQa0CvzWc+tIDmZS3xncLx5Pl95qead4ZQzexo7YM3uO7r724
         rMj1VsKL6PWpzLaQXklNiSabdAioN2m+H7ihWTePxmprsyCP9PP3gwpLCLUlcENvwMMV
         VKKjOwJyktDaMHR29ievvoRjTbOE+b3GCErq/zdPg7ew2fiVbfPi6Q1C/OhNKUF8FUSQ
         Jgv83j89G9zgEi9DQ3nb2iLPvUPxylcVbgVYDIexhifgzTtBPOoWROtt+I4u3yYzb/TO
         +PgGX3AZFDSHSFGV5ai2E4wNEQnAzHo3Q2bUgGMC9eA1P+JVdjiUzTuLiQHbqV1cfb95
         OzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=SSPt9k4aY4j0TILU/AKOopJRGNx6dOG74A1CLihUt48=;
        b=FIhTwB0uxgGJcyT1hHuAG6U9BB9f2+vG9SeJdcO8GfH6oSy+UfQ21e4nLTlfh1qaFX
         5a2pC50Ur68rX/jTq8is7jtPNF3u5EjgroZnPEOAvkko+jJNgHXGvy9IBZLJHB8LQRe7
         kl/O063FUeLtgJ2IFGEk7RvHhtJpFTY58zl31Ok/+Q06kml6k2yq58SQu4hNC53Q4Y3p
         EcKZKN08dZ9A6fXEF+U7jZ7opHnAjuyBZy8wZPSt8i5Jdeiwsp9YmTGTUkLvBkGOwpVd
         goKlLh75BK4v3DKlq+kLpsfd0qRuFa868Q8MNgGeImMjcjktn2j5HyKZ6XhtN7skgACK
         PnWg==
X-Gm-Message-State: AOAM533T+2Vg4Pq+EphrauzRfiVJziHMUiGpMHvSpjTESh2BjJ+tARDU
        4qNRdlJsYgvYfkMzrmMT7DZm4UTK9/dRIi/rsoLhOKACQlw=
X-Google-Smtp-Source: ABdhPJz5OTrH74CbXT368GIAsTeoi9zxYEE90cJUp3o43nnwQTg2OmtbIoOsACaE2s7EnHtyNUSGZhcLC8RXUwhqeyM=
X-Received: by 2002:aed:2321:: with SMTP id h30mr1001637qtc.213.1604663697844;
 Fri, 06 Nov 2020 03:54:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <5180b1583f4a9db07d8374026818d6a557f94768.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <5180b1583f4a9db07d8374026818d6a557f94768.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:54:46 +0000
Message-ID: <CAL3q7H5ChGfGd27+vaqkBR6YBXN9jj1AWup4G+iBzMfs2Vu8OQ@mail.gmail.com>
Subject: Re: [PATCH 09/14] btrfs: use btrfs_read_node_slot in qgroup_trace_new_subtree_blocks
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 5, 2020 at 3:47 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We're open-coding btrfs_read_node_slot() here, replace with the helper.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I couldn't get anymore the lockdep splat I reported before (after
applying the whole patchset of course), it used to happen very often
with btrfs/033.

Looks good, thanks.

> ---
>  fs/btrfs/qgroup.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 21e42d8ec78e..8d112ff7b5ae 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -2002,10 +2002,8 @@ static int qgroup_trace_new_subtree_blocks(struct =
btrfs_trans_handle* trans,
>
>         /* Read the tree block if needed */
>         if (dst_path->nodes[cur_level] =3D=3D NULL) {
> -               struct btrfs_key first_key;
> -               int parent_slot;
>                 u64 child_gen;
> -               u64 child_bytenr;
> +               int parent_slot;
>
>                 /*
>                  * dst_path->nodes[root_level] must be initialized before
> @@ -2024,23 +2022,16 @@ static int qgroup_trace_new_subtree_blocks(struct=
 btrfs_trans_handle* trans,
>                   */
>                 eb =3D dst_path->nodes[cur_level + 1];
>                 parent_slot =3D dst_path->slots[cur_level + 1];
> -               child_bytenr =3D btrfs_node_blockptr(eb, parent_slot);
>                 child_gen =3D btrfs_node_ptr_generation(eb, parent_slot);
> -               btrfs_node_key_to_cpu(eb, &first_key, parent_slot);
>
>                 /* This node is old, no need to trace */
>                 if (child_gen < last_snapshot)
>                         goto out;
>
> -               eb =3D read_tree_block(fs_info, child_bytenr, child_gen,
> -                                    cur_level, &first_key);
> +               eb =3D btrfs_read_node_slot(eb, parent_slot);
>                 if (IS_ERR(eb)) {
>                         ret =3D PTR_ERR(eb);
>                         goto out;
> -               } else if (!extent_buffer_uptodate(eb)) {
> -                       free_extent_buffer(eb);
> -                       ret =3D -EIO;
> -                       goto out;
>                 }
>
>                 dst_path->nodes[cur_level] =3D eb;
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
