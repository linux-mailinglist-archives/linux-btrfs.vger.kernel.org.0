Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76B3E3D1B
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 22:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfJXUXp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 16:23:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40698 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfJXUXp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 16:23:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id u22so80299lji.7
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Cd+q0lrvKIogSrtZO8F+Mpan06mcbC6EZTUnHaJLW0=;
        b=YZVdrzTV0P/JmIYszgzLBFbGWwjTZinYFs/6gDzptYgm0PQSXON1CGaa8pHluh6zoq
         o3Zj+z76UnYYXgasgHmEEqEclBxZaSmlZmIS2+jpycHjhhbLLfWAqkv/riAeVg+OuwbF
         BAxL5uZApzCjhIexPZPMy5kp2u0vSPpYkrcCNKel4RGI/k3N9l9MTmPZYA/arfo4Eu6V
         13F8vf3VOz5RePNOuw08IumTvQqjNNAcf7CQf/uNAHPYKPID0elnsxcSvBOSBGPub9u0
         THIbH/OTpzhZ8jsvV+LqcocumrWQ/yziX5ZnayG9RDP37WZn1E7m+56yLiCeghDGkRS0
         z5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Cd+q0lrvKIogSrtZO8F+Mpan06mcbC6EZTUnHaJLW0=;
        b=h6KMVlyoAEx9Ciqm5Gmahqo5mvPAzzbSccQMnfRLipAd5WKfEIFBQ7X19URfkAKOvB
         KiVc6JOq+PKB4W7ro4PeUAL2GYHZdte2nSfMkVf3Q6T8nC6nRS08WVJbBK+O0jopDVH6
         UmneEU4oLWfk7OU0VkMDezAJlfpNiVk5gj+nqEisEQ3j/hOX/vs6z/amEu5fRenJP1Mx
         TxQv5lvDYM/rvMH0vH37lEuy8EpMJmVasiLNCNNGbxRusX/8pm4ym/Y3+HwNUqTGr9mV
         e4tZNrp4UyybikCkXVKgu8berBaznmfXQxWwdTdNIujLRbTP9CpUZlsqmjKnyHdiNBfz
         n+sw==
X-Gm-Message-State: APjAAAW4gMbmmWRKjRMD8Byr4kEED/ONIcWZrg2TPd6mzsOYk3j0JUBl
        ib4fURlex7pV068CQkHWCDp/ri9EIk6JRsQRwfjGM5tnqi0=
X-Google-Smtp-Source: APXvYqw9KlVPenRqv7JchnIaHR6Ff8Rh2x/bnBYhTYBHtQHKL65gkFvneq+coF9O9gGPyPOzVtQV2XQxpqlRJag4tZI=
X-Received: by 2002:a2e:7405:: with SMTP id p5mr2342599ljc.191.1571948620938;
 Thu, 24 Oct 2019 13:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <CALpSwpjVz=F_hb9DbVanECsfWOYog2B7SLY=Dy0NvQx=w9voDA@mail.gmail.com>
 <f4037f43-97fb-5a25-52db-2d69ec69f6ee@suse.de> <3acc15f7-fe1e-6672-8a89-fba9a09561d4@suse.de>
In-Reply-To: <3acc15f7-fe1e-6672-8a89-fba9a09561d4@suse.de>
From:   Peter Hjalmarsson <kanelxake@gmail.com>
Date:   Thu, 24 Oct 2019 22:23:29 +0200
Message-ID: <CALpSwpgFiOo+KxZ13TD_YY0mx2vZ4BLMo=qBeaagHrA=UgW9Mw@mail.gmail.com>
Subject: Re: "BUG: kernel NULL pointer dereference," when unmounting
 filesystem hitted by enospc error
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Sorry for late answer. Have been out of town for work.
Interesting that you could not reproduce. What kind of system do you run?
I have tried on a couple of system now, and they behave slightly
different, so maybe it has something to do with which arch it runs
what kind of crash it triggers if any?
Also make sure that the "dd"-line in the script is not wrapped like it
became in the mail.

For me running trough the test in a couple of systems, I found the followin=
g:

The systems that always crashes did that during the first or the
second run of the script (so probably no need to run for longer than
maybe three to four times to verify).

