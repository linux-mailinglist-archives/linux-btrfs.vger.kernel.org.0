Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3D3EA30C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 12:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhHLKmL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 06:42:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41704 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhHLKmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 06:42:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A46AD22268;
        Thu, 12 Aug 2021 10:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628764904;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WLaDCGpLgaD0uedP6SFyCk6Ki6nEduqBk8ElNDyTxhQ=;
        b=J6twbbsaOTo7Lkl3c0ZHTYlP3y6pBfORenklXCr/1RZsljM3NkkI2KihowQqTW2F+UCRy1
        fSRMa6c2CHIi2QfvSr8TVeowE+1CAmvvBZfJqdOr9EXq/e/iO1irNN8WsCNqC3VLxhdTKH
        Xakx8oGZSdFdK2UU4mLmrhv04jny0v4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628764904;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WLaDCGpLgaD0uedP6SFyCk6Ki6nEduqBk8ElNDyTxhQ=;
        b=GWCVhMT+df21pSNaxBg2B9NW00p3GClvwR6jmNgBi9ETh0pyV54RSk7OSpTwE33o5bI8pw
        t9mNi0/gU/m8e5Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 81987A3ED3;
        Thu, 12 Aug 2021 10:41:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35D2FDA733; Thu, 12 Aug 2021 12:38:51 +0200 (CEST)
Date:   Thu, 12 Aug 2021 12:38:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        anand.jain@oracle.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] btrfs: fix rw device counting in
 __btrfs_free_extra_devids
Message-ID: <20210812103851.GC5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
References: <20210727071303.113876-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727071303.113876-1-desmondcheongzx@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 03:13:03PM +0800, Desmond Cheong Zhi Xi wrote:
> When removing a writeable device in __btrfs_free_extra_devids, the rw
> device count should be decremented.
> 
> This error was caught by Syzbot which reported a warning in
> close_fs_devices because fs_devices->rw_devices was not 0 after
> closing all devices. Here is the call trace that was observed:
> 
>   btrfs_mount_root():
>     btrfs_scan_one_device():
>       device_list_add();   <---------------- device added
>     btrfs_open_devices():
>       open_fs_devices():
>         btrfs_open_one_device();   <-------- writable device opened,
> 	                                     rw device count ++
>     btrfs_fill_super():
>       open_ctree():
>         btrfs_free_extra_devids():
> 	  __btrfs_free_extra_devids();  <--- writable device removed,
> 	                              rw device count not decremented
> 	  fail_tree_roots:
> 	    btrfs_close_devices():
> 	      close_fs_devices();   <------- rw device count off by 1
> 
> As a note, prior to commit cf89af146b7e ("btrfs: dev-replace: fail
> mount if we don't have replace item with target device"), rw_devices
> was decremented on removing a writable device in
> __btrfs_free_extra_devids only if the BTRFS_DEV_STATE_REPLACE_TGT bit
> was not set for the device. However, this check does not need to be
> reinstated as it is now redundant and incorrect.
> 
> In __btrfs_free_extra_devids, we skip removing the device if it is the
> target for replacement. This is done by checking whether device->devid
> == BTRFS_DEV_REPLACE_DEVID. Since BTRFS_DEV_STATE_REPLACE_TGT is set
> only on the device with devid BTRFS_DEV_REPLACE_DEVID, no devices
> should have the BTRFS_DEV_STATE_REPLACE_TGT bit set after the check,
> and so it's redundant to test for that bit.
> 
> Additionally, following commit 82372bc816d7 ("Btrfs: make
> the logic of source device removing more clear"), rw_devices is
> incremented whenever a writeable device is added to the alloc
> list (including the target device in btrfs_dev_replace_finishing), so
> all removals of writable devices from the alloc list should also be
> accompanied by a decrement to rw_devices.
> 
> Fixes: cf89af146b7e ("btrfs: dev-replace: fail mount if we don't have replace item with target device")
> Reported-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
> Tested-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 807502cd6510..916c25371658 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1078,6 +1078,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>  		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>  			list_del_init(&device->dev_alloc_list);
>  			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> +			fs_devices->rw_devices--;
>  		}
>  		list_del_init(&device->dev_list);
>  		fs_devices->num_devices--;

I've hit a crash on master branch with stacktrace very similar to one
this bug was supposed to fix. It's a failed assertion on device close.
This patch was the last one to touch it and it matches some of the
keywords, namely the BTRFS_DEV_STATE_REPLACE_TGT bit that used to be in
the original patch but was not reinstated in your fix.

I'm not sure how reproducible it is, right now I have only one instance
and am hunting another strange problem. They could be related.

assertion failed: !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state), in fs/btrfs/volumes.c:1150

https://susepaste.org/view/raw/18223056 full log with other stacktraces,
possibly relatedg

[ 3310.383268] kernel BUG at fs/btrfs/ctree.h:3431!
[ 3310.384586] invalid opcode: 0000 [#1] PREEMPT SMP
[ 3310.385848] CPU: 1 PID: 3982 Comm: umount Tainted: G        W         5.14.0-rc5-default+ #1532
[ 3310.388216] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 3310.391054] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
[ 3310.397628] RSP: 0018:ffffb7a5454c7db8 EFLAGS: 00010246
[ 3310.399079] RAX: 0000000000000068 RBX: ffff978364b91c00 RCX: 0000000000000000
[ 3310.400990] RDX: 0000000000000000 RSI: ffffffffabee13c4 RDI: 00000000ffffffff
[ 3310.402504] RBP: ffff9783523a4c00 R08: 0000000000000001 R09: 0000000000000001
[ 3310.404025] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9783523a4d18
[ 3310.405074] R13: 0000000000000000 R14: 0000000000000004 R15: 0000000000000003
[ 3310.406130] FS:  00007f61c8f42800(0000) GS:ffff9783bd800000(0000) knlGS:0000000000000000
[ 3310.407649] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3310.409022] CR2: 000056190cffa810 CR3: 0000000030b96002 CR4: 0000000000170ea0
[ 3310.410111] Call Trace:
[ 3310.410561]  btrfs_close_one_device.cold+0x11/0x55 [btrfs]
[ 3310.411788]  close_fs_devices+0x44/0xb0 [btrfs]
[ 3310.412654]  btrfs_close_devices+0x48/0x160 [btrfs]
[ 3310.413449]  generic_shutdown_super+0x69/0x100
[ 3310.414155]  kill_anon_super+0x14/0x30
[ 3310.414802]  btrfs_kill_super+0x12/0x20 [btrfs]
[ 3310.415767]  deactivate_locked_super+0x2c/0xa0
[ 3310.416562]  cleanup_mnt+0x144/0x1b0
[ 3310.417153]  task_work_run+0x59/0xa0
[ 3310.417744]  exit_to_user_mode_loop+0xe7/0xf0
[ 3310.418440]  exit_to_user_mode_prepare+0xaf/0xf0
[ 3310.419425]  syscall_exit_to_user_mode+0x19/0x50
[ 3310.420281]  do_syscall_64+0x4a/0x90
[ 3310.420934]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 3310.421718] RIP: 0033:0x7f61c91654db
