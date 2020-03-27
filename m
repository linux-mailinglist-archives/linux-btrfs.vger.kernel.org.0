Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A284E1950CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 07:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgC0F7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Mar 2020 01:59:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40206 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgC0F7U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Mar 2020 01:59:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id u10so9986820wro.7
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 22:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRfLJrTtjGisM9MJB7CpzmMqXK2LFAOdVVonzaPvjzY=;
        b=QmqkobXnN9OaEsOLtGEZvCOkBI56fe/uHJbzB2cJvczBM7tkI+ajWINXE71hDeqp/h
         2R2tAQs5BqfgoTpcnquziRYjWVhVcm0YIxjYqUg8CPLH46V9mKexoLNwyK+CRHw8DWK3
         3z5IiSljRXG7KuGbb2y4GuUAJMTUmY/otHEs/kCBaWnVMpquqHl7rQW2qVJcT+dFaUw8
         F5W5+9Bg2bI1FvG/W7xhBRyNYbVVeUkMnSce5LD74hiZjLEUxFsplBeT7O7Goj20KIIM
         CgK91ccb8redSWADXeS5y048xOemQOCcai+/c16+lY0ZQTLLlxexBVlm1cGGh8+Yxr/l
         3Mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRfLJrTtjGisM9MJB7CpzmMqXK2LFAOdVVonzaPvjzY=;
        b=aXoONbNGb60Vaw9tg8Yz7xAlC7CG+efQ6mAavnRnZPSo6rXSrK8L4TRGql4pLcuCuW
         UEtF19Evcnhdu7ia6Ezj5Sy5GsEW1SCkELd5MDNs04/X+RJs92fHZoN83OImtHRighMi
         0DNbc0pt8JuqbfozwtLSaeNa0vIrj/HRhRG6Oj07RulSd0ig12KPjUwx8xTR5H+nx+zM
         CyOi4XFRaAnyUL3cxqe4X08y20nE6ZIYZEioHcpu3c0jYi5+Ry6LSRjO16d3tNNzkDLv
         qi4HNdO3kHMXZEb/5Cnd21SNql4rP9xoZG0hD3RcHJLYXZNDn8VsRM2mVd+BOk2Qimdq
         X/9g==
X-Gm-Message-State: ANhLgQ1g/bxRPdqfiC4ShtSYkg2ux/FpSsdz/OLZrTbv4j2pZ69mfGJ3
        sJ9zsqH56ss8E8yjAFKdwG13pP1B3EcOK2XD5svnoS4W
X-Google-Smtp-Source: ADFU+vv2rXDSbTlmqGBMBqkTqflaaGRarcM/P9m9ZA0XSK7fis+SEXO/ttbsV+nIV8DfkQhJUOph8JW1VsZcvRV4UQE=
X-Received: by 2002:adf:a490:: with SMTP id g16mr13061156wrb.42.1585288756018;
 Thu, 26 Mar 2020 22:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190322041731.GF16651@hungrycats.org> <20200204050456.GB13306@hungrycats.org>
 <65514978-506f-83fa-2c95-ee9ce3cbf5b4@applied-asynchrony.com> <20200204164918.GC13306@hungrycats.org>
In-Reply-To: <20200204164918.GC13306@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 26 Mar 2020 23:59:00 -0600
Message-ID: <CAJCQCtRxiLEbD8dbWTAwqGLoGUyGxfMicx5qakqAwdVkDVs5uA@mail.gmail.com>
Subject: Re: Kernel 5.5.8 : "WARNING: CPU: 2 PID: 4150 at fs/fs-writeback.c:2363
 __writeback_inodes_sb_nr+0xa9/0xc0"
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm seeing this too, with kernel 5.5.8. It starts almost immediately
after remounting with flushoncommit.

