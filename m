Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D0EAF915
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 11:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfIKJhk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 05:37:40 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34835 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfIKJhk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 05:37:40 -0400
Received: by mail-ua1-f68.google.com with SMTP id u18so6564662uap.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 02:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=f9yGeHuHWi7tjsE2H0wZkeYkFEXJpBx2FUkcJHP53DI=;
        b=n37v7DtrwHURwsSs0SjVrymdyKv2mGl4B+xHf531bHoOVHrxeKFB5zJbhukiY7DfSl
         g/VchNe9CW8lbZCVB+PCTtr/knptZ4l14fa1OBR8Xf5Hqg9MQBiXhH0s5T4rWFd/9DpO
         9XwtecMr1yqOMOCJUs5C8w+aA35PZfUcnmYnK9qru+s0YTTQNpBYUHX78JqezVMKoYLI
         mcPVzj3OEIx5rA75SdjX8Dq1wYlGqOLCJxCtkqEHVRXMFkj89WzHtPP4xaR9SD8t0714
         HWzSsiyOutwYVqKmgDDKb9zkMBPoTSKOU/m5V5U9rxEYFfdxvyYQtVOWih1+HaLxWOPk
         v6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=f9yGeHuHWi7tjsE2H0wZkeYkFEXJpBx2FUkcJHP53DI=;
        b=GpAcZbgsdCHCo32rjkP44xrr9Op6EHt6ccqg7qlxIJM319UsLpgHqL/k1lQm9PMIIC
         nC7fQkDGFMZBCg2zRq2KdPBtgdQ7Ae2jcj29tri7hmNmVWUksufz7YPn2KqLbeP+XAoB
         roglnPafVAcvGaBOD5su0m5i7V346gYpn8B4dmfTfKbXGYthCNxwkIJ+IUnAOIOKuZFA
         dyYOIDD/NU9o5v9fHNomBzI2VJsbB/+XZsRW4Hnt5vX9uFylNiZhus7AuDRwVbDykRaA
         AVfLzrBddC3Pyf6ojTKWi/Om5/LyPnWoWL+jQtegMAGDkeOV4s1zfFuwppRCeE1nRnTy
         F+Vw==
X-Gm-Message-State: APjAAAULfY70RrCOuckImoUVmBK3rIExQFfzrkToapQATwdjeVpuThcL
        RfOUVMfthYx2lF2Vw91P43XoUU8O9g35RlRz04o=
X-Google-Smtp-Source: APXvYqyLm2zWUI1jm1cZpu3bb5SXOg9oBxMJNIHnduHBvCkOQAG+S6g/7lWA5ho0Llfd8Oa3GpSuYXTV7rQGETlr2tc=
X-Received: by 2002:ab0:2410:: with SMTP id f16mr16280976uan.83.1568194658428;
 Wed, 11 Sep 2019 02:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190909141204.24557-1-josef@toxicpanda.com>
