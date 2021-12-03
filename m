Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB9F467CF4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 19:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359112AbhLCSJl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 13:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353418AbhLCSJl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 13:09:41 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F5EC061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 10:06:16 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x32so11578896ybi.12
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 10:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEmWYDb8p3ZUjjVXoIqm8GHlLCBlA6sZCCY59LodgD4=;
        b=1ZIQWgFbx7NFvWa726G9C8rQhiOZ0alssZ8uyG325ou4n5q8E4pMG0nL3vQwFgq4Cq
         5glMmFwu7UpikW0k7Lqr3zPyZCm8apTqKQ91zqKzCMCgiYe3zjrlsVJFLvmjWfsmgfwL
         Qgbi+EQfAZOvs0prmImJDw+CMJD9i4+owqKgoi1lpMHMugzmaFROR7GLxmVOo21MpjeU
         TKb67zYWt4HqnrnST38cX1I7Q9cxHC7CIZp3j8KAk83QzmfKqzygi/xqnWUyMZFMpJQY
         il20AwA4KPV7iuyH0TaZ2br314YCsBELGhYnal6JlApIy4u4mBW7F7xogYWRflCDCTT7
         z1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEmWYDb8p3ZUjjVXoIqm8GHlLCBlA6sZCCY59LodgD4=;
        b=nzuOoCyLD0Q27IXorK8/nlh3zXqbb6X74r3QiF5kc9LGH8Lc0Oh7CaJrYFK+Hppb7i
         tjWP21+h49bFmRBDWw39O+DHvvWq445RDmSiKPIFLRDRxea/QamMlhF95F3ch9b9SHwh
         Sbf4gXyLYwzdEVUZl4anXEkUxu+07wjHyoBkse6Q2cBCul5SHwrs/G5m/5+umXFWR8WR
         l8gjEyVkWZmyfVoG3U790pwOmdWZOe3lIaVv+r1wn3WaTWcdBfa5qdwHRqXC9JOun+w/
         XN14kL56rmd2bbdCFCm4Ejmdv5qn23X57DCC7V0TNMfngq4ZKb2zCNkx2YKyrzWqfeT8
         vnWA==
X-Gm-Message-State: AOAM531lMnfY/46/cxVCZ/Xdcw1Jw2N4WbyYLBvefBWztNPdNnhBjiAx
        n8+iM7eN9Aiexs3fWKgyN344v/A0k+ZGg7u5N8qy5Q==
X-Google-Smtp-Source: ABdhPJyBFKvCclzKeZIaJ8lua3hqI2FdVXRmzOG2Eti+NKFhpKZNBpBi9mkdXV5F7PmCO+5gRTkJa+UZa1AfD36lj7U=
X-Received: by 2002:a25:af82:: with SMTP id g2mr22597801ybh.509.1638554775648;
 Fri, 03 Dec 2021 10:06:15 -0800 (PST)
MIME-Version: 1.0
References: <c5af7d3735e68237fbd49a2ae69a7e7f@wpkg.org> <PH0PR04MB7416465C59F5F339FA87AB839B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <93111e00ad2e42738d65d426f82ad17f@wpkg.org> <CAJCQCtROaF5cO=An5z2gxXCo8_87V1G0JQqdFCSspj3Bjfax1Q@mail.gmail.com>
In-Reply-To: <CAJCQCtROaF5cO=An5z2gxXCo8_87V1G0JQqdFCSspj3Bjfax1Q@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 3 Dec 2021 13:05:59 -0500
Message-ID: <CAJCQCtR=jztS3P34U_iUNoBodExHcud44OQ8oe4Jn3TK=1yFNw@mail.gmail.com>
Subject: Re: kworker/u32:5+btrfs-delalloc using 100% CPU
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Tomasz Chmielewski <mangoo@wpkg.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 3, 2021 at 12:23 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> I just did a Fedora Rawhide installation in a VM which has kernel
> 5.16.0-0.rc3.20211201git58e1100fdc59.25.fc36.x86_64
>
> The installation depends on loop mounted squashfs image as the source,
> and rsync as the copy mechanism. In top I see quite a few high CPU
> btrfs-delalloc as well, more than expected. I'll redo the installation
> and see if there were any deadlock warnings or anything like that, and
> if not I'll grab sysrq+t during the heavier btrfs CPU usage.
>
> The guest uses virtio drives; and the host uses NVMe.

On second glance, it's mostly btrfs-endio-write that's hitting 50%+
CPU on occasion, but no kernel warnings. sysrq+w caught this:

[ 1864.688477] EXT4-fs (vda2): mounted filesystem with ordered data
mode. Opts: (null). Quota mode: none.
[ 2002.412681] sysrq: Show Blocked State
[ 2002.412939] task:rsync           state:D stack:12856 pid: 3360
ppid:  3358 flags:0x00004000
[ 2002.412957] Call Trace:
[ 2002.412960]  <TASK>
[ 2002.412968]  __schedule+0x3f8/0x1500
[ 2002.412976]  ? lock_is_held_type+0xea/0x140
[ 2002.412984]  ? kvm_sched_clock_read+0x14/0x40
[ 2002.412999]  schedule+0x4e/0xc0
[ 2002.413004]  io_schedule+0x47/0x70
[ 2002.413007]  folio_wait_bit_common+0x14a/0x400
[ 2002.413024]  ? folio_unlock+0x50/0x50
[ 2002.413034]  filemap_get_pages+0x733/0x800
[ 2002.413047]  ? lock_is_held_type+0xea/0x140
[ 2002.413107]  filemap_read+0xb8/0x3f0
[ 2002.413113]  ? sched_clock_cpu+0xb/0xc0
[ 2002.413122]  ? lock_release+0x151/0x460
[ 2002.413133]  ? _copy_to_user+0x63/0x80
[ 2002.413143]  ? lock_is_held_type+0xea/0x140
[ 2002.413156]  new_sync_read+0x108/0x180
[ 2002.413175]  vfs_read+0x125/0x1c0
[ 2002.413184]  ksys_read+0x58/0xd0
[ 2002.413192]  do_syscall_64+0x38/0x90
[ 2002.413199]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 2002.413626] RIP: 0033:0x7f728b42d622
[ 2002.413631] RSP: 002b:00007ffc166df488 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[ 2002.413636] RAX: ffffffffffffffda RBX: 000055ba4417f9b0 RCX: 00007f728b42d622
[ 2002.413639] RDX: 0000000000012633 RSI: 000055ba44155990 RDI: 0000000000000003
[ 2002.413642] RBP: 0000000000012633 R08: 0000000000000000 R09: 0000000000000000
[ 2002.413644] R10: 0000000004000000 R11: 0000000000000246 R12: 0000000000000000
[ 2002.413647] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000012633
[ 2002.413671]  </TASK>
[ 2163.803113] kworker/dying (7) used greatest stack depth: 11536 bytes left




-- 
Chris Murphy
