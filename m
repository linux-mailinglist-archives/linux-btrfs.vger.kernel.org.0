Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A397363B3FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 22:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiK1VLT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 16:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiK1VLS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 16:11:18 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903CF21BE
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 13:11:16 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id r197-20020a6b8fce000000b006c3fc33424dso6877715iod.5
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 13:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vrFvgf3kC0HHJ1u0C1MfigaITyNx2eYmkBwRJdnQic=;
        b=56zrifjDsZ0dow4XDIAhD9ITKoUApAGxi+T9mIuh5eXyyQ5e2nPl60ZUolUv4kko3+
         +U4/zKOIG7w1X+wIyBlU2LOPkS1E+e5T1L34cNrsvVhpC8ZhM6pzK9kOBBUhR6tj/1jo
         NJ2GesRIvKrnNPtt965PadKXs2TEZ0/VKHxIkQep3NlCXpvm1ohjI9+9Rm95zgU0qszM
         3kBr4Ihr8DSo2ty2Tf23p0/yldYRBNtaK9YSSMqd7KH5PSUNmQAv+uKz1Bx5NpLBI75u
         7BJct5dct2laFL1j6VsTNuwzt7Nij8mJbgNyDL70/Rmlx3ud1H0cxgtw6didq/Z+xjLX
         7jkA==
X-Gm-Message-State: ANoB5pkDn8i6XzS3uzauUD9yi3sVX9g73MM9GiMM3RPRidzzJP3ujgAz
        ORdgBflz7fxcw1H52pSh3SraNA5enfkdtVslrDzoJ4KXeLnf
X-Google-Smtp-Source: AA0mqf7nkU1Jbpcji4kFBESpoY6kF2tL8/7c5Hh6oW8lp6EE/JxTkrQM8rCd1l6CmBzg424AY7Gr/fvtNlX33s4+k5JkdqGbr5tr
MIME-Version: 1.0
X-Received: by 2002:a92:4a0f:0:b0:302:e9ff:dc96 with SMTP id
 m15-20020a924a0f000000b00302e9ffdc96mr11245832ilf.236.1669669875947; Mon, 28
 Nov 2022 13:11:15 -0800 (PST)
Date:   Mon, 28 Nov 2022 13:11:15 -0800
In-Reply-To: <0000000000000c379205ec806d6e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d921ab05ee8e4f48@google.com>
Subject: Re: [syzbot] WARNING in btrfs_commit_transaction
From:   syzbot <syzbot+9c37714c07194d816417@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, dsterba@suse.cz,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

commit 8bb808c6ad91ec3d332f072ce8f8aa4b16e307e0
Author: David Sterba <dsterba@suse.com>
Date:   Thu Nov 3 13:39:01 2022 +0000

    btrfs: don't print stack trace when transaction is aborted due to ENOMEM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e020bd880000
start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=9c37714c07194d816417
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17401632880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13176716880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
