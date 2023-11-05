Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20C47E12A5
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Nov 2023 09:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjKEIkI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Nov 2023 03:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjKEIkH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Nov 2023 03:40:07 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69D3DB
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Nov 2023 01:40:04 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b2e44c8664so5289653b6e.3
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Nov 2023 01:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699173604; x=1699778404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubi1y/nFwBKOxlg1T1iV5JNUkHex1InrNIEt964xeT4=;
        b=ZuaI6KM5U8JzlsL4ACRClLFWy8J5PCW0+kUb76GXPnqJm/2pYMH9pOMkJqlgoxxtQH
         FqewNC27SB6m6VsHmTjdBQvYdE09x/kKCleMWJz6HNtk0zxjrSZHgO/rGmC45z2etEjt
         VkXdSj40IFvWF85be+Aw1MR1YnxWhN1ZNMldi1nMkVNKtDm/mElXG3wn8CxmrV2m97vU
         TZpdIF3rFuIFFWrIz/i2nVmbnPzLJFf35mldz0dBeIjLWI+dEwkwksULh7+Sg7KswRDD
         xQmz7X0fbUmsu0KGEvrKxZjaO8cIJFMVo7DPM6n2j7Ptwy0H+SkimCg/mN6kcvvsc6xZ
         qUFw==
X-Gm-Message-State: AOJu0Yx0NjwkI4b+3Ez5puk7kIw/Q7LhPFgmQ+KbgVkqXgp6vLQ9Fbwi
        XDbx+HGg/QadfQNM4e9ZdSz3EmKXgMMpVGGgI+TkyKBMs/o0
X-Google-Smtp-Source: AGHT+IGqts477963RT4MDh/f/hOQ8Is3TL1ul5XZfsXe70UO+SdEY8Tj3eLHmIToYNzq6fUjwsfSMcQJugLkZMJ9xfcI14GwIpl/
MIME-Version: 1.0
X-Received: by 2002:a54:470b:0:b0:3b2:e214:9118 with SMTP id
 k11-20020a54470b000000b003b2e2149118mr8543741oik.4.1699173603875; Sun, 05 Nov
 2023 01:40:03 -0700 (PDT)
Date:   Sun, 05 Nov 2023 01:40:03 -0700
In-Reply-To: <000000000000a6429e0609331930@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001222c4060963af3a@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_qgroup_account_extent
From:   syzbot <syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has bisected this issue to:

commit dce28769a33a95425b007f00842d6e12ffa28f83
Author: Qu Wenruo <wqu@suse.com>
Date:   Sat Sep 2 00:13:57 2023 +0000

    btrfs: qgroup: use qgroup_iterator_nested to in qgroup_update_refcnt()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f01717680000
start commit:   90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16f01717680000
console output: https://syzkaller.appspot.com/x/log.txt?x=12f01717680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4cc8c922092464e7
dashboard link: https://syzkaller.appspot.com/bug?extid=e0b615318f8fcfc01ceb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cae708e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1354647b680000

Reported-by: syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com
Fixes: dce28769a33a ("btrfs: qgroup: use qgroup_iterator_nested to in qgroup_update_refcnt()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
