Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5C265F48A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 20:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbjAETdy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 14:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbjAETdf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 14:33:35 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734EB632F
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 11:31:20 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id y11-20020a056e02178b00b0030c048d64a7so17585583ilu.1
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jan 2023 11:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHitcvZ97hShjTanm2Z1738H5JrjpQR9jWA6jzfw080=;
        b=bu7gG8v+pfhH15WEQNpxyfAYreoMui0reL2ltz1ATPodgPRhfmG64apHsEyuLPESDE
         /KjSS3HjQJU6NvmtRC0N+v+yq8frDx/UNh/y2/KQh36zZFyfHGhPIJos/I+/gcKq++mg
         JmP2Wnropi2CLkPqTX1FURc+IxLNIuBIsViRzamReAXBjbXy8Dg+pJYqmRBYRftXhZ9+
         t1ma7KvqfD5GjKBNq05bo95/y7Ljd6SXsHNy5ICP62e5wrax54QNHM8qbuQ9HMV9klu/
         lnmNzX/0bmrff3WTIYIDb4JeMIU44zQ5+qXxzWxgHPqyfNOA9j6ZPr+wO1+Z7tEvkv9i
         k7mg==
X-Gm-Message-State: AFqh2kqDQ5+WeQadP/tPFfkdUxV0dFi4tCi0z5cs0ms47MUbt0M0xq2e
        AEBa47q7zkTlPswIdlgenFAlAN8j+55oS0Tf/0dY0v2KOy0u
X-Google-Smtp-Source: AMrXdXsmzWZjH2qNr3kPWcUgcVDuVtjE/cdxWStjZYrlgBwEYkDkujVcC9u6HELosFV92GLRuU7BnAbsCB1X0znqsIu3ssBk32sH
MIME-Version: 1.0
X-Received: by 2002:a02:238c:0:b0:363:b2f7:64d9 with SMTP id
 u134-20020a02238c000000b00363b2f764d9mr4162831jau.211.1672947079603; Thu, 05
 Jan 2023 11:31:19 -0800 (PST)
Date:   Thu, 05 Jan 2023 11:31:19 -0800
In-Reply-To: <000000000000a2432a05eea26be6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000686d3405f1895819@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in insert_state_fast
From:   syzbot <syzbot+9ce4a36127ca92b59677@syzkaller.appspotmail.com>
To:     clm@fb.com, djwong@kernel.org, dsterba@suse.com, fdmanana@suse.com,
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

syzbot has bisected this issue to:

commit 05fd9564e9faf0f23b4676385e27d9405cef6637
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Mon Mar 14 17:55:32 2022 +0000

    btrfs: fix fallocate to use file_modified to update permissions consistently

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ef1870480000
start commit:   644e9524388a Merge tag 'for-v6.1-rc' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ef1870480000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ef1870480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12806381880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127f33c5880000

Reported-by: syzbot+9ce4a36127ca92b59677@syzkaller.appspotmail.com
Fixes: 05fd9564e9fa ("btrfs: fix fallocate to use file_modified to update permissions consistently")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
