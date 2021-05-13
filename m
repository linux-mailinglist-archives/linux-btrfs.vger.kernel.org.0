Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C10380092
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 00:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhEMXAx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 19:00:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:50340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhEMXAx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 19:00:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7F60AEE5;
        Thu, 13 May 2021 22:59:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 42263DA8EB; Fri, 14 May 2021 00:57:11 +0200 (CEST)
Date:   Fri, 14 May 2021 00:57:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 01/42] btrfs: scrub: fix subpage scrub repair error
 caused by hardcoded PAGE_SIZE
Message-ID: <20210513225711.GM7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427230349.369603-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 28, 2021 at 07:03:08AM +0800, Qu Wenruo wrote:
> [BUG]
> For the following file layout, btrfs scrub will not be able to repair
> all these two repairable error, but in fact make one corruption even
> unrepairable:
> 
> 	  inode offset 0      4k     8K
> Mirror 1               |XXXXXX|      |
> Mirror 2               |      |XXXXXX|
> 
> [CAUSE]
> The root cause is the hard coded PAGE_SIZE, which makes scrub repair to
> go crazy for subpage.
> 
> For above case, when reading the first sector, we use PAGE_SIZE other
> than sectorsize to read, which makes us to read the full range [0, 64K).
> In fact, after 8K there may be no data at all, we can just get some
> garbage.
> 
> Then when doing the repair, we also writeback a full page from mirror 2,
> this means, we will also writeback the corrupted data in mirror 2 back
> to mirror 1, leaving the range [4K, 8K) unrepairable.
> 
> [FIX]
> This patch will modify the following PAGE_SIZE use with sectorsize:

Let me take this as an example: the changelog is great and descriptive,
the only thing I often change is an extra newline between the
introductory paragraph ended by ":" and the item list. This is maybe a
personal preference but I find it easier to read.

> - scrub_print_warning_inode()
>   Remove the min() and replace PAGE_SIZE with sectorsize.
>   The min() makes no sense, as csum is done for the full sector with
>   padding.
> 
>   This fixes a bug that subpage report extra length like:
>    checksum error at logical 298844160 on dev /dev/mapper/arm_nvme-test,
>    physical 575668224, root 5, inode 257, offset 0, length 12288, links 1 (path: file)
> 
>   Where the error is only 1 sector.
> 
> - scrub_handle_errored_block()
>   Comments with PAGE|page involved, all changed to sector.
> 
> - scrub_setup_recheck_block()
> - scrub_repair_page_from_good_copy()
> - scrub_add_page_to_wr_bio()
> - scrub_wr_submit()
> - scrub_add_page_to_rd_bio()
> - scrub_block_complete()
>   Replace PAGE_SIZE with sectorsize.
>   This solves several problems where we read/write extra range for
>   subpage case.

...
