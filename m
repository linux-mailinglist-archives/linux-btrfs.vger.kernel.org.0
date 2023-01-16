Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3117766C3E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjAPPbI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 16 Jan 2023 10:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAPPar (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 10:30:47 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F71B1CF4E
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 07:24:53 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 270449215C4
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 15:24:52 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0D2EB920FA7
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 15:24:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1673882691; a=rsa-sha256;
        cv=none;
        b=xqKLUGzlOLKkFbj+JrktHfqJuGOoBx6ekpR0t9aq2ial13wGLI1XrQlWrCKn71z86K+JWX
        amlp7E1slQkbn3Ny90FoK/MA7t+273IbPYiJnDKEQ4kebStMzTPFUUwVVqupzSYpKehoRi
        0dIjx7Yrj87g6hovQ5sdApNVrqOwaRwd9iKwwR7SbrrsIjVUQ6s8zJZ7Ybu7FEA+ndxjC8
        JmOxtHJApiXI6um4gCqq/abqZQATWivoV4758uFOAc80ORDkgYWUNpDNPMLuuqHIuphg3V
        dOjwXYrnatbDKZsIA2WkCcMOr0g6+zFS0n4gnxqWis9HE3OifmtnnEehcyLl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1673882691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3rLyMDCmMbcGSil1Ir5ZuT9EnBXwqiJYrqSIZqgMZo=;
        b=1P8Ear8ovqSLucTM/dzEXapcFR4qtdv4odVR2bUMaYEFnt9qpziuiCPUPBaZnW7HLCnKQx
        023AtZKB0sJYHzIixzzE+zMxyhc6xOIe0A5ey3kEz7O4JpR+bpmeCBGvDponlJKRbTlUZD
        ghaysglPEFiGVuLFIsXaWkEPatM3IFMvZIYDo8WLE81GVpno1b9mPU7Zk4SiBy0L5Yb4lM
        nMg7yeNq4zUfr3YvO5DCkxZ/FMJjuq5IPjMCgXrgbcPGOB3JZjddK++af4CdjBlufp/V0p
        wWlGla6LMDG7MCQqd23qXc/5KXFKfp5p7CWz7Mz+6gZfr+6UBOeHQ2ixzK5IIQ==
ARC-Authentication-Results: i=1;
        rspamd-6f569fcb69-7hzm9;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Suffer-Bored: 144f55435e5572c8_1673882691598_2522074815
X-MC-Loop-Signature: 1673882691598:3070083846
X-MC-Ingress-Time: 1673882691598
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.99.229.59 (trex/6.7.1);
        Mon, 16 Jan 2023 15:24:51 +0000
Received: from p5b071e4a.dip0.t-ipconnect.de ([91.7.30.74]:51052 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1pHRLp-000595-A3
        for linux-btrfs@vger.kernel.org;
        Mon, 16 Jan 2023 15:24:49 +0000
Message-ID: <c7bf7a6053211c1ac84ab00441e7505df25cbbe6.camel@scientia.org>
Subject: Re: [PATCH] btrfs-progs: docs: improve space cache documentation
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Mon, 16 Jan 2023 16:24:43 +0100
In-Reply-To: <afabf6cea649902733684575037e718f151a2ce1.camel@scientia.org>
References: <2269684.ElGaqSPkdT@lichtvoll.de>
         <bddd724d-649b-aa3b-9a97-f415fe7b6afd@gmx.com>
         <afabf6cea649902733684575037e718f151a2ce1.camel@scientia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3-1 
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

Hey Qu, Dave.

Since the space cache clearing options remain a source for confusion,
I'd have written the above patch (there's also a draft PR) which tries
to improve the documentation a bit.


What remains open (which why the patch/PR is just a draft) is:

a) Does --clear-space-cache v1|v2 really remove (or just clear) any
   space cache from the fs? Or is there even a difference?
 
   Especially, when I ran --clear-space-cache v1|v2 and then mount the
   fs (without neither nospace_cache nor space_cache[=*])...
   will it automatically get a new space cache, if so, which?

b) Is my assumption correct, that with v1, clear_cache itself really
   only clears the space cache for written blocks but not automatically
   rebuilds it.
   I.e. when clear_cache,nospace_cache would be used, its just cleared
   but not rebuild.

c) What about clear_cache and v2? Is it only clearing? Or is it,
   unless nospace_cache is used, right after clearing completely
   rebuilt?


Cheers,
Chris.