Two systems passes 5 times (32 bit arm)
One system crashes during umount with a slightly different traceback
but essential the same as previously reported Pine64 Rock64 rk3328:
[503397.433500] Call trace:
[503397.436338]  __free_pages+0x1c/0x80
[503397.440506]  __free_raid_bio+0x84/0xf8 [btrfs]
[503397.445713]  __remove_rbio_from_cache+0x134/0x1b8 [btrfs]
[503397.451957]  btrfs_clear_rbio_cache.isra.0+0x5c/0x98 [btrfs]
[503397.458473]  btrfs_free_stripe_hash_table+0x24/0x40 [btrfs]
[503397.464891]  close_ctree+0x1b0/0x2c8 [btrfs]
[503397.469851]  btrfs_put_super+0x20/0x30 [btrfs]

Two system crashes (one x86_64 Atom, one RPI3 arch64) during balance
with a dmesg like:
[10282.926420] Call Trace:
[10282.926488]  lock_stripe_add+0x292/0x370 [btrfs]
[10282.926560]  __raid56_parity_write+0x20/0x40 [btrfs]
[10282.926633]  run_plug+0x131/0x150 [btrfs]
[10282.926671]  blk_flush_plug_list+0xc2/0x110
[10282.926708]  blk_finish_plug+0x21/0x2e
[10282.926769]  btrfs_write_and_wait_transaction.isra.0+0x57/0xa0 [btrfs]
[10282.926851]  btrfs_commit_transaction+0x72e/0x9a0 [btrfs]

Three system crashes (three x86_64, the one "tainted" has nvidia
binary blobs) during umount with a dmesg like:
[  658.646613] Call Trace:
[  658.646675]  __free_raid_bio+0x72/0xb0 [btrfs]
[  658.646728]  btrfs_free_stripe_hash_table+0x3d/0x70 [btrfs]
[  658.646766]  close_ctree+0x1ea/0x2f0 [btrfs]
[  658.646773]  generic_shutdown_super+0x6c/0x100
[  658.646778]  kill_anon_super+0x14/0x30
[  658.646808]  btrfs_kill_super+0x12/0xa0 [btrfs]

All full dmesg saved if you want to look at any of the other not posted bel=
ow.

