Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08ECE2ED064
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jan 2021 14:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbhAGNLy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jan 2021 08:11:54 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:46530 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbhAGNLy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jan 2021 08:11:54 -0500
Received: by mail-il1-f199.google.com with SMTP id x14so6388520ilg.13
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Jan 2021 05:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oRgWg98/FIZVEp9r8aGEhshpBf9hX/r9V4Oyf+qndMQ=;
        b=e+feLOE//VDkAJP3sCFvqfm3i6fgSAgrtu44yH8uQe7vWT7t6YAi2YEMJYsT27nAaX
         Xe0qAoRMi479RFXLBphegh3REzr43gWDHdDtcU2Y/8Na7W5qdO5SNCeMn41U38C9lPjZ
         LTfInJzym8BmZ+u8p92rzX7d7mAEKYEiv2c7KTMhUNs4b4bfMBnC6pDb5hAr9b6QrSxo
         +KkmTiEwoa2GHqAjw8dFot2joZvN5NugInzz0mHTvAlv4AJqxDksg4z+y4gv6IIN1zAs
         Yp4IXJeCARpDZEcVudoD1E5UDzBxxjzPfKO3eOd+Wx+NPlD7gaaOT0AHSJltanGBrFXs
         50Tw==
X-Gm-Message-State: AOAM532GeWNerTf1ASc/Euj7KtYrPIWZVGvNc28z6MXy1iMAhqi9JHgA
        3oCJ152wzfooNVpiIk0JW5ru2R3GDtSOi8bTHSbF5/SsJpru
X-Google-Smtp-Source: ABdhPJzAnEVXSY+0SUdfW+TlfG3lxIrSn4jNeUtDM1iW6Sx0nFOKztdga01Tpd5QZdv7OejOUPG+X745sJHHIqpZqgHwQGz1OH2i
MIME-Version: 1.0
X-Received: by 2002:a92:ca46:: with SMTP id q6mr8928737ilo.278.1610025073072;
 Thu, 07 Jan 2021 05:11:13 -0800 (PST)
Date:   Thu, 07 Jan 2021 05:11:13 -0800
In-Reply-To: <00000000000053e36405b3c538fc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f60c505b84f2cd0@google.com>
Subject: Re: KASAN: null-ptr-deref Write in start_transaction
From:   syzbot <syzbot+6700bca07dff187809c4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, fdmanana@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f30bed83426c5cb9fce6cabb3f7cc5a9d5428fcc
Author: Filipe Manana <fdmanana@suse.com>
Date:   Fri Nov 13 11:24:17 2020 +0000

    btrfs: remove unnecessary attempt to drop extent maps after adding inline extent

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ddc30b500000
start commit:   521b619a Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
dashboard link: https://syzkaller.appspot.com/bug?extid=6700bca07dff187809c4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a07ab2500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fe69c6500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove unnecessary attempt to drop extent maps after adding inline extent

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
