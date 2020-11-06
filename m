Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37EE2A95C6
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgKFLvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFLvs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:51:48 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA387C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:51:48 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id d1so292559qvl.6
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=WFh20jcAcx3LKpemVjYSPei9kHg4zul2Qzc1oK4jJOk=;
        b=Jr21csp/Ss1HFNDGhkNkdkC8wEWzgpPox8gE3+GSr5gB+jsNJ4vNKC2EWGuSllTS+N
         qTixCF31cimLojaYveF77lg7tG9CME0wnkbl/Mi7j9SioSD1plFzmp4G8OD4XZXUoPf7
         cU6/VNKu5gpHUho4kzBL6D3Hf1UbqmEe11L/x0bWGDU1EBdnmIJPz/1fYu+0IoBmIU9+
         bEdN6dIF4usRHqCqCU66VlEfuUnv3TYbROPGbyUEpBTYLRJOZNgYG+kzsoE3tLeecwsJ
         kc9PvuaF1aoKikJUhVJF6409OlvVcTExeshujKAy5FqgQ84WPTqDhLMx5wZ1DcHYIbFF
         WMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=WFh20jcAcx3LKpemVjYSPei9kHg4zul2Qzc1oK4jJOk=;
        b=P8YKrh85op1VP72ua73awjg466nu6mBl/mT8pcfqIk+ZdCzHBZp73AcKYKFDxBdIRH
         Z10iFt/4VM4qZIoJsyhq813TzZNnfNWItlUKkPPJ1XLF1iJyrN3AcWDf7L35pxJnnr1A
         0zxSy7dFcJuqei65zTEaLEZ7ClRw0Qxzbd4QDfvYJ70Yn93NGVBTB/+gnYpuoYWhuW0n
         SekGGNhGduOxMzGZBQFvefHlZxaH1wUUn5TLCPcuj7UhKl8YoJJqb2DN6WnjIX2GYrYG
         ZJDKKQ5fc1BBy2flxj9cJI+6T9g6LE+ubBmqXjiHGaZqd6iA5fzZRQi0NC0G7T1WU3Fd
         Wtkw==
X-Gm-Message-State: AOAM530YWs01OiPZ7qwEWyfcoh6bbQl8l2fF2RrS4D+pKIvDGBy2ufFf
        jyuQtpjQqoTVRaaxJ8mUPcu3sznmglL5wR4awZw=
X-Google-Smtp-Source: ABdhPJxhH1nUZKvO39EVyfKbf9hswgiactwwBKNbc2H01XfsZay/gicnnBmJnzNsuROS7UP8/RYjDw/Bihx5gIhzcy0=
X-Received: by 2002:a0c:99e6:: with SMTP id y38mr1130042qve.28.1604663508117;
 Fri, 06 Nov 2020 03:51:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <3a6461bd56f7f175fe4050b0c78747bf065242c4.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <3a6461bd56f7f175fe4050b0c78747bf065242c4.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:51:37 +0000
Message-ID: <CAL3q7H4v0MoEAY02SHGLjqMWHpdp5XOKAiKm9foLJ5i=sM75cg@mail.gmail.com>
Subject: Re: [PATCH 03/14] btrfs: use btrfs_read_node_slot in btrfs_realloc_node
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 5, 2020 at 3:47 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We have this giant open-coded nightmare in btrfs_realloc_node that does
> the same thing that the normal read path does, which is to see if we
> have the eb in memory already, and if not read it, and verify the eb is
> uptodate.  Delete this open coding and simply use btrfs_read_node_slot.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I couldn't get anymore the lockdep splat I reported before (after
applying the whole patchset of course), it used to happen very often
with btrfs/033.

Looks good, thanks.

> ---
>  fs/btrfs/ctree.c | 33 +++------------------------------
>  1 file changed, 3 insertions(+), 30 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 0ff866328a4f..5ec778e01222 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1570,7 +1570,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *t=
rans,
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
>         struct extent_buffer *cur;
>         u64 blocknr;
> -       u64 gen;
>         u64 search_start =3D *last_ret;
>         u64 last_block =3D 0;
>         u64 other;
> @@ -1579,7 +1578,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *t=
rans,
>         int i;
>         int err =3D 0;
>         int parent_level;
> -       int uptodate;
>         u32 blocksize;
>         int progress_passed =3D 0;
>         struct btrfs_disk_key disk_key;
> @@ -1597,7 +1595,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *t=
rans,
>                 return 0;
>
>         for (i =3D start_slot; i <=3D end_slot; i++) {
> -               struct btrfs_key first_key;
>                 int close =3D 1;
>
>                 btrfs_node_key(parent, &disk_key, i);
> @@ -1606,8 +1603,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *t=
rans,
>
>                 progress_passed =3D 1;
>                 blocknr =3D btrfs_node_blockptr(parent, i);
> -               gen =3D btrfs_node_ptr_generation(parent, i);
> -               btrfs_node_key_to_cpu(parent, &first_key, i);
>                 if (last_block =3D=3D 0)
>                         last_block =3D blocknr;
>
> @@ -1624,31 +1619,9 @@ int btrfs_realloc_node(struct btrfs_trans_handle *=
trans,
>                         continue;
>                 }
>
> -               cur =3D find_extent_buffer(fs_info, blocknr);
> -               if (cur)
> -                       uptodate =3D btrfs_buffer_uptodate(cur, gen, 0);
> -               else
> -                       uptodate =3D 0;
> -               if (!cur || !uptodate) {
> -                       if (!cur) {
> -                               cur =3D read_tree_block(fs_info, blocknr,=
 gen,
> -                                                     parent_level - 1,
> -                                                     &first_key);
> -                               if (IS_ERR(cur)) {
> -                                       return PTR_ERR(cur);
> -                               } else if (!extent_buffer_uptodate(cur)) =
{
> -                                       free_extent_buffer(cur);
> -                                       return -EIO;
> -                               }
> -                       } else if (!uptodate) {
> -                               err =3D btrfs_read_buffer(cur, gen,
> -                                               parent_level - 1,&first_k=
ey);
> -                               if (err) {
> -                                       free_extent_buffer(cur);
> -                                       return err;
> -                               }
> -                       }
> -               }
> +               cur =3D btrfs_read_node_slot(parent, i);
> +               if (IS_ERR(cur))
> +                       return PTR_ERR(cur);
>                 if (search_start =3D=3D 0)
>                         search_start =3D last_block;
>
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