dmesg for the three x86_64 crashes during umount as follows (since
that was what I reported in this thread):
[ 7322.868716] BUG: kernel NULL pointer dereference, address: 0000000000000=
2ce
[ 7322.868720] #PF: supervisor read access in kernel mode
[ 7322.868721] #PF: error_code(0x0000) - not-present page
[ 7322.868722] PGD 0 P4D 0
[ 7322.868725] Oops: 0000 [#1] SMP PTI
[ 7322.868727] CPU: 1 PID: 18329 Comm: umount Tainted: P           OE
   5.3.6-200.fc30.x86_64 #1
[ 7322.868728] Hardware name: System manufacturer System Product
Name/Z170 PRO GAMING, BIOS 3805 05/16/2018
[ 7322.868733] RIP: 0010:__free_pages+0x5/0x30
[ 7322.868735] Code: 00 48 89 c3 fa 66 0f 1f 44 00 00 48 89 ef 4c 89
e6 e8 2f ef ff ff 48 89 df 57 9d 0f 1f 44 00 00 5b 5d 41 5c c3 0f 1f
44 00 00 <8b> 47 34 85 c0 74 12 f0 ff 4f 34 75 06 85 f6 75 03 eb 88 c3
e9 82
[ 7322.868737] RSP: 0018:ffffb481d632fdb0 EFLAGS: 00010046
[ 7322.868738] RAX: ffff8932a0b32118 RBX: 0000000000000045 RCX: 00000000000=
00000
[ 7322.868740] RDX: ffff893366a6e2f0 RSI: 0000000000000000 RDI: 00000000000=
0029a
[ 7322.868741] RBP: ffff8932a0b32000 R08: ffffd62ac0e41b48 R09: ffffd62ac0e=
41b48
[ 7322.868742] R10: 000000000004f4b1 R11: ffffd62ac055d220 R12: 00000000000=
00045
[ 7322.868743] R13: ffff893135a20010 R14: ffff89326792e72c R15: ffff8932679=
2e6f8
[ 7322.868744] FS:  00007fc8c95d8080(0000) GS:ffff893366a40000(0000)
knlGS:0000000000000000
[ 7322.868746] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7322.868747] CR2: 00000000000002ce CR3: 0000000085bd6001 CR4: 00000000003=
606e0
[ 7322.868748] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 7322.868749] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 7322.868750] Call Trace:
[ 7322.868782]  __free_raid_bio+0x72/0xb0 [btrfs]
[ 7322.868809]  btrfs_free_stripe_hash_table+0x3d/0x70 [btrfs]
[ 7322.868827]  close_ctree+0x1ea/0x2f0 [btrfs]
[ 7322.868831]  generic_shutdown_super+0x6c/0x100
[ 7322.868834]  kill_anon_super+0x14/0x30
[ 7322.868848]  btrfs_kill_super+0x12/0xa0 [btrfs]
[ 7322.868851]  deactivate_locked_super+0x36/0x70
[ 7322.868853]  cleanup_mnt+0x104/0x150
[ 7322.868856]  task_work_run+0x87/0xa0
[ 7322.868860]  exit_to_usermode_loop+0xda/0x100
[ 7322.868862]  do_syscall_64+0x183/0x1a0
[ 7322.868866]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 7322.868868] RIP: 0033:0x7fc8c982358b
[ 7322.868870] Code: 39 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3
0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cd 38 0c 00 f7 d8 64 89
01 48
[ 7322.868872] RSP: 002b:00007ffd1ba2b9f8 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[ 7322.868873] RAX: 0000000000000000 RBX: 00007fc8c994e1c4 RCX: 00007fc8c98=
2358b
[ 7322.868874] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005558839=
3a6f0
[ 7322.868875] RBP: 000055588393a4e0 R08: 0000000000000000 R09: 00007ffd1ba=
2a7a0
[ 7322.868876] R10: 000055588393b750 R11: 0000000000000246 R12: 00005558839=
3a6f0
[ 7322.868877] R13: 0000000000000000 R14: 000055588393a5d8 R15: 00000000000=
00000
[ 7322.868879] Modules linked in: zram rpcsec_gss_krb5 auth_rpcgss
nfsv4 dns_resolver nfs lockd grace rfcomm fuse xt_CHECKSUM
xt_MASQUERADE tun xt_addrtype br_netfilter bridge stp llc
nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_rpfilter
ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack
ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw
iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
iptable_filter ip_tables overlay cmac bnep nct6775 cachefiles
hwmon_vid fscache sunrpc vfat fat nvidia_drm(POE) nvidia_modeset(POE)
nvidia_uvm(OE) nvidia(POE) intel_rapl_msr intel_rapl_common
snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp coretemp
kvm_intel snd_hda_codec_realtek snd_hda_codec_generic kvm
ledtrig_audio irqbypass snd_hda_intel btusb snd_hda_codec btrtl btbcm
btintel crct10dif_pclmul snd_hda_core
[ 7322.868904]  ucsi_ccg crc32_pclmul typec_ucsi bluetooth snd_hwdep
mei_hdcp typec snd_seq eeepc_wmi iTCO_wdt ghash_clmulni_intel
iTCO_vendor_support asus_wmi intel_cstate snd_seq_device intel_uncore
intel_rapl_perf wmi_bmof sparse_keymap drm_kms_helper snd_pcm
ecdh_generic i2c_i801 rfkill mei_me ecc snd_timer drm cp210x mei snd
ipmi_devintf soundcore i2c_nvidia_gpu ipmi_msghandler acpi_pad
binfmt_misc btrfs libcrc32c xor zstd_decompress zstd_compress raid6_pq
mxm_wmi e1000e nvme crc32c_intel nvme_core wmi video [last unloaded:
zram]
[ 7322.868923] CR2: 00000000000002ce
[ 7322.868924] ---[ end trace 9c6f3e1ed9db6ba7 ]---
[ 7322.868927] RIP: 0010:__free_pages+0x5/0x30
[ 7322.868929] Code: 00 48 89 c3 fa 66 0f 1f 44 00 00 48 89 ef 4c 89
e6 e8 2f ef ff ff 48 89 df 57 9d 0f 1f 44 00 00 5b 5d 41 5c c3 0f 1f
44 00 00 <8b> 47 34 85 c0 74 12 f0 ff 4f 34 75 06 85 f6 75 03 eb 88 c3
e9 82
[ 7322.868930] RSP: 0018:ffffb481d632fdb0 EFLAGS: 00010046
[ 7322.868931] RAX: ffff8932a0b32118 RBX: 0000000000000045 RCX: 00000000000=
00000
[ 7322.868932] RDX: ffff893366a6e2f0 RSI: 0000000000000000 RDI: 00000000000=
0029a
[ 7322.868933] RBP: ffff8932a0b32000 R08: ffffd62ac0e41b48 R09: ffffd62ac0e=
41b48
[ 7322.868934] R10: 000000000004f4b1 R11: ffffd62ac055d220 R12: 00000000000=
00045
[ 7322.868935] R13: ffff893135a20010 R14: ffff89326792e72c R15: ffff8932679=
2e6f8
[ 7322.868937] FS:  00007fc8c95d8080(0000) GS:ffff893366a40000(0000)
knlGS:0000000000000000
[ 7322.868938] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7322.868939] CR2: 00000000000002ce CR3: 0000000085bd6001 CR4: 00000000003=
606e0
[ 7322.868940] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 7322.868941] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400


