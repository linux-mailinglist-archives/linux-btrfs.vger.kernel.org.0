Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBBE76856C
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jul 2023 15:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjG3NPH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Jul 2023 09:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjG3NPG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Jul 2023 09:15:06 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CF21AE
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jul 2023 06:15:04 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a3df1e1f38so7495301b6e.2
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jul 2023 06:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690722904; x=1691327704;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujxfyGz6aP3+bL3wx8HXRBterKxnWJIS46oEXqsvR9M=;
        b=a6MPc64ROJ3jMj2EaTjnYXCJdo3NepxA4DSgyRVlqzmwM6d8dGDnMWtaznPBZ+eX86
         tyLCsiA8uzQCK8+eereNrNmBG5WNMCczXdIlJ8Jcf+62AvyV8BeT0MSWRV3qI2nD/xKt
         Q6oJyyuASgruzu9a6k+gWFcHi00G1ijJZ4UK9IsVm47HDkcVBLWqOgvJfs7tgQ4TQ/KJ
         mfX5+syQ7SB6trrjdx7q6JI3ukIwukUpPExQPTnaD3wMoeVrDJGK9rsYfhFusVsYFI3Y
         JNiNgwo36AAIK/KOjvktSyW6+Flw9ElLySMexJz8pSx6QOBzINxiphXsqvRmmFzsaD08
         UEog==
X-Gm-Message-State: ABy/qLZz/w9kvcmubqHGk2B5Wb4H2J9eIVS2EQXjRhNJ2YSD+qw+Je5S
        rk+oMxtnEBW6OKaX0Iruef/MJZVki9AOq1g8sV8eRm72CA0V
X-Google-Smtp-Source: APBJJlHtBlxRMaOo42huwetO6El+kvMunHmSRso82LX/eGklZ6M3gBwmCtOfCmCosZg3xOG7qZ0H9fypADjBmDys9yhFNUx9h0sm
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1993:b0:3a4:18d1:1638 with SMTP id
 bj19-20020a056808199300b003a418d11638mr13908863oib.5.1690722904062; Sun, 30
 Jul 2023 06:15:04 -0700 (PDT)
Date:   Sun, 30 Jul 2023 06:15:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c40170601b41a3e@google.com>
Subject: [syzbot] Monthly btrfs report (Jul 2023)
From:   syzbot <syzbot+list78bb969b37073eea676a@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 4 new issues were detected and 3 were fixed.
In total, 51 issues are still open and 35 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4533    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  1115    Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<3>  804     Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<4>  678     Yes   WARNING in __kernel_write_iter
                   https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
<5>  373     Yes   WARNING in btrfs_block_rsv_release
                   https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
<6>  294     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
<7>  249     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<8>  210     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<9>  200     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<10> 142     Yes   INFO: task hung in lock_extent
                   https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
