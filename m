Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF26329233
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 21:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243315AbhCAUlM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 15:41:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:38634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235347AbhCAUfB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 15:35:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E43FACE5;
        Mon,  1 Mar 2021 20:34:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8AB68DA7AA; Mon,  1 Mar 2021 21:32:18 +0100 (CET)
Date:   Mon, 1 Mar 2021 21:32:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix the false data csum mismatch error caused
Message-ID: <20210301203218.GC7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20210301084422.103716-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301084422.103716-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 01, 2021 at 04:44:22PM +0800, Qu Wenruo wrote:
> [BUG]
> When running fstresss, we can hit strange data csum mismatch where the
> on-disk data is in fact correct (passes both scrub and btrfs check
> --check-data-csum).

check --chech-data-csum is not 100% reliable so I'd rather not mention
it, scrub is safe.

> With some extra debug info added, we have the following traces:
> 
> 510482us : btrfs_do_readpage: root=5 ino=284 offset=393216, submit force=0 pgoff=0 iosize=8192
> 510494us : btrfs_do_readpage: root=5 ino=284 offset=401408, submit force=0 pgoff=8192 iosize=4096
> 510498us : btrfs_submit_data_bio: root=5 ino=284 bio first bvec=393216 len=8192
> 510591us : btrfs_do_readpage: root=5 ino=284 offset=405504, submit force=0 pgoff=12288 iosize=36864
> 510594us : btrfs_submit_data_bio: root=5 ino=284 bio first bvec=401408 len=4096
> 510863us : btrfs_submit_data_bio: root=5 ino=284 bio first bvec=405504 len=36864
> 510933us : btrfs_verify_data_csum: root=5 ino=284 offset=393216 len=8192
> 510967us : btrfs_do_readpage: root=5 ino=284 offset=442368, skip beyond isize pgoff=49152 iosize=16384
> 511047us : btrfs_verify_data_csum: root=5 ino=284 offset=401408 len=4096
> 511163us : btrfs_verify_data_csum: root=5 ino=284 offset=405504 len=36864
> 511290us : check_data_csum: !!! root=5 ino=284 offset=438272 pg_off=45056 !!!
> 517387us : end_bio_extent_readpage: root=5 ino=284 before pending_read_bios=0
> 
> [CAUSE]
> Normally we expect all submitted bio read to only touch the range we
> specified, and under subpage context, it means we should only touch the
> range spcified in each bvec.
> 
> But in data read path, inside end_bio_extent_readpage(), we have page
> zeroing which only takes regular page size into consideration.
> 
> This means for subpage if we have an inode whose content looks like below:
> 
>   0       16K     32K     48K     64K
>   |///////|       |///////|       |
> 
>   |//| = data needs to be read from disk
>   |  | = hole
> 
> And i_size is 64K initially.
> 
> Then the following race can happen:
> 
> 		T1		|		T2
> --------------------------------+--------------------------------
> btrfs_do_readpage()		|
> |- isize = 64K;			|
> |  At this time, the isize is 	|
> |  64K				|
> |				|
> |- submit_extent_page()		|
> |  submit previous assembled bio|
> |  assemble bio for [0, 16K)	|
> |				|
> |- submit_extent_page()		|
>    submit read bio for [0, 16K) |
>    assemble read bio for	|
>    [32K, 48K)			|
>  				|
> 				| btrfs_setsize()
> 				| |- i_size_write(, 16K);
> 				|    Now i_size is only 16K
> end_io() for [0K, 16K)		|
> |- end_bio_extent_readpage()	|
>    |- btrfs_verify_data_csum()  |
>    |  No csum error		|
>    |- i_size = 16K;		|
>    |- zero_user_segment(16K,	|
>       PAGE_SIZE);		|
>       !!! We zeroed range	|
>       !!! [32K, 48K)		|
> 				| end_io for [32K, 48K)
> 				| |- end_bio_extent_readpage()
> 				|    |- btrfs_verify_data_csum()
> 				|       ! CSUM MISMATCH !
> 				|       ! As the range is zeroed now !
> 
> [FIX]
> To fix the problem, make end_bio_extent_readpage() to only zero the
> range of bvec.
> 
> Thankfully the bug only affects subpage read-write support, as for full
> read-only mount we can't change i_size thus won't hit the race
> condition.

Oh right, I've updated the subject so this is clearly referring to the
subpage case. Thanks.
