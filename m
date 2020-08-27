Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B464125445A
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 13:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgH0Ld5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Aug 2020 07:33:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:42410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbgH0LdR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Aug 2020 07:33:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC12AAE17;
        Thu, 27 Aug 2020 11:33:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BFAA5DA703; Thu, 27 Aug 2020 13:32:07 +0200 (CEST)
Date:   Thu, 27 Aug 2020 13:32:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: qgroup: fix wrong qgroup metadata reserve for
 delayed inode
Message-ID: <20200827113207.GL28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200724064610.69442-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724064610.69442-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 24, 2020 at 02:46:09PM +0800, Qu Wenruo wrote:
> For delayed inode facility, qgroup metadata is reserved for it, and
> later freed.
> 
> However we're freeing more bytes than we reserved.
> In btrfs_delayed_inode_reserve_metadata():
> 
> 	num_bytes = btrfs_calc_metadata_size(fs_info, 1);
> 	...
> 		ret = btrfs_qgroup_reserve_meta_prealloc(root,
> 				fs_info->nodesize, true);
> 		...
> 		if (!ret) {
> 			node->bytes_reserved = num_bytes;
> 
> But in btrfs_delayed_inode_release_metadata():
> 
> 	if (qgroup_free)
> 		btrfs_qgroup_free_meta_prealloc(node->root,
> 				node->bytes_reserved);
> 	else
> 		btrfs_qgroup_convert_reserved_meta(node->root,
> 				node->bytes_reserved);
> 
> This means, we're always releasing more qgroup metadata rsv than we have
> reserved.
> 
> This won't trigger selftest warning, as btrfs qgroup metadata rsv has
> extra protection against cases like quota enabled half-way.
> 
> But we still need to fix this problem any way.
> 
> This patch will use the same num_bytes for qgroup metadata rsv so we
> could handle it correctly.
> 
> Fixes: f218ea6c4792 ("btrfs: delayed-inode: Remove wrong qgroup meta reservation calls")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next.

Patch 2/2 should go to stable (4.19+) but it does not apply even to 5.8
due to some other intermediate changes. I have tagged it for 4.19 but it
will expectedly fail to apply. A backport would be needed then.
