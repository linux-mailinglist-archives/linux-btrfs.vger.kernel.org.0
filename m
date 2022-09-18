Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FD75BC00B
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Sep 2022 23:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIRVZe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 18 Sep 2022 17:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIRVZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Sep 2022 17:25:33 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FCE12AF2
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Sep 2022 14:25:31 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DA270E0494
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Sep 2022 21:15:41 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0F9F2E047D
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Sep 2022 21:15:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663535741; a=rsa-sha256;
        cv=none;
        b=lk8D6DW+M1eXCOxXfQ5qLYUjWn1l9b+FJP9UrEZRt347Cwdv4/lnhc9FdbB5b4mDj3DyTw
        MJFPuRvjr2AkPbUUQQdvjFeRv25TWId+mONCAvQ/wDSLXxU4D7NtsF0KHWtw2avRykqot5
        eALZo+VjGtjf8Ko36nQj6gzynfMoDMf4rKDujR/oWHHOotPUI7KTo6/KVbUpAco8SbM3j5
        VxCnf3DWlXeCKi4cm39N8bV4mAVdCJCV2bt6FD7QtrtVeBIMTIlVgV49NbwQfdprIC+/kG
        DvO4siS0iTVWNhPqehEy/7QBxIVFF/nspXLiQ9GTArwgfQc3nb3Jw0RtTVErgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663535741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rfEJz0YIA8npR7HY0Pc/YGyUopuywfkzSlBNxpl5SD0=;
        b=TQKLIV8TiEOKNfEb1238Fre6tUfB/+D9f6yw+U9KX+7A2+Fe+YogXKm1KhW8r4Iq7m2Uek
        jdeLGvbnQNGMy/zeVRzvGUSYOG25T2KWD8flWV+ZbCZ7mdHJCe4XmRaxMhRN/W/3kBcMwu
        Yu/hs7wTPJbUttqTpK6cvHlFok+8mhwVHruyeemy63rVxWt2PyrWQUqUuqGvmTYKqai4Dd
        gW600apE6oszRWc6A9BgON3z4kBChkC+apvNmNTZjsFtqLmiKOAWbK4tJRlMJk1IhMGY93
        xKDxFrTo1XU9JrzzCrF00a2hGBPjJ0vWaMP8x+pR2QkGMRjanoOWDKUTXTzeZw==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-qgj4j;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Plucky-Celery: 4a8892f45a42811a_1663535741561_426398649
X-MC-Loop-Signature: 1663535741560:845645194
X-MC-Ingress-Time: 1663535741560
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.112.55.209 (trex/6.7.1);
        Sun, 18 Sep 2022 21:15:41 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:53546 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oa1dW-00080L-Pk
        for linux-btrfs@vger.kernel.org;
        Sun, 18 Sep 2022 21:15:39 +0000
Message-ID: <e70c6c27d49e3625f0d06c8a90646c0248552b69.camel@scientia.org>
Subject: btrfs-check for filesystems with many snapshots (with many files)
 gets slow
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Sun, 18 Sep 2022 23:15:34 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.0-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        HAS_X_OUTGOING_SPAM_STAT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

That's not really a priority issue, I just figured that no one might
have thought about it before:

When having a filesystem with many files (like a million or so) and on
the same fs, snapshots are continuously made of the "main" subvol with
those files... then eventually btrfs-check get's super slow, even
though there weren't really that many changes between the snapshots
(mostly added files).

"Super slow" in the sense of 6 hours and more.


I just wondered whether there's any room for speed up (without loosing
any safety in checking) in btrfs-check to make it much faster?

Very naively thought something like: it doesn't have to check the stuff
it already checked on the other snapshot.
But of course I'm aware that with refs between the snapshots and
extents, things are much more complex in reality.


Cheers,
Chris.
