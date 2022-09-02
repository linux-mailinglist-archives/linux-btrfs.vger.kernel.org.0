Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17925ABA10
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 23:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiIBVbj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 2 Sep 2022 17:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiIBVbg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 17:31:36 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F2EEF02B
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 14:31:31 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 342C2201298;
        Fri,  2 Sep 2022 21:25:24 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 348312014E3;
        Fri,  2 Sep 2022 21:25:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662153923; a=rsa-sha256;
        cv=none;
        b=7xQ+TS+3dWTH8FGrU12UmjNcO0TRrSuzBcCR+M7MRqmwPvsrq25C/sHIXdleTtHdKmOfc2
        mj+f/hjWqCfP6j2KtZbIrXtzGuuw7eWX7WXxPIjf49CW6enUsf0zUlPv3pIlkKy0xpChJ2
        Uz6ypfkkHa8IxrlhZG+VsUdJ71X/GKivGMN1MLtpUijR5xX/OM1TeYOLkrBvFHRaJgTNhl
        Xm0LYOP3rZflz3CeSB+OHNOBXPuq076o6InO+m1KTQExgV2NuN+9AFp2rW0G0iAXoHC3JP
        GC4C9RIUfjSlyTZECKZvIbfYMFwNtGmf0BxRTV8NtUbIejHMEOrIhDyLN8MkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662153923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4IH8EZ+NfOCyWbnRl11JIa8TT2qFlwQtVE5sdPNJOE=;
        b=q7MPkEQnAudpQaHMiIfxcgKdhTtW906lSHdv+AJ1Ov8QtwRWk7AZNJs7thOyt5ymLlmM4A
        hACuQL5fOCmT5o3ia2hUvnwfXUvOJs5CFECsYvz0+Jy42xLfvr/NFb3vzeZ3qPQgMXpU9r
        SoWoGNdZ0MR8KRBQaioitZmlIjsEuMsEWpMHVh5vx6IWa7MXJfIP28zEgC6Oe1fe0SZwNx
        erVmnMZ5aTydzUzowge3ZSB1ezr57y3vbBaRkeOTd7fjM6StAl/eLl0fUz/hiPIvf3Ra2V
        2wVKOR3Se18EVS5tEHoNmBq13EOL2gDXHwNAt7BTo993/2n1Tln5SpaGPwRPWw==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-2hk8x;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Daffy-Robust: 745b566d3a67185f_1662153923845_4091846074
X-MC-Loop-Signature: 1662153923844:519348373
X-MC-Ingress-Time: 1662153923844
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.109.219.78 (trex/6.7.1);
        Fri, 02 Sep 2022 21:25:23 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:48756 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oUEAB-0004jQ-SS;
        Fri, 02 Sep 2022 21:25:21 +0000
Message-ID: <159804e368285248d992d333c3643a186193271e.camel@scientia.org>
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linux BTRFS <linux-btrfs@vger.kernel.org>
Date:   Fri, 02 Sep 2022 23:25:16 +0200
In-Reply-To: <YxD3iM29bDpnxeNg@relinquished.localdomain>
References: <cover.1660690698.git.osandov@fb.com>
         <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
         <CAK-xaQZYDBuL2DMeOiZDubujSmZTcNJfkgqa03Q+24=nhCmynw@mail.gmail.com>
         <dbc8b0ee60b174f1b2c17a7469918a32a381c51b.camel@scientia.org>
         <Yv2A+Du6J7BWWWih@relinquished.localdomain>
         <b5d37d4d059e220313341d2804cbf1daf2956563.camel@scientia.org>
         <Yv2IIwNQBb3ivK7D@relinquished.localdomain>
         <467e49af8348d085e21079e8969bedbe379b3145.camel@scientia.org>
         <751cc484a56fc0bbe3838929feae3c214c297001.camel@scientia.org>
         <YxD3iM29bDpnxeNg@relinquished.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-1+b1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Oh and one more

On Thu, 2022-09-01 at 11:18 -0700, Omar Sandoval wrote:
> and any suggestions you have.

> "If you want to be extra cautious, you can also clear the v1 space cache.\n"
> "There are two ways to do this. The first is:\n"
> "\n"
> "1. Add the clear_cache mount option to this filesystem in fstab.\n"
> "2. Unmount then mount the filesystem. Note that `mount -o remount` is\n"
> "   not sufficient; you need a full unmount/mount cycle. You can also\n"
> "   reboot instead.\n"
> "3. Remove the clear_cache mount option from fstab.\n"

Wasn't the clear_cache flag only clearing it for stuff that get's
actually written?
And if so, wouldn't that be *not* enough to do?


> "\n"
> "The second way to clear the space cache is:\n"
> "\n"
> "1. Unmount the filesystem.\n"
> "2. Run `btrfs check --clear-space-cache v1 <device>`.\n"
> "3. Mount the filesystem.\n");


Wouldn't it make sense to generally advise people to clear the v1 and
v2 space cache?


Cheers,
Chris.
