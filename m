Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3703814BDCD
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 17:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgA1Qcv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 11:32:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:55160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgA1Qcv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 11:32:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62ADAB15F;
        Tue, 28 Jan 2020 16:32:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 112E2DA730; Tue, 28 Jan 2020 17:32:31 +0100 (CET)
Date:   Tue, 28 Jan 2020 17:32:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: flush write bio if we loop in
 extent_write_cache_pages
Message-ID: <20200128163230.GX3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200123203302.2180124-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123203302.2180124-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 23, 2020 at 03:33:02PM -0500, Josef Bacik wrote:
> There exists a deadlock with range_cyclic that has existed forever.  If
> we loop around with a bio already built we could deadlock with a writer
> who has the page locked that we're attempting to write but is waiting on
> a page in our bio to be written out.  The task traces are as follows
> 
> PID: 1329874  TASK: ffff889ebcdf3800  CPU: 33  COMMAND: "kworker/u113:5"
>  #0 [ffffc900297bb658] __schedule at ffffffff81a4c33f
>  #1 [ffffc900297bb6e0] schedule at ffffffff81a4c6e3
>  #2 [ffffc900297bb6f8] io_schedule at ffffffff81a4ca42
>  #3 [ffffc900297bb708] __lock_page at ffffffff811f145b
>  #4 [ffffc900297bb798] __process_pages_contig at ffffffff814bc502
>  #5 [ffffc900297bb8c8] lock_delalloc_pages at ffffffff814bc684
>  #6 [ffffc900297bb900] find_lock_delalloc_range at ffffffff814be9ff
>  #7 [ffffc900297bb9a0] writepage_delalloc at ffffffff814bebd0
>  #8 [ffffc900297bba18] __extent_writepage at ffffffff814bfbf2
>  #9 [ffffc900297bba98] extent_write_cache_pages at ffffffff814bffbd
> 
> PID: 2167901  TASK: ffff889dc6a59c00  CPU: 14  COMMAND:
> "aio-dio-invalid"
>  #0 [ffffc9003b50bb18] __schedule at ffffffff81a4c33f
>  #1 [ffffc9003b50bba0] schedule at ffffffff81a4c6e3
>  #2 [ffffc9003b50bbb8] io_schedule at ffffffff81a4ca42
>  #3 [ffffc9003b50bbc8] wait_on_page_bit at ffffffff811f24d6
>  #4 [ffffc9003b50bc60] prepare_pages at ffffffff814b05a7
>  #5 [ffffc9003b50bcd8] btrfs_buffered_write at ffffffff814b1359
>  #6 [ffffc9003b50bdb0] btrfs_file_write_iter at ffffffff814b5933
>  #7 [ffffc9003b50be38] new_sync_write at ffffffff8128f6a8
>  #8 [ffffc9003b50bec8] vfs_write at ffffffff81292b9d
>  #9 [ffffc9003b50bf00] ksys_pwrite64 at ffffffff81293032
> 
> I used drgn to find the respective pages we were stuck on
> 
> page_entry.page 0xffffea00fbfc7500 index 8148 bit 15 pid 2167901
> page_entry.page 0xffffea00f9bb7400 index 7680 bit 0 pid 1329874
> 
> As you can see the kworker is waiting for bit 0 (PG_locked) on index
> 7680, and aio-dio-invalid is waiting for bit 15 (PG_writeback) on index
> 8148.  aio-dio-invalid has 7680, and the kworker epd looks like the
> following
> 
> crash> struct extent_page_data ffffc900297bbbb0
> struct extent_page_data {
>   bio = 0xffff889f747ed830,
>   tree = 0xffff889eed6ba448,
>   extent_locked = 0,
>   sync_io = 0
> }
> 
> and using drgn I walked the bio pages looking for page
> 0xffffea00fbfc7500 which is the one we're waiting for writeback on
> 
> bio = Object(prog, 'struct bio', address=0xffff889f747ed830)
> for i in range(0, bio.bi_vcnt.value_()):
>     bv = bio.bi_io_vec[i]
>     if bv.bv_page.value_() == 0xffffea00fbfc7500:
>         print("FOUND IT")
> 
> which validated what I suspected.
> 
> The fix for this is simple, flush the epd before we loop back around to
> the beginning of the file during writeout.
> 
> Fixes: b293f02e1423 ("Btrfs: Add writepages support")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
