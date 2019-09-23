Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9D9BB7F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 17:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfIWPax (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 11:30:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:52204 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfIWPax (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 11:30:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E45C4AB98;
        Mon, 23 Sep 2019 15:30:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C0139DA871; Mon, 23 Sep 2019 17:31:10 +0200 (CEST)
Date:   Mon, 23 Sep 2019 17:31:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix missing error return if writeback for extent
 buffer never started
Message-ID: <20190923153109.GF2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190911164228.13507-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911164228.13507-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 05:42:28PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If lock_extent_buffer_for_io() fails, it returns a negative value, but its
> caller btree_write_cache_pages() ignores such error. This means that a
> call to flush_write_bio(), from lock_extent_buffer_for_io(), might have
> failed. We should make btree_write_cache_pages() notice such error values
> and stop immediatelly, making sure filemap_fdatawrite_range() returns an
> error to the transaction commit path. A failure from flush_write_bio()
> should also result in the endio callback end_bio_extent_buffer_writepage()
> being invoked, which sets the BTRFS_FS_*_ERR bits appropriately, so that
> there's no risk a transaction or log commit doesn't catch a writeback
> failure.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
