Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB7F3404AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 12:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhCRLd3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 07:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229664AbhCRLdN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 07:33:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F2CC64F24
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Mar 2021 11:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616067192;
        bh=9zHCEUodkCA46XsLl+RhwzoC83Qb8jZX3YUHvCVgU7M=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=EnEbZhJhr8qSs+HOzNMcrR8KokF7lPGKfqbKqSJa7x6ikR+gcDa5LOM3TFkNyKsv6
         YltxGzdHdaWhJeqgG/eBYEnxjrCg7GBMjmj4dd4k8U0yTEv+LrOUXqXb6V8bGJEoYW
         0tvQsReSoNhQTFlKJuvjKC08yvvitSoujal5gePsL3epwSAq6GhcfFdQ113zVGTXPi
         ra1CpsJie2I96OaYy6EThmA/iAxk4P1W9kMngZDHqXWppZPIveqmbtu/4LCTry1VPp
         Ws+Ss6Efkw7IF7HooPl3xyV6GkobBPnIRSkVwXVJcKW/jCpGm0qE1YzmlGx8kv+eGV
         RKomPZQT5YVdA==
Received: by mail-qk1-f175.google.com with SMTP id x10so1561065qkm.8
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Mar 2021 04:33:12 -0700 (PDT)
X-Gm-Message-State: AOAM532Qk6TEa25cyXy4eSaaRUlsmhKLRd/GbkODhvFxC69byGeenpdd
        BSQ37BkH1gzAgfF2HD+YGU1i01XegaC4YCLGRjk=
X-Google-Smtp-Source: ABdhPJx3SU8lP9TfT86IKeSMuB9GrnTS4cnQnIa+lfAeJ74xA1OxXSCzoUxelWXgPvWH900yOJotbtkbrnS5cT/pV6k=
X-Received: by 2002:a05:620a:119a:: with SMTP id b26mr3851613qkk.438.1616067191547;
 Thu, 18 Mar 2021 04:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <206d121e2e2b609ffe31217e6d90bfabe1c4e121.1616066404.git.fdmanana@suse.com>
In-Reply-To: <206d121e2e2b609ffe31217e6d90bfabe1c4e121.1616066404.git.fdmanana@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 18 Mar 2021 11:33:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4DEuA8zMtBAdAc=eYYpRYF=2k4h=_P1+G2_eoMDuzPjQ@mail.gmail.com>
Message-ID: <CAL3q7H4DEuA8zMtBAdAc=eYYpRYF=2k4h=_P1+G2_eoMDuzPjQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix sleep while in non-sleep context during qgroup removal
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 18, 2021 at 11:25 AM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> While removing a qgroup's sysfs entry we end up taking the kernfs_mutex,
> through kobject_del(), while holding the fs_info->qgroup_lock spinlock,
> producing the following trace:
>
> [  821.843637] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:281
> [  821.843641] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 28214, name: podman
> [  821.843644] CPU: 3 PID: 28214 Comm: podman Tainted: G        W         5.11.6 #15
> [  821.843646] Hardware name: Dell Inc. PowerEdge R330/084XW4, BIOS 2.11.0 12/08/2020
> [  821.843647] Call Trace:
> [  821.843650]  dump_stack+0xa1/0xfb
> [  821.843656]  ___might_sleep+0x144/0x160
> [  821.843659]  mutex_lock+0x17/0x40
> [  821.843662]  kernfs_remove_by_name_ns+0x1f/0x80
> [  821.843666]  sysfs_remove_group+0x7d/0xe0
> [  821.843668]  sysfs_remove_groups+0x28/0x40
> [  821.843670]  kobject_del+0x2a/0x80
> [  821.843672]  btrfs_sysfs_del_one_qgroup+0x2b/0x40 [btrfs]
> [  821.843685]  __del_qgroup_rb+0x12/0x150 [btrfs]
> [  821.843696]  btrfs_remove_qgroup+0x288/0x2a0 [btrfs]
> [  821.843707]  btrfs_ioctl+0x3129/0x36a0 [btrfs]
> [  821.843717]  ? __mod_lruvec_page_state+0x5e/0xb0
> [  821.843719]  ? page_add_new_anon_rmap+0xbc/0x150
> [  821.843723]  ? kfree+0x1b4/0x300
> [  821.843725]  ? mntput_no_expire+0x55/0x330
> [  821.843728]  __x64_sys_ioctl+0x5a/0xa0
> [  821.843731]  do_syscall_64+0x33/0x70
> [  821.843733]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  821.843736] RIP: 0033:0x4cd3fb
> [  821.843739] Code: fa ff eb bd e8 86 8b fa ff e9 61 ff ff ff cc e8 fb 55 fa ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
> [  821.843741] RSP: 002b:000000c000906b20 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> [  821.843744] RAX: ffffffffffffffda RBX: 000000c000050000 RCX: 00000000004cd3fb
> [  821.843745] RDX: 000000c000906b98 RSI: 000000004010942a RDI: 000000000000000f
> [  821.843747] RBP: 000000c000907cd0 R08: 000000c000622901 R09: 0000000000000000
> [  821.843748] R10: 000000c000d992c0 R11: 0000000000000206 R12: 000000000000012d
> [  821.843749] R13: 000000000000012c R14: 0000000000000200 R15: 0000000000000049
>
> Fix this by removing the qgroup sysfs entry while not holding the spinlock,
> since the spinlock is only meant for protection of the qgroup rbtree.
>
> Reported-by: Stuart Shelton <srcshelton@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/7A5485BB-0628-419D-A4D3-27B1AF47E25A@gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Missed:

Fixes: 49e5fb46211de0 ("btrfs: qgroup: export qgroups in sysfs")

> ---
>  fs/btrfs/qgroup.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9d8d1ac86962..2319c923c9e6 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -227,7 +227,6 @@ static void __del_qgroup_rb(struct btrfs_fs_info *fs_info,
>  {
>         struct btrfs_qgroup_list *list;
>
> -       btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
>         list_del(&qgroup->dirty);
>         while (!list_empty(&qgroup->groups)) {
>                 list = list_first_entry(&qgroup->groups,
> @@ -244,7 +243,6 @@ static void __del_qgroup_rb(struct btrfs_fs_info *fs_info,
>                 list_del(&list->next_member);
>                 kfree(list);
>         }
> -       kfree(qgroup);
>  }
>
>  /* must be called with qgroup_lock held */
> @@ -570,6 +568,8 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
>                 qgroup = rb_entry(n, struct btrfs_qgroup, node);
>                 rb_erase(n, &fs_info->qgroup_tree);
>                 __del_qgroup_rb(fs_info, qgroup);
> +               btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
> +               kfree(qgroup);
>         }
>         /*
>          * We call btrfs_free_qgroup_config() when unmounting
> @@ -1579,6 +1579,14 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>         spin_lock(&fs_info->qgroup_lock);
>         del_qgroup_rb(fs_info, qgroupid);
>         spin_unlock(&fs_info->qgroup_lock);
> +
> +       /*
> +        * Remove the qgroup from sysfs now without holding the qgroup_lock
> +        * spinlock, since the sysfs_remove_group() function needs to take
> +        * the mutex kernfs_mutex through kernfs_remove_by_name_ns().
> +        */
> +       btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
> +       kfree(qgroup);
>  out:
>         mutex_unlock(&fs_info->qgroup_ioctl_lock);
>         return ret;
> --
> 2.28.0
>
