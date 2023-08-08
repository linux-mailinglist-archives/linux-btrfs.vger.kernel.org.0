Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC89C7737B4
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Aug 2023 05:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjHHD1T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 23:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjHHD0n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 23:26:43 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479441BF3
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Aug 2023 20:24:37 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a78a2ebe6dso5411977b6e.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Aug 2023 20:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691465076; x=1692069876;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2t0653jgaoKi74sFUq52vSh+FHiO/WGGg3QCdJix3M=;
        b=E5HQskKcczZNpBzSO04Lo4gjGQpSRsuhhmicexEfSuN5FaR+diC/Uy64imq0ebSgHV
         UaTB4Nw5gvpoLrMaxYWzxf3ub6u4R0SencZMXuqWZykt+AY6FiaGtsznBHwdpYdTE5z2
         BjriM9Yt84/SWtTnVF2faqjopJrCp24gGNE6Irf8CrjOr3enAn9W2leOIVirEdWZsCiX
         Kj7z/huGrsxynpM0M7etEFUZddg5cm31D/dUsfowMc/HvOnIZRw8B9JeiHzadZJb62RU
         jgd4SCsvgXJd4sTyxKet1pNXvgvLh9ebB41+Z238pxU+eF+mK9/ouzr3GBE4O9XPPAZi
         N9Dg==
X-Gm-Message-State: AOJu0YwhamUqAXmKk2OBVJGBgla65VtxpMEJynsTJ+sVvYPf4vc7oE69
        CUVHGd2vknt4dOwTCwzqn6XKIMjU7Cv20k82u3ENsDE40B9Y
X-Google-Smtp-Source: AGHT+IEdBx25FpCRFr7kwRfEIsTWGepOXKy+8cWomP3KEck/KxtG1Gi2xvFNSte1rAaKhA76kQLKa2VS+xd5mbRIv1R4n98gOq0Y
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2190:b0:3a4:87eb:da2c with SMTP id
 be16-20020a056808219000b003a487ebda2cmr20263284oib.0.1691465076523; Mon, 07
 Aug 2023 20:24:36 -0700 (PDT)
Date:   Mon, 07 Aug 2023 20:24:36 -0700
In-Reply-To: <0000000000007921d606025b6ad6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000094846060260e710@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_open_devices
From:   syzbot <syzbot+26860029a4d562566231@syzkaller.appspotmail.com>
To:     brauner@kernel.org, clm@fb.com, dsterba@suse.com, hch@lst.de,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot has bisected this issue to:

commit 066d64b26a21a5b5c500a30f27f3e4b1959aac9e
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Aug 2 15:41:23 2023 +0000

    btrfs: open block devices after superblock creation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15493371a80000
start commit:   f7dc24b34138 Add linux-next specific files for 20230807
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17493371a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=13493371a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7847c9dca13d6c5
dashboard link: https://syzkaller.appspot.com/bug?extid=26860029a4d562566231
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179704c9a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17868ba9a80000

Reported-by: syzbot+26860029a4d562566231@syzkaller.appspotmail.com
Fixes: 066d64b26a21 ("btrfs: open block devices after superblock creation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
