Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED76533288A
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 15:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhCIO0W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 09:26:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:57006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbhCIO0E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Mar 2021 09:26:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CDA0AF1E;
        Tue,  9 Mar 2021 14:26:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A44DFDA7D7; Tue,  9 Mar 2021 15:24:04 +0100 (CET)
Date:   Tue, 9 Mar 2021 15:24:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH] btrfs-progs: fix false alert on tree block crossing 64K
 page boundary
Message-ID: <20210309142404.GI7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>
References: <20210306004019.18528-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306004019.18528-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 06, 2021 at 08:40:19AM +0800, Qu Wenruo wrote:
> [BUG]
> When btrfs-check is executed on even newly created fs, it can report
> tree blocks crossing 64K page boundary like this:
> 
>   Opening filesystem to check...
>   Checking filesystem on /dev/test/test
>   UUID: 80d734c8-dcbc-411b-9623-a10bd9e7767f
>   [1/7] checking root items
>   [2/7] checking extents
>   WARNING: tree block [30523392, 30539776) crosses 64K page boudnary, may cause problem for 64K page system
>   [3/7] checking free space cache
>   [4/7] checking fs roots
>   [5/7] checking only csums items (without verifying data)
>   [6/7] checking root refs
>   [7/7] checking quota groups skipped (not enabled on this FS)
>   found 131072 bytes used, no error found
>   total csum bytes: 0
>   total tree bytes: 131072
>   total fs tree bytes: 32768
>   total extent tree bytes: 16384
>   btree space waste bytes: 125199
>   file data blocks allocated: 0
>    referenced 0
> 
> [CAUSE]
> Tree block [30523392, 30539776) is at the last 16K slot of page.
> As 30523392 % 65536 = 49152, and 30539776 % 65536 = 0.
> 
> The cross boundary check is using exclusive end, which causes false
> alerts.
> 
> [FIX]
> Use inclusive end to do the cross 64K boundary check.
> 
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> Fixes: fc38ae7f4826 ("btrfs-progs: check: detect and warn about tree blocks crossing 64K page boundary")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks. I've extended the 001 test for mkfs to actually check for any
check warnings right after mkfs, covering all profiles and
single/multiple setups.
