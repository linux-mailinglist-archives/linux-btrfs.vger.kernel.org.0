Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0A6154C83
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 20:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgBFT73 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 14:59:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:46170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgBFT73 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 14:59:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6970BAAB8;
        Thu,  6 Feb 2020 19:59:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D92E2DA790; Thu,  6 Feb 2020 20:59:13 +0100 (CET)
Date:   Thu, 6 Feb 2020 20:59:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/11] Make pinned extents tracking per-transaction
Message-ID: <20200206195912.GE2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120140918.15647-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 20, 2020 at 04:09:07PM +0200, Nikolay Borisov wrote:
> I've finally managed to finish and test the pinned extents rework. So here it is.
> 
> The idea is to move pinnex extents tracking from the global fs_info->pinned_extents,
> which is just a pointer to fs_info->freed_extents[] array members to a per
> transaction structure. This will allow to cleanup pinned extents information
> during transaction abort.
> 
> The bulk of the changes are necessary to ensure a valid transaction handle
> is passed to every function that utilizes fs_info->pinned_extents. Also it
> was necessary to account for the peculiarities of excluded extents which are
> also tracked in ->freed_extents array but with a different flag (yuck).
> 
> First 9 patches propagate btrfs_trans_handle where it's necessary. Patch 10
> factors out pinned extent clean up to make Patch 11 more readable , alternatively
> the changes in patch 10 had to be in patch 11 which would have made it messier
> for review.
> 
> I believe this series doesn't bring any user facing changes it (hopefully)
> streamlines the code and makes it apparent what the lifetime of pinned extents
> is and paves the way for further cleanups of BUG_ON.
> 
> Nikolay Borisov (11):
>   btrfs: Perform pinned cleanup directly in btrfs_destroy_delayed_refs
>   btrfs: Make btrfs_pin_extent take trans handle
>   btrfs: Introduce unaccount_log_buffer
>   btrfs: Call btrfs_pin_reserved_extent only during active transaction
>   btrfs: Make btrfs_pin_reserved_extent take transaction
>   btrfs: Make btrfs_pin_extent_for_log_replay take transaction handle
>   btrfs: Make pin_down_extent take btrfs_trans_handle
>   btrfs: Pass trans handle to write_pinned_extent_entries
>   btrfs: Mark pinned log extents as excluded
>   btrfs: Factor out pinned extent clean up in btrfs_delete_unused_bgs
>   btrfs: Use btrfs_transaction::pinned_extents

So far I found test btrfs/139 to fail, nothing in the log, only the
golden output does not match.
