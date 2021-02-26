Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132EF32649C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 16:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBZPVU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 10:21:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:38530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhBZPVT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 10:21:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6533EAD57;
        Fri, 26 Feb 2021 15:20:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 37967DA7FF; Fri, 26 Feb 2021 16:18:44 +0100 (CET)
Date:   Fri, 26 Feb 2021 16:18:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Erik Jensen <erikjensen@rkjnsn.net>
Subject: Re: [PATCH] btrfs: do more graceful error/warning for 32bit kernel
Message-ID: <20210226151844.GM7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Erik Jensen <erikjensen@rkjnsn.net>
References: <20210220020633.53400-1-wqu@suse.com>
 <20210224191823.GC1993@twin.jikos.cz>
 <550d771d-f328-8d37-b1a0-1758e683b1ca@gmx.com>
 <20210225153443.GD7604@twin.jikos.cz>
 <47f12020-b3c1-0f05-53c2-6b3230dd6bc8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47f12020-b3c1-0f05-53c2-6b3230dd6bc8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 26, 2021 at 07:43:36AM +0800, Qu Wenruo wrote:
> On 2021/2/25 下午11:34, David Sterba wrote:
> > On Thu, Feb 25, 2021 at 07:44:19AM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2021/2/25 上午3:18, David Sterba wrote:
> >>> On Sat, Feb 20, 2021 at 10:06:33AM +0800, Qu Wenruo wrote:
> >>>> Due to the pagecache limit of 32bit systems, btrfs can't access metadata
> >>>> at or beyond 16T boundary correctly.
> >>>>
> >>>> And unlike other fses, btrfs uses internally mapped u64 address space for
> >>>> all of its metadata, this is more tricky than other fses.
> >>>>
> >>>> Users can have a fs which doesn't have metadata beyond 16T boundary at
> >>>> mount time, but later balance can cause btrfs to create metadata beyond
> >>>> 16T boundary.
> >>>
> >>> As this is for the interhal logical offsets, it should be fixable by
> >>> reusing the range below 16T on 32bit systems. There's some logic relying
> >>> on the highest logical offset and block group flags so this needs to be
> >>> done with some care, but is possible in principle.
> >>
> >> I doubt, as with the dropping price per-GB, user can still have extreme
> >> case where all metadata goes beyond 16T in size.
> >
> > But unlikely on a 32bit machine. And if yes we'll have the warnings in
> > place, as a stop gap.
> >
> >> The proper fix may be multiple metadata address spaces for 32bit
> >> systems, but that would bring extra problems too.
> >>
> >> Finally it doesn't really solve the problem that we don't have enough
> >> test coverage for 32 bit at all.
> >
> > That's true and it'll be worse as distributions drop 32bit builds. There
> > are stil non-intel arches that slowly get the 64bit CPUs but such
> > machines are not likely to have huge storage attached. Vendors of NAS
> > boxes patch their kernels anyway.
> >
> >> So for now I still believe we should just reject and do early warning.
> >
> > I agree.
> >>
> >> [...]
> >>>>
> >>>> +#if BITS_PER_LONG == 32
> >>>> +#define BTRFS_32BIT_EARLY_WARN_THRESHOLD	(10ULL * 1024 * SZ_1G)
> >>
> >> Although the threshold should be calculated based on page size, not a
> >> fixed value.
> >
> > Would it make a difference? I think setting the early warning to 10T
> > sounds reasonable in all cases. IMHO you could keep it as is.
> 
> The problem is page size.
> 
> If we have 64K page size, the file size limit would be 256T, and then
> 10T threshold is definitely too low.

That makes sense but are there 32bit CPUs with 64K pages? Adding the
warning won't cause harm, of course.

So out of curiosity I searched for that cpu/page combo at it is allowed
eg. on MIPS, oh well.
