Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD63309F4E
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 00:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhAaW7m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 31 Jan 2021 17:59:42 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:41096 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhAaW7g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 31 Jan 2021 17:59:36 -0500
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 323EA2262E
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Jan 2021 22:50:26 +0000 (UTC)
Received: from mailgw-02.dd24.net (100-96-18-11.trex.outbound.svc.cluster.local [100.96.18.11])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5046B226CA
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Jan 2021 22:50:25 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from mailgw-02.dd24.net (mailgw-02.dd24.net [193.46.215.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.18.11 (trex/6.0.2);
        Sun, 31 Jan 2021 22:50:26 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authsender|calestyo@scientia.net
X-MailChannels-Auth-Id: instrampxe0y3a
X-Arithmetic-Cooing: 18838bdd04e7f78e_1612133425861_2622138207
X-MC-Loop-Signature: 1612133425861:3759016569
X-MC-Ingress-Time: 1612133425861
Received: from heisenberg.scientia.net (p57b044d2.dip0.t-ipconnect.de [87.176.68.210])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: calestyo@scientia.net)
        by smtp.dd24.net (Postfix) with ESMTPSA id 517455FC4B
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Jan 2021 22:50:23 +0000 (UTC)
Message-ID: <956e08b1aed7805f7ee387cc4994702c02b61560.camel@scientia.net>
Subject: Re: is back and forth incremental send/receive supported/stable?
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-btrfs@vger.kernel.org
Date:   Sun, 31 Jan 2021 23:50:22 +0100
In-Reply-To: <20210129192058.GN4090@savella.carfax.org.uk>
References: <157ed91bb66820d1fef89eb05d00e65c25607938.camel@scientia.net>
         <20210129192058.GN4090@savella.carfax.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Hugo.


Thanks for your explanation.
I assume such a swapped send/receive would fail at least gracefully?


On Fri, 2021-01-29 at 19:20 +0000, Hugo Mills wrote:
>    In your scenario with MASTER and COPY-1 swapped, you'd have to
> match the received_uuid from the sending side (on old COPY-1) to the
> actual UUID on old MASTER. The code doesn't do this, so you'd have to
> patch send/receive to do this.

Well from the mailing list thread you've referenced it seems that the
whole thing is rather quite non-trivial... so I guess it's nothing for
someone who has basically no insight into btrfs code ^^


It's a pity though, that this doesn't work. Especially the use case of
sending back (backup)snapshots would seem pretty useful.

Given that this thread is nearly 6 years, I'd guess the whole idea has
been abandoned upstream?!


Cheers,
Chris.

