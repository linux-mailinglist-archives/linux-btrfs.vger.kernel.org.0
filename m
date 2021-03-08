Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A623312C2
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 17:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCHQB2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 11:01:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:60392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhCHQBK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Mar 2021 11:01:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 189B7ADDB;
        Mon,  8 Mar 2021 16:01:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 39D30DA81B; Mon,  8 Mar 2021 16:59:11 +0100 (CET)
Date:   Mon, 8 Mar 2021 16:59:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] btrfs: fix wrong offset to zero out range beyond isize
Message-ID: <20210308155911.GC7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <20210308092017.81059-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308092017.81059-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 08, 2021 at 05:20:17PM +0800, Qu Wenruo wrote:
> [BUG]
> Btrfs fails at generic/091 test case, with the following output:
> 
>   fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -W
>   mapped writes DISABLED
>   Seed set to 1
>   main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RANGE, disabling!
>   main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, disabling!
>   skipping zero size read
>   truncating to largest ever: 0xe400
>   copying to largest ever: 0x1f400
>   cloning to largest ever: 0x70000
>   cloning to largest ever: 0x77000
>   fallocating to largest ever: 0x7a120
>   Mapped Read: non-zero data past EOF (0x3a7ff) page offset 0x800 is 0xf2e1 <<<
>   ...
> 
> [CAUSE]
> In commit c28ea613fafa ("btrfs: subpage: fix the false data csum mismatch error")
> end_bio_extent_readpage() changes to only zero the range inside the bvec
> for incoming subpage support.
> 
> But that commit is using incorrect offset to calculate the start.
> 
> For subpage, we can have a case that the whole bvec is beyond isize,
> thus we need to calculate the correct offset.
> 
> But the offending commit is using @end (bvec end), other than @start
> (bvec start) to calculate the start offset.
> 
> This means, we only zero the last byte of the bvec, not from the isize.
> This stupid bug makes the range beyond isize is not properly zeroed, and
> failed above test.
> 
> [FIX]
> Use correct @start to calculate the range start.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
