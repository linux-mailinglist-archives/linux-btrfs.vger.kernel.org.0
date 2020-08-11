Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E2F241556
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 05:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgHKDfO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 23:35:14 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40229 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgHKDfJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 23:35:09 -0400
Received: by mail-io1-f71.google.com with SMTP id t22so8745118iob.7
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 20:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0XXF4gP00AKnsVQiDFXbJzMYIOYWHxHdd4RVsRPAbhc=;
        b=NiQkIOlO3CrI5lU1iXLn6BpW1rbvWiIb3HLaz7ypw3+WVElLAm+s6hlMb7389rtaZk
         ++GcGnR6Qvg/xArvt/dvLdaDgzsV7kPYWpm+o9vDrncPY9ozTBh9SsL90XPxMhcxiKcs
         5/dIBxN437v/I1vr62hdhLg7W/uK2pIUqaBUgnULpLqYmKemWU++leXE9aAbzb8s7kus
         TeeowxIK2DVjkpFUAUkLMoNLXDNKVlOQMrqZ8eQZkc0slfcTHdW/84qNlVCSacQU20wx
         x9dsfgw+nyU4M2sEtWCmIZcQLPyi6IGj7pr/9BUI9uVmOC1hLHkpOVRC3eMZ2iH7Dsaw
         LFYA==
X-Gm-Message-State: AOAM530+7qxXA5xuAIT/Gl8EkSSOVo2monhc/wqB0N2PMQN01hhPUcvv
        gWLxqAqytm+0WpxNOrKe1HGROtrKbVFjoKgmCrW2vQufHDUx
X-Google-Smtp-Source: ABdhPJxgP7ejVjnfsazNH0Tqy82Cxwho0b25shTclrrEX2JEZZQVzsMpsyfvz791kmnbkiw1QrmUlfEf4tjZSNi1+1P0jsQ/cPE1
MIME-Version: 1.0
X-Received: by 2002:a6b:5502:: with SMTP id j2mr20825119iob.204.1597116908036;
 Mon, 10 Aug 2020 20:35:08 -0700 (PDT)
Date:   Mon, 10 Aug 2020 20:35:08 -0700
In-Reply-To: <000000000000734f2505ac0f2426@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7ec6f05ac91c11d@google.com>
Subject: Re: KASAN: use-after-free Write in hci_conn_del
From:   syzbot <syzbot+7b1677fecb5976b0a099@syzkaller.appspotmail.com>
To:     clm@fb.com, davem@davemloft.net, dsterba@suse.com,
        johan.hedberg@gmail.com, josef@toxicpanda.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        nborisov@suse.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has bisected this issue to:

commit 6a3c7f5c87854e948c3c234e5f5e745c7c553722
Author: Nikolay Borisov <nborisov@suse.com>
Date:   Thu May 28 08:05:13 2020 +0000

    btrfs: don't balance btree inode pages from buffered write path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f973c2900000
start commit:   5631c5e0 Merge tag 'xfs-5.9-merge-7' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16f973c2900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12f973c2900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afba7c06f91e56eb
dashboard link: https://syzkaller.appspot.com/bug?extid=7b1677fecb5976b0a099
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155d73fa900000

Reported-by: syzbot+7b1677fecb5976b0a099@syzkaller.appspotmail.com
Fixes: 6a3c7f5c8785 ("btrfs: don't balance btree inode pages from buffered write path")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
