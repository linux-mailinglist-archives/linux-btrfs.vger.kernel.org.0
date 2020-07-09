Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B4A21A5FF
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 19:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgGIRki (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 13:40:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:34676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgGIRki (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 13:40:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A44CAD68;
        Thu,  9 Jul 2020 17:40:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CBF03DAB7F; Thu,  9 Jul 2020 19:40:16 +0200 (CEST)
Date:   Thu, 9 Jul 2020 19:40:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/3] btrfs: qgroup: try to flush qgroup space when we
 get -EDQUOT
Message-ID: <20200709174016.GE15161@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200708062447.81341-1-wqu@suse.com>
 <20200708062447.81341-3-wqu@suse.com>
 <20200709163246.GB15161@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709163246.GB15161@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 09, 2020 at 06:32:46PM +0200, David Sterba wrote:
> On Wed, Jul 08, 2020 at 02:24:46PM +0800, Qu Wenruo wrote:
> > -int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
> > +static int try_flush_qgroup(struct btrfs_root *root)
> > +{
> > +	struct btrfs_trans_handle *trans;
> > +	int ret;
> > +
> > +	/*
> > +	 * We don't want to run flush again and again, so if there is a running
> > +	 * one, we won't try to start a new flush, but exit directly.
> > +	 */
> > +	ret = mutex_trylock(&root->qgroup_flushing_mutex);
> > +	if (!ret) {
> > +		mutex_lock(&root->qgroup_flushing_mutex);
> > +		mutex_unlock(&root->qgroup_flushing_mutex);
> 
> This is abuse of mutex, for status tracking "is somebody flushing" and
> for waiting until it's over.
> 
> We have many root::status bits (the BTRFS_ROOT_* namespace) so that
> qgroups are flushing should another one. The bit atomically set when it
> starts and cleared when it ends.
> 
> All waiting tasks should queue in a normal wait_queue_head.

Something like that (untested):

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2cc1fcaa7cfa..5dbb6b7300b7 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1007,6 +1007,12 @@ enum {
 	BTRFS_ROOT_DEAD_TREE,
 	/* The root has a log tree. Used only for subvolume roots. */
 	BTRFS_ROOT_HAS_LOG_TREE,
+
+	/*
+	 * Indicate that qgroup flushing is in progress to prevent multiple
+	 * processes attempting that
+	 */
+	BTRFS_ROOT_QGROUP_FLUSHING,
 };
 
 /*
@@ -1159,7 +1165,7 @@ struct btrfs_root {
 	spinlock_t qgroup_meta_rsv_lock;
 	u64 qgroup_meta_rsv_pertrans;
 	u64 qgroup_meta_rsv_prealloc;
-	struct mutex qgroup_flushing_mutex;
+	wait_queue_head_t qgroup_flush_wait;
 
 	/* Number of active swapfiles */
 	atomic_t nr_swapfiles;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8029127df537..e124e3376208 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1116,7 +1116,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	mutex_init(&root->log_mutex);
 	mutex_init(&root->ordered_extent_mutex);
 	mutex_init(&root->delalloc_mutex);
-	mutex_init(&root->qgroup_flushing_mutex);
+	init_waitqueue_head(&root->qgroup_flush_wait);
 	init_waitqueue_head(&root->log_writer_wait);
 	init_waitqueue_head(&root->log_commit_wait[0]);
 	init_waitqueue_head(&root->log_commit_wait[1]);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 494ab2b1bbf2..95695aca7aa9 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3503,10 +3503,9 @@ static int try_flush_qgroup(struct btrfs_root *root)
 	 * We don't want to run flush again and again, so if there is a running
 	 * one, we won't try to start a new flush, but exit directly.
 	 */
-	ret = mutex_trylock(&root->qgroup_flushing_mutex);
-	if (!ret) {
-		mutex_lock(&root->qgroup_flushing_mutex);
-		mutex_unlock(&root->qgroup_flushing_mutex);
+	if (test_and_set_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state)) {
+		wait_event(root->qgroup_flush_wait,
+			!test_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state));
 		return 0;
 	}
 
@@ -3523,7 +3522,7 @@ static int try_flush_qgroup(struct btrfs_root *root)
 
 	ret = btrfs_commit_transaction(trans);
 unlock:
-	mutex_unlock(&root->qgroup_flushing_mutex);
+	clear_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state);
 	return ret;
 }
 
