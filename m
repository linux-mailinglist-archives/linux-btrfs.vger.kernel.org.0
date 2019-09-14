Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14639B2CF0
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2019 22:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfINUwU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Sep 2019 16:52:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46675 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfINUwU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Sep 2019 16:52:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so31912940qkd.13
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Sep 2019 13:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=xQQrIMpv47uVTkKh93o1Fi9RT2Qz+Mat2r0H54zH64Q=;
        b=gqMszKhYhwzgQGYKmzhhVd3DYYkqsUSo56AM1mVHoK7pPWhPeLxX6AoBoN7qqvTxVl
         LVQHR00Vtv+/jVRaIzUsE25MEM09Bl7sdhEfJlpiFj0Lqo3qFC3dSOifKyhyoA9lYNma
         IIIel9KEhND629G4c3EYCyU4KMjkxY7gNpCczPl1/qS/AsD+OITjuRTs//6OBoi4S8Cc
         lcpkuKh1A/9tY/8LUWKVo6qSmXz/ps06BM9WuCIEAivuO4YsKqdKjGHYoYDWQwGPnj+a
         tRRlyblGkYlocfMctjZp+CJKH5PKRO/+UMyo3Z2gflnzfyMcrxn/pxJCByyKKgzPkSlG
         U1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=xQQrIMpv47uVTkKh93o1Fi9RT2Qz+Mat2r0H54zH64Q=;
        b=QOXM/oygs0nNpGq5k50Z80emchoiyN4veuQcCaEVGnu6IKsAk1uVndblCONg/0NiAx
         TEWBNpeDkslTr9gqPp4c5YTrt3gV+5UDtORArfaKqtJuEEC9mogIXU7AjuxZRzkZcwYU
         epWER9rjzaB6crlXhRYAOjdVFj/eFW9wyrCu5WpRzT+4NTknyQifKSl+4jU6Ip316Yms
         UWh7rRa6QvS8ZODlIVok+5oG3iX3ae++sTs5iYOrPlotSEDebXzVGzftQcccJUKR+5ik
         1yyhMhd+ZJ2ksX4V/SMK3jjChJKGwTEQDN/xwLQKlq/qrGLiA3epB8UZI8ZLlu3XMkHi
         tERQ==
X-Gm-Message-State: APjAAAVRho/V9bgYUv1AQxjMR3F/P/apn/4j0J+3igpNgjNyNB3FKWsd
        F2P9Qrcf4Clxee1jFZVQi9qIt6Mk
X-Google-Smtp-Source: APXvYqxYGXajtZ0PRv5eijygPFwAuwGGI2o/vnYVifT6hHHnK5HMpvwZXBx3PPgpNg3yoiCnM+7jfw==
X-Received: by 2002:ae9:e219:: with SMTP id c25mr27977511qkc.234.1568494338211;
        Sat, 14 Sep 2019 13:52:18 -0700 (PDT)
Received: from ?IPv6:2604:6000:1014:c7c6:3870:3b84:b31a:588b? ([2604:6000:1014:c7c6:3870:3b84:b31a:588b])
        by smtp.gmail.com with ESMTPSA id z8sm2755327qkf.37.2019.09.14.13.52.17
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 13:52:17 -0700 (PDT)
Message-ID: <11898294e644baf5da8121f2c0f3d71e155a7352.camel@gmail.com>
Subject: BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x2bf/0x330
 [btrfs]
From:   Cebtenzzre <cebtenzzre@gmail.com>
To:     linux-btrfs@vger.kernel.org
Date:   Sat, 14 Sep 2019 16:52:16 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have been able to trigger a use-after-free in btrfs on a stock Arch
Linux kernel, versions 5.2.9 and 5.2.11. I also reproduced it on
kernel.org mainline 5.3-rc8, resulting in this KASAN report:


[49286.511157] BTRFS info (device sdi1): balance: start -dvrange=3D22216819=
34336..2221681934337
[49286.515651] BTRFS info (device sdi1): relocating block group 22216819343=
36 flags data|raid0
[49294.092536] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[49294.092637] BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x2bf/0x=
330 [btrfs]
[49294.092645] Write of size 8 at addr ffff8885b4901440 by task kworker/u24=
:6/10894

