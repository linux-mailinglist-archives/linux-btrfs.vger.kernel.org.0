Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9846738C700
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhEUMwS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:52:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234778AbhEUMv6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:51:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B09DAC7A;
        Fri, 21 May 2021 12:50:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0C86ADA72C; Fri, 21 May 2021 14:47:57 +0200 (CEST)
Date:   Fri, 21 May 2021 14:47:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: check error value from btrfs_update_inode in tree
 log
Message-ID: <20210521124757.GJ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <2661a4cc24936c9cc24836999c479e39f0db2402.1621437971.git.josef@toxicpanda.com>
 <c82160a4-03bd-783d-009b-5ab5e25424f9@gmx.com>
 <20210520132410.GC7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520132410.GC7604@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 20, 2021 at 03:24:10PM +0200, David Sterba wrote:
> On Thu, May 20, 2021 at 09:07:26AM +0800, Qu Wenruo wrote:
> > > -			btrfs_update_inode(trans, root, BTRFS_I(inode));
> > 
> > I did a quick grep and found that we have other locations where we call
> > btrfs_uppdate_inode() without catching the return value:
> > 
> > $ grep -IRe "^\s\+btrfs_update_inode(" fs/btrfs/
> > fs/btrfs/free-space-cache.c:    btrfs_update_inode(trans, root,
> > BTRFS_I(inode));
> > fs/btrfs/free-space-cache.c:    btrfs_update_inode(trans, root,
> > BTRFS_I(inode));
> > fs/btrfs/inode.c:               btrfs_update_inode(trans, root, inode);
> > fs/btrfs/inode.c:       btrfs_update_inode(trans, root, BTRFS_I(inode));
> > 
> > Maybe it's better to make btrfs_update_inode() to have __must_check prefix?
> 
> We should handle errors everywhere by default, with rare exceptions that
> might get a comment why it's ok to ignore the errors. So that would mean
> that basically all functions get __must_check attribute if we really
> want to catch that.

As an alternative I'm thinking about a set of coccinelle rules to find
such cases, and not only that. Eg. lack of error handling of
btrfs_update_inode is as simple as

---
@@
@@
* btrfs_update_inode(...);
---

With following output. The advantage of separate rules is that it can be
run outside of compilation and the semantic language offers much wider
options than the few compiler attributes.

diff -u -p ./free-space-cache.c /tmp/nothing/free-space-cache.c
--- ./free-space-cache.c
+++ /tmp/nothing/free-space-cache.c
@@ -1270,7 +1270,6 @@ out:
          "failed to write free space cache for block group %llu error %d",
                                  block_group->start, ret);
        }
-       btrfs_update_inode(trans, root, BTRFS_I(inode));
 
        if (block_group) {
                /* the dirty list is protected by the dirty_bgs_lock */
@@ -1455,7 +1454,6 @@ out:
                invalidate_inode_pages2(inode->i_mapping);
                BTRFS_I(inode)->generation = 0;
        }
-       btrfs_update_inode(trans, root, BTRFS_I(inode));
        if (must_iput)
                iput(inode);
        return ret;
diff -u -p ./inode.c /tmp/nothing/inode.c
--- ./inode.c
+++ /tmp/nothing/inode.c
@@ -4997,7 +4997,6 @@ static int maybe_insert_hole(struct btrf
                btrfs_abort_transaction(trans, ret);
        } else {
                btrfs_update_inode_bytes(inode, 0, drop_args.bytes_found);
-               btrfs_update_inode(trans, root, inode);
        }
        btrfs_end_transaction(trans);
        return ret;
@@ -6564,7 +6563,6 @@ static int btrfs_mknod(struct user_names
        if (err)
                goto out_unlock;
 
-       btrfs_update_inode(trans, root, BTRFS_I(inode));
        d_instantiate_new(dentry, inode);
 
 out_unlock:
diff -u -p ./tree-log.c /tmp/nothing/tree-log.c
--- ./tree-log.c
+++ /tmp/nothing/tree-log.c
@@ -1574,7 +1574,6 @@ static noinline int add_inode_ref(struct
                        if (ret)
                                goto out;
 
-                       btrfs_update_inode(trans, root, BTRFS_I(inode));
                }
 
                ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + namelen;
@@ -1749,7 +1748,6 @@ static noinline int fixup_inode_link_cou
 
        if (nlink != inode->i_nlink) {
                set_nlink(inode, nlink);
-               btrfs_update_inode(trans, root, BTRFS_I(inode));
        }
        BTRFS_I(inode)->index_cnt = (u64)-1;
 
---------------------
