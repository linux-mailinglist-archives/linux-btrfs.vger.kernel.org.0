Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623E3213C95
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 17:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgGCPcV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 11:32:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:48622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgGCPcU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 11:32:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D009AC22;
        Fri,  3 Jul 2020 15:32:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5CEECDA87C; Fri,  3 Jul 2020 17:32:01 +0200 (CEST)
Date:   Fri, 3 Jul 2020 17:32:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] Corrupt counter improvement
Message-ID: <20200703153200.GC27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200702122335.9117-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702122335.9117-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 03:23:27PM +0300, Nikolay Borisov wrote:
> This series aims to make the device corrupt counter be incremented when we
> encounter checksum error. This stems from an upstream report at [0] that btrfs
> doesn't actually increment the corruption device stats counter. There's no good
> reason why this should be the case so here's a patchset rectifying this.

Yeah I think this was forgotten at the time the dev-stats were merged.

> While looking around the code I thought the signature of the functions related
> to creating the failrec are somewhat quirky so the first 2 patches fix this.
> 
> Patch 3 introduces btrfs_device into btrfs_io_bio so that functions in the
> bio completion stack can use it.
> 
> Patch 4 removes a redundant check
> 
> Next 3 patches wire in increment of the CORRUPT counter in the respective
> read end io routines, namely compressed and ordinary reads.
> 
> Last patch creates a symlink of the private bdi that btrfs creates on mount
> which is used in an xfstest for this series.
> 
> [0] https://lore.kernel.org/linux-btrfs/4857863.FCrPRfMyHP@liv/
> 
> Nikolay Borisov (8):
>   btrfs: Make get_state_failrec return failrec directly
>   btrfs: Streamline btrfs_get_io_failure_record logic
>   btrfs: Record btrfs_device directly btrfs_io_bio
>   btrfs: Don't check for btrfs_device::bdev in btrfs_end_bio
>   btrfs: Increment device corruption error in case of checksum error
>   btrfs: Remove needless ASSERT
>   btrfs: Increment corrupt device counter during compressed read
>   btrfs: sysfs: Add bdi link to the fsid dir

This is pretty straightforward, thanks. I did some smallish changes like
renaming the btrfs_io_bio::dev to device.

Updating the existing counter is in line with scrub so we don't have to
change the on-disk stats.

Patchset is now in misc-next, I don't see any reason to keep it in a
topic branch.
