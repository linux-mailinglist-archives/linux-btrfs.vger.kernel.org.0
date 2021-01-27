Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C57306599
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 22:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhA0VEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 16:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhA0VEA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 16:04:00 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB5FC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 13:03:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i9so2840957wmq.1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 13:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHclYNBpq2zDbINEjXZGiBeixuCrln8kUP9mpMAPAhA=;
        b=fs9bIdYxDTOaqa/VnpG+8sXyIcEr4tXd3bkuW3Sh47UvGPVMkYYO6U1tj5XnzFNA9q
         X5wXmtud0IIYZOWpwmq2wD0PoljNWzSTZ/BfZggLHeRPmFQKADfYNIO8WlaMCBUd8hAt
         ubP8GMaSwIFhFYKn3DzT9C4NkxsTdPb2RwjnXWLOdNV04+zgm03frNUBAdBCb3IvyHPC
         EOQRisHL0X/fYYunXvMChX+HbxnACr9VD22bHW7+8EKUhhFm3nojLa7H4HT42oM9EJYq
         HWaGw36xqwQg+knBRTxCUQ4wDe6mQQvZNJdVp2JiIUZbGvopiUFi+7J5roASW0INkW3/
         UIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHclYNBpq2zDbINEjXZGiBeixuCrln8kUP9mpMAPAhA=;
        b=CWaVsTGUpPsOUDcjXr2+xHTw43yh6OL0KDbjXcf+WKi831I1nQViSLgLxbUip7xz60
         VyAr0ohXG2C4sPDuBMyrs9VVI28HVVznrzwVwXXUeQh7xZQkXl0Mn3MNd677Ybq1sgVB
         ZKTPzEJBmEokBCPUeY6a5rGC4ZbSbFVDEWLroqlWk2OXAn9ZtLIjVG/Wf5a6nFXbtDDz
         JaYg7m1jVuiGU2hPKqHUz6aAqRZfhibrd6GmhizE8oEnNoQxMopBIv0g/SocHoRIrpct
         wKEArgzl5JiANb3lTLsLvbqhVBsvRSCvk1vF9dIhWdyD23LeZqOMZfBctKY2V6gyfNua
         GxQQ==
X-Gm-Message-State: AOAM532ahOTu4TsNUwneqK1V5JB1AbF3jWKrbNDZIRNEHLBA2G5xF0Ma
        b8GrEcW7FVxcZi+TTP3NXiQyF4NyKduERLi64rwe+0ZFhPF1qQ==
X-Google-Smtp-Source: ABdhPJznd0y4JA7kSXv4mxoGw/pDaG+8YjBBYNmXyulxuW/SYd1YFkgUTJa8Eh4pyYokQSIASv03dDkS62Oh1EKfpQA=
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr5756063wmb.124.1611781398575;
 Wed, 27 Jan 2021 13:03:18 -0800 (PST)
