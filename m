Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CBA2B1FED
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgKMQRQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:17:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:59364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgKMQRQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:17:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B36EAD07;
        Fri, 13 Nov 2020 16:17:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9111ADA87A; Fri, 13 Nov 2020 17:15:32 +0100 (CET)
Date:   Fri, 13 Nov 2020 17:15:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tests: fix free space tree test failure on 64K
 page system
Message-ID: <20201113161532.GD6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201111070245.92797-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111070245.92797-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 11, 2020 at 03:02:45PM +0800, Qu Wenruo wrote:
> When trying to load btrfs with selftest compiled in, on 64K page system
> the test will always fail:
> 
>   BTRFS: selftest: running free space tree tests
>   BTRFS: selftest: fs/btrfs/tests/free-space-tree-tests.c:101 free space tree is invalid
>   BTRFS: selftest: fs/btrfs/tests/free-space-tree-tests.c:529 test_empty_block_group [btrfs] failed with extents, sectorsize=65536, nodesize=65536, alignment=134217728
> 
> The cause is that, after commit 801dc0c9ff1f ("btrfs: replace div_u64 by
> shift in free_space_bitmap_size"), we use fs_info->sectorsize_bits for
> free space cache.
> 
> But in comit fc59cfa7d2ab ("btrfs: use precalculated sectorsize_bits
> from fs_info"), we only initialized the fs_info for non-testing
> environment, leaving the default bits to be ilog2(4K), screwing up the
> selftest on 64K page system.
> 
> Fix it by also honor sectorsize_bits in selftest.
> 
> David, please fold this fix into the offending commit.

Thanks for catching it, patch updated.
