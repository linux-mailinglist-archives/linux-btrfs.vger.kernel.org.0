Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7521B1312
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 19:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgDTRb0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 13:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgDTRbY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 13:31:24 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C84C061A0C;
        Mon, 20 Apr 2020 10:31:23 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id u12so3959640uau.10;
        Mon, 20 Apr 2020 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=iVY0Hpczvi7L5kCeZ6+GsOel+foAxGUdGDubvBbDcLM=;
        b=mnzjP+p9p62Tt54In3kvaFAsTqnLkSsb5asmMvniKCgik1yjX1iITdNKYt2Qm+oRzJ
         jsXH/q59g0GI7zHllzSqUzT03sasDSEXNQoGbIaIT6eK6wEEv4r6t1eDwsDRAeOhcnNj
         JwfkB+U/0S/XAn37mHtcuZb/fvyVBETYBphzLmV5sK9vTdG1VCRvbwV3eeO/8cg0EXNo
         HK/5ZepmYFiyakWP5dh4ME64kCyKg4zn+BocuG5z/uG/Z3S9u/TLatGIzckMDc0dw3VG
         98dPTPxeqfKPc5IiH1tfa3TR3kOc5vYvMctJXysAW8AtJx2SvmcZhzLHuXRMa1lmN0w8
         HhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=iVY0Hpczvi7L5kCeZ6+GsOel+foAxGUdGDubvBbDcLM=;
        b=oJCLipl46E46Ib8hUA7Vt0Svl3BvAkYN5HmBMdG8qMzX5N4CvVpoji18nhrMR5E9ai
         0L46B79YZOur0WjMtPnZRuns4PlbFT3ECjtw3k/hfQAccVLyxW+R8bRFQnq6gaG7obNe
         h1Abq1JHxxLNTWBD0ckqjGWTvc2FkB1ZizsJw7apTbdqE6f0UndfXKuLZy/jMjUeidj9
         oMIRixV8l16rGsFuIbpLE8rKo0Mk/wiyeEvrKYk4FexaD7o2uN+quKXiZjIClIppmfKf
         vZKQl/Gmr2W/1k5YXZ27oO1scmF0/tNCjRTKqs3eYXhyDtBNL/kNcQ+GIIf5C3cSLn50
         UC0g==
X-Gm-Message-State: AGi0PuZ6i7aPwfX8CGApVa2bBOwBUJl2XRdD7/jDvtjY5lbDB8XTm9dr
        wJ0loNFMcgEBQBoPxtYO/FiP7pEid+z19XGLxHg=
X-Google-Smtp-Source: APiQypL7+rXbzmdtDdBy5m419OAA82863CHZRkkuwAJ3GNdtPTpcRgl6s5lOBursmCBzXmMfTpd2F/AnsCiLZeFTjqk=
X-Received: by 2002:ab0:b88:: with SMTP id c8mr7756282uak.0.1587403882279;
 Mon, 20 Apr 2020 10:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <1587361120-83160-1-git-send-email-xiyuyang19@fudan.edu.cn>
In-Reply-To: <1587361120-83160-1-git-send-email-xiyuyang19@fudan.edu.cn>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 20 Apr 2020 18:31:11 +0100
Message-ID: <CAL3q7H4wE48Uqu6xLA-FYGy9qxov+26wnpXsjG=Ragi1UJx21Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Fix btrfs_block_group refcnt leak
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 20, 2020 at 6:48 AM Xiyu Yang <xiyuyang19@fudan.edu.cn> wrote:
>
> btrfs_remove_block_group() invokes btrfs_lookup_block_group(), which
> returns a local reference of the blcok group that contains the given
> bytenr to "block_group" with increased refcount.
>
> When btrfs_remove_block_group() returns, "block_group" becomes invalid,
> so the refcount should be decreased to keep refcount balanced.
>
> The reference counting issue happens in several exception handling paths
> of btrfs_remove_block_group(). When those error scenarios occur such as
> btrfs_alloc_path() returns NULL, the function forgets to decrease its
> refcnt increased by btrfs_lookup_block_group() and will cause a refcnt
> leak.
>
> Fix this issue by jumping to "out_put_group" label and calling
> btrfs_put_block_group() when those error scenarios occur.
>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Seems correct to me.
I would change the subject to something more clear like: "btrfs: fix
block group leak after failure to remove it"

One more suggestion below.

> ---
>  fs/btrfs/block-group.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 404e050ce8ee..d9f432bd3329 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -916,7 +916,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handl=
e *trans,
>         path =3D btrfs_alloc_path();
>         if (!path) {
>                 ret =3D -ENOMEM;
> -               goto out;
> +               goto out_put_group;
>         }
>
>         /*
> @@ -954,7 +954,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handl=
e *trans,
>                 ret =3D btrfs_orphan_add(trans, BTRFS_I(inode));
>                 if (ret) {
>                         btrfs_add_delayed_iput(inode);
> -                       goto out;
> +                       goto out_put_group;
>                 }
>                 clear_nlink(inode);
>                 /* One for the block groups ref */
> @@ -977,13 +977,13 @@ int btrfs_remove_block_group(struct btrfs_trans_han=
dle *trans,
>
>         ret =3D btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
>         if (ret < 0)
> -               goto out;
> +               goto out_put_group;
>         if (ret > 0)
>                 btrfs_release_path(path);
>         if (ret =3D=3D 0) {
>                 ret =3D btrfs_del_item(trans, tree_root, path);
>                 if (ret)
> -                       goto out;
> +                       goto out_put_group;
>                 btrfs_release_path(path);
>         }
>
> @@ -1102,7 +1102,7 @@ int btrfs_remove_block_group(struct btrfs_trans_han=
dle *trans,
>
>         ret =3D remove_block_group_free_space(trans, block_group);
>         if (ret)
> -               goto out;
> +               goto out_put_group;
>
>         btrfs_put_block_group(block_group);
>         btrfs_put_block_group(block_group);
> @@ -1132,6 +1132,9 @@ int btrfs_remove_block_group(struct btrfs_trans_han=
dle *trans,
>                 btrfs_delayed_refs_rsv_release(fs_info, 1);
>         btrfs_free_path(path);
>         return ret;
> +out_put_group:
> +       btrfs_put_block_group(block_group);
> +       goto out;

Instead of this double goto, which tends to be error prone and harder to fo=
llow,
I suggest placing a call to btrfs_put_block_group() right after the
'out' label, with a comment
above it saying something like "once for the lookup reference" and
removing one of the btrfs_put_block_group()
calls right after calling remove_block_group_free_space(), and leaving
a comment above the other one saying "once for the block groups
rbtree".

Thanks.

>  }
>
>  struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
> --
> 2.7.4
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
