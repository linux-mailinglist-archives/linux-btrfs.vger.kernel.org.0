Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DA3676C3D
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Jan 2023 12:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjAVLOZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Jan 2023 06:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjAVLOY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Jan 2023 06:14:24 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31481C31E
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jan 2023 03:14:22 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id 9-20020a056e0220c900b0030f1b0dfa9dso6628057ilq.4
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jan 2023 03:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knvEjaz7f71VMDphq93Ttomb3XiR1RLVfVR0GiG+5yc=;
        b=oHkMgD+fdA9mj26Kd2NSic4GetpQzfXD+3YpE2bVppLOT4U1k6MohlUSJmch2lxcKo
         4hAk8ApAHCh3tGGUJYX0cMWw/7HT23wPKlCf/AOWbsUUzzB4zWxjXYWDrvyebBeql1e5
         R62y5lmm4knmjGQBizAbR+DPNVh6qpwzjuMI9dTZqlvEV52vEpQRJEn81YbNQDhXVuy5
         NL1IRPN8Q3XkF86DEhhsPiTJCWpinjaS5YduLsx0O3BUFrQmlHUUQCBmSs6KESKclsYP
         U+A5ZF7781kx6HQbuPhNKXu2nYzgndVUq8eF/HFm1Qb1klUKKcp0Q/0Tq55rk4YwYqdP
         dISg==
X-Gm-Message-State: AFqh2kqTCUPnfrMbmdgvVxC0eVTaN3G/VZ3fpKrgVJ2cUqD0DSwK9gqT
        B1gybiIG0ugjZ78GxqRAN1Dp8au8ZsUZSo562wB3OHz4SedI
X-Google-Smtp-Source: AMrXdXt6XfxN8kz3zBped8n8r4ixtXs+B2FAnQI2vA4E/ji1IGwbPrta94N1OpQJqC7Z8lQSds9Wh2G+0Tw+vpHVK9m46qL2Pr21
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1090:b0:30d:7fd4:a6dd with SMTP id
 r16-20020a056e02109000b0030d7fd4a6ddmr2610074ilj.20.1674386061807; Sun, 22
 Jan 2023 03:14:21 -0800 (PST)
Date:   Sun, 22 Jan 2023 03:14:21 -0800
In-Reply-To: <00000000000075a52e05ee97ad74@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e58cb05f2d86236@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING: kmalloc bug in btrfs_ioctl_send
From:   syzbot <syzbot+4376a9a073770c173269@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        dsterba@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        w@1wt.eu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has bisected this issue to:

commit 7661809d493b426e979f39ab512e3adf41fbcc69
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jul 14 16:45:49 2021 +0000

    mm: don't allow oversized kvmalloc() calls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f2c851480000
start commit:   f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=100ac851480000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f2c851480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=827916bd156c2ec6
dashboard link: https://syzkaller.appspot.com/bug?extid=4376a9a073770c173269
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1775aed7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cbcbd0480000

Reported-by: syzbot+4376a9a073770c173269@syzkaller.appspotmail.com
Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