[ 3270.915492] BUG: kernel NULL pointer dereference, address: 0000000000000=
2d1
[ 3270.915499] #PF: supervisor read access in kernel mode
[ 3270.915502] #PF: error_code(0x0000) - not-present page
[ 3270.915504] PGD 0 P4D 0
[ 3270.915509] Oops: 0000 [#1] SMP PTI
[ 3270.915514] CPU: 1 PID: 2578 Comm: umount Not tainted
5.3.6-200.fc30.x86_64 #1
[ 3270.915516] Hardware name: System manufacturer System Product
Name/P7P55D-E LX, BIOS 1701    09/27/2012
[ 3270.915525] RIP: 0010:__free_pages+0x5/0x30
[ 3270.915529] Code: 90 48 89 c3 fa 66 66 90 66 66 90 48 89 ef 4c 89
e6 e8 2f ef ff ff 48 89 df 57 9d 66 66 90 66 90 5b 5d 41 5c c3 66 66
66 66 90 <8b> 47 34 85 c0 74 12 f0 ff 4f 34 75 06 85 f6 75 03 eb 88 c3
e9 82
[ 3270.915532] RSP: 0018:ffffb41a52367db0 EFLAGS: 00010046
[ 3270.915535] RAX: ffffa01a356ed918 RBX: 0000000000000045 RCX: 00000000000=
00000
[ 3270.915538] RDX: ffffa01ad586e350 RSI: 0000000000000000 RDI: 00000000000=
0029d
[ 3270.915541] RBP: ffffa01a356ed800 R08: fffff43e482f9688 R09: fffff43e482=
f9688
[ 3270.915543] R10: 000000000021592f R11: fffff43e482b8420 R12: 00000000000=
00045
[ 3270.915546] R13: ffffa01a63040010 R14: ffffa01a6ae125ec R15: ffffa01a6ae=
125b8
[ 3270.915549] FS:  00007fbfce760080(0000) GS:ffffa01ad5840000(0000)
knlGS:0000000000000000
[ 3270.915552] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3270.915554] CR2: 00000000000002d1 CR3: 000000020b64c000 CR4: 00000000000=
006e0
[ 3270.915557] Call Trace:
[ 3270.915617]  __free_raid_bio+0x72/0xb0 [btrfs]
[ 3270.915668]  btrfs_free_stripe_hash_table+0x3d/0x70 [btrfs]
[ 3270.915709]  close_ctree+0x1ea/0x2f0 [btrfs]
[ 3270.915715]  generic_shutdown_super+0x6c/0x100
[ 3270.915720]  kill_anon_super+0x14/0x30
[ 3270.915751]  btrfs_kill_super+0x12/0xa0 [btrfs]
[ 3270.915756]  deactivate_locked_super+0x36/0x70
[ 3270.915760]  cleanup_mnt+0x104/0x150
[ 3270.915765]  task_work_run+0x87/0xa0
[ 3270.915771]  exit_to_usermode_loop+0xda/0x100
[ 3270.915776]  do_syscall_64+0x183/0x1a0
[ 3270.915782]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 3270.915786] RIP: 0033:0x7fbfce9ab58b
[ 3270.915790] Code: 39 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3
0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cd 38 0c 00 f7 d8 64 89
01 48
[ 3270.915792] RSP: 002b:00007ffcf5f6a918 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[ 3270.915796] RAX: 0000000000000000 RBX: 00007fbfcead61c4 RCX: 00007fbfce9=
ab58b
[ 3270.915798] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055b3dcd=
106f0
[ 3270.915801] RBP: 000055b3dcd104e0 R08: 0000000000000000 R09: 00007ffcf5f=
696c0
[ 3270.915803] R10: 000055b3dcd10710 R11: 0000000000000246 R12: 000055b3dcd=
106f0
[ 3270.915805] R13: 0000000000000000 R14: 000055b3dcd105d8 R15: 00000000000=
00000
[ 3270.915809] Modules linked in: zram rpcsec_gss_krb5 auth_rpcgss
nfsv4 dns_resolver nfs lockd grace sunrpc rfcomm bluetooth
ecdh_generic rfkill ecc ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ebtable_broute
ip6table_nat ip6table_mangle ip6table_raw ip6table_security
iptable_nat nf_nat iptable_mangle iptable_raw iptable_security
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter
ip_tables intel_powerclamp kvm_intel kvm irqbypass snd_hda_codec_via
iTCO_wdt snd_hda_codec_generic iTCO_vendor_support intel_cstate
intel_uncore snd_hda_codec_hdmi ledtrig_audio uinput snd_hda_intel
snd_hda_codec cachefiles fscache hwmon_vid coretemp snd_hda_core
i7core_edac snd_hwdep xpad i2c_i801 snd_seq joydev ff_memless lpc_ich
snd_seq_device snd_pcm asus_atk0110 snd_timer snd soundcore
acpi_cpufreq amdgpu amd_iommu_v2 gpu_sched btrfs radeon libcrc32c xor
zstd_decompress zstd_compress
[ 3270.915860]  raid6_pq i2c_algo_bit drm_kms_helper crc32c_intel ttm
serio_raw drm r8169
[ 3270.915870] CR2: 00000000000002d1
[ 3270.915874] ---[ end trace 03b4a864514336a0 ]---
[ 3270.915879] RIP: 0010:__free_pages+0x5/0x30
[ 3270.915882] Code: 90 48 89 c3 fa 66 66 90 66 66 90 48 89 ef 4c 89
e6 e8 2f ef ff ff 48 89 df 57 9d 66 66 90 66 90 5b 5d 41 5c c3 66 66
66 66 90 <8b> 47 34 85 c0 74 12 f0 ff 4f 34 75 06 85 f6 75 03 eb 88 c3
e9 82
[ 3270.915885] RSP: 0018:ffffb41a52367db0 EFLAGS: 00010046
[ 3270.915888] RAX: ffffa01a356ed918 RBX: 0000000000000045 RCX: 00000000000=
00000
[ 3270.915890] RDX: ffffa01ad586e350 RSI: 0000000000000000 RDI: 00000000000=
0029d
[ 3270.915893] RBP: ffffa01a356ed800 R08: fffff43e482f9688 R09: fffff43e482=
f9688
[ 3270.915895] R10: 000000000021592f R11: fffff43e482b8420 R12: 00000000000=
00045
[ 3270.915898] R13: ffffa01a63040010 R14: ffffa01a6ae125ec R15: ffffa01a6ae=
125b8
[ 3270.915901] FS:  00007fbfce760080(0000) GS:ffffa01ad5840000(0000)
knlGS:0000000000000000
[ 3270.915904] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3270.915906] CR2: 00000000000002d1 CR3: 000000020b64c000 CR4: 00000000000=
006e0


