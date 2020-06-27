Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4F720BDC5
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jun 2020 04:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgF0Co2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 22:44:28 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42268 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgF0Co1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 22:44:27 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 90CBD7358F2; Fri, 26 Jun 2020 22:44:26 -0400 (EDT)
Date:   Fri, 26 Jun 2020 22:44:26 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: BUG_ON in btrfs_check_repairable during btrfs raid5 replace
Message-ID: <20200627024426.GU10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This happened during a 'btrfs replace' on a -draid5 -mraid1 btrfs
filesystem (3 btrfs devices on top of dm-crypt and lvm):

        [163127.237803][ T2833] ------------[ cut here ]------------
        [163127.237811][ T2833] kernel BUG at fs/btrfs/extent_io.c:2497!
        [163127.237820][ T2833] invalid opcode: 0000 [#1] SMP NOPTI
        [163127.237824][ T2833] CPU: 1 PID: 2833 Comm: kworker/u8:7 Not tainted 5.4.41-zb64-4b623f143c7c+ #1
        [163127.237827][ T2833] Hardware name: System manufacturer System Product Name/A55BM-E, BIOS 1302 01/20/2014
        [163127.237834][ T2833] Workqueue: btrfs-endio btrfs_work_helper
        [163127.237840][ T2833] RIP: 0010:btrfs_check_repairable+0xbf/0x100
        [163127.237844][ T2833] Code: 5d 41 5e 5d c3 0f 1f 44 00 00 31 c0 eb ee 44 39 e6 75 19 c7 43 30 00 00 00 00 b9 01 00 00 00 31 f6 c7 43 28 00 00
 00 00 eb b3 <0f> 0b 0f 0b 45 89 e0 48 c7 c6 a0 1d 89 84 4c 89 ef e8 cb 02 fb ff
        [163127.237847][ T2833] RSP: 0018:ffffa94c40df7ca0 EFLAGS: 00010202
        [163127.237850][ T2833] RAX: 0000000000000001 RBX: ffff8f93e83bbe00 RCX: 0000000000000000
        [163127.237853][ T2833] RDX: 0000000000000003 RSI: 0000000000000001 RDI: 0000000000000246
        [163127.237855][ T2833] RBP: ffffa94c40df7cc0 R08: 0000000000000000 R09: 0000000000000000
        [163127.237857][ T2833] R10: 0000000000000000 R11: ffff8f9213cbb300 R12: 0000000000000001
        [163127.237860][ T2833] R13: ffff8f9569710000 R14: 0000000000000002 R15: ffff8f922a61e830
        [163127.237863][ T2833] FS:  0000000000000000(0000) GS:ffff8f960dc00000(0000) knlGS:0000000000000000
        [163127.237865][ T2833] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
        [163127.237868][ T2833] CR2: 00007f00989266e0 CR3: 0000000018e0c000 CR4: 00000000000406e0
        [163127.237873][ T2833] Call Trace:
        [163127.237881][ T2833]  end_bio_extent_readpage+0x476/0x750
        [163127.237890][ T2833]  ? try_to_wake_up+0x55/0x920
        [163127.237897][ T2833]  bio_endio+0xff/0x1c0
        [163127.237901][ T2833]  ? bio_endio+0xff/0x1c0
        [163127.237907][ T2833]  end_workqueue_fn+0x2d/0x40
        [163127.237911][ T2833]  btrfs_work_helper+0xf4/0x5f0
        [163127.237917][ T2833]  process_one_work+0x23f/0x590
        [163127.237924][ T2833]  worker_thread+0x44/0x3b0
        [163127.237929][ T2833]  kthread+0x12d/0x150
        [163127.237932][ T2833]  ? process_one_work+0x590/0x590
        [163127.237935][ T2833]  ? kthread_create_worker_on_cpu+0x70/0x70
        [163127.237940][ T2833]  ret_from_fork+0x27/0x50
        [163127.237948][ T2833] Modules linked in: nf_conntrack_netlink nfsv3 rpcsec_gss_krb5 nfsv4 algif_skcipher af_alg mq_deadline cpufreq_userspace
 cpufreq_powersave cpufreq_conservative xt_nat xt_owner xt_tcpudp xt_state xt_conntrack nf_log_ipv4 nf_log_common nft_counter nft_limit xt_LOG xt_limit
 nft_compat x_tables nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv4 nf_tables nfnetlink lp bnep rfcomm bluetooth ecdh_generic ecc binfmt_misc uinput
nfsd auth_rpcgss nfs_acl nfs lockd grace fscache sunrpc sch_fq_codel tcp_cubic dm_cache_smq ppdev snd_hda_codec_realtek snd_hda_codec_generic ledtrig_a
udio snd_hda_intel snd_intel_nhlt snd_hda_codec snd_hda_core snd_hwdep snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq
_midi_event snd_rawmidi edac_mce_amd kvm_amd ccp snd_seq snd_seq_device kvm snd_timer irqbypass input_leds joydev eeepc_wmi snd asus_wmi battery sparse
_keymap rfkill wmi_bmof pcspkr k10temp soundcore sp5100_tco radeon sg parport_pc parport evdev
        [163127.237993][ T2833]  acpi_cpufreq dm_crypt ipv6 nf_defrag_ipv6 crc_ccitt dm_raid dm_cache dm_persistent_data dm_bio_prison dm_bufio af_pack
et raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid0 multipath linear nbd hid_generic uas crct10dif_pclmul ghash_clmulni_
intel raid1 ohci_pci md_mod aesni_intel r8169 realtek i2c_piix4 ehci_pci ohci_hcd ehci_hcd wmi rtc_cmos
        [163127.238020][ T2833] ---[ end trace 9170430ffdbe958a ]---
        [163127.238024][ T2833] RIP: 0010:btrfs_check_repairable+0xbf/0x100
        [163127.238028][ T2833] Code: 5d 41 5e 5d c3 0f 1f 44 00 00 31 c0 eb ee 44 39 e6 75 19 c7 43 30 00 00 00 00 b9 01 00 00 00 31 f6 c7 43 28 00 00
 00 00 eb b3 <0f> 0b 0f 0b 45 89 e0 48 c7 c6 a0 1d 89 84 4c 89 ef e8 cb 02 fb ff
        [163127.238030][ T2833] RSP: 0018:ffffa94c40df7ca0 EFLAGS: 00010202
        [163127.238034][ T2833] RAX: 0000000000000001 RBX: ffff8f93e83bbe00 RCX: 0000000000000000
        [163127.238036][ T2833] RDX: 0000000000000003 RSI: 0000000000000001 RDI: 0000000000000246
        [163127.238038][ T2833] RBP: ffffa94c40df7cc0 R08: 0000000000000000 R09: 0000000000000000
        [163127.238040][ T2833] R10: 0000000000000000 R11: ffff8f9213cbb300 R12: 0000000000000001
        [163127.238043][ T2833] R13: ffff8f9569710000 R14: 0000000000000002 R15: ffff8f922a61e830
        [163127.238046][ T2833] FS:  0000000000000000(0000) GS:ffff8f960dc00000(0000) knlGS:0000000000000000
        [163127.238048][ T2833] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
        [163127.238051][ T2833] CR2: 00007f00989266e0 CR3: 0000000018e0c000 CR4: 00000000000406e0

        (gdb) l *(btrfs_check_repairable+0xbf)
        0xffffffff815491ef is in btrfs_check_repairable (fs/btrfs/extent_io.c:2497).
        2492                     * we need separate read requests for the failed bio
        2493                     *
        2494                     * if the following BUG_ON triggers, our validation request got
        2495                     * merged. we need separate requests for our algorithm to work.
        2496                     */
        2497                    BUG_ON(failrec->in_validation);
        2498                    failrec->in_validation = 1;
        2499                    failrec->this_mirror = failed_mirror;
        2500            } else {
        2501                    /*

No other IO or csum errors were reported at the time.

This may or may not have lead to a watchdog reset several hours later.
The kernel definitely did crash, but I do not know exactly why, or
whether this BUG_ON was related; however, it was the only event of
significance in the kernel log.

Applications were logging data on the filesystem up to the moment of
reboot, so it did not look like any usual kind of filesystem deadlock.
It could have been a phenomenon I've observed on some filesystems where
a scrub postpones transaction commits until the end of the scrub.
