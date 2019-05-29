Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF2A62DC1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2019 13:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfE2Lr6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 May 2019 07:47:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38062 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfE2Lr6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 May 2019 07:47:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so1196248qkk.5
        for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2019 04:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ceUBuHsiZpX9I/YhccjAwOKy6TwmK6r1y56IpCMv3K8=;
        b=torlbaYXocmIXl3G7a7I5jY0GuzqpRBnhDddQpKlxESudXElxPO2MPZprldoZcjhvv
         8535HEVhcJPHDU47Wa8js7RoPPm+8niowgIkmVIE7LbdrSxguJAvDnLss684fbY/syVM
         /9Crc+k7FeJFopTgUm9tEweV2cFq5Rcmy9JyLHIwwUhqprhwQE4vUb3ittoBMre2NsP+
         fCEKt8rC7cn82+cyn1QzzFwmondsUHFhecn9yQRo8tKKxt1Ahra3SJ+8Bq8Q8ftG7Mcu
         CPnrammS1C6FGvAPLnZJNfsDcJj5MilCiR6IbDL1UJwlvWSLbtGtUt2ajmdFCSTNrfiX
         fYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ceUBuHsiZpX9I/YhccjAwOKy6TwmK6r1y56IpCMv3K8=;
        b=Oh609D5vk5n/2AE+t8BE3ep2C3m0w4fXYGo4OSt3RF04l/Yazvd4mSNMt7q7rIdKgN
         17TFuuO+CGxAQ/+95t4ZpJhSw/rZm+xgWdFGl2NSZ5n9T6+x2valvrKBvZo2ZnTMxEPT
         2AzDlCUIAhKVRSK1Ts5VFnxuVFCJPB4CMc8Hx3/CB+0HapmLvdZNrwBUQOEitC7uQNAZ
         2kRKWAMouHPrH0BEnxG/xO8QLtm8oKCaEwAwgJA2E36ZZaJodcpiIUWlhOnFrN+VZ6mQ
         tbhHhpy15sUZrEzxBNLSHojGKcLM8Mc9HpmnsKl4RLPgXUeMYewoc0s6BEJPXwHEdNaT
         oz9g==
X-Gm-Message-State: APjAAAXtSQHOcjPAbolToFfkq0th6+msMTHzUhRb8HUSPUShBUguCuXY
        J0nsJRr52xNyf5SqA2S0OUm7m8/hYKKz2Gw8Il8rrfb/6AK/Gg==
X-Google-Smtp-Source: APXvYqxYHORsBirG6IuyPBwWYuWfyN4V8OFdz+4eDU/seo5ExqBuedaXGO7YkW3HGw9Vin5Vos94vAHuYrMQ1wHa3gI=
X-Received: by 2002:a05:620a:15c1:: with SMTP id o1mr54891905qkm.299.1559130476183;
 Wed, 29 May 2019 04:47:56 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?V8OoaSBDxY1uZ3J1w6w=?= <crvv.mail@gmail.com>
Date:   Wed, 29 May 2019 19:47:45 +0800
Message-ID: <CAPxZtjG1DdHN9c6adtiyDahUJ85earQS5=9skgWopYg+m_7uUQ@mail.gmail.com>
Subject: kernel BUG at fs/btrfs/relocation.c:2595! on 5.1.4
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I got the stack trace when I did "sudo btrfs device remove 4 ." from a
RAID1 file system.
The device 4 is bad.
There are many "BTRFS error (device sdb): bdev /dev/sdc errs: wr
19368749, rd 91, flush 10138, corrupt 0, gen 0" in kernel log.
(/dev/sdc is device 4)
There is no power loss.

