Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4506A2A95CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgKFLxa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgKFLxa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:53:30 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AD7C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:53:30 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id t5so527154qtp.2
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=rcCnKJ8L68lRrHNSwc8ugkqtWHmr890Swawvbcqc0j8=;
        b=f1tCSvsQVwRVBnbyQzTw+9xVHBcr/wKIc5Vn1wiq1rxpsff/fClDMh5Sbiuz4pASjS
         1nBrMHHJ509olYuBfylDh4Yc2TqzCxA+8AUw8hJhI3ss5PHrMQ6OHwiAL4feVgB9hFpO
         YVpwCBGO5YJj0IW0ZiK/QcUZA0rq01qAEpMO9J0gMbr9HAQhiyo6c7Wln/+0NwdQwfq6
         Uqx+Gafu6U2O00kblnwcIJdbXabgABlQ/aKXSul1fMhVZfDvRghZS7TCyuuBNUIRSj+i
         VMFqAPod36yXXXhjRrkrpduySYoYBIMi/JgU1/ZWo6f/3JAekwBRoWv+TvgdoFcFdyeh
         5QQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=rcCnKJ8L68lRrHNSwc8ugkqtWHmr890Swawvbcqc0j8=;
        b=rjNLFoQZL9+BroN7PmXZ16KrPjihsPVjaDxZmJ7RUyGFj76kFs6OZSDCY5/JBwuQ00
         y848xioSh7U+LycQ4+8QvgZ2hFno1F3zjAZFPsFFCaCS12H9VK6TcVBLT3e9iKpXdzce
         5XzaCK+kJVGJetiWUBSZHgcnGsOBhW+ZYi+pPjxmEHDu4iIP4fANl8W5Cu36iTjHjBb4
         jd7fzMBUFaTbdx+4tNaL59Zq6Ws4w+hB6XlZpYdPI9Wbdk5uow4Z0OkGSdP8mP+07SN5
         C/Z3j91tYMIvMp5u7GndWMCj+28HUXKAyOeE1ZYT81trgy6bddbQSTBXhvGLzKHCeqoB
         /I+w==
X-Gm-Message-State: AOAM5315DADUpD//S1UIl8T9Dzx5kwfj8aw9lSpzHIE3IYyzdYd+3Eyk
        p+2xLpk+7s6hhVk6wjooWrcG4N5rKNaytumYiAo=
X-Google-Smtp-Source: ABdhPJxYGdW9m9DS/bJ/DlNrliabWPY6cg82JCUApHaCUQffpYlshTOKGcLKq+srfbQ0+lZ7ig2+lLV1TV3jmyZbbys=
X-Received: by 2002:aed:2321:: with SMTP id h30mr997800qtc.213.1604663609526;
 Fri, 06 Nov 2020 03:53:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <026ed684d026b3d792f1bab60bd3d63be28acd65.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <026ed684d026b3d792f1bab60bd3d63be28acd65.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:53:18 +0000
Message-ID: <CAL3q7H69Nx0gfWO_t2=aYQS8EMN5HKH+0VA=Jx=d2h8tPuLtxA@mail.gmail.com>
Subject: Re: [PATCH 06/14] btrfs: use btrfs_read_node_slot in replace_path
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
>  fs/btrfs/relocation.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 4d5cb593b674..465f5b4d3233 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1218,8 +1218,6 @@ int replace_path(struct btrfs_trans_handle *trans, =
struct reloc_control *rc,
>
>         parent =3D eb;
>         while (1) {
> -               struct btrfs_key first_key;
> -
>                 level =3D btrfs_header_level(parent);
>                 BUG_ON(level < lowest_level);
>
> @@ -1235,7 +1233,6 @@ int replace_path(struct btrfs_trans_handle *trans, =
struct reloc_control *rc,
>                 old_bytenr =3D btrfs_node_blockptr(parent, slot);
>                 blocksize =3D fs_info->nodesize;
>                 old_ptr_gen =3D btrfs_node_ptr_generation(parent, slot);
> -               btrfs_node_key_to_cpu(parent, &first_key, slot);
>
>                 if (level <=3D max_level) {
>                         eb =3D path->nodes[level];
> @@ -1260,15 +1257,10 @@ int replace_path(struct btrfs_trans_handle *trans=
, struct reloc_control *rc,
>                                 break;
>                         }
>
> -                       eb =3D read_tree_block(fs_info, old_bytenr, old_p=
tr_gen,
> -                                            level - 1, &first_key);
> +                       eb =3D btrfs_read_node_slot(parent, slot);
>                         if (IS_ERR(eb)) {
>                                 ret =3D PTR_ERR(eb);
>                                 break;
> -                       } else if (!extent_buffer_uptodate(eb)) {
> -                               ret =3D -EIO;
> -                               free_extent_buffer(eb);
> -                               break;
>                         }
>                         btrfs_tree_lock(eb);
>                         if (cow) {
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
