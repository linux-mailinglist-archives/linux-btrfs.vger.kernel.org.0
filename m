Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93679545CE7
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 09:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346596AbiFJHKd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345532AbiFJHKW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 03:10:22 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F133238BF
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 00:10:19 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id j18-20020a056e02219200b002d3aff22b4cso19122126ila.9
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 00:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1s4eQtwNPIFPmijyqkQxRHOcZ3UNMSKoKcH4SMx+dwU=;
        b=wwqG4EbSl5KhpzqganGCc5hYXphi7eznr1T1VLxf/YbcGn7fze2rO1722+jj7Os/FL
         gz/ez9Fn5GSTEqCxn/H7WYpg26EjFXHtJxy192YffFXL0zvWdnYuDmdfrw13pGilRfL4
         KQJzY9NXKj+0GQHTR0o1E49K30uKdbD9FxtpN4EVPggeDfmZxZTkjvskgM8jgu0hE2vB
         EH7FbwL7/n7fq0gJAGsn1BJzXzLmtEYYatl+ASNgqgpxw0JJ5aF4C4phao1WNCMI4W6X
         bNWvVYDZiRqmzje3FPQH650U74tTsVDulXgeOc6zyqPR17ruqxx/qh4yHp4nbz2BJW0b
         wk7Q==
X-Gm-Message-State: AOAM532qNs7ufIvVR8xmBTTpE119Ru9vRMUfrkVyE07qGAtEZ3uFSG6N
        dWZa8p2JCPkC04A2Pq+yv/tX8zqLJzx3OuM8ucMs8TQCine4
X-Google-Smtp-Source: ABdhPJy5bafZuLIonGH4GUOrP3ruXh8F7X7gdTY46sCg3pH3RDVeUt5B+QRwB61fcauuyJ3F6YRJ4lORT1xiAPOmM/UOYzheuU2c
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3892:b0:331:e9b0:80f2 with SMTP id
 b18-20020a056638389200b00331e9b080f2mr6982887jav.133.1654845019061; Fri, 10
 Jun 2022 00:10:19 -0700 (PDT)
Date:   Fri, 10 Jun 2022 00:10:19 -0700
In-Reply-To: <0000000000003ce9d105e0db53c8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085068105e112a117@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in copy_page_from_iter_atomic (2)
From:   syzbot <syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        hch@lst.de, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
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

commit 4cd4aed63125ccd4efc35162627827491c2a7be7
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri May 27 08:43:20 2022 +0000

    btrfs: fold repair_io_failure into btrfs_repair_eb_io_failure

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1332525ff00000
start commit:   ff539ac73ea5 Add linux-next specific files for 20220609
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10b2525ff00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1732525ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5002042f00a8bce
dashboard link: https://syzkaller.appspot.com/bug?extid=d2dd123304b4ae59f1bd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d6d7cff00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1113b2bff00000

Reported-by: syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com
Fixes: 4cd4aed63125 ("btrfs: fold repair_io_failure into btrfs_repair_eb_io_failure")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
