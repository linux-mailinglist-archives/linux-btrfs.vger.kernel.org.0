Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D9537A5DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 13:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhEKLjX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 07:39:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:53726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230501AbhEKLjU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 07:39:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9CBDAB114;
        Tue, 11 May 2021 11:38:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5BE7DDA96D; Tue, 11 May 2021 13:35:44 +0200 (CEST)
Date:   Tue, 11 May 2021 13:35:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 3/4] btrfs: submit read time repair only for each
 corrupted sector
Message-ID: <20210511113544.GG7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210503020856.93333-1-wqu@suse.com>
 <20210503020856.93333-4-wqu@suse.com>
 <20210510203203.GD7604@twin.jikos.cz>
 <751b7396-d0fd-d3b2-f14d-e730e6b08222@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <751b7396-d0fd-d3b2-f14d-e730e6b08222@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 11, 2021 at 09:42:30AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/5/11 上午4:32, David Sterba wrote:
> > On Mon, May 03, 2021 at 10:08:55AM +0800, Qu Wenruo wrote:
> >> Currently btrfs_submit_read_repair() has some extra check on whether the
> >> failed bio needs extra validation for repair.
> >>
> >> But we can avoid all these extra mechanism if we submit the repair for
> >> each sector.
> >>
> >> By this, each read repair can be easily handled without the need to
> >> verify which sector is corrupted.
> >>
> >> This will also benefit subpage, as one subpage bvec can contain several
> >> sectors, making the extra verification more complex.
> >>
> >> So this patch will:
> >> - Introduce repair_one_sector()
> >>    The main code submitting repair, which is more or less the same as old
> >>    btrfs_submit_read_repair().
> >>    But this time, it only repair one sector.
> >>
> >> - Make btrfs_submit_read_repair() to handle sectors differently
> >>    For sectors without csum error, just release them like what we did
> >>    in end_bio_extent_readpage().
> >>    Although in this context we don't have process_extent structure, thus
> >>    we have to do extent tree operations sector by sector.
> >>    This is slower, but since it's only in csum mismatch path, it should
> >>    be fine.
> >>
> >>    For sectors with csum error, we submit repair for each sector.
> >>
> >> This patch will focus on the change on the repair path, the extra
> >> validation code is still kept as is, and will be cleaned up later.
> >
> > This leaves btrfs_io_needs_validation unused and compiler warns about
> > that but it gets removed in the next patch so that's ok.
> >
> > I did some minor style fixups
> >
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2706,7 +2706,7 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
> >          struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
> >
> >          ASSERT(page_offset(page) <= start &&
> > -               start + len <= page_offset(page) + PAGE_SIZE);
> > +              start + len <= page_offset(page) + PAGE_SIZE);
> >
> >          if (uptodate) {
> >                  btrfs_page_set_uptodate(fs_info, page, start, len);
> > @@ -2734,7 +2734,7 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
> >   {
> >          struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> >          const u32 sectorsize = fs_info->sectorsize;
> > -       int nr_bits = (end + 1 - start) / sectorsize;
> > +       const int nr_bits = (end + 1 - start) / fs_info->sectorsize_bits;
> 
> It should be >> fs_info->sectorsize_bits;
> 
> Anyway, I'll submit a proper updated version, with your update and
> proper test.

My bad, thanks for catching it.
