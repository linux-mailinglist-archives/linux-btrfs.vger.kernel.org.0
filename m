Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD863EE4F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 05:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhHQDUJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 23:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbhHQDUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 23:20:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A36C061230
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Aug 2021 20:19:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f5so26362388wrm.13
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Aug 2021 20:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=cc1YsksuYJjqlBxO1u+1D6NP5R3lLXFD0HB1py4KBEQ=;
        b=CAprpUMpZLchuMIh5vIl1RX6TV7lFz2JF86pqxdE/+PNZd8FfX7ZN5UB10L7bDuzsw
         Yh1LLn+YUlwVfKSMg+w6PSsyw15eJZY8KDZNpBLm17vJeuyD0VT6F/r9dIpCwGf4xoCR
         3CJ7kx1uFyobu8NJ/FPTXWZUm1L1KjidbpWft05TSJX11rYPFdzn9SAk5VTzcuSIIsQy
         PbWkhzt/KMLToS+RH9dhYOhWqQ9s03N3WxOO6UofOd/Kf9dXYrDZHp3UYwGI+NI+oz1L
         c3dfeC2LlILg9LnxAcSrcHSkEEC6s/4lZPVLvFsKlxU11INlVmKkKoCyaBzeaF/RYqli
         PMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cc1YsksuYJjqlBxO1u+1D6NP5R3lLXFD0HB1py4KBEQ=;
        b=B35NXutsQ6YDFBJO2j3gUK/8FgVRLaciHJeT3ef6WScjrX7RwChJ9iLnI1FIgbz+5F
         fk5trE04BzV0VbrPRwogz/yt5peNcz0V7f+O/ibct3eqluzIwllgOZulYgKxcSeHSH1N
         afLkd0p8FXQdAOwjyQFSx7UQZLFvUzocsjfXk1FKlOH91ZI/BV0GfHtkv2M89MK+7vEZ
         ZrNYCVkzXq47EoqUt0MQMCzp0kpEB4aFXjJDYB1X2nquC+2un/s0ecCLVeTNgz0NYlMb
         6LJPbWTZNbqTfEiBknMbgkFfCZRgWPBYtcuixTvC7q7kqLZP6uDUmyi4RRonOtbRAUz7
         Nn1w==
X-Gm-Message-State: AOAM533ezlropz9nkiD0mSKeW/1tZct9ZIr9NuwmQpuo7sTr0pvuBoXk
        YuqjgkUdCo4JycD/KN80h250I+dm5Cy6vvG3Y+5gqzrBq6bjAQ==
X-Google-Smtp-Source: ABdhPJxw22LE1CBssG0T92dASy8q54c1fD/6VajbcJyq8Ez4+qWt+g8c5NYRIkXwo5g+KL86W/G3f3bh6xjJ9PJxgDw=
X-Received: by 2002:a5d:6b86:: with SMTP id n6mr1203392wrx.65.1629170340116;
 Mon, 16 Aug 2021 20:19:00 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 16 Aug 2021 21:18:44 -0600
Message-ID: <CAJCQCtQg5AkNGQ9FwFhbu-moyH8cbo11P22xipE0_MOrD-Mmcg@mail.gmail.com>
Subject: 5.14.0-rc5: WARNING: at fs/btrfs/super.c:2507 btrfs_show_devname+0x83/0x90
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

5.14.0-0.rc5.42.fc35.x86_64

Command running at the time of the splat:
btrfs dev rem /dev/loop3 /mnt/1

Setup summary: seed device image file located on Btrfs formatted USB
stick, and the seed device is being removed in order to
replicate/create a sprout on NVMe.

cryptsetup open /dev/sdb1 sdb1
mount /dev/mapper/sdb1 /mnt/0
losetup /dev/loop3 /mnt/0/fedora35.raw
mount /dev/loop3 /mnt/1
btrfs dev add /dev/nvme0n1p7 /mnt/1
mount -o remount,rw /mnt/1
btrfs dev rem /dev/loop3 /mnt/1

Full dmesg:
https://drive.google.com/file/d/1CGxsldrXA1cFSO8-vkV7ZtjhfOVesGlP/view?usp=sharing

Snippet:
[  480.488427] ------------[ cut here ]------------
[  480.488431] WARNING: CPU: 1 PID: 1213 at fs/btrfs/super.c:2507
btrfs_show_devname+0x83/0x90
[  480.488439] Modules linked in: <removed>
[  480.488566] CPU: 1 PID: 1213 Comm: udisksd Not tainted
5.14.0-0.rc5.42.fc35.x86_64 #1
[  480.488569] Hardware name: HP HP Spectre Notebook/81A0, BIOS F.44 11/25/2019
[  480.488571] RIP: 0010:btrfs_show_devname+0x83/0x90
[  480.488576] Code: c2 48 8b 00 48 39 f0 75 e0 48 85 d2 74 1c 48 8b
72 40 48 c7 c2 80 23 5d 8a 48 83 c6 10 e8 a5 2f ee ff e8 d0 d4 cc ff
31 c0 c3 <0f> 0b e8 c6 d4 cc ff 31 c0 c3 0f 1f 00 0f 1f 44 00 00 41 54
bf 15
[  480.488579] RSP: 0018:ffffad0400e7fdb0 EFLAGS: 00010246
[  480.488582] RAX: ffff8e9505493098 RBX: ffff8e950549d060 RCX: 0000000000000b26
[  480.488585] RDX: ffff8e955bb8c000 RSI: ffff8e9505493098 RDI: ffff8e950a0ad8e8
[  480.488587] RBP: ffff8e950a0ad8e8 R08: 0000000000000008 R09: ffffffff8a5d2380
[  480.488589] R10: ffffffff8a5f37ec R11: 0000000000000005 R12: ffff8e950e8ef800
[  480.488591] R13: ffff8e9508254008 R14: ffff8e950a0ad910 R15: ffff8e950549d040
[  480.488593] FS:  00007f41946db900(0000) GS:ffff8e96b6c80000(0000)
knlGS:0000000000000000
[  480.488596] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  480.488599] CR2: 00007fb920aea1e0 CR3: 0000000105496006 CR4: 00000000003706e0
[  480.488602] Call Trace:
[  480.488605]  show_mountinfo+0x1bf/0x2e0
[  480.488612]  seq_read_iter+0x2c3/0x4b0
[  480.488618]  new_sync_read+0x102/0x180
[  480.488623]  ? selinux_sk_alloc_security+0x30/0x90
[  480.488627]  vfs_read+0xf3/0x180
[  480.488630]  ksys_read+0x4f/0xc0
[  480.488633]  do_syscall_64+0x38/0x90
[  480.488637]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  480.488643] RIP: 0033:0x7f419506073c
[  480.488646] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08
e8 d9 89 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31
c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 1f 8a f8
ff 48
[  480.488649] RSP: 002b:00007ffd89221830 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[  480.488652] RAX: ffffffffffffffda RBX: 0000557de9606220 RCX: 00007f419506073c
[  480.488654] RDX: 0000000000001000 RSI: 00007ffd89221940 RDI: 0000000000000012
[  480.488657] RBP: 00007f419515a3a0 R08: 0000000000000000 R09: 0000000000000000
[  480.488659] R10: 0000000000001000 R11: 0000000000000246 R12: 00007ffd89221940
[  480.488661] R13: 0000000000000d68 R14: 00007f41951597a0 R15: 0000000000001000
[  480.488665] ---[ end trace 6c008b15a132f983 ]---

The seed device does successfully remove. The sprout mounts OK, and
btrfs check is OK.

--
Chris Murphy