[49294.092657] CPU: 8 PID: 10894 Comm: kworker/u24:6 Tainted: P           O=
E     5.3.0-rc8-rc-kasan #2
[49294.092661] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M.=
/X99 Extreme4, BIOS P3.80 04/06/2018
[49294.092726] Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs=
]
[49294.092730] Call Trace:
[49294.092743]  dump_stack+0x71/0xa0
[49294.092751]  print_address_description+0x67/0x323
[49294.092817]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
[49294.092879]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
[49294.092884]  __kasan_report.cold+0x1a/0x3d
[49294.092945]  ? btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
[49294.092951]  kasan_report+0xe/0x12
[49294.093012]  btrfs_init_reloc_root+0x2bf/0x330 [btrfs]
[49294.093066]  record_root_in_trans+0x2ba/0x3a0 [btrfs]
[49294.093119]  btrfs_record_root_in_trans+0xd2/0x150 [btrfs]
[49294.093170]  start_transaction+0x1c3/0xea0 [btrfs]
[49294.093226]  btrfs_finish_ordered_io+0x811/0x1610 [btrfs]
[49294.093233]  ? syscall_return_via_sysret+0xf/0x7f
[49294.093238]  ? syscall_return_via_sysret+0xf/0x7f
[49294.093243]  ? __switch_to_asm+0x40/0x70
[49294.093248]  ? __switch_to_asm+0x34/0x70
[49294.093300]  ? btrfs_unlink_subvol+0xa30/0xa30 [btrfs]
[49294.093307]  ? finish_task_switch+0x1a1/0x760
[49294.093312]  ? __switch_to+0x457/0xe90
[49294.093317]  ? __switch_to_asm+0x34/0x70
[49294.093378]  normal_work_helper+0x15a/0xb90 [btrfs]
[49294.093387]  process_one_work+0x706/0x1200
[49294.093394]  worker_thread+0x92/0xfb0
[49294.093401]  ? __kthread_parkme+0x85/0x100
[49294.093406]  ? process_one_work+0x1200/0x1200
[49294.093410]  kthread+0x2ba/0x3b0
[49294.093414]  ? kthread_park+0x130/0x130
[49294.093420]  ret_from_fork+0x35/0x40

[49294.093431] Allocated by task 11689:
[49294.093441]  __kasan_kmalloc.part.0+0x3c/0xa0
[49294.093493]  btrfs_read_tree_root+0x8f/0x350 [btrfs]
[49294.093542]  btrfs_read_fs_root+0xc/0xc0 [btrfs]
[49294.093601]  create_reloc_root+0x445/0x920 [btrfs]
[49294.093660]  btrfs_init_reloc_root+0x1da/0x330 [btrfs]
[49294.093709]  record_root_in_trans+0x2ba/0x3a0 [btrfs]
[49294.093758]  btrfs_record_root_in_trans+0xd2/0x150 [btrfs]
[49294.093806]  start_transaction+0x1c3/0xea0 [btrfs]
[49294.093856]  __btrfs_prealloc_file_range+0x1c2/0xa50 [btrfs]
[49294.093907]  btrfs_prealloc_file_range+0x10/0x20 [btrfs]
[49294.093966]  prealloc_file_extent_cluster+0x24e/0x4a0 [btrfs]
[49294.094025]  relocate_file_extent_cluster+0x193/0xc90 [btrfs]
[49294.094083]  relocate_data_extent+0x1f2/0x460 [btrfs]
[49294.094142]  relocate_block_group+0x5a5/0xf50 [btrfs]
[49294.094200]  btrfs_relocate_block_group+0x38f/0x990 [btrfs]
[49294.094258]  btrfs_relocate_chunk+0x5c/0x100 [btrfs]
[49294.094315]  btrfs_balance+0x1292/0x2f00 [btrfs]
[49294.094373]  btrfs_ioctl_balance+0x4c2/0x6a0 [btrfs]
[49294.094430]  btrfs_ioctl+0xe56/0x82d0 [btrfs]
[49294.094434]  do_vfs_ioctl+0x99f/0xf10
[49294.094437]  ksys_ioctl+0x5e/0x90
[49294.094440]  __x64_sys_ioctl+0x6f/0xb0
[49294.094446]  do_syscall_64+0xa0/0x370
[49294.094451]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[49294.094457] Freed by task 11689:
[49294.094464]  __kasan_slab_free+0x144/0x1f0
[49294.094468]  kfree+0x95/0x2a0
[49294.094516]  btrfs_drop_snapshot+0x1529/0x1c40 [btrfs]
[49294.094573]  clean_dirty_subvols+0x23f/0x380 [btrfs]
[49294.094632]  relocate_block_group+0x95b/0xf50 [btrfs]
[49294.094691]  btrfs_relocate_block_group+0x38f/0x990 [btrfs]
[49294.094748]  btrfs_relocate_chunk+0x5c/0x100 [btrfs]
[49294.094805]  btrfs_balance+0x1292/0x2f00 [btrfs]
[49294.094863]  btrfs_ioctl_balance+0x4c2/0x6a0 [btrfs]
[49294.094920]  btrfs_ioctl+0xe56/0x82d0 [btrfs]
[49294.094923]  do_vfs_ioctl+0x99f/0xf10
[49294.094926]  ksys_ioctl+0x5e/0x90
[49294.094929]  __x64_sys_ioctl+0x6f/0xb0
[49294.094934]  do_syscall_64+0xa0/0x370
[49294.094939]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[49294.094946] The buggy address belongs to the object at ffff8885b4901100
                which belongs to the cache kmalloc-2k of size 2048
