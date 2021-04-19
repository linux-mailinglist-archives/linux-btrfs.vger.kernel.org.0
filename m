Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC63364AA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 21:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbhDSThJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 15:37:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:46900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239423AbhDSThI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 15:37:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B3E9B020;
        Mon, 19 Apr 2021 19:36:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F08AFDA732; Mon, 19 Apr 2021 21:34:18 +0200 (CEST)
Date:   Mon, 19 Apr 2021 21:34:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: remove the inode_need_compress() call in
Message-ID: <20210419193418.GU7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200804072548.34001-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804072548.34001-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 04, 2020 at 03:25:46PM +0800, Qu Wenruo wrote:
> This is an attempt to remove the inode_need_compress() call in
> compress_file_extent().
> 
> As that compress_file_extent() can race with inode ioctl or bad
> compression ratio, to cause NULL pointer dereferecen for @pages, it's
> nature to try to remove that inode_need_compress() to remove the race
> completely.
> 
> However that's not that easy, we have the following problems:
> 
> - We still need to check @pages anyway
>   That @pages check is for kcalloc() failure, so what we really get is
>   just removing one indent from the if (inode_need_compress()).
>   Everything else is still the same (in fact, even worse, see below
>   problems)
> 
> - Behavior change
>   Before that change, every async_chunk does their check on
>   INODE_NO_COMPRESS flags.
>   If we hit any bad compression ratio, all incoming async_chunk will
>   fall back to plain text write.
> 
>   But if we remove that inode_need_compress() check, then we still try
>   to compress, and lead to potentially wasted CPU times.
> 
> - Still race between compression disable and NULL pointer dereferecen
>   There is a hidden race, mostly exposed by btrfs/071 test case, that we
>   have "compress_type = fs_info->compress_type", so we can still hit case
>   where that compress_type is NONE (caused by remount -o nocompress), and
>   then btrfs_compress_pages() will return -E2BIG, without modifying
>   @nr_pages
> 
>   Then later when we cleanup @pages, we try to access pages[i]->mapping,
>   triggering NULL pointer dereference.
> 
>   This will be address in the first patch though.
> 
> Changelog:
> v2:
> - Fix a bad commit merge
>   Which merges the commit message for the first patch, though the content is
>   still correct.
> 
> Qu Wenruo (2):
>   btrfs: prevent NULL pointer dereference in compress_file_range() when
>     btrfs_compress_pages() hits default case

Patch 1 added to misc-next, due to this bug report
https://bugzilla.kernel.org/show_bug.cgi?id=212331
