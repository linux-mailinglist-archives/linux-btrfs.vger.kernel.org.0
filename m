Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469EB328478
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 17:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhCAQgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 11:36:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:58188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232491AbhCAQbz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 11:31:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87E82AE07;
        Mon,  1 Mar 2021 16:31:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CD402DA7AA; Mon,  1 Mar 2021 17:29:17 +0100 (CET)
Date:   Mon, 1 Mar 2021 17:29:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/12] btrfs: disk-io: allow btree_set_page_dirty() to do
 more sanity check on subpage metadata
Message-ID: <20210301162917.GX7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210222063357.92930-1-wqu@suse.com>
 <20210222063357.92930-4-wqu@suse.com>
 <im6kr0tz.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <im6kr0tz.fsf@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 22, 2021 at 03:58:00PM +0800, Su Yue wrote:
> 
> On Mon 22 Feb 2021 at 14:33, Qu Wenruo <wqu@suse.com> wrote:
> 
> > For btree_set_page_dirty(), we should also check the extent 
> > buffer
> > sanity for subpage support.
> >
> > Unlike the regular sector size case, since one page can contain 
> > multiple
> > extent buffers, we need to make sure there is at least one dirty 
> > extent
> > buffer in the page.
> >
> > So this patch will iterate through the 
> > btrfs_subpage::dirty_bitmap
> > to get the extent buffers, and check if any dirty extent buffer 
> > in the page
> > range has EXTENT_BUFFER_DIRTY and proper refs.
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  fs/btrfs/disk-io.c | 47 
> >  ++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 41 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index c2576c5fe62e..437e6b2163c7 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -42,6 +42,7 @@
> >  #include "discard.h"
> >  #include "space-info.h"
> >  #include "zoned.h"
> > +#include "subpage.h"
> >
> >  #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
> >  				 BTRFS_HEADER_FLAG_RELOC |\
> > @@ -992,14 +993,48 @@ static void btree_invalidatepage(struct 
> > page *page, unsigned int offset,
> >  static int btree_set_page_dirty(struct page *page)
> >  {
> >  #ifdef DEBUG
> > +	struct btrfs_fs_info *fs_info = 
> > btrfs_sb(page->mapping->host->i_sb);
> > +	struct btrfs_subpage *subpage;
> >  	struct extent_buffer *eb;
> > +	int cur_bit;
> >
> cur_bit is not initialized.

Indeed and it's strange that gcc does not warn about that, either by
default or with W=3.
