Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B5897F7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 17:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfHUPyy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 11:54:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:38338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728126AbfHUPyx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 11:54:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F01CAF0D;
        Wed, 21 Aug 2019 15:54:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D4A73DA7DB; Wed, 21 Aug 2019 17:55:17 +0200 (CEST)
Date:   Wed, 21 Aug 2019 17:55:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 6/6] btrfs: Remove BUG_ON from run_delalloc_nocow
Message-ID: <20190821155517.GB2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190805144708.5432-1-nborisov@suse.com>
 <20190805144708.5432-7-nborisov@suse.com>
 <CAL3q7H4bG0g7O8vUOR7pYBn9fvQbDvKVYUSucsPAcxBsNorrnw@mail.gmail.com>
 <92e30fce-58bb-8049-99e0-7af34098806f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92e30fce-58bb-8049-99e0-7af34098806f@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 07, 2019 at 11:18:20AM +0300, Nikolay Borisov wrote:
> >> @@ -1569,16 +1569,26 @@ static noinline int run_delalloc_nocow(struct inode *inode,
> >>                                                        disk_bytenr, num_bytes,
> >>                                                        num_bytes,
> >>                                                        BTRFS_ORDERED_PREALLOC);
> >> +                       if (nocow)
> >> +                               btrfs_dec_nocow_writers(fs_info, disk_bytenr);
> >> +                       if (ret) {
> >> +                               btrfs_drop_extent_cache(BTRFS_I(inode),
> >> +                                                       cur_offset,
> >> +                                                       cur_offset + num_bytes - 1,
> >> +                                                       0);
> >> +                               goto error;
> >> +                       }
> >>                 } else {
> >>                         ret = btrfs_add_ordered_extent(inode, cur_offset,
> >>                                                        disk_bytenr, num_bytes,
> >>                                                        num_bytes,
> >>                                                        BTRFS_ORDERED_NOCOW);
> >> +                       if (nocow)
> >> +                               btrfs_dec_nocow_writers(fs_info, disk_bytenr);
> >> +                       if (ret)
> >> +                               goto error;
> > 
> > We are now duplicating some error handling. Could be done like before,
> > outside the if branches.
> > 
> 
> Dependson the POV. IMO it's better to have all error handling for the
> respective branch in one place. That way when someone is reading the
> function and gets to that branch they see that in case one of the
> functions fail what is the error handling. Otherwise as they are
> scanning the code they'd have to look up and see if something tricky is
> going on.
> 
> David, what's your take on that ?

I agree with Filipe and the common error handling style is to coalesce
the common code at the end of the function. In this function there are
several places that decrement the nocow writers and then jump to error.
So this asks for a cleanup that does something like that (untested):

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1314,6 +1314,8 @@ static noinline int run_delalloc_nocow(struct inode *inode,
        bool check_prev = true;
        const bool freespace_inode = btrfs_is_free_space_inode(BTRFS_I(inode));
        u64 ino = btrfs_ino(BTRFS_I(inode));
+       bool nocow = false;
+       u64 disk_bytenr = 0;

        path = btrfs_alloc_path();
        if (!path) {
@@ -1333,12 +1335,12 @@ static noinline int run_delalloc_nocow(struct inode *inode,
                struct extent_buffer *leaf;
                u64 extent_end;
                u64 extent_offset;
-               u64 disk_bytenr = 0;
                u64 num_bytes = 0;
                u64 disk_num_bytes;
                u64 ram_bytes;
                int extent_type;
-               bool nocow = false;
+
+               nocow = false;
 
                ret = btrfs_lookup_file_extent(NULL, root, path, ino,
                                               cur_offset, 0);
@@ -1541,12 +1543,8 @@ static noinline int run_delalloc_nocow(struct inode *inode,
                        ret = cow_file_range(inode, locked_page,
                                             cow_start, found_key.offset - 1,
                                             page_started, nr_written, 1);
-                       if (ret) {
-                               if (nocow)
-                                       btrfs_dec_nocow_writers(fs_info,
-                                                               disk_bytenr);
+                       if (ret)
                                goto error;
-                       }
                        cow_start = (u64)-1;
                }
 
@@ -1562,9 +1560,6 @@ static noinline int run_delalloc_nocow(struct inode *inode,
                                          ram_bytes, BTRFS_COMPRESS_NONE,
                                          BTRFS_ORDERED_PREALLOC);
                        if (IS_ERR(em)) {
-                               if (nocow)
-                                       btrfs_dec_nocow_writers(fs_info,
-                                                               disk_bytenr);
                                ret = PTR_ERR(em);
                                goto error;
                        }
@@ -1583,6 +1578,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
                if (nocow)
                        btrfs_dec_nocow_writers(fs_info, disk_bytenr);
                BUG_ON(ret); /* -ENOMEM */
+               nocow = false;
 
                if (root->root_key.objectid ==
                    BTRFS_DATA_RELOC_TREE_OBJECTID)
@@ -1627,6 +1623,8 @@ static noinline int run_delalloc_nocow(struct inode *inode,
        }
 
 error:
+       if (nocow)
+               btrfs_dec_nocow_writers(fs_info, disk_bytenr);
        if (ret && cur_offset < end)
                extent_clear_unlock_delalloc(inode, cur_offset, end,
                                             locked_page, EXTENT_LOCKED |
