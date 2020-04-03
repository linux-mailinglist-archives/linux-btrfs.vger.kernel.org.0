Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 827E419D327
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgDCJKP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 05:10:15 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40874 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgDCJKP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Apr 2020 05:10:15 -0400
Received: by mail-vk1-f196.google.com with SMTP id k63so1802772vka.7
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Apr 2020 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=HdTTFQreZa07Aw63NvgsDwHWPVavfNVjGfShUL8ya3w=;
        b=vYplSc8nBqoRqfzQW+XhueGnwIa0NaHFsTYX9qHcKwrtIueB4qA4Xd5sMAuqdmHv6P
         KfAxVjHDSDreRyR74aFYK/MtAJL9ptUJDffG/cmwHNSD5s5VjRFbjwVQ/NQcdhFYMnpr
         X1QUAfvWjw7Nxqj2G+90G28/4UVE7DmNrSWMkUP5xFEw72gTr3awY1nUNmYVJzcm0vZI
         yJwMLoyH+zghF4xypwSWY8rFo4ZquonMyTIS/BBOjCYhb9WrmUvgfFFPfhWdEJzMaPNt
         ptSk2DaRwbSFrhM7yTGkJgUZRqNnzCxr0Pp0OPMdqD5oDPQRn7+Qqvbxdvp+zB4d4NFD
         +BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=HdTTFQreZa07Aw63NvgsDwHWPVavfNVjGfShUL8ya3w=;
        b=JPX5QRxfGsdUyFajGoe8K/UlXF2PLp1+FDMBdgd/KE6TstVBuiVouWTzQcGawvdReG
         fZjfkCzKA34p59KkSMwC4V/HED6EHSeVeJqApQJ7fz/aXd1T36N7IfX2g5YZZ/xUXK3I
         FPc6GZb6a1PayvgASjU487hsier+36lEgPsQxa+kyfzv8ksNwepDWyOYdqKd8b+S8aUX
         XGRCOp+ZavvaJnBtBDwTv4ZDdVNt1579EuIGaVivNnao42V4WWQiwABNAXINXRvyfokF
         do8OG8ciXIIIJXM1jJ9avL/M29p/tzv0btSco8suoHhn81AFvwjfdWFhDYL/lmZIUvoC
         rTpg==
X-Gm-Message-State: AGi0PuYt+FnywC3j8NVXPHKq+UesAK7hKG1ZebSvI2BizjsEMlNSTwS/
        f868pIkk2nlZXEsy++F82f0rbhYW+aBhdwC4PA4Xew==
X-Google-Smtp-Source: APiQypI2lY/nCnpqjBs43AnvTvCl8pcsStGlBtWdd2MWey+iO/JfUFFzDevDdGzH88YBP6SAA2ZBBZmYoG0JyhnAcXw=
X-Received: by 2002:a1f:ca04:: with SMTP id a4mr5512227vkg.65.1585905013557;
 Fri, 03 Apr 2020 02:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200402195118.4406-1-josef@toxicpanda.com>
In-Reply-To: <20200402195118.4406-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 3 Apr 2020 09:10:02 +0000
Message-ID: <CAL3q7H709dV06QGXQ9Pi3XSa7CpQYiTg=jE=Ev=ht1=GMnhwug@mail.gmail.com>
Subject: Re: [PATCH] btrfs: check commit root generation in should_ignore_root
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 2, 2020 at 8:53 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Previously we would set the reloc root's last snapshot to transid - 1.
> However there was a problem with doing this, and we changed it to
> setting the last snapshot to the generation of the commit node of the fs
> root.
>
> This however broke should_ignore_root().  The assumption is that if we
> are in a generation newer than when the reloc root was created, then we
> would find the reloc root through normal backref lookups, and thus can
> ignore any fs roots we find with an old enough reloc root.
>
> Now that the last snapshot could be considerably further in the past
> than before, we'd end up incorrectly ignoring an fs root.  Thus we'd
> find no nodes for the bytenr we were searching for, and we'd fail to
> relocate anything.  We'd loop through the relocate code again and see
> that there were still used space in that block group, attempt to
> relocate those bytenr's again, fail in the same way, and just loop like
> this forever.  This is tricky in that we have to not modify the fs root
> at all during this time, so we need to have a block group that has data
> in this fs root that is not shared by any other root, which is why this
> has been difficult to reproduce.
>
> Fixes: 054570a1dc94 ("Btrfs: fix relocation incorrectly dropping data ref=
erences")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/relocation.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 89a218cb81ef..7cb8d4123169 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -616,8 +616,8 @@ static int should_ignore_root(struct btrfs_root *root=
)
>         if (!reloc_root)
>                 return 0;
>
> -       if (btrfs_root_last_snapshot(&reloc_root->root_item) =3D=3D
> -           root->fs_info->running_transaction->transid - 1)
> +       if (btrfs_header_generation(reloc_root->commit_root) =3D=3D
> +           root->fs_info->running_transaction->transid)
>                 return 0;
>         /*
>          * if there is reloc tree and it was created in previous
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
