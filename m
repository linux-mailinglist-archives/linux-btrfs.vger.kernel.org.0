Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903DE30B396
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 00:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhBAXaS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 18:30:18 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:62016 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230470AbhBAXaP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 18:30:15 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Feb 2021 18:30:13 EST
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D2F7B703317
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Feb 2021 22:51:10 +0000 (UTC)
Received: from mailgw-02.dd24.net (100-96-16-7.trex.outbound.svc.cluster.local [100.96.16.7])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id A0A3C703472
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Feb 2021 22:51:09 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from mailgw-02.dd24.net (mailgw-02.dd24.net [193.46.215.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.16.7 (trex/6.0.2);
        Mon, 01 Feb 2021 22:51:10 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authsender|calestyo@scientia.net
X-MailChannels-Auth-Id: instrampxe0y3a
X-Continue-Wide-Eyed: 79dc54414511aa14_1612219870381_4016938804
X-MC-Loop-Signature: 1612219870381:2627216359
X-MC-Ingress-Time: 1612219870380
Received: from heisenberg.scientia.net (p57b044d2.dip0.t-ipconnect.de [87.176.68.210])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: calestyo@scientia.net)
        by smtp.dd24.net (Postfix) with ESMTPSA id 6EB415FCFB
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Feb 2021 22:51:07 +0000 (UTC)
Message-ID: <d73ee44738fc69df8aa3f9a5d3c04c5a88e2731a.camel@scientia.net>
Subject: Re: is back and forth incremental send/receive supported/stable?
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-btrfs@vger.kernel.org
Date:   Mon, 01 Feb 2021 23:51:06 +0100
In-Reply-To: <20210201104609.GO4090@savella.carfax.org.uk>
References: <157ed91bb66820d1fef89eb05d00e65c25607938.camel@scientia.net>
         <20210129192058.GN4090@savella.carfax.org.uk>
         <956e08b1aed7805f7ee387cc4994702c02b61560.camel@scientia.net>
         <20210201104609.GO4090@savella.carfax.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2021-02-01 at 10:46 +0000, Hugo Mills wrote:
>    It'll fail *obviously*. I'm not sure how graceful it is. :)

Okay that doesn't sound like it was very trustworthy... :-/

Especially this from the manpage:
       You must not specify clone sources unless you guarantee that these
       snapshots are exactly in the same state on both sides—both for the
       sender and the receiver.

I mean what should the user ever be able to guarantee... respectively
what's meant with above?

If the tools or any option combination thereof would allow one to
create corrupted send/received shapthots, then there's not much a user
can do.
If this sentence just means that the user mustn't have manually hacked
some UUIDs or so... well then I guess that's anyway clear and the
sentence is just confusing.


> but I guess it's not a priority for the devs

Since it seems to be a valuable feature with probably little chances to
get it working in the foreseeable future, I've added it as a feature
request to the long term records ;-)
https://bugzilla.kernel.org/show_bug.cgi?id=211521



Cheers,
Chris.

