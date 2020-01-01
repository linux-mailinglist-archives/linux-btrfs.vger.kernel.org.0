Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0812E103
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 00:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgAAXfJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jan 2020 18:35:09 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:40310 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgAAXfI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jan 2020 18:35:08 -0500
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 626EAA4131; Wed,  1 Jan 2020 23:35:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1577921705;
        bh=o4W5uRNOm+WRM9gd2h5uy9AG0q8FNmdVk5/aMN05JRk=;
        h=To:From:Subject:Date:From;
        b=Lz69bMUX8vXwnwZ2VOemabEt4cSXfGnxriGlSrSKFIx84uBlJJR1FHB3OU2G2WAJA
         yUH1wjf9v4G1xXUgKWnC8PtzRntSQNLQw6LZfCgtx7LJGjlNRuIUIReMu8e8VXirjJ
         ZClE+aeYWEakMCGB0vb2n44sVLCqgSa8eP9aRCdo1f4mJmKWeHF+2ZxcgA7hlv3emw
         Y6oHmhFN6tA4DAKQJWd9iLVNPNuHouNgxY3F7PbbwYaqdnTcb7M7emYJMKAECG/gQY
         KKDjReGv2hfrGDCM3skOULiSNjZ3iO0mUnRvzk9D18XqE7ntPFYnzuSQALGo1eCiAZ
         Tcxqx8thMZCow==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id EB5C5A4130
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2020 23:35:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1577921702;
        bh=o4W5uRNOm+WRM9gd2h5uy9AG0q8FNmdVk5/aMN05JRk=;
        h=To:From:Subject:Date:From;
        b=N4yOe8zIttMert9EgzflddsGVl0GPdPtTi1VEL1SFZG+8Yx6kdVlNe+EKBpbXzKCw
         WriH/6MEKypIWEB2m1Qfh8xKcLZmZj4bE0SPCfDLCSqda2ZYzvblOV/uyOMGpSkC6J
         5mVBjo9x4gUAWOixjtT0Y8dEfpwMg6Sun76+jhg8XcomY0h5Nkj7fBq1t5QTsLOH7d
         pRMywlpYO/ImnmVMgD3UBCCJHiuqCyA44qHvnhpCUsGSUicbKIri4ZXLsGbygqvwiY
         kZq+/gUNcDBVfAE+NB8sPJr2EKFIl6Ur5MCDxUEfEt0M+UnPZq6n2EgWSCJevSNUWA
         b64TmpWbkcZ9w==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 2906F93A06
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2020 23:35:01 +0000 (GMT)
To:     linux-btrfs@vger.kernel.org
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Interrupted and resumed scrubs seem to have caused filesystem to go
 readonly (EFBIG error)
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <f15c0d2f-df61-17fc-667c-2b0eb5674be2@cobb.uk.net>
Date:   Wed, 1 Jan 2020 23:35:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a problem on one BTRFS filesystem. It is not a critical
filesystem (it is used for backups) and I have not yet tried even
unmounting and remounting, let alone a "btrfs check".

The problem seems to be that after several iterations of running 'btrfs
scrub' for 30 minutes, then pausing for a while, then resuming the
scrub, I got a transaction aborted with an EFBIG error and a warning in
the kernel log. The fs went readonly, and transid verify errors are now
reported. The original log extract is available at
http://www.cobb.uk.net/kern.log.bug-010120 but I have pasted the key
part below.

The kernel is a Debian Testing kernel:
Linux black 5.3.0-2-amd64 #1 SMP Debian 5.3.9-3 (2019-11-19) x86_64
GNU/Linux

I run this same script monthly, and I have not seen this problem before,
so I cannot be certain it is caused by the scrub. I have not yet tried
to reproduce it, or to investigate the filesystem (check, etc).

Does anyone recognise this as a known/fixed problem? If not, is there
any particular further information I could gather before or during my
attempt to either recover the filesystem or just rebuild it?

Here is the log (starting with the 7th resumed scrub):


