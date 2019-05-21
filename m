Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E670025A4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 00:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfEUW2k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 18:28:40 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:43566 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfEUW2k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 18:28:40 -0400
Received: by mail-oi1-f169.google.com with SMTP id t187so88149oie.10
        for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2019 15:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6zoa8xY8NgSGC0ugOpDIQ4XJ0+YED2usuo9aB8Uvh84=;
        b=npv6U89oyiPDbXfTxnumdthQadIcRXQ2q/cMdeEiHdf7y9u3X3YCVUatq1qk568x9a
         8Xzd0mgwB5l9Ex3iznEbJHUl6cSkCrBfFhBQGS9gH6arG/7v9jY3tjA2zMIrlPNaHbE9
         pFTM26YtcYc77pGUjWS/cJ6VpKyfQuEyqpfcXvUks1k37pDHNTRiZuRC6d9Cgqtr66me
         7cjo4IVL0A5YKPofLj/08ulkxQAl8QWcKli8yckUQgxzvaUFfUMjyB1OzJBRs01RWTJV
         m1YcOhOoyM3JZPz6mE2KmIuKiYFFuf3RXMUKLl95eKJTrYnthFgv9DbS29xqFDovBWIR
         6Qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6zoa8xY8NgSGC0ugOpDIQ4XJ0+YED2usuo9aB8Uvh84=;
        b=faZ/xl5I/dU8OomGmnHDOAGW7pU1C5m6BSYCdzb8r1VQlnO8ydTSEsukyHhi+1Uks0
         xIded+QgvLXNaSQozK5RnRIjBBe/iHDTdkk+oojTIFardW8CXCdlaL+gbSsx98vhRj+3
         rqt9fSYwbhGI52AUTIVkGN7eK2PiC8Id68t/Hgcgy60BoHGKKgpHkglXqEKmUaC0msFu
         AD/jkC9/KEAqYyYxLPK35/GlvjjlfMVjhkprL6Lui3VE850homg/5qqPGwyAYni1P5jA
         S38dBnxbZt0EMzsO4om+z4rUPJEmFx1z5t4NPi+j7ZVVhZBXEkSzz//is62OXujdFry3
         4ppA==
X-Gm-Message-State: APjAAAWdGwtIl1cfh8SL5wMFJSZ2oTLrYL0zlxLi+xFz9Ve9YXyZnJK4
        2KTsJZEnChhtnQ/w9TDdLM+nDvDr+fW0/4o7Ok6Na/+N
X-Google-Smtp-Source: APXvYqzK3pfRaemr7L+aG0HVUZSiX9MOsnCaz+GNugsEjAd4LEuoRKT60rvHv/xyKbuYd9DRz2XBSpUpiV6sBQ1/k5c=
X-Received: by 2002:aca:b7c1:: with SMTP id h184mr3752773oif.5.1558477719027;
 Tue, 21 May 2019 15:28:39 -0700 (PDT)
MIME-Version: 1.0
From:   "C. Cebtenzzre" <cebtenzzre@gmail.com>
Date:   Tue, 21 May 2019 18:28:28 -0400
Message-ID: <CAHk_K8bjAofDftLuFXB=60wcDchxFhuK79=OETEQDV_f-c0s-A@mail.gmail.com>
Subject: 5.1.3: kernel BUG at fs/btrfs/relocation.c:1413 (create_reloc_root)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I attempted to start a balance on Linux 5.1.3.  The process crashed
and I got this in dmesg:

[  600.078204] kernel BUG at fs/btrfs/relocation.c:1413!
[  600.078215] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  600.078220] CPU: 5 PID: 4010 Comm: btrfs Tainted: P           OE
 5.1.3-arch1-1-ARCH #1
