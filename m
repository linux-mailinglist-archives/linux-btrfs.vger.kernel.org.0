Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACB45BF4E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 05:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIUDn2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 20 Sep 2022 23:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIUDn1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 23:43:27 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0472F4CA2E
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 20:43:25 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2BB5B3E17D0;
        Wed, 21 Sep 2022 03:43:25 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3312C3E1AF4;
        Wed, 21 Sep 2022 03:43:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663731804; a=rsa-sha256;
        cv=none;
        b=dtVcjConACv/3OBPfPzF6XEPuUX7yM+dXu14+gXkeVOT1U8IflS+SmflbCN/0m3p0bumEq
        9NJIzthlA4vgI5fDxYWH/y2QUW2gsunCDh6ev7LaN/57EkZ/FlQCMM2j7+oWj5ylJGKwfm
        nQ04j3/qd0ukGVd4Hn3rJtiQ9Il5bC6VEFZws4QRhzDQ/t/vGcPfyvT/nPQFWdZ0D12lsz
        faOCTVRAmS7eSD8EtElqcAe/NepR3dPzLpbIQCrS4SuOm6XZGUNtsqJl3QoZko7p/0V6EL
        TwhC/8weJGjzxrIh2WetiR0j0glCAyrh68g/35FJTJTnPeBfOawz7/4brxGv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663731804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttZnA2FdBH1p8KuaulLFdmfkGG7ZhQjSRhpnpgZuZHs=;
        b=K5KPWm5d+wpFAwqaT/209AFj4HVjbCUYoRM0mx2bzeN4js736qaEs+OesbPKoIeLr1i0Jc
        Uepjo76qUWFYVIClffigoh2D6O9WvBNtVX3G5oWI6G3+CUHVJhp9HbMknlU/q+UMid5EM2
        HCR6GnfRx3j63U5FahVW8EtXcV5svKoQfUIBoTJKXjvFinRa7Ygx9CIa+K3glQ9ZT41IG5
        W7LIh9BiXwW/ZPNl0dPU102Swfihc21dQ60Nnl3iS9539sQLnGj7/lRmZhlF4sh+lBhFcr
        x0aNxGNKtmF70iTKi/h0ppsby+HhHZWdcAQde0blER/C3xmE9QlWiQAFMbOxxw==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-ct74j;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Invention-Cooperative: 7d3baca451b9a2a9_1663731804829_2118058625
X-MC-Loop-Signature: 1663731804829:1676192915
X-MC-Ingress-Time: 1663731804829
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.116.63.142 (trex/6.7.1);
        Wed, 21 Sep 2022 03:43:24 +0000
Received: from ppp-46-244-242-250.dynamic.mnet-online.de ([46.244.242.250]:58058 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oaqds-0000YL-Co;
        Wed, 21 Sep 2022 03:43:22 +0000
Message-ID: <52bf0daaa1f88fe1069f4871e28ca18a90d1d5c1.camel@scientia.org>
Subject: Re: call trace when btrfs-check tries to write on ro-blockdev
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Wed, 21 Sep 2022 05:43:16 +0200
In-Reply-To: <6d72763c-d024-3224-be8e-0ade32540883@gmx.com>
References: <70591e96d9dbc46cfaa44316f0eb1bcccc7017f5.camel@scientia.org>
         <6d72763c-d024-3224-be8e-0ade32540883@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.0-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2022-09-21 at 10:40 +0800, Qu Wenruo wrote:
> But my concern is, why this is not reported at fs open time?

At first I also wanted to suggest to not even do the (possibly lengthy
opening) if it's anyway "clear" that it would fail (because of the --
clear-space-cache request and the blockdev being ro).

However... if e.g. --clear-space-cache is used, but the device wouldn't
have any space cache... then it could still succeed, even if it was ro,
right?
So maybe for that case it would make sense to try.


> Let me dig deeper into the case.

Thanks.


Chris.
