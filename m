Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B97E1385
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Nov 2023 14:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjKENHa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Nov 2023 08:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKENHa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Nov 2023 08:07:30 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2575FE9
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Nov 2023 05:07:27 -0800 (PST)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6ce322bbb63so3740633a34.0
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Nov 2023 05:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699189646; x=1699794446;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17+OiAdjnksb54atTiSO83QAo/t+7eezn3BKvlonFgc=;
        b=AxE/wkA9+ScwIg0dqwiUpGnPz5Cmm8/qKlU6/7AYN2f4ucpom4AD9+wgWrPkVEQ55D
         9b1y4Fb9LE3S5XZ9odJZATJm3p0NDz+5S0om5Ha1ZYDVfShjHDJD4Yn7e3g37DXmFoNN
         wTMT0rlgl4ArkZj5VooVm+c0Jjrg3V+mzu6qrfDqnyUy4LOJhHaIVH9qTG0ifBqT9uUJ
         igTKWqp+oJp3WjDmJDEcN46avq5h+UpNv6GAkUr8hvrP3+bJw6J0vdh5umc2fd1oUBZB
         fA4e3kdZbT5CMovQj/y+ZqCPs+/CRAOKQkK0H9W3XqSVE0OoJuOIYLNr9RklesLU0Ip9
         hftg==
X-Gm-Message-State: AOJu0YyF8GdRCJH9FOp7Xm7jJvGiewAzlCVQtiOyh6yMgHns0WrHysuX
        h6sEYCH9wrRH3Pq5tzl0knpAigZsEdBA5B6Vy1kSs7AlR166
X-Google-Smtp-Source: AGHT+IFviFkSwvEhccN8YdDBniWK/osExJFWr3CT0VV7FYAEW4sdmB6lTIUGTtVIUtX5KSyiFnLqK7wi6Qw+zwPl3XZ1M+dOT/ap
MIME-Version: 1.0
X-Received: by 2002:a05:6830:3d09:b0:6bc:af19:1d22 with SMTP id
 eu9-20020a0568303d0900b006bcaf191d22mr7671000otb.7.1699189646504; Sun, 05 Nov
 2023 05:07:26 -0800 (PST)
Date:   Sun, 05 Nov 2023 05:07:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000493bc20609676b0a@google.com>
Subject: [syzbot] Monthly btrfs report (Nov 2023)
From:   syzbot <syzbot+list60f60686fc15f64ee667@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 53 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5549    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  1540    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  1026    Yes   WARNING in __kernel_write_iter
                   https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
<4>  373     Yes   WARNING in btrfs_block_rsv_release
                   https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
<5>  288     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<6>  212     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<7>  206     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<8>  205     Yes   INFO: task hung in lock_extent
                   https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
<9>  109     Yes   general protection fault in btrfs_orphan_cleanup
                   https://syzkaller.appspot.com/bug?extid=2e15a1e4284bf8517741
<10> 91      Yes   kernel BUG in insert_state_fast
                   https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
