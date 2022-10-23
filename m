Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA54609527
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Oct 2022 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJWR0d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 23 Oct 2022 13:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJWR0c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Oct 2022 13:26:32 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F95D94
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 10:26:31 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DB92888099F;
        Sun, 23 Oct 2022 17:26:30 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id EF97D8801DB;
        Sun, 23 Oct 2022 17:26:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666545990; a=rsa-sha256;
        cv=none;
        b=wBsI7YovFrxBN6kDFs/WF7XF01n5vXmrSakGaoaFXBDdRcr5b4Di7KoyEMC1xjLoxSNqoQ
        C9gWtSrzcLriDmkE11xUnCQtM6G2nH6LukMbTFVv9h4+KP62mOoKdDFs6qO7xnKdWoNk1J
        UqfJ/t8clUTU5740yrpw6mtk+VXjMZ1tJRb3XTyHUueSjq7CDXtqTOsS57oxmgwgYxPAx/
        vk+bwPrBofapISfREq3w8ESfPaNzkQM+xoM0YXzVFwizO4ZZ5DupURxjNNXlDoTSaz3uc4
        3WzKeoZiH+XjSXQPvZtC3mgrSrL14Vuje+yfCBCMXEEkGhCoTyAlfpdXaW76mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666545990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EtDv0e6sUBXoJXwPo0OR/PksWaR8MBhjJbMCm8Fa9/o=;
        b=uZIs4EGCEGpcL7VX9WvJ7OFrhwJNXwizOxmEwkWV5Fgj9OdM6amjXNvW7S0SxXl0/3yBua
        eG7DRlsIidOOlpnu7A8Nu65cOfardYJbt8pAZaeZpY9Yez+VQGOwZjFU9oLKwEGcx8kTjH
        qGFA2u8zRbBJiPpRkxE6v/ARWOtJm5zl8842nXJsbnydj6GfLIzr6S+b9TORvHlupdyStq
        5aupiWYhTtTJzW75MhaGbAeoCei40ce0ebHrj6QYf5XKSFp+vSMJ20d9HfsRql8xdxfF47
        8LK0sz0gflSi5EW80oZIQxYfXncRxkXyy9j+vv40FiQKKVS4dRw+OqiaXJ5KGw==
ARC-Authentication-Results: i=1;
        rspamd-7fb88f4dd5-x7hrn;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Shelf-Minister: 5d07f7ad56b1a0c6_1666545990611_3089084922
X-MC-Loop-Signature: 1666545990611:1667902140
X-MC-Ingress-Time: 1666545990611
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.97.34.76 (trex/6.7.1);
        Sun, 23 Oct 2022 17:26:30 +0000
Received: from ppp-88-217-43-50.dynamic.mnet-online.de ([88.217.43.50]:52102 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1omejv-0002aI-KV;
        Sun, 23 Oct 2022 17:26:28 +0000
Message-ID: <1c531dd5de7477c8b6ec15d4aebb8e42ae460925.camel@scientia.org>
Subject: Re: 6.0.3 broke space_cache=v1 devices
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Tobias Powalowski <tobias.powalowski@googlemail.com>,
        linux-btrfs@vger.kernel.org
Date:   Sun, 23 Oct 2022 19:26:22 +0200
In-Reply-To: <CAHfPjO-gtcdvzgjm1o5NdS0bRy8ukyROH24UhWUATn6ouj07yw@mail.gmail.com>
References: <CAHfPjO-gtcdvzgjm1o5NdS0bRy8ukyROH24UhWUATn6ouj07yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

At least the:
  __btrfs_remove_free_space_cache
also shows up in my call traces:
https://lore.kernel.org/linux-btrfs/2291416ef48d98059f9fdc5d865b0ff040148237.camel@scientia.org/T/#u


Though I had the issue only on mv (and once on send|receive)...
otherwise my 6.0.3 v1-space-cache fs seem to work find (or maybe they
just pile up corruptions under the hood ^^).


Cheers,
Chris.