The stack trace:
[34926.797727] ------------[ cut here ]------------
[34926.797731] kernel BUG at fs/btrfs/relocation.c:2595!
[34926.797744] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[34926.797750] CPU: 0 PID: 16275 Comm: btrfs Not tainted 5.1.4-arch1-1-ARCH #1
[34926.797754] Hardware name: Gigabyte Technology Co., Ltd. To be
filled by O.E.M./B75-DS3V, BIOS F5a 05/30/2014
[34926.797803] RIP: 0010:select_one_root+0xfc/0x110 [btrfs]
[34926.797808] Code: 34 d4 44 89 c2 45 85 c0 74 c5 4c 8b 0e 48 89 f7
48 83 ee 08 49 8b 09 4d 8b 49 20 49 83 c1 40 4c 39 c9 75 92 41 83 e8
01 eb d8 <0f> 0b 48 89 d5 eb ac 31 ed eb a8 e8 a4 0e cd fa 0f 1f 40 00
0f 1f
[34926.797817] RSP: 0018:ffffb937831aba60 EFLAGS: 00010246
[34926.797821] RAX: ffff99e7cb8c0900 RBX: ffff99e7cb8c0180 RCX: 0000000000000002
[34926.797825] RDX: 0000000000000000 RSI: ffffb937831aba68 RDI: ffff99e7cb8c0900
[34926.797829] RBP: 0000000000000000 R08: 0000000000000002 R09: ffff99e7cb8c0940
[34926.797833] R10: ffffe5db423e7dc0 R11: 0000000000000002 R12: ffffb937831abb80
[34926.797837] R13: ffff99e74f9f7920 R14: 0000000000000000 R15: ffff99e74f9f7900
[34926.797842] FS:  00007f10629188c0(0000) GS:ffff99e7db000000(0000)
knlGS:0000000000000000
[34926.797847] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[34926.797851] CR2: 00007f9d31f97340 CR3: 0000000057e48001 CR4: 00000000001606f0
[34926.797855] Call Trace:
[34926.797898]  relocate_tree_blocks+0x144/0x640 [btrfs]
[34926.797926]  ? btrfs_release_path+0x2c/0x80 [btrfs]
[34926.797961]  ? add_data_references+0x2a6/0x2c0 [btrfs]
[34926.797996]  relocate_block_group+0x433/0x5b0 [btrfs]
[34926.798031]  btrfs_relocate_block_group+0x18b/0x210 [btrfs]
[34926.798068]  btrfs_relocate_chunk+0x31/0xa0 [btrfs]
[34926.798104]  btrfs_shrink_device+0x1db/0x560 [btrfs]
[34926.798113]  ? preempt_count_sub+0x90/0xa0
[34926.798148]  btrfs_rm_device+0x171/0x590 [btrfs]
[34926.798183]  ? btrfs_ioctl+0x1d38/0x2e10 [btrfs]
[34926.798190]  ? __check_object_size+0xc1/0x175
[34926.798224]  btrfs_ioctl+0x1d7e/0x2e10 [btrfs]
[34926.798232]  ? _raw_spin_unlock+0x16/0x30
[34926.798237]  ? __handle_mm_fault+0x117d/0x15c0
[34926.798244]  ? do_vfs_ioctl+0xa4/0x630
[34926.798247]  do_vfs_ioctl+0xa4/0x630
[34926.798251]  ? handle_mm_fault+0x10a/0x250
[34926.798258]  ? syscall_trace_enter+0x1d3/0x2d0
[34926.798262]  ksys_ioctl+0x60/0x90
[34926.798266]  __x64_sys_ioctl+0x16/0x20
[34926.798271]  do_syscall_64+0x5b/0x180
[34926.798277]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[34926.798282] RIP: 0033:0x7f1062a0ccbb
[34926.798286] Code: 0f 1e fa 48 8b 05 a5 d1 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 d1 0c 00 f7 d8 64 89
01 48
[34926.798294] RSP: 002b:00007ffcef54e4a8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[34926.798300] RAX: ffffffffffffffda RBX: 00007ffcef550650 RCX: 00007f1062a0ccbb
[34926.798304] RDX: 00007ffcef54f4d0 RSI: 000000005000943a RDI: 0000000000000003
[34926.798308] RBP: 00007ffcef54f4d0 R08: 00007ffcef552820 R09: 0000000000000000
[34926.798312] R10: 00007f1062a8aae0 R11: 0000000000000246 R12: 0000000000000001
[34926.798316] R13: 0000000000000000 R14: 0000000000000003 R15: 00007ffcef550658
[34926.798322] Modules linked in: xt_nat veth nf_conntrack_netlink
nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter xt_conntrack
br_netfilter bridge cfg80211 xt_TCPMSS xt_tcpudp iptable_mangle
ipt_MASQUERADE iptable_nat rfkill nf_nat 8021q garp mrp stp
nf_conntrack llc nf_defrag_ipv6 nf_defrag_ipv4 nls_iso8859_1 nls_cp437
vfat fat snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp i915 kvm
snd_hda_intel i2c_algo_bit snd_hda_codec drm_kms_helper irqbypass
snd_hda_core crct10dif_pclmul snd_hwdep crc32_pclmul drm snd_pcm
iTCO_wdt ghash_clmulni_intel mei_hdcp iTCO_vendor_support cryptd
intel_cstate r8169 snd_timer intel_uncore realtek snd intel_rapl_perf
i2c_i801 pcspkr libphy mei_me soundcore intel_gtt lpc_ich mei agpgart
evdev syscopyarea ie31200_edac sysfillrect mac_hid pcc_cpufreq
sysimgblt fb_sys_fops nfsd auth_rpcgss nfs_acl lockd grace sunrpc
tcp_bbr sch_fq ip_tables x_tables btrfs libcrc32c crc32c_generic xor
[34926.798356]  raid6_pq sd_mod ahci libahci crc32c_intel libata
xhci_pci scsi_mod ehci_pci ehci_hcd xhci_hcd
[34926.798398] ---[ end trace b1d0f5815d520d21 ]---
[34926.798432] RIP: 0010:select_one_root+0xfc/0x110 [btrfs]
[34926.798436] Code: 34 d4 44 89 c2 45 85 c0 74 c5 4c 8b 0e 48 89 f7
48 83 ee 08 49 8b 09 4d 8b 49 20 49 83 c1 40 4c 39 c9 75 92 41 83 e8
01 eb d8 <0f> 0b 48 89 d5 eb ac 31 ed eb a8 e8 a4 0e cd fa 0f 1f 40 00
0f 1f
[34926.798444] RSP: 0018:ffffb937831aba60 EFLAGS: 00010246
[34926.798448] RAX: ffff99e7cb8c0900 RBX: ffff99e7cb8c0180 RCX: 0000000000000002
[34926.798452] RDX: 0000000000000000 RSI: ffffb937831aba68 RDI: ffff99e7cb8c0900
[34926.798456] RBP: 0000000000000000 R08: 0000000000000002 R09: ffff99e7cb8c0940
[34926.798460] R10: ffffe5db423e7dc0 R11: 0000000000000002 R12: ffffb937831abb80
[34926.798464] R13: ffff99e74f9f7920 R14: 0000000000000000 R15: ffff99e74f9f7900
[34926.798469] FS:  00007f10629188c0(0000) GS:ffff99e7db000000(0000)
knlGS:0000000000000000
[34926.798474] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[34926.798477] CR2: 00007f9d31f97340 CR3: 0000000057e48001 CR4: 00000000001606f0
