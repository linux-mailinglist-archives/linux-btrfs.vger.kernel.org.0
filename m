Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD8781EFF
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Aug 2023 19:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjHTRVT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Aug 2023 13:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjHTRVM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Aug 2023 13:21:12 -0400
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B45E1FC3
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Aug 2023 10:16:38 -0700 (PDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26b10a6dbcaso2847029a91.1
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Aug 2023 10:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692551798; x=1693156598;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCSk00jAApWamdTfi1WTVOGP5cs400bLmhiOEbCKesk=;
        b=At6BUkixk0SKnFNlVEKFPWxztzMQPlpBO/bVlFI92gw66f3rIzt0Gz4i/zs8WPl4vb
         qnKa85Y5+nseTvffPKnmafVMp7BNct1ePAUMPO+ZKowohZGzPZSD0M6eudR+cX5qTFGL
         n6Apzj+3Z/MjmyIyF7/3b7RDw4dAxvCizKhh/PW/478aoYGmT878xKwdN0icYh93lyTa
         8ILpFbM8qhfXdz1AZRCmSy9jlwCfRAXy8aHQhJq+D6uKpQiSsFMMyLOgY+XNl70+3B7S
         m0Fjn6fa4IU5RcLDpw83/7rqvognKZCHyIumUj65plAYkpZNXQYm5s6MiomO5YBNOI70
         7a6w==
X-Gm-Message-State: AOJu0YwoRvmjx0fbNRjck/D0WcPuap3npJCD8b/igCmBDkXi/LRmPh2O
        OUnh+4wkP8tKGCbVMw/oBTi5zzBArm1AXCrHGM/4hWUpk6et
X-Google-Smtp-Source: AGHT+IGbFyIS9NDNfSrv5ROBrZBSPZIn7XTQBYjYL7hVeWwbUyvw2yfdQ7peX/lgKHMqNK63IFqFy3dwHdOqk0yKDRy9FVbvtwws
MIME-Version: 1.0
X-Received: by 2002:a17:90a:e38f:b0:268:3469:d86e with SMTP id
 b15-20020a17090ae38f00b002683469d86emr896563pjz.1.1692551798085; Sun, 20 Aug
 2023 10:16:38 -0700 (PDT)
Date:   Sun, 20 Aug 2023 10:16:37 -0700
In-Reply-To: <20230820163131.205263-1-code@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0609a06035dec44@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_cancel_balance
From:   syzbot <syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com

Tested on:

commit:         706a7415 Linux 6.5-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=130c1e5fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=d6443e1f040e8d616e7b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
