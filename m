Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE00363B7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 08:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhDSGao (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 02:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhDSGan (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 02:30:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5EC06174A
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Apr 2021 23:30:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so17342841wmg.0
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Apr 2021 23:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=YXn4yvwGN+8uzF5osrUQXp2zvLkea2vPBlwSxME70Wg=;
        b=pHJkpcaDiwHhhJyF94xE7WdzwjDDpYFcbuZ3XUm+G1dk2/QRdOqgouo2VyprbZHXib
         8w+xdYtHH2fXZj1cWlWyKdvC68+rG03TYJKDJoZI88KBWQsdWUiYnNMF9UqsW9NdRMjv
         yyp3ELhQ+5CxDAnhTiV0Omee1hgN1hDtcZ31b8hK67AtSm86NHrcmJD7eT6dp7F0TDJm
         Zoc5R4sELDQmLvrCtx0oqCbUln5T/5NVMNCvv1RA6JSGNUJZSUTmcmgQR0CnFNCb/+s1
         d7oQRvveSLAja+6EozBbsgwjHqUlCNG4NSMIkFmOHsjEozCCwnXXFqHD+pX/zeDiJBHV
         J1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YXn4yvwGN+8uzF5osrUQXp2zvLkea2vPBlwSxME70Wg=;
        b=oSTC0DeC50A8Dj9z9JIzeeVwnXdHZPNUxffXKlqyxqwNPcI5ZkvO4qzmT2u8IxEApJ
         8a1aI/yb/EOZeZPCVX0dto5TtZcMwVqBToDBCGC+zjMOxf+yl7vrrfvk7WHdXu3zt+81
         3jNytCW+NltZi+5wEPe9J7X0Gax4ZB/+EL/t4/Z2qw8iW9d3j/tHS+UN7MbIbqNWe417
         KjvXsqpra2LVqcEv1UkIihkOS4rEfkF9JV/RXrkn3i9kYqQQmG1BvL7N1n83EKwaXBq+
         hBaLM5bz9ZGRPajA/Y+8sm3JlEsoNgYaof5Oeu4aTeuYLfu3yTtufbNKGa7tX7zHYYsp
         HwPg==
X-Gm-Message-State: AOAM531qqxLXnerPPEuCm4xBAZ1hGtXpaUwUjHrG9f1R3nil34ZX/Lq+
        le6KTI/EUKjX6rLWoXJwbhmEVPtagQmeSheMYnaYcOFxWpnys4sj
X-Google-Smtp-Source: ABdhPJyOLg5bkABMICN+f2myIFsQKGAxrh0CDoCFZPVUWADR+FhdXjGtQiArvxc4V4b5nMZWi72Gj61VQRRiM5C5zbg=
X-Received: by 2002:a7b:c30e:: with SMTP id k14mr19984639wmj.128.1618813813025;
 Sun, 18 Apr 2021 23:30:13 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 19 Apr 2021 00:29:57 -0600
Message-ID: <CAJCQCtR4VtdJ5qP7eg=Oj7w+2JHTRjXO8HneyX3UPeHgCmGxdA@mail.gmail.com>
Subject: 5.12-rc7 occasional btrfs splat when rebooting
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm not sure with which rc I first saw this appear. I don't recalling
seeing it with 5.11 series. There's nothing unusual reported during
the subsequent reboot.

[16212.441466] kernel: dnf (7568) used greatest stack depth: 10752 bytes left
[16332.569785] kernel: Lockdown: systemd-logind: hibernation is
restricted; see man kernel_lockdown.7
[16337.349525] kernel: rfkill: input handler enabled
[16339.203377] kernel: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
[16339.203439] kernel: turning off the locking correctness validator.
[16339.203491] kernel: Please attach the output of /proc/lock_stat to
the bug report
[16339.203555] kernel: CPU: 2 PID: 5625 Comm: signal-desktop Not
tainted 5.12.0-0.rc7.189.fc35.x86_64+debug #1
[16339.203636] kernel: Hardware name: HP HP Spectre Notebook/81A0,
BIOS F.44 11/25/2019
[16339.203698] kernel: Call Trace:
[16339.203723] kernel:  dump_stack+0x7f/0xa1
[16339.203762] kernel:  __lock_acquire.cold+0x1a9/0x2bf
[16339.203810] kernel:  lock_acquire+0xc4/0x3a0
[16339.203850] kernel:  ? __delayacct_thrashing_end+0x36/0x60
[16339.203898] kernel:  ? mark_held_locks+0x50/0x80
[16339.203938] kernel:  _raw_spin_lock_irqsave+0x4d/0x90
[16339.203981] kernel:  ? __delayacct_thrashing_end+0x36/0x60
[16339.204030] kernel:  __delayacct_thrashing_end+0x36/0x60
[16339.204077] kernel:  wait_on_page_bit_common+0x38e/0x490
[16339.204125] kernel:  ? add_page_wait_queue+0xf0/0xf0
[16339.204170] kernel:  read_extent_buffer_pages+0x55e/0x610
[16339.204222] kernel:  btree_read_extent_buffer_pages+0x97/0x110
[16339.204277] kernel:  read_tree_block+0x39/0x60
[16339.204314] kernel:  btrfs_read_node_slot+0xe3/0x130
[16339.204358] kernel:  push_leaf_left+0x98/0x190
[16339.204400] kernel:  btrfs_del_items+0x2ba/0x440
[16339.204446] kernel:  btrfs_truncate_inode_items+0x254/0xfc0
[16339.204499] kernel:  ? _raw_spin_unlock+0x1f/0x30
[16339.204542] kernel:  ? btrfs_block_rsv_migrate+0x6d/0xb0
[16339.204589] kernel:  btrfs_evict_inode+0x3fe/0x4e0
[16339.204631] kernel:  evict+0xcf/0x1d0
[16339.204662] kernel:  __dentry_kill+0xe8/0x190
[16339.204697] kernel:  ? dput+0x20/0x480
[16339.204729] kernel:  dput+0x2b8/0x480
[16339.204758] kernel:  __fput+0x102/0x260
[16339.204792] kernel:  task_work_run+0x5c/0xa0
[16339.204830] kernel:  do_exit+0x3e1/0xc20
[16339.204864] kernel:  ? find_held_lock+0x32/0x90
[16339.204903] kernel:  ? sched_clock+0x5/0x10
[16339.204938] kernel:  ? sched_clock_cpu+0xc/0xb0
[16339.204977] kernel:  do_group_exit+0x39/0xb0
[16339.205008] kernel:  get_signal+0x16f/0xb00
[16339.205037] kernel:  arch_do_signal_or_restart+0xfc/0x750
[16339.205075] kernel:  ? finish_task_switch.isra.0+0xa0/0x2c0
[16339.205120] kernel:  ? finish_task_switch.isra.0+0x6a/0x2c0
[16339.205165] kernel:  ? do_user_addr_fault+0x1ea/0x6b0
[16339.205208] kernel:  exit_to_user_mode_prepare+0x15d/0x240
[16339.205253] kernel:  ? asm_exc_page_fault+0x8/0x30
[16339.205296] kernel:  irqentry_exit_to_user_mode+0x5/0x40
[16339.205343] kernel:  asm_exc_page_fault+0x1e/0x30
[16339.205383] kernel: RIP: 0033:0x7f49d11b6674
[16339.205421] kernel: Code: Unable to access opcode bytes at RIP
0x7f49d11b664a.
[16339.205481] kernel: RSP: 002b:00007f49ce07f250 EFLAGS: 00010206
[16339.205530] kernel: RAX: 000055593f9bc088 RBX: 00007f49d11d9140
RCX: 000000000000084e
[16339.205602] kernel: RDX: 0000000000000c4e RSI: 000000000099c84e
RDI: 00000000267213a2
[16339.205664] kernel: RBP: 0000000000000000 R08: 00007f49ce07f390
R09: 00007f49d11d9400
[16339.205720] kernel: R10: 00007f49d11aa540 R11: 000000000000005a
R12: 000000000000005a
[16339.205781] kernel: R13: 00007f49ce1c5688 R14: 0000000000000001
R15: 0000000000000000
[16339.626109] kernel: wlp108s0: deauthenticating from
f8:a0:97:6e:c7:e8 by local choice (Reason: 3=DEAUTH_LEAVING)
[16340.238863] kernel: kauditd_printk_skb: 93 callbacks suppressed



-- 
Chris Murphy
