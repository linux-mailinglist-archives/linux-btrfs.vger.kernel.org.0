Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7446D154AD0
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 19:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBFSLJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 13:11:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:58526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgBFSLJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 13:11:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A97C5AEDC;
        Thu,  6 Feb 2020 18:11:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9AB2EDA790; Thu,  6 Feb 2020 19:10:54 +0100 (CET)
Date:   Thu, 6 Feb 2020 19:10:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 11/11 v3] btrfs: Use btrfs_transaction::pinned_extents
Message-ID: <20200206181054.GD2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200124103541.6415-1-nborisov@suse.com>
 <20200124151830.25984-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124151830.25984-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 05:18:30PM +0200, Nikolay Borisov wrote:
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -334,6 +334,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
>  	list_add_tail(&cur_trans->list, &fs_info->trans_list);
>  	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
>  			IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);
> +	extent_io_tree_init(fs_info, &cur_trans->pinned_extents, 0, NULL);

What's the reason there's no symbolic name for pinned_extents? Also 0
matches IO_TREE_FS_INFO_EXCLUDED_EXTENTS because it's first in the enum
list.
