Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E85186391
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 04:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgCPDNt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 23:13:49 -0400
Received: from mail.virtall.com ([46.4.129.203]:59466 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbgCPDNt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 23:13:49 -0400
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id B90C94090B12
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Mar 2020 03:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1584328424; bh=hpHsdhzzKV8ysMGCvgu6j7CMgAe50fm+3ijh/nE8Hms=;
        h=Date:From:To:Subject;
        b=o4nK9c1GRyPcLe7/6evDu1MHF0tauuvrYfYM4S0nX8CsHqSCfu4OhVk0YOODC1fZL
         XhVVv9nIR3cOU0WZJc6Nhem147AbUJIqD3f6YxzOhD6GLEYpfNpJ39y8KzBUvVbIRF
         /l28y81Agc/TlJ8/XiCzHtWSd42mmJAw5Aic+zd9lp9f1Z+uQT1DOewsz3qOWZfhl+
         XPZJltbyBODYmlYqTsXnF41VP0ij5CIaAoWHEEcms5CsZgzf4Mw2HHIJKy7rs5ALCd
         kmxEYGOn+sTOF+zc7OiGb+ikxVOAoYv9o2E4egBfW7v+DGkG2+JIW106K5R9JFo2hz
         p+IHb25HOnvAg==
X-Fuglu-Suspect: 2c083ffb4ae846b998b900f5974b352c
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Mar 2020 03:13:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Mar 2020 12:13:36 +0900
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: kernel panic after upgrading to Linux 5.5
Message-ID: <8374ca28bc970a51b3378a5a92939c01@wpkg.org>
X-Sender: mangoo@wpkg.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After upgrading to Linux 5.5 (tried 5.5.6, 5.5.9, also 5.6.0-rc5), the 
system panics shortly after mounting and starting to use a btrfs 
filesystem. Here is a dmesg - please advise how to deal with it.
It has since crashed several times, because of panic=10 parameter 
(system boots, runs for a while, crashes, boots again, and so on).

Mount options:

noatime,ssd,space_cache=v2,user_subvol_rm_allowed



[   65.777428] BTRFS info (device sda2): enabling ssd optimizations
[   65.777435] BTRFS info (device sda2): using free space tree
[   65.777436] BTRFS info (device sda2): has skinny extents
[   98.225099] BTRFS error (device sda2): parent transid verify failed 
on 19718118866944 wanted 664218442 found 674530371
[   98.225594] BTRFS error (device sda2): parent transid verify failed 
on 19718118866944 wanted 664218442 found 674530371
[   98.225757] BTRFS warning (device sda2): error accounting new delayed 
refs extent (err code: -5), quota inconsistent
[  129.044785] ------------[ cut here ]------------
[  129.044840] WARNING: CPU: 4 PID: 4476 at fs/btrfs/qgroup.c:2523 
btrfs_qgroup_account_extents+0x211/0x250 [btrfs]
[  129.044841] Modules linked in: unix_diag binfmt_misc nf_tables 
nfnetlink ebt_ip ebtable_filter ebtables joydev input_leds hid_generic 
amd64_edac_mod edac_mce_amd kvm_amd kvm ip6table_filter ipmi_ssif 
crct10dif_pclmul ip6table_nat ip6_tables crc32_pclmul 
ghash_clmulni_intel iptable_filter xt_CHECKSUM iptable_mangle 
xt_MASQUERADE xt_comment xt_nat aesni_intel xt_tcpudp iptable_nat 
crypto_simd nf_nat drm_vram_helper cryptd drm_ttm_helper glue_helper 
nf_conntrack ttm nf_defrag_ipv6 nf_defrag_ipv4 drm_kms_helper cec 
bpfilter rc_core drm usbhid hid fb_sys_fops syscopyarea sysfillrect 
sysimgblt k10temp ccp ipmi_si ipmi_devintf ipmi_msghandler mac_hid 
sch_fq_codel ip_tables x_tables autofs4 btrfs blake2b_generic 
zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq 
async_xor async_tx xor raid6_pq raid1 raid0 multipath linear bnx2x igb 
i2c_algo_bit mdio dca libcrc32c ahci libahci i2c_piix4
[  129.044896] CPU: 4 PID: 4476 Comm: btrfs-transacti Kdump: loaded Not 
tainted 5.6.0-050600rc5-generic #202003082130
[  129.044897] Hardware name: GIGABYTE MZ31-AR0-00/MZ31-AR0-00, BIOS 
F03e 09/13/2017
[  129.044941] RIP: 0010:btrfs_qgroup_account_extents+0x211/0x250 
[btrfs]
[  129.044945] Code: 85 db 74 21 48 8b 03 48 8b 7b 08 48 83 c3 18 4c 89 
f1 4c 89 fa 4c 89 ee e8 7c 5f 6f e5 48 8b 03 48 85 c0 75 e2 e9 67 ff ff 
ff <0f> 0b 49 8b 57 18 45 31 c9 4d 8d 47 38 31 c9 4c 89 ee e8 d8 95 ff
[  129.044947] RSP: 0018:ffffadb1cef7fde8 EFLAGS: 00010246
[  129.044949] RAX: ffff9c4a4b36c300 RBX: ffff9c1a5768a550 RCX: 
0000000000000017
[  129.044951] RDX: 0000000000000001 RSI: 000011edd6f5c000 RDI: 
0000000000000000
[  129.044952] RBP: ffffadb1cef7fe38 R08: ffff9c4a4b36c300 R09: 
ffff9c4a4cb4bc00
[  129.044953] R10: 0000000000004000 R11: 0000000000000010 R12: 
0000000000000000
[  129.044954] R13: ffff9c4a59240000 R14: 0000000000000001 R15: 
ffff9c4a4b36c300
[  129.044957] FS:  0000000000000000(0000) GS:ffff9c1a5eb00000(0000) 
knlGS:0000000000000000
[  129.044958] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  129.044959] CR2: 00007f67fab03808 CR3: 0000002abae0a000 CR4: 
00000000003406e0
[  129.044961] Call Trace:
[  129.045004]  btrfs_commit_transaction+0x4dc/0x9e0 [btrfs]
[  129.045011]  ? wait_woken+0x80/0x80
[  129.045045]  transaction_kthread+0x146/0x190 [btrfs]
[  129.045051]  kthread+0x104/0x140
[  129.045083]  ? btrfs_cleanup_transaction+0x5c0/0x5c0 [btrfs]
[  129.045086]  ? kthread_park+0x90/0x90
[  129.045091]  ret_from_fork+0x22/0x40
[  129.045095] ---[ end trace e192cb9f9978caa3 ]---
[  129.094866] BTRFS error (device sda2): parent transid verify failed 
on 19718118866944 wanted 664218442 found 674530371
[  129.095331] BTRFS error (device sda2): parent transid verify failed 
on 19718118866944 wanted 664218442 found 674530371
[  129.095476] ------------[ cut here ]------------
[  129.095478] kernel BUG at mm/slub.c:304!
[  129.095551] invalid opcode: 0000 [#1] SMP NOPTI
[  129.095618] CPU: 28 PID: 4476 Comm: btrfs-transacti Kdump: loaded 
Tainted: G        W         5.6.0-050600rc5-generic #202003082130
[  129.095704] Hardware name: GIGABYTE MZ31-AR0-00/MZ31-AR0-00, BIOS 
F03e 09/13/2017
[  129.095780] RIP: 0010:__slab_free+0x183/0x330
[  129.095842] Code: 00 48 89 c7 fa 66 0f 1f 44 00 00 f0 49 0f ba 2c 24 
00 72 65 4d 3b 6c 24 20 74 11 49 0f ba 34 24 00 57 9d 0f 1f 44 00 00 eb 
9f <0f> 0b 49 3b 5c 24 28 75 e8 48 8b 44 24 28 49 89 4c 24 28 49 89 44
[  129.095953] RSP: 0018:ffffadb1cef7fcf0 EFLAGS: 00010246
[  129.096018] RAX: ffff9c1a47934c00 RBX: 0000000080800076 RCX: 
ffff9c1a47934c00
[  129.096088] RDX: ffff9c1a47934c00 RSI: ffffe1d03f1e4d00 RDI: 
ffff9c1a5e407800
[  129.096157] RBP: ffffadb1cef7fd90 R08: 0000000000000001 R09: 
ffffffffc0305740
[  129.096254] R10: ffff9c1a47934c00 R11: 0000000000000001 R12: 
ffffe1d03f1e4d00
[  129.096366] R13: ffff9c1a47934c00 R14: ffff9c1a5e407800 R15: 
ffff9c4a4b36c300
[  129.096469] FS:  0000000000000000(0000) GS:ffff9c1a5ec80000(0000) 
knlGS:0000000000000000
[  129.096596] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  129.096688] CR2: 0000555a48f94988 CR3: 0000002abae0a000 CR4: 
00000000003406e0
[  129.096785] Call Trace:
[  129.096868]  ? kfree+0x22b/0x240
[  129.096971]  ? ulist_free+0x20/0x30 [btrfs]
[  129.097074]  ? btrfs_find_all_roots_safe+0xdd/0x130 [btrfs]
[  129.097182]  ? ulist_free+0x20/0x30 [btrfs]
[  129.097270]  kfree+0x22b/0x240
[  129.097368]  ulist_free+0x20/0x30 [btrfs]
[  129.097469]  btrfs_qgroup_account_extents+0x91/0x250 [btrfs]
[  129.097577]  btrfs_commit_transaction+0x4dc/0x9e0 [btrfs]
[  129.097670]  ? wait_woken+0x80/0x80
[  129.097769]  transaction_kthread+0x146/0x190 [btrfs]
[  129.097860]  kthread+0x104/0x140
[  129.097955]  ? btrfs_cleanup_transaction+0x5c0/0x5c0 [btrfs]
[  129.098047]  ? kthread_park+0x90/0x90
[  129.098133]  ret_from_fork+0x22/0x40
[  129.098218] Modules linked in: unix_diag binfmt_misc nf_tables 
nfnetlink ebt_ip ebtable_filter ebtables joydev input_leds hid_generic 
amd64_edac_mod edac_mce_amd kvm_amd kvm ip6table_filter ipmi_ssif 
crct10dif_pclmul ip6table_nat ip6_tables crc32_pclmul 
ghash_clmulni_intel iptable_filter xt_CHECKSUM iptable_mangle 
xt_MASQUERADE xt_comment xt_nat aesni_intel xt_tcpudp iptable_nat 
crypto_simd nf_nat drm_vram_helper cryptd drm_ttm_helper glue_helper 
nf_conntrack ttm nf_defrag_ipv6 nf_defrag_ipv4 drm_kms_helper cec 
bpfilter rc_core drm usbhid hid fb_sys_fops syscopyarea sysfillrect 
sysimgblt k10temp ccp ipmi_si ipmi_devintf ipmi_msghandler mac_hid 
sch_fq_codel ip_tables x_tables autofs4 btrfs blake2b_generic 
zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq 
async_xor async_tx xor raid6_pq raid1 raid0 multipath linear bnx2x igb 
i2c_algo_bit mdio dca libcrc32c ahci libahci i2c_piix4
