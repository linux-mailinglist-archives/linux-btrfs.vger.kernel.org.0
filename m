Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5032C2D87
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 17:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390676AbgKXQ4P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 11:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390663AbgKXQ4O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 11:56:14 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0DFC0613D6
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Nov 2020 08:56:14 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so21191476qkc.12
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Nov 2020 08:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FHUdrFnJaEbHA63CUTGZVugr8H/w2wOhd+QQQOeoD4Y=;
        b=CFWw3pKPEnpar6XvuAg1tIE1Ap/8kwwz25dY1SJGOFKB2yJzyVvz+nZiae6P6XfM3h
         I1kpaQ21PQUd3hNovBtlBclhGgrhZv+OFWaYATGqZJ1QqHS2Ed9/Ru7hfgz5xkGaFmAL
         QtvFvwZKzM2uztvJ3lR66WEWQScjyK6fS7FwO/vcTVyuzISd2TadQNlH4xCdDJ2DHu1l
         WqxgXX+RW5NrBucrlDCbGBDx0Baa0+MKrhOmpDOx5LPYMlItOLVk4IBJqDU/gPBKK0bA
         EBDhQwhGPpsPXLs4Ju5r8Z62fexXZZRDeVyouJSGE9FgJSCV87gy7SAhdea7tGhdA8d9
         UbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FHUdrFnJaEbHA63CUTGZVugr8H/w2wOhd+QQQOeoD4Y=;
        b=jRLunO605tgb1NqGYYIO69tGYoPD7dHm+RKH8XxBQa/BCG85gPcJ871O3M+eOHszmf
         ZPLsqZ8mu7k8gsH1qwa6g4jWtxTM7GeOAs2U9jI97mhuW0YfiPI6d/krSXLO4t7JaXLn
         WIgfSUV5Ri9Wx/6TRrpIFWzDlouhLHU/ugt3p1MMyBY6CR7ihcpEWDbfRzcrSv2ni/5r
         +6vmZK84DrQBnF7nLw8OxYMYs3KAXFghWgFL7KIWLosxsw3lLgUafX6pAjXcnW4Yeo13
         WKIJ3VQDj8/M7v6SaWGyudAKtiRqSUtcw5HC/gApTVn8fVp178IsCW9rFyqeMxXzDHqH
         Fr/g==
X-Gm-Message-State: AOAM53398CaL55oTs6cr8gabpXzSyznDEqYo/OcQoMWpapR+mRaYjr39
        c/tcmhr9WfbHBtm/5DA4+JGSt1cVgb4yX+oSuI8=
X-Google-Smtp-Source: ABdhPJww4PVoaXWn0A8XGcBFT9Yilr1nXe34ArICqM1we+9C5VTY6ciImBYLw3dA/Ie5B0B2yZoxJXjBa1L4npWmsVw=
X-Received: by 2002:a37:7c81:: with SMTP id x123mr5326789qkc.383.1606236973833;
 Tue, 24 Nov 2020 08:56:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605284383.git.josef@toxicpanda.com> <44c756daa28122f0f51f52d154c1232a09e66872.1605284383.git.josef@toxicpanda.com>
In-Reply-To: <44c756daa28122f0f51f52d154c1232a09e66872.1605284383.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 24 Nov 2020 16:56:02 +0000
Message-ID: <CAL3q7H6vUsWfKn1KtU+=5w_cn5OBa5k1VBEQnK=d51gfuiC9+w@mail.gmail.com>
Subject: Re: [PATCH v2 02/42] btrfs: fix lockdep splat in btrfs_recover_relocation
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 4:25 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> While testing the error paths of relocation I hit the following lockdep
> splat

The lockdep splat has a kernel named exactly like mine: *-btrfs-next-71 :)

