Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF1F5BF373
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 04:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIUC3t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 20 Sep 2022 22:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIUC3r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 22:29:47 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187BFDF82
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 19:29:45 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 982AC3C1349
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 02:29:44 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id CBF2C3C146F
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 02:29:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663727384; a=rsa-sha256;
        cv=none;
        b=LzLmG67Jt/IuGzdUfBWEX7ZbD7dTeHnItWkaTtxzgbFi+yOWysw2duZhC9Ac7wAWe7fnKT
        uCEOZN1Zlckj2Le9PNddbpC+HJKwos/hwKRHgvwM7jy5JM3w/AFOT+lBYw9Vr95VtmgffR
        A7L/BtPS7pHM9X0uhXmJe+6nAVaufErUlMheEG2Q5dKN0c46TEIBQmkOw6Kzfy73b8Xytk
        +mgd+6FSbqnaP+FaVNKk706g2TfSBAA3Z5xf/BjZhyX98bPkMIYopBXsknod4v0dPErbaa
        HXum/Yzs//TBJ4pmjO4ZGXQp14bAqGseG9UaiTtpqEB60OosHf7NgZx6TPt+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663727384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O7oJ2reAEAdzLak2oa0/kxa/ZxDy6E0CmB57S2GS3eg=;
        b=tdBAW8Fg2UVAOfsWw7ScCBYBIfl0zOp5mDbblXFF1Kr1+6KPzp0dVNm066aN8rkpcprH2g
        XtWeOB3WUjSI7gpJXe/nzyY5lkKlZSLj2R9zPaL9Y9D36J747kldVhZEN/jFwprekbfb2d
        YfhjR+49YksXNID74/wQAoDFUP2167XvGoDLZ1ROZBvTNTReCw4Xcf7hvHyEkgM85fnEZS
        O9kdk80FuFKsCwgZ8NX0Xrr0nrXR7FNMaaPM6MA1R6Z8RkyTkyou7nvwnvQMaubE8q09hU
        8+2YZnjnYhRWNOt0cgA7xPuE+zSgr0vLHR8YxWEZwdWjXVgVLO+kJz76qoIBXQ==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-z22nr;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Illegal-Belong: 3fbb7a967ce76f03_1663727384318_1067027284
X-MC-Loop-Signature: 1663727384318:3447230
X-MC-Ingress-Time: 1663727384318
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.122.234.205 (trex/6.7.1);
        Wed, 21 Sep 2022 02:29:44 +0000
Received: from ppp-46-244-242-250.dynamic.mnet-online.de ([46.244.242.250]:47334 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oapUa-0006rg-6p
        for linux-btrfs@vger.kernel.org;
        Wed, 21 Sep 2022 02:29:42 +0000
Message-ID: <70591e96d9dbc46cfaa44316f0eb1bcccc7017f5.camel@scientia.org>
Subject: call trace when btrfs-check tries to write on ro-blockdev
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Wed, 21 Sep 2022 04:29:37 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.0-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,
        HAS_X_OUTGOING_SPAM_STAT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

Not really a big problem but a but "ugly"...

When trying to do some write operation with btrfs check on a blockdev
that is set read-only, one gets a call trace like the following:


# btrfs check --clear-space-cache v1 /dev/mapper/data
Opening filesystem to check...
Checking filesystem on /dev/mapper/data-b-1
UUID: 18343f60-3955-11ed-a6c8-38afd7a81270
Error writing to device 1
kernel-shared/transaction.c:156: __commit_transaction: BUG_ON `ret`
triggered, value 1
btrfs(+0x3683b)[0x55c75780483b]
btrfs(__commit_transaction+0xc6)[0x55c757804b32]
btrfs(btrfs_commit_transaction+0x130)[0x55c757804ca0]
btrfs(+0x61963)[0x55c75782f963]
btrfs(+0x6e297)[0x55c75783c297]
btrfs(main+0x318)[0x55c7577e6138]
/lib/x86_64-linux-gnu/libc.so.6(+0x2920a)[0x7f6fd6ff920a]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x7c)[0x7f6fd6ff92bc]
btrfs(_start+0x21)[0x55c7577e6171]
Aborted


Cheers,
Chris.

PS: That was with progs 5.19.
