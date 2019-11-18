Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 612EB100813
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 16:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKRPX2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 10:23:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:35570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbfKRPX2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 10:23:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A521B23B;
        Mon, 18 Nov 2019 15:23:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09B60DA823; Mon, 18 Nov 2019 16:23:27 +0100 (CET)
Date:   Mon, 18 Nov 2019 16:23:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix block group remaining RO forever after error
 during device replace
Message-ID: <20191118152327.GG3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191114180243.10857-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114180243.10857-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 14, 2019 at 06:02:43PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing a device replace, while at scrub.c:scrub_enumerate_chunks(), we
> set the block group to RO mode and then wait for any ongoing writes into
> extents of the block group to complete. While doing that wait we overwrite
> the value of the variable 'ret' and can break out of the loop if an error
> happens without turning the block group back into RW mode. So what happens
> is the following:
> 
> 1) btrfs_inc_block_group_ro() returns 0, meaning it set the block group
>    to RO mode (its ->ro field set to 1 or incremented to some value > 1);
> 
> 2) Then btrfs_wait_ordered_roots() returns a value > 0;
> 
> 3) Then if either joinning or committing the transaction fails, we break
>    out of the loop wihtout calling btrfs_dec_block_group_ro(), leaving
>    the block group in RO mode forever.
> 
> To fix this, just remove the code that waits for ongoing writes to extents
> of the block group, since it's not needed because in the initial setup
> phase of a device replace operation, before starting to find all chunks
> and their extents, we set the target device for replace while holding
> fs_info->dev_replace->rwsem, which ensures that after releasing that
> semaphore, any writes into the source device are made to the target device
> as well (__btrfs_map_block() guarantees that). So while at
> scrub_enumerate_chunks() we only need to worry about finding and copying
> extents (from the source device to the target device) that were written
> before we started the device replace operation.
> 
> Fixes: f0e9b7d6401959 ("Btrfs: fix race setting block group readonly during device replace")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
