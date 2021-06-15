Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D693A790C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jun 2021 10:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhFOIfM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 04:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhFOIfL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 04:35:11 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DA3C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jun 2021 01:33:06 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id o20so10590703qtr.8
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jun 2021 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPRLuX68fN3MBTKIcPaDskdfs8yDI+LzPrWJoY8CXl8=;
        b=rYwqAurknXMNiOA15rGYLHJ+rtvH/aPeCnkA0QlREsWDkdC+Mo96WmrqPPEW+eLjV4
         O3Jd0n/gCA4oHYQKfa7HDwnb/UL6gh+R5Xfl4SxN/Meh3tLjd8MOro6M6DjDF3KnR8iP
         WxJAdU5kgmRlegOyMJZM/tAIJTFA3vvefJFrje7RHkHfaq2Qof2c+nQ22cON3nl6bw4a
         GIDnJXXdnMDnpppPCzL8SVlrIYwFStoIBWQIWIgyEB8tEo3wGPQG/Gl2nrcdmT9vw67g
         ZJzw7k95QeaEwcP8fVLpKeeKT8mHevdBZ5T725/n3nfX4bGcim2gWRaqVvIpkJb+Bg7k
         lD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPRLuX68fN3MBTKIcPaDskdfs8yDI+LzPrWJoY8CXl8=;
        b=stsym6+Mn9JW0GkfKmsLs+WS4sdd5CJSVS6i1fF6ciXRq0RLXeOOL7vFjysI1kY55I
         PMuL+fkyoygurUVwf4S6TdrmNcVUHh2+18yoiy8MebIcvO7qWcWqHKeLB1M/UjyYYHE9
         pmC7y6PmTaMZiNWclI0yiTE3XabUzmwLFBt5C4JWN4cXkEDSX68iV7PFzHM3TSMapSrA
         +Hw9VpMXQzW7NSOKhh86EChiGA2RmVCqUlndTf8nYO3o/FU6m9uzenCm4rA1jgHcQiUB
         Yc7hy3eOEQrrAdF5kRa2lsIkj0DOy4fz1zsMIcSYv23dQPJ7q2YjFaQUSwCbGUomfoJy
         dJRw==
X-Gm-Message-State: AOAM530qs3YUfBnqxtLTVXKx/8NPnB/uvRQENmV7Fm7E+7EY00JjTqTt
        BooIPYJhMJqN7KpqTddkCjDRZv+ngtkMEyh8bBIKSA==
X-Google-Smtp-Source: ABdhPJyUqqfkD7z8rVARq/6IOe6ofKeo9UmbLfYZ9Cd5wzhOG+enr+XxQep9MOXRxxv2Ny5oFlSYCFcyjk8j6XBBZNg=
X-Received: by 2002:ac8:5949:: with SMTP id 9mr3025053qtz.67.1623745985682;
 Tue, 15 Jun 2021 01:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009c083105c4b34e70@google.com> <8ba465e6-f933-6224-ef74-c5aa898a1022@toxicpanda.com>
In-Reply-To: <8ba465e6-f933-6224-ef74-c5aa898a1022@toxicpanda.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 15 Jun 2021 10:32:53 +0200
Message-ID: <CACT4Y+anyMbe-GQ040BN1dRO=stayqGDPLUpV=c89BUs6qzTCQ@mail.gmail.com>
Subject: Re: [syzbot] KMSAN: uninit-value in generic_bin_search (2)
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     syzbot <syzbot+8aa9678d1cda7a0432b7@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, glider@google.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

_data_ On Mon, Jun 14, 2021 at 8:53 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 6/14/21 1:41 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    6099c9da x86: entry: speculatively unpoison pt_regs in do_..
> > git tree:       https://github.com/google/kmsan.git master
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12c7a057d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4e6842a91012889c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8aa9678d1cda7a0432b7
> > compiler:       Debian clang version 11.0.1-2
> > userspace arch: i386
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+8aa9678d1cda7a0432b7@syzkaller.appspotmail.com
> >
> >   tracehook_notify_resume include/linux/tracehook.h:189 [inline]
> >   exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
> >   exit_to_user_mode_prepare+0x486/0x560 kernel/entry/common.c:208
> >   __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
> >   syscall_exit_to_user_mode+0x35/0x60 kernel/entry/common.c:301
> >   __do_fast_syscall_32+0x14f/0x180 arch/x86/entry/common.c:145
> >   do_fast_syscall_32+0x77/0xd0 arch/x86/entry/common.c:168
> >   do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:211
> >   entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > =====================================================
> > =====================================================
> > BUG: KMSAN: uninit-value in btrfs_comp_cpu_keys fs/btrfs/ctree.c:1556 [inline]
> > BUG: KMSAN: uninit-value in comp_keys fs/btrfs/ctree.c:1528 [inline]
> > BUG: KMSAN: uninit-value in generic_bin_search+0x799/0xbc0 fs/btrfs/ctree.c:1702
> > CPU: 1 PID: 9364 Comm: syz-executor.2 Tainted: G    B             5.12.0-rc6-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:79 [inline]
> >   dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
> >   kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
> >   __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
> >   btrfs_comp_cpu_keys fs/btrfs/ctree.c:1556 [inline]
> >   comp_keys fs/btrfs/ctree.c:1528 [inline]
> >   generic_bin_search+0x799/0xbc0 fs/btrfs/ctree.c:1702
> >   btrfs_bin_search fs/btrfs/ctree.c:1724 [inline]
>
> This appears to be a bug in KMSAN, the code is doing the correct thing and it
> appears to be complaining about tmp, which is initialized either in the if or
> else part.  The else part may be what's confusing KMSAM here as it's essentially
>
> struct btrfs_disk_key tmp;
> struct btrfs_disk_key unaligned;
>
> else {
>       memcpy(&unaligned, ptr, len); // read_extent_buffer is basically memcpy
>       tmp = &unaligned;
> }

Hi Josef,

Thanks for looking into this.

The mere fact of assigning something to a variable does not make it initialized.
Namely,

int y;
int x = y;
if (x) ...

is not much different from:

int x;
if (x) ...

Are you sure the data used in the code is in fact initialized?
KMSAN says the data originated in btrfs_alloc_tree_block. Was it
initialized? Where?
