Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1BD76B972
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 18:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjHAQIi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 12:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjHAQIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 12:08:34 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FADA1FFD
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 09:08:33 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-39cdf9f9d10so8388942b6e.3
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Aug 2023 09:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690906112; x=1691510912;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqSDbqh+AqXAOmtaKKmTpkj09he/+2Nk5RSO5m5curM=;
        b=BdzSwbuIqEtf6jLRMMwFEX0+gLCrfio71hO7YiY/hcyZrwMy4+co0Jviso8LZ0tuxI
         RSDsLI4fLFnYbv4umiiHthn/G9YIvcoqr/53jGUJkyOnlvZisNXUJtaiZ63csHEe2vIq
         ewh2ouWUdzSfdyxKNw8r7UtzywuzGemNuU4KWknDArpc77P0USX5lcwXZg/FlFdNzPgj
         w9o481CiOaDRN8QlamKLYHtyOIZgOYnuCbRvJEN3bspkvy7Bm4qoDRh2JaRh6+qmgWJt
         MdT2h32cAcnVTG01mTvsFyGfGISHLh2uHauL5EJgZ/B6mzgZlRSAQcUTzqj+a3cKTRKu
         E9CQ==
X-Gm-Message-State: ABy/qLYjt2tSqHNZg0IPWiGbgAOdygkGwaArJjyfBxo9nsemX1S0vPuM
        V6aVhXXYJiuciMTP+wxc5awJCuqSbw2YBFvwh5isaoUkcyIM
X-Google-Smtp-Source: APBJJlHDYv3Bai1IVXl7MsYcw/fXODejsx+YKiAwPu8CG7DqcwkPQ9I6nsiOykSwXdl4QmplpaP/OJUpnim+JcxwxIsC7/ZB+w4m
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bc4:b0:3a7:3b45:74da with SMTP id
 o4-20020a0568080bc400b003a73b4574damr7943965oik.1.1690906111907; Tue, 01 Aug
 2023 09:08:31 -0700 (PDT)
Date:   Tue, 01 Aug 2023 09:08:31 -0700
In-Reply-To: <000000000000fd151d05ece59b42@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000261e660601dec2c2@google.com>
Subject: Re: [syzbot] [btrfs?] possible deadlock in btrfs_search_slot
From:   syzbot <syzbot+c06034aecf9f5eab1ac1@syzkaller.appspotmail.com>
To:     anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        hdanton@sina.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13015709a80000
start commit:   eb7081409f94 Linux 6.1-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=c06034aecf9f5eab1ac1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124fc309880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126dfde5880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: free btrfs_path before copying root refs to userspace

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