Jan  1 06:41:45 black kernel: [1930660.938782] BTRFS info (device sdc3):
scrub: started on devid 1
Jan  1 06:41:45 black kernel: [1930660.939195] BTRFS info (device sdc3):
scrub: started on devid 4
Jan  1 06:41:45 black kernel: [1930661.475557] ------------[ cut here
]------------
Jan  1 06:41:45 black kernel: [1930661.475562] BTRFS: Transaction
aborted (error -27)
Jan  1 06:41:45 black kernel: [1930661.475667] WARNING: CPU: 0 PID:
771075 at fs/btrfs/extent-tree.c:8247 btrfs_create_pending_block_
groups+0x1db/0x230 [btrfs]
Jan  1 06:41:45 black kernel: [1930661.475669] Modules linked in: fuse
nfsv3 rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache bnep nf_t
ables snd_hrtimer snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq
snd_seq_device cpufreq_userspace cpufreq_powersave cpufreq_cons
ervative nfnetlink_queue nfnetlink_log nfnetlink bluetooth drbg
ansi_cprng ecdh_generic ecc binfmt_misc hid_generic usbhid hid it87 h
wmon_vid radeon edac_mce_amd kvm_amd eeepc_wmi ccp asus_wmi rng_core
evdev sparse_keymap kvm snd_hda_codec_realtek rfkill irqbypass s
nd_hda_codec_generic ttm video wmi_bmof ledtrig_audio pcspkr
snd_hda_codec_hdmi drm_kms_helper fam15h_power k10temp snd_hda_intel snd
_hda_codec snd_hda_core snd_hwdep sp5100_tco drm snd_pcm_oss
snd_mixer_oss watchdog snd_pcm snd_timer sg snd soundcore i2c_algo_bit b
utton acpi_cpufreq eeprom i2c_nforce2 firewire_sbp2 firewire_core
crc_itu_t psmouse nfsd parport_pc ppdev auth_rpcgss lp nfs_acl parp
ort lockd grace sunrpc ip_tables x_tables autofs4 btrfs xor
zstd_decompress zstd_compress raid6_pq libcrc32c
Jan  1 06:41:45 black kernel: [1930661.475710]  ext4 crc16 mbcache jbd2
crc32c_generic sr_mod cdrom uas usb_storage sd_mod dm_crypt d
m_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel
ohci_pci aesni_intel ahci libahci xhci_pci aes_x86_64 xhci_hcd c
rypto_simd libata ehci_pci ohci_hcd ehci_hcd cryptd glue_helper scsi_mod
usbcore r8169 i2c_piix4 realtek libphy usb_common wmi
Jan  1 06:41:45 black kernel: [1930661.475737] CPU: 0 PID: 771075 Comm:
btrfs Not tainted 5.3.0-2-amd64 #1 Debian 5.3.9-3
Jan  1 06:41:45 black kernel: [1930661.475739] Hardware name: To be
filled by O.E.M. To be filled by O.E.M./M5A97, BIOS 0705 08/22/20
11
Jan  1 06:41:45 black kernel: [1930661.475767] RIP:
0010:btrfs_create_pending_block_groups+0x1db/0x230 [btrfs]
Jan  1 06:41:45 black kernel: [1930661.475770] Code: e9 26 ff ff ff 48
8b 45 50 f0 48 0f ba a8 38 17 00 00 02 72 17 41 83 fc fb 74 2d
 44 89 e6 48 c7 c7 50 2e 7a c0 e8 23 9d 19 e3 <0f> 0b 44 89 e1 ba 37 20
