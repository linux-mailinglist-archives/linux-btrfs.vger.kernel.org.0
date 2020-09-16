Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFCB26BF00
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 10:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgIPITM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 04:19:12 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:40708 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgIPITL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 04:19:11 -0400
Received: by mail-io1-f78.google.com with SMTP id f8so4467904iow.7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Sep 2020 01:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MpjW6yPzOhFB98vREk8U50PzmQ08W7Z9iyhJvVdEnJg=;
        b=Gs9uZ/I5/AYn4vSUiIb12hFcg9gXcZ0gAies/swZd6nAnP2+xH1/i3KC28bzl8VDXG
         93MvNHtBMOj1zHQWNWJJ5p/J9nZENwhOzeoK/GZE+vx0WI3fQz7Nf3VGapT/q84+1rIt
         WegDyRotCJgAycbY2Mbj3BdViCSG22xlCuF1/0aPJZudRmt0RwOPW+Q+g9Bh4NXX8CwN
         3ggeY1EpFn08kRQRimoLmQFUsvXfxQ1e5CEzRysdDUt46K5YvqF2DLJmTnqqL6Vce6iJ
         K/o11NZCxPrqAOGMCCB0qf3gnTje/6HwLI5smW5nOMsxI/sgVcRMm3qOjwZ4hieHcjl6
         C7Sg==
X-Gm-Message-State: AOAM5337nDb66haN9IoMzMKPSw2g3iO8sXz3noD1YtJgr7KLpGgnXFji
        D1sHrTmaRFQeXaKNxkvGvMBSq+VNHDxR9USYCLYFKg/owjGs
X-Google-Smtp-Source: ABdhPJwFOyM2R4eo8fW8aOAA9iJyx59dTuWjTzJjlk/np2AmX2NM0Lqembb1/k6o9Y7CdAHXiPP78YaM9lMqspuh/QwIai9kafLT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d45:: with SMTP id h5mr20731707ilj.168.1600244350175;
 Wed, 16 Sep 2020 01:19:10 -0700 (PDT)
Date:   Wed, 16 Sep 2020 01:19:10 -0700
In-Reply-To: <000000000000a61d6b05af580e62@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bcff305af69ecae@google.com>
Subject: Re: kernel BUG at lib/string.c:LINE! (5)
From:   syzbot <syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com>
To:     anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, josef@toxicpanda.com,
        jthumshirn@suse.de, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has bisected this issue to:

commit 3951e7f050ac6a38bbc859fc3cd6093890c31d1c
Author: Johannes Thumshirn <jthumshirn@suse.de>
Date:   Mon Oct 7 09:11:01 2019 +0000

    btrfs: add xxhash64 to checksumming algorithms

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10aadcc5900000
start commit:   e4c26faa Merge tag 'usb-5.9-rc5' of git://git.kernel.org/p..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12aadcc5900000
console output: https://syzkaller.appspot.com/x/log.txt?x=14aadcc5900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
dashboard link: https://syzkaller.appspot.com/bug?extid=e864a35d361e1d4e29a5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177582be900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13deb2b5900000

Reported-by: syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com
Fixes: 3951e7f050ac ("btrfs: add xxhash64 to checksumming algorithms")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