[  658.646553] BUG: kernel NULL pointer dereference, address: 0000000000000=
2d1
[  658.646560] #PF: supervisor read access in kernel mode
[  658.646562] #PF: error_code(0x0000) - not-present page
[  658.646564] PGD 0 P4D 0
[  658.646569] Oops: 0000 [#1] SMP PTI
[  658.646574] CPU: 0 PID: 6418 Comm: umount Not tainted
5.3.6-300.fc31.x86_64 #1
[  658.646576] Hardware name: LENOVO 80JV/Lenovo U41-70, BIOS BDCN71WW
08/03/2016
[  658.646584] RIP: 0010:__free_pages+0x5/0x30
[  658.646588] Code: 00 48 89 c3 fa 66 0f 1f 44 00 00 48 89 ef 4c 89
e6 e8 2f ef ff ff 48 89 df 57 9d 0f 1f 44 00 00 5b 5d 41 5c c3 0f 1f
44 00 00 <8b> 47 34 85 c0 74 12 f0 ff 4f 34 75 06 85 f6 75 03 eb 88 c3
e9 82
[  658.646591] RSP: 0018:ffffb23bc8d73db0 EFLAGS: 00010046
[  658.646594] RAX: ffff9d285707c918 RBX: 0000000000000045 RCX: 00000000000=
00000
[  658.646597] RDX: ffff9d290ea2e2f0 RSI: 0000000000000000 RDI: 00000000000=
0029d
[  658.646599] RBP: ffff9d285707c800 R08: ffffdc18806c2d48 R09: ffffdc18806=
c2d48
[  658.646601] R10: 000000000001b12d R11: ffffdc1888e5a020 R12: 00000000000=
00045
[  658.646603] R13: ffff9d2825350010 R14: ffff9d2882cec66c R15: ffff9d2882c=
ec638
[  658.646606] FS:  00007f28dbf23c80(0000) GS:ffff9d290ea00000(0000)
knlGS:0000000000000000
[  658.646609] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  658.646611] CR2: 00000000000002d1 CR3: 0000000092fd0003 CR4: 00000000003=
606f0
[  658.646613] Call Trace:
[  658.646675]  __free_raid_bio+0x72/0xb0 [btrfs]
[  658.646728]  btrfs_free_stripe_hash_table+0x3d/0x70 [btrfs]
[  658.646766]  close_ctree+0x1ea/0x2f0 [btrfs]
[  658.646773]  generic_shutdown_super+0x6c/0x100
[  658.646778]  kill_anon_super+0x14/0x30
[  658.646808]  btrfs_kill_super+0x12/0xa0 [btrfs]
[  658.646814]  deactivate_locked_super+0x36/0x70
[  658.646819]  cleanup_mnt+0x104/0x150
[  658.646825]  task_work_run+0x87/0xa0
[  658.646831]  exit_to_usermode_loop+0xda/0x100
[  658.646836]  do_syscall_64+0x183/0x1a0
[  658.646843]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  658.646847] RIP: 0033:0x7f28dc16e67b
[  658.646851] Code: 08 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3
0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d dd 07 0c 00 f7 d8 64 89
01 48
[  658.646854] RSP: 002b:00007ffe46290828 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[  658.646858] RAX: 0000000000000000 RBX: 00007f28dc2981e4 RCX: 00007f28dc1=
6e67b
[  658.646860] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055d87bf=
48730
[  658.646862] RBP: 000055d87bf48520 R08: 0000000000000000 R09: 00007ffe462=
8f5a0
[  658.646864] R10: 000055d87bf49750 R11: 0000000000000246 R12: 000055d87bf=
48730
[  658.646867] R13: 0000000000000000 R14: 000055d87bf48618 R15: 00000000000=
00000
[  658.646870] Modules linked in: zram uinput rfcomm ccm xt_CHECKSUM
xt_MASQUERADE nf_nat_tftp nf_conntrack_tftp nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_CT ip6t_REJECT nf_reject_ipv6 ip6t_rpfilter
ipt_REJECT nf_reject_ipv4 xt_conntrack tun bridge ebtable_nat stp
ebtable_broute ip6table_nat llc ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat iptable_mangle ip6_udp_tunnel
udp_tunnel iptable_raw iptable_security nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter cmac bnep cachefiles fscache
sunrpc vfat fat intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel snd_hda_codec_realtek iwlmvm
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi mei_hdcp
snd_hda_intel mac80211 kvm snd_hda_codec uvcvideo libarc4 snd_hda_core
videobuf2_vmalloc iwlwifi btusb snd_hwdep videobuf2_memops irqbypass
snd_seq videobuf2_v4l2 btrtl btbcm btintel snd_seq_device
[  658.646916]  videobuf2_common intel_cstate intel_uncore snd_pcm
videodev mc intel_rapl_perf bluetooth cfg80211 asus_wmi joydev
input_polldev wmi_bmof i2c_i801 mei_me intel_wmi_thunderbolt wdat_wdt
snd_timer intel_pch_thermal ecdh_generic ecc mei snd soundcore lpc_ich
ideapad_laptop sparse_keymap rfkill acpi_pad lz4 lz4_compress
binfmt_misc ip_tables btrfs libcrc32c xor zstd_decompress
zstd_compress raid6_pq dm_crypt i915 nouveau crct10dif_pclmul
crc32_pclmul crc32c_intel mxm_wmi ttm i2c_algo_bit drm_kms_helper
ghash_clmulni_intel drm serio_raw r8169 wmi video fuse [last unloaded:
zram]
[  658.646954] CR2: 00000000000002d1
[  658.646958] ---[ end trace 0e45be4afd3f4e04 ]---
[  658.646964] RIP: 0010:__free_pages+0x5/0x30
[  658.646967] Code: 00 48 89 c3 fa 66 0f 1f 44 00 00 48 89 ef 4c 89
e6 e8 2f ef ff ff 48 89 df 57 9d 0f 1f 44 00 00 5b 5d 41 5c c3 0f 1f
44 00 00 <8b> 47 34 85 c0 74 12 f0 ff 4f 34 75 06 85 f6 75 03 eb 88 c3
e9 82
[  658.646970] RSP: 0018:ffffb23bc8d73db0 EFLAGS: 00010046
[  658.646973] RAX: ffff9d285707c918 RBX: 0000000000000045 RCX: 00000000000=
00000
[  658.646975] RDX: ffff9d290ea2e2f0 RSI: 0000000000000000 RDI: 00000000000=
0029d
[  658.646978] RBP: ffff9d285707c800 R08: ffffdc18806c2d48 R09: ffffdc18806=
c2d48
[  658.646980] R10: 000000000001b12d R11: ffffdc1888e5a020 R12: 00000000000=
00045
[  658.646982] R13: ffff9d2825350010 R14: ffff9d2882cec66c R15: ffff9d2882c=
ec638
[  658.646986] FS:  00007f28dbf23c80(0000) GS:ffff9d290ea00000(0000)
knlGS:0000000000000000
[  658.646988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  658.646991] CR2: 00000000000002d1 CR3: 0000000092fd0003 CR4: 00000000003=
606f0


