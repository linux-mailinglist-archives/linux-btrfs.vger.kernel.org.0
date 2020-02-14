Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C3015DB06
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 16:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgBNPeC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 10:34:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:44632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387397AbgBNPeC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 10:34:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E8B65B1D3;
        Fri, 14 Feb 2020 15:34:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 63623DA703; Fri, 14 Feb 2020 16:33:46 +0100 (CET)
Date:   Fri, 14 Feb 2020 16:33:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 11/11 v3] btrfs: Use btrfs_transaction::pinned_extents
Message-ID: <20200214153346.GZ2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200124103541.6415-1-nborisov@suse.com>
 <20200124151830.25984-1-nborisov@suse.com>
 <20200206181054.GD2654@twin.jikos.cz>
 <ce572fd3-feef-262a-0fa8-06cb8f8299f1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce572fd3-feef-262a-0fa8-06cb8f8299f1@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 06, 2020 at 09:40:35PM +0200, Nikolay Borisov wrote:
> 
> 
> On 6.02.20 г. 20:10 ч., David Sterba wrote:
> > On Fri, Jan 24, 2020 at 05:18:30PM +0200, Nikolay Borisov wrote:
> >> --- a/fs/btrfs/transaction.c
> >> +++ b/fs/btrfs/transaction.c
> >> @@ -334,6 +334,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
> >>  	list_add_tail(&cur_trans->list, &fs_info->trans_list);
> >>  	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
> >>  			IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);
> >> +	extent_io_tree_init(fs_info, &cur_trans->pinned_extents, 0, NULL);
> > 
> > What's the reason there's no symbolic name for pinned_extents? Also 0
> > matches IO_TREE_FS_INFO_EXCLUDED_EXTENTS because it's first in the enum
> > list.
> > 
> 
> No reason, I'll change it in next version :)

Patchset going to misc-next with the following fixup:

--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -36,6 +36,7 @@ struct io_failure_record;
 #define CHUNK_TRIMMED                          EXTENT_DEFRAG
 
 enum {
+       IO_TREE_FS_PINNED_EXTENTS,
        IO_TREE_FS_EXCLUDED_EXTENTS,
        IO_TREE_INODE_IO,
        IO_TREE_INODE_IO_FAILURE,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e39cc15646a4..559a7a38d5a8 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -334,7 +334,8 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
        list_add_tail(&cur_trans->list, &fs_info->trans_list);
        extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
                        IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);
-       extent_io_tree_init(fs_info, &cur_trans->pinned_extents, 0, NULL);
+       extent_io_tree_init(fs_info, &cur_trans->pinned_extents,
+                       IO_TREE_FS_PINNED_EXTENTS, NULL);
        fs_info->generation++;
        cur_trans->transid = fs_info->generation;
        fs_info->running_transaction = cur_trans;
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 0f11f1fb982d..bcbc763b8814 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -81,6 +81,7 @@ TRACE_DEFINE_ENUM(COMMIT_TRANS);
 
 #define show_extent_io_tree_owner(owner)                                      \
        __print_symbolic(owner,                                                \
+               { IO_TREE_FS_PINNED_EXTENTS,      "PINNED_EXTENTS" },          \
                { IO_TREE_FS_EXCLUDED_EXTENTS,    "EXCLUDED_EXTENTS" },        \
                { IO_TREE_INODE_IO,               "INODE_IO" },                \
                { IO_TREE_INODE_IO_FAILURE,       "INODE_IO_FAILURE" },        \
