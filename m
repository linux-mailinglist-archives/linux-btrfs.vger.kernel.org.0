Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA267FD7F
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jan 2023 09:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjA2IA2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Jan 2023 03:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjA2IA1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Jan 2023 03:00:27 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0B4206A0
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 00:00:23 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id r21-20020a0566022b9500b00707e4ee2b6fso5054329iov.2
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 00:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWUjXLTnw3h+L3dZwm5YKP98PHZMaQaUEy4gOEVllR0=;
        b=au4zRNPCLR9pqa5xP0s62sC/Ii85jtm138I4NQrwBoIPdqeh1I9NN4fq3/N8cFusVR
         Wm0HSTjWB9NHD7NQSzpmPupizh/gxy7O8gtu8ht2XIzzPW/c+kc+SRSiYcplMeI1twn9
         +pS2KqEwJ9KXTFE8Rew0rsgSIZrboQMRR0G4YrYCC+OfFHjL70RTB+F1ZCWmSrKcaPs+
         DN2kxyexIIXiBTHHBQf77t6iazq3RLhY1k3TXT4pGQyDEktpTy7ayUymJ9Lll6mJFfWl
         v8nEvSwZT3qjnuywJ3L5oogBf6QDGH9vzNrXnlHtf9tq1yDu9JQxmWrz3+h/gzzl29gc
         ZXKw==
X-Gm-Message-State: AO0yUKV9H5GsTEjw0KSKJG38kabhVDqw6FEqPRTsMZpGyNOpLyKN7Y0g
        XDdGmyFXysXb65xIpjss+DtOdvXOYXRJ/WAIKrO7f9yY3642
X-Google-Smtp-Source: AK7set+kUJ90GQ7HGXxpBff9eEcbdEcLgNAdzlX2Mf8X4xcjkWW2R9ZNa7JKjDRN4WMZw4u6J7f3RfS2pX3PS1zWMS+aL+pM2RyE
MIME-Version: 1.0
X-Received: by 2002:a92:3004:0:b0:310:bb17:2ffb with SMTP id
 x4-20020a923004000000b00310bb172ffbmr1222681ile.144.1674979222613; Sun, 29
 Jan 2023 00:00:22 -0800 (PST)
Date:   Sun, 29 Jan 2023 00:00:22 -0800
In-Reply-To: <00000000000076699c05ed7c54a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091f75805f3627ddd@google.com>
Subject: Re: [syzbot] possible deadlock in btrfs_commit_transaction
From:   syzbot <syzbot+52d708a0bca2efc4c9df@syzkaller.appspotmail.com>
To:     anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        hdanton@sina.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b740d806166979488e798e41743aaec051f2443f
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon Nov 7 16:44:51 2022 +0000

    btrfs: free btrfs_path before copying root refs to userspace

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e58bae480000
start commit:   08ad43d554ba Merge tag 'net-6.1-rc7' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=52d708a0bca2efc4c9df
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114d3e03880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1320ea4b880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: free btrfs_path before copying root refs to userspace

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
