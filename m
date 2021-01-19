Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A672FC3EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 23:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbhASWkS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 17:40:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:53652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbhASWiV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 17:38:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE483AB7A;
        Tue, 19 Jan 2021 22:37:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1F4D9DA6E3; Tue, 19 Jan 2021 23:35:19 +0100 (CET)
Date:   Tue, 19 Jan 2021 23:35:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 04/18] btrfs: make attach_extent_buffer_page() to
 handle subpage case
Message-ID: <20210119223518.GS6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-5-wqu@suse.com>
 <5a6223fc-9937-3bd6-ecd0-d6c5939f59a7@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a6223fc-9937-3bd6-ecd0-d6c5939f59a7@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 19, 2021 at 04:54:28PM -0500, Josef Bacik wrote:
> On 1/16/21 2:15 AM, Qu Wenruo wrote:
> > +/* For rare cases where we need to pre-allocate a btrfs_subpage structure */
> > +static inline int btrfs_alloc_subpage(struct btrfs_fs_info *fs_info,
> > +				      struct btrfs_subpage **ret)
> > +{
> > +	if (fs_info->sectorsize == PAGE_SIZE)
> > +		return 0;
> > +
> > +	*ret = kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
> > +	if (!*ret)
> > +		return -ENOMEM;
> > +	return 0;
> > +}
> 
> We're allocating these for every metadata page, that deserves a dedicated 
> kmem_cache.  Thanks,

I'm not opposed to that idea but for the first implementation I'm ok
with using the default slabs. As the subpage support depends on the
filesystem, creating the cache unconditionally would waste resources and
creating it on demand would need some care. Either way I'd rather see it
in a separate patch.
