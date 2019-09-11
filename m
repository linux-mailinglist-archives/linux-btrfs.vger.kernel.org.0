Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4787BAFAD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 12:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfIKKxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 06:53:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:49704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbfIKKxH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 06:53:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A577AF23;
        Wed, 11 Sep 2019 10:53:02 +0000 (UTC)
Subject: Re: Mount/df/PAM login hangs during rsync to btrfs subvolume, or
 maybe doing btrfs subvolume snapshot
To:     David Newall <btrfs@davidnewall.com>, linux-btrfs@vger.kernel.org
References: <c00dfaf7-81a4-5e79-6279-b4af53f7f928@davidnewall.com>
 <1a651f17-ba40-2f17-403e-69999e927b2d@suse.com>
 <cfc872b2-ea1e-57b4-f548-48679daad069@davidnewall.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <133d5657-a045-ad53-31f0-75714d983255@suse.com>
Date:   Wed, 11 Sep 2019 13:52:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cfc872b2-ea1e-57b4-f548-48679daad069@davidnewall.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.09.19 г. 13:21 ч., David Newall wrote:
>> echo w > /proc/sysrq-trigger
> 
> Interesting.
> 
> One material point which I failed to mention is that the btrfs volume is
> on an encrypted volume (cryptsetup luksOpen /dev/vdc backups).
> 
> The first step, "mount -r /dev/vg/ext2fs-snapshot
> /btrfs-backup-volume/local-snapshot", seemed to trigger the problem. 
> When I did the echo to sysrq-trigger, it seemed to stop blocking, but
> that might have been a coincidence.  After the echo, kernel output
> exceeded 100KB, so I saved it to https://davidnewall.com/kern.1

Nothing useful in that log, everything seems normal. 

> 
> During rsync (--archive --one-file-system --hard-links --inplace
> --numeric-ids --delete /btrfs-backup-volume/local-snapshot/
> /btrfs-backup-volume/data/), initially there was no problem, but, then
> it (df) seemed to hang again.  The rsync took a long time to complete,
> and before it did finish, I did the echo to sysrq-trigger again; kernel
> output is saved to https://davidnewall.com/kern.2

Same thing here

> 
> The rsync finished not long after the echo to sysrq-trigger, but that's
> probably also a coincidence.  After rsync completed, df still hung.  I
> did another echo to sysrq-trigger, and saved kernel output to
> https://davidnewall.com/kern.3

So here it seems df is blocked inside btrfs_show_devname trying to acquire device_list_mutex:

Sep 11 19:24:11 crowies kernel: [1109983.104578] Call Trace:
Sep 11 19:24:11 crowies kernel: [1109983.104580]  [<ffffffff81860625>] schedule+0x35/0x80
Sep 11 19:24:11 crowies kernel: [1109983.104582]  [<ffffffff8186097e>] schedule_preempt_disabled+0xe/0x10
Sep 11 19:24:11 crowies kernel: [1109983.104584]  [<ffffffff81862817>] __mutex_lock_slowpath+0xb7/0x130
Sep 11 19:24:11 crowies kernel: [1109983.104586]  [<ffffffff818628af>] mutex_lock+0x1f/0x30
Sep 11 19:24:11 crowies kernel: [1109983.104599]  [<ffffffffc01a0edb>] btrfs_show_devname+0x2b/0xe0 [btrfs]
Sep 11 19:24:11 crowies kernel: [1109983.104603]  [<ffffffff81261547>] show_mountinfo+0x1b7/0x2a0
Sep 11 19:24:11 crowies kernel: [1109983.104608]  [<ffffffff8123d25d>] m_show+0x1d/0x20
Sep 11 19:24:11 crowies kernel: [1109983.104611]  [<ffffffff81242af0>] seq_read+0x300/0x3d0
Sep 11 19:24:11 crowies kernel: [1109983.104614]  [<ffffffff8121d1eb>] __vfs_read+0x1b/0x40
Sep 11 19:24:11 crowies kernel: [1109983.104616]  [<ffffffff8121d966>] vfs_read+0x86/0x130
Sep 11 19:24:11 crowies kernel: [1109983.104618]  [<ffffffff8121e6bc>] SyS_read+0x5c/0xe0
Sep 11 19:24:11 crowies kernel: [1109983.104623]  [<ffffffff8106f0a7>] ? trace_do_page_fault+0x37/0xe0
Sep 11 19:24:11 crowies kernel: [1109983.104625]  [<ffffffff81864f9b>] entry_SYSCALL_64_fastpath+0x22/0xcb

