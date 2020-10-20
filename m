Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32F0293809
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 11:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392879AbgJTJb7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 05:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391734AbgJTJb7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 05:31:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA43DC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Oct 2020 02:31:57 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 188so979051qkk.12
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Oct 2020 02:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Bqj2Is3fOgVRtcZghaJ7s5OkS/JdmoI7QQ3yPD8O0X8=;
        b=U9TMN8LKF2Qupbo68JKXW1goa5mYdMwfUnpsVZvgW5e7EBWQL76hL1m9y7NipzIF2z
         j3F8DRPDmpZwXGNp3dJErgkZPPIuEV3feQSgbnqnkYOID4mf1OzG4KQ2rQADlrnpj2GU
         KY8bEb/jknXdwQck59cpbCRRfep4zpT0RDZpG4kRckfKBSxCZAbbk1WecB6LuFK7SgdH
         qTPYjhXslURPNSCxHCzJJP8IR0i5XlUPshDf1fVJgw+/XcC48clPlSMwQn6t2bVWzvrY
         Tz+jzg0zogobWWRDtSwB5FXk1tyHHG4vTUo9bmoOf4ezxAkLCAQbo0Gl11OkMe7h0Nkq
         1EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Bqj2Is3fOgVRtcZghaJ7s5OkS/JdmoI7QQ3yPD8O0X8=;
        b=NLyjETSy0CoB6IY3K00SUL8IP/4v5ecj1sliCUuj5Vn4Y6xUAYsev9SUDgpChTmr2O
         12lb0OABvyObW9llhEphK2NJ7EUIx1hWeYU4Hrpq0mekZUosX9FdM0Dlmxwqimn3Gua0
         gXz7X1ehGUluW4bApv7ZCxGRoM09XvNaIMojzaUH5VAqKsGKl1xHCQu9bFSLR2XMjXsg
         6GOSxdD/Fi1HkUEfqCqg5hbjvGgnTkFrb/reuAkbNa//pd67XeMZjLPyZh1Wc1P/bFlG
         QaxgppZHf1sUR3Yen2CrdEGdhLWao9I/Q1jUHQyQEwRWAxAAxIfR1vHAgpDA3hbiz+g4
         vVcw==
X-Gm-Message-State: AOAM533xAqOMAt2upBDv+mcnM+UItUJ3cbgiS/mFAEbnx4VEX8ZwWi3Z
        j0M/D3JWQ4Xn2rm46Kl/EqN7uCl2YS59og0NFdJiMjOSxvo=
X-Google-Smtp-Source: ABdhPJyEnqoJyzIAjunZpss9FRqC9j5yhHL0JG8twmZB4FoXhChYBAV3AHP1CA6VQf+rsnxZ/TKS60KkayQV2uju9gk=
X-Received: by 2002:ae9:f444:: with SMTP id z4mr1766049qkl.338.1603186316999;
 Tue, 20 Oct 2020 02:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603137558.git.josef@toxicpanda.com> <f0fc7512506f008dd356cffe49a17990199ff6f4.1603137558.git.josef@toxicpanda.com>
