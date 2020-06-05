Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223EB1EFDB4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jun 2020 18:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgFEQ1H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jun 2020 12:27:07 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:44608 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgFEQ1F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jun 2020 12:27:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49dp2H45X6z9vZ2Y
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Jun 2020 16:27:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NgHuglfgDK0r for <linux-btrfs@vger.kernel.org>;
        Fri,  5 Jun 2020 11:27:03 -0500 (CDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49dp2H16tzz9vZ2b
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Jun 2020 11:27:03 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49dp2H16tzz9vZ2b
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49dp2H16tzz9vZ2b
Received: by mail-ed1-f72.google.com with SMTP id o12so4113253edj.12
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jun 2020 09:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=WIvP0FRbwun7CTMmvfSr3LZNYtmOFSx7mJ3M1NpkWJs=;
        b=K7OTZzRN+krNuAcfdUDSNVzyexCu56vuwADOkp45B+szbf73VCr1lu435/9UUmbN6S
         3Xysdy/iU6EYd0hGGCMzfLAg5lF/G00h+S3WTIRUwzpoPy+0D6pgFS57yIgwdw16Y2Fa
         CVfhwbNyt3YFTRmOpgO98g0nl5UVX70wYb/hDJv03q0Zmp8xHE+FR/4wohDS9j4rrFC7
         YIa+RfxiG8NoIdLqu5eAPBXoZuOxn2JlrZZCUouf2G8nI561DLLuAknnOnvwxJeJroJa
         DtB0PzVHlvh7eu4nGoszMLcJloMa+pWRixGgRy0PZ86ArJjKTxiyqWAQOGjrY7TUl9Ej
         yV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WIvP0FRbwun7CTMmvfSr3LZNYtmOFSx7mJ3M1NpkWJs=;
        b=nhbPA1FbTbCns8cettQrCcrsfxuAc90Og9/j8cALqqL7iIUmvIZzxc41wz572zMZKg
         o2Om/Pvd13d4W19sITM5Pd+z6g/xLQtbe4udlgQQop3wiYGG55Sv8LhFXSqPxTX/mIVy
         OfnsIdmT4egEgRJu4ODlUWMQHMZ4dtXEkHNxONGkUvpjPqq7xK7WnPB1VKQCSKCkixjZ
         O9fpsmnBjpYZ1XYHdCrojv1BjFSMVkhiJFL3z+AhalJEvl6+dKgGIbmhIIt8NsmuIuKK
         7fY2ImmjVvFuiOWWgCPmEop5D2oAtAT66/yTAC8fGCWZd5BvfK7x5zem4LQfoTPf5W/1
         8TPA==
X-Gm-Message-State: AOAM533mIiqWdYYgHzYhfq0AD/ydl4qCK9t7dBQGfW31okLDrGQziiVn
        tLL0HNMMcmLTYFiEGtaTHtK8fR+rFkb1eCH3LLFNOQCIBOSj4gGbWeXtBeP/bYzOtiKUbn+EasY
        d4u3DOSDWbyHmO0PA1H1X4+JDXt3oNxYiK5VFj1Jsiv8=
X-Received: by 2002:a50:b0e2:: with SMTP id j89mr10270861edd.257.1591374421631;
        Fri, 05 Jun 2020 09:27:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmWOOy6EzC6jO0nBcyED30d7kQ/Sl1/vn1UxbAMezU8rSmUkbzWjfZ/VWbhF2Ffg1oLl1ck36ULIPW7sw1vfw=
X-Received: by 2002:a50:b0e2:: with SMTP id j89mr10270846edd.257.1591374421392;
 Fri, 05 Jun 2020 09:27:01 -0700 (PDT)
MIME-Version: 1.0
From:   Matt Zagrabelny <mzagrabe@d.umn.edu>
Date:   Fri, 5 Jun 2020 11:26:50 -0500
Message-ID: <CAOLfK3Wr9e+gE3v_=30etzxNr8=JgzUK5PEkq1wTDbaKCRKgZw@mail.gmail.com>
Subject: readonly btrfs
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings,

I'm getting a readonly btrfs filesystem. Here is the relevant dmesg:

Linux version 5.5.0-1-amd64 (debian-kernel@lists.debian.org) (gcc
version 9.3.0 (Debian 9.3.0-8)) #1 SMP Debian 5.5.13-2 (2020-03-30)
[...]
BTRFS error (device sda2): tree first key mismatch detected,
bytenr=165532581888 parent_transid=2459281 key
expected=(68186292224,169,1073741824) has=(68186292224,169,0)
BTRFS error (device sda2): tree first key mismatch detected,
bytenr=165532581888 parent_transid=2459281 key
expected=(68186292224,169,1073741824) has=(68186292224,169,0)
BTRFS error (device sda2): tree first key mismatch detected,
bytenr=165532581888 parent_transid=2459281 key
expected=(68186292224,169,1073741824) has=(68186292224,169,0)
BTRFS error (device sda2): tree first key mismatch detected,
bytenr=165532581888 parent_transid=2459281 key
expected=(68186292224,169,1073741824) has=(68186292224,169,0)
BTRFS error (device sda2): tree first key mismatch detected,
bytenr=165532581888 parent_transid=2459281 key
expected=(68186292224,169,1073741824) has=(68186292224,169,0)
BTRFS error (device sda2): tree first key mismatch detected,
bytenr=165532581888 parent_transid=2459281 key
expected=(68186292224,169,1073741824) has=(68186292224,169,0)
BTRFS error (device sda2): tree first key mismatch detected,
bytenr=165532581888 parent_transid=2459281 key
expected=(68186292224,169,1073741824) has=(68186292224,169,0)
BTRFS error (device sda2): tree first key mismatch detected,
bytenr=165532581888 parent_transid=2459281 key
expected=(68186292224,169,1073741824) has=(68186292224,169,0)
BTRFS error (device sda2): tree first key mismatch detected,
bytenr=165532581888 parent_transid=2459281 key
expected=(68186292224,169,1073741824) has=(68186292224,169,0)
BTRFS error (device sda2): tree first key mismatch detected,
bytenr=165532581888 parent_transid=2459281 key
expected=(68186292224,169,1073741824) has=(68186292224,169,0)
BTRFS error (device sda2): tree first key mismatch detected,
bytenr=165532581888 parent_transid=2459281 key
expected=(68186292224,169,1073741824) has=(68186292224,169,0)
------------[ cut here ]------------
BTRFS: Transaction aborted (error -117)
WARNING: CPU: 3 PID: 286 at fs/btrfs/extent-tree.c:2209
btrfs_run_delayed_refs+0x1a1/0x1f0 [btrfs]
Modules linked in: cmac bnep cpufreq_userspace cpufreq_powersave
cpufreq_conservative binfmt_misc nls_ascii nls_cp437 vfat fat
intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp
coretemp uvcvideo kvm_intel kvm btusb videobuf2_vmalloc
videobuf2_memops btrtl videobuf2_v4l2 btbcm irqbypass videobuf2_common
btintel iwldvm mac80211 bluetooth videodev dell_laptop
crct10dif_pclmul drbg ghash_clmulni_intel ansi_cprng
snd_hda_codec_hdmi snd_hda_codec_idt ecdh_generic aesni_intel
snd_hda_codec_generic ecc dell_smm_hwmon libarc4 crypto_simd crc16 mc
ledtrig_audio cryptd ppdev snd_hda_intel glue_helper joydev mei_wdt
iTCO_wdt snd_intel_dspcfg dell_wmi snd_hda_codec dell_smbios wmi_bmof
iwlwifi dell_smo8800 snd_hda_core iTCO_vendor_support intel_cstate
snd_hwdep intel_uncore snd_pcm watchdog sg intel_rapl_perf pcspkr
snd_timer serio_raw sparse_keymap parport_pc dcdbas dell_rbtn cfg80211
dell_wmi_descriptor mei_me efi_pstore snd ac efivars evdev mei parport
soundcore
 rfkill efivarfs ip_tables x_tables autofs4 btrfs blake2b_generic xor
zstd_decompress zstd_compress raid6_pq libcrc32c crc32c_generic sr_mod
cdrom sd_mod hid_generic usbhid hid nouveau mxm_wmi i2c_algo_bit ttm
ahci libahci xhci_pci drm_kms_helper libata xhci_hcd sdhci_pci
crc32_pclmul ehci_pci drm cqhci ehci_hcd psmouse crc32c_intel sdhci
i2c_i801 e1000e scsi_mod usbcore mmc_core lpc_ich ptp mfd_core
usb_common pps_core wmi battery video button
CPU: 3 PID: 286 Comm: btrfs-transacti Tainted: G        W
5.5.0-1-amd64 #1 Debian 5.5.13-2
Hardware name: Dell Inc. Latitude E6430/0H3MT5, BIOS A18 01/18/2016
RIP: 0010:btrfs_run_delayed_refs+0x1a1/0x1f0 [btrfs]
Code: 41 5f c3 49 8b 54 24 50 f0 48 0f ba aa 28 17 00 00 02 72 1b 83
f8 fb 74 37 89 c6 48 c7 c7 40 c0 84 c0 89 04 24 e8 71 47 2f f3 <0f> 0b
8b 04 24 89 c1 ba a1 08 00 00 4c 89 e7 89 04 24 48 c7 c6 00
RSP: 0018:ffffaec08084fe00 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 00000000000001a8 RCX: 0000000000000007
RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff98501dcd9a40
RBP: ffff984fb22e7d58 R08: 000000000000047c R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000001 R12: ffff98501af1ae38
R13: ffff98501bad1230 R14: ffff98501bad0378 R15: ffff984fb22e7c00
FS:  0000000000000000(0000) GS:ffff98501dcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563a7b0aa168 CR3: 000000028bc0a001 CR4: 00000000001606e0
Call Trace:
 btrfs_commit_transaction+0x57/0xa20 [btrfs]
 ? start_transaction+0xbb/0x4c0 [btrfs]
 transaction_kthread+0x13c/0x180 [btrfs]
 kthread+0xf9/0x130
 ? btrfs_cleanup_transaction+0x5c0/0x5c0 [btrfs]
 ? kthread_park+0x90/0x90
 ret_from_fork+0x35/0x40
---[ end trace 717f06ffcf003459 ]---
BTRFS: error (device sda2) in btrfs_run_delayed_refs:2209: errno=-117 unknown
BTRFS info (device sda2): forced readonly

Is this a helpful message for the developers?

Does it look like hardware failure?

I can provide more details.

Let me know what you think.

Thanks,

-Matt
