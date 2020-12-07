Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B52D0D15
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 10:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgLGJev (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 04:34:51 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:38583 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLGJeu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 04:34:50 -0500
Received: by mail-io1-f69.google.com with SMTP id q140so11446013iod.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 01:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lM8WLkinSDHgX0CP1qhRRtUnNv9UgUMhc5+FYvvQq+4=;
        b=ZzWIH9GUiBjTxMYyuOdpAqrXJw32apm3NPBuqpHiKoSdXeRiq8F8X0UoRmlssD1YNc
         SJfzw5gfCD6+vSBG00/NDTfsYrkQkGXhlXnGe0Zr1t3AKi1IijccleFOG2EwSRCcJS7O
         oZHGR37aE4+cGCcXaPJr4nPzWpHU9vFHIX3EJk/qtqEVgt+5I9kkK1Noz+3wubmQyQn1
         hyZQvWqrBHXTNVu8in+kU7i9w7vQznpBbA1lz77aa0JqwB8sTu1RD/W0l2XXgDoQfbFc
         G0ySH5MzfuIKGAb1MAbFgm4St9Gapm6w5xZTFbIXJgVyW5ACXuIRDIBx9PvM/b0pvKw0
         Z1Zw==
X-Gm-Message-State: AOAM531Ub0mv2wJGKETstpbQY6+e3xguj7jhdCvTc2z8N8pWzkReiQQL
        yubw468W+pbW3CHefTQigCmFX79Uk9ge1cOc/xfbAx/QEUE0
X-Google-Smtp-Source: ABdhPJxiaeneNlDt35Xc9SOPXO/UFyyutzJ3zRt1jb7qr+u3x1AAXCpLVEIA0wmIkUqXkcpOj6N1ezTtw1h2zLhDVr7ppP5/uyYT
MIME-Version: 1.0
X-Received: by 2002:a92:c112:: with SMTP id p18mr14337470ile.89.1607333643854;
 Mon, 07 Dec 2020 01:34:03 -0800 (PST)
Date:   Mon, 07 Dec 2020 01:34:03 -0800
In-Reply-To: <0000000000002ae6eb05b3bd420c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0aa9a05b5dc86cb@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in btrfs_scan_one_device
From:   syzbot <syzbot+c4b1e5278d93269fd69c@syzkaller.appspotmail.com>
To:     anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, josef@toxicpanda.com,
        jthumshirn@suse.de, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, nborisov@suse.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 0697d9a610998b8bdee6b2390836cb2391d8fd1a
Author: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed Nov 18 09:03:26 2020 +0000

    btrfs: don't access possibly stale fs_info data for printing duplicate device

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fb0d9b500000
start commit:   521b619a Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e791ddf0875adf65
dashboard link: https://syzkaller.appspot.com/bug?extid=c4b1e5278d93269fd69c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16296f5c500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1614e746500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: don't access possibly stale fs_info data for printing duplicate device

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
