Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A7C4F7EF9
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 14:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245145AbiDGMaU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 08:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245139AbiDGM36 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 08:29:58 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02066A88AD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 05:27:55 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 509CF2B521B; Thu,  7 Apr 2022 08:27:54 -0400 (EDT)
Date:   Thu, 7 Apr 2022 08:27:54 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Marc MERLIN <marc@merlins.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: figuring out why transient double raid failure caused a fair
 amount of btrfs corruption
Message-ID: <Yk7YyhQ/CdcMfoS7@hungrycats.org>
References: <20220405200805.GD28707@merlins.org>
 <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <YkzWAZtf7rcY/d+7@hungrycats.org>
 <20220406000844.GK28707@merlins.org>
 <Ykzvoz47Rvknw7aH@hungrycats.org>
 <20220406040913.GE3307770@merlins.org>
 <Yk3W88Eyh0pSm9mQ@hungrycats.org>
 <20220406191317.GC14804@merlins.org>
 <20220406203811.GF14804@merlins.org>
 <CAEzrpqdLm+Kwp9AWtPvxEBHXXm3wb_NhGLnhxsAsEXhufstPPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdLm+Kwp9AWtPvxEBHXXm3wb_NhGLnhxsAsEXhufstPPw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 06, 2022 at 04:51:14PM -0400, Josef Bacik wrote:
> On Wed, Apr 6, 2022 at 4:38 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > This is an interesting discussion, so let's make a new thread out of it.
> > TL;DR: I think btrfs may have failed to go read only earlier, causing
> > more damage than needed to be, or some block layers just held enough
> > data in flight that partial data got written, causing more damage than
> > expected.
> > Figuring out the underlying problem would be good to avoid this again.

> We can't do anything about the disks lying to us.  If a disk has a
> wonky FUA/FLUSH implementation then we're just sort of screwed.
> Unfortunately because our metadata moves around a lot we're waaaaay
> more susceptible to this failure case than ext4 or xfs, their metadata
> is relatively static they can put humpty dumpty back together again
> relatively simply.

Disks are pretty good at FUA/FLUSH bugs these days, though you can
still buy new old drives that have them.

SSDs have a whole lot of bugs, especially if they get old. have a few bits
fail, and try to recover themselves, but blow up the whole filesystem
by losing a few pages.  These ones get through firmware qualification
testing because they only misbehave when they're a year or two old.

> Btrfs needs to
> 
> 1. Go whole hog on error injection testing.  I only barely scratched
> the surface with my bpf error injection stuff.  This is on our roadmap
> and I plan on devoting developer time to this, but clearly that
> doesn't help you right now.
> 2. Put a lot more effort into disaster recovery.  What I've written
> for you is an idea I've had in my head for a while.  Some of this
> failures aren't catastrophic, we can generally pretty easily put back
> together a file system that resembles something sane by simply
> stitching together blocks that we find that are close enough to what
> we wanted.  Unfortunately this gets back-burnered because in reality
> this doesn't happen that often.

This does seem to be an important missing piece at the moment.  
In practice, when we see "parent transid verify failed," we go directly
to mkfs + restore backups, as none of the existing tools will touch it.
They all want intact interior nodes in some tree to work, and that's
the one thing that FUA/FLUSH bugs destroy.

It doesn't solve the underlying problem--the drive will still trash
the filesystem every other month until its write ordering gets fixed or
worked around--but at least it lets users fix the filesystem in place
without mkfs + restoring a full set of backups.

> 3. Test these btrfs+dmcrypt+mdraid setups.  Every time I notice one of
> these catastrophic failures it generally involves btrfs+<something
> else>.  This is likely just because it's a timing thing, you put more
> layers you get a wider window in per-io races, you're more likely to
> be sad in the event of a failure.  However it would be good to make
> sure these layers are doing the correct thing themselves.

bcache and dmcache layers in series with the underlying storage multiply
the failure rates (including software regressions) of the individual
components, and mdadm blends firmware bugs from all the drives together.
Statistically we're always going to see more problems if there are more
moving parts in the system, especially if they aggregate risks and break
fault isolation.

FWIW I'm not seeing a difference in failure rate between "btrfs +
mdadm" and "btrfs alone", but I'm intentionally avoiding the many mdadm
configurations that introduce new failure modes by design (e.g. raid5
without ppl or journal, raid1 without component device integrity, or
single/raid1 SSD cache in writeback mode running over multiple drives).
There isn't a fix for those except to not use them.  In most cases
there's a better way to do the same thing, though there are some gaps
(e.g. there's no working solution for writeback SSD caching on raid5).

Thought experiment:  if you have 2 drives from vendor A and 2 drives
from vendor B, and you want to build two filesystems that replicate
to each other, where do you put the drives if you know one vendor has
a firmware bug but you don't know which one?  With mdadm, you build
filesystems with AA and BB drives, because that way a firmware bug
corrupts one filesystems and leaves the other intact.  With btrfs, you
build two filesystems with AB and AB drives, because that way a firmware
bug gets autocorrected by btrfs and both filesystems remain intact.
If you put btrfs on mdadm on AB drives, you combine the risk from both
vendors, lose both filesystems, and skew the failure statistics.

> We need to be better about this scenario, both in making sure we don't
> have bugs that contribute to the problem, but also that we have the
> tools necessary to recover when things go wrong.  Thanks,
> 
> Josef
