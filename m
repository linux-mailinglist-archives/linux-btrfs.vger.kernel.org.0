Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00093064AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 21:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhA0UB5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 15:01:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:54202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232539AbhA0UAl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 15:00:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B80EACBA;
        Wed, 27 Jan 2021 19:59:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A813FDA84C; Wed, 27 Jan 2021 20:58:04 +0100 (CET)
Date:   Wed, 27 Jan 2021 20:58:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 04/18] btrfs: make attach_extent_buffer_page() to
 handle subpage case
Message-ID: <20210127195804.GF1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-5-wqu@suse.com>
 <5a6223fc-9937-3bd6-ecd0-d6c5939f59a7@toxicpanda.com>
 <20210119223518.GS6430@twin.jikos.cz>
 <3ec1e4e4-c154-309d-5a75-cba85a20fd9c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ec1e4e4-c154-309d-5a75-cba85a20fd9c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 26, 2021 at 03:29:17PM +0800, Qu Wenruo wrote:
> On 2021/1/20 上午6:35, David Sterba wrote:
> > On Tue, Jan 19, 2021 at 04:54:28PM -0500, Josef Bacik wrote:
> >> On 1/16/21 2:15 AM, Qu Wenruo wrote:
> >>> +/* For rare cases where we need to pre-allocate a btrfs_subpage structure */
> >>> +static inline int btrfs_alloc_subpage(struct btrfs_fs_info *fs_info,
> >>> +				      struct btrfs_subpage **ret)
> >>> +{
> >>> +	if (fs_info->sectorsize == PAGE_SIZE)
> >>> +		return 0;
> >>> +
> >>> +	*ret = kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
> >>> +	if (!*ret)
> >>> +		return -ENOMEM;
> >>> +	return 0;
> >>> +}
> >>
> >> We're allocating these for every metadata page, that deserves a dedicated
> >> kmem_cache.  Thanks,
> >
> > I'm not opposed to that idea but for the first implementation I'm ok
> > with using the default slabs. As the subpage support depends on the
> > filesystem, creating the cache unconditionally would waste resources and
> > creating it on demand would need some care. Either way I'd rather see it
> > in a separate patch.
> >
> Well, too late for me to see this comment...
> 
> As I have already converted to kmem cache.
> 
> But the good news is, the latest version has extra refactor on memory
> allocation/freeing, now we just need to change two lines to change how
> we allocate memory for subpage.
> (Although still need to remove the cache allocation code).
> 
> Will convert it back to default slab, but will also keep the refactor
> there to make it easier for later convert to kmem_cache.
> 
> So don't be too surprised to see function like in next version.
> 
>    btrfs_free_subpage(struct btrfs_subpage *subpage)
>    {
> 	kfree(subpage);
>    }

I hoped to save you time converting it to the kmem slabs so no need to
revert it back to kmalloc, keep what you have. Switching with the helper
would be easier should we need to reconsider it for some reason.
