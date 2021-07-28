Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA933D8F10
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 15:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbhG1Nb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 09:31:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58848 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbhG1Nb0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 09:31:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 45039222F7;
        Wed, 28 Jul 2021 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627479084;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=izxiOPP2QQpWjbAYnpy/KDWYjLGMgLUvYHlNdcs7mwU=;
        b=a0wTQf0iLEe+pw3X5GfdqGVAvrbKruAFXPwlrWjMjLXmfVUsgGPmkrUP8Ewhjjnyn0mUNt
        RZiZPrlpgXku9/5c7SWLHTVbcP2iSRwCEZYzotANUVnifzITUSl2HOVFoV2l96KBSXkf7J
        SyjLNmcdERcoOuFwp2No4rz5mGLvpiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627479084;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=izxiOPP2QQpWjbAYnpy/KDWYjLGMgLUvYHlNdcs7mwU=;
        b=Rz4WIcirpKQ9Plkxg3N2hDJkGooXYbCawa8Wz37I0xRBWgHjkaMG0V0YY5Tsp8giMjxM4Z
        NWXEmLulSqr8vQCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3E3C4A3B8D;
        Wed, 28 Jul 2021 13:31:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 64645DA8A7; Wed, 28 Jul 2021 15:28:39 +0200 (CEST)
Date:   Wed, 28 Jul 2021 15:28:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v8 09/18] btrfs: fix wild subpage writeback which does
 not have ordered extent.
Message-ID: <20210728132839.GI5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210726063507.160396-1-wqu@suse.com>
 <20210726063507.160396-10-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726063507.160396-10-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 26, 2021 at 02:34:58PM +0800, Qu Wenruo wrote:
> [BUG]
> When running fsstress with subpage RW support, there are random
> BUG_ON()s triggered with the following trace:
> 
>  kernel BUG at fs/btrfs/file-item.c:667!
>  Internal error: Oops - BUG: 0 [#1] SMP
>  CPU: 1 PID: 3486 Comm: kworker/u13:2 5.11.0-rc4-custom+ #43
>  Hardware name: Radxa ROCK Pi 4B (DT)
>  Workqueue: btrfs-worker-high btrfs_work_helper [btrfs]
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
>  pc : btrfs_csum_one_bio+0x420/0x4e0 [btrfs]
>  lr : btrfs_csum_one_bio+0x400/0x4e0 [btrfs]
>  Call trace:
>   btrfs_csum_one_bio+0x420/0x4e0 [btrfs]
>   btrfs_submit_bio_start+0x20/0x30 [btrfs]
>   run_one_async_start+0x28/0x44 [btrfs]
>   btrfs_work_helper+0x128/0x1b4 [btrfs]
>   process_one_work+0x22c/0x430
>   worker_thread+0x70/0x3a0
>   kthread+0x13c/0x140
>   ret_from_fork+0x10/0x30
> 
> [CAUSE]
> Above BUG_ON() means there are some bio range which doesn't have ordered
> extent, which indeed is worthy a BUG_ON().
> 
> Unlike regular sectorsize == PAGE_SIZE case, in subpage we have extra
> subpage dirty bitmap to record which range is dirty and should be
> written back.
> 
> This means, if we submit bio for a subpage range, we do not only need to
> clear page dirty, but also need to clear subpage dirty bits.
> 
> In __extent_writepage_io(), we will call btrfs_page_clear_dirty() for
> any range we submit a bio.
> 
> But there is loophole, if we hit a range which is beyond isize, we just

Please refer to inode size as i_size, it's easier to grep for next to
the results where we also want inode->i_size.
