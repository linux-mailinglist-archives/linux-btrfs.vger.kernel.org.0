Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD22F2B55B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Nov 2020 01:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbgKQA0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 19:26:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:37940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbgKQA0M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 19:26:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3DA3AD29;
        Tue, 17 Nov 2020 00:26:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EA591DA6E3; Tue, 17 Nov 2020 01:24:25 +0100 (CET)
Date:   Tue, 17 Nov 2020 01:24:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 10/24] btrfs: introduce a helper to determine if the
 sectorsize is smaller than PAGE_SIZE
Message-ID: <20201117002425.GW6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-11-wqu@suse.com>
 <20201116225129.GU6756@twin.jikos.cz>
 <4094ac4c-1755-8ba1-81be-6bfa5e3b24fd@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4094ac4c-1755-8ba1-81be-6bfa5e3b24fd@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 17, 2020 at 07:50:48AM +0800, Qu Wenruo wrote:
> On 2020/11/17 上午6:51, David Sterba wrote:
> > On Fri, Nov 13, 2020 at 08:51:35PM +0800, Qu Wenruo wrote:
> >> Just to save us several letters for the incoming patches.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>  fs/btrfs/ctree.h | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> >> index 99955b6bfc62..93de6134c65c 100644
> >> --- a/fs/btrfs/ctree.h
> >> +++ b/fs/btrfs/ctree.h
> >> @@ -3660,6 +3660,11 @@ static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
> >>  	return signal_pending(current);
> >>  }
> >>  
> >> +static inline bool btrfs_is_subpage(struct btrfs_fs_info *fs_info)
> >> +{
> >> +	return (fs_info->sectorsize < PAGE_SIZE);
> > 
> > I'm not convinced we want to obscure the simple check, saving a few
> > letters does not sound like a compelling argument. Nothing wrong to have
> > 'sectorsize < PAGE_SIZE' in conditions.
> > 
> OK, I can go without the helper.
> 
> But there are more things like:
> 
> struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
> 
> Should we use a helper or just above line?

That's ok and we can clean it up later, the pointer chain is used in
several places so that's not an uncommon pattern and if we want to use
something compact then it's better to do that all at once.

> Since we're here, allow me to ask for some advice on how to refactor
> some code.
> 
> Another question is in my current RW branch.
> We will have quite some calls like:
> 
> spin_lock(&subpage->lock);
> bitmap_set(subpage->uptodate_bitmap, bit_start, nbits);
> if (bitmap_full(subpage->uptodate_bitmap, BTRFS_SUBPAGE_BITMAP_SIZE))
> 	SetPageUptodate(page);
> spin_unlock(&subpage->lock);
> 
> The call sites are not that many, <=5, but there are several different
> combinations, e.g. for endio we want to use irqsave version of spinlock.
> 
> For data write, we want to convert bits in dirty_bitmap to
> writeback_bitmap, and re-check page status.
> 
> Should I introduce some helpers for that too?

I haven't seen the code but from what you say I think it could be hard
to have one common helper for all the cases. I can give you another
oppinion after I see the actual patch so if the code follows a pattern
lock/update bitmap/check/nulock I think it's ok.
