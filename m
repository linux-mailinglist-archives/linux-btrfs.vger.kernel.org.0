Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1175E689FD9
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Feb 2023 18:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjBCRCu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 3 Feb 2023 12:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjBCRCt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Feb 2023 12:02:49 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FFD196BC
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Feb 2023 09:02:47 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B768A3C130D
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Feb 2023 17:02:45 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id E85D03C0E5A
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Feb 2023 17:02:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675443765; a=rsa-sha256;
        cv=none;
        b=9Zhvuwiw3hTuj9FjiXBV9pMwoDLuwqGBa131f6KU5Jqyjf5DtQW585VZG5nkuLfFbFazGT
        ssPHZOyLnov6uNdewksKwnmJ30M4NF18vahJbmCssxALiur62l/Aw92uRL/YPgSihWykOf
        lR4xKYq8h7K9wJ7SnrLpOJgnIZTvjg0VGMOLtcS9cqt54WQX2xTQVoXuB1LMNyuy80qCAi
        hILVVpga/d4/CIBfXOfwnAnzHbh1wR/9bYl1hQ+f5WVtAe6NxOxTpb0XB3/pR/L7MrKDhL
        +arBMilIRDZafR6J0Mxjhzy7VNBoejiTiuFc8kdx7zwklOzonSJhmSXpF207nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675443765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Efns7Ql0cbKbysAcyElzVSHdmWvUaoSrW9PlqQ0uQbU=;
        b=TxwrcVQX1FSyI/jbBI+VqA3ROkCedrO7RsdyVlTVMdhjQ6XZ3SceOLaBy1HzdkFKD6UY8L
        T3V9MFtTCX3blUxyUDEHhBZiLnIKvJXXgrOJvBLHwvpsXOpgq1hvuqlxQ5ZCfTqtPpQuus
        AQ1jG4Te/8L7XqzNTlIAKDHFubSRbOSOmCQHJpO7pbr/8pFRKNi5YduNaHTbAQqfNSd+ad
        hyCtv2912LZp7IImEducseG+SkNORuAOXyFX1gqS9RZRHBNFxljXKE+ap6eCYvFi3CRLMd
        OW9b2gWVEpv5V7jBrN6g0WFHhuG3WNFg12ruGxGaXC/DLJgV/QMk21rObs8DtA==
ARC-Authentication-Results: i=1;
        rspamd-5fb8f68d88-tkj5q;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Tangy-Lonely: 0feb694355360c06_1675443765445_1782475068
X-MC-Loop-Signature: 1675443765445:4179740949
X-MC-Ingress-Time: 1675443765445
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.109.196.238 (trex/6.7.1);
        Fri, 03 Feb 2023 17:02:45 +0000
Received: from p5b071f3f.dip0.t-ipconnect.de ([91.7.31.63]:37826 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1pNzSS-0000Wi-47
        for linux-btrfs@vger.kernel.org;
        Fri, 03 Feb 2023 17:02:41 +0000
Message-ID: <0150b9ef37499cadc13222710bf08adbf4e75f7f.camel@scientia.org>
Subject: recursive send/receive?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Fri, 03 Feb 2023 18:02:36 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        HAS_X_OUTGOING_SPAM_STAT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

I wondered whether it was possible to get the following in
send/receive:


A mode, where any subvolumes beneath a sent subvolume are also
sent/received (automatically).

Like if one has:
/mnt/btrfs/     -> which is e.g. subvol=/root-fs
/mnt/btrfs/home -> which is e.g. subvol=/home
or also in case of:
/mnt/btrfs/     -> which is e.g. subvol=/root-fs
/mnt/btrfs/home -> which is e.g. subvol=/root-fs/home

that a:
# btrfs send /mnt/btrfs/ | btrfs receive ...

also picks up home (wherever it is - perhaps with an additional option
-xdev like option, that would include only such subvols, that are on
the same btrfs as the subvolume via which it was included).


The main idea for this is simply to avoid forgetting any subvolumes
when e.g. backuping.


-p and -c should of course support that, too. I guess if one actually
specifies the parents/clone-srcs of such "sub-subvolumes" this
shouldn't be a problem.

But of course it would be even nicer if there was some way that receive
indicates send which subvolumes already has. Of course this wouldn't
work anymore via a pipe (which is however a really nice way).


Thanks,
Chris
