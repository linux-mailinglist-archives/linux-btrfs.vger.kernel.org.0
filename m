Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350EC355C21
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 21:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbhDFTWj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 15:22:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:35316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhDFTWh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Apr 2021 15:22:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F4C8B33B;
        Tue,  6 Apr 2021 19:22:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 65C80DA732; Tue,  6 Apr 2021 21:20:16 +0200 (CEST)
Date:   Tue, 6 Apr 2021 21:20:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210406192016.GN7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210403110853.GD7604@twin.jikos.cz>
 <aa1c1709-a29b-1c64-1174-b395dd5cd5de@gmx.com>
 <10c3098d-94e3-7cdd-030e-bd4ef5061163@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10c3098d-94e3-7cdd-030e-bd4ef5061163@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 06, 2021 at 10:31:58AM +0800, Anand Jain wrote:
> On 05/04/2021 14:14, Qu Wenruo wrote:
> > 
> > 
> > On 2021/4/3 下午7:08, David Sterba wrote:
> >> On Thu, Mar 25, 2021 at 03:14:32PM +0800, Qu Wenruo wrote:
> >>> This patchset can be fetched from the following github repo, along with
> >>> the full subpage RW support:
> >>> https://github.com/adam900710/linux/tree/subpage
> >>>
> >>> This patchset is for metadata read write support.
> >>
> >>> Qu Wenruo (13):
> >>>    btrfs: add sysfs interface for supported sectorsize
> >>>    btrfs: use min() to replace open-code in btrfs_invalidatepage()
> >>>    btrfs: remove unnecessary variable shadowing in 
> >>> btrfs_invalidatepage()
> >>>    btrfs: refactor how we iterate ordered extent in
> >>>      btrfs_invalidatepage()
> >>>    btrfs: introduce helpers for subpage dirty status
> >>>    btrfs: introduce helpers for subpage writeback status
> >>>    btrfs: allow btree_set_page_dirty() to do more sanity check on 
> >>> subpage
> >>>      metadata
> >>>    btrfs: support subpage metadata csum calculation at write time
> >>>    btrfs: make alloc_extent_buffer() check subpage dirty bitmap
> >>>    btrfs: make the page uptodate assert to be subpage compatible
> >>>    btrfs: make set/clear_extent_buffer_dirty() to be subpage compatible
> >>>    btrfs: make set_btree_ioerr() accept extent buffer and to be subpage
> >>>      compatible
> >>>    btrfs: add subpage overview comments
> >>
> >> Moved from topic branch to misc-next.
> >>
> > 
> > Note sure if it's too late, but I inserted the last comment patch into
> > the wrong location.
> > 
> > In fact, there are 4 more patches to make
> 
> 
> > subpage metadata RW really work:
> 
>   I took some time to go through these patches, which are lined up for
>   integration.
> 
>   With this set of patches that are being integrated, we don't yet
>   support RW mount of filesystem if PAGESIZE > sectorsize as a whole.
>   Subpage metadata RW support, how is it to be used in the production?
>   OR How is this supposed to be tested?

What gets merged to misc-next is incrementally adding support for the
whole subpage feature. This would quite hard to get in in one go so it's
been split to patchsets with known limitations. Qu lists what works and
what does not in the cover letter.

With known missing functionality it obviously can't be used for
production, just for testing. There are likely patches in Qu's
development branches and more patches still to be written, so even the
testing is partial with known failures or bugs.

>   OR should you just cleanup the title as preparatory patches to support
>   subpage RW? It is confusing.

I think the title says what the patchset does, adding rw support for
metadata, in a sense it's still preparatory, yes.
