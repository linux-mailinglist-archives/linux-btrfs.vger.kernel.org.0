Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDBF19E8C1
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Apr 2020 05:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDEDIB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Apr 2020 23:08:01 -0400
Received: from mailgw-01.dd24.net ([193.46.215.41]:34316 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgDEDIA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Apr 2020 23:08:00 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-01.dd24.net (Postfix) with ESMTP id 6455060071
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Apr 2020 03:07:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id qrnQS_HK9CRr for <linux-btrfs@vger.kernel.org>;
        Sun,  5 Apr 2020 03:07:55 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-46-244-252-139.dynamic.mnet-online.de [46.244.252.139])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Apr 2020 03:07:55 +0000 (UTC)
Message-ID: <f7276df6f122a38d5307c78bc69c1a784fb474ab.camel@scientia.net>
Subject: bug: btrfs send/receive crashes when computer is suspended
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Sun, 05 Apr 2020 05:07:55 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

I think I've noticed that much earlier already, then when a "btrfs send
| btrfs receive" pipe received SIGSTOP, ... it seems that when such
pipe is running while the computer is suspended... it crashes for no
good reason:
root@heisenberg:/mnt/snapshots/root# btrfs send 2020-04-04_1 | btrfs receive /data/e/1/snapshots/_external-fs/heisenberg.scientia.net/root/ ; echo $?
At subvol 2020-04-04_1
At subvol 2020-04-04_1
ERROR: crc32 mismatch in command
1


It even seems that it somehow prevented the suspend to fully finish, at
least on my system:
While e.g. the screen was shut off and external USB devices, too, the
fan of the CPU continued to run and the LEDs didn't get the typical
I'm-suspended flashing pattern.
Powering on didn't work either immediately... only after several
minutes and closing/opening the lid again the system came back (then
with the btrfs send|receive pipe died as above).


