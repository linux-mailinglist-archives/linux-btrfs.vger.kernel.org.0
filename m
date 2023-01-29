Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9718C67FFE1
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jan 2023 16:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjA2P0V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Jan 2023 10:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjA2P0U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Jan 2023 10:26:20 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE42193F0
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 07:26:18 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id c8-20020a05660221c800b007164907d311so2021757ioc.11
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 07:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cF9L9jLWY8TFRKz3jdp0+sMF5n63XrGkYgD+r/LrUM=;
        b=P9LMaKcTsr5QuBNNr8XepBSpEwVbhD/gbs0f0mRo1KweA4x/NZoWR3k/j2lhQiSv82
         pCXSAuyK+7L6qIeebVbZm+YcYeygYMwjOn4cJ8qIGVzFhuZyuUZGb4AcsZYmGj97O/q+
         lLfx0EtEbcKbWTMbDLufk+qCrKqRzcKlQGF/r7z+yqvn1oOCRedmgJXG61KbUNF/P6pm
         hYTPa4Fn/bnMsauITV/YcCTJ1alUv4F9kjkQYz1fIXdXR10wVM2HSFE0iHJk+lZiQsuN
         5gXI5cQ+o3xMxs/IRGCMaifPTPCqQR4pCT3IqVwQ1ea6m6cXjZ0rUftIKL8EIZgStVHw
         FuJw==
X-Gm-Message-State: AO0yUKUKmxQkAzbw2fhrhLep3v9EvAHKm/qDmyumRDZK7wvSOQ6582ii
        nw+5a4i49f9nD1Lps14dFMdY+xvZYyk/jA9eqIONVXtVK77Q
X-Google-Smtp-Source: AK7set+J97wR6pyTkJQzNgrvEAzGQv2Coaf5oP9nuxQEXIut8CfO8ZG6G1elUbRDOv3uUOL8oT6D2A3Lpa4yxBs0atsxKTWirtU4
MIME-Version: 1.0
X-Received: by 2002:a92:8e4d:0:b0:310:c52c:81ff with SMTP id
 k13-20020a928e4d000000b00310c52c81ffmr1143173ilh.50.1675005977489; Sun, 29
 Jan 2023 07:26:17 -0800 (PST)
Date:   Sun, 29 Jan 2023 07:26:17 -0800
In-Reply-To: <0000000000008f0ed405ed71ef58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048f87b05f368b832@google.com>
Subject: Re: [syzbot] possible deadlock in btrfs_dirty_inode
From:   syzbot <syzbot+37edf86c9b60581e523f@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10cf123e480000
start commit:   77c51ba552a1 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f9416d398342c83
dashboard link: https://syzkaller.appspot.com/bug?extid=37edf86c9b60581e523f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148fcd31880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167bfb31880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: free btrfs_path before copying root refs to userspace

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
