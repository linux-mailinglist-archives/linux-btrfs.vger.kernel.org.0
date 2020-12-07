Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949C02D0D64
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 10:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgLGJvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 04:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgLGJvu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 04:51:50 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AC5C0613D2
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 01:51:10 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 19so4379731qkm.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 01:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VR9ccj3VZSQzXddm6nlHnfILAXhosyXfLldvzBYO/DY=;
        b=u15bSG0X1jXZKkUKPXr4OSV5mRVqrVENiAIEb/4bZwToS7erDlBOdigOMm5wl8RQYK
         Up+j+FNcq0ay82L1iUexGikTW9ujx9BNGzSlyD2XFRIRbwfqO5dk0tyA2LGXy+cI8DIT
         qkq7PQ6C+q91BC6V7NEkUaVV0xFWsM/gvQXgxgAx4Vg42S7VzgDhCkNL/QiT1a9Ycgm5
         pDrAFrObzsTTMlEpEtFr7dakHdDEbhSDghSwEo3kAPjO8N2KI/p6DdStsyYV+JJmD6dh
         /icY7bqV+aBlVklxdBzwLlB0iwF1u5B7sK6X+KwpZlFT/D2oa+opCBqkcLhiKAMKk9X+
         tv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VR9ccj3VZSQzXddm6nlHnfILAXhosyXfLldvzBYO/DY=;
        b=R/4qb2AYsrvkQ9ShAcoX9aZK3eQcb3mq53tRSYe/EzFkKIF9JuP9U0gxp+v9A6xiHE
         9HbmN2IEXWCxR+fbT+eDofyEGtqykOCbQnEy3v+SnpKUKPcyEGfR05Oo/DjshpnjYK3Q
         +zE5GO7UkZXtFHQKfMRRNC3bsJc319zyGz/M7uNYI3OHH8IdHc1aH0U2QtQCEBGXynQV
         YaNWMy5+5LxcaCcKJY2rqQHIKPv1tdrRwLmDGX7OcovH0TTFx/zWglQrxyciRiZ1bpMt
         ZCoytr5arU4rK8caQx28o8Fxmm/BWDO0KFCTmXsSrmjpQBVQ90JjX3hYH4GDBc/Hed0y
         pQeA==
X-Gm-Message-State: AOAM533jioHMnRQMU/sDo33uuZcaHdCH+i7TZnoOEqMf9ewqQoc0jrgM
        gCcCEOeF4XnznoY2fHlxC4hsOZWSCZN7l4f9pDQgVA==
X-Google-Smtp-Source: ABdhPJyeX5PDWFLgbYSZU1JT0BNzdVw8jgRVtz7EdtF+safLiBICjtFMUcoU+XhYCGM//ibi5Ta4pCnsmQCuJK1KaTI=
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr23807360qkm.231.1607334669170;
 Mon, 07 Dec 2020 01:51:09 -0800 (PST)
MIME-Version: 1.0
References: <0000000000002ae6eb05b3bd420c@google.com> <000000000000e0aa9a05b5dc86cb@google.com>
In-Reply-To: <000000000000e0aa9a05b5dc86cb@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Dec 2020 10:50:57 +0100
Message-ID: <CACT4Y+YnN6dnvfyfTizEbvSuBG2bqhD5n46AYSiTmLmmOQcFkg@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in btrfs_scan_one_device
To:     syzbot <syzbot+c4b1e5278d93269fd69c@syzkaller.appspotmail.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Chris Mason <clm@fb.com>,
        dsterba@suse.com, johannes.thumshirn@wdc.com,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 7, 2020 at 10:34 AM syzbot
<syzbot+c4b1e5278d93269fd69c@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 0697d9a610998b8bdee6b2390836cb2391d8fd1a
> Author: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Date:   Wed Nov 18 09:03:26 2020 +0000
>
>     btrfs: don't access possibly stale fs_info data for printing duplicate device
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fb0d9b500000
> start commit:   521b619a Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' ..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e791ddf0875adf65
> dashboard link: https://syzkaller.appspot.com/bug?extid=c4b1e5278d93269fd69c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16296f5c500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1614e746500000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: btrfs: don't access possibly stale fs_info data for printing duplicate device
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix:
btrfs: don't access possibly stale fs_info data for printing duplicate device
