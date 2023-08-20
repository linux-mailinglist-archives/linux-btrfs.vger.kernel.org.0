Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491C3781ED6
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Aug 2023 18:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjHTQfp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Aug 2023 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjHTQfp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Aug 2023 12:35:45 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24677171C
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Aug 2023 09:31:50 -0700 (PDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-26f3fce5b45so1052155a91.3
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Aug 2023 09:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692549109; x=1693153909;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zs/80MywMGN5nz//xF6VCFq/BEhESsIQ+1ZAkPDALbk=;
        b=AfY0tYKR1Otv7CfP9gYJb9YPFry/1DsLhuaBmsRazcUYgNtibmB9rU5q2M8RYnXS+H
         XrLmv042zxXZBp5IaMcW5RK+6FbMB3HNghvEId0dQgV+gLwC5cxT5N9IB2mSt+vb+cGv
         9SK9XQBRpDhYwEpm48doa8+VUvZPaXRwEiTQ6g38Uplb2jNHnbgYAyOHkbqXxrDpAD6y
         G/X/05vx+9ThuZTzZei9MToGAskOK+6kwpkKPxjMZa3IOBnHv40Ddxmo1ptxLstlyjgR
         NEz/e4YWqnZw2G2b1DrwiZTedg/MwGOQ4+fdTRIqbZdCZncUGwnZlgTG3SEAcMQ/Vmt1
         a5Ag==
X-Gm-Message-State: AOJu0Yw0ihgsp6hV/KJoa4UZ9JGb/Ug1MdgEo72yMwnm5hno3vWSyTQ2
        BvKyLLbGs5ztNFAx8auF+p++zmlsVlofw8eKeUv92VaeRnpG
X-Google-Smtp-Source: AGHT+IErhqdhvHhVckGfIW/XLXNm4JqtQuA565sNNBhC+CqBhOhSA7xFnKkvkT/G/qpRMs4iUai8h3DEsavT5Ko3eLEIRZY3rxjo
MIME-Version: 1.0
X-Received: by 2002:a17:903:189:b0:1bb:cf58:532f with SMTP id
 z9-20020a170903018900b001bbcf58532fmr1899889plg.0.1692549109491; Sun, 20 Aug
 2023 09:31:49 -0700 (PDT)
Date:   Sun, 20 Aug 2023 09:31:49 -0700
In-Reply-To: <20230820163131.205263-1-code@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006faceb06035d4c37@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_cancel_balance
From:   syzbot <syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com>
To:     code@siddh.me
Cc:     code@siddh.me, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Cannot reproduce with the repro locally, check on upstream again.
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Your commands are accepted, but please keep syzkaller-bugs@googlegroups.com mailing list in CC next time. It serves as a history of what happened with each bug report. Thank you.

>
