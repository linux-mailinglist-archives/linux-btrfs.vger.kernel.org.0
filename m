Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E073313B5
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 17:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCHQqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 11:46:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:53764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230144AbhCHQqX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Mar 2021 11:46:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11250AE05;
        Mon,  8 Mar 2021 16:46:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35D35DA81B; Mon,  8 Mar 2021 17:44:24 +0100 (CET)
Date:   Mon, 8 Mar 2021 17:44:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: use a dedicated variable for qgroup
 released data rsv for insert_prealloc_file_extent()
Message-ID: <20210308164424.GD7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210303104152.105877-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303104152.105877-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 03, 2021 at 06:41:51PM +0800, Qu Wenruo wrote:
> There is a piece of weird code in insert_prealloc_file_extent(), which
> looks like:
> 
> 	ret = btrfs_qgroup_release_data(inode, file_offset, len);
> 	if (ret < 0)
> 		return ERR_PTR(ret);
> 	if (trans) {
> 		ret = insert_reserved_file_extent(trans, inode,
> 						  file_offset, &stack_fi,
> 						  true, ret);
> 	...
> 	}
> 	extent_info.is_new_extent = true;
> 	extent_info.qgroup_reserved = ret;
> 	...
> 
> Note how the variable @ret is abused here, and if anyone is adding code
> just after btrfs_qgroup_release_data() call, it's super easy to
> overwrite the @ret and cause tons of qgroup related bugs.
> 
> Fix such abuse by introducing new variable @qgroup_released, so that we
> won't reuse the existing variable @ret.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
