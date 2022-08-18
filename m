Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726BC597A92
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 02:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiHRAWM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 17 Aug 2022 20:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiHRAWL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 20:22:11 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C6A3443
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 17:22:10 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 35EC22A17DE;
        Thu, 18 Aug 2022 00:22:09 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 299802A1649;
        Thu, 18 Aug 2022 00:22:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660782128; a=rsa-sha256;
        cv=none;
        b=GqjlboAYswB02OGdepSlEM8oIl3QkYVBhLjdFM6SeK0w0NFRkZflLGvp3cGQcRWcgqvOwB
        1hfLckVU319UK14U3l0ecBe/nI6JfJfOFlIc3F99qlSMj5lF+1S9YHJ0ek4VBNbiPMjuiG
        tbUZ/HpZt4BGui80tECOs2gnOu8t3FPsUVtiZgDdxnFmh5Mqoycx15SYtp71ymA+1/tjeA
        P1C1ic0K9KFBHAOPS04zFTX9M4mwu70XVwRmp3lM1mJAxRKG5cEkSPMuHaEgokmGOFLKhM
        YJFvS5d1CBC30ub87qeoTe9RNep0cTCKDZmp7S4FVpBu/MCUK3SYLFTeEeVs+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660782128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFR9uqe30MYUzT8xiAxQekeDWa95DeIwSFgxht51S20=;
        b=T2PK0eb9/B5C872nT4aVGchjq98bwzFjCS1pBWubInEr/ujdtypj8XiDmuek4r8n/0ASj7
        iJ2SBO19YpoPa8YiHPhVfYKmZmgHOgpxjIK5slCBb9A7aYRwRRV+S1WG2j0lXnYV6b9TLd
        bEpjElhPLcG4M5cqTuSDIVKcd/GRMfl5hOSrlSNjQcRtvdyS/BAgPh5CegvhwUHfJi9sNs
        mNvraY1nbGSSBm1k+NjqKvRF9gotZXqY0x168DyywDZJQVznGPBoQnrJuBzKJF1W1wBV03
        cOAaHe35hav9Gkrp24hRggENGrLslgu20y65B03OhnhX3CkMNZzYtv4E4WAgAQ==
ARC-Authentication-Results: i=1;
        rspamd-7697cc766f-v2dnn;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Cellar-Troubled: 77ecbe684f12d3b4_1660782128841_1896567213
X-MC-Loop-Signature: 1660782128841:559139658
X-MC-Ingress-Time: 1660782128841
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.121.210.163 (trex/6.7.1);
        Thu, 18 Aug 2022 00:22:08 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:47942 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oOTIQ-0007hL-S9;
        Thu, 18 Aug 2022 00:22:06 +0000
Message-ID: <b5d37d4d059e220313341d2804cbf1daf2956563.camel@scientia.org>
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linux BTRFS <linux-btrfs@vger.kernel.org>
Date:   Thu, 18 Aug 2022 02:22:00 +0200
In-Reply-To: <Yv2A+Du6J7BWWWih@relinquished.localdomain>
References: <cover.1660690698.git.osandov@fb.com>
         <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
         <CAK-xaQZYDBuL2DMeOiZDubujSmZTcNJfkgqa03Q+24=nhCmynw@mail.gmail.com>
         <dbc8b0ee60b174f1b2c17a7469918a32a381c51b.camel@scientia.org>
         <Yv2A+Du6J7BWWWih@relinquished.localdomain>
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

On Wed, 2022-08-17 at 16:59 -0700, Omar Sandoval wrote:
> I'm working on a tool that can be run on a mounted filesystem to
> detect
> most of the corruptions that could result from this bug. I'll share
> that
> in the next couple of days.

That sounds quite good.

Maybe such thing should find it's way into btrfs-progs.

I remember back then whether there were some corruption issues that
occurred with holes in compressed files, there were also some ways to
search for files which may have been affected.

So I mean such things wouldn't be the day2day tools of btrfs-progs, but
could be helpful to those who'd like to investigate more... and having
it as part of btrfs-progrs would make them much more accessible to end-
users (no need to search for it, no need to compile it, no need to
trust their author (well at least not more than they anyway need to
trust btrfs-progs)).


> 
> From what I've found, it's much more likely to happen if you delete a
> lot of data soon after boot with space_cache=v2/nospace_cache and
> discard/discard=sync. I can't say that it'd never happen outside of
> those conditions, but I suspect that it's much harder to hit
> otherwise.

Okay, but deletion *is* necessary, right? So if one has never deleted
(regular) files on a btrfs in question, the thing shouldn't be able to
have happened.



> 
> That's a fair point. We'll need to figure out a good way to do this.
> Do
> you have any suggestions?

Well, I had already brought this up before (on some other corruption
issue)... where some people argued it wouldn't be needed.

What one could do...

- A separate linux-btrfs-announce mailing list, or so, where only
  developers can post, informing only about really important stuff
  Not sure whether new versions or features would be important
  enough, but even if eventually "more" stuff gets posted than just
  corruption issues, one could prefix the subject with easy to spot
  tags like [NEWS], [CORRUPTION], or so.
  
  Downside is of course that people would need to register there.


- One also could think this even further and team up with other major
  filesystems, to have some dedicated corruption warning list,
  where posts would have a subject like "[<filesystem-type>] issue" and
  just pointing to further information.
  That way interested people could easily filter on the filesystems
  they use, and have a rather easy chance of noticing that they may
  need to take action.


- Another way would be to add it to a NEWS file of btrfs-progs, but I'd
  say it's too easy there too simply get overlooked.
  Also, it doesn't really belong to btrfs-progs (unless that would
  itself cause the corruption).
  Also, it would require release every time a new serious issue is
  found, which is then not guaranteed to end up anytime soon in the
  distributions.

- Same speaks IMO against having this in some NEWS file or so in the
  Linux sources.

- IMO anything which is not actively pushed to people is ruled out,
  so having it in the btrfs wiki or so, is also not really a solution.


Cheers,
Chris.