>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 5.10.0-rc2-btrfs-next-71 #1 Not tainted
> ------------------------------------------------------
> find/324157 is trying to acquire lock:
> ffff8ebc48d293a0 (btrfs-tree-01#2/3){++++}-{3:3}, at: __btrfs_tree_read_l=
ock+0x32/0x1a0 [btrfs]
>
> but task is already holding lock:
> ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+=
0x32/0x1a0 [btrfs]
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (btrfs-tree-00){++++}-{3:3}:
>        lock_acquire+0xd8/0x490
>        down_write_nested+0x44/0x120
>        __btrfs_tree_lock+0x27/0x120 [btrfs]
>        btrfs_search_slot+0x2a3/0xc50 [btrfs]
>        btrfs_insert_empty_items+0x58/0xa0 [btrfs]
>        insert_with_overflow+0x44/0x110 [btrfs]
>        btrfs_insert_xattr_item+0xb8/0x1d0 [btrfs]
>        btrfs_setxattr+0xd6/0x4c0 [btrfs]
>        btrfs_setxattr_trans+0x68/0x100 [btrfs]
>        __vfs_setxattr+0x66/0x80
>        __vfs_setxattr_noperm+0x70/0x200
>        vfs_setxattr+0x6b/0x120
>        setxattr+0x125/0x240
>        path_setxattr+0xba/0xd0
>        __x64_sys_setxattr+0x27/0x30
>        do_syscall_64+0x33/0x80
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> -> #0 (btrfs-tree-01#2/3){++++}-{3:3}:
>        check_prev_add+0x91/0xc60
>        __lock_acquire+0x1689/0x3130
>        lock_acquire+0xd8/0x490
>        down_read_nested+0x45/0x220
>        __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>        btrfs_next_old_leaf+0x27d/0x580 [btrfs]
>        btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
>        iterate_dir+0x170/0x1c0
>        __x64_sys_getdents64+0x83/0x140
>        do_syscall_64+0x33/0x80
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(btrfs-tree-00);
>                                lock(btrfs-tree-01#2/3);
>                                lock(btrfs-tree-00);
>   lock(btrfs-tree-01#2/3);
>
>  *** DEADLOCK ***
>
> 5 locks held by find/324157:
>  #0: ffff8ebc502c6e00 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x4d/=
0x60
>  #1: ffff8eb97f689980 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: iterat=
e_dir+0x52/0x1c0
>  #2: ffff8ebaec00ca58 (btrfs-tree-02#2){++++}-{3:3}, at: __btrfs_tree_rea=
d_lock+0x32/0x1a0 [btrfs]
>  #3: ffff8eb98f986f78 (btrfs-tree-01#2){++++}-{3:3}, at: __btrfs_tree_rea=
d_lock+0x32/0x1a0 [btrfs]
>  #4: ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_=
lock+0x32/0x1a0 [btrfs]
>
> stack backtrace:
> CPU: 2 PID: 324157 Comm: find Not tainted 5.10.0-rc2-btrfs-next-71 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-=
gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  dump_stack+0x8d/0xb5
>  check_noncircular+0xff/0x110
>  ? mark_lock.part.0+0x468/0xe90
>  check_prev_add+0x91/0xc60
>  __lock_acquire+0x1689/0x3130
>  ? kvm_clock_read+0x14/0x30
>  ? kvm_sched_clock_read+0x5/0x10
>  lock_acquire+0xd8/0x490
>  ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>  down_read_nested+0x45/0x220
>  ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>  __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>  btrfs_next_old_leaf+0x27d/0x580 [btrfs]
>  btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
>  iterate_dir+0x170/0x1c0
>  __x64_sys_getdents64+0x83/0x140
>  ? filldir+0x1d0/0x1d0
>  do_syscall_64+0x33/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> This is thankfully straightforward to fix, simply release the path
> before we setup the reloc_ctl.

Ok, so that splat is exactly what I reported not long ago and is
already fixed by:

https://lore.kernel.org/linux-btrfs/36b861f262858990f84eda72da6bb2e6762c41b=
7.1604697895.git.josef@toxicpanda.com/#r

Which is the splat that happened in one of my test boxes.

So, have you pasted the wrong splat?
Did it happen with any existing test case from fstests, if so, which?
That one I reported was with btrfs/187 (worth mentioning in the
changelog).

Thanks.

>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/volumes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bb1aa96e1233..ece8bb62fcc1 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4283,6 +4283,8 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_=
info)
>                 btrfs_warn(fs_info,
>         "balance: cannot set exclusive op status, resume manually");
>
> +       btrfs_release_path(path);
> +
>         mutex_lock(&fs_info->balance_mutex);
>         BUG_ON(fs_info->balance_ctl);
>         spin_lock(&fs_info->balance_lock);
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
