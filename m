Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4653967627C
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jan 2023 01:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjAUAg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 19:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjAUAg0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 19:36:26 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F44459D4
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 16:36:25 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id k1-20020a6b3c01000000b006f744aee560so3782279iob.2
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 16:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgX3OLdyl63a85Teu2ThGDnS3O9jXoEr2Eos41v+st8=;
        b=sp1T3+txRMGPhKA9gjZBHSG7afp59ayiMLbpskBInWUvZF11uzv45y9MPcVQcciLXd
         a6TEHrLVgu4GAeDGe1xPOVwFVxT2wjCyH929m0qGP2fo8lPpgBL0WZNMgzNw7lLM3pGA
         qVbilztXB2XLjAU02B9VDbhm5aPsWShnCbsqfmrD7jWY2kjtIwLu1Zcvad3IlI8mdUu+
         gyLJtEk446cI5aA+kDPvWH5XBv3S+Eo6fRrpCccdadrctUwndozBS1Ih5G80nHapocxN
         feSErmxMXpD1i2uaYfS/g45OCfO8ii1COoePyDIn6jeq1h/YS5ogUf6Sq9mpcpo4V0Op
         nJ4w==
X-Gm-Message-State: AFqh2kpbhAgKJYsIMnMu2BnTi7kRHYhBg91Vxblf6wSplrIvnpNwl0tG
        1Tm6Ld0QmyaUlLXOQYJ2QxbKZXUndOrctGBkv5qHpP5GMaCy
X-Google-Smtp-Source: AMrXdXutvEXiengHA3DvVHKzijsZxSuGZwfw0rku6p+wlNUDnMgyL92bIuD6EeDsBmkNphjVMLrdRTrXXCoNF4iL+cUOmbY7n8P/
MIME-Version: 1.0
X-Received: by 2002:a5d:928d:0:b0:6ed:9ed6:6bab with SMTP id
 s13-20020a5d928d000000b006ed9ed66babmr1096038iom.54.1674261384909; Fri, 20
 Jan 2023 16:36:24 -0800 (PST)
Date:   Fri, 20 Jan 2023 16:36:24 -0800
In-Reply-To: <00000000000080bb5c05ebe34a4d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bde1e05f2bb5be8@google.com>
Subject: Re: [syzbot] WARNING in cow_file_range_inline
From:   syzbot <syzbot+858534c396b0cdd291d2@syzkaller.appspotmail.com>
To:     Johannes.Thumshirn@wdc.com, clm@fb.com, dsterba@suse.com,
        dsterba@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@fb.com,
        sweettea-kernel@dorminy.me, syzkaller-bugs@googlegroups.com
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

syzbot suspects this issue was fixed by commit:

commit 8bb808c6ad91ec3d332f072ce8f8aa4b16e307e0
Author: David Sterba <dsterba@suse.com>
Date:   Thu Nov 3 13:39:01 2022 +0000

    btrfs: don't print stack trace when transaction is aborted due to ENOMEM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15521666480000
start commit:   337a0a0b63f1 Merge tag 'net-6.1-rc3-1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=858534c396b0cdd291d2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e5a422880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16387a16880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
