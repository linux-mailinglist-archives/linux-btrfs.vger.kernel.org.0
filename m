Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3578932847E
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 17:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhCAQhG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 11:37:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:59166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233299AbhCAQdY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 11:33:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91D7EAE3C;
        Mon,  1 Mar 2021 16:32:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10AE9DA7AA; Mon,  1 Mar 2021 17:30:46 +0100 (CET)
Date:   Mon, 1 Mar 2021 17:30:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: support read-write for subpage metadata
Message-ID: <20210301163045.GY7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210222063357.92930-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222063357.92930-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 22, 2021 at 02:33:45PM +0800, Qu Wenruo wrote:
> This patchset can be fetched from the following github repo, along with
> the full subpage RW support:
> https://github.com/adam900710/linux/tree/subpage
> 
> This patchset is for metadata read write support.
> 
> [TEST]
> Since the data write path is not included in this patchset, we can't
> really test it, but during the lunar new year vocation, I have tested
> the full RW patchset with "fstresss -n 10000 -p2" on my Aarch64 board.
> 
> And the full RW patchset survives without any crash for a full week.
> 
> There is only one remaining bug exposed during the test, that we have
> random data checksum mismatch, which is still under investigation.
> 
> But the metadata part should be OK for submission.
> 
> [DIFFERENCE AGAINST REGULAR SECTORSIZE]
> The metadata part in fact has more new code than data part, as it has
> some different behaviors compared to the regular sector size handling:
> 
> - No more page locking
>   Now metadata read/write relies on extent io tree locking, other than
>   page locking.
>   This is to allow behaviors like read lock one eb while also try to
>   read lock another eb in the same page.
>   We can't rely on page lock as now we have multiple extent buffers in
>   the same page.
> 
> - Page status update
>   Now we use subpage wrappers to handle page status update.
> 
> - How to submit dirty extent buffers
>   Instead of just grabbing extent buffer from page::private, we need to
>   iterate all dirty extent buffers in the page and submit them.
> 
> Qu Wenruo (12):
>   btrfs: subpage: introduce helper for subpage dirty status
>   btrfs: subpage: introduce helper for subpage writeback status
>   btrfs: disk-io: allow btree_set_page_dirty() to do more sanity check
>     on subpage metadata
>   btrfs: disk-io: support subpage metadata csum calculation at write
>     time
>   btrfs: extent_io: make alloc_extent_buffer() check subpage dirty
>     bitmap
>   btrfs: extent_io: make the page uptodate assert check to handle
>     subpage
>   btrfs: extent_io: make set/clear_extent_buffer_dirty() to support
>     subpage sized metadata
>   btrfs: extent_io: make set_btree_ioerr() accept extent buffer and
>     handle subpage metadata
>   btrfs: extent_io: introduce end_bio_subpage_eb_writepage() function
>   btrfs: extent_io: introduce write_one_subpage_eb() function
>   btrfs: extent_io: make lock_extent_buffer_for_io() to support subpage
>     metadata
>   btrfs: extent_io: introduce submit_eb_subpage() to submit a subpage
>     metadata page

Please don't use "extent_io" nor "disk-io" in subjects.
