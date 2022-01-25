Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1131949B223
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 11:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347208AbiAYKj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 05:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348065AbiAYKhY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 05:37:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C19C061772
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 02:37:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9BE55CE1764
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 10:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3937FC340F0;
        Tue, 25 Jan 2022 10:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643107034;
        bh=jipnwgeKYLn+suzzxmeYUMWhJyjdwavCU2TO8eKcUTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLJJxK38JcQ8a1SeZP2//PQpPk8W5yF3QFUtS8C6YHATxHw17vMrCDLwPlpc4V5F1
         vwrIEdLMYUzhgsaFri3ngreXhFfZaAmo8hm0Jszffkrw5vYkHllyyAoA9oiKgvbQK+
         MsKK4kEgDLoWmuqfyAnaeKUVmR57I+OxIH+v+4sX6lKkik7Zt+BUQuJbIoy3hG+Zgh
         5h3VeWhR5ECQfd1bFwkQp0BK3E9wHUHWk6DQSROYnuxWmKBamcv0Ax2rMEjLKW/K2x
         aYNZF8y9210YI+rFRqKDODmnx3+bstt3I3nOm+wmN7bupMuoJsbNqrHCr0ZmMupRZO
         4+XJcBZ8S/u0A==
Date:   Tue, 25 Jan 2022 10:37:11 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper
 defrag
Message-ID: <Ye/S15/clpSOG3y6@debian9.Home>
References: <20220125065057.35863-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220125065057.35863-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 25, 2022 at 02:50:55PM +0800, Qu Wenruo wrote:
> ** DON'T MERGE, THIS IS JUST A PROOF OF CONCEPT **
> 
> There are several reports about v5.16 btrfs autodefrag is causing more
> IO than v5.15.
> 
> But it turns out that, commit f458a3873ae ("btrfs: fix race when
> defragmenting leads to unnecessary IO") is making defrags doing less
> work than it should.
> Thus damping the IO for autodefrag.
> 
> This POC series is to make v5.15 kernel to do proper defrag of all good
> candidates while still not defrag any hole/preallocated range.
> 
> The test script here looks like this:
> 
> 	wipefs -fa $dev
> 	mkfs.btrfs -f $dev -U $uuid > /dev/null
> 	mount $dev $mnt -o autodefrag
> 	$fsstress -w -n 2000 -p 1 -d $mnt -s 1642319517
> 	sync
> 	echo "=== baseline ==="
> 	cat /sys/fs/btrfs/$uuid/debug/io_accounting/data_write
> 	echo 0 > /sys/fs/btrfs/$uuid/debug/cleaner_trigger
> 	sleep 3
> 	sync
> 	echo "=== after autodefrag ==="
> 	cat /sys/fs/btrfs/$uuid/debug/io_accounting/data_write
> 	umount $mnt
> 
> <uuid>/debug/io_accounting/data_write is the new debug features showing
> how many bytes has been written for a btrfs.
> The numbers are before chunk mapping.
> cleaer_trigger is the trigger to wake up cleaner_kthread so autodefrag
> can do its work.
> 
> Now there is result:
> 
>                 | Data bytes written | Diff to baseline
> ----------------+--------------------+------------------
> no autodefrag   | 36896768           | 0
> v5.15 vanilla   | 40079360           | +8.6%
> v5.15 POC       | 42491904           | +15.2%
> v5.16 fixes	| 42536960	     | +15.3%
> 
> The data shows, although v5.15 vanilla is really causing the least
> amount of IO for autodefrag, if v5.15 is patched with POC to do proper
> defrag, the final IO is almost the same as v5.16 with submitted fixes.
> 
> So this proves that, the v5.15 has lower IO is not a valid default, but
> a regression which leads to less efficient defrag.
> 
> And the IO increase is in fact a proof of a regression being fixed.

Are you sure that's the only thing?
Users report massive IO difference, 15% more does not seem to be massive.
François for example reported a difference of 10 ops/s vs 1k ops/s [1]

It also does not explain the 100% cpu usage of the cleaner kthread.
Scanning the whole file based on extent maps and not using
btrfs_search_forward() anymore, as discussed yesterday on slack, can
however contribute to much higher cpu usage.

[1] https://lore.kernel.org/linux-btrfs/CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com/

Thanks.

> 
> Qu Wenruo (2):
>   btrfs: defrag: don't defrag preallocated extents
>   btrfs: defrag: limit cluster size to the first hole/prealloc range
> 
>  fs/btrfs/ioctl.c | 48 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 6 deletions(-)
> 
> -- 
> 2.34.1
> 