In-Reply-To: <20190909141204.24557-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 11 Sep 2019 10:37:27 +0100
Message-ID: <CAL3q7H5CYhEqs9URKnnXejt+kFydFn4AoExrrwjvO022bzoN8w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: nofs inode allocations
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zdenek Sojka <zsojka@seznam.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 10, 2019 at 7:22 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> A user reported a lockdep splat
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: possible circular locking dependency detected
>  5.2.11-gentoo #2 Not tainted
>  ------------------------------------------------------
>  kswapd0/711 is trying to acquire lock:
>  000000007777a663 (sb_internal){.+.+}, at: start_transaction+0x3a8/0x500
>
> but task is already holding lock:
>  000000000ba86300 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x30
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (fs_reclaim){+.+.}:
>  kmem_cache_alloc+0x1f/0x1c0
>  btrfs_alloc_inode+0x1f/0x260
>  alloc_inode+0x16/0xa0
>  new_inode+0xe/0xb0
>  btrfs_new_inode+0x70/0x610
>  btrfs_symlink+0xd0/0x420
>  vfs_symlink+0x9c/0x100
>  do_symlinkat+0x66/0xe0
>  do_syscall_64+0x55/0x1c0
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> -> #0 (sb_internal){.+.+}:
>  __sb_start_write+0xf6/0x150
>  start_transaction+0x3a8/0x500
>  btrfs_commit_inode_delayed_inode+0x59/0x110
>  btrfs_evict_inode+0x19e/0x4c0
>  evict+0xbc/0x1f0
>  inode_lru_isolate+0x113/0x190
>  __list_lru_walk_one.isra.4+0x5c/0x100
>  list_lru_walk_one+0x32/0x50
>  prune_icache_sb+0x36/0x80
>  super_cache_scan+0x14a/0x1d0
>  do_shrink_slab+0x131/0x320
>  shrink_node+0xf7/0x380
>  balance_pgdat+0x2d5/0x640
>  kswapd+0x2ba/0x5e0
>  kthread+0x147/0x160
>  ret_from_fork+0x24/0x30
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>  CPU0 CPU1
>  ---- ----
>  lock(fs_reclaim);
>  lock(sb_internal);
>  lock(fs_reclaim);
>  lock(sb_internal);
> *** DEADLOCK ***
>
>  3 locks held by kswapd0/711:
>  #0: 000000000ba86300 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x=
30
>  #1: 000000004a5100f8 (shrinker_rwsem){++++}, at: shrink_node+0x9a/0x380
>  #2: 00000000f956fa46 (&type->s_umount_key#30){++++}, at: super_cache_sca=
n+0x35/0x1d0
>
> stack backtrace:
>  CPU: 7 PID: 711 Comm: kswapd0 Not tainted 5.2.11-gentoo #2
>  Hardware name: Dell Inc. Precision Tower 3620/0MWYPT, BIOS 2.4.2 09/29/2=
017
>  Call Trace:
>  dump_stack+0x85/0xc7
>  print_circular_bug.cold.40+0x1d9/0x235
>  __lock_acquire+0x18b1/0x1f00
>  lock_acquire+0xa6/0x170
>  ? start_transaction+0x3a8/0x500
>  __sb_start_write+0xf6/0x150
>  ? start_transaction+0x3a8/0x500
>  start_transaction+0x3a8/0x500
>  btrfs_commit_inode_delayed_inode+0x59/0x110
>  btrfs_evict_inode+0x19e/0x4c0
>  ? var_wake_function+0x20/0x20
>  evict+0xbc/0x1f0
>  inode_lru_isolate+0x113/0x190
>  ? discard_new_inode+0xc0/0xc0
>  __list_lru_walk_one.isra.4+0x5c/0x100
>  ? discard_new_inode+0xc0/0xc0
>  list_lru_walk_one+0x32/0x50
>  prune_icache_sb+0x36/0x80
>  super_cache_scan+0x14a/0x1d0
>  do_shrink_slab+0x131/0x320
>  shrink_node+0xf7/0x380
>  balance_pgdat+0x2d5/0x640
>  kswapd+0x2ba/0x5e0
>  ? __wake_up_common_lock+0x90/0x90
>  kthread+0x147/0x160
>  ? balance_pgdat+0x640/0x640
>  ? __kthread_create_on_node+0x160/0x160
>  ret_from_fork+0x24/0x30
>
> This is because btrfs_new_inode() calls new_inode() under the
> transaction.  We could probably move the new_inode() outside of this but
> for now just wrap it in memalloc_nofs_save().
>
> Reported-by: Zdenek Sojka <zsojka@seznam.cz>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

To aid the stable team figure out to where to backport things, adding
a Fixes tag (Fixes: 712e36c5f2a7fa ("btrfs: use GFP_KERNEL in
btrfs_alloc_inode")) or a " CC: stable@vger.kernel.org #  4.16+" would
help.

> ---
>  fs/btrfs/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index aece5dd0e7a8..bf40d1085e4e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6291,13 +6291,16 @@ static struct inode *btrfs_new_inode(struct btrfs=
_trans_handle *trans,
>         u32 sizes[2];
>         int nitems =3D name ? 2 : 1;
>         unsigned long ptr;
> +       unsigned long nofs_flag;

Should be unsigned int (it's what memalloc_nofs_save() returns exactly).

Anyway, the change itself looks good to me.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

>         int ret;
>
>         path =3D btrfs_alloc_path();
>         if (!path)
>                 return ERR_PTR(-ENOMEM);
>
> +       nofs_flag =3D memalloc_nofs_save();
>         inode =3D new_inode(fs_info->sb);
> +       memalloc_nofs_restore(nofs_flag);
>         if (!inode) {
>                 btrfs_free_path(path);
>                 return ERR_PTR(-ENOMEM);
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
