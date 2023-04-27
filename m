Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB8D6F03FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 12:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243496AbjD0KNv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 06:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243328AbjD0KNt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 06:13:49 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8648C449D
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 03:13:48 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7606d44d4cfso581407839f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 03:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590428; x=1685182428;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIASw9GSY2Of7dAiuTmEdRXJa7/4ehqzLcUcuOFsD+o=;
        b=Yrr24RoE0TkNmm/H2gEz56AaAZ35Rt7L2AMEoEa2KQbK1jRfFTItIwsgCDyyBkLxCo
         RAk4OU4ovConuFYdlPocD4huTxYnnXL8TulnI0nxC69Ex+r7bMrFeqH8EeTg6LlQHLT/
         IUQlFj22DceQnmtfKZG0kGlSKPAxH6JTvOzEpFahicJRHnO9oDks01LRBkOa1zRoVbv8
         1m6ewJWY4IwpNzY1gK/jsOjKPIyTuVZf5ot5M4i/6bQvUhs2B0o+liDAjffJPZ56zqlC
         xLeNni2RNhcBpwMsmL4bd0gKW9c4TP5x4GA5i3wIxn6B5OZeMs+AkLtgMbPICrpIG341
         9oLw==
X-Gm-Message-State: AC+VfDwMWZAtT3OP8NKVJeKDe6mGx9nYC1nrR0oB+p3Jd5lLzmo27bCI
        Rpj5h+q0M1zE4wLaYH5KnS9dWtyuesXxzqawJVBsEMgR7TAR
X-Google-Smtp-Source: ACHHUZ56RFAeCriTAKSh7aExBM934wOdE8tuJWkeAOdKypKxxbZl9RB+VyRBFcAIdtQYvhEFy3z9AqWvUyNz6CChrajmXxlHxL+W
MIME-Version: 1.0
X-Received: by 2002:a02:6345:0:b0:40f:83e7:a965 with SMTP id
 j66-20020a026345000000b0040f83e7a965mr484047jac.4.1682590427848; Thu, 27 Apr
 2023 03:13:47 -0700 (PDT)
Date:   Thu, 27 Apr 2023 03:13:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c122fa05fa4e9c55@google.com>
Subject: [syzbot] Monthly btrfs report (Apr 2023)
From:   syzbot <syzbot+list8d625089c709215832c5@syzkaller.appspotmail.com>
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

During the period, 8 new issues were detected and 0 were fixed.
In total, 52 issues are still open and 25 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2242    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  486     Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<3>  365     Yes   WARNING in btrfs_block_rsv_release
                   https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
<4>  319     Yes   WARNING in __kernel_write_iter
                   https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
<5>  274     Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<6>  190     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<7>  181     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<8>  180     Yes   possible deadlock in btrfs_search_slot
                   https://syzkaller.appspot.com/bug?extid=c06034aecf9f5eab1ac1
<9>  162     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<10> 138     Yes   kernel BUG in assertfail (2)
                   https://syzkaller.appspot.com/bug?extid=c4614eae20a166c25bf0

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
