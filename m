Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD6830A5C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 11:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhBAKth (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 05:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhBAKtg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Feb 2021 05:49:36 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF40C061573
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Feb 2021 02:48:55 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1l6Wif-00017c-V8; Mon, 01 Feb 2021 10:46:09 +0000
Date:   Mon, 1 Feb 2021 10:46:09 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Christoph Anton Mitterer <calestyo@scientia.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: is back and forth incremental send/receive supported/stable?
Message-ID: <20210201104609.GO4090@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs@vger.kernel.org
References: <157ed91bb66820d1fef89eb05d00e65c25607938.camel@scientia.net>
 <20210129192058.GN4090@savella.carfax.org.uk>
 <956e08b1aed7805f7ee387cc4994702c02b61560.camel@scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <956e08b1aed7805f7ee387cc4994702c02b61560.camel@scientia.net>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 31, 2021 at 11:50:22PM +0100, Christoph Anton Mitterer wrote:
> Hey Hugo.
> 
> 
> Thanks for your explanation.
> I assume such a swapped send/receive would fail at least gracefully?

   It'll fail *obviously*. I'm not sure how graceful it is. :)

> On Fri, 2021-01-29 at 19:20 +0000, Hugo Mills wrote:
> >    In your scenario with MASTER and COPY-1 swapped, you'd have to
> > match the received_uuid from the sending side (on old COPY-1) to the
> > actual UUID on old MASTER. The code doesn't do this, so you'd have to
> > patch send/receive to do this.
> 
> Well from the mailing list thread you've referenced it seems that the
> whole thing is rather quite non-trivial... so I guess it's nothing for
> someone who has basically no insight into btrfs code ^^
> 
> It's a pity though, that this doesn't work. Especially the use case of
> sending back (backup)snapshots would seem pretty useful.
> 
> Given that this thread is nearly 6 years, I'd guess the whole idea has
> been abandoned upstream?!

   It can be made to work, in a number of different ways -- the option
above is one way; another would be to add extra history of subvolume
identities -- but I guess it's not a priority for the devs, and at
least the latter approach would require extending the on-disk FS
format. Both approaches would need changes to the send stream format.

   Hugo.

-- 
Hugo Mills             | Great oxymorons of the world, no. 7:
hugo@... carfax.org.uk | The Simple Truth
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
