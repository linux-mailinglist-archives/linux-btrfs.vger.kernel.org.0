Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D517689E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 04:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjGaCNb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Jul 2023 22:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGaCNa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Jul 2023 22:13:30 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48DC18B
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jul 2023 19:13:29 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b9d3ce1a56so7875105a34.1
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jul 2023 19:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690769609; x=1691374409;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPkgU757mcAfVErB4JqXmP6kqt1Ainnk7Zov9FfgpnM=;
        b=lcnzy2xDfvCv/QSrWTV576sSkCgamE9OHzdVljteVAqlYSa1v/SeL7WqJmCte2htUH
         0pwCZsIG2rdC1IdekmxnAx9eaj+GIaqrJ45HGLv1vvMkMFiK1Vmvi3eHxnSr8+/aYVsy
         xcME3FgNB351cdC/VyK/Pl/BvdUhCPeuo+DeI0d0DyenkjWtxC0OdNSdk6+owAlEN2qe
         l+oTBijO1f+hQvE2PhvyeOa70HrG2Y2NMWkQBGsy5zaV37ZHfoHQue4vjnE7Eys7bF9R
         7XAAzskm/FOYE/I6LtkbZTeVuZudLNycNZ03wqUo+KKIOHaA36LSp4tF7YZLVBL1JOBT
         Mq9Q==
X-Gm-Message-State: ABy/qLZiytQgq3F8Cjlt6pL2v9Z/lY/OEnrO5HvEbGDtPZGZF7tupPLd
        wsdCqGnKb4VK9+EMj/fT990A6T5FouuT2qegvLY2LOHnwimy
X-Google-Smtp-Source: APBJJlGXOGBA2AgNlWNY31LIsNq0WRqp6IlSCViwbyXiU2fsMGi3dC8fkFp/KA9wRkqtorpwD5/slNt3e/VUr55xOY+neabpk0dh
MIME-Version: 1.0
X-Received: by 2002:a05:6870:76b3:b0:1bb:3cab:49b0 with SMTP id
 dx51-20020a05687076b300b001bb3cab49b0mr10439028oab.6.1690769609114; Sun, 30
 Jul 2023 19:13:29 -0700 (PDT)
Date:   Sun, 30 Jul 2023 19:13:29 -0700
In-Reply-To: <000000000000a3d67705ff730522@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2ca8f0601bef9ca@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
From:   syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, hch@lst.de,
        johannes.thumshirn@wdc.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has bisected this issue to:

commit 85724171b302914bb8999b9df091fd4616a36eb7
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue May 23 08:40:18 2023 +0000

    btrfs: fix the btrfs_get_global_root return value

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12343ac5a80000
start commit:   d192f5382581 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11343ac5a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16343ac5a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
dashboard link: https://syzkaller.appspot.com/bug?extid=ae97a827ae1c3336bbb4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1230cc11a80000

Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Fixes: 85724171b302 ("btrfs: fix the btrfs_get_global_root return value")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
