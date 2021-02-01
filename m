Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E92D30ABE5
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 16:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhBAPtw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 10:49:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:53002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhBAPtk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 10:49:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A735AB92;
        Mon,  1 Feb 2021 15:49:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 848CDDA6FC; Mon,  1 Feb 2021 16:47:10 +0100 (CET)
Date:   Mon, 1 Feb 2021 16:47:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v5 17/18] btrfs: integrate page status update for data
 read path into begin/end_page_read()
Message-ID: <20210201154710.GR1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-18-wqu@suse.com>
 <dd190a49-9c70-c6a5-1c2d-896d290c1a76@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd190a49-9c70-c6a5-1c2d-896d290c1a76@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 12:13:27PM -0500, Josef Bacik wrote:
> On 1/26/21 3:34 AM, Qu Wenruo wrote:
> > @@ -3263,6 +3277,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
> >   		      unsigned int read_flags, u64 *prev_em_start)
> >   {
> >   	struct inode *inode = page->mapping->host;
> > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> >   	u64 start = page_offset(page);
> >   	const u64 end = start + PAGE_SIZE - 1;
> >   	u64 cur = start;
> > @@ -3306,6 +3321,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
> >   			kunmap_atomic(userpage);
> >   		}
> >   	}
> 
> You have two error cases above this
> 
>          ret = set_page_extent_mapped(page);
>          if (ret < 0) {
>                  unlock_extent(tree, start, end);
>                  SetPageError(page);
>                  goto out;
>          }
> 
> and
> 
>          if (!PageUptodate(page)) {
>                  if (cleancache_get_page(page) == 0) {
>                          BUG_ON(blocksize != PAGE_SIZE);
>                          unlock_extent(tree, start, end);
>                          goto out;
>                  }
>          }
> 
> which will now leave the page locked when it errors out.  Not to mention I'm 
> pretty sure you want to use btrfs_page_set_error() instead of SetPageError() in 
> that first case.

Qu, please send a fixed version, just this patch, thanks.
