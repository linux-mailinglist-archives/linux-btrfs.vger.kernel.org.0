Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAFF4A32F8
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jan 2022 02:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243706AbiA3BAE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Jan 2022 20:00:04 -0500
Received: from smarthost2.cuci.nl ([212.125.129.134]:58322 "EHLO
        smarthost2.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiA3BAD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Jan 2022 20:00:03 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jan 2022 20:00:03 EST
Received: from aristoteles.cuci.nl (aristoteles.cuci.nl [212.125.128.18])
        by smarthost.cuci.nl (Postfix) with ESMTP id 4JmXjk6mscz4xNnx
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jan 2022 01:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cuci.nl; s=mail;
        t=1643503978; bh=O67HbTB041DbrD405OnqCSmk/t6dm2DgLT0OTj1VGa4=;
        l=2193; h=Date:From:To:Subject:From;
        b=o1ixJuSt955R+ZW71w2P3wLwIsKTiuCKH7drLBGFPawCGcesCL7JVRCYgfF2kZNAh
         kj4Et5bhsMxUeKCza3wd0g7VZj4c4OmD6Klee5FnXSCsK5pJZ5IK6c5wQhiL73PZFf
         JegTYYoAejcdZGbL/qmGUOKHT0i5ZJOucD8DFEDQ=
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
        id B75575461; Sun, 30 Jan 2022 01:52:58 +0100 (CET)
Date:   Sun, 30 Jan 2022 01:52:58 +0100
From:   "Stephen R. van den Berg" <srb@cuci.nl>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: RIP: 0010:__writeback_inodes_sb_nr+0x7e/0xb3
Message-ID: <20220130005258.GA7465@cuci.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Linux kernel 5.16.3

This is an NFS server storing on BTRFS.
What does the error mean?

[  499.260653] NFS: SECINFO: security flavor 390003 is not supported
[  499.270404] NFS: SECINFO: security flavor 390004 is not supported
[  499.280127] NFS: SECINFO: security flavor 390005 is not supported
[  947.470439] ------------[ cut here ]------------
[  947.473890] WARNING: CPU: 5 PID: 930 at fs/fs-writeback.c:2610 __writeback_inodes_sb_nr+0x7e/0xb3
[  947.481623] Modules linked in: nfsd nls_cp437 cifs asn1_decoder cifs_arc4 fscache cifs_md4 ipmi_ssif
[  947.489571] CPU: 5 PID: 930 Comm: btrfs-transacti Not tainted 95.16.3-srb-asrock-00001-g36437ad63879 #186
[  947.497969] RIP: 0010:__writeback_inodes_sb_nr+0x7e/0xb3
[  947.502097] Code: 24 10 4c 89 44 24 18 c6 44 24 24 01 44 89 54 24 28 48 89 64 24 40 49 8b 41 58 74 28 48 85 c0 74 23 49 8b 40 70 48 85 c0 75 02 <0f> 0b 4c 89 cf 48 8d 74 24 10 0f b6 d2 e8 8b fd ff ff 48 89 e7 e8
[  947.519760] RSP: 0018:ffffc90000777e10 EFLAGS: 00010246
[  947.523818] RAX: 0000000000000000 RBX: 0000000000963300 RCX: 0000000000000000
[  947.529765] RDX: 0000000000000000 RSI: 000000000000fa51 RDI: ffffc90000777e50
[  947.535740] RBP: ffff888101628a90 R08: ffff888100955800 R09: ffff888100956000
[  947.541701] R10: 0000000000000002 R11: 0000000000000001 R12: ffff888100963488
[  947.547645] R13: ffff888100963000 R14: ffff888112fb7200 R15: ffff888100963460
[  947.553621] FS:  0000000000000000(0000) GS:ffff88841fd40000(0000) knlGS:0000000000000000
[  947.560537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  947.565122] CR2: 0000000008be50c4 CR3: 000000000220c000 CR4: 00000000001006e0
[  947.571072] Call Trace:
[  947.572354]  <TASK>
[  947.573266]  btrfs_commit_transaction+0x1f1/0x998
[  947.576785]  ? start_transaction+0x3ab/0x44e
[  947.579867]  ? schedule_timeout+0x8a/0xdd
[  947.582716]  transaction_kthread+0xe9/0x156
[  947.585721]  ? btrfs_cleanup_transaction.isra.0+0x407/0x407
[  947.590104]  kthread+0x131/0x139
[  947.592168]  ? set_kthread_struct+0x32/0x32
[  947.595174]  ret_from_fork+0x22/0x30
[  947.597561]  </TASK>
[  947.598553] ---[ end trace 644721052755541c ]---
-- 
Stephen.
