Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FB6475E48
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 18:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbhLORMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 12:12:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60760 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhLORMM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 12:12:12 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8BD9C1F3CB;
        Wed, 15 Dec 2021 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639588331;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QvFJ0W0l/L2dhaeHJWfZLXN2dF+ZtzcHstyu0MMzeIk=;
        b=jSJZoHCMM/bnPKVYZ//yRZVcDNEtf9fG21QH6iLxfjeU6WRrh70th9Pl//clmQ12oPYby6
        M5K8+ENJOiKF0is8qti1NwdWolZWtst/vOjgTnDljhUmeyhucWmmt1mQ8UiCwpqXJareNa
        SsfKx4k/6OuwKtEWgPK3e0mVYIGakdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639588331;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QvFJ0W0l/L2dhaeHJWfZLXN2dF+ZtzcHstyu0MMzeIk=;
        b=blHe6cNk9QS+x/lybP2WWm/0DErBmX6nTH1WDF6zbpKj1kd5/C9NOqPi0tLbOHQNKxnI72
        E8F1LoCkED11GUCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 84A1FA3B83;
        Wed, 15 Dec 2021 17:12:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B0AB7DA781; Wed, 15 Dec 2021 18:11:52 +0100 (CET)
Date:   Wed, 15 Dec 2021 18:11:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: use btrfs_path::reada to replace the
 under-utilized btrfs_reada_add() mechanism
Message-ID: <20211215171152.GD28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211214130145.82384-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214130145.82384-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 14, 2021 at 09:01:42PM +0800, Qu Wenruo wrote:
> [PROBLEMS]
> The metadata readahead code is introduced in 2011 (surprisingly, the
> commit message even contains changelog), but now there is only one user
> for it, and even for the only one user, the readahead mechanism can't
> provide all it needs:
> 
> - No support for commit tree readahead
>   Only support readahead on current tree.
> 
> - Bad layer separation
>   To manage on-fly bios, btrfs_reada_add() mechanism internally manages
>   a kinda complex zone system, and it's bind to per-device.
> 
>   This is against the common layer separation, as metadata should all be
>   in btrfs logical address space, should not be bound to device physical
>   layer.
> 
>   In fact, this is the cause of all recent reada related bugs.
> 
> - No caller for asynchronous metadata readahead
>   Even btrfs_reada_add() is designed to be fully asynchronous, scrub
>   only calls it in a synchronous way (call btrfs_reada_add() and
>   immediately call btrfs_reada_wait()).
>   Thus rendering a lot of code unnecessary.
> 
> [ALTERNATIVE]
> On the other hand, we have btrfs_path::reada mechanism, which is already
> used by tons of btrfs sub-systems like send.
> 
> [MODIFICATION]
> This patch will use btrfs_path::reada to replace btrfs_reada_add()
> mechanism.
> 
> [BENCHMARK]
> The conclusion looks like this:
> 
> For the worst case (no dirty metadata, slow HDD), there will be around 5%
> performance drop for scrub.
> For other cases (even SATA SSD), there is no distinguishable performance
> difference.
> 
> The number is reported scrub speed, in MiB/s.
> The resolution is limited by the reported duration, which only has a
> resolution of 1 second.
> 
> 	Old		New		Diff
> SSD	455.3		466.332		+2.42%
> HDD	103.927 	98.012		-5.69%
> 
> 
> [BENCHMARK DETAILS]
> Both tests are done in the same host and VM, the VM has one dedicated
> SSD and one dedicated HDD attached to it (virtio driver though)
> 
> Host:
> CPU:	5900X
> RAM:	DDR4 3200MT, no ECC
> 
> 	During the benchmark, there is no other active other than light
> 	DE operations.
> 
> VM:
> vCPU:	16x
> RAM:	4G
> 
> 	The VM kernel doesn't have any heavy debug options to screw up
> 	the benchmark result.
> 
> Test drives:
> SSD:	500G SATA SSD
> 	Crucial CT500MX500SSD1
> 	(With quite some wear, as it's my main test drive for fstests)
> 
> HDD:	2T 5400rpm SATA HDD (device-managed SMR)
> 	WDC WD20SPZX-22UA7T0
> 	(Very new, invested just for this benchmark)
> 
> Filesystem contents:
> For filesystems on SSD and HDD, they are generated using the following
> fio job file:
> 
>   [scrub-populate]
>   directory=/mnt/btrfs
>   nrfiles=16384
>   openfiles=16
>   filesize=2k-512k
>   readwrite=randwrite
>   ioengine=libaio
>   fallocate=none
>   numjobs=4
>   
> Then randomly remove 4096 files (1/16th of total files) to create enough
> gaps in extent tree.
> 
> Finally run scrub on each filesystem 5 times, with cycle mount and
> module reload between each run.
> 
> Full result can be fetched here:
> https://docs.google.com/spreadsheets/d/1cwUAlbKPfp4baKrS92debsCt6Ejqvxr_Ylspj_SDFT0/edit?usp=sharing
> 
> [CHANGELOG]
> RFC->v1:
> - Add benchmark result
> - Add extent tree readahead using btrfs_path::reada
> 
> v2:
> - Reorder the patches
>   So that the reada removal comes at last
> 
> - Add benchmark result into the reada removal patch
> 
> - Fix a bug that can cause false alert for RAID56 dev-replace/scrub
>   Caused by missing ->search_commit_root assignment during refactor.
> 
> Qu Wenruo (3):
>   btrfs: remove the unnecessary path parameter for scrub_raid56_parity()
>   btrfs: use btrfs_path::reada for scrub extent tree readahead
>   btrfs: remove reada mechanism

Added to misc-next, thanks.
