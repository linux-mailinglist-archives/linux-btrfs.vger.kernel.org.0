Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4429F14CDA7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 16:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgA2Pi7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 10:38:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:33442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgA2Pi7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 10:38:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 81EB1AD3C;
        Wed, 29 Jan 2020 15:38:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B452BDA730; Wed, 29 Jan 2020 16:38:35 +0100 (CET)
Date:   Wed, 29 Jan 2020 16:38:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
Message-ID: <20200129153833.GH3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
 <20200116142928.GX3929@twin.jikos.cz>
 <40ff2d8d-eb3b-1c90-ea19-618e5c058bcc@gmx.com>
 <a8e81e58-8d9d-789c-de33-c213f6a894e6@gmx.com>
 <20200117141037.GG3929@twin.jikos.cz>
 <85585720-77de-b999-8d17-a17e86e1c181@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85585720-77de-b999-8d17-a17e86e1c181@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 10:22:46PM +0800, Qu Wenruo wrote:
> >>>> If it gets removed you are trading one bug for another. With the changed
> >>>> logic in the referenced commit, the metadata exhaustion is more likely
> >>>> but it's also temporary.
> >>
> >> Furthermore, the point of the patch is, current check doesn't play well
> >> with metadata over-commit.
> > 
> > The recent overcommit updates broke statfs in a new way and left us
> > almost nothing to make it better.
> 
> It's not impossible to solve in fact.
> 
> Exporting can_overcommit() can do pretty well in this particular case.

can_overcommit will be exported by the block group reado-only fixes,
pending for 5.6, so it might be used for statfs if need be.

> >> If it's before v5.4, I won't touch the check considering it will never
> >> hit anyway.
> >>
> >> But now for v5.4, either:
> >> - We over-commit metadata
> >>   Meaning we have unallocated space, nothing to worry
> > 
> > Can we estimate how much unallocated data are there? I don't know how,
> > and "nothing to worry" always worries me.
> 
> Data never over-commit. We always ensure there are enough data chunk
> allocated before we allocate data extents.
> 
> > 
> >> - No more space for over-commit
> >>   But in that case, we still have global rsv to update essential trees.
> >>   Please note that, btrfs should never fall into a status where no files
> >>   can be deleted.
> > 
> > Of course, the global reserve is there for last resort actions and will
> > be used for deletion and updating essential trees. What statfs says is
> > how much data is there left for the user. New files, writing more data
> > etc.
> > 
> >> Consider all these, we're no longer able to really hit that case.
> >>
> >> So that's why I'm purposing deleting that. I see no reason why that
> >> magic number 4M would still work nowadays.
> > 
> > So, the corner case that resulted in the guesswork needs to be
> > reevaluated then, the space reservations and related updates clearly
> > affect that. That's out of 5.5-rc timeframe though.
> 
> Although we can still solve the problem only using facility in v5.5, I'm
> still not happy enough with the idea of "one exhausted resource would
> result a different resource exhausted"
> 
> I still believe in that we should report different things independently.
> (Which obviously makes our lives easier in statfs case).
> 
> That's also why we require reporters to include 'btrfs fi df' result
> other than vanilla 'df', because we have different internals.
> 
> Or, can we reuse the f_files/f_free facility to report metadata space,
> and forgot all these mess?

Requiring filesystem-specific interpretation of f_files is a mess too.
That statfs, which is a syscall and we can't change anything on the
interface level, is a severe limitation for presenting the space is a
well known problem, yeah.

The patch is still in game, I got a feedback some feedback on IRC.
Comparing the 2 corner cases, the one I was aiming to fix is harder to
hit than the inflated metadata during balance.