In he kernel log I found this:
Apr  4 05:45:23 heisenberg kernel: [ 9177.331422] PM: suspend entry (deep)
Apr  4 05:45:29 heisenberg kernel: [ 9183.131964] Filesystems sync: 5.800 seconds
Apr  4 05:45:49 heisenberg kernel: [ 9183.139754] (NULL device *): firmware: direct-loading firmware regulatory.db.p7s
Apr  4 05:45:49 heisenberg kernel: [ 9183.139918] (NULL device *): firmware: direct-loading firmware regulatory.db
Apr  4 05:45:49 heisenberg kernel: [ 9183.139961] (NULL device *): firmware: direct-loading firmware i915/kbl_dmc_ver1_04.bin
Apr  4 05:45:49 heisenberg kernel: [ 9183.140861] (NULL device *): firmware: direct-loading firmware iwlwifi-8265-36.ucode
Apr  4 05:45:49 heisenberg kernel: [ 9183.140872] Freezing user space processes ...
Apr  4 05:45:49 heisenberg kernel: [ 9203.141630] Freezing of tasks failed after 20.001 seconds (1 tasks refusing to freeze, wq_busy=0):
Apr  4 05:45:49 heisenberg kernel: [ 9203.141643] btrfs           R  running task        0 1973346   3197 0x00004004
Apr  4 05:45:49 heisenberg kernel: [ 9203.141646] Call Trace:
Apr  4 05:45:49 heisenberg kernel: [ 9203.141651]  ? mutex_lock+0x1f/0x30
Apr  4 05:45:49 heisenberg kernel: [ 9203.141654]  ? _cond_resched+0x15/0x30
Apr  4 05:45:49 heisenberg kernel: [ 9203.141655]  ? mutex_lock+0xe/0x30
Apr  4 05:45:49 heisenberg kernel: [ 9203.141657]  ? _cond_resched+0x15/0x30
Apr  4 05:45:49 heisenberg kernel: [ 9203.141658]  ? mutex_lock+0xe/0x30
Apr  4 05:45:49 heisenberg kernel: [ 9203.141661]  ? do_splice+0xfa/0x660
Apr  4 05:45:49 heisenberg kernel: [ 9203.141663]  ? __x64_sys_splice+0xf2/0x120
Apr  4 05:45:49 heisenberg kernel: [ 9203.141666]  ? do_syscall_64+0x52/0x180
Apr  4 05:45:49 heisenberg kernel: [ 9203.141667]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
Apr  4 05:45:49 heisenberg kernel: [ 9203.141671] OOM killer enabled.
Apr  4 05:45:49 heisenberg kernel: [ 9203.141671] Restarting tasks ... done.
Apr  4 05:45:49 heisenberg kernel: [ 9203.176215] PM: suspend exit
Apr  4 05:45:49 heisenberg kernel: [ 9203.176287] PM: suspend entry (s2idle)
Apr  4 05:47:22 heisenberg kernel: [ 9203.887154] Filesystems sync: 0.710 seconds
Apr  4 05:47:22 heisenberg kernel: [ 9203.887958] Freezing user space processes ... (elapsed 0.004 seconds) done.
Apr  4 05:47:22 heisenberg kernel: [ 9203.892873] OOM killer disabled.
Apr  4 05:47:22 heisenberg kernel: [ 9203.892878] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Apr  4 05:47:22 heisenberg kernel: [ 9203.894509] printk: Suspending console(s) (use no_console_suspend to debug)
Apr  4 05:47:22 heisenberg kernel: [ 9203.895621] wlan0: deauthenticating from 34:31:c4:42:e5:41 by local choice (Reason: 3=DEAUTH_LEAVING)
Apr  4 05:47:22 heisenberg kernel: [ 9203.916926] sd 3:0:0:0: [sdb] Synchronizing SCSI cache
Apr  4 05:47:22 heisenberg kernel: [ 9203.925902] e1000e: EEE TX LPI TIMER: 00000011
Apr  4 05:47:22 heisenberg kernel: [ 9203.926011] sd 2:0:0:0: [sda] Synchronizing SCSI cache
Apr  4 05:47:22 heisenberg kernel: [ 9203.929166] sd 2:0:0:0: [sda] Stopping disk
Apr  4 05:47:22 heisenberg kernel: [ 9206.449932] ACPI: EC: interrupt blocked
Apr  4 05:47:22 heisenberg kernel: [ 9294.842883] ACPI: EC: interrupt unblocked
Apr  4 05:47:22 heisenberg kernel: [ 9295.406845] sd 2:0:0:0: [sda] Starting disk
Apr  4 05:47:22 heisenberg kernel: [ 9296.052818] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
Apr  4 05:47:22 heisenberg kernel: [ 9296.054817] ata3.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Apr  4 05:47:22 heisenberg kernel: [ 9296.054818] ata3.00: ACPI cmd b1/c1:00:00:00:00:a0 (DEVICE CONFIGURATION OVERLAY) filtered out
Apr  4 05:47:22 heisenberg kernel: [ 9296.054887] ata3.00: ACPI cmd ef/10:09:00:00:00:b0 (SET FEATURES) succeeded
Apr  4 05:47:22 heisenberg kernel: [ 9296.055110] ata3.00: supports DRM functions and may not be fully accessible
Apr  4 05:47:22 heisenberg kernel: [ 9296.059963] ata3.00: disabling queued TRIM support
Apr  4 05:47:22 heisenberg kernel: [ 9296.065210] ata3.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Apr  4 05:47:22 heisenberg kernel: [ 9296.065212] ata3.00: ACPI cmd b1/c1:00:00:00:00:a0 (DEVICE CONFIGURATION OVERLAY) filtered out
Apr  4 05:47:22 heisenberg kernel: [ 9296.065233] ata3.00: ACPI cmd ef/10:09:00:00:00:b0 (SET FEATURES) succeeded
Apr  4 05:47:22 heisenberg kernel: [ 9296.065455] ata3.00: supports DRM functions and may not be fully accessible
Apr  4 05:47:22 heisenberg kernel: [ 9296.070254] ata3.00: disabling queued TRIM support
Apr  4 05:47:22 heisenberg kernel: [ 9296.075210] ata3.00: configured for UDMA/133
Apr  4 05:47:22 heisenberg kernel: [ 9296.194394] OOM killer enabled.
Apr  4 05:47:22 heisenberg kernel: [ 9296.194395] Restarting tasks ... done.
Apr  4 05:47:22 heisenberg kernel: [ 9296.269425] PM: suspend exit


Afterwards, the systems root fs (btrfs) was apparently still okay, the
attached USB devices came up as well (with an external HDD with a
btrfs, that seemed to be okay, too,... just the send|receive to it had
died).


Cheers,
Chris

PS: kernel 5.5.13, progs 5.4.1

