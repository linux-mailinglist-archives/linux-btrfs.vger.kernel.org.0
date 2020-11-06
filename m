Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BDF2A9DD1
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 20:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgKFTRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 14:17:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:52930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgKFTRt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 14:17:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3C59AF2C;
        Fri,  6 Nov 2020 19:17:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 89704DA6E3; Fri,  6 Nov 2020 20:16:08 +0100 (CET)
Date:   Fri, 6 Nov 2020 20:16:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 14/32] btrfs: inode: make btrfs_readpage_end_io_hook()
 follow sector size
Message-ID: <20201106191608.GU6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-15-wqu@suse.com>
 <ec23422d-e7d9-2886-6c12-8582fa05d968@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec23422d-e7d9-2886-6c12-8582fa05d968@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 05, 2020 at 04:28:12PM +0200, Nikolay Borisov wrote:
> 
> 
> On 3.11.20 г. 15:30 ч., Qu Wenruo wrote:
> > Currently btrfs_readpage_end_io_hook() just pass the whole page to
> > check_data_csum(), which is fine since we only support sectorsize ==
> > PAGE_SIZE.
> > 
> > To support subpage, we need to properly honor per-sector
> > checksum verification, just like what we did in dio read path.
> > 
> > This patch will do the csum verification in a for loop, starts with
> > pg_off == start - page_offset(page), with sectorsize increasement for
> > each loop.
> > 
> > For sectorsize == PAGE_SIZE case, the pg_off will always be 0, and we
> > will only finish with just one loop.
> > 
> > For subpage case, we do the loop to iterate each sector and if we found
> > any error, we return error.
> 
> You refer to btrfs_readpage_end_io_hook but you actually change
> btrfs_verity_data_csum. I guess the changelog needs adjusting.
> 
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  fs/btrfs/inode.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index c54e0ed0b938..0432ca58eade 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -2888,9 +2888,11 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
> >  			   struct page *page, u64 start, u64 end, int mirror)
> >  {
> >  	size_t offset = start - page_offset(page);
> > +	size_t pg_off;
> 
> nit: For offsets we should be using a more self-descriptive type such as
> loff_t

loff_t is meant for file offsets and is an overkill when it's used for
offset in page that's fine with an u32.
