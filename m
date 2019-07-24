Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1537315F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 16:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfGXORG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 10:17:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:34150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbfGXORG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 10:17:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 219AEAFD4;
        Wed, 24 Jul 2019 14:17:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 95C1FDA808; Wed, 24 Jul 2019 16:17:42 +0200 (CEST)
Date:   Wed, 24 Jul 2019 16:17:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jeff Mahoney <jeffm@suse.com>
Cc:     dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs-progs: check: run delayed refs after writing
 out dirty block groups
Message-ID: <20190724141742.GN2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jeff Mahoney <jeffm@suse.com>,
        Filipe Manana <fdmanana@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190402180956.28893-1-jeffm@suse.com>
 <CAL3q7H7O=ZqJdQUXYZjJRfZF04Or7kLgEVnRUGE97YRsV=3pMg@mail.gmail.com>
 <068957f9-c4cf-688d-3db7-7f519c21e4ea@suse.com>
 <20190515141605.GQ3138@twin.jikos.cz>
 <CAL3q7H45c8H91vbz=9yPmtPE95Ret1XLNW3kNT5XGs6L2-GAAw@mail.gmail.com>
 <20190517131246.GB3138@twin.jikos.cz>
 <b0172639-ceaf-c220-dd3d-32e193ec8817@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0172639-ceaf-c220-dd3d-32e193ec8817@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 24, 2019 at 09:53:33AM -0400, Jeff Mahoney wrote:
> On 5/17/19 9:12 AM, David Sterba wrote:
> > On Wed, May 15, 2019 at 03:45:13PM +0100, Filipe Manana wrote:
> >>>>> And running delayed refs can dirty more block groups as well.
> >>>>> At this point shouldn't we loop running delayed refs until no more
> >>>>> dirty block groups exist? Just like in the kernel.
> >>>>
> >>>> Right.  This is another argument for code sharing between the kernel and
> >>>> userspace.
> >>>
> >>> Sharing code in this function would be really hard, I've implemented the
> >>> loop in commit in progs.
> >>
> >> Shouldn't the new patch version be sent to the list for review?
> >> It doesn't seem to be a trivial change on first through.
> > 
> > Ok, I've removed the patches from devel and will send them once the
> > release is done.
> > 
> 
> Hi Dave -
> 
> Did this ever get revisited?

No, but Qu sent the fix, that's now in devel.
