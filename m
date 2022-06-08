Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F2754263D
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiFHEDv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 00:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiFHEDb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 00:03:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A7BF3383
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 18:16:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h23so30897798lfe.4
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 18:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=CrOYowYOFp82tL21o8LXK0fk8dLpFDBmFJZDjB/MQVc=;
        b=dFA4aEceqSjt8Ahdsjln24BCMPpHZ3IMmac5M7NDJPvcqSwhvynhX5odrQKw/QeG8q
         t5U2MOswUMlA0C54B0eCzrB37ImaHOWJAOJ5DwCOeX2LF1ms/f0PQnuc05/K3G/jg6Up
         EMomsHbG/MYHqxhV4ZWq7ig0/cTOzpyqaccnCzV0ScQM88IvIUoBcSSTytzSRZ/MYMja
         l0/4NxgZbQI7sDPGciBd0b8GjwKVjiWRM7h/H8sAeMj9MOa9LNtdqmpgf9NZ5rDE4qrg
         ykg4a/poxrhksYH3JP0KOC6vh1YjC7ccdJcGWGMKOspmk1S2T5vbxCqq5el9QxunPCI0
         +MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CrOYowYOFp82tL21o8LXK0fk8dLpFDBmFJZDjB/MQVc=;
        b=dHFs8i42HbCE5YIWCJEhbjQKVZ+swIRZBl0ynvJYcD8cq9UPs+JL//NXQwzsVj3gqe
         OZkiz/LCAxC+Z5EEtOAWACAT+V98zeyUkXppTVc7UZNnBn30pkY2GDC0Vzby6Vp+DEPW
         s9TLYWBVLfhEgCiS7TqVepR4kXh2uX4BMrk/qU4445QZ7Y39rHBcvYr+M4n7U5Fh7034
         P568YvOH2w/E7cLtBOyv3XHqCcphXt0yy8GZrGDmngIoi/xXkAAXchQ8aHeFrTmd+Eaa
         mEb9pGKHprMZYbHZ69DJESBhJcqkjVBnClRMbr9+j756LNJBUZ7VTEjAnb81xsohKSGi
         kt6w==
X-Gm-Message-State: AOAM530pkVSrp0TW2D5T1nN4mrfADZR4fS2wzD2jhFqrUDbsCOVU/bK+
        E/mRMzz6u2s2yvYGdcaM6RzjQB0ndRvhw02DQ6tkb24tEqrWXFTX
X-Google-Smtp-Source: ABdhPJy8VLNon4sghii23S3TmPUmO3W0an0HG+Jq2aALav1Zu9oklYJLyxzRDIrP+fKKKMi7v6NeNkXYucf/FxRuSps=
X-Received: by 2002:a05:6512:b05:b0:479:60b3:d1c1 with SMTP id
 w5-20020a0565120b0500b0047960b3d1c1mr4791128lfu.600.1654651004829; Tue, 07
 Jun 2022 18:16:44 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 7 Jun 2022 21:16:28 -0400
Message-ID: <CAJCQCtT+TdMOvZf_B6CwH15W5LTJPwf3Pj7t4XQotbK-q-gsiQ@mail.gmail.com>
Subject: bug: btrfs_commit_transaction: at fs/btrfs/extent-tree.c:2159 btrfs_run_delayed_refs
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel 5.17.5
The reporter says it happens during boot, but in Fedora we don't have
anything that's doing fs shrink during boot. I'm not seeing anything
in changelogs suggesting this has been fixed in 5.17 stable yet.

https://bugzilla.redhat.com/show_bug.cgi?id=2082022

