Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A64138C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 19:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhIURmE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhIURmC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 13:42:02 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3358C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 10:40:33 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 194so32534388qkj.11
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=1+cOL6eii+crldBkzQOxw8WhuSkZuKUFCBHg3oc9zjE=;
        b=iZ5DneaIXZ81cK+u2s01IwibF70ZUnLSGEiMU/hI+HSwj8jBzc5c0gP8MySzl6BwkW
         CJJN7utO8BVEmkCxqbZOUUQxvl+ThVwt6nGUwP6o0u7eH5giOzOcQBpd9CsO9UH2MlL8
         B1lB4iRKbBddYS6hWvMV7BRhHj+RQKEH1TFBVacp0BXbRT58szhQ/vV5008yPElM9BUU
         h5fbIaNOtfbaCjweQ/6IOfMgBwq5TJNbeB3nUkiyw1hGX1k8y6Wf2/6uTsv5a2e2kAJ1
         9UNuBtmCNNFPoX9wuW0diE10T4jdPeETsju0VzowyFi+gKLccRFSJ2szpVxNTip8uCxf
         mXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1+cOL6eii+crldBkzQOxw8WhuSkZuKUFCBHg3oc9zjE=;
        b=J1GLhpPwsOEs2umB0l6YPvrlGy9tv9K0kax+mmHrfhrPpP9PzSkLKYlbv+L7ajvRa+
         dU6A98gCtHq0NGHOXFQls+1J0oMCnQ7tDY65G45QofUIIOGMpL5DFNXDA7dQ8gbDhhHJ
         9TwZ2+r1s8INOKCKAX912FQW6aV9YBwCH/cTCQniIc3OgcE9NpzNVVRqJRs7dju5MHgz
         M/McuDyPUjEQ3NF2qDOAHn93VqHAIz22VGASthdvCbfGgbzu/4gRlYqAOwOS0GdbzUJd
         NUvSLSIYVmQL0wL0tKhj021c9e3CrgXQcuNaLVbL2ULYLl6Dd/St4s1A3WlcLkRDu2wK
         DVkw==
X-Gm-Message-State: AOAM532crvUu1QHW4PK4mfeggC8H97WIYjANTp5oZgchcdq0R4+XMQ5z
        VNIAEFW/sFSMdCsoenyzKQaG3SYsudQB4OpbUViDrPfHY54L/Cto
X-Google-Smtp-Source: ABdhPJyrrB6KkneJrGJ3rd/5Mr2qsLtPHnTVcSWUWRkz/yGbNmXi4eLWMpfdUhyktPV3N91cnhgxbNNYwXFajyNN4xQ=
X-Received: by 2002:a25:c6c1:: with SMTP id k184mr40473228ybf.277.1632246032702;
 Tue, 21 Sep 2021 10:40:32 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 21 Sep 2021 11:40:17 -0600
Message-ID: <CAJCQCtQsqsDwzUegUgYAo2PccUP9q=DKKA7kUNtRcbttW-nQrw@mail.gmail.com>
Subject: aarch64: Unsupported V0 extent filesystem detected.
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Downstream bug report with a 5.13.12 kernel.
https://bugzilla.redhat.com/show_bug.cgi?id=2000482

[98070.003257] BTRFS error (device sda3): Unsupported V0 extent
filesystem detected. Aborting. Please re-create your filesystem with a
newer kernel
[98070.016180] ------------[ cut here ]------------
[98070.020848] BTRFS: Transaction aborted (error -22)
[98070.020919] WARNING: CPU: 6 PID: 1175325 at
fs/btrfs/extent-tree.c:872 lookup_inline_extent_backref+0x5b4/0x5e0
[98070.031001] Modules linked in: nfnetlink crypto_user rfkill
xgene_enet dwc3 sdhci_acpi sdhci udc_core at803x ulpi mdio_xgene
xgene_rng mailbox_xgene_slimpro cppc_cpufreq vfat fat fuse drm
 zram ip_tables crct10dif_ce i2c_xgene_slimpro xgene_hwmon gpio_dwapb