MIME-Version: 1.0
References: <0102017744df8bf8-cbdaa286-cfcc-4f6f-8332-69a98b3a4073-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102017744df8bf8-cbdaa286-cfcc-4f6f-8332-69a98b3a4073-000000@eu-west-1.amazonses.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 27 Jan 2021 14:03:02 -0700
Message-ID: <CAJCQCtROhiK+pEnS-kdApzkzZtFU1-yOAh5Uyv9hBtpyNJ3qig@mail.gmail.com>
Subject: Re: ENOSPC in btrfs_run_delayed_refs with 5.10.8 + zstd
To:     Martin Raiber <martin@urbackup.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 10:27 AM Martin Raiber <martin@urbackup.org> wrote:
>
> Hi,
>
> seems 5.10.8 still has the ENOSPC issue when compression is used (compress-force=zstd,space_cache=v2):
>
> Jan 27 11:02:14  kernel: [248571.569840] ------------[ cut here ]------------
> Jan 27 11:02:14  kernel: [248571.569843] BTRFS: Transaction aborted (error -28)
> Jan 27 11:02:14  kernel: [248571.569845] BTRFS: error (device dm-0) in add_to_free_space_tree:1039: errno=-28 No space left
> Jan 27 11:02:14  kernel: [248571.569848] BTRFS info (device dm-0): forced readonly
> Jan 27 11:02:14  kernel: [248571.569851] BTRFS: error (device dm-0) in add_to_free_space_tree:1039: errno=-28 No space left
> Jan 27 11:02:14  kernel: [248571.569852] BTRFS: error (device dm-0) in __btrfs_free_extent:3270: errno=-28 No space left
> Jan 27 11:02:14  kernel: [248571.569854] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2191: errno=-28 No space left
> Jan 27 11:02:14  kernel: [248571.569898] WARNING: CPU: 3 PID: 21255 at fs/btrfs/free-space-tree.c:1039 add_to_free_space_tree+0xe8/0x130
> Jan 27 11:02:14  kernel: [248571.569913] BTRFS: error (device dm-0) in __btrfs_free_extent:3270: errno=-28 No space left
> Jan 27 11:02:14  kernel: [248571.569939] Modules linked in:
> Jan 27 11:02:14  kernel: [248571.569966] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2191: errno=-28 No space left
> Jan 27 11:02:14  kernel: [248571.569992]  bfq zram bcache crc64 loop dm_crypt xfs dm_mod st sr_mod cdrom nf_tables nfnetlink iptable_filter bridge stp llc intel_powerclamp coretemp k$
> Jan 27 11:02:14  kernel: [248571.570075] CPU: 3 PID: 21255 Comm: kworker/u50:22 Tainted: G          I       5.10.8 #1
> Jan 27 11:02:14  kernel: [248571.570076] Hardware name: Dell Inc. PowerEdge R510/0DPRKF, BIOS 1.13.0 03/02/2018
> Jan 27 11:02:14  kernel: [248571.570079] Workqueue: events_unbound btrfs_async_reclaim_metadata_space
> Jan 27 11:02:14  kernel: [248571.570081] RIP: 0010:add_to_free_space_tree+0xe8/0x130
> Jan 27 11:02:14  kernel: [248571.570082] Code: 55 50 f0 48 0f ba aa 40 0a 00 00 02 72 22 83 f8 fb 74 4c 83 f8 e2 74 47 89 c6 48 c7 c7 b8 39 49 82 89 44 24 04 e8 8a 99 4a 00 <0f> 0b 8$
> Jan 27 11:02:14  kernel: [248571.570083] RSP: 0018:ffffc90009c57b88 EFLAGS: 00010282
> Jan 27 11:02:14  kernel: [248571.570084] RAX: 0000000000000000 RBX: 0000000000004000 RCX: 0000000000000027
> Jan 27 11:02:14  kernel: [248571.570085] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff888617a58b88
> Jan 27 11:02:14  kernel: [248571.570086] RBP: ffff8889ecb874e0 R08: ffff888617a58b80 R09: 0000000000000000
> Jan 27 11:02:14  kernel: [248571.570087] R10: 0000000000000001 R11: ffffffff822372e0 R12: 0000005741510000
> Jan 27 11:02:14  kernel: [248571.570087] R13: ffff8884e05727e0 R14: ffff88815ae4fc00 R15: ffff88815ae4fdd8
> Jan 27 11:02:14  kernel: [248571.570088] FS:  0000000000000000(0000) GS:ffff888617a40000(0000) knlGS:0000000000000000
> Jan 27 11:02:14  kernel: [248571.570089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jan 27 11:02:14  kernel: [248571.570090] CR2: 00007eb4a3a4f00a CR3: 000000000260a005 CR4: 00000000000206e0
> Jan 27 11:02:14  kernel: [248571.570091] Call Trace:
> Jan 27 11:02:14  kernel: [248571.570097]  __btrfs_free_extent.isra.0+0x56a/0xa10
> Jan 27 11:02:14  kernel: [248571.570100]  __btrfs_run_delayed_refs+0x659/0xf20
> Jan 27 11:02:14  kernel: [248571.570102]  btrfs_run_delayed_refs+0x73/0x200
> Jan 27 11:02:14  kernel: [248571.570103]  flush_space+0x4e8/0x5e0
> Jan 27 11:02:14  kernel: [248571.570105]  ? btrfs_get_alloc_profile+0x66/0x1b0
> Jan 27 11:02:14  kernel: [248571.570106]  ? btrfs_get_alloc_profile+0x66/0x1b0
> Jan 27 11:02:14  kernel: [248571.570107]  btrfs_async_reclaim_metadata_space+0x107/0x3a0
> Jan 27 11:02:14  kernel: [248571.570111]  process_one_work+0x1b6/0x350
> Jan 27 11:02:14  kernel: [248571.570112]  worker_thread+0x50/0x3b0
> Jan 27 11:02:14  kernel: [248571.570114]  ? process_one_work+0x350/0x350
> Jan 27 11:02:14  kernel: [248571.570116]  kthread+0xfe/0x140
> Jan 27 11:02:14  kernel: [248571.570117]  ? kthread_park+0x90/0x90
> Jan 27 11:02:14  kernel: [248571.570120]  ret_from_fork+0x22/0x30
> Jan 27 11:02:14  kernel: [248571.570122] ---[ end trace 568d2f30de65b1c0 ]---
> Jan 27 11:02:14  kernel: [248571.570123] BTRFS: error (device dm-0) in add_to_free_space_tree:1039: errno=-28 No space left
> Jan 27 11:02:14  kernel: [248571.570151] BTRFS: error (device dm-0) in __btrfs_free_extent:3270: errno=-28 No space left
> Jan 27 11:02:14  kernel: [248571.570178] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2191: errno=-28 No space left
>
>
> btrfs fi usage:
>
> Overall:
>     Device size:                 931.49GiB
>     Device allocated:            931.49GiB
>     Device unallocated:            1.00MiB
>     Device missing:                  0.00B
>     Used:                        786.39GiB
>     Free (estimated):            107.69GiB      (min: 107.69GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
>
> Data,single: Size:884.48GiB, Used:776.79GiB (87.82%)
>    /dev/mapper/LUKS-RC-a6414fd731ce4f878af44c3987bce533  884.48GiB
>
> Metadata,single: Size:47.01GiB, Used:9.59GiB (20.41%)
>    /dev/mapper/LUKS-RC-a6414fd731ce4f878af44c3987bce533   47.01GiB
>
> System,single: Size:4.00MiB, Used:144.00KiB (3.52%)
>    /dev/mapper/LUKS-RC-a6414fd731ce4f878af44c3987bce533    4.00MiB
>
> Unallocated:
>    /dev/mapper/LUKS-RC-a6414fd731ce4f878af44c3987bce533    1.00MiB

Can you mount or remount with enospc_debug, and reproduce the problem?
That'll include some debug info that might be helpful to a developing
coming across this report. Also it might help:

cd /sys/fs/btrfs/$UUID/allocation
grep -R .

And post that too. The $UUID is the file system UUID for this specific
file system, as reported by blkid or lsblk -f.


-- 
Chris Murphy
