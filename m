Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78071B7B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 16:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfEMOE1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 10:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbfEMOE1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 10:04:27 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA6BC21019
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 14:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557756266;
        bh=W9bVmywEtKfoBTydCBYLM1ordxXwdloe4TaDdD1M44w=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=JexnKV+ahaF+8AG6C78CXKIReMErRxaZwNvRm6filWJ28RoJwk973rG1zv/3aoyct
         EYK/OUckrglLwTLlZr7LL0SApjbs3bHkTHOyYYYb4n1rvTr5aRVaFlMr1VVY9WM7im
         2716xYxTz4qprsg9ie1eCQA5jNntWBi7OQGM+4Wg=
Received: by mail-ua1-f49.google.com with SMTP id g16so4845048uad.2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 07:04:25 -0700 (PDT)
X-Gm-Message-State: APjAAAWnrqpdjqbfeJM9kuWqvbOKdPiwJ5xwja0CZdp9+SXwQO6NNc9e
        bZ2HJf46ywiW83NuuJAy91+55zXXnltAEVVV/YM=
X-Google-Smtp-Source: APXvYqwmJyfMlHOYbEZgzT6sR/zirFDMjWHTrfsxLhOsT87TNLj4Pb2bjHQNSl5JCqoh52ihze11NBMYOO59p2KMJLM=
X-Received: by 2002:a9f:326e:: with SMTP id y43mr12934601uad.83.1557756264524;
 Mon, 13 May 2019 07:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190422154409.16323-1-fdmanana@kernel.org>
In-Reply-To: <20190422154409.16323-1-fdmanana@kernel.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 13 May 2019 15:04:13 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4nrAJSwXoX9c5LX2oFb-CFdHQ-enMON3ZqgNWoRqP33g@mail.gmail.com>
Message-ID: <CAL3q7H4nrAJSwXoX9c5LX2oFb-CFdHQ-enMON3ZqgNWoRqP33g@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: prevent send failures and crashes due to
 concurrent relocation
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 22, 2019 at 4:52 PM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> Send always operates on read-only trees and always expected that while it
> is in progress, nothing changes in those trees. Due to that expectation
> and the fact that send is a read-only operation, it operates on commit
> roots and does not hold transaction handles. However relocation can COW
> nodes and leafs from read-only trees, which can cause unexpected failures
> and crashes (hitting BUG_ONs). while send using a node/leaf, it gets
> COWed, the transaction used to COW it is committed, a new transaction
> starts, the extent previously used for that node/leaf gets allocated,
> possibly for another tree, and the respective extent buffer' content
> changes while send is still using it. When this happens send normally
> fails with EIO being returned to user space and messages like the
> following are found in dmesg/syslog:
>
>   [ 3408.699121] BTRFS error (device sdc): parent transid verify failed on 58703872 wanted 250 found 253
>   [ 3441.523123] BTRFS error (device sdc): did not find backref in send_root. inode=63211, offset=0, disk_byte=5222825984 found extent=5222825984
>
> Other times, less often, we hit a BUG_ON() because an extent buffer that
> send is using used to be a node, and while send is still using it, it
> got COWed and got reused as a leaf while send is still using, producing
> the following trace:
>
>  [ 3478.466280] ------------[ cut here ]------------
>  [ 3478.466282] kernel BUG at fs/btrfs/ctree.c:1806!
>  [ 3478.466965] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
>  [ 3478.467635] CPU: 0 PID: 2165 Comm: btrfs Not tainted 5.0.0-btrfs-next-46 #1
>  [ 3478.468311] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
>  [ 3478.469681] RIP: 0010:read_node_slot+0x122/0x130 [btrfs]
>  (...)
>  [ 3478.471758] RSP: 0018:ffffa437826bfaa0 EFLAGS: 00010246
>  [ 3478.472457] RAX: ffff961416ed7000 RBX: 000000000000003d RCX: 0000000000000002
>  [ 3478.473151] RDX: 000000000000003d RSI: ffff96141e387408 RDI: ffff961599b30000
>  [ 3478.473837] RBP: ffffa437826bfb8e R08: 0000000000000001 R09: ffffa437826bfb8e
>  [ 3478.474515] R10: ffffa437826bfa70 R11: 0000000000000000 R12: ffff9614385c8708
>  [ 3478.475186] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  [ 3478.475840] FS:  00007f8e0e9cc8c0(0000) GS:ffff9615b6a00000(0000) knlGS:0000000000000000
>  [ 3478.476489] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  [ 3478.477127] CR2: 00007f98b67a056e CR3: 0000000005df6005 CR4: 00000000003606f0
>  [ 3478.477762] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  [ 3478.478385] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  [ 3478.479003] Call Trace:
>  [ 3478.479600]  ? do_raw_spin_unlock+0x49/0xc0
>  [ 3478.480202]  tree_advance+0x173/0x1d0 [btrfs]
>  [ 3478.480810]  btrfs_compare_trees+0x30c/0x690 [btrfs]
>  [ 3478.481388]  ? process_extent+0x1280/0x1280 [btrfs]
>  [ 3478.481954]  btrfs_ioctl_send+0x1037/0x1270 [btrfs]
>  [ 3478.482510]  _btrfs_ioctl_send+0x80/0x110 [btrfs]
>  [ 3478.483062]  btrfs_ioctl+0x13fe/0x3120 [btrfs]
>  [ 3478.483581]  ? rq_clock_task+0x2e/0x60
>  [ 3478.484086]  ? wake_up_new_task+0x1f3/0x370
>  [ 3478.484582]  ? do_vfs_ioctl+0xa2/0x6f0
>  [ 3478.485075]  ? btrfs_ioctl_get_supported_features+0x30/0x30 [btrfs]
>  [ 3478.485552]  do_vfs_ioctl+0xa2/0x6f0
>  [ 3478.486016]  ? __fget+0x113/0x200
>  [ 3478.486467]  ksys_ioctl+0x70/0x80
>  [ 3478.486911]  __x64_sys_ioctl+0x16/0x20
>  [ 3478.487337]  do_syscall_64+0x60/0x1b0
>  [ 3478.487751]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>  [ 3478.488159] RIP: 0033:0x7f8e0d7d4dd7
>  (...)
>  [ 3478.489349] RSP: 002b:00007ffcf6fb4908 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
>  [ 3478.489742] RAX: ffffffffffffffda RBX: 0000000000000105 RCX: 00007f8e0d7d4dd7
>  [ 3478.490142] RDX: 00007ffcf6fb4990 RSI: 0000000040489426 RDI: 0000000000000005
>  [ 3478.490548] RBP: 0000000000000005 R08: 00007f8e0d6f3700 R09: 00007f8e0d6f3700
>  [ 3478.490953] R10: 00007f8e0d6f39d0 R11: 0000000000000202 R12: 0000000000000005
>  [ 3478.491343] R13: 00005624e0780020 R14: 0000000000000000 R15: 0000000000000001
>  (...)
>  [ 3478.493352] ---[ end trace d5f537302be4f8c8 ]---
>
> Another possibility, much less likely to happen, is that send will not
> fail but the contents of the stream it produces may not be correct.
>
> To avoid this, do not allow send and relocation (balance) to run in
> parallel. In the long term the goal is to allow for both to be able to
> run concurrently without any problems, but that will take a significant
> effort in development and testing.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

