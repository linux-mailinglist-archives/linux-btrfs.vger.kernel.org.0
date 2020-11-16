Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EBE2B4957
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 16:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbgKPPav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 10:30:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:59350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbgKPPav (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 10:30:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0139CAC0C;
        Mon, 16 Nov 2020 15:30:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8D3CCDA6E3; Mon, 16 Nov 2020 16:29:05 +0100 (CET)
Date:   Mon, 16 Nov 2020 16:29:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: stop incrementing log batch when joining log
 transaction
Message-ID: <20201116152905.GL6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <5c0655d43b2809932ec8aa40d99b94295469e3f1.1605266377.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0655d43b2809932ec8aa40d99b94295469e3f1.1605266377.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 11:23:30AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When joining a log transaction we acquire the root's log mutex, then
> increment the root's log batch and log writers counters while holding
> the mutex. However we don't need to increment the log batch there,
> because we are holding the mutex and incremented the log writers counter
> as well, so any other task trying to sync log will wait for the current
> task to finish its logging and still achieve the desired log batching.
> 
> Since the log batch counter is an atomic counter and is incremented twice
> at the very beginning of the fsync callback (btrfs_sync_file()), once
> before flushing delalloc and once again after waiting for writeback to
> complete, eliminating its increment when joining the log transaction
> may provide some performance gains in case we have multiple concurrent
> tasks doing fsyncs against different files in the same subvolume, as it
> reduces contention on the atomic (locking the cacheline and bouncing it).
> 
> When testing fio with 32 jobs, on a 8 cores vm, doing fsyncs against
> different files of the same subvolume, on top of a zram device, I could
> consistently see gains (higher throughput) between 1% to 2%, which is a
> very low value and possibly hard to be observed with a real device (I
> couldn't observe consistent gains with my low/mid end NVMe device).
> So this change is mostly motivated to just simplify the logic, as updating
> the log batch counter is only relevant when an fsync starts and while not
> holding the root's log mutex.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
