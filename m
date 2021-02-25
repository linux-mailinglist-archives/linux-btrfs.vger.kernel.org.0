Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB06325A25
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 00:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhBYXW7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 18:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhBYXWz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 18:22:55 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6292EC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Feb 2021 15:22:15 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id d9so7382151ote.12
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Feb 2021 15:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBC+X73pAu5mKMZLAztBOR60SQvU87uFrikYSfhbyFw=;
        b=rUf2/R7AjIja/GUVsfq7ThPYwWxp6JjxQgoCo3azCK4mks3HEZ0Js/9HnupcmcQY8V
         mCEWxjIZkZqaxhiQDSgCjWpACXJlqtNbf7CLOeB99l/jHBMSOSKIxe9bk7affkeqLLsz
         mgBy20QEUn2y525CW+B5u+xa2Fu/G94UwkF79yAhLkXoQyQEjTKinJh3KrV7Znc6kb/Q
         NYmkZb+hcC7CyRygt0prnCWmOCRfuSAyGD0P4muUnag5cNzWghJdsxD62H2NpoM/+r9o
         B2sKOxuIbbRmYG+rHE14Xk+f8OqbYjkF0BZpyxD3LSLwBByPdhiBdNtHm5pYR7zsprWA
         /yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBC+X73pAu5mKMZLAztBOR60SQvU87uFrikYSfhbyFw=;
        b=Z8rk3PCwg/taj4a7m4BEWXxECfUOLfikwhg5TS/oQbmjgaTgYJEYCNQ5vlMcVChFUa
         bGKTPadqAG6GAVKAWH7dgK3bweJqxjpz2hmF2OKom8+rv6sCJ/E88+99dwguJVnvZBd4
         8weU2Ln/d3/TETPV9KF49pb05wfkD8Iv7IE3YnUfneNfjJ38RxTb9fOanB+XY1Zf2CqH
         8htzMYHb88FgcJZVJhag2owgZ4WbrbGZAMouUiAd4EVYaLDC1P/m5FC2N9wsDFI574zs
         UGKr/Eojh1gBYcvrPAt70FcDhDzP6mj5EEqFyPB/hzqSQ7SHaxmuIOkvQsgV9uoZMUH1
         5DoQ==
X-Gm-Message-State: AOAM531EyG/LsOX/m0KoNJmyrAwTuqS8c0KZ4GgZQ/ec4QgGoz2jZ5W8
        OT46M3ZdmQBi8IHDEsgiWJzfoU5xAtRUYGOYuEU=
X-Google-Smtp-Source: ABdhPJyrkghFsqlQHuGBBoNe3ibPzpQyy+jGso9olQ0TWI3zCqWD3O3EZafqtv9rQIveR/alnrZZMB7n/YeiC7zqjEM=
X-Received: by 2002:a05:6830:10c1:: with SMTP id z1mr88489oto.254.1614295334505;
 Thu, 25 Feb 2021 15:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20210225205822.mgx5ei3tzcqmlts6@fiona>
In-Reply-To: <20210225205822.mgx5ei3tzcqmlts6@fiona>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Thu, 25 Feb 2021 15:22:03 -0800
Message-ID: <CAE1WUT6SPVbNhr5xD-BFqzZS+jRNtdJsE2CBO=24iuO2a_GgGA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: Remove force argument from run_delalloc_nocow()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, dsterba@suse.cz
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 25, 2021 at 1:04 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> force_nocow can be calculated by btrfs_inode and does not need to be
> passed as an argument.
>
> This simplifies run_delalloc_nocow() call from btrfs_run_delalloc_range()
> since the decision whether the extent is cow'd or not can be derived
> from need_force_cow(). Since BTRFS_INODE_NODATACOW and
> BTRFS_INODE_PREALLOC flags are checked in need_force_cow(), there is
> no need to check it again.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>
> Change since v1:
>  - Kept need_force_cow() as it is
>
> ---
>  fs/btrfs/inode.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4f2f1e932751..e5dd8d7ef0c8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1516,7 +1516,7 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
>  static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>                                        struct page *locked_page,
>                                        const u64 start, const u64 end,
> -                                      int *page_started, int force,
> +                                      int *page_started,
>                                        unsigned long *nr_written)
>  {
>         struct btrfs_fs_info *fs_info = inode->root->fs_info;
> @@ -1530,6 +1530,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>         u64 ino = btrfs_ino(inode);
>         bool nocow = false;
>         u64 disk_bytenr = 0;
> +       bool force = inode->flags & BTRFS_INODE_NODATACOW;
>
>         path = btrfs_alloc_path();
>         if (!path) {
> @@ -1891,17 +1892,12 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
>                 struct writeback_control *wbc)
>  {
>         int ret;
> -       int force_cow = need_force_cow(inode, start, end);
>         const bool zoned = btrfs_is_zoned(inode->root->fs_info);
>
> -       if (inode->flags & BTRFS_INODE_NODATACOW && !force_cow) {
> +       if (!need_force_cow(inode, start, end)) {
>                 ASSERT(!zoned);
>                 ret = run_delalloc_nocow(inode, locked_page, start, end,
> -                                        page_started, 1, nr_written);
> -       } else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
> -               ASSERT(!zoned);
> -               ret = run_delalloc_nocow(inode, locked_page, start, end,
> -                                        page_started, 0, nr_written);
> +                                        page_started, nr_written);
>         } else if (!inode_can_compress(inode) ||
>                    !inode_need_compress(inode, start, end)) {
>                 if (zoned)
> --
> 2.30.1
>
>
> --
> Goldwyn

Acked-by: Amy Parker <enbyamy@gmail.com>

Not super familiar with the btrfs inode implementation - but from what
I know of it and what I can read here it looks good to me.

   -Amy IP
