Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFF019B547
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 20:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbgDASU7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 14:20:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:34980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732316AbgDASU7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 14:20:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7544AC0C;
        Wed,  1 Apr 2020 18:20:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BCCBADA727; Wed,  1 Apr 2020 20:20:21 +0200 (CEST)
Date:   Wed, 1 Apr 2020 20:20:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kreijack@inwind.it
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: add warning for mixed profiles filesystem
Message-ID: <20200401182021.GY5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kreijack@inwind.it,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Graham Cobb <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>
References: <20200331191045.8991-1-kreijack@libero.it>
 <97ec9f13-8d8d-1df9-f725-44a2a0ecc438@cobb.uk.net>
 <20200331220534.GI2693@hungrycats.org>
 <6bd78420-f630-19af-076f-1a2b4bf89aa2@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bd78420-f630-19af-076f-1a2b4bf89aa2@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 01, 2020 at 07:15:19PM +0200, Goffredo Baroncelli wrote:
> On 4/1/20 12:05 AM, Zygo Blaxell wrote:
> > On Tue, Mar 31, 2020 at 10:46:17PM +0100, Graham Cobb wrote:
> >> On 31/03/2020 20:10, Goffredo Baroncelli wrote:
> >>> WARNING: ------------------------------------------------------
> >>> WARNING: Detection of multiple profiles for a block group type:
> >>> WARNING:
> >>> WARNING: * DATA ->          [raid1c3, single]
> >>> WARNING: * METADATA ->      [raid1, single]
> >>> WARNING:
> >>> WARNING: Please consider using 'btrfs balance ...' commands set
> >>> WARNING: to solve this issue.
> >>> WARNING: ------------------------------------------------------
> >>
> >> The check is a good a idea but I think the warning is too strong. I
> >> would prefer that the word "Warning" is reserved for cases and
> >> operations that may actually damage data (such as reformating a
> >> filesystem). [Note: in a previous job, my employer decided that the word
> >> Warning was ONLY to be used if there was a risk of harm to a human - for
> >> example, electrical safety]
> 
> In some fields, like medical devices, terms "warning", "caution", "notice"
> are strictly regulated; and your employer is right: warning is
> required only when an human harm could happen.
> 
> In btrfs however, the rules are a bit relaxed; so we have only ERROR (fatal)
> and Warning (which is more like caution).
> 
> However I think that an unexpected profile is to be considered a severe fault.

I agree with the 'unexpected' part and as I read the other feedback, but
the mixed profiles do not emerge out of nowhere. It requires a balance
operation and that it changes the filesystem layout I consider expected.

> I.e. you could have a RAID5 instead of a RAID1, where the former is more
> fragile than the latter.
> Moreover I suspect that a lot of problems reported on mailing list born from
> a mixed profile filesystem...

Do you have an example? Converting between some priofiles is tricky, eg.
when the striped ones need enough space on all devices, unlike mirrored
that need that on 2/3/4 devices. But that's not something I feel is
related to lack of the warning.

> >> Also, btrfs fi usage is something that I routinely run continuously in a
> >> window (using watch) when a remove/replace/balance operation is in
> > 
> > I was going to say please put all the new output lines at the bottom,
> 
> The added lines are the last ones. Do you mean top ?
> 
> > so that 'watch' windows can be minimally sized without having to write
> > something like
> > 
> > 	watch 'btrfs fi usage /foo | sed -e "g/WARNING:/d"'
> > 
> > People with short terminal windows running btrfs fi usage directly from
> > the command line would probably complain about extra lines at the bottom...
> > 
> > Another good idea here would be a --quiet switch, or
> > '--no-profile-warning'.
> 
> I think that having a global switch like '--no-profile-warning' is a good thing.
> 
> > 
> >> progress to monitor at a glance what is happening - I don't want to
> >> waste all that space on the screen. To say nothing of the annoyance of
> >> having it shouting at me for weeks on end while **I AM TRYING TO FIX THE
> >> DAMN PROBLEM!**.
> >>
> >> I would suggest a more compact layout and factual tone. Something like:
> >>
> >> Caution: This filesystem has multiple profiles for a block group type
> >> so new block groups will have unpredictable profiles.
> >>   * DATA ->          [raid1c3, single]
> >>   * METADATA ->      [raid1, single]
> >> Use of 'btrfs balance' is recommended as soon as possible to move all
> >> blocks to a single profile for each of data and metadata.
> > 
> > How about a one-liner:
> > 
> > 	NOTE: Multiple profiles detected.  See 'man btrfs-filesystem'.
> 
> 
> WARNING: Multiple profiles detected.  See 'man btrfs-filesystem'.
> WARNING: data -> [raid1c3, single], metadata -> [raid1, single]
> 
> I think that the one above could be a good compromise.

I agree, though I'd prefer only the reference to manual page with enough
examples and commandds to see what it means and what to do next.

The output style of the tools I generally try to maintain is to provide
building blocks or combining information from various sources together,
not necessarily a tool that comes with warning everywhere a first time
user can be surprised.

> I am thinking also to combine '--no-profile-warning' and '--verbose' to have
> three different warning level (--no-profile-warning -> no warning at all, nothing
> -> small warning, --verbose -> "giant" warning).

That sounds like an overkill to me, the option is too long and I think
slightly experienced users would have to use it all the time. If we
could find commands where the warning makes most sense, like right
before or after balance, then it's fine to add it to the output. But for
'fi df' or 'fi us' it's IMHO inappropriate.

This is all usability tuning, so I'm open to discussion or
disagreements, we'll find some solution.
