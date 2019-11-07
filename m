Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8881F3009
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2019 14:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389230AbfKGNmL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Nov 2019 08:42:11 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:38116 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389211AbfKGNmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Nov 2019 08:42:10 -0500
Received: by mail-il1-f197.google.com with SMTP id f6so2669892ilg.5
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Nov 2019 05:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZHlAkJvC4AzLYOgESJJjCrLwj1SC/DFrfw0gQTfFdTQ=;
        b=JW1ufKHnTzSETD7J1OzOm5cxckKhovpv9vn9KpjeeEEJ0EsGyyRee0HonPVYFdtov3
         Mjxh85K1gqy1yHeUOyo/9mRC5C99bon3SjuxDM1R0OlpoUq1hMjlxFALUr4NbEwQBErn
         mk+yml1+uZoP2RnA9oMqoahAiC53dD1Al+MIgCjeusEmMHu0atd4wg6hsnTp8sx531UR
         2owJnFbdvN+uQ13Z7qOEd/bFcU0TTSYTqdFKtD8dpB+1PvkQ8Wr0SQao0UGwy2MiB4eo
         W0shaD1aCyPS0tHuZeOk/juL1Zvbi6lSpjoO1p8MzNRcHiPDdYp/rHKzZxQOX32g/9Tq
         oRGw==
X-Gm-Message-State: APjAAAVB3CzkvrOdQbGt9ngwqoY0oEVG4MYhGExGmBBIrHixQaGq6CNi
        qGiUnkXZ3ex4yuGDy8+yhI/5zu61EHrW31aA2ghseLBuM/b6
X-Google-Smtp-Source: APXvYqy98iNl1kKSai2jcmgSIkxjPCuJlUrj+Tm8vB/VRQBb354vs8ydYDcKDIM+Vg31Z/X164elRv8qzu3LjKXgEKIcBqJW11oo
MIME-Version: 1.0
X-Received: by 2002:a92:8681:: with SMTP id l1mr4407473ilh.94.1573134129675;
 Thu, 07 Nov 2019 05:42:09 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:09 -0800
In-Reply-To: <00000000000051ee78057cc4d98f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbc9650596c1d456@google.com>
Subject: Re: general protection fault in put_pid
From:   syzbot <syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aryabinin@virtuozzo.com, bp@alien8.de,
        cai@lca.pw, clm@fb.com, dan.carpenter@oracle.com,
        dave@stgolabs.net, dhowells@redhat.com, dsterba@suse.com,
        dsterba@suse.cz, dvyukov@google.com, ebiederm@xmission.com,
        glider@google.com, hpa@zytor.com, jbacik@fb.com,
        ktkhai@virtuozzo.com, ktsanaktsidis@zendesk.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, manfred@colorfullife.com, mhocko@suse.com,
        mingo@redhat.com, nborisov@suse.com,
        penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, rppt@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, vdavydov.dev@gmail.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit a8e911d13540487942d53137c156bd7707f66e5d
Author: Qian Cai <cai@lca.pw>
Date:   Fri Feb 1 22:20:20 2019 +0000

     x86_64: increase stack size for KASAN_EXTRA

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10364f3c600000
start commit:   f5d58277 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16803afb400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: x86_64: increase stack size for KASAN_EXTRA

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
