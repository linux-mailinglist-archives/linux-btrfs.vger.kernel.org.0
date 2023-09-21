Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457897A9E2C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjIUT62 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 15:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjIUT6M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 15:58:12 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F60D3143
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 11:23:34 -0700 (PDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-412136f4706so12416871cf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 11:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320613; x=1695925413;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q3qFJHo3XVshohtuwZiN/FL0niZyPiXxa7GA+BqUwY=;
        b=mxLPVRDwXCHctFOZ40uq5vq43E8P3wJpIQ0283rkGhHnK/n30n/sDhZLY1Y+jKcM3B
         4rTC74XTxI98lN5y8eYSjKa/QMKRq4MJyBwZvGmgGvfDARHJOZ+brNO48FS76gJO4zPE
         tFCx6EdXy+FyV7+0cck/FOuJWqDNMkFrDZ9BEhu+MFaXu/F7tMJIFDPGtUNTwW9VpFLz
         /3K3oj4ahdJAdtcRA5rKe2LCL83uH+BJJQF9W7envSce9pkHtXo3ekFxfko2G/roDvvG
         GXyX7QkME9btDtmrsLsXziELZ15+7HHG1TDEKTt5+IEN2yzC77UufITXgTs2FebyZL1y
         B6TQ==
X-Gm-Message-State: AOJu0Yxcc8ka523LbNalmnkmt04gLEehG94FthBjzEUoqcrlwTZWq+mX
        qUmnUvkcVAV1zh0gBkQ1ohG9DIiSXJAPkH15Sz+6EzCRvYYw
X-Google-Smtp-Source: AGHT+IHHPQ+f83WOGBx5Q3jkh5OIGbhQpryoZz5a7eZICtLdsOv/3A7TNMHxgGgwmTb+a5OxHenITAsJd3MG+L4ZYu+uSSaU8Nmx
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a8b2:b0:1c5:e4a5:6990 with SMTP id
 eb50-20020a056870a8b200b001c5e4a56990mr2450683oab.5.1695320123192; Thu, 21
 Sep 2023 11:15:23 -0700 (PDT)
Date:   Thu, 21 Sep 2023 11:15:23 -0700
In-Reply-To: <000000000000172fc905f8a19ab5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b93c240605e27901@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_commit_transaction (2)
From:   syzbot <syzbot+dafbca0e20fbc5946925@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, kristian@klausen.dk,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has bisected this issue to:

commit 2b9ac22b12a266eb4fec246a07b504dd4983b16b
Author: Kristian Klausen <kristian@klausen.dk>
Date:   Fri Jun 18 11:51:57 2021 +0000

    loop: Fix missing discard support when using LOOP_CONFIGURE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15dfb0f4680000
start commit:   57012c57536f Merge tag 'net-6.5-rc4' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17dfb0f4680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13dfb0f4680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f28dfd7d77a7042
dashboard link: https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173a6716a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111c7c7ea80000

Reported-by: syzbot+dafbca0e20fbc5946925@syzkaller.appspotmail.com
Fixes: 2b9ac22b12a2 ("loop: Fix missing discard support when using LOOP_CONFIGURE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
