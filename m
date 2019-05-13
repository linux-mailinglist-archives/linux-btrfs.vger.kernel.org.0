Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427F41BA99
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfEMQGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 12:06:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:58166 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730269AbfEMQGI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 12:06:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D34D9AF5B;
        Mon, 13 May 2019 16:06:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D9CE6DA851; Mon, 13 May 2019 18:07:04 +0200 (CEST)
Date:   Mon, 13 May 2019 18:07:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] Btrfs: fix race between send and deduplication that
 lead to failures and crashes
Message-ID: <20190513160704.GE3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190415083018.2224-1-fdmanana@kernel.org>
 <20190422154342.11873-1-fdmanana@kernel.org>
 <20190513155607.GD3138@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513155607.GD3138@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 05:56:07PM +0200, David Sterba wrote:
> On Mon, Apr 22, 2019 at 04:43:42PM +0100, fdmanana@kernel.org wrote:
> > +		btrfs_warn_rl(root_dst->fs_info,
> > +"Can not deduplicate to root %llu while send operations are using it (%d in progress)",
> > +			      root_dst->root_key.objectid,
> > +			      root_dst->send_in_progress);
> 
> The test btrfs/187 stresses this code and the logs are flooded by the
> messages, even ratelimited.
> 
> I wonder if the test is rather artificail (and that's fine for the testing
> purposes) or if the number of messages would repeat under normal conditions.
> 
> We don't need to print the message each time the dedup tries to acces a
> snapshot under send, so keeping track if the message has been sent already
> would be less intrusive and still provide the information.

Untested:

--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1205,6 +1205,8 @@ enum {
        BTRFS_ROOT_DEAD_RELOC_TREE,
        /* Mark dead root stored on device whose cleanup needs to be resumed */
        BTRFS_ROOT_DEAD_TREE,
+       /* Track if dedupe was attempted under a current send */
+       BTRFS_ROOT_NOTIFIED_DEDUPE_DURING_SEND,
 };
 
 /*
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6dafa857bbb9..23677cf12afc 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3263,7 +3263,9 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 
        spin_lock(&root_dst->root_item_lock);
        if (root_dst->send_in_progress) {
-               btrfs_warn_rl(root_dst->fs_info,
+               if (!test_and_set_bit(BTRFS_ROOT_NOTIFIED_DEDUPE_DURING_SEND,
+                                       &root_dst->state))
+                       btrfs_warn(root_dst->fs_info,
 "cannot deduplicate to root %llu while send operations are using it (%d in progress)",
                              root_dst->root_key.objectid,
                              root_dst->send_in_progress);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index dd38dfe174df..cc85ae903368 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6637,6 +6637,8 @@ static void btrfs_root_dec_send_in_progress(struct btrfs_root* root)
                btrfs_err(root->fs_info,
                          "send_in_progress unbalanced %d root %llu",
                          root->send_in_progress, root->root_key.objectid);
+       if (root->send_in_progress == 0)
+               clear_bit(BTRFS_ROOT_NOTIFIED_DEDUPE_DURING_SEND, &root->state);
        spin_unlock(&root->root_item_lock);
 }

