Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245275AB5B5
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbiIBPwX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 2 Sep 2022 11:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbiIBPwE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 11:52:04 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94712BFEA9
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 08:43:19 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 209206C29A7;
        Fri,  2 Sep 2022 15:43:16 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 111336C29BA;
        Fri,  2 Sep 2022 15:43:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662133395; a=rsa-sha256;
        cv=none;
        b=NN2ioeDN4bV1yfkueZLfVTBoz/fwJuzvdboYq7WD8gwcVNPDZwDSNys78a/s1slmM7g69E
        cfzEOFwvcLCPm6Xwnid8d7rtrwksrU23rsFIEbqZEwbVWaNDSLX1+8J/itKRFMBNEmwUQd
        tB3N1zrWfKQxUr1vA7Q4u31RlTlfAsIzz7U87DLZqxd1TnbKyAmENUnz94WjBSkYW/bBzp
        RtFNuWJEpnA1JDWmR/IpVeMvxhNQX/j6RiAWTXrAJlauk4faIJtv97/pOfAjy5oSBquDAs
        cpdiE6AGETKwtIgiy2t25DhKzP5lW0wLRqqciuIKglfHDsebADwkSkEW7LTGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662133395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FxBPl4PZPteqVUuLVoIOaxqJ4veHJPnOy90Rvf1ssl0=;
        b=X3SHNM1S1NKHGGp89oxyhGOqEWHdPIsZBMED7mb3H6Zmb10OVrpEUBwSUkdr5HDxfAUJLC
        o+a/5KRCkyk+ipsg1wQVWPKM0plLjAhWsfUfdSO/V6YqMEY03NOZ2ZiunRtMdr0Mm+eVoV
        ueh6C+I9dLHc5xxn6l5DxcJUI+ojNR9CZFHGaMZAo3fT8EsvY931jFWnV8nG2q9URm+Roy
        e/OR5u/6ayRAGOjgFpp128PiahvRSkb3lD1m/1Km7nYQL/vaqNr34O0zoEJgnT0WLbT5cr
        CqX3kUtZujqTqKMRJtJMxLF/037FUmNxunnSLWMM7bbumNXqkh/T45ILt+rw4g==
ARC-Authentication-Results: i=1;
        rspamd-64cc6f7466-zldmm;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Industry-Illustrious: 0d0ebc6013fda72d_1662133395702_2799880310
X-MC-Loop-Signature: 1662133395702:2318811570
X-MC-Ingress-Time: 1662133395702
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.126.240.197 (trex/6.7.1);
        Fri, 02 Sep 2022 15:43:15 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:51346 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oU8p5-00011O-96;
        Fri, 02 Sep 2022 15:43:13 +0000
Message-ID: <5ed8515b0d26f18f2c561b5afb20ddc09acb91f3.camel@scientia.org>
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linux BTRFS <linux-btrfs@vger.kernel.org>
Date:   Fri, 02 Sep 2022 17:43:07 +0200
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
X-OutGoing-Spam-Status: No, score=-0.2
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2022-09-01 at 11:18 -0700, Omar Sandoval wrote:
> The tool is here for now:
> https://github.com/osandov/osandov-linux/blob/master/scripts/btrfs_check_space_cache.c

Thanks.

> sudo ./btrfs_check_space_cache $MOUNTED_FILESYSTEM_PATH

I assume this would work on all data of the fs, even if that was
mounted on a subvolume?

And does it also check v1 space cache? And is it going to be part of
btrfs check?


> It'll print out a diagnosis and some advice. Please let me know what
> output it gives you and any suggestions you have.

I just ran it on the still unfixed kernel on several filesystems,...
some with v1 some with v2.

The output was e.g.
-----------------------------------------------------------------------

# ./btrfs_check_space_cache /data/a/1/
Space cache checker 1.0
retries = 2, freeze = 0
Running on Linux 5.18.0-4-amd64 #1 SMP PREEMPT_DYNAMIC Debian 5.18.16-1
(2022-08-10) x86_64
Free space tree is enabled

No corruption detected :)

You should install a kernel with the fix as soon as possible and avoid
rebooting until then.

Once you are running a kernel with the fix:

1. Run this program again.
2. Run btrfs scrub.
-----------------------------------------------------------------------


But to me it's still absolutely unclear what that really means now.

Is it just a: you're 99% safe... or 100%?

Were all trees/metadata checked? Would any corruption be detected, even
if it happened in the past and maybe the double allocation had been
cleared by chance in meantime?

Would the scrub detect any corruptions?

Basically it boils down to the questions I've had asked in:
https://lore.kernel.org/linux-btrfs/467e49af8348d085e21079e8969bedbe379b3145.camel@scientia.org/



But it seem right now, one cannot really give a definite answer, so I
probably have to recover everything from backups?!


Thanks,
Chris.
