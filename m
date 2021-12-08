Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C9546DE07
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 23:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbhLHWPn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 17:15:43 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:49748 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbhLHWPm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Dec 2021 17:15:42 -0500
Received: by mail-io1-f69.google.com with SMTP id h16-20020a056602155000b005ec7daa8de5so4810044iow.16
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Dec 2021 14:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YDuFQ6emh5gUoA6TdFfIdjfCjIG5wOobAHlEcRoJOl8=;
        b=SDVISMrDIuojC+BJPX79dN/bCxfP2p4O/IyTtKQkLVigJDmMIG90TjWNF+obbkeCRx
         YVoyd20p3ObH6A3msPOJJKebspwTJIZhTpAw8F6d9oRAyP1b90PhKmLaLYww29DQGVa/
         6zlEpSes5wdorxdQTcHd9EchtVziMZ3OPJBEghpLrFuGB255vIL51ep49OoGQB6x8mtO
         9BxkCUBjot+yNHrJnvDsslutxARjC/1zA0SLYB/giDVuGABU61VBUd0W+EhVvAMnUdRC
         mJlQDemG2MlDrPOAF/nWlY5aNBeOayhWKB77zPO4++Nu/LLY3W+6F5iFPkYa8IwT2Pcw
         rbxQ==
X-Gm-Message-State: AOAM531ibwfM0aDbIQAQgTxHfsLx37Llz0moAmLWV/u+nrhok8oTZPd6
        1sKayTqQc823C21s66pZvmBQysXakNZm5opdZkWdYZRkINnz
X-Google-Smtp-Source: ABdhPJzDOMT8txQxYMhtFkPjs0jYJ8eGusGov8KXPtu3gDsFT0eObG9rdXmU3Y/TVBdj4zBJS2NgvnKjeItwx1YMxCue6BjKIzJ3
MIME-Version: 1.0
X-Received: by 2002:a02:9f15:: with SMTP id z21mr3393897jal.137.1639001529964;
 Wed, 08 Dec 2021 14:12:09 -0800 (PST)
Date:   Wed, 08 Dec 2021 14:12:09 -0800
In-Reply-To: <000000000000e016c205d1025f4c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fadd4905d2a9c7e8@google.com>
Subject: Re: [syzbot] INFO: task hung in io_uring_cancel_generic (2)
From:   syzbot <syzbot+21e6887c0be14181206d@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, clm@fb.com,
        dsterba@suse.com, fgheet255t@gmail.com, io-uring@vger.kernel.org,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has bisected this issue to:

commit 741ec653ab58f5f263f2b6df38157997661c7a50
Author: Qu Wenruo <wqu@suse.com>
Date:   Mon Sep 27 07:22:01 2021 +0000

    btrfs: subpage: make end_compressed_bio_writeback() compatible

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103f2ae5b00000
start commit:   cd8c917a56f2 Makefile: Do not quote value for CONFIG_CC_IM..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=123f2ae5b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=143f2ae5b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5247c9e141823545
dashboard link: https://syzkaller.appspot.com/bug?extid=21e6887c0be14181206d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1218dce1b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f91d89b00000

Reported-by: syzbot+21e6887c0be14181206d@syzkaller.appspotmail.com
Fixes: 741ec653ab58 ("btrfs: subpage: make end_compressed_bio_writeback() compatible")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
