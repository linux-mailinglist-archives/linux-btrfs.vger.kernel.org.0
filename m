Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0899B46B19A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 04:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhLGDrx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 22:47:53 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:56517 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231324AbhLGDrw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Dec 2021 22:47:52 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A9B17621042;
        Tue,  7 Dec 2021 03:44:22 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id C9EEE621495;
        Tue,  7 Dec 2021 03:44:21 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.105.57.109 (trex/6.4.3);
        Tue, 07 Dec 2021 03:44:22 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Ski-Grain: 31e1d8d15060590c_1638848662485_2678359442
X-MC-Loop-Signature: 1638848662485:1060601635
X-MC-Ingress-Time: 1638848662485
Received: from p57b045ec.dip0.t-ipconnect.de ([87.176.69.236]:49576 helo=heisenberg.scientia.net)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1muROq-0004sw-QG; Tue, 07 Dec 2021 03:44:19 +0000
Message-ID: <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
Subject: Re: ENOSPC while df shows 826.93GiB free
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Tue, 07 Dec 2021 04:44:13 +0100
In-Reply-To: <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com>
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
         <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
         <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
         <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2021-12-07 at 11:29 +0800, Qu Wenruo wrote:
> For other regular operations, you either got ENOSPC just like all
> other
> fses which runs out of space, or do it without problem.
> 
> Furthermore, balance in this case is not really the preferred way to
> free up space, really freeing up data is the correct way to go.

Well but to be honest... that makes btrfs kinda broke for that
particular purpose.


The software which runs on the storage and provides the data to the
experiments does in fact make sure that the space isn't fully used (per
default, it leave a gap of 4GB).

While this gap is configurable it seems a bit odd if one would have to
set it to ~1TB per fs... just to make sure that btrfs doesn't run out
of space for metadata.


And btrfs *does* show that plenty of space is left (always around 700-
800 GB)... so the application thinks it can happily continue to write,
while in fact it fails (and the cannot even start anymore as it fails
to create lock files).


My understanding was the when not using --mixed, btrfs has block groups
for data and metadata.

And it seems here that the data block groups have several 100 GB still
free, while - AFAIU you - the metadata block groups are already full.



I also wouldn't want to regularly balance (which doesn't really seem to
help that much so far)... cause it puts quite some IO load on the
systems.


So if csum data needs so much space... why can't it simply reserve e.g.
60 GB for metadata instead of just 17 GB?



If I really had to reserve ~ 1TB of storage to be unused (per 16TB fs)
just to get that working... I would need to move stuff back to ext4,
cause that's such a big loss we couldn't justify to our funding
agencies.


And we haven't had that issue with e.g. ext4 ... that seems to reserve
just enough for meta, so that we could basically fill up the fs close
to the end.



Cheers,
Chris.
