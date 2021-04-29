Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7055036ECC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 16:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhD2OwZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 10:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhD2OwZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 10:52:25 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC9BC06138B
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Apr 2021 07:51:38 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 3so7886461qvp.6
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Apr 2021 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYUCAkG5rIk250e4cAKds84YQOXypxUNHt1+2r9UoyM=;
        b=DRw0sFi25uCMvkuexxB7XnfG71HtNVhm6p8YoIopqDPFwkkstaPgmYLtiwJ7TeS32+
         LR/I8JFFw1TY/W24DYqRQvX3FBBX5jos9j00Sw5wDs86vCQITR1AOo2ejTTCGYiwNrOw
         GnA93xyXdw9Kexb5GgRMur2VAepPoHOq0YviZ4iqbyeps8GKxM2MFVbKxiEfKT/pAtjo
         EyPJ2PAs/2cswkxgfUOb7cpRIvUS7F06WF4TEYRDSw/HreWOykICSlTLmhIm+6Rp6iu4
         /WNoc+WEKqkeXpV0R8RNkoRXmSbPoduOlJOCzdDsh0j/1kB1k7oMpEawPMxsq6gY1F1p
         7IQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYUCAkG5rIk250e4cAKds84YQOXypxUNHt1+2r9UoyM=;
        b=Sj5nLFV2TfUGN2D1521DTd4DV05MK2chZkK7wGpnSeIbG10PmW6eTMSeh3PyqqDLLi
         0J5QS7eBN1zIHY7grwRtgVcBvKpT1RKmFdsWUy/Q19i3dDT2CyPr8ksmuP6LuabNFEcL
         ZzKV3RrNW8V6J1b64h0jk7vwYZM6PcvUJIUIMo5qCkQZFIlBH2DG1THaWBQxNoeKI4UK
         0Z/XdCJpqsZQBPj2BRdDse9Nss50qDQ0QCvZNUE0VGIIERPJQEjh5m9piu4zoXY7C6GF
         OY4SJL+gX4GQ7LOJhJP856YgTSWwJ8DhSwUOo10BPxOXUgR00ZH9/Zpw5RbsuBW6/3T6
         GXpw==
X-Gm-Message-State: AOAM530GR1EFTw8ouh9R0Gpe8anDnmUz4kqbLycPFpz+qOpDzYtWAhd5
        faL0zaRCA0CQ5V/7OK4Ck2rYzebP+yduFg==
X-Google-Smtp-Source: ABdhPJypjVyk4CupzhlrqoEeRRSMuccR2vEVMX3EKwk/bXYeEy4VilB8OPNttYNtmuoGwLF8D1XGYw==
X-Received: by 2002:a0c:f0c9:: with SMTP id d9mr23238762qvl.3.1619707897241;
        Thu, 29 Apr 2021 07:51:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 26sm66095qtd.73.2021.04.29.07.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 07:51:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: avoid RCU stalls while running delayed iputs
Date:   Thu, 29 Apr 2021 10:51:34 -0400
Message-Id: <c979946e8341274a0a45cfe9166cf6e4bea25a3e.1619707886.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Generally a delayed iput is added when we might do the final iput, so
usually we'll end up sleeping while processing the delayed iputs
naturally.  However there's no guarantee of this, especially for small
files.  In production we noticed 5 instances of RCU stalls while testing
a kernel release overnight across 1000 machines, so this is relatively
common

host count: 5
rcu: INFO: rcu_sched self-detected stall on CPU
 rcu: \x091-....: (20998 ticks this GP) idle=59e/1/0x4000000000000002 softirq=12333372/12333372 fqs=3208
 \x09(t=21031 jiffies g=27810193 q=41075) NMI backtrace for cpu 1
 CPU: 1 PID: 1713 Comm: btrfs-cleaner Kdump: loaded Not tainted 5.6.13-0_fbk12_rc1_5520_gec92bffc1ec9 #1
 "Hardware name: Quanta Tioga Pass Single Side 01-0030993006\x5cx0d/Tioga Pass Single Side, BIOS F08_3A24 05/13/2020"
 Call Trace: <IRQ> dump_stack+0x50/0x70 nmi_cpu_backtrace.cold.6+0x30/0x65
 ? lapic_can_unplug_cpu.cold.30+0x40/0x40 nmi_trigger_cpumask_backtrace+0xba/0xca
 rcu_dump_cpu_stacks+0x99/0xc7 rcu_sched_clock_irq.cold.90+0x1b2/0x3a3
 ? trigger_load_balance+0x5c/0x200 ? tick_sched_do_timer+0x60/0x60
 ? tick_sched_do_timer+0x60/0x60 update_process_times+0x24/0x50
 tick_sched_timer+0x37/0x70 __hrtimer_run_queues+0xfe/0x270
 hrtimer_interrupt+0xf4/0x210 smp_apic_timer_interrupt+0x5e/0x120
 apic_timer_interrupt+0xf/0x20 </IRQ>
 RIP: 0010:queued_spin_lock_slowpath+0x17d/0x1b0
 RSP: 0018:ffffc9000da5fe48 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
 RAX: 0000000000000000 RBX: ffff889fa81d0cd8 RCX: 0000000000000029
 RDX: ffff889fff86c0c0 RSI: 0000000000080000 RDI: ffff88bfc2da7200
 RBP: ffff888f2dcdd768 R08: 0000000001040000 R09: 0000000000000000
 R10: 0000000000000001 R11: ffffffff82a55560 R12: ffff88bfc2da7200
 R13: 0000000000000000 R14: ffff88bff6c2a360 R15: ffffffff814bd870
 ? kzalloc.constprop.57+0x30/0x30 list_lru_add+0x5a/0x100
 inode_lru_list_add+0x20/0x40 iput+0x1c1/0x1f0 run_delayed_iput_locked+0x46/0x90
 btrfs_run_delayed_iputs+0x3f/0x60 cleaner_kthread+0xf2/0x120 kthread+0x10b/0x130

Fix this by adding a cond_resched_lock() to the loop processing delayed
iputs so we can avoid these sort of stalls.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1a349759efae..f9c23ccfc1a3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3246,6 +3246,7 @@ void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 		inode = list_first_entry(&fs_info->delayed_iputs,
 				struct btrfs_inode, delayed_iput);
 		run_delayed_iput_locked(fs_info, inode);
+		cond_resched_lock(&fs_info->delayed_iput_lock);
 	}
 	spin_unlock(&fs_info->delayed_iput_lock);
 }
-- 
2.26.3

