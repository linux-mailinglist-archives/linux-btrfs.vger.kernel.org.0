Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0957664443
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 16:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjAJPOi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 10:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbjAJPOB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 10:14:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E99BDC
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 07:13:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 808AB3F2A3;
        Tue, 10 Jan 2023 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673363633;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tsIADWYaoYedHPBsujZDkfYyy3UnN3lxl3NiI7N6zRI=;
        b=jAhZnxP+ygAqJNvRQRDwbHHNb4jM36FVxgb9YI4CxbrfLXWHQzhHSE73NCTgnC/oRHhRZz
        tnTApyLartBP+wuMKEp80lg/sxa5C9g6vmyUAFAAGNA81TCKc4pk4i4c9Yd/hKsgk/hVrR
        r8AC6jfIhgHwF0AQxlIcDQFcZsUx6i0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673363633;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tsIADWYaoYedHPBsujZDkfYyy3UnN3lxl3NiI7N6zRI=;
        b=bvk6o6XuVIXfb2nQc+JLopFDsQ/10sR5LhmNSAy5hqwq2DOd7e0YsSSgyfnJC9NyD/floh
        InnLnEXlv69qDdBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15F6B13338;
        Tue, 10 Jan 2023 15:13:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ILyBBLGAvWOreAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 Jan 2023 15:13:53 +0000
Date:   Tue, 10 Jan 2023 16:08:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     robbieko <robbieko@synology.com>
Cc:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: fix unexpected -ENOMEM with
 percpu_counter_init when create snapshot
Message-ID: <20230110150818.GD11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221214021125.28289-1-robbieko@synology.com>
 <Y5oA3qBk+qMSyAR/@localhost.localdomain>
 <20221214180718.GF10499@twin.jikos.cz>
 <f1971de4-5355-6f57-46df-0a6cefb9ee95@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1971de4-5355-6f57-46df-0a6cefb9ee95@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 19, 2022 at 02:54:06PM +0800, robbieko wrote:
> 
> David Sterba 於 2022/12/15 上午2:07 寫道:
> > On Wed, Dec 14, 2022 at 11:59:10AM -0500, Josef Bacik wrote:
> >> On Wed, Dec 14, 2022 at 10:11:22AM +0800, robbieko wrote:
> >>> From: Robbie Ko <robbieko@synology.com>
> >>>
> >>> [Issue]
> >>> When creating subvolume/snapshot, the transaction may be abort due to -ENOMEM
> >>>
> >>>    WARNING: CPU: 1 PID: 411 at fs/btrfs/transaction.c:1937 create_pending_snapshot+0xe30/0xe70 [btrfs]()
> >>>    CPU: 1 PID: 411 Comm: btrfs Tainted: P O 4.4.180+ #42661
> >>>    Call Trace:
> >>>      create_pending_snapshot+0xe30/0xe70 [btrfs]
> >>>      create_pending_snapshots+0x89/0xb0 [btrfs]
> >>>      btrfs_commit_transaction+0x469/0xc60 [btrfs]
> >>>      btrfs_mksubvol+0x5bd/0x690 [btrfs]
> >>>      btrfs_mksnapshot+0x102/0x170 [btrfs]
> >>>      btrfs_ioctl_snap_create_transid+0x1ad/0x1c0 [btrfs]
> >>>      btrfs_ioctl_snap_create_v2+0x102/0x160 [btrfs]
> >>>      btrfs_ioctl+0x2111/0x3130 [btrfs]
> >>>      do_vfs_ioctl+0x7ea/0xa80
> >>>      SyS_ioctl+0xa1/0xb0
> >>>      entry_SYSCALL_64_fastpath+0x1e/0x8e
> >>>    ---[ end trace 910c8f86780ca385 ]---
> >>>    BTRFS: error (device dm-2) in create_pending_snapshot:1937: errno=-12 Out of memory
> >>>
> >>> [Cause]
> >>> During creating a subvolume/snapshot, it is necessary to allocate memory for Initializing fs root.
> >>> Therefore, it can only use GFP_NOFS to allocate memory to avoid deadlock issues.
> >>> However, atomic allocation is required when processing percpu_counter_init
> >>> without GFP_KERNEL due to the unique structure of percpu_counter.
> >>> In this situation, allocating memory for initializing fs root may cause
> >>> unexpected -ENOMEM when free memory is low and causes btrfs transaction to abort.
> >>>
> >>> [Fix]
> >>> We allocate memory at the beginning of creating a subvolume/snapshot.
> >>> This way, we can ensure the memory is enough when initializing fs root.
> >>> Even -ENOMEM happens at the beginning of creating a subvolume/snapshot,
> >>> the transaction won’t abort since it hasn’t started yet.
> >> Honestly I'd rather just make the btrfs_drew_lock use an atomic_t for the
> >> writers counter as well.  This is only taken in truncate an nocow writes, and in
> >> nocow writes there are a looooot of slower things that have to be done that
> >> we're not winning a lot with the percpu counter.  Is there any reason not to
> >> just do that and leave all this code alone?  Thanks,
> > The percpu counter for writers is there since the original commit
> > 8257b2dc3c1a1057 "Btrfs: introduce btrfs_{start, end}_nocow_write() for
> > each subvolume". The reason could be to avoid hammering the same
> > cacheline from all the readers but then the writers do that anyway.
> > This happens in context related to IO or there's some waiting anyway, so
> > yeah using atomic for writers should be ok as well.
> 
> Sorry for the late reply, I've been busy recently.
> This modification will not affect the original btrfs_drew_lock behavior,
> and the framework can also provide future scenarios where memory
> needs to be allocated in init_fs_root.