BR,
Peter Hjalmarsson

Den m=C3=A5n 21 okt. 2019 kl 16:33 skrev Johannes Thumshirn <jthumshirn@sus=
e.de>:
>
> On 21/10/2019 11:17, Johannes Thumshirn wrote:
> [...]
> >> -----
> >> $ cat run-btrfs-test
> >> modprobe -iv zram num_devices=3D8
> >> udevadm trigger
> >> sync
> >> zramctl /dev/zram0 -s 8G && \
> >> zramctl /dev/zram1 -s 8G && \
> >> zramctl /dev/zram2 -s 4G && \
> >> zramctl /dev/zram3 -s 4G && \
> >> zramctl /dev/zram4 -s 4G && \
> >> zramctl /dev/zram5 -s 2G && \
> >> zramctl /dev/zram6 -s 2G && \
> >> zramctl /dev/zram7 -s 4G && \
> >> mkfs.btrfs /dev/zram0 && \
> >> mkdir -p /mnt/btrfs-test && \
> >> mount /dev/zram0 /mnt/btrfs-test && \
> >> echo "FS Mounted" && \
> >> btrfs dev add /dev/zram1 /mnt/btrfs-test && \
> >> echo "Devices added" && \
> >> for int in {1..500} ; do dd if=3D/dev/zero of=3D/mnt/btrfs-test/file${=
int}
> >> bs=3D32M count=3D1 && sync ; done
> >> btrfs dev add /dev/zram[2-7] /mnt/btrfs-test && \
> >> btrfs fi sh /mnt/btrfs-test && \
> >> btrfs fi df /mnt/btrfs-test && \
> >> btrfs bal star -mconvert=3Draid6 /mnt/btrfs-test && \
> >> btrfs bal star -dconvert=3Draid6 /mnt/btrfs-test
> >> btrfs fi sh /mnt/btrfs-test && \
> >> btrfs fi df /mnt/btrfs-test
>
> I'm sorry. I ran this script in a loop for 35 iterations on 5.3.6 and
> couldn't reproduce a single crash.
>
>
> Is there anything else needed?
> --
> Johannes Thumshirn                            SUSE Labs Filesystems
> jthumshirn@suse.de                                +49 911 74053 689
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5
> 90409 N=C3=BCrnberg
> Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
> Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
