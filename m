Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AA47B44C4
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Oct 2023 02:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjJAADi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Sep 2023 20:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjJAADh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Sep 2023 20:03:37 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA309D3
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Sep 2023 17:03:33 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1dd691b1037so16807487fac.3
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Sep 2023 17:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696118613; x=1696723413;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7RyblSS0tqaFb3Y91Y88UCjMBkJmAdJj2b4I9Ezm1U=;
        b=Qh9qs9Onhr4YNGE1t0knA+MNbXZTQscUU2tYQBTGFavbDNFOtVK02IctqoPBfZQ52B
         EPQTPXo6UaCBnGMTlvCHqA4BObIaJHuQzhRTlo7XH52yVZkkV9aKHkZscc6c8zJSveU1
         dBhRxsxlf3K1m6ct1f72+ch6XQmPGF0h3Y0Rm0NWcC1WS/RJ3G9nDzg3w6ZpHDfTSEax
         EmKVIV8wzOqaTtgGg9uMnwIf8VA/ifQisfLsSIhYp3+FDITOk5/56+rugAZUOYu1l7bW
         KtaTrrLxBRjrBjbgrlhCzIIkdrvtsGBg13/glHf9IxOvqT9m9t88PiwKOTAc6qM/rYmP
         tQRA==
X-Gm-Message-State: AOJu0YwALOdGKG9zHxw57QgYXB8tltNOtapl2OYwr2EjfFqzUlN549u3
        mKIJbN0DfS45VC6y24EP+8cVWK/ltdUSU6dkgsPgUocPDfDP
X-Google-Smtp-Source: AGHT+IFj/3ix5064W+YXk0/tjitl6ix4wB9gxsdZRwQLoHNQPwV2bbll2Lr00GU38AGrPoM78qWOD/El8ZBU/5ClBn3Tks8tTVQf
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a886:b0:1d1:3ff8:9f80 with SMTP id
 eb6-20020a056870a88600b001d13ff89f80mr3336962oab.8.1696118613280; Sat, 30 Sep
 2023 17:03:33 -0700 (PDT)
Date:   Sat, 30 Sep 2023 17:03:33 -0700
In-Reply-To: <000000000000672c810601db3e84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000710b5c06069c6302@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_cancel_balance
From:   syzbot <syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com>
To:     clm@fb.com, code@siddh.me, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiaoshoukui@gmail.com, xiaoshoukui@ruijie.com.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 29eefa6d0d07e185f7bfe9576f91e6dba98189c2
Author: xiaoshoukui <xiaoshoukui@gmail.com>
Date:   Tue Aug 15 06:55:59 2023 +0000

    btrfs: fix BUG_ON condition in btrfs_cancel_balance

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170f5bae680000
start commit:   5d0c230f1de8 Linux 6.5-rc4
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=d6443e1f040e8d616e7b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1167e711a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a90161a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: fix BUG_ON condition in btrfs_cancel_balance

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
