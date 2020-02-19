Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 662BF1646E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 15:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgBSO2G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 09:28:06 -0500
Received: from magic.merlins.org ([209.81.13.136]:57056 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgBSO2G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 09:28:06 -0500
X-Greylist: delayed 2674 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Feb 2020 09:28:06 EST
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1j4PdP-0006A1-Tl by authid <merlin>; Wed, 19 Feb 2020 05:43:27 -0800
Date:   Wed, 19 Feb 2020 05:43:27 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not zero f_bavail if we have available space
Message-ID: <20200219134327.GD30993@merlins.org>
References: <20200131143105.52092-1-josef@toxicpanda.com>
 <20200202175247.GB3929@twin.jikos.cz>
 <CAKhhfD7S=kcKLRURdNFZ8H4beS8=XjFvnOQXche7+SVOGFGC_w@mail.gmail.com>
 <2776783.E9KYCc1pZO@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2776783.E9KYCc1pZO@merkaba>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 19, 2020 at 10:17:24AM +0100, Martin Steigerwald wrote:
> Marc MERLIN - 19.02.20, 01:42:57 CET:
> > Has the patch gotten to any 5.5 release too?
> 
> Yes, as git log easily reveals.

Sorry if I suck, but right now I only have pre-made kernel releases from
kernel.org.
This bug in 5.4 messed up some of my dm-thin volumes which now took 28% of a dm-thin
14TB pool when the actual data is only using 4GB :( (at the same time it
also shows my FS is full when of course it's not).

I'll likely have to destroy the dm-thin to recover that space (or maybe
not, we'll see), but I'm travelling and don't really have countless time
to allocate to this.
If 5.5.4 is supposed to fix this too, I'll build it, install it and hope
it reclaims my lost dm-thin space, and if not suck up the deletion,
re-creation and backup/restore.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
