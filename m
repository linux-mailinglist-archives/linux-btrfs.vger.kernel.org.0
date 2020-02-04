Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5A7151BB8
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 14:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgBDN6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 08:58:54 -0500
Received: from mail.itouring.de ([188.40.134.68]:53586 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbgBDN6y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 08:58:54 -0500
Received: from tux.applied-asynchrony.com (p5B07E981.dip0.t-ipconnect.de [91.7.233.129])
        by mail.itouring.de (Postfix) with ESMTPSA id 1376D4160454;
        Tue,  4 Feb 2020 14:58:53 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id BCA65F01602;
        Tue,  4 Feb 2020 14:58:52 +0100 (CET)
Subject: Re: Kernels 4.15..5.5: "WARNING: CPU: 2 PID: 4150 at
 fs/fs-writeback.c:2363 __writeback_inodes_sb_nr+0xa9/0xc0"
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20190322041731.GF16651@hungrycats.org>
 <20200204050456.GB13306@hungrycats.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <65514978-506f-83fa-2c95-ee9ce3cbf5b4@applied-asynchrony.com>
Date:   Tue, 4 Feb 2020 14:58:52 +0100
MIME-Version: 1.0
In-Reply-To: <20200204050456.GB13306@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/4/20 6:04 AM, Zygo Blaxell wrote:
> On Fri, Mar 22, 2019 at 12:17:32AM -0400, Zygo Blaxell wrote:
>> When filesystems are mounted flushoncommit, I get this warning roughly
>> every 30 seconds:
>>
>> 	[ 4575.142805] WARNING: CPU: 3 PID: 4150 at fs/fs-writeback.c:2363 __writeback_inodes_sb_nr+0xa9/0xc0
>> 	[ 4575.145567] Modules linked in: crct10dif_pclmul crc32_pclmul dm_cache_smq crc32c_intel dm_cache snd_pcm ghash_clmulni_intel aesni_intel sr_mod dm_persistent_data ppdev joydev dm_bio_prison aes_x86_64 crypto_simd snd_timer dm_bufio cryptd cdrom snd glue_helper dm_mod parport_pc soundcore sg floppy parport pcspkr psmouse bochs_drm rtc_cmos ide_pci_generic piix input_leds i2c_piix4 ide_core serio_raw evbug qemu_fw_cfg evdev ip_tables x_tables ipv6 crc_ccitt autofs4
>> 	[ 4575.160021] CPU: 3 PID: 4150 Comm: btrfs-transacti Tainted: G        W         5.0.3-zb64+ #1
>> 	[ 4575.162484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> 	[ 4575.164505] RIP: 0010:__writeback_inodes_sb_nr+0xa9/0xc0
>> 	[ 4575.165809] Code: 0f b6 d2 e8 b9 f8 ff ff 48 89 ee 48 89 df e8 0e f8 ff ff 48 8b 44 24 48 65 48 33 04 25 28 00 00 00 75 0b 48 83 c4 50 5b 5d c3 <0f> 0b eb cb e8 4e e9 d6 ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00
>> 	[ 4575.171927] RSP: 0018:ffffa9cac0eabde8 EFLAGS: 00010246
>> 	[ 4575.173045] RAX: 0000000000000000 RBX: ffff9353e23af000 RCX: 0000000000000000
>> 	[ 4575.175639] RDX: 0000000000000002 RSI: 0000000000030c67 RDI: ffffa9cac0eabe30
>> 	[ 4575.177619] RBP: ffffa9cac0eabdec R08: ffffa9cac0eabdf0 R09: ffff9353f12da000
>> 	[ 4575.179736] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9353e1980000
>> 	[ 4575.181661] R13: ffff9353e1981430 R14: ffff9353f27e4260 R15: ffff9353e1981518
>> 	[ 4575.183871] FS:  0000000000000000(0000) GS:ffff9353f6800000(0000) knlGS:0000000000000000
>> 	[ 4575.185940] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> 	[ 4575.188072] CR2: 00007fb81841fa20 CR3: 00000002218c0006 CR4: 00000000001606e0
>> 	[ 4575.190094] Call Trace:
>> 	[ 4575.190828]  btrfs_commit_transaction+0x7a6/0x9e0
>> 	[ 4575.192115]  ? start_transaction+0x91/0x4d0
>> 	[ 4575.193197]  transaction_kthread+0x146/0x180
>> 	[ 4575.194415]  kthread+0x106/0x140
>> 	[ 4575.195403]  ? btrfs_cleanup_transaction+0x620/0x620
>> 	[ 4575.196903]  ? kthread_park+0x90/0x90
>> 	[ 4575.198412]  ret_from_fork+0x3a/0x50
>> 	[ 4575.199374] irq event stamp: 54922780
>> 	[ 4575.200218] hardirqs last  enabled at (54922779): [<ffffffffa3d5f2e2>] _raw_spin_unlock_irqrestore+0x32/0x60
>> 	[ 4575.202753] hardirqs last disabled at (54922780): [<ffffffffa300379f>] trace_hardirqs_off_thunk+0x1a/0x1c
>> 	[ 4575.205921] softirqs last  enabled at (54922378): [<ffffffffa40003a4>] __do_softirq+0x3a4/0x45f
>> 	[ 4575.208350] softirqs last disabled at (54922361): [<ffffffffa30a3d44>] irq_exit+0xe4/0xf0
>> 	[ 4575.210616] ---[ end trace 5309dcf3a1920eca ]---
>>
>> For my own kernel builds I just comment out the line in fs-writeback.c,
>> but that's not a real solution.
> 
> This still happens in 5.5.0.  No changes in behavior or workaround, no
> apparent harmful effect, almost 2 years running in stress-testing and
> production.
> 
> I, for one, am glad we fixed all those other bugs before doing anything
> about this one.  It is utterly harmless.

This triggered my archeology itch. I had to go deeper.

The warning goes all the way back to 2010 (kernel 2.6.x) when everything
happened at FusionIO.

Commit [1] introduced it as preparation for [2].

The only caller of writeback_inodes_sb_nr is btrfs_writeback_inodes_sb_nr in
(today's) space-info.c, where the mutex trylock was introduced in [3], apparently
to work around a VFS function that didn't do it for btrfs at the time.

Flushoncommit was added by Sage Weil for Ceph's btrfs backend in [4], even
before the WARN_ON, in 2009. We know how that story ended.

Why has nobody except you noticed this? Probably because the number of people
actually using it or reporting bugs is.. very small. ¯\_(ツ)_/¯

Unfortunately I'm still none the wiser why btrfs feels it's necessary to
"open-code"/circumvent the rwsem check. Maybe this gives you a clue.

cheers,
Holger

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/fs-writeback.c?id=cf37e972478ec58a8a54a6b4f951815f0ae28f78

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/fs-writeback.c?id=d19de7edf59cdd586777b009e0e8fbe5412dd35f

[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/btrfs/extent-tree.c?id=925a6efb8ff0c2bdbec107ed9890e62650c83306

[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dccae99995089641fbac452ebc7f0cab18751ddb
