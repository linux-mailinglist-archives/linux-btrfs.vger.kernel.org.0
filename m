Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343F731D7BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 11:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBQK4Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 05:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBQK4S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 05:56:18 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71469C061756
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 02:55:38 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id x14so12278340qkm.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 02:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=s0pnF0NM7Nk3noI5+FpH2QmUNRp6an4fbMLTHjOceBA=;
        b=NkxlJUtPRuhYWrSOnNxapHDsqsEZYYyIue6pox//q7VeV8GK6rvq49iAe/tAfLePQZ
         OyNTvpeFddLrNQYerDxpF2RzbAcz2BKjBILD/WV2owfWaD/Msb2G6LJPkT/381RFKOUw
         FW3fWkuC28mTUvFRFAHJ9w/SZefi3ma33/IiWablJ5lkdEmq5KyimjoQX3M4YlunWGn0
         vyLho4Rmea3GQcNyK0644yj5fp95WS0BurYeVcjWZYzsjERihHmMHdhjo+vqGyA9fdoR
         m/V6L4+O1CRHZL+psIVed3VE/CVWZzqbFZG/zMH2S24gMbwalBHsdJC4xsfkAAetZDJC
         qanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=s0pnF0NM7Nk3noI5+FpH2QmUNRp6an4fbMLTHjOceBA=;
        b=iPv+es1xyb8u+82boXq3CAyh8zyUuegzCetjmboemNBx4NYDceKtnWvYYBfs2+NMob
         /xQe5V3oYfQvnS+YxShQ1lD7WdV6IwrRkBjcvUQrYepssJVTHllCKmOEU6jI3xGQow1t
         Zg1GQ/zwC9lc173BTuZqlxagnuaWk1Tv5Qfn8O9vdo7Jizt6z2kCZn3hRghsc/eDObqf
         CyY5ouWGvsSeBbJTxWUOlD8ygbOPHEAkrg54J6PrNo/QOaAKPw1fXcvoDJm+ZzcQM3h+
         WcgCjH7HdeuVa757ia5QkNZuqzS2dRLRrpXi/tw4RsUovunJLznnQ8zY0lK7FVXnXKjP
         YxyA==
X-Gm-Message-State: AOAM530pRvhoCS2iRZffQcXlGTHbVgCXTT46xTzz6pGhSTA6vNH9/oE/
        4fkipIMDjWMvo2ehuFs6rxXFOcxDpmO3nNpKPGQolgHL/MI=
X-Google-Smtp-Source: ABdhPJzEj8aCcjirSg85h2VvteLa/MPfB2jPenCILhzAERbYpxgt+Tg2DHQ+IE3unEMnUCRVB9LCu3B6bQAqyF2Wlc4=
X-Received: by 2002:a37:54b:: with SMTP id 72mr22684149qkf.338.1613559337726;
 Wed, 17 Feb 2021 02:55:37 -0800 (PST)