With the conversion to atomic_t the preallocation can remain unchanged
as there would be only the anon bdev preallocated, then there's not much
reason to have the infrastructure.

I'm now testing the patch below, it's relatively short an can be
backported if needed but it can potentially make the performance worse
in some cases.

---
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a7d5a3967ba0..7acedc6c2a56 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1523,15 +1523,7 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 	int ret;
 	unsigned int nofs_flag;
 
-	/*
-	 * We might be called under a transaction (e.g. indirect backref
-	 * resolution) which could deadlock if it triggers memory reclaim
-	 */
-	nofs_flag = memalloc_nofs_save();
-	ret = btrfs_drew_lock_init(&root->snapshot_lock);
-	memalloc_nofs_restore(nofs_flag);
-	if (ret)
-		goto fail;
+	 btrfs_drew_lock_init(&root->snapshot_lock);
 
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
 	    !btrfs_is_data_reloc_root(root)) {
@@ -2242,7 +2234,6 @@ void btrfs_put_root(struct btrfs_root *root)
 		WARN_ON(test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state));
 		if (root->anon_dev)
 			free_anon_bdev(root->anon_dev);
-		btrfs_drew_lock_destroy(&root->snapshot_lock);
 		free_root_extent_buffers(root);
 #ifdef CONFIG_BTRFS_DEBUG
 		spin_lock(&root->fs_info->fs_roots_radix_lock);
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 870528d87526..3a496b0d3d2b 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -325,24 +325,12 @@ struct extent_buffer *btrfs_try_read_lock_root_node(struct btrfs_root *root)
  * acquire the lock.
  */
 
-int btrfs_drew_lock_init(struct btrfs_drew_lock *lock)
+void btrfs_drew_lock_init(struct btrfs_drew_lock *lock)
 {
-	int ret;
-
-	ret = percpu_counter_init(&lock->writers, 0, GFP_KERNEL);
-	if (ret)
-		return ret;
-
 	atomic_set(&lock->readers, 0);
+	atomic_set(&lock->writers, 0);
 	init_waitqueue_head(&lock->pending_readers);
 	init_waitqueue_head(&lock->pending_writers);
-
-	return 0;
-}
-
-void btrfs_drew_lock_destroy(struct btrfs_drew_lock *lock)
-{
-	percpu_counter_destroy(&lock->writers);
 }
 
 /* Return true if acquisition is successful, false otherwise */
@@ -351,10 +339,10 @@ bool btrfs_drew_try_write_lock(struct btrfs_drew_lock *lock)
 	if (atomic_read(&lock->readers))
 		return false;
 
-	percpu_counter_inc(&lock->writers);
+	atomic_inc(&lock->writers);
 
 	/* Ensure writers count is updated before we check for pending readers */
-	smp_mb();
+	smp_mb__after_atomic();
 	if (atomic_read(&lock->readers)) {
 		btrfs_drew_write_unlock(lock);
 		return false;
@@ -374,7 +362,7 @@ void btrfs_drew_write_lock(struct btrfs_drew_lock *lock)
 
 void btrfs_drew_write_unlock(struct btrfs_drew_lock *lock)
 {
-	percpu_counter_dec(&lock->writers);
+	atomic_dec(&lock->writers);
 	cond_wake_up(&lock->pending_readers);
 }
 
@@ -390,8 +378,7 @@ void btrfs_drew_read_lock(struct btrfs_drew_lock *lock)
 	 */
 	smp_mb__after_atomic();
 
-	wait_event(lock->pending_readers,
-		   percpu_counter_sum(&lock->writers) == 0);
+	wait_event(lock->pending_readers, atomic_read(&lock->writers) == 0);
 }
 
 void btrfs_drew_read_unlock(struct btrfs_drew_lock *lock)
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 11c2269b4b6f..edb9b4a0dba1 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -195,13 +195,12 @@ static inline void btrfs_tree_unlock_rw(struct extent_buffer *eb, int rw)
 
 struct btrfs_drew_lock {
 	atomic_t readers;
-	struct percpu_counter writers;
+	atomic_t writers;
 	wait_queue_head_t pending_writers;
 	wait_queue_head_t pending_readers;
 };
 
-int btrfs_drew_lock_init(struct btrfs_drew_lock *lock);
-void btrfs_drew_lock_destroy(struct btrfs_drew_lock *lock);
+void btrfs_drew_lock_init(struct btrfs_drew_lock *lock);
 void btrfs_drew_write_lock(struct btrfs_drew_lock *lock);
 bool btrfs_drew_try_write_lock(struct btrfs_drew_lock *lock);
 void btrfs_drew_write_unlock(struct btrfs_drew_lock *lock);
