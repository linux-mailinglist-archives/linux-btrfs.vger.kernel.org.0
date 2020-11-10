Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B292AD8F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 15:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbgKJOjN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 09:39:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:49780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgKJOjN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 09:39:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D093ABD1;
        Tue, 10 Nov 2020 14:39:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 33AD7DA7D7; Tue, 10 Nov 2020 15:37:31 +0100 (CET)
Date:   Tue, 10 Nov 2020 15:37:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 12/32] btrfs: disk-io: extract the extent buffer
 verification from btrfs_validate_metadata_buffer()
Message-ID: <20201110143730.GI6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-13-wqu@suse.com>
 <15477e44-e15d-9b8b-634a-d300d3c82d84@suse.com>
 <20201106190346.GT6756@twin.jikos.cz>
 <bcbd0b74-b433-03a9-5bfe-2f365625c6f3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcbd0b74-b433-03a9-5bfe-2f365625c6f3@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 09, 2020 at 02:44:54PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/11/7 上午3:03, David Sterba wrote:
> > On Thu, Nov 05, 2020 at 03:57:14PM +0200, Nikolay Borisov wrote:
> >>> +int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
> >>> +				   struct page *page, u64 start, u64 end,
> >>> +				   int mirror)
> >>> +{
> >>> +	struct extent_buffer *eb;
> >>> +	int ret = 0;
> >>> +	int reads_done;
> >>> +
> >>> +	if (!page->private)
> >>> +		goto out;
> >>> +
> >>
> >> nit:I think this is redundant since metadata pages always have their eb
> >> attached at ->private.
> >
> > We could have an assert here instead.
> 
> Yes, we can do that for now.
> 
> But later patches, like "implement subpage metadata read and its endio
> function" would make subpage page->private initialized to 0 as we no
> longer rely on page->private any more.
> 
> This means we will add the assert() just for several commits, then
> remove it again.

Yes, this is safer so we have the assert in code where it applies. Also
this patchset is being merged incrementally mixed with other patchsets
so it's not just a few commits.
