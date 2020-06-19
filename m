Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D96200998
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 15:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbgFSNLb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 09:11:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:52812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731801AbgFSNL3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 09:11:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 277D8AFC1;
        Fri, 19 Jun 2020 13:11:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45091DA9B9; Fri, 19 Jun 2020 15:11:17 +0200 (CEST)
Date:   Fri, 19 Jun 2020 15:11:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     DanglingPointer <danglingpointerexception@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: btrfs-dedupe broken and unsupported but in official wiki
Message-ID: <20200619131117.GD27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        DanglingPointer <danglingpointerexception@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
 <20200618204317.GM10769@hungrycats.org>
 <65eeb90a-e983-2ae8-14ad-79bcd2960851@gmail.com>
 <20200619050402.GN10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200619050402.GN10769@hungrycats.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 19, 2020 at 01:04:03AM -0400, Zygo Blaxell wrote:
> It might be nice to keep btrfs-dedupe and bedup _somewhere_ on the wiki,
> clearly marked as not supported and only of historical interest to new
> developers.  I learned a lot about what is possible on btrfs from bedup
> in particular (bees was initially a project to combine the features of
> bedup and duperemove), and python is accessible to more developers than
> C or C++.  btrfs-dedupe was the first btrfs dedupe agent to combine
> defrag and dedupe operations into a single program.

It's there now.

> > So I do agree with waxhead.  It would be preferable if there were an
> > official btrfs deduplication command from btrfs-progs instead of relying on
> > 3rd parties.  Joe Bloggs example above can read a web-page instructions
> > saying "run this command... and then this command..."; but he will not have
> > the knowledge, nor comprehension nor time to go through code.
> 
> Which of the available candidates for "official btrfs dedupe" would you
> put in btrfs-progs?  I see a lot of runners in the race, but no clear
> winner yet.
> 
> duperemove is the closest to Waxhead's proposed "-r /somewhere" syntax.
> It's the obvious choice:  written in the same language as btrfs-progs, and
> also the oldest btrfs deduper, and it has years of patient, data-driven
> optimization built in.

That there's not even a simple eg. file-based deduper available in
btrfs-progs is kind of bad. Duperemove is indeed closest to that.

> If there wasn't some insurmountable reason
> why duperemove can't be merged with btrfs-progs, then it would have
> happened already, so there must be a reason why this can't ever happen
> (which might be as simple as neither maintainer wants to merge).

I'm not against adding the functionality to btrfs-progs, but merging
whole duperemove feature set might not happen due to additional
dependencies. This would need to be evaluated, but I'm not aware of any
other technical reasons.

I don't remember exactly why duperemove started as a separate project
instead of a subcommand or progs, but we can revisit that.

> Maybe we put duperemove at the top of the Wiki page, as it has the
> simplest command-line for Joe Blogger's use case, and it's relatively
> easy to build for the few people who use distros where it's not packaged.

That's a good idea, a 'quick start' section, with description of most
common usecases using duperemove.

> The stub support for in-kernel dedupe (arguably the only "official"
> btrfs dedupe so far) has been removed due to lack of interest in its
> development.  That _was_ available in branches of btrfs-progs
> as 'btrfs dedupe'.  It's gone now.

The more I think about in-band dedupe (and how it would complicate
everything), I'm leaning more towards a user-space solution with support
from kernel (ioctls, keeping hashes of recently modified blocks but not
doing the actual deduplication, reading hashes from csum tree, etc).
