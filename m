Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8837C3F2171
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 22:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhHSUR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 16:17:26 -0400
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:33017 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231856AbhHSUR0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 16:17:26 -0400
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D510E782164;
        Thu, 19 Aug 2021 20:00:18 +0000 (UTC)
Received: from mailgw-01.dd24.net (100-96-99-6.trex.outbound.svc.cluster.local [100.96.99.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id BF8497820B1;
        Thu, 19 Aug 2021 20:00:14 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authsender|calestyo@scientia.net
Received: from mailgw-01.dd24.net (mailgw-01.dd24.net [193.46.215.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.99.6 (trex/6.3.3);
        Thu, 19 Aug 2021 20:00:18 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authsender|calestyo@scientia.net
X-MailChannels-Auth-Id: instrampxe0y3a
X-Troubled-Reign: 39c8d7026f3cc80b_1629403216415_1707753347
X-MC-Loop-Signature: 1629403216415:1857796178
X-MC-Ingress-Time: 1629403216415
Received: from heisenberg.scientia.net (p57b04748.dip0.t-ipconnect.de [87.176.71.72])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: calestyo@scientia.net)
        by smtp.dd24.net (Postfix) with ESMTPSA id 62AAA5FC35;
        Thu, 19 Aug 2021 20:00:07 +0000 (UTC)
Message-ID: <61edec6fd6d3704d55adf6888341e50b56df11d5.camel@scientia.net>
Subject: Re: failed to read the system array: -2 / open_ctree failed
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Date:   Thu, 19 Aug 2021 22:00:06 +0200
In-Reply-To: <9775aead-8884-dfb6-d877-a38c093e696d@suse.com>
References: <2d56668e7c0f83531c6e46b9582bc4a0704e690a.camel@scientia.net>
         <9775aead-8884-dfb6-d877-a38c093e696d@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Nikolay, Anand.

After some further testing last night, it seems that a rootdelay=60
options solves the whole issue (and turning it off again, brings it
back in most boots).

So in the end, no btrfs issue at all.

Still a bit strange the whole thing - I'd have expected the device file
to appear only once after the device is really usable.


Thanks,
Chris.

