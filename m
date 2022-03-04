Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4144F4CD405
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 13:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiCDMJ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 07:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiCDMJz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 07:09:55 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597235620B
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 04:09:08 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id r16-20020a92ac10000000b002c1ec9fa8edso5367378ilh.23
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Mar 2022 04:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZLQ+l6U3cC3xcyZ26dmva83Rjla9btl+5WyQj7ZwMUQ=;
        b=ROj1kf2jrgJv60TczeJzhcLLT9yjdPTbZRoLFGVuKbrfB1i51vzUUJVOxnOx08rWxI
         qaR21dD/z3jL70oEkwME7+YU+/iEu8dUrMIAoQTFRE9cHkYW7d8cFifSDXL2Oo7SLjfn
         gL+6zSup032m50RhzHGlsuZC32gd6M0v8Ykq14GMHyYSb+rWSbWWoxCu6pFCYpmskyKh
         py8bRwii2bQOnPTinsPseMrpTdt8fHkAhxl1nO2tjS7ECorPC4KnRmPnZw3gc/tGok6L
         Vi4dlUY14dvnPzS0xU0D5C6iSL7ekM3sUzo5tPUIBpfTCumvUQe2pa+7oSfwxnJkJgih
         GfNg==
X-Gm-Message-State: AOAM533THVFLhyld8vWkmDiFY3x0/6114GmyeiF44O9wnxS6tT/KrsAV
        kxNXv6NQ8/ya3YKeOLE/EDwKuK7+I0riEiWsSWApx0ItPOjQ
X-Google-Smtp-Source: ABdhPJzTtUgWNdrJB42fkiOFuPQZ9wPjXcRLvuJiYwlAZuwlxR2NYIaEMoOGsQAnk3FD4ovrLTnL00mlm28BFC5D8h0pBTHV1nNt
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:2c2:e41d:f72b with SMTP id
 n7-20020a056e02148700b002c2e41df72bmr23414746ilk.61.1646395747743; Fri, 04
 Mar 2022 04:09:07 -0800 (PST)
Date:   Fri, 04 Mar 2022 04:09:07 -0800
In-Reply-To: <20220304114907.2733-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b43dde05d96361a0@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in btrfs_scan_one_device (2)
From:   syzbot <syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com>
To:     anand.jain@oracle.com, dsterba@suse.com, hdanton@sina.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com

Tested on:

commit:         2293be58 Merge tag 'trace-v5.17-rc4' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f28851401b410e5
dashboard link: https://syzkaller.appspot.com/bug?extid=82650a4e0ed38f218363
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1723b521700000

Note: testing is done by a robot and is best-effort only.