In-Reply-To: <f0fc7512506f008dd356cffe49a17990199ff6f4.1603137558.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 20 Oct 2020 10:31:45 +0100
Message-ID: <CAL3q7H5N1TStBRGzz1Ky6zNDXbLsHuH0KOF1gvsfoCgXsxgGoQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: drop the path before adding qgroup items when
 enabling qgroups
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 20, 2020 at 8:37 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> When enabling qgroups we walk the tree_root and then add a qgroup item
> for every root that we have.  This creates a lock dependency on the
> tree_root and qgroup_root, which results in the following lockdep splat
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 5.9.0-default+ #1299 Not tainted
> ------------------------------------------------------
> btrfs/24552 is trying to acquire lock:
> ffff9142dfc5f630 (btrfs-quota-00){++++}-{3:3}, at: __btrfs_tree_read_lock=
+0x35/0x1c0 [btrfs]
>
> but task is already holding lock:
> ffff9142dfc5d0b0 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock+=
0x35/0x1c0 [btrfs]
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (btrfs-root-00){++++}-{3:3}:
>        __lock_acquire+0x3fb/0x730
>        lock_acquire.part.0+0x6a/0x130
>        down_read_nested+0x46/0x130
>        __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
>        __btrfs_read_lock_root_node+0x3a/0x50 [btrfs]
>        btrfs_search_slot_get_root+0x11d/0x290 [btrfs]
>        btrfs_search_slot+0xc3/0x9f0 [btrfs]
>        btrfs_insert_item+0x6e/0x140 [btrfs]
>        btrfs_create_tree+0x1cb/0x240 [btrfs]
>        btrfs_quota_enable+0xcd/0x790 [btrfs]
>        btrfs_ioctl_quota_ctl+0xc9/0xe0 [btrfs]
>        __x64_sys_ioctl+0x83/0xa0
>        do_syscall_64+0x2d/0x70
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> -> #0 (btrfs-quota-00){++++}-{3:3}:
>        check_prev_add+0x91/0xc30
>        validate_chain+0x491/0x750
>        __lock_acquire+0x3fb/0x730
>        lock_acquire.part.0+0x6a/0x130
>        down_read_nested+0x46/0x130
>        __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
>        __btrfs_read_lock_root_node+0x3a/0x50 [btrfs]
>        btrfs_search_slot_get_root+0x11d/0x290 [btrfs]
>        btrfs_search_slot+0xc3/0x9f0 [btrfs]
>        btrfs_insert_empty_items+0x58/0xa0 [btrfs]
>        add_qgroup_item.part.0+0x72/0x210 [btrfs]
>        btrfs_quota_enable+0x3bb/0x790 [btrfs]
>        btrfs_ioctl_quota_ctl+0xc9/0xe0 [btrfs]
>        __x64_sys_ioctl+0x83/0xa0
>        do_syscall_64+0x2d/0x70
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(btrfs-root-00);
>                                lock(btrfs-quota-00);
>                                lock(btrfs-root-00);
>   lock(btrfs-quota-00);
>
>  *** DEADLOCK ***
>
> 5 locks held by btrfs/24552:
>  #0: ffff9142df431478 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write_fil=
e+0x22/0xa0
>  #1: ffff9142f9b10cc0 (&fs_info->subvol_sem){++++}-{3:3}, at: btrfs_ioctl=
_quota_ctl+0x7b/0xe0 [btrfs]
>  #2: ffff9142f9b11a08 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}, at: btrf=
s_quota_enable+0x3b/0x790 [btrfs]
>  #3: ffff9142df431698 (sb_internal#2){.+.+}-{0:0}, at: start_transaction+=
0x406/0x510 [btrfs]
>  #4: ffff9142dfc5d0b0 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_=
lock+0x35/0x1c0 [btrfs]
>
> stack backtrace:
> CPU: 1 PID: 24552 Comm: btrfs Not tainted 5.9.0-default+ #1299
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59=
-gc9ba527-rebuilt.opensuse.org 04/01/2014
> Call Trace:
>  dump_stack+0x77/0x97
>  check_noncircular+0xf3/0x110
>  check_prev_add+0x91/0xc30
>  validate_chain+0x491/0x750
>  __lock_acquire+0x3fb/0x730
>  lock_acquire.part.0+0x6a/0x130
>  ? __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
>  ? lock_acquire+0xc4/0x140
>  ? __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
>  down_read_nested+0x46/0x130
>  ? __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
>  __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
>  ? btrfs_root_node+0xd9/0x200 [btrfs]
>  __btrfs_read_lock_root_node+0x3a/0x50 [btrfs]
>  btrfs_search_slot_get_root+0x11d/0x290 [btrfs]
>  btrfs_search_slot+0xc3/0x9f0 [btrfs]
>  btrfs_insert_empty_items+0x58/0xa0 [btrfs]
>  add_qgroup_item.part.0+0x72/0x210 [btrfs]
>  btrfs_quota_enable+0x3bb/0x790 [btrfs]
>  btrfs_ioctl_quota_ctl+0xc9/0xe0 [btrfs]
>  __x64_sys_ioctl+0x83/0xa0
>  do_syscall_64+0x2d/0x70
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Fix this by dropping the path whenever we find a root item, add the
> qgroup item, and then re-lookup the root item we found and continue
> processing roots.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/qgroup.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 580899bdb991..573a555b51d8 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1026,6 +1026,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_inf=
o)
>                 btrfs_item_key_to_cpu(leaf, &found_key, slot);
>
>                 if (found_key.type =3D=3D BTRFS_ROOT_REF_KEY) {
> +                       btrfs_release_path(path);
> +
>                         ret =3D add_qgroup_item(trans, quota_root,
>                                               found_key.offset);
>                         if (ret) {
> @@ -1044,6 +1046,20 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_in=
fo)
>                                 btrfs_abort_transaction(trans, ret);
>                                 goto out_free_path;
>                         }
> +                       ret =3D btrfs_search_slot_for_read(tree_root, &fo=
und_key,
> +                                                        path, 1, 0);
> +                       if (ret < 0) {
> +                               btrfs_abort_transaction(trans, ret);
> +                               goto out_free_path;
> +                       }
> +                       if (ret > 0) {
> +                               /*
> +                                * Shouldn't happen, but in case it does =
we
> +                                * don't need to do the btrfs_next_item, =
just
> +                                * continue.
> +                                */
> +                               continue;
> +                       }
>                 }
>                 ret =3D btrfs_next_item(tree_root, path);
>                 if (ret < 0) {
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
