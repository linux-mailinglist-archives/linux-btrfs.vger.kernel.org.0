Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C1F3017FE
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 20:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbhAWTPh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 14:15:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:52506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbhAWTPd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 14:15:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85868AD18;
        Sat, 23 Jan 2021 19:14:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CFDE3DA823; Sat, 23 Jan 2021 20:13:04 +0100 (CET)
Date:   Sat, 23 Jan 2021 20:13:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 01/18] btrfs: update locked page dirty/writeback/error
 bits in __process_pages_contig()
Message-ID: <20210123191304.GA1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-2-wqu@suse.com>
 <b0360753-072a-f5c5-3ea6-08e9db2445dd@toxicpanda.com>
 <c4bd841c-6657-5a72-85ac-fc8359c87a74@gmx.com>
 <bab806e1-ad3d-b34c-b623-915b39621983@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bab806e1-ad3d-b34c-b623-915b39621983@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 21, 2021 at 02:51:46PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/1/21 下午2:32, Qu Wenruo wrote:
> > 
> > 
> > On 2021/1/20 上午5:41, Josef Bacik wrote:
> >> On 1/16/21 2:15 AM, Qu Wenruo wrote:
> >>> When __process_pages_contig() get called for
> >>> extent_clear_unlock_delalloc(), if we hit the locked page, only Private2
> >>> bit is updated, but dirty/writeback/error bits are all skipped.
> >>>
> >>> There are several call sites call extent_clear_unlock_delalloc() with
> >>> @locked_page and PAGE_CLEAR_DIRTY/PAGE_SET_WRITEBACK/PAGE_END_WRITEBACK
> >>>
> >>> - cow_file_range()
> >>> - run_delalloc_nocow()
> >>> - cow_file_range_async()
> >>>    All for their error handling branches.
> >>>
> >>> For those call sites, since we skip the locked page for
> >>> dirty/error/writeback bit update, the locked page will still have its
> >>> dirty bit remaining.
> >>>
> >>> Thankfully, since all those call sites can only be hit with various
> >>> serious errors, it's pretty hard to hit and shouldn't affect regular
> >>> btrfs operations.
> >>>
> >>> But still, we shouldn't leave the locked_page with its
> >>> dirty/error/writeback bits untouched.
> >>>
> >>> Fix this by only skipping lock/unlock page operations for locked_page.
> >>>
> >>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>
> >> Except this is handled by the callers.  We clear_page_dirty_for_io() the
> >> page before calling btrfs_run_delalloc_range(), so we don't need the
> >> PAGE_CLEAR_DIRTY, it's already cleared.  The SetPageError() is handled
> >> in the error path for locked_page, as is the
> >> set_writeback/end_writeback.  Now I don't think this patch causes
> >> problems specifically, but the changelog is at least wrong, and I'd
> >> rather we'd skip the handling of the locked_page here and leave it in
> >> the proper error handling.  If you need to do this for some other reason
> >> that I haven't gotten to yet then you need to make that clear in the
> >> changelog, because as of right now I don't see why this is needed.  
> >> Thanks,
> > 
> > This is mostly to co-operate with a later patch on
> > __process_pages_contig(), where we need to make sure page locked by
> > __process_pages_contig() is only unlocked by __process_pages_contig() too.
> > 
> > The exception is after cow_file_inline(), we call
> > __process_pages_contig() on the locked page, making it to clear page
> > writeback and unlock it.
> 
> To be more clear, we call extent_clear_unlock_delalloc() with 
> locked_page == NULL, to allow __process_pages_contig() to unlock the 
> locked page (while the locked page isn't locked by 
> __process_pages_contig()).
> 
> For subpage data, we need writers accounting for subpage, but that 
> accounting only happens in __process_pages_contig(), thus we don't want 
> pages without the accounting to be unlocked by __process_pages_contig().
> 
> I can do extra page unlock/clear_dirty/end_writeback just for that 
> exception, but it would definitely needs more comments.

This is patch 1 and other depend on the changed behaviour so if it's
just updated changelog and comments, and Josef is ok with the result, I
can take it but otherwise this could delay the series once the rest is
reworked.