Looking at the other threads transaction commit is writing the superblocks
to the underlying storage: 

Sep 11 19:24:11 crowies kernel: [1109983.104414]  [<ffffffff818600e1>] ? __schedule+0x301/0x810
Sep 11 19:24:11 crowies kernel: [1109983.104417]  [<ffffffff81860625>] schedule+0x35/0x80
Sep 11 19:24:11 crowies kernel: [1109983.104419]  [<ffffffff81863be4>] schedule_timeout+0x1b4/0x270
Sep 11 19:24:11 crowies kernel: [1109983.104421]  [<ffffffff81860121>] ? __schedule+0x341/0x810
Sep 11 19:24:11 crowies kernel: [1109983.104424]  [<ffffffff81861132>] wait_for_completion+0xb2/0x190
Sep 11 19:24:11 crowies kernel: [1109983.104429]  [<ffffffff810b34a0>] ? wake_up_q+0x70/0x70
Sep 11 19:24:11 crowies kernel: [1109983.104485]  [<ffffffffc01ce557>] write_all_supers.isra.43+0x977/0xb10 [btrfs]
Sep 11 19:24:11 crowies kernel: [1109983.104501]  [<ffffffffc01cf7b7>] write_ctree_super+0x17/0x20 [btrfs]
Sep 11 19:24:11 crowies kernel: [1109983.104517]  [<ffffffffc01d658a>] btrfs_commit_transaction+0x7fa/0xb10 [btrfs]
Sep 11 19:24:11 crowies kernel: [1109983.104532]  [<ffffffffc01d13c8>] transaction_kthread+0x1c8/0x230 [btrfs]
Sep 11 19:24:11 crowies kernel: [1109983.104548]  [<ffffffffc01d1200>] ? btrfs_cleanup_transaction+0x570/0x570 [btrfs]
Sep 11 19:24:11 crowies kernel: [1109983.104553]  [<ffffffff810a7707>] kthread+0xe7/0x100
Sep 11 19:24:11 crowies kernel: [1109983.104555]  [<ffffffff818600e1>] ? __schedule+0x301/0x810
Sep 11 19:24:11 crowies kernel: [1109983.104557]  [<ffffffff810a7620>] ? kthread_create_on_node+0x1e0/0x1e0
Sep 11 19:24:11 crowies kernel: [1109983.104560]  [<ffffffff81865425>] ret_from_fork+0x55/0x80
Sep 11 19:24:11 crowies kernel: [1109983.104562]  [<ffffffff810a7620>] ? kthread_create_on_node+0x1e0/0x1e0

And it's waiting for that write to complete, under device_list_mutex. From my POV it
seems you have slow storage and df is blocked while transaction commit is finished, in 
particular, the last phase of transaction commit - writing the superblocks. 


At this point I don't see anything which would suggest foul play. Newer kernels have changed
the locking in btrfs_show_devname and it takes an RCU rather than device_list_mutex. Also 
4.4.0-159 is ubuntu's own kernel and 4.4 is rather old at this stage. The only remediation I could
suggest is to upgrade your kernel either via ubuntu's HWE or compiling one on your own. 


> 
> I tried a minor change in procedure to see if it would bring the system
> back to normal response.  Normally I'd do "btrfs subvolume snapshot",
> but I tried unmounting the lvm2 snapshot first (umount
> /btrfs-backup-volume/local-snapshot).  It did not complete within the
> expected time, and another echo to sysrq-trigger resulted in
> https://davidnewall.com/kern.4
> 
> Eventually the umount completed and system came back to normal response.
> 
> I did the btrfs subvolume snapshot, and it completed faster than I could
> notice without causing any issues.
> 
> After unmounting the btrfs volume, I tried each step again, and
> everything completed within expected times without causing any hang.
> 
> Something which I did previously mention, but I'll repeat because it
> might well be important, is that the base ext2 filesystem is on a
> drbd-replicated volume.  I don't know if it's part of the problem, and I
> observe that the hang condition was not triggered at the point of
> creating the lvm2 snapshot.
> 
> I greatly appreciate your advice and help.
> 
> Thanks,
> 
> David
> 
> 
