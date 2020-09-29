Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0141127CEEE
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgI2NTu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 09:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgI2NTu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 09:19:50 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57938C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 06:19:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id r8so3449992qtp.13
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UwhKa6PHzs3WuuZVhEN+JNRa9fftuTsAQSnicffkx90=;
        b=FeGEC+EMe8b7J5aEGH5IY0+uofP3EJDue7PI4A92QhAwMSHhqa8lMPFrtyzghmLyyW
         4Hp5fNLmAwqDALkx4harRee4fBqcNVdIxcI9rk7KOh68mqm9A7LKsaF3WHq7iFNh2e44
         wHKxbfQDsGj6x7GT6zq100hRRKQRctQjTQOHFZY2+qwSqR/MOd6B1slZp6bpVpcvmGOB
         q7BpHJ0rZcFBb0iQdzUASJjQY6WX8gjlIQqzL9zYITiSJg8TnlltLk0WBuZh4I8E10vT
         X1wuiA8+jgx7pRpxx1oU+0acIJBS8HSQQEsOEKdnMNBop9kUced8/UFVjVp06+yMakpN
         +OzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UwhKa6PHzs3WuuZVhEN+JNRa9fftuTsAQSnicffkx90=;
        b=pOHHFCJ45Qqdext4MzuWSE2XogAO9ZgfBwoYngyQF8ydJhKUzS7Pke0PBOoaFbffa5
         ZEms0zBhMkUtZs6Bx/DCo1PcYprtFskSo7x2WFbKsc9OlHuNalHJgwZYn/IiGlygtZKK
         BzUJ1sZ9FOT8pheQxM9fgHz4qL/PB8JQrBJ96GxA3BDC3+0eqZrFb9AaasJP8vXVAZ+g
         /wgCPQQ1w4cLa2USdvoLBRHjIYhstaxM8fULRo/08lc8gJhNWXRXzo4TX7b4NnVuV0lV
         kV5S4qMiVUIl+uDXDGtgEVs8/jlLJ5tx28DL9zngaKMVsk+ntJ9yP8VebBk6QPV/lJoB
         aTAw==
X-Gm-Message-State: AOAM531I1Xvz2ih1DeemqckYY8w/Q6hrO7VLIHJOvnN5lQvaFgTQpj80
        pEMiqJgezIaiNPljCqukS0/bL1wgesXCYl5B1i0=
X-Google-Smtp-Source: ABdhPJwWDjdABIEtcqlFNcU2DYXnOhCO4r6qJC13UM87+YQ33B21ct5hdLywAh+flrjwswpj0SZu4hnWi5oguoyRr5U=
X-Received: by 2002:ac8:cc4:: with SMTP id o4mr3199311qti.21.1601385589303;
 Tue, 29 Sep 2020 06:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <1f84722853326611d5d0d6c74e7af75be7b5928d.1601384009.git.josef@toxicpanda.com>
In-Reply-To: <1f84722853326611d5d0d6c74e7af75be7b5928d.1601384009.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 29 Sep 2020 14:19:38 +0100
Message-ID: <CAL3q7H66bd6S-p5f4g7bmk2jMYemGRkQM3km=LKRkzuBbeug+w@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: cleanup cow block on error
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 29, 2020 at 1:55 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> With my automated fstest runs I noticed one of my workers didn't report
> results.  Turns out it was hung trying to write back inodes, and the
> write back thread was stuck trying to lock an extent buffer
>
> [root@xfstests2 xfstests-dev]# cat /proc/2143497/stack
> [<0>] __btrfs_tree_lock+0x108/0x250
> [<0>] lock_extent_buffer_for_io+0x35e/0x3a0
> [<0>] btree_write_cache_pages+0x15a/0x3b0
> [<0>] do_writepages+0x28/0xb0
> [<0>] __writeback_single_inode+0x54/0x5c0
> [<0>] writeback_sb_inodes+0x1e8/0x510
> [<0>] wb_writeback+0xcc/0x440
> [<0>] wb_workfn+0xd7/0x650
> [<0>] process_one_work+0x236/0x560
> [<0>] worker_thread+0x55/0x3c0
> [<0>] kthread+0x13a/0x150
> [<0>] ret_from_fork+0x1f/0x30
>
> This is because we got an error while cow'ing a block, specifically here
>
>         if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
>                 ret =3D btrfs_reloc_cow_block(trans, root, buf, cow);
>                 if (ret) {
>                         btrfs_abort_transaction(trans, ret);
>                         return ret;
>                 }
>         }
>
> The problem here is that as soon as we allocate the new block it is
> locked and marked dirty in the btree inode.  This means that we could
> attempt to writeback this block and need to lock the extent buffer.
> However we're not unlocking it here and thus we deadlock.
>
> Fix this by unlocking the cow block if we have any errors inside of
> __btrfs_cow_block, and also free it so we do not leak it.
>
> Fixes: 65b51a009e29 ("btrfs_search_slot: reduce lock contention by cowing=
 in two stages")
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a165093739c4..113da62dc17f 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1064,6 +1064,8 @@ static noinline int __btrfs_cow_block(struct btrfs_=
trans_handle *trans,
>
>         ret =3D update_ref_for_cow(trans, root, buf, cow, &last_ref);
>         if (ret) {
> +               btrfs_tree_unlock(cow);
> +               free_extent_buffer(cow);
>                 btrfs_abort_transaction(trans, ret);
>                 return ret;
>         }
> @@ -1071,6 +1073,8 @@ static noinline int __btrfs_cow_block(struct btrfs_=
trans_handle *trans,
>         if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
>                 ret =3D btrfs_reloc_cow_block(trans, root, buf, cow);
>                 if (ret) {
> +                       btrfs_tree_unlock(cow);
> +                       free_extent_buffer(cow);
>                         btrfs_abort_transaction(trans, ret);
>                         return ret;
>                 }
> @@ -1103,6 +1107,8 @@ static noinline int __btrfs_cow_block(struct btrfs_=
trans_handle *trans,
>                 if (last_ref) {
>                         ret =3D tree_mod_log_free_eb(buf);
>                         if (ret) {
> +                               btrfs_tree_unlock(cow);
> +                               free_extent_buffer(cow);

The tree here already has a node pointing to the new buffer ("cow"),
so we shouldn't call free_extent_buffer() against it.
For all the previous places it's fine.

Thanks.

>                                 btrfs_abort_transaction(trans, ret);
>                                 return ret;
>                         }
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
