Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59CE3813C0
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 May 2021 00:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhENW2w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 18:28:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:34338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhENW2v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 18:28:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCE50AFEA;
        Fri, 14 May 2021 22:27:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE698DAF1B; Sat, 15 May 2021 00:25:07 +0200 (CEST)
Date:   Sat, 15 May 2021 00:25:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
Message-ID: <20210514222507.GA7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210512221821.GB7604@twin.jikos.cz>
 <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
 <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
 <20210514113040.GV7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210514113040.GV7604@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 14, 2021 at 01:30:40PM +0200, David Sterba wrote:
> On Thu, May 13, 2021 at 10:21:24AM +0800, Qu Wenruo wrote:
> > > On 2021/5/13 上午6:18, David Sterba wrote:
> > >> On Wed, Apr 28, 2021 at 07:03:07AM +0800, Qu Wenruo wrote:
> > >>> === Patchset structure ===
> > >>>
> > >>> Patch 01~02:    hardcoded PAGE_SIZE related fixes
> > >>> Patch 03~05:    submit_extent_page() refactor which will reduce overhead
> > >>>         for write path.
> > >>>         This should benefit 4K page the most. Although the
> > >>>         primary objective is just to make the code easier to
> > >>>         read.
> > >>> Patch 06:    Cleanup for metadata writepath, to reduce the impact on
> > >>>         regular sectorsize path.
> > >>> Patch 07~13:    PagePrivate2 and ordered extent related refactor.
> > >>>         Although it's still a refactor, the refactor is pretty
> > >>>         important for subpage data write path, as for subpage we
> > >>>         could have btrfs_writepage_endio_finish_ordered() call
> > >>>         across several sectors, which may or may not have
> > >>>         ordered extent for those sectors.
> > >>>
> > >>> ^^^ Above patches are all subpage data write preparation ^^^
> > >>
> > >> Do you think the patches 1-13 are safe to be merged independently? I've
> > >> paged through the whole patchset and some of the patches are obviously
> > >> preparatory stuff so they can go in without much risk.
> > >
> > > Yes. I believe they are OK for merge.
> > >
> > > I have run the full tests on x86 VM for the whole patchset, no new
> > > regression.
> > >
> > > Especially patch 03~05 would benefit 4K page size the most, thus merging
> > > them first would definitely help.
> > >
> > > Just let me to run the tests with patch 1~13 only, to see if there is
> > > any special dependency missing.
> > 
> > Yep, patch 1~13 with the v5 read time repair patches are safe for x86.
> 
> All fine up to generic/521 that got stuck. It looks like some use after
> free, check the 2nd line of the dump, there's the 0x6b6b signature

On the same VM it did not appear for 2-3 runs, but now I see it on a
different one, so it's not deterministic. The error is the same.
