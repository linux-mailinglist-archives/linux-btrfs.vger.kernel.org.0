Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD64D38008D
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 00:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhEMW5w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 18:57:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhEMW5v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 18:57:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E76EAEAA;
        Thu, 13 May 2021 22:56:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EBFB9DA8EB; Fri, 14 May 2021 00:54:09 +0200 (CEST)
Date:   Fri, 14 May 2021 00:54:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
Message-ID: <20210513225409.GL7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210512221821.GB7604@twin.jikos.cz>
 <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
 <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 13, 2021 at 10:21:24AM +0800, Qu Wenruo wrote:
> >> Do you think the patches 1-13 are safe to be merged independently? I've
> >> paged through the whole patchset and some of the patches are obviously
> >> preparatory stuff so they can go in without much risk.
> >
> > Yes. I believe they are OK for merge.
> >
> > I have run the full tests on x86 VM for the whole patchset, no new
> > regression.
> >
> > Especially patch 03~05 would benefit 4K page size the most, thus merging
> > them first would definitely help.
> >
> > Just let me to run the tests with patch 1~13 only, to see if there is
> > any special dependency missing.
> 
> Yep, patch 1~13 with the v5 read time repair patches are safe for x86.
> 
> So they should be fine for the next merge window.
> >>
> >> I haven't looked at your git if there are updates from what was posted,
> >> but I don't expect any significant changes, but what I saw looked ok to
> >> me.
> >
> > I haven't touched those patches since v2 submission, thus there
> > shouldn't be any modification to them.
> > (At most some cosmetic change for the commit message/comments)
> >>
> >> If there are changes, please post 1-13 (ie. all the preparatory
> >> patches), I'll put them to misc-next so you can focus on the rest.

I did another pass and found a few unimportant style fixes, it's now
pushed to branch ext/qu/subpage-prep-13. I'll run tests before merging
it to misc-next, the cleanups are great, some changes scare me a bit
though. Handling the ordered extents gets changed a bit, nothing
obviously wrong but based on past experience there are some subtle bugs
lurking.

The plan is to add the branch to misc-next soon so we have enough time
to test it. I'll reply to the individual patches with comments that
stand out among the trivialities.