gpio_xgene_sb xhci_plat_hcd aes_neon_bs
[98070.057184] CPU: 6 PID: 1175325 Comm: kworker/u16:2 Not tainted
5.13.12-200.fc34.aarch64 #1
[98070.065512] Hardware name: AppliedMicro X-Gene Mustang Board/X-Gene
Mustang Board, BIOS 3.06.25 Oct 17 2016
[98070.075213] Workqueue: events_unbound btrfs_preempt_reclaim_metadata_space
[98070.082060] pstate: 40400005 (nZcv daif +PAN -UAO -TCO BTYPE=--)
[98070.088039] pc : lookup_inline_extent_backref+0x5b4/0x5e0
[98070.093415] lr : lookup_inline_extent_backref+0x5b4/0x5e0
[98070.098789] sp : ffff800018e0b900
[98070.102085] x29: ffff800018e0b900 x28: 0000000000000019 x27: 0000000000000065
[98070.109189] x26: 0000000000000065 x25: ffff00000a70f000 x24: 00000000ffffffff
[98070.116293] x23: ffff00000603e750 x22: ffff0001c4a1b600 x21: 00000001d8c74000
[98070.123398] x20: 0000000000000001 x19: ffff00000bb825b0 x18: ffffffffffffffff
[98070.130523] x17: 0000000100000000 x16: 0000000000000000 x15: ffff80001275987a
[98070.137648] x14: 00000000fffffffe x13: ffff800012759875 x12: 7220657361656c50
[98070.144773] x11: ffff8000123bccc8 x10: 00000000ffffe000 x9 : ffff800010302810
[98070.151899] x8 : 00000000ffffdfff x7 : ffff8000123bccc8 x6 : 0000000000000001
[98070.159025] x5 : ffff0003fdefb148 x4 : 0000000000000000 x3 : 0000000000000027
[98070.166149] x2 : 0000000000000023 x1 : ffff0003fdefb150 x0 : 0000000000000026
[98070.173272] Call trace:
[98070.175707]  lookup_inline_extent_backref+0x5b4/0x5e0
[98070.180737]  lookup_extent_backref+0x54/0x110
[98070.185072]  __btrfs_free_extent+0xcc/0xce0
[98070.189233]  run_delayed_data_ref+0x98/0x190
[98070.193482]  btrfs_run_delayed_refs_for_head+0x1ac/0x47c
[98070.198767]  __btrfs_run_delayed_refs+0xa8/0x280
[98070.203361]  btrfs_run_delayed_refs+0x7c/0x2b4
[98070.207782]  flush_space+0x354/0x430
[98070.211341]  btrfs_preempt_reclaim_metadata_space+0x180/0x2e0
[98070.217059]  process_one_work+0x1f0/0x4ac
[98070.221051]  worker_thread+0x184/0x500
[98070.224783]  kthread+0x110/0x114
[98070.227996]  ret_from_fork+0x10/0x18
[98070.231548] ---[ end trace e40182db389567a8 ]---
[98070.236189] BTRFS: error (device sda3) in
lookup_inline_extent_backref:872: errno=-22 unknown
[98070.242064] systemd-journald[521]:
/var/log/journal/b678600db30b48c583d660c7503b29a6/system.journal: IO
error, rotating.
[98070.244696] BTRFS info (device sda3): forced readonly
[98070.258648] systemd-journald[521]: Failed to rotate
/var/log/journal/b678600db30b48c583d660c7503b29a6/system.journal:
Read-only file system
[98070.260560] BTRFS: error (device sda3) in __btrfs_free_extent:3084:
errno=-22 unknown
[98070.274101] systemd-journald[521]: Failed to rotate
/var/log/journal/b678600db30b48c583d660c7503b29a6/user-1003.journal:
Read-only file system
[98070.280866] BTRFS: error (device sda3) in
btrfs_run_delayed_refs:2163: errno=-22 unknown
[98070.342771] systemd-journald[521]: Failed to write entry (9 items,
350 bytes) despite vacuuming, ignoring: Input/output error


-- 
Chris Murphy
