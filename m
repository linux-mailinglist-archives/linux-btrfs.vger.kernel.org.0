Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BE52C7A1E
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Nov 2020 17:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgK2Qwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Nov 2020 11:52:49 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:34407 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2Qws (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Nov 2020 11:52:48 -0500
Received: by mail-io1-f72.google.com with SMTP id q6so5659786iog.1
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Nov 2020 08:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qMz6FQvC1fcPUihVEUOwnOdKwTMvJtCoQhjXTojuMcw=;
        b=KfUpL0d4h+fSogp/t9OaBI0BoWDYiEFN454bSfs3j9of24BdA8Yk86Wb0yxWQ0vlGn
         /zsXxI9L8JzF0PG91Yk6UbmMCXCYziTSNZe5HqSIgV+wmcvor/ErdIPvNbK4LcU9pVp3
         s3UaaaIk62TRtmTNgsGDQVWKBapD4eDA2ujF3ZdyFLASnaxV4VuC9A9ktkibV3CkNgzW
         bIMgVLI5+qrOZ+SGqiLNWt0kQ8UbrJUazrIoCYpmbOpHsDrrfx0x7MwWymOlCaKGc22B
         tO5/suKCVdidiy4+EOeo/7UTj1VJa/cJXwUj8TfJUUr9EDviLy3VIdt05AFRWApPaw4o
         1dPg==
X-Gm-Message-State: AOAM533R8H/2BWQBen5E5cQhRTIDWhi1kaekB2nqu57qCUG8o//WsCIb
        kzgvAsj2oCTfZCObfzzTLP6++WZIfdlbZLVOID8lcV0Pa8Jx
X-Google-Smtp-Source: ABdhPJzOzXWgVWYLzenNvr6XVYL/h1lDT6QXlmavbabLKcZKARtOR+kw7Q5p9pzxK7Fav9WuHQJW+8DYmCMwYWJtQ3Qkwd2uXdFO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e8e:: with SMTP id t14mr15320646ilj.207.1606668728344;
 Sun, 29 Nov 2020 08:52:08 -0800 (PST)
Date:   Sun, 29 Nov 2020 08:52:08 -0800
In-Reply-To: <0000000000007e15b505b530766d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d324e605b541b602@google.com>
Subject: Re: WARNING in close_fs_devices (3)
From:   syzbot <syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has bisected this issue to:

commit 4d004099a668c41522242aa146a38cc4eb59cb1e
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Oct 2 09:04:21 2020 +0000

    lockdep: Fix lockdep recursion

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=178c99fd500000
start commit:   6174f052 Add linux-next specific files for 20201127
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=144c99fd500000
console output: https://syzkaller.appspot.com/x/log.txt?x=104c99fd500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79c69cf2521bef9c
dashboard link: https://syzkaller.appspot.com/bug?extid=a70e2ad0879f160b9217
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11727795500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1793dcc9500000

Reported-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Fixes: 4d004099a668 ("lockdep: Fix lockdep recursion")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
