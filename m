Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617E778DA64
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Aug 2023 20:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjH3SgP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 14:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242857AbjH3JxM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 05:53:12 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE05CCB
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 02:53:09 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-68bec43ec0cso6708836b3a.2
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 02:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693389189; x=1693993989;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzHfCFTnMqiRc3QC+Ez91qszxdCPJ8z3TEmrMibThBo=;
        b=WcQJKrUS1FiLJCVuZ4jUBmYc7hQ5neeKNA8PvQt3dYG5Qkvzj8PONpeyQfgb/BT8Mh
         wYtvNZaBEPaszBT6lEkD2N2GiHZIwARjSX4w1zWucqN1UBdT/HVq0ShJIKX//YBri2Lc
         pRUtIS8IpeD09ywOfEXGC6W0otxPRrJCo1zqoUv78M7KYyz6co5lvHHvFj6k/pr1LWru
         Y5LCCm+scztnTned1ui+O52OYQ72XV63SVG9h4dcbKfV7ne1qPpQTDpZE/PqLUKxp/zJ
         X0L3/vrNcLYesYi48VgBbgFcQr07J5NTd71uoOQLpQV+c4eHgZ6soXt32Hi+Suqn72Ws
         lpFg==
X-Gm-Message-State: AOJu0YwDfbnA9mMAdhC/G6B+fthibAUCkVHKQ0H0kLcLaluF4jc18Yw9
        jc5WRv2WJ4VZAzAeB3IbLXaoEGjIv3PsK2woezoUIia4C+Ef
X-Google-Smtp-Source: AGHT+IEFbtW9dUlVtXjbvzQEeZ3dBkPMebb+v/x8PTR70mT5YNAC4VJuW4mF4Sl+HGZj2RTmt4R+j6UhLQLFI1PLR7U4bup+E6wz
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:21cf:b0:68a:5cf8:dadd with SMTP id
 t15-20020a056a0021cf00b0068a5cf8daddmr631221pfj.4.1693389189024; Wed, 30 Aug
 2023 02:53:09 -0700 (PDT)
Date:   Wed, 30 Aug 2023 02:53:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001411fa060420e5f4@google.com>
Subject: [syzbot] Monthly btrfs report (Aug 2023)
From:   syzbot <syzbot+list902b4a7ca2aca212df12@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
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

During the period, 8 new issues were detected and 1 were fixed.
In total, 55 issues are still open and 37 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8234    Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  5325    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<3>  1042    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<4>  809     Yes   WARNING in __kernel_write_iter
                   https://syzkaller.appspot.com/bug?extid=12e098239d20385264d3
<5>  310     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
<6>  273     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<7>  211     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<8>  202     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<9>  147     Yes   INFO: task hung in lock_extent
                   https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
<10> 89      Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
