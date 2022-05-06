Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C85851E0B6
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 May 2022 23:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245426AbiEFVKR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 May 2022 17:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444198AbiEFVKP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 May 2022 17:10:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C136EC6A
        for <linux-btrfs@vger.kernel.org>; Fri,  6 May 2022 14:06:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o69so8043890pjo.3
        for <linux-btrfs@vger.kernel.org>; Fri, 06 May 2022 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=M7yusSoYt9af88U4kPfUWufRIREWhTzK2DgeC5eujU8MQEfaEs4UUrh/fFLuytW9oi
         rCISitp9n49tGRTjeJx8iGJyFte4qjiDuMtDNtr+xw4248zGGIFHmPB959KsFrScJhMO
         dlifxseF85/uZHX2PfQFapxngXQ7Un7ki9gfTb2Xq8De9r/ieZ8Tc2SPKRunyZaY1zi0
         Vks9CPMXZ/aa0r9wl7zXBf7JGco5mmaoB/DP8m++5ntrEWL6dSWKgqggpBombfhckPfv
         J8p03/gMwHYQMrso4PI9K702HAzEsAovcns2u+2lScdg+ycIaZZ41+AM1f+1b4u9bMQD
         W/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=WUO1SwTO52vNUy6kkDY8ngjX7phDxYg+PLXGrViAFsdtHy2a41U2OBUD0KPvEerzTy
         9r4bR4NDmWIRqo4N3fNaWCjGv8Fs+pEyK+LacHA7txKeHbuKTt4N9vSNjiqFb2iDgo7W
         /fV1HCVR7sFUnbPEhMXuy6Lu1Fk7cSbBH8KNBycQvQb7Igmc4XOYV6wNKuXNbNphSO0U
         vqBd1UywJZ7+em0wQKExr/RL40pwe/WDOBKZlXh+0pcurL+t0L+64qMVe+cHBgJItRWQ
         MehftMPGrJ+Z1+UtFeCzIgnhw9b4uRxTO4AYiBqqVGhxn4ntOfwJdCEHiMuxgoHiTVN3
         m1aw==
X-Gm-Message-State: AOAM530hiYRUp1y2596j+oUe8Y13U4xiADIVsan8AtmA5m8NQKotmOVv
        +niHwu64eDjaZbuSn/rz02J6LkHLnkbdOs3pTw==
X-Google-Smtp-Source: ABdhPJxuCmPeqiBx6ZqsmPkyUIRLmOJwpybigdwPr3VRYSnRUwrwV87b4MhBepbE0YEslSnz73FFLaj5qIGcEI1pPPo=
X-Received: by 2002:a17:902:edd1:b0:158:8318:b51e with SMTP id
 q17-20020a170902edd100b001588318b51emr5647226plk.89.1651871190156; Fri, 06
 May 2022 14:06:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:9906:0:b0:4ba:807b:b8f3 with HTTP; Fri, 6 May 2022
 14:06:29 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
In-Reply-To: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
References: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
From:   Warren Buffett <guidayema@gmail.com>
Date:   Fri, 6 May 2022 21:06:29 +0000
Message-ID: <CAD_xG_od-sCCkXTsvpy6Axgd1QPuypw8vrgyMpZ3bqxH3n2QNw@mail.gmail.com>
Subject: Fwd: My name is Warren Buffett, an American businessman.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1044 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4981]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [guidayema[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you.

Mr. Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