David, are you picking this for this merge window or have any other plans?

Thanks.

> ---
>  fs/btrfs/ctree.h   |  7 +++++++
>  fs/btrfs/disk-io.c |  2 ++
>  fs/btrfs/send.c    | 14 ++++++++++++++
>  fs/btrfs/volumes.c |  8 ++++++++
>  4 files changed, 31 insertions(+)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 753ff68a8e8f..e6284e353dee 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -785,6 +785,7 @@ enum {
>         /*
>          * Indicate that balance has been set up from the ioctl and is in the
>          * main phase. The fs_info::balance_ctl is initialized.
> +        * Set and cleared while holding fs_info::balance_mutex.
>          */
>         BTRFS_FS_BALANCE_RUNNING,
>
> @@ -1167,6 +1168,12 @@ struct btrfs_fs_info {
>         spinlock_t swapfile_pins_lock;
>         struct rb_root swapfile_pins;
>
> +       /*
> +        * Number of send operations in progress.
> +        * Updated while holding fs_info::balance_mutex.
> +        */
> +       int send_in_progress;
> +
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>         spinlock_t ref_verify_lock;
>         struct rb_root block_tree;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5216e7b3f9ad..4cde9a9654fe 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2785,6 +2785,8 @@ int open_ctree(struct super_block *sb,
>         spin_lock_init(&fs_info->swapfile_pins_lock);
>         fs_info->swapfile_pins = RB_ROOT;
>
> +       fs_info->send_in_progress = 0;
> +
>         ret = btrfs_alloc_stripe_hash_table(fs_info);
>         if (ret) {
>                 err = ret;
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index f91f474f14f6..5c32ac661519 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6869,9 +6869,23 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
>         if (ret)
>                 goto out;
>
> +       mutex_lock(&fs_info->balance_mutex);
> +       if (test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
> +               mutex_unlock(&fs_info->balance_mutex);
> +               btrfs_warn_rl(fs_info,
> +             "Can not run send because a balance operation is in progress");
> +               ret = -EAGAIN;
> +               goto out;
> +       }
> +       fs_info->send_in_progress++;
> +       mutex_unlock(&fs_info->balance_mutex);
> +
>         current->journal_info = BTRFS_SEND_TRANS_STUB;
>         ret = send_subvol(sctx);
>         current->journal_info = NULL;
> +       mutex_lock(&fs_info->balance_mutex);
> +       fs_info->send_in_progress--;
> +       mutex_unlock(&fs_info->balance_mutex);
>         if (ret < 0)
>                 goto out;
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index db934ceae9c1..8145b62e3912 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4203,6 +4203,14 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
>                            get_raid_name(meta_index), get_raid_name(data_index));
>         }
>
> +       if (fs_info->send_in_progress) {
> +               btrfs_warn_rl(fs_info,
> +"Can not run balance while send operations are in progress (%d in progress)",
> +                             fs_info->send_in_progress);
> +               ret = -EAGAIN;
> +               goto out;
> +       }
> +
>         ret = insert_balance_item(fs_info, bctl);
>         if (ret && ret != -EEXIST)
>                 goto out;
> --
> 2.11.0
>
