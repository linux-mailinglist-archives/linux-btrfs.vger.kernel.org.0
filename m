Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E496B3CBF91
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 01:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhGPXKD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 19:10:03 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39428 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbhGPXKC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 19:10:02 -0400
Received: by mail-io1-f72.google.com with SMTP id v2-20020a5d94020000b02905058dc6c376so7034254ion.6
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 16:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qaMOIh2upbMs9hOM1Tz4AOxQSYOvrsMlI718rr6A6Is=;
        b=hOCeidJJZvSlv95DxCXkA+r1+CvQxa9VcsxuK/VZyl3cQq9HIMBnYTd9m4Sz8TIC9A
         hk90/t4PE73GD5bCgxAlzn6FUhQ/7vU8gbUEgF/hpTDBDdzwvCcmLmMlxvM58UjaYjup
         DygJYQXByRB44uXr98dWlxAtqy4WWwuaJ+PKFwv8UqI4Wj1zTvaWTo/RgbEUAOXgU3GH
         xaPtGsUYQKq/pePbBOaoPwuivOfK42ySMQDy42P9EithCQvozZwFqX7FPMFjPcI4smvk
         k9tf/MbaisNlevl9weIdo0zjz8+WK2KD9a1uhWUQ4WwY9B13KMKh+4px3GZ7J6srdO20
         gCrA==
X-Gm-Message-State: AOAM531d3cv9M2zqDVbyURQy8EyggW9d0Tac8ywU/wHjRX46D2xSqZAM
        s1PohOcDA9dKIofevYGlWaNDdG5W3avNIbKzBwpPfuxXnOzy
X-Google-Smtp-Source: ABdhPJxsZhI0CdLIY+rzWPN0HYQv81ux+PuPu2AjkvxwV5y7JgLfQU6oiuU1IVzcs8ebcrTDjOTOzG9MGTpliCM3OpXNwjB3HeBm
MIME-Version: 1.0
X-Received: by 2002:a92:d943:: with SMTP id l3mr8182316ilq.37.1626476826637;
 Fri, 16 Jul 2021 16:07:06 -0700 (PDT)
Date:   Fri, 16 Jul 2021 16:07:06 -0700
In-Reply-To: <00000000000055e16405b0fc1a90@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cbbcd05c745a560@google.com>
Subject: Re: [syzbot] WARNING in sta_info_alloc
From:   syzbot <syzbot+45d7c243c006f39dc55a@syzkaller.appspotmail.com>
To:     a@unstable.cc, anand.jain@oracle.com,
        b.a.t.m.a.n@lists.open-mesh.org, catalin.marinas@arm.com,
        clm@fb.com, davem@davemloft.net, dsterba@suse.com,
        johannes@sipsolutions.net, josef@toxicpanda.com, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        will.deacon@arm.com, will@kernel.org, zlim.lnx@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 282ab3ff16120ec670fe3330e85f8ebf13092f21
Author: David Sterba <dsterba@suse.com>
Date:   Mon Oct 14 12:38:33 2019 +0000

    btrfs: reduce compressed_bio members' types

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d5f6f2300000
start commit:   7f75285ca572 Merge tag 'for-5.12/dm-fixes-3' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5591c832f889fd9
dashboard link: https://syzkaller.appspot.com/bug?extid=45d7c243c006f39dc55a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164f385ad00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1427af9ad00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: reduce compressed_bio members' types

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