[  600.078222] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./X99 Extreme4, BIOS P3.80 04/06/2018
[  600.078285] RIP: 0010:create_reloc_root+0x1e9/0x200 [btrfs]
[  600.078288] Code: 15 5c 12 d4 ea 48 8b 80 98 00 00 00 4c 29 c0 48
c1 f8 06 48 c1 e0 0c 48 8b 44 10 50 49 89 86 f0 00 00 00 e9 b6 fe ff
ff 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b e8 ea 15 c8 e9 66 2e 0f 1f 84 00 00
00 00
[  600.078291] RSP: 0018:ffffa9e9031a7878 EFLAGS: 00010282
[  600.078294] RAX: 00000000ffffffef RBX: ffff9065986f6c00 RCX: 0000000000000000
[  600.078297] RDX: 000000005aee9205 RSI: ffff90660796cb60 RDI: ffffee0d88144b00
[  600.078299] RBP: ffff9065faf47a28 R08: 000000000002cb60 R09: ffffffffc198cd4e
[  600.078301] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000005
[  600.078303] R13: ffff9065eb41a000 R14: ffff9065ce41c000 R15: ffff90640b5b8100
[  600.078307] FS:  00007fc6540a68c0(0000) GS:ffff906607940000(0000)
knlGS:0000000000000000
[  600.078309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  600.078311] CR2: 00003608585ea008 CR3: 0000000222ff6006 CR4: 00000000001606e0
[  600.078313] Call Trace:
[  600.078361]  btrfs_init_reloc_root+0x8f/0xa0 [btrfs]
[  600.078398]  record_root_in_trans+0xae/0xd0 [btrfs]
[  600.078435]  btrfs_record_root_in_trans+0x4e/0x60 [btrfs]
[  600.078476]  select_reloc_root+0x7c/0x230 [btrfs]
[  600.078518]  do_relocation+0x9f/0x540 [btrfs]
[  600.078560]  ? select_one_root+0x37/0x110 [btrfs]
[  600.078565]  ? preempt_count_add+0x79/0xb0
[  600.078570]  ? _raw_spin_lock+0x13/0x30
[  600.078573]  ? _raw_spin_unlock+0x16/0x30
[  600.078614]  relocate_tree_blocks+0x4ce/0x640 [btrfs]
[  600.078620]  ? kmem_cache_alloc_trace+0x169/0x1c0
[  600.078662]  relocate_block_group+0x433/0x5b0 [btrfs]
[  600.078704]  btrfs_relocate_block_group+0x18b/0x210 [btrfs]
[  600.078748]  btrfs_relocate_chunk+0x31/0xa0 [btrfs]
[  600.078791]  btrfs_balance+0x7bc/0xf00 [btrfs]
[  600.078830]  ? btrfs_opendir+0x3e/0x70 [btrfs]
[  600.078872]  btrfs_ioctl_balance+0x2d3/0x370 [btrfs]
[  600.078916]  btrfs_ioctl+0x13c3/0x2e10 [btrfs]
[  600.078923]  ? mem_cgroup_commit_charge+0x7a/0x470
[  600.078929]  ? __mod_node_page_state+0x69/0xa0
[  600.078936]  ? __lru_cache_add+0x75/0xa0
[  600.078939]  ? _raw_spin_unlock+0x16/0x30
[  600.078943]  ? __handle_mm_fault+0x947/0x15c0
[  600.078948]  ? do_vfs_ioctl+0xa4/0x630
[  600.078950]  do_vfs_ioctl+0xa4/0x630
[  600.078954]  ? handle_mm_fault+0x10a/0x250
[  600.078959]  ? syscall_trace_enter+0x1d3/0x2d0
[  600.078962]  ksys_ioctl+0x60/0x90
[  600.078966]  __x64_sys_ioctl+0x16/0x20
[  600.078970]  do_syscall_64+0x5b/0x180
[  600.078974]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  600.078978] RIP: 0033:0x7fc65419acbb
[  600.078981] Code: 0f 1e fa 48 8b 05 a5 d1 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 d1 0c 00 f7 d8 64 89
01 48
[  600.078983] RSP: 002b:00007fffb4681988 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  600.078987] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fc65419acbb
[  600.078989] RDX: 00007fffb4681a20 RSI: 00000000c4009420 RDI: 0000000000000003
[  600.078991] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000003
[  600.078993] R10: 000055a6d9248010 R11: 0000000000000246 R12: 00007fffb46823b8
[  600.078994] R13: 0000000000000001 R14: 00007fffb4681a20 R15: 00007fffb468278f
[  600.078998] Modules linked in: cfg80211 xt_recent xt_tcpudp rfkill
8021q xt_state xt_conntrack garp mrp nf_conntrack stp llc
nf_defrag_ipv6 vmnet(OE) nf_defrag_ipv4 iptable_filter nct6775
hwmon_vid nls_iso8859_1 nls_cp437 vfat fat snd_usb_audio
snd_usbmidi_lib snd_rawmidi snd_seq_device intel_rapl
snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp coretemp
kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel input_leds snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_intel aesni_intel
snd_hda_codec usblp iTCO_wdt joydev aes_x86_64 iTCO_vendor_support
mousedev snd_hda_core crypto_simd cryptd snd_hwdep glue_helper snd_pcm
intel_cstate snd_timer mei_me snd intel_uncore intel_rapl_perf
intel_wmi_thunderbolt pcspkr i2c_i801 mxm_wmi e1000e mei lpc_ich
soundcore evdev mac_hid pcc_cpufreq fuse vmmon(OE) vmw_vmci
vboxnetflt(OE) vboxnetadp(OE) vboxpci(OE) vboxdrv(OE) sg crypto_user
ip_tables x_tables btrfs libcrc32c crc32c_generic xor usbhid uas
[  600.079039]  usb_storage raid6_pq sd_mod ahci libahci libata
xhci_pci ehci_pci crc32c_intel scsi_mod xhci_hcd ehci_hcd wmi
nvidia_drm(POE) drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops drm agpgart nvidia_uvm(OE) nvidia_modeset(POE) nvidia(POE)
ipmi_devintf ipmi_msghandler hid_generic hid
[  600.079061] ---[ end trace ccdf8b30014d6c1d ]---
[  600.079104] RIP: 0010:create_reloc_root+0x1e9/0x200 [btrfs]
[  600.079107] Code: 15 5c 12 d4 ea 48 8b 80 98 00 00 00 4c 29 c0 48
c1 f8 06 48 c1 e0 0c 48 8b 44 10 50 49 89 86 f0 00 00 00 e9 b6 fe ff
ff 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b e8 ea 15 c8 e9 66 2e 0f 1f 84 00 00
00 00
[  600.079109] RSP: 0018:ffffa9e9031a7878 EFLAGS: 00010282
[  600.079112] RAX: 00000000ffffffef RBX: ffff9065986f6c00 RCX: 0000000000000000
[  600.079114] RDX: 000000005aee9205 RSI: ffff90660796cb60 RDI: ffffee0d88144b00
[  600.079116] RBP: ffff9065faf47a28 R08: 000000000002cb60 R09: ffffffffc198cd4e
[  600.079118] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000005
[  600.079120] R13: ffff9065eb41a000 R14: ffff9065ce41c000 R15: ffff90640b5b8100
[  600.079123] FS:  00007fc6540a68c0(0000) GS:ffff906607940000(0000)
knlGS:0000000000000000
[  600.079125] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  600.079127] CR2: 00003608585ea008 CR3: 0000000222ff6006 CR4: 00000000001606e0

After downgrading to Linux 5.0.9 and rebooting, btrfs check found these errors:
root 1306 inode 712 errors 1040, bad file extent, some csum missing
root 1306 inode 725 errors 1040, bad file extent, some csum missing

The only files in root 1306 are some unimportant virtual machines, but
how do I deal with these errors?
