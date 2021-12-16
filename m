Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BB64768CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 04:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhLPDrM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 22:47:12 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:46152 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230345AbhLPDrM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 22:47:12 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 38DA46214CA;
        Thu, 16 Dec 2021 03:47:11 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 436DC621286;
        Thu, 16 Dec 2021 03:47:10 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.109.250.15 (trex/6.4.3);
        Thu, 16 Dec 2021 03:47:11 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Power-Cure: 10f8215b6806d891_1639626430941_4203674757
X-MC-Loop-Signature: 1639626430941:1817441896
X-MC-Ingress-Time: 1639626430941
Received: from ppp-88-217-34-119.dynamic.mnet-online.de ([88.217.34.119]:35704 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1mxhjV-0006M0-WA; Thu, 16 Dec 2021 03:47:08 +0000
Message-ID: <352195e7515f1665165df10157aba30e26b8b4cc.camel@scientia.org>
Subject: Re: ENOSPC while df shows 826.93GiB free
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Phillip Susi <phill@thesusis.net>
Cc:     linux-btrfs@vger.kernel.org
Date:   Thu, 16 Dec 2021 04:47:02 +0100
In-Reply-To: <87ilw0v2rj.fsf@vps.thesusis.net>
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
         <87ilw0v2rj.fsf@vps.thesusis.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2021-12-07 at 10:39 -0500, Phillip Susi wrote:
> I'm not sure what you intended this to do or show.  It looks like you
> tried to execute a program named /srv/dcache/pools/2/foo, and there
> is
> no such program.  That doesn't say anything about the filesystem.

Ooops, sorry... that was some wrong copy&pasting.

What I actually did was merely a
# touch /srv/dcache/pools/2/foo

which already gave me the ENOSPC (for the reasons that have now already
been explained... i.e. no (usable) free space in the meta-data and no
unallocated space either.


Thanks,
Chris.

