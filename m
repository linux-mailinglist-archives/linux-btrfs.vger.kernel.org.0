Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40781611779
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Oct 2022 18:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJ1QZV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Oct 2022 12:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJ1QZT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Oct 2022 12:25:19 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F48D72EEA
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Oct 2022 09:25:19 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i14-20020a056e021d0e00b0030028180f5bso5423845ila.5
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Oct 2022 09:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0M2eNGrrFy1lqBx+Mbj7u6/ivikymdyJDCkEXUlOf4=;
        b=ZJJy0y21dI+A+QYfCC2wY+b/JxwLVRfX2ml4rw1fkAslBx1oyD39Vj6/A7iMm/FjoF
         yfUFHg8ZvjeUMWYsBzIV/wAB779F1QqfkVu9DuHTdwaSZIu0d/cwyjMs0B5634r6zvNa
         lG+6F4ZHotCuA/27hw2b+bjAdH9XXj9MMJ+sFHB+JVExxnw4BjqkRAcsEnX/QTHqC8ha
         gipH6FDykBBsNr7nr/Ir+PQv2G+pgacNyOrHSUtxfmSri6e1VJTxxZ0sBDUvGS0+lnDc
         t7iIWa7XhseFE3+x3j2PBeAImUUU5qOlNDtUTX4JEUqCK6wl7ou/AE01Yh8sPflz/h1e
         Y2vw==
X-Gm-Message-State: ACrzQf3imDv2FZ1fxtXJNHYHGQy4rGNC4YbyOdpgxYVfjioBToRYLO6c
        ahvJ4IjMZoUjt61GoiMi7+IxnH0sR4YuwXQuGlRVyuiF3Hu0
X-Google-Smtp-Source: AMsMyM4+dAFAySyvCpcZ0y/ApLfH48HExaDis7YotuSsW4mMSrDjl7EZangPlAlQPtKflrLKT035o6bJhkEHpeYNzXQn4FKwZnPt
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bee:b0:2fc:793c:aa5c with SMTP id
 y14-20020a056e021bee00b002fc793caa5cmr127203ilv.126.1666974318783; Fri, 28
 Oct 2022 09:25:18 -0700 (PDT)
Date:   Fri, 28 Oct 2022 09:25:18 -0700
In-Reply-To: <CAKrof1NyNjozshnGPgxKHuBoKgnd79tC50M44UL_DfeVBad+Kw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ef38d05ec1ab476@google.com>
Subject: Re: [syzbot] WARNING in btrfs_block_rsv_release
From:   syzbot <syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com>
To:     18801353760@163.com, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        yin31149@gmail.com
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

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com

Tested on:

commit:         493ffd66 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17bdd716880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e315ce880000

Note: testing is done by a robot and is best-effort only.
