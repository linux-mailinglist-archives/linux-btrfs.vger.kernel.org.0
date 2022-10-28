Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51846115D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Oct 2022 17:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJ1P3j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Oct 2022 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJ1P3T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Oct 2022 11:29:19 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B7E1D73D3
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Oct 2022 08:29:19 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id m9-20020a056e021c2900b002fadb905ddcso5305714ilh.18
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Oct 2022 08:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGvPUBMEmwEn0TdkvjUpBwVv8//3CS3caUnadTGNx2c=;
        b=Oa2XubzA6qmoAX+zftQkpanH/anj1JbV/yJSnOAoU3psUaEDidLKc0zQ3xkN6wLVT5
         l9dHTOaV8gDeTbU4O6YHH+9AjGobSPSAeOWNu2GwuGJb+CmOSZVewjhESJL6wlQ0m0tu
         obZaneyRDe6Qal0E+p2sy8M6OLWnYtJL8VcJwhQC0YTWYLee8m/XDgquNsoJrRPY1WCv
         qL9YIfTQc4YIs0TeV8hK7UHDsry36mkuN0jdkTRfzJ99Rn4JLvxzwJZGkJQMDEoaYU42
         iT5X2euF6GOl0wnmCjJZIo17xwYhyR00hbeiuVTmD8n+7/7Uj+rQcWxdewhvKkWo11pg
         5dEA==
X-Gm-Message-State: ACrzQf19JIu4DAuwyJ3U1Kiz+eQPzkY/hgHvtw7IRuoSQ13Ao0+/PRog
        5G0ANMNs/E9Za6xtX5NnsLqDmfN1fJ/Jq1OGOEiGXFAWEc/L
X-Google-Smtp-Source: AMsMyM69hxBCHtw7/2qrDY0fKxAuiNmJIQhPdoRkK902NMT+PIh6vY8xF3mmbVikSsLhk9tBbIz22LRe00jRBK77aiqOumcNXqIW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cf:b0:2f8:e698:51c0 with SMTP id
 s15-20020a056e0218cf00b002f8e69851c0mr31830983ilu.73.1666970958444; Fri, 28
 Oct 2022 08:29:18 -0700 (PDT)
Date:   Fri, 28 Oct 2022 08:29:18 -0700
In-Reply-To: <20221028150501.5159-1-yin31149@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4408a05ec19ebee@google.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/btrfs/block-group.c
patch: **** unexpected end of file in patch



Tested on:

commit:         493ffd66 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121ea041880000