[1098047.402847] fnuc.local kernel: BTRFS info (device sdb2): turning
on flush-on-commit
[1098047.402856] fnuc.local kernel: BTRFS info (device sdb2): disabling tree log
[1098047.402861] fnuc.local kernel: BTRFS info (device sdb2): using
free space tree
[1098053.747527] fnuc.local kernel: BTRFS info (device dm-0): turning
on flush-on-commit
[1098053.747535] fnuc.local kernel: BTRFS info (device dm-0): disabling tree log
[1098053.747538] fnuc.local kernel: BTRFS info (device dm-0): using
free space tree
[1098077.413093] fnuc.local kernel: ------------[ cut here ]------------
[1098077.413131] fnuc.local kernel: WARNING: CPU: 2 PID: 379 at
fs/fs-writeback.c:2466 __writeback_inodes_sb_nr+0xc0/0xd0
[1098077.413136] fnuc.local kernel: Modules linked in: cdc_acm
dm_crypt nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT
ip6t_REJECT nf_reject_ipv6 ip6t_rpfilter ipt_REJECT nf_reject_ipv4
xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_mangle
ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle
iptable_raw iptable_security nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter cmac bnep sunrpc
snd_hda_codec_hdmi intel_rapl_msr snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio mei_hdcp snd_hda_intel
intel_rapl_common snd_intel_dspcfg intel_powerclamp iTCO_wdt coretemp
iTCO_vendor_support snd_hda_codec kvm_intel iwlmvm mac80211 kvm
snd_hda_core libarc4 btusb irqbypass snd_hwdep snd_seq
crct10dif_pclmul iwlwifi btrtl crc32_pclmul btbcm snd_seq_device
btintel snd_pcm ghash_clmulni_intel bluetooth intel_cstate cfg80211
snd_timer snd ecdh_generic ecc soundcore r8169 mei_txe
intel_xhci_usb_role_switch mei rfkill
[1098077.413395] fnuc.local kernel:  roles i2c_i801 lpc_ich dw_dmac
intel_int0002_vgpio vfat fat binfmt_misc zram ip_tables btrfs
blake2b_generic libcrc32c xor zstd_decompress zstd_compress raid6_pq
i915 i2c_algo_bit crc32c_intel drm_kms_helper drm uas usb_storage
sdhci_acpi sdhci video mmc_core pwm_lpss_platform pwm_lpss fuse
[1098077.413515] fnuc.local kernel: CPU: 2 PID: 379 Comm:
btrfs-transacti Not tainted 5.5.8-200.fc31.x86_64 #1
[1098077.413522] fnuc.local kernel: Hardware name:  /NUC5PPYB, BIOS
PYBSWCEL.86A.0078.2019.0807.1133 08/07/2019
[1098077.413539] fnuc.local kernel: RIP: 0010:__writeback_inodes_sb_nr+0xc0/0xd0
[1098077.413553] fnuc.local kernel: Code: 0f b6 d1 48 8d 74 24 10 e8
6d fc ff ff 48 89 e7 e8 e5 fb ff ff 48 8b 44 24 50 65 48 33 04 25 28
00 00 00 75 09 48 83 c4 58 c3 <0f> 0b eb cf e8 b7 38 d9 ff 0f 1f 80 00
00 00 00 0f 1f 44 00 00 31
[1098077.413561] fnuc.local kernel: RSP: 0018:ffffabed404a7df0 EFLAGS: 00010246
[1098077.413572] fnuc.local kernel: RAX: 0000000000000000 RBX:
ffff8cc172cfc960 RCX: 0000000000000000
[1098077.413578] fnuc.local kernel: RDX: 0000000000000002 RSI:
0000000000001d2a RDI: ffff8cc17abf5000
[1098077.413585] fnuc.local kernel: RBP: ffff8cc176b84e38 R08:
ffff8cc17666e800 R09: ffffabed404a7de8
[1098077.413592] fnuc.local kernel: R10: ffff8cc048cd3758 R11:
000000000003c000 R12: ffff8cc172cf0000
[1098077.413599] fnuc.local kernel: R13: ffff8cc13dc2a000 R14:
ffff8cc172cfc938 R15: ffff8cc13dc2a000
[1098077.413608] fnuc.local kernel: FS:  0000000000000000(0000)
GS:ffff8cc17bd00000(0000) knlGS:0000000000000000
[1098077.413614] fnuc.local kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
[1098077.413621] fnuc.local kernel: CR2: 0000555defae5e90 CR3:
000000014b60a000 CR4: 00000000001006e0
[1098077.413626] fnuc.local kernel: Call Trace:
[1098077.413820] fnuc.local kernel:
btrfs_commit_transaction+0x303/0xa20 [btrfs]
[1098077.413977] fnuc.local kernel:  ? start_transaction+0xbb/0x4c0 [btrfs]
[1098077.414124] fnuc.local kernel:  transaction_kthread+0x13c/0x180 [btrfs]
[1098077.414146] fnuc.local kernel:  kthread+0xf9/0x130
[1098077.414292] fnuc.local kernel:  ?
btrfs_cleanup_transaction+0x5c0/0x5c0 [btrfs]
[1098077.414306] fnuc.local kernel:  ? kthread_park+0x90/0x90
[1098077.414323] fnuc.local kernel:  ret_from_fork+0x35/0x40
[1098077.414340] fnuc.local kernel: ---[ end trace a3fc4c6144f1f7ae ]---
[1098107.620280] fnuc.local kernel: ------------[ cut here ]------------

--
Chris Murphy