WARNING: CPU: 11 PID: 81628 at fs/btrfs/extent-tree.c:2159
btrfs_run_delayed_refs+0x196/0x1e0
Modules linked in: binfmt_misc tls uinput dm_crypt loop rfcomm
snd_seq_dummy snd_hrtimer nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nf_tables nfnetlink qrtr bnep sunrpc vfat fat iwlmvm mac80211
intel_rapl_msr intel_rapl_common libarc4 snd_hda_codec_realtek
snd_hda_codec_generic edac_mce_amd ledtrig_audio iwlwifi
snd_hda_codec_hdmi btusb snd_hda_intel btrtl snd_intel_dspcfg btbcm
snd_intel_sdw_acpi snd_usb_audio snd_hda_codec iwlmei btintel uvcvideo
snd_hda_core snd_usbmidi_lib btmtk videobuf2_vmalloc snd_hwdep
videobuf2_memops cfg80211 kvm bluetooth snd_seq snd_rawmidi
videobuf2_v4l2 snd_seq_device videobuf2_common snd_pcm videodev
snd_timer irqbypass rapl mc gigabyte_wmi wmi_bmof snd i2c_piix4
k10temp mei ecdh_generic rfkill soundcore acpi_cpufreq gpio_amdpt
gpio_generic zram
 amdgpu crct10dif_pclmul crc32_pclmul drm_ttm_helper crc32c_intel nvme
ttm ghash_clmulni_intel ccp r8169 iommu_v2 sp5100_tco nvme_core
gpu_sched wmi ip6_tables ip_tables ipmi_devintf ipmi_msghandler fuse
i2c_dev
CPU: 11 PID: 81628 Comm: systemd-homewor Not tainted 5.17.5-300.fc36.x86_64 #1
Hardware name: CSL-Computer GmbH & Co. KG 5946/B550 AORUS ELITE V2,
BIOS F14e 10/13/2021
RIP: 0010:btrfs_run_delayed_refs+0x196/0x1e0
Code: 48 8d 91 48 0a 00 00 f0 48 0f ba 2a 03 72 20 83 f8 fb 74 39 83
f8 e2 74 34 89 c6 48 c7 c7 60 11 65 97 89 04 24 e8 e3 0f 7d 00 <0f> 0b
8b 04 24 89 c1 ba 6f 08 00 00 48 89 df 89 04 24 48 c7 c6 80
RSP: 0018:ffffba6e04ad7b68 EFLAGS: 00010296
RAX: 0000000000000026 RBX: ffff9f7d0c70a958 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff97665ad5 RDI: 00000000ffffffff
RBP: ffff9f7e0a146b78 R08: 0000000000000000 R09: ffffba6e04ad79a8
R10: ffffba6e04ad79a0 R11: 0000000000000003 R12: ffff9f7e0a146a00
R13: ffff9f7c881f3000 R14: ffff9f7c881f3000 R15: ffff9f7e0a146a00
FS:  00007f6105cf3b80(0000) GS:ffff9f8b7ecc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005593907b06d0 CR3: 000000013f79a000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 btrfs_commit_transaction+0x52/0xb00
 ? start_transaction+0xc3/0x5e0
 relocate_block_group+0x179/0x4c0
 btrfs_relocate_block_group+0x22e/0x3f0
 ? preempt_count_add+0x64/0x90
 btrfs_relocate_chunk+0x27/0xe0
 btrfs_shrink_device+0x255/0x570
 btrfs_ioctl_resize+0x2ed/0x400
 btrfs_ioctl+0x1a5a/0x2b80
 ? ioctl_has_perm.constprop.0.isra.0+0xaa/0xf0
 ? __seccomp_filter+0x27b/0x4c0
 __x64_sys_ioctl+0x8d/0xc0
 do_syscall_64+0x3a/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f610636da3f
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48
89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2
3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffcbe940430 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000029b04f5000 RCX: 00007f610636da3f
RDX: 00007ffcbe940520 RSI: 0000000050009403 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000075
R10: 00007ffcbe9401cc R11: 0000000000000246 R12: 00007ffcbe940520
R13: 0000000000000000 R14: 000000000000005d R15: 0000557c349231b0
 </TASK>

--
Chris Murphy
