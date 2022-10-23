Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71862609460
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Oct 2022 17:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiJWP1R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Oct 2022 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiJWP1Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Oct 2022 11:27:16 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5879A65821
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 08:27:14 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id q18so4061264ils.12
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQx//nIMTXIuGES5wdU306SDyqo/9GYHWGhMmpKB5Ag=;
        b=GBbLnRZzhnxvSYWieV8C1FI77iyK1UcdREQHbBSeAUjJQNPlmqJzdG+19MafjuJzU8
         YYE1JinvuJLhuF1J429xzZpsza8M3Q6u/DF2/+61NBqkeYu5dh48MlqITZkZooYuXwkc
         ThA6sYT1xqy94B5aPwbiEUCuQcg+9piKlUDP7rfGD8ilVIQw55hqJCoLgBnAMCNC6BeL
         oy1LCLgh1GPFLpxd/fQ3MJJtq5FQhX5+S7V8clusXm3Fj9pin1kQ3+l33KNk8tI/zHsW
         oZ/fSsnpO4JHvNkDE110AY101SQ4Ox/zXHhPsudYClkO4/nYnNFD0s19ykg5lgtIemCb
         vaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQx//nIMTXIuGES5wdU306SDyqo/9GYHWGhMmpKB5Ag=;
        b=6jA0HkBDgu0NYny2Sf7xBnQb+9WQT2Zftx+0WqjbgTDfkLpZJEuzJhxGwWnra0USYa
         rsrznp8tSuV1jHvnZjQK4SeLuJetZib6RD1gSyzyJeg8hNJTimZUtOAkik/2i0EBMfza
         bOo7kL9W4nmY0kovkAtBKFUICzL8wqVPcP3d5AD8OFBGtTaPoE9LLYomfrl0L4KX/qeY
         x6uLA2BD95ESabVwk/4qCt7nd7iGRUmEPZ114xKQ39YK4P9zzzutvuHzWJLDr6o9glGk
         ro3dh2MhCLCa6DSeZX+8pVXQHRsmLQjk2Xs4QNOP+lw95781FxuWT1fIpFJozzP9kOm+
         XMFw==
X-Gm-Message-State: ACrzQf2F5A0peNtLLnaFy5wcdF3DTD93nfAhS7w9qMjc/KJysGXT1/E0
        kTnJgAvQ9JUbB/kp3V5STGoyg78VCoOeEH4IiAI=
X-Google-Smtp-Source: AMsMyM68dtRkc5wWzk9JmhvqroUfzJVS6bvxYg2SDwnku7ltWImg7Zt8qovHUGRF1/q5nx9qrpoJNJVIsDIXuabOUQ4=
X-Received: by 2002:a05:6e02:1521:b0:2fa:4306:19f7 with SMTP id
 i1-20020a056e02152100b002fa430619f7mr18921405ilu.104.1666538833535; Sun, 23
 Oct 2022 08:27:13 -0700 (PDT)
MIME-Version: 1.0
Sender: rachidbagagnan@gmail.com
Received: by 2002:a05:6638:238f:b0:363:dbd6:1d04 with HTTP; Sun, 23 Oct 2022
 08:27:13 -0700 (PDT)
From:   H mimi m <mimih6474@gmail.com>
Date:   Sun, 23 Oct 2022 16:27:13 +0100
X-Google-Sender-Auth: F0symPBRrdoj52cW0x9hUFCGI-o
Message-ID: <CAKryBMctODCpX+=oNYp6qf8iyhnvkvyPSVE3_GGcDG48PCrk1A@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

i am Mrs Mimi Hassan Abdul Muhammad, and i was diagnosed with  cancer
about 2 years ago,before i go for my surgery i  have to do this by helping the
Less-privileged, with this fund so If you are interested to use the
sum of US17.3Million that is in  a Finance house) in  OUAGADOUGOU
BURKINA FASO to help them, kindly get back to me for more information.
Warm Regards,
Mrs Mimi Hassan Abdul Muhammad
