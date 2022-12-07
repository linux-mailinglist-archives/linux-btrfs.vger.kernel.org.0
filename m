Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3034464504D
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 01:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiLGAYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 19:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiLGAYn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 19:24:43 -0500
X-Greylist: delayed 459 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Dec 2022 16:24:41 PST
Received: from mail.callehosting.com (mail.callehosting.com [216.244.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EAD240
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 16:24:41 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.callehosting.com (Postfix) with ESMTP id 978BD6E28F
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 16:17:01 -0800 (PST)
X-Virus-Scanned: amavisd-new at callehosting.com
Received: from mail.callehosting.com ([127.0.0.1])
        by localhost (mail.callehosting.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2NX4wkA5R9RH for <linux-btrfs@vger.kernel.org>;
        Tue,  6 Dec 2022 16:17:00 -0800 (PST)
Received: from www.callehosting.com (_www [192.168.33.12])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.callehosting.com (Postfix) with ESMTPSA id 2150B6E28A
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 16:17:00 -0800 (PST)
Received: from UXHzu8OYYEoxa29bJQZ6orivFof0ggYE
 by www.callehosting.com
 with HTTP (HTTP/1.1 POST); Tue, 06 Dec 2022 16:16:59 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 06 Dec 2022 16:16:59 -0800
From:   Olivier Calle <olivier@calle.org>
To:     linux-btrfs@vger.kernel.org
Subject: Filesystem only mounts read-only after balance failure on enospc
Message-ID: <91999645c6ae4d70eaae0752c0d24e31@calle.org>
X-Sender: olivier@calle.org
User-Agent: Roundcube Webmail/1.1.12
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I was trying to get my filesystem (which appeared to have space) to use 
DUP instead of single for metadata, however that immediately caused the 
filesystem to be forced readonly and I cannot fix it.
I rebooted with sysresccd and here are the versions of things (original 
system is openSUSE Leap 15.4, so 5.14 kernel, I think?).

root@sysrescue ~ # uname -a
Linux sysrescue 5.15.74-1-lts #1 SMP Sat, 15 Oct 2022 06:43:47 +0000 
x86_64 GNU/Linux

root@sysrescue ~ # btrfs --version
btrfs-progs v5.15.1

root@sysrescue ~ # btrfs fi show
Label: none  uuid: 5ae3925a-e5b6-4287-953e-65ec81279020
	Total devices 1 FS bytes used 307.42GiB
	devid    1 size 328.42GiB used 328.42GiB path /dev/nvme0n1p6

root@sysrescue ~ # btrfs fi df /old
Data, single: total=322.38GiB, used=304.25GiB
System, single: total=32.00MiB, used=64.00KiB
Metadata, single: total=6.01GiB, used=3.17GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

Before I paste the dmesg output from a skip_balance mount, I also ran 
into this problem trying to use send:

root@sysrescue ~ # btrfs send /old/usr/local | btrfs receive /new
ERROR: subvolume /old/usr/local is not read-only
ERROR: empty stream is not considered valid

So here is dmesg after trying a mount with skip_balance:
[ 8638.498434] BTRFS info (device nvme0n1p6): disk space caching is 
enabled
[ 8638.498438] BTRFS info (device nvme0n1p6): has skinny extents
[ 8638.542568] BTRFS info (device nvme0n1p6): enabling ssd optimizations
[ 8638.542678] BTRFS info (device nvme0n1p6): balance: resume skipped
[ 8638.542680] BTRFS info (device nvme0n1p6): checking UUID tree
[ 8638.573611] BTRFS warning (device nvme0n1p6): Skipping commit of 
aborted transaction.
[ 8638.573615] ------------[ cut here ]------------
[ 8638.573615] BTRFS: Transaction aborted (error -28)
[ 8638.573663] WARNING: CPU: 5 PID: 3293 at fs/btrfs/transaction.c:2011 
btrfs_commit_transaction.cold+0xd6/0x2a4 [btrfs]
[ 8638.573701] Modules linked in: xfs nilfs2 jfs ip6table_filter 
ip6_tables xt_LOG nf_log_syslog xt_limit xt_conntrack nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter iwlmvm ucsi_ccg mac80211 
intel_rapl_msr typec_ucsi intel_rapl_common libarc4 uvcvideo 
snd_hda_codec_realtek typec snd_hda_codec_generic roles 
snd_hda_codec_hdmi ledtrig_audio videobuf2_vmalloc btusb btrtl 
videobuf2_memops iwlwifi snd_hda_intel edac_mce_amd btbcm snd_usb_audio 
videobuf2_v4l2 snd_intel_dspcfg kvm_amd snd_intel_sdw_acpi btintel 
videobuf2_common snd_hda_codec kvm bluetooth cfg80211 videodev eeepc_wmi 
snd_usbmidi_lib snd_hda_core snd_rawmidi snd_seq_device snd_hwdep 
asus_wmi irqbypass mc snd_pcm sparse_keymap ecdh_generic snd_timer snd 
platform_profile crc16 soundcore rfkill xpad rapl wmi_bmof joydev 
mousedev ff_memless sp5100_tco i2c_nvidia_gpu k10temp i2c_piix4 mac_hid 
pcspkr tpm_crb tpm_tis tpm_tis_core acpi_cpufreq pinctrl_amd 
dm_multipath sg bpf_preload ip_tables x_tables overlay squashfs loop 
vfat
[ 8638.573740]  fat dm_crypt dm_mod cbc encrypted_keys trusted 
asn1_encoder tee tpm uas usb_storage usbhid btrfs blake2b_generic xor 
raid6_pq libcrc32c crc32c_generic nouveau crct10dif_pclmul mxm_wmi 
crc32_pclmul video ccp crc32c_intel ghash_clmulni_intel aesni_intel 
r8169 crypto_simd realtek cryptd drm_ttm_helper mdio_devres rng_core 
xhci_pci ttm libphy xhci_pci_renesas wmi fuse
[ 8638.573759] CPU: 5 PID: 3293 Comm: kworker/u64:3 Tainted: G        W  
        5.15.74-1-lts #1 c059c1807053d13436aba0757c9a4f8a4ad32094
[ 8638.573761] Hardware name: System manufacturer System Product 
Name/TUF GAMING X570-PLUS (WI-FI), BIOS 1407 04/01/2020
[ 8638.573762] Workqueue: events_unbound 
btrfs_async_reclaim_metadata_space [btrfs]
[ 8638.573792] RIP: 0010:btrfs_commit_transaction.cold+0xd6/0x2a4 
[btrfs]
[ 8638.573818] Code: c4 48 8d 45 28 48 89 04 24 48 89 c1 48 8b 45 28 48 
39 c1 75 2e 0f 0b 0f 0b eb a4 44 89 fe 48 c7 c7 08 f0 85 c0 e8 a4 41 ec 
c4 <0f> 0b eb ac 48 8b 7b 58 44 89 fa 48 c7 c6 38 f0 85 c0 e8 86 b9 ff
[ 8638.573819] RSP: 0018:ffffad70813f3d18 EFLAGS: 00010282
[ 8638.573821] RAX: 0000000000000000 RBX: ffff979c4a9cecb0 RCX: 
0000000000000027
[ 8638.573822] RDX: ffff97a33eb606e8 RSI: 0000000000000001 RDI: 
ffff97a33eb606e0
[ 8638.573823] RBP: ffff979c5a5abc00 R08: 0000000000000000 R09: 
ffffad70813f3b28
[ 8638.573823] R10: ffffad70813f3b20 R11: 0000000000000003 R12: 
ffff979c4d4b9000
[ 8638.573824] R13: ffff979c4a9cec08 R14: ffff979c4a9cec08 R15: 
00000000ffffffe4
[ 8638.573825] FS:  0000000000000000(0000) GS:ffff97a33eb40000(0000) 
knlGS:0000000000000000
[ 8638.573826] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8638.573827] CR2: 000055a66465f588 CR3: 0000000105302000 CR4: 
0000000000350ee0
[ 8638.573828] Call Trace:
[ 8638.573829]  <TASK>
[ 8638.573831]  ? start_transaction+0xc8/0x570 [btrfs 
d5ac4552346f4531b80696df917ac71a8b95c788]
[ 8638.573856]  flush_space+0x104/0x5d0 [btrfs 
d5ac4552346f4531b80696df917ac71a8b95c788]
[ 8638.573883]  ? __switch_to_asm+0x3a/0x60
[ 8638.573886]  ? finish_task_switch.isra.0+0x83/0x290
[ 8638.573889]  btrfs_async_reclaim_metadata_space+0x1b9/0x2d0 [btrfs 
d5ac4552346f4531b80696df917ac71a8b95c788]
[ 8638.573913]  process_one_work+0x1d6/0x360
[ 8638.573916]  worker_thread+0x4d/0x3b0
[ 8638.573918]  ? process_one_work+0x360/0x360
[ 8638.573919]  kthread+0x118/0x140
[ 8638.573920]  ? set_kthread_struct+0x50/0x50
[ 8638.573922]  ret_from_fork+0x22/0x30
[ 8638.573924]  </TASK>
[ 8638.573925] ---[ end trace 8c33bccd5b6c252a ]---
[ 8638.573926] BTRFS: error (device nvme0n1p6) in 
cleanup_transaction:2011: errno=-28 No space left
[ 8638.573928] BTRFS info (device nvme0n1p6): forced readonly
[ 8638.573933] BTRFS warning (device nvme0n1p6): btrfs_uuid_scan_kthread 
failed -28

Since it does mount read-only, I've got a full rsync backup, however I'd 
like to avoid an OS re-install... :-(

Thanks for any ideas you may have,

-- 
Olivier Calle
<olivier@calle.org>
