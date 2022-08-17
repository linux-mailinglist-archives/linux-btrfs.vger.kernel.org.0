Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE67597496
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 18:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiHQQyM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 17 Aug 2022 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbiHQQyJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 12:54:09 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CECF57886
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 09:54:06 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3C48012276F;
        Wed, 17 Aug 2022 16:54:05 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2869C1226BE;
        Wed, 17 Aug 2022 16:54:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660755244; a=rsa-sha256;
        cv=none;
        b=oIkglCirNeCNNSsBsEwHa/WwzFxaxwPUhhpCIo+11NGh1ZLYkcUk6AiT8D/RPuRH8OAgb+
        i5ENaGj1xaSL/lQgipOBHYRi54YX/tGZ5mjorTlCrerhQz4hrjsB1ORgyL3XtKmMz8liYG
        zB4uwi69XaELyklzFscL7QJfg1MJFGewv1ZVfZOi+h8Mi9Djzi1S2Tpgf2dxG3htayLUdv
        +x3vVrk0T3B2yB9MVHUKkHx9P732XegM2FIXSFt3OsOZUgmGFyg8cfj7ohepIHZ9vyq9cu
        i0UakNN8Vi3OR7X7Ab79XSqpIcpuh30GALg0mQZJ3H4AKSIB5kiDMzxH3Ybm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660755244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jy46ctlehTfxEOVx/0U6y8+NsuX/b+6sgzXG82EDVHE=;
        b=cxEwZt3YUsXOlMwnqJVCJ58u3YEip7eNhZsU8BnHsAPcYPEsrcPLaduA2zCGpK1FRuHRKB
        Gu2Y6bR2nubNg22RVnGF+xYtYKFaibOSt/U7jyzUS594//pJOkOA/EPretcZzmarQlORXT
        RXqTx9o4bq9IMVrpwRiuTQG2B68zdlUE9vxm5si10DK6V+pC9caD6LavIftegvPCdIAA33
        iMF0aDsVgO5t1shtCFrhvfpr1kwm1uo6XCey/LAjXXr7PLnw/lGoqDnIGvDnZzgA5suQi6
        4sFFklOk7k+Ox6BzUJ4dfqrXm/NmPB3F1vQvFSe20v6r/GvCH4ze3R+jkB3IIg==
ARC-Authentication-Results: i=1;
        rspamd-7697cc766f-7fgh6;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Illegal-Juvenile: 1e6b225761f75a85_1660755244986_2871680459
X-MC-Loop-Signature: 1660755244986:1122366455
X-MC-Ingress-Time: 1660755244986
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.124.238.93 (trex/6.7.1);
        Wed, 17 Aug 2022 16:54:04 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:53716 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oOMIp-00029t-Pz;
        Wed, 17 Aug 2022 16:54:02 +0000
Message-ID: <dbc8b0ee60b174f1b2c17a7469918a32a381c51b.camel@scientia.org>
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Linux BTRFS <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Cc:     Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Wed, 17 Aug 2022 18:53:56 +0200
In-Reply-To: <CAK-xaQZYDBuL2DMeOiZDubujSmZTcNJfkgqa03Q+24=nhCmynw@mail.gmail.com>
References: <cover.1660690698.git.osandov@fb.com>
         <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
         <CAK-xaQZYDBuL2DMeOiZDubujSmZTcNJfkgqa03Q+24=nhCmynw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-1 
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

Hey.


It would be indeed quite helpful if there was some more usable
information for end-users on how to detect any possible corruptions
from that issue.


From how I'd understand the commit message there are at least some ways
where one would not be able to notice that, and so the corruptions are
actually possibly silent?



Are there perhaps at least some usage patters that were not prone to 
the issue?
I have e.g. numerous filesystems were regular files were only ever
added, but never deleted (just moved perhaps within the filesystem).



Are there any recommendations for people what they should do once the
have the fix? Like invalidating the free space cache with btrfs check?



Is this going to be submitted to the stable kernels?



Also, I think, there should be some better means of communicating data
corruption issues, especially silent ones, to the users.
In the past there were several of them (like the issues with holes and
compression) that - just like this one now - people only ever noticed
merely by chance.

This however easily crushes any chances for people to actively search
for corrupted data (e.g. by manually comparing with backups) and
retrieving still good copies of damaged files (which possibly will
eventually be rotated out of existence).


Cheers,
Chris.
