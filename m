Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234B02AD8DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 15:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbgKJOfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 09:35:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:44464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgKJOfW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 09:35:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BD4EABCC;
        Tue, 10 Nov 2020 14:35:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3CD35DA7D7; Tue, 10 Nov 2020 15:33:40 +0100 (CET)
Date:   Tue, 10 Nov 2020 15:33:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 11/32] btrfs: disk-io: make csum_tree_block() handle
 sectorsize smaller than page size
Message-ID: <20201110143339.GH6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-12-wqu@suse.com>
 <20201106185836.GS6756@twin.jikos.cz>
 <746bb53e-8a71-67a0-6d93-7c6e126670ea@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <746bb53e-8a71-67a0-6d93-7c6e126670ea@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 07, 2020 at 08:04:44AM +0800, Qu Wenruo wrote:
> >> --- a/fs/btrfs/disk-io.c
> >> +++ b/fs/btrfs/disk-io.c
> >> @@ -211,16 +211,16 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
> >>  static void csum_tree_block(struct extent_buffer *buf, u8 *result)
> >>  {
> >>  	struct btrfs_fs_info *fs_info = buf->fs_info;
> >> -	const int num_pages = fs_info->nodesize >> PAGE_SHIFT;
> >> +	const int num_pages = DIV_ROUND_UP(fs_info->nodesize, PAGE_SIZE);
> >
> > No, this is not necessary and the previous way of counting pages should
> > stay as it's clear what is calculated. The rounding side effects make it
> > too subtle.  If sectorsize < page size, then num_pages is 0 but checksum
> > of the first page or it's part is done unconditionally.
> 
> You mean keep num_pages to be 0, since pages[0] will also be checksumed
> unconditionally?
> 
> This doesn't sound sane. It's too tricky and hammer the readability.

I don't find it tricky,

- num_pages = fs_info->nodesize >> PAGE_SHIFT
- checksum relevant part of the first page unconditionally
- for (i = 1; i < num_pages) this obviously skips the first page
  so it's either 0 or 1 in num_pages

So this does not break the top-down reading flow.
