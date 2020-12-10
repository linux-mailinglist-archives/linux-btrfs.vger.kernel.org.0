Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB42D512E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 04:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgLJDNc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 9 Dec 2020 22:13:32 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40230 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgLJDNc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Dec 2020 22:13:32 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 438358EBAEB; Wed,  9 Dec 2020 22:12:51 -0500 (EST)
Date:   Wed, 9 Dec 2020 22:12:51 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Wheeler <btrfs@lists.ewheeler.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Global reserve ran out of space at 512MB, fails to rebalance
Message-ID: <20201210031251.GJ31381@hungrycats.org>
References: <alpine.LRH.2.21.2012100149160.15698@pop.dreamhost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <alpine.LRH.2.21.2012100149160.15698@pop.dreamhost.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 10, 2020 at 01:52:19AM +0000, Eric Wheeler wrote:
> Hello all,
> 
> We have a 30TB volume with lots of snapshots that is low on space and we 
> are trying to rebalance.  Even if we don't rebalance, the space cleaner 
> still fills up the Global reserve:
> 
>     Device size:                  30.00TiB
>     Device allocated:             30.00TiB
>     Device unallocated:            1.00GiB
>     Device missing:                  0.00B
>     Used:                         29.27TiB
>     Free (estimated):            705.21GiB	(min: 704.71GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
> >>> Global reserve:              512.00MiB	(used: 512.00MiB) <<<<<<<

It would be nice to have the rest of the btrfs fi usage output.  We are
having to guess how your drives are populated with data and metadata
and what profiles are in use.

You probably need to be running some data balances (btrfs balance start
-dlimit=9 about once a day) to ensure there is always at least 1GB of
unallocated space on every drive.

Never balance metadata, especially not from a scheduled job.  Metadata
balances lead directly to this situation.

> This was on a Linux 5.6 kernel.  I'm trying a Linux 5.9.13 kernel with a 
> hacked in SZ_4G in place of the SZ_512MB and will report back when I learn 
> more.
> 
> In the meantime, do you have any suggestions to work through the issue?

I've had similar problems with snapshot deletes hitting ENOSPC with
small amounts of free metadata space.  In this case, the upgrade from
5.6 to 5.9 will include a fix for that (it's in 5.8, also 5.4 and earlier
LTS kernels).

Increasing the global reserve may seem to help, but so will just rebooting
over and over, so a positive result from an experimental kernel does not
necessarily mean anything.  Pending snapshot deletes will be making small
amounts of progress just before hitting ENOSPC, so it will eventually
succeed if you repeat the mount enough times even with an old stock
kernel.

> Thank you for your help!
> 
> 
> --
> Eric Wheeler
