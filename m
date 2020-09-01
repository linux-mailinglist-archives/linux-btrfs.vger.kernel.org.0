Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096D7259003
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgIAOOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 10:14:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:36404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgIAOOf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Sep 2020 10:14:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A82B5AD29;
        Tue,  1 Sep 2020 14:14:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7B918DA7CF; Tue,  1 Sep 2020 16:13:11 +0200 (CEST)
Date:   Tue, 1 Sep 2020 16:13:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] Another batch of inode vs btrfs_inode cleanups
Message-ID: <20200901141311.GF28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200831114249.8360-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831114249.8360-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 31, 2020 at 02:42:37PM +0300, Nikolay Borisov wrote:
> Here is the latest batch of inode vs btrfs_inode of interface cleanups for
> internal btrfs functions.
> 
> Nikolay Borisov (12):
>   btrfs: Make inode_tree_del take btrfs_inode
>   btrfs: Make btrfs_lookup_first_ordered_extent take btrfs_inode
>   btrfs: Make ordered extent tracepoint take btrfs_inode
>   btrfs: Make btrfs_dec_test_ordered_pending take btrfs_inode
>   btrfs: Convert btrfs_inode_sectorsize to take btrfs_inode
>   btrfs: Make btrfs_invalidatepage work on btrfs_inode
>   btrfs: Make btrfs_writepage_endio_finish_ordered btrfs_inode-centric
>   btrfs: Make get_extent_skip_holes take btrfs_inode
>   btrfs: Make btrfs_find_ordered_sum take btrfs_inode
>   btrfs: Make copy_inline_to_page take btrfs_inode
>   btrfs: Make btrfs_zero_range_check_range_boundary take btrfs_inode
>   btrfs: Make extent_fiemap take btrfs_iode

Added to misc-next, thanks. How many to go?