MIME-Version: 1.0
References: <ba64e01fa8f13d10daebe1d8e24ad1a20de9b231.1613545566.git.johannes.thumshirn@wdc.com>
In-Reply-To: <ba64e01fa8f13d10daebe1d8e24ad1a20de9b231.1613545566.git.johannes.thumshirn@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 Feb 2021 10:55:26 +0000
Message-ID: <CAL3q7H4+ndp=gj_vQewTsXsaSd+B0YR8zeAMNt2SqfArYiPxSQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: fix possible deadlock on log sync
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 17, 2021 at 7:38 AM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Lockdep with fstests test-case btrfs/041 detected a unsafe locking
> scenario when we allocate the log node on a zoned filesystem.
>
> btrfs/041
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  WARNING: possible recursive locking detected
>  5.11.0-rc7+ #939 Not tainted
>  --------------------------------------------
>  xfs_io/698 is trying to acquire lock:
>  ffff88810cd673a0 (&root->log_mutex){+.+.}-{3:3}, at: btrfs_sync_log+0x3d=
1/0xee0 [btrfs]
>
>  but task is already holding lock:
>  ffff88810b0fc3a0 (&root->log_mutex){+.+.}-{3:3}, at: btrfs_sync_log+0x31=
3/0xee0 [btrfs]
>
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(&root->log_mutex);
>    lock(&root->log_mutex);
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
>  2 locks held by xfs_io/698:
>   #0: ffff88810cd66620 (sb_internal){.+.+}-{0:0}, at: btrfs_sync_file+0x2=
c3/0x570 [btrfs]
>   #1: ffff88810b0fc3a0 (&root->log_mutex){+.+.}-{3:3}, at: btrfs_sync_log=
+0x313/0xee0 [btrfs]
>
>  stack backtrace:
>  CPU: 0 PID: 698 Comm: xfs_io Not tainted 5.11.0-rc7+ #939
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0=
-gf21b5a4-rebuilt.opensuse.org 04/01/2014
>  Call Trace:
>   dump_stack+0x77/0x97
>   __lock_acquire.cold+0xb9/0x32a
>   lock_acquire+0xb5/0x400
>   ? btrfs_sync_log+0x3d1/0xee0 [btrfs]
>   __mutex_lock+0x7b/0x8d0
>   ? btrfs_sync_log+0x3d1/0xee0 [btrfs]
>   ? btrfs_sync_log+0x3d1/0xee0 [btrfs]
>   ? find_first_extent_bit+0x9f/0x100 [btrfs]
>   ? __mutex_unlock_slowpath+0x35/0x270
>   btrfs_sync_log+0x3d1/0xee0 [btrfs]
>   btrfs_sync_file+0x3a8/0x570 [btrfs]
>   __x64_sys_fsync+0x34/0x60
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  RIP: 0033:0x7f1e856b8ecb
>  Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 =
0c e8 b3 f6 ff ff 8b 7c 24 0c 41 89 c0 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 f=
f ff 77 35 44 89 c7 89 44 24 0c e8 11 f7 ff ff 8b 44
>  RSP: 002b:00007ffde89011b0 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
>  RAX: ffffffffffffffda RBX: 0000557ef97886c0 RCX: 00007f1e856b8ecb
>  RDX: 0000000000000002 RSI: 0000557ef97886e0 RDI: 0000000000000003
>  RBP: 0000557ef97886e0 R08: 0000000000000000 R09: 0000000000000003
>  R10: fffffffffffff50e R11: 0000000000000293 R12: 0000000000000001
>  R13: 0000557ef97886c0 R14: 0000000000000001 R15: 0000557ef976e2a0
>
> This happens, because we are taking the ->log_mutex albeit it has already
> been locked.
>
> Also while at it, fix the bogus unlock of the tree_log_mutex in the error
> handling.
>
> Fixes: 3ddebf27fcd3 ("btrfs: zoned: reorder log node allocation on zoned =
filesystem")
> Cc: Filipe Manana <fdmanana@suse.com>
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, and actually this is a guaranteed deadlock rather than a
possible deadlock (as the subject says).

Thanks.

> ---
>  fs/btrfs/tree-log.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index d90695c1ab6c..2f1acc9aea9e 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3174,16 +3174,13 @@ int btrfs_sync_log(struct btrfs_trans_handle *tra=
ns,
>         root_log_ctx.log_transid =3D log_root_tree->log_transid;
>
>         if (btrfs_is_zoned(fs_info)) {
> -               mutex_lock(&fs_info->tree_root->log_mutex);
>                 if (!log_root_tree->node) {
>                         ret =3D btrfs_alloc_log_tree_node(trans, log_root=
_tree);
>                         if (ret) {
> -                               mutex_unlock(&fs_info->tree_log_mutex);
>                                 mutex_unlock(&log_root_tree->log_mutex);
>                                 goto out;
>                         }
>                 }
> -               mutex_unlock(&fs_info->tree_root->log_mutex);
>         }
>
>         /*
> --
> 2.30.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
