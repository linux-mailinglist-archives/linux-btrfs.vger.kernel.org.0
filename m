Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB64CE82D
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 02:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiCFBsY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 5 Mar 2022 20:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCFBsX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 20:48:23 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B29D7F
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 17:47:31 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 634C9120D6A;
        Sun,  6 Mar 2022 01:38:57 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4260C120C7D;
        Sun,  6 Mar 2022 01:38:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1646530736; a=rsa-sha256;
        cv=none;
        b=h5ImEbs11DEIsDPr2/9PKvxknktp47Lk12rx03ThVfCPCCWtFk66x8fjbgyA5QJUZbkIcV
        fxA5ki54n9rcXZNNlHhCEofD3puHF7fqpnB+VjQ7rjEQrTWk6qwASW03nuXf6N1YcowcE+
        fys4ZqFsqdKVcq/0SRshIlPMGenWeVtUDUfCUzVnbWlISf0gsSoxFtiDx+uJleRTmR0YCP
        edNOH+pa83KaoNx72/CAQANHcPM81L7O1pM8t9Tbzc+I3Fk11iKy4knoDqCu8Dx1R0fKl1
        /HwMLhVGyqiIucCxdnkCnndD03zF3Js+Rw6aseTsDBSSEIv612bg4rddL388qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1646530736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwfkOGzYjJcjZm7HUhB99Rm/t7rw47dYlRSgaVl4s8o=;
        b=meE/wCfQK4MSP+N5O6AuMqTG6vSLWuhUvjXFPWRAk69DUqPjpuGJRfTkC+Z9Zpec5jVmKZ
        x+kLI3KsBh+p3tT+hZ62+G/MIVXYdPM9WFStVpQK7EbRHENKdx7Mk2LvrZkvIZz7t0+hz8
        QnmM80DRPhTf7P6dPX265GXtekfKkyKBm7y3JW7cAa0/cFyNMnT4+7Pgkt+D0f9PZFvnRa
        Zpcpb7kHF8J0IpEr6YGTIn65icG2dgTZfNtUhUvWyHP3QQa6bn006eJIsmJsYUN051hIKy
        8if8hOQTsGsvc2y6i3cKyrotCkVxgMaNDdguyTShlnpuWCu0itzWlJm0hYRdsQ==
ARC-Authentication-Results: i=1;
        rspamd-56df6fd94d-rx8xk;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.124.238.84 (trex/6.5.3);
        Sun, 06 Mar 2022 01:38:57 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Spot-Shelf: 72acedec5d837842_1646530736908_423060553
X-MC-Loop-Signature: 1646530736908:915787044
X-MC-Ingress-Time: 1646530736908
Received: from p3e9c2960.dip0.t-ipconnect.de ([62.156.41.96]:59388 helo=heisenberg.scientia.net)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nQfrI-00069y-UO; Sun, 06 Mar 2022 01:38:54 +0000
Message-ID: <3d8e6c6a2bd08164835b6aa3bf6d4d1d9ed9e5df.camel@scientia.org>
Subject: Re: status page status - dedupe
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Date:   Sun, 06 Mar 2022 02:38:48 +0100
In-Reply-To: <YiP5l4Rq9AOuiIKt@hungrycats.org>
References: <c16169c5b971fe5dee1e50e07e2c7bb8d2bface4.camel@scientia.org>
         <YiP5l4Rq9AOuiIKt@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for that elaborate description (and thanks to Qu, too).

I think that might be be a good addition to
https://btrfs.wiki.kernel.org/index.php/Deduplication


Also:

On Sat, 2022-03-05 at 19:00 -0500, Zygo Blaxell wrote:
> jdupes can use the safe dedupe ioctl (-B) or very unsafe hardlinks (-
> H).

I guess you mean -L ?!

Thanks,
Chris.
