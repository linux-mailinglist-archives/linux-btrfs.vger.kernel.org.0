Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D86C1648C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 16:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgBSPhD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 10:37:03 -0500
Received: from magic.merlins.org ([209.81.13.136]:58072 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSPhD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 10:37:03 -0500
Received: from [161.216.164.248] (port=59161 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1j4RPC-0003PV-KW by authid <merlins.org> with srv_auth_plain; Wed, 19 Feb 2020 07:36:57 -0800
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1j4RPB-00066s-0U; Wed, 19 Feb 2020 07:36:53 -0800
Date:   Wed, 19 Feb 2020 07:36:52 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     dsterba@suse.cz, Martin Steigerwald <martin@lichtvoll.de>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not zero f_bavail if we have available space
Message-ID: <20200219153652.GA26873@merlins.org>
References: <20200131143105.52092-1-josef@toxicpanda.com>
 <20200202175247.GB3929@twin.jikos.cz>
 <CAKhhfD7S=kcKLRURdNFZ8H4beS8=XjFvnOQXche7+SVOGFGC_w@mail.gmail.com>
 <2776783.E9KYCc1pZO@merkaba>
 <20200219134327.GD30993@merlins.org>
 <20200219143114.GY2902@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219143114.GY2902@suse.cz>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-No-Run: Yes
X-Broken-Reverse-DNS: no host name for IP address 161.216.164.248
X-SA-Exim-Connect-IP: 161.216.164.248
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 19, 2020 at 03:31:14PM +0100, David Sterba wrote:
> On Wed, Feb 19, 2020 at 05:43:27AM -0800, Marc MERLIN wrote:
> > On Wed, Feb 19, 2020 at 10:17:24AM +0100, Martin Steigerwald wrote:
> > > Marc MERLIN - 19.02.20, 01:42:57 CET:
> > > > Has the patch gotten to any 5.5 release too?
> > > 
> > > Yes, as git log easily reveals.
> > 
> > Sorry if I suck, but right now I only have pre-made kernel releases from
> > kernel.org.
> > This bug in 5.4 messed up some of my dm-thin volumes which now took 28% of a dm-thin
> > 14TB pool when the actual data is only using 4GB :( (at the same time it
> > also shows my FS is full when of course it's not).
> > 
> > I'll likely have to destroy the dm-thin to recover that space (or maybe
> > not, we'll see), but I'm travelling and don't really have countless time
> > to allocate to this.
> > If 5.5.4 is supposed to fix this too, I'll build it, install it and hope
> > it reclaims my lost dm-thin space, and if not suck up the deletion,
> > re-creation and backup/restore.
> 
> The fix got to stable 5.5.2 and 5.4.18. I don't know if dm-thin actually
> allows that, but is there a non-destructive way to reclaim the space?
> Like using fstrim (the filesystem can tell the underlying storage which
> blocks are free). According to
> http://man7.org/linux/man-pages/man7/lvmthin.7.html ("Manually manage
> free data space of thin pool LV") this should work but I have no
> practical experience with that.

Thanks. For some reason, debian's latest make-kpkg hangs forever on 5.5
kernels (not sure why) so I can't build it right now, but I just got
5.4.20 and I'm compiling that now, thanks.
As for dm-thin, I'm not sure yet, I'll find out when the new kernel is
installed. I was also hoping fstrim would work, I guess I'll find out.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
