Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC598DF1E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 17:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfJUPpo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 11:45:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:52046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfJUPpn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 11:45:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD2F6AEBE;
        Mon, 21 Oct 2019 15:45:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9C85DA733; Mon, 21 Oct 2019 17:45:54 +0200 (CEST)
Date:   Mon, 21 Oct 2019 17:45:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/10] btrfs-progs: image: Enhancement with new data
 dump feature
Message-ID: <20191021154554.GQ3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190925121356.118038-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925121356.118038-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 25, 2019 at 08:13:46PM +0800, Qu Wenruo wrote:
> This patchset includes the following features:
> 
> - Small fixes to improve btrfs-image error report
>   * Output error message for chunk tree build error
>   * Fix error output to show correct return value
>   Patch 1 and 2.
> 
> - Reduce memory usage when decompress super block
>   Independent change, for current btrfs-image, it will reduce buffer
>   size from 256K to fixed 4K.
>   Patch 3.
> 
> - Rework how we search chunk tree blocks
>   Instead of iterating clusters again and again for each chunk tree
>   block, record system chunk array and iterate clusters once for all
>   chunk tree blocks.
>   This should reduce restore time for large image dump.
>   Patch 4, 5 and 6.
> 
> - Introduce data dump feature to dump the whole fs.
>   This will introduce a new magic number to prevent old btrfs-image to
>   hit failure as the item size limit is enlarged.
>   Patch 7 and 8.
> 
> - Reduce memory usage for data dump restore
>   This is mostly due to the fact that we have much larger
>   max_pending_size introduced by data dump(256K -> 256M).
>   Using 4 * max_pending_size for each decompress thread as buffer is way
>   too expensive now.
>   Use proper inflate() to replace uncompress() calls.
>   Patch 9 and 10.
> 
> Changelog:
> v2:
> - New small fixes:
>   * Fix a confusing error message due to unpopulated errno
>   * Output error message for chunk tree build error
>   
> - Fix a regression of previous version
>   Patch "btrfs-progs: image: Rework how we search chunk tree blocks"
>   deleted a "ret = 0" line which could cause false early exit.
> 
> - Reduce memory usage for data dump
> 
> v2.1:
> - Rebased to devel branch
>   Removing 4 already merged patches from the patchset.
> 
> - Re-order the patchset
>   Put small and independent patches at the top of queue, and put the
>   data dump related feature at the end.
> 
> - Fix -Wmaybe-uninitialized warnings
>   Strangely, D=1 won't trigger these warnings thus they sneak into v2
>   without being detected.
> 
> - Fix FROM: line
>   Reverted to old smtp setup. The new setup will override FROM: line,
>   messing up the name of author.
> 
> v3:
> - Fix a wrong option in error string
> - Fix a bug that we always dump data extents
> 
> Qu Wenruo (10):
>   btrfs-progs: image: Output error message for chunk tree build error
>   btrfs-progs: image: Fix error output to show correct return value
>   btrfs-progs: image: Don't waste memory when we're just extracting
>     super block
>   btrfs-progs: image: Allow restore to record system chunk ranges for
>     later usage
>   btrfs-progs: image: Introduce helper to determine if a tree block is
>     in the range of system chunks
>   btrfs-progs: image: Rework how we search chunk tree blocks
>   btrfs-progs: image: Introduce framework for more dump versions
>   btrfs-progs: image: Introduce -d option to dump data
>   btrfs-progs: image: Reduce memory requirement for decompression
>   btrfs-progs: image: Reduce memory usage for chunk tree search

Added to devel. Thanks.