00 00 48 c7 c6 20 80 79 c0 48 89 ef e8 73
Jan  1 06:41:45 black kernel: [1930661.475772] RSP:
0018:ffff9c69804cfb00 EFLAGS: 00010286
Jan  1 06:41:45 black kernel: [1930661.475775] RAX: 0000000000000000
RBX: ffff909444e7a520 RCX: 0000000000000006
Jan  1 06:41:45 black kernel: [1930661.475777] RDX: 0000000000000007
RSI: 0000000000000096 RDI: ffff90957aa17680
Jan  1 06:41:45 black kernel: [1930661.475779] RBP: ffff90946c745d68
R08: 0000000000010ec1 R09: 0000000000000007
Jan  1 06:41:45 black kernel: [1930661.475781] R10: 0000000000000000
R11: 0000000000000001 R12: 00000000ffffffe5
Jan  1 06:41:45 black kernel: [1930661.475783] R13: ffff90946c745dc0
R14: ffff909575d2e000 R15: ffff909574444000
Jan  1 06:41:45 black kernel: [1930661.475786] FS:
00007ff2eb4c7700(0000) GS:ffff90957aa00000(0000) knlGS:0000000000000000
Jan  1 06:41:45 black kernel: [1930661.475788] CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Jan  1 06:41:45 black kernel: [1930661.475790] CR2: 00005634edab7008
CR3: 00000000bd0f2000 CR4: 00000000000406f0
Jan  1 06:41:45 black kernel: [1930661.475792] Call Trace:
Jan  1 06:41:45 black kernel: [1930661.475826]
__btrfs_end_transaction+0x3f/0x1b0 [btrfs]
Jan  1 06:41:45 black kernel: [1930661.475855]
btrfs_inc_block_group_ro+0x10e/0x150 [btrfs]
Jan  1 06:41:45 black kernel: [1930661.475891]
scrub_enumerate_chunks+0x162/0x560 [btrfs]
Jan  1 06:41:45 black kernel: [1930661.475900]  ?
remove_wait_queue+0x20/0x60
Jan  1 06:41:45 black kernel: [1930661.475936]
btrfs_scrub_dev+0x26b/0x590 [btrfs]
Jan  1 06:41:45 black kernel: [1930661.475942]  ? _cond_resched+0x15/0x30
Jan  1 06:41:45 black kernel: [1930661.475946]  ?
__kmalloc_track_caller+0x16e/0x260
Jan  1 06:41:45 black kernel: [1930661.475980]  ?
btrfs_ioctl+0x82f/0x2e10 [btrfs]
Jan  1 06:41:45 black kernel: [1930661.475984]  ?
__check_object_size+0x136/0x147
Jan  1 06:41:45 black kernel: [1930661.476019]  btrfs_ioctl+0x87a/0x2e10
[btrfs]
Jan  1 06:41:45 black kernel: [1930661.476024]  ?
tomoyo_path_number_perm+0x66/0x1d0
Jan  1 06:41:45 black kernel: [1930661.476030]  ? do_vfs_ioctl+0x40e/0x670
Jan  1 06:41:45 black kernel: [1930661.476033]  do_vfs_ioctl+0x40e/0x670
Jan  1 06:41:45 black kernel: [1930661.476036]  ?
create_task_io_context+0x95/0x100
Jan  1 06:41:45 black kernel: [1930661.476040]  ksys_ioctl+0x5e/0x90
Jan  1 06:41:45 black kernel: [1930661.476044]  __x64_sys_ioctl+0x16/0x20
Jan  1 06:41:45 black kernel: [1930661.476048]  do_syscall_64+0x53/0x140
Jan  1 06:41:45 black kernel: [1930661.476052]
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jan  1 06:41:45 black kernel: [1930661.476055] RIP: 0033:0x7ff2eb5b95b7
Jan  1 06:41:45 black kernel: [1930661.476058] Code: 00 00 90 48 8b 05
d9 78 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84
00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b
0d a9 78 0c 00 f7 d8 64 89 01 48
Jan  1 06:41:45 black kernel: [1930661.476061] RSP:
002b:00007ff2eb4c6d38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Jan  1 06:41:45 black kernel: [1930661.476064] RAX: ffffffffffffffda
RBX: 000055eeaf2e94b0 RCX: 00007ff2eb5b95b7
Jan  1 06:41:45 black kernel: [1930661.476066] RDX: 000055eeaf2e94b0
RSI: 00000000c400941b RDI: 0000000000000003
Jan  1 06:41:45 black kernel: [1930661.476067] RBP: 0000000000000000
R08: 00007ff2eb4c7700 R09: 0000000000000000
Jan  1 06:41:45 black kernel: [1930661.476069] R10: 00007ff2eb4c7700
R11: 0000000000000246 R12: 00007ffc4cfa511e
Jan  1 06:41:45 black kernel: [1930661.476071] R13: 00007ffc4cfa511f
R14: 00007ff2eb4c7700 R15: 00007ff2eb4c6e40
Jan  1 06:41:45 black kernel: [1930661.476075] ---[ end trace
6429c1bf293fecb8 ]---
Jan  1 06:41:45 black kernel: [1930661.476079] BTRFS: error (device
sdc3) in btrfs_create_pending_block_groups:8247: errno=-27 unknown
Jan  1 06:41:45 black kernel: [1930661.476082] BTRFS info (device sdc3):
forced readonly
Jan  1 06:41:45 black kernel: [1930661.489816] BTRFS warning (device
sdc3): failed setting block group ro: -30
Jan  1 06:41:45 black kernel: [1930661.489821] BTRFS info (device sdc3):
scrub: not finished on devid 1 with status: -30
Jan  1 06:41:52 black kernel: [1930668.052295] BTRFS warning (device
sdc3): failed setting block group ro: -30
Jan  1 06:41:52 black kernel: [1930668.052301] BTRFS info (device sdc3):
scrub: not finished on devid 4 with status: -30
Jan  1 06:51:56 black kernel: [1931271.801468] BTRFS error (device
sdc3): parent transid verify failed on 16216583520256 wanted 301800
found 301756
Jan  1 06:51:56 black kernel: [1931271.822215] BTRFS error (device
sdc3): parent transid verify failed on 16216583520256 wanted 301800
found 301756
Jan  1 06:51:57 black kernel: [1931273.492798] BTRFS error (device
sdc3): parent transid verify failed on 16216583520256 wanted 301800
found 301756
Jan  1 06:51:57 black kernel: [1931273.493041] BTRFS error (device
sdc3): parent transid verify failed on 16216583520256 wanted 301800
found 301756