[49294.094953] The buggy address is located 832 bytes inside of
                2048-byte region [ffff8885b4901100, ffff8885b4901900)
[49294.094957] The buggy address belongs to the page:
[49294.094962] page:ffffea0016d24000 refcount:1 mapcount:0 mapping:ffff8886=
4400e800 index:0x0 compound_mapcount: 0
[49294.094968] flags: 0x2ffff0000010200(slab|head)
[49294.094976] raw: 02ffff0000010200 dead000000000100 dead000000000122 ffff=
88864400e800
[49294.094981] raw: 0000000000000000 00000000800f000f 00000001ffffffff 0000=
000000000000
[49294.094983] page dumped because: kasan: bad access detected

[49294.094987] Memory state around the buggy address:
[49294.094992]  ffff8885b4901300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[49294.094997]  ffff8885b4901380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[49294.095002] >ffff8885b4901400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[49294.095006]                                            ^
[49294.095010]  ffff8885b4901480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[49294.095015]  ffff8885b4901500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[49294.095018] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[49301.893672] BTRFS info (device sdi1): 1 enospc errors during balance
[49301.893675] BTRFS info (device sdi1): balance: ended with status: -28


Without KASAN, I would eventually get an oops like this:


[170020.060858] BUG: unable to handle page fault for address: fffff47e48011=
248
[170020.060863] #PF: supervisor read access in kernel mode
[170020.060865] #PF: error_code(0x0000) - not-present page
[170020.060866] PGD 0 P4D 0=20
[170020.060870] Oops: 0000 [#1] PREEMPT SMP PTI
[170020.060873] CPU: 1 PID: 26807 Comm: kworker/1:1 Tainted: P        W  OE=
     5.2.9-arch1-1-ARCH #1
[170020.060875] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M=
./X99 Extreme4, BIOS P3.80 04/06/2018
[170020.060882] Workqueue: events proc_cleanup_work
[170020.060888] RIP: 0010:kfree+0x4e/0x1a0
[170020.060891] Code: 80 48 01 df 0f 82 64 01 00 00 48 c7 c0 00 00 00 80 48=
 2b 05 0c 9f ef 00 48 01 c7 48 c1 ef 0c 48 c1 e7 06 48 03 3d ea 9e ef 00 <4=
8> 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa 48 8b 57 08 48 8d 42 ff
[170020.060892] RSP: 0018:ffffa9f1883f7df8 EFLAGS: 00010282
[170020.060895] RAX: 00006da180000000 RBX: 000000000044996c RCX: 0000000000=
800058
[170020.060896] RDX: 0000000000800059 RSI: ffff9262044c9fe0 RDI: fffff47e48=
011240
[170020.060897] RBP: ffff9260e4ca8e00 R08: 0000000000000001 R09: ffffffff8a=
223a2e
[170020.060899] R10: ffff926487403980 R11: ffffa9f1883f7de0 R12: ffffffff8a=
223a2e
[170020.060900] R13: ffff92648786f700 R14: 0000000000000000 R15: 0ffff92648=
786f70
[170020.060902] FS:  0000000000000000(0000) GS:ffff926487840000(0000) knlGS=
:0000000000000000
[170020.060904] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[170020.060906] CR2: fffff47e48011248 CR3: 00000001c55fe006 CR4: 0000000000=
1606e0
[170020.060907] Call Trace:
[170020.060915]  memcg_destroy_list_lru_node.isra.0+0x2e/0x40
[170020.060918]  list_lru_destroy+0xb9/0xf0
[170020.060923]  deactivate_locked_super+0x42/0x70
[170020.060927]  cleanup_mnt+0x3f/0x70
[170020.060931]  process_one_work+0x1d1/0x3e0
[170020.060935]  worker_thread+0x4a/0x3d0
[170020.060938]  kthread+0xfb/0x130
[170020.060941]  ? process_one_work+0x3e0/0x3e0
[170020.060943]  ? kthread_park+0x80/0x80
[170020.060948]  ret_from_fork+0x35/0x40
[170020.060952] Modules linked in: qmi_wwan cdc_wdm usbnet mii i2c_dev snd_=
seq_dummy snd_seq xfs jfs rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nf=
s lockd grace sunrpc fscache tun ipt_REJECT nft_redir nf_tables_set nft_fib=
_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_r=
eject_ipv6 nft_reject nft_ct nft_chain_nat nf_tables nfnetlink ip6table_nat=
 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat iptable_=
mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 ip6table_filter ip6_tables iptable_filter cfg80211 rfkill 8021q garp mr=
p stp llc nct6775 vmnet(OE) hwmon_vid nls_iso8859_1 nls_cp437 vfat fat inte=
l_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel iTCO_wdt iT=
CO_vendor_support joydev mousedev kvm irqbypass crct10dif_pclmul crc32_pclm=
ul ghash_clmulni_intel aesni_intel aes_x86_64 crypto_simd cryptd glue_helpe=
r intel_cstate intel_uncore snd_hda_codec_hdmi intel_wmi_thunderbolt intel_=
rapl_perf pcspkr mxm_wmi
[170020.060991]  snd_usb_audio snd_usbmidi_lib snd_rawmidi snd_seq_device i=
nput_leds media snd_hda_codec_realtek snd_hda_codec_generic usblp ledtrig_a=
udio snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_pcm e1000e snd_=
timer mei_me mei snd lpc_ich soundcore i2c_i801 pcc_cpufreq evdev mac_hid f=
use vmmon(OE) vmw_vmci sg crypto_user ip_tables x_tables btrfs libcrc32c cr=
c32c_generic xor usbhid raid6_pq uas usb_storage sd_mod ahci libahci libata=
 xhci_pci crc32c_intel scsi_mod ehci_pci xhci_hcd ehci_hcd wmi nvidia_drm(P=
OE) drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm agpgar=
t nvidia_uvm(OE) nvidia_modeset(POE) nvidia(POE) ipmi_devintf ipmi_msghandl=
er hid_generic hid
[170020.061024] CR2: fffff47e48011248
[170020.061027] ---[ end trace 51e55b474e252eae ]---
[170020.061029] RIP: 0010:kfree+0x4e/0x1a0
[170020.061032] Code: 80 48 01 df 0f 82 64 01 00 00 48 c7 c0 00 00 00 80 48=
 2b 05 0c 9f ef 00 48 01 c7 48 c1 ef 0c 48 c1 e7 06 48 03 3d ea 9e ef 00 <4=
8> 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa 48 8b 57 08 48 8d 42 ff
[170020.061033] RSP: 0018:ffffa9f1883f7df8 EFLAGS: 00010282
[170020.061035] RAX: 00006da180000000 RBX: 000000000044996c RCX: 0000000000=
800058
[170020.061037] RDX: 0000000000800059 RSI: ffff9262044c9fe0 RDI: fffff47e48=
011240
[170020.061038] RBP: ffff9260e4ca8e00 R08: 0000000000000001 R09: ffffffff8a=
223a2e
[170020.061039] R10: ffff926487403980 R11: ffffa9f1883f7de0 R12: ffffffff8a=
223a2e
[170020.061041] R13: ffff92648786f700 R14: 0000000000000000 R15: 0ffff92648=
786f70
[170020.061043] FS:  0000000000000000(0000) GS:ffff926487840000(0000) knlGS=
:0000000000000000
[170020.061044] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[170020.061045] CR2: fffff47e48011248 CR3: 00000001c55fe006 CR4: 0000000000=
1606e0


I only noticed this bug because I keep an eye on dmesg. In one instance,
I ignored it for a few hours, then my graphics driver crashed because of
memory allocation failure and/or heap corruption. Aside from that, I
have seen no obvious effects.

I have hit this bug at least 5 times over the last two weeks. Every
time, it has been caused by a balance on various volumes (typically to
balance a single block group). I was able to trigger it somewhat
reliably by attempting a balance on a volume with a size of 596.18GiB
and 1.68GiB of estimated free space, but that stopped working
eventually.
--=20
Cebtenzzre <cebtenzzre@gmail.com>

