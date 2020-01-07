Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB96132B4E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 17:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgAGQqe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 11:46:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:38326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbgAGQqd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jan 2020 11:46:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5B65DAD29;
        Tue,  7 Jan 2020 16:46:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 65062DA78B; Tue,  7 Jan 2020 17:46:22 +0100 (CET)
Date:   Tue, 7 Jan 2020 17:46:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/5] btrfs: introduce the inode->file_extent_tree
Message-ID: <20200107164622.GC3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20191230213118.7532-1-josef@toxicpanda.com>
 <20191230213118.7532-3-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230213118.7532-3-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 30, 2019 at 04:31:15PM -0500, Josef Bacik wrote:
> +int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
> +				      u64 len)
> +{
> +	if (len == 0)
> +		return 0;
> +
> +	ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize));
> +
> +	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
> +		return 0;
> +	return set_extent_bits(&inode->file_extent_tree, start, start + len - 1,
> +			       EXTENT_DIRTY);

set_extent_bits and friends do the allocations for range splits so this
is going to decrease performance. For the allocations and tree
traversals.  With enabled no-holes it's not going to be a problem, but
there are still many filesystems without the feature enabled so this
needs some evaluation.
