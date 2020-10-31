Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87BB2A1973
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Oct 2020 19:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgJaSVz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Oct 2020 14:21:55 -0400
Received: from mail.nethype.de ([5.9.56.24]:43103 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgJaSVz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Oct 2020 14:21:55 -0400
X-Greylist: delayed 915 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Oct 2020 14:21:53 EDT
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1kYvGv-002r7w-07
        for linux-btrfs@vger.kernel.org; Sat, 31 Oct 2020 18:06:37 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1kYvGu-00084g-Rg
        for linux-btrfs@vger.kernel.org; Sat, 31 Oct 2020 18:06:36 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1kYvGu-0001wU-RC
        for linux-btrfs@vger.kernel.org; Sat, 31 Oct 2020 19:06:36 +0100
Date:   Sat, 31 Oct 2020 19:06:36 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     linux-btrfs@vger.kernel.org
Subject: NULL pointer exception in btrfs_compress_pages
Message-ID: <20201031180636.GA7373@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

It seems some kernel newer than 5.4.55 has introduced a NULL pointer
access in btrfs_compress_pages.

5.4.45 and 5.4.55 work fine on the systems in question, while 5.4.73 and
5.8.17 both generate variations of the following oops at some point during
runtime (usually within 1-2 hours, sometimes at boot). btrfs scrub and
btrfsck find nothing to complain about in the filesystems, and compression
is not globally enabled on the filesystems (but possibly enabled for some
directories).

[ 2735.988544] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 2735.996149] #PF: supervisor instruction fetch in kernel mode
[ 2736.003692] #PF: error_code(0x0010) - not-present page
[ 2736.011098] PGD 0 P4D 0 
[ 2736.018429] Oops: 0010 [#1] SMP NOPTI
[ 2736.025643] CPU: 3 PID: 6853 Comm: kworker/u8:9 Not tainted 5.4.73-050473-generic #202010291054
[ 2736.032992] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./C2550D4I, BIOS P2.30 01/26/2016
[ 2736.047966] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
[ 2736.055481] RIP: 0010:0x0
[ 2736.062828] Code: Bad RIP value.
[ 2736.070001] RSP: 0018:ffffafafc389fce8 EFLAGS: 00010282
[ 2736.077117] RAX: 0000000000000000 RBX: ffffffffc0595a60 RCX: ffff8a2995282250
[ 2736.084345] RDX: 00000000000fc000 RSI: ffff8a29a192ec98 RDI: ffff8a2a623e37e0
[ 2736.091651] RBP: ffffafafc389fd30 R08: ffffafafc389fda0 R09: ffffafafc389fdb0
[ 2736.098860] R10: ffff8a2a623e37e0 R11: ffff8a2995282250 R12: ffff8a2a623e37e0
[ 2736.105936] R13: ffff8a29a192ec98 R14: 00000000000fc000 R15: ffff8a2995282250
[ 2736.113016] FS:  0000000000000000(0000) GS:ffff8a2a6fb80000(0000) knlGS:0000000000000000
[ 2736.120108] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2736.127049] CR2: ffffffffffffffd6 CR3: 000000026d40a000 CR4: 00000000001006e0
[ 2736.133957] Call Trace:
[ 2736.140687]  btrfs_compress_pages+0x6b/0xa0 [btrfs]
[ 2736.147444]  compress_file_range+0x2e2/0x830 [btrfs]
[ 2736.154301]  ? submit_compressed_extents+0x430/0x430 [btrfs]
[ 2736.161085]  async_cow_start+0x16/0x40 [btrfs]
[ 2736.167715]  btrfs_work_helper+0xc1/0x3a0 [btrfs]
[ 2736.174166]  ? __schedule+0x2eb/0x740
[ 2736.180473]  process_one_work+0x1eb/0x3b0
[ 2736.186761]  worker_thread+0x4d/0x400
[ 2736.192888]  kthread+0x104/0x140
[ 2736.198819]  ? process_one_work+0x3b0/0x3b0
[ 2736.204741]  ? kthread_park+0x90/0x90
[ 2736.210660]  ret_from_fork+0x1f/0x40
[ 2736.216421] Modules linked in: xfs dm_crypt msr bfq intel_powerclamp kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel snd_pcm crypto_simd snd_timer cryptd glue_helper intel_cstate snd soundcore joydev pcspkr input_leds ipmi_ssif mac_hid ipmi_si ipmi_devintf ipmi_msghandler nct6775 hwmon_vid coretemp sunrpc ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear ses enclosure hid_generic usbkbd usbmouse usbhid hid gpio_ich i2c_ismt mpt3sas lpc_ich igb i2c_i801 i2c_algo_bit ahci dca raid_class libahci scsi_transport_sas
[ 2736.258562] CR2: 0000000000000000
[ 2736.264814] ---[ end trace 696b8659e073a6a0 ]---
[ 2736.295596] RIP: 0010:0x0
[ 2736.301519] Code: Bad RIP value.
[ 2736.307333] RSP: 0018:ffffafafc389fce8 EFLAGS: 00010282
[ 2736.313169] RAX: 0000000000000000 RBX: ffffffffc0595a60 RCX: ffff8a2995282250
[ 2736.319087] RDX: 00000000000fc000 RSI: ffff8a29a192ec98 RDI: ffff8a2a623e37e0
[ 2736.325030] RBP: ffffafafc389fd30 R08: ffffafafc389fda0 R09: ffffafafc389fdb0
[ 2736.330974] R10: ffff8a2a623e37e0 R11: ffff8a2995282250 R12: ffff8a2a623e37e0
[ 2736.336873] R13: ffff8a29a192ec98 R14: 00000000000fc000 R15: ffff8a2995282250
[ 2736.342795] FS:  0000000000000000(0000) GS:ffff8a2a6fb80000(0000) knlGS:0000000000000000
[ 2736.348832] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2736.354847] CR2: ffffffffffffffd6 CR3: 000000026d40a000 CR4: 00000000001006e0


-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
