Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB75C53A12A
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351505AbiFAJro (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 05:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351549AbiFAJr2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 05:47:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A635D195
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 02:47:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6EC3E1F980
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 09:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654076837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sKe2e5uKUniXfEdX4RT523c5VbpwhxD8lnBD8mFawQM=;
        b=bXDQehYga0VtgP5oLCsoEW0Y72rTzu0YClJ4Za/RpaDXyZ0Skc9P5QJwIBiQpaqBlWk+7P
        uhWzjC8WM1Pa9QDMVATQVVq6OsOEpCs9ka+2yGHHCZOq80ct/lxjE9VvmbHYpfT8bYEXUK
        BYvD93yPQIeMB3jMoc4PfdDAnKeGxMc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B615E13A8F
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 09:47:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id naA1H6Q1l2KHegAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 09:47:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add RAID56 submitted bio trace events
Date:   Wed,  1 Jun 2022 17:46:59 +0800
Message-Id: <56cbf892eb0bec3b26da3e26f46537e94fb358af.1654076723.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the later incoming RAID56J, it's better to know each bio we're
submitting from btrfs RAID56 layer, so this patch will introduce the
trace events for every bio submitted by btrfs RAID56 layer.

The output looks like this: (trace event header and UUID skipped)

   raid56_read_partial: full_stripe=389152768 devid=3 type=DATA1 offset=32768 opf=0x0 physical=323059712 len=32768
   raid56_read_partial: full_stripe=389152768 devid=1 type=DATA2 offset=0 opf=0x0 physical=67174400 len=65536
   raid56_write_stripe: full_stripe=389152768 devid=3 type=DATA1 offset=0 opf=0x1 physical=323026944 len=32768
   raid56_write_stripe: full_stripe=389152768 devid=2 type=PQ1 offset=0 opf=0x1 physical=323026944 len=32768

The above debug output is from a 32K data write into an empty RAID56
data chunk.

Some explanation on the event output:
 full_stripe:	the logical bytenr of the full stripe
 devid:		btrfs devid
 type:		raid stripe type.
		DATA1:	the first data stripe
		DATA2:	the second data stripe
		PQ1:	the P stripe
		PQ2:	the Q stripe
 offset:	the offset inside the stripe.
 opf:		the bio op type
 physical:	the physical offset the bio is for
 len:		the length of the bio

The first two lines are from partial RMW read, which is reading the
remaining data stripes from disks.

The last two lines are for full stripe RMW write, which is writing the
involved two 16K stripes (one for DATA1 stripe, one for P stripe).
The stripe for DATA2 doesn't need to be written.

There are 5 types of trace events:
- raid56_read_partial
  Read remaining data for regular read/write path.

- raid56_write_stripe
  Write the modified stripes for regular read/write path.

- raid56_scrub_read_recover
  Read remaining data for scrub recovery path.

- raid56_scrub_write_stripe
  Write the modified stripes for scrub path.

- raid56_scrub_read
  Read remaining data for scrub path.

Also, since the trace events are included at super.c, we have to export
needed structure definitions into "raid56.h" and include the header in
super.c, or we're unable to access those members.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c            | 186 ++++++++++-------------------------
 fs/btrfs/raid56.h            | 159 +++++++++++++++++++++++++++++-
 fs/btrfs/super.c             |   1 +
 include/trace/events/btrfs.h |  93 ++++++++++++++++++
 4 files changed, 306 insertions(+), 133 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index a4fcc60e45a0..edff167a2ca6 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -63,138 +63,6 @@ struct sector_ptr {
 	unsigned int uptodate:8;
 };
 
-enum btrfs_rbio_ops {
-	BTRFS_RBIO_WRITE,
-	BTRFS_RBIO_READ_REBUILD,
-	BTRFS_RBIO_PARITY_SCRUB,
-	BTRFS_RBIO_REBUILD_MISSING,
-};
-
-struct btrfs_raid_bio {
-	struct btrfs_io_context *bioc;
-
-	/* while we're doing rmw on a stripe
-	 * we put it into a hash table so we can
-	 * lock the stripe and merge more rbios
-	 * into it.
-	 */
-	struct list_head hash_list;
-
-	/*
-	 * LRU list for the stripe cache
-	 */
-	struct list_head stripe_cache;
-
-	/*
-	 * for scheduling work in the helper threads
-	 */
-	struct work_struct work;
-
-	/*
-	 * bio list and bio_list_lock are used
-	 * to add more bios into the stripe
-	 * in hopes of avoiding the full rmw
-	 */
-	struct bio_list bio_list;
-	spinlock_t bio_list_lock;
-
-	/* also protected by the bio_list_lock, the
-	 * plug list is used by the plugging code
-	 * to collect partial bios while plugged.  The
-	 * stripe locking code also uses it to hand off
-	 * the stripe lock to the next pending IO
-	 */
-	struct list_head plug_list;
-
-	/*
-	 * flags that tell us if it is safe to
-	 * merge with this bio
-	 */
-	unsigned long flags;
-
-	/*
-	 * set if we're doing a parity rebuild
-	 * for a read from higher up, which is handled
-	 * differently from a parity rebuild as part of
-	 * rmw
-	 */
-	enum btrfs_rbio_ops operation;
-
-	/* Size of each individual stripe on disk */
-	u32 stripe_len;
-
-	/* How many pages there are for the full stripe including P/Q */
-	u16 nr_pages;
-
-	/* How many sectors there are for the full stripe including P/Q */
-	u16 nr_sectors;
-
-	/* Number of data stripes (no p/q) */
-	u8 nr_data;
-
-	/* Numer of all stripes (including P/Q) */
-	u8 real_stripes;
-
-	/* How many pages there are for each stripe */
-	u8 stripe_npages;
-
-	/* How many sectors there are for each stripe */
-	u8 stripe_nsectors;
-
-	/* First bad stripe, -1 means no corruption */
-	s8 faila;
-
-	/* Second bad stripe (for RAID6 use) */
-	s8 failb;
-
-	/* Stripe number that we're scrubbing  */
-	u8 scrubp;
-
-	/*
-	 * size of all the bios in the bio_list.  This
-	 * helps us decide if the rbio maps to a full
-	 * stripe or not
-	 */
-	int bio_list_bytes;
-
-	int generic_bio_cnt;
-
-	refcount_t refs;
-
-	atomic_t stripes_pending;
-
-	atomic_t error;
-
-	/* Bitmap to record which horizontal stripe has data */
-	unsigned long dbitmap;
-
-	/* Allocated with stripe_nsectors-many bits for finish_*() calls */
-	unsigned long finish_pbitmap;
-
-	/*
-	 * these are two arrays of pointers.  We allocate the
-	 * rbio big enough to hold them both and setup their
-	 * locations when the rbio is allocated
-	 */
-
-	/* pointers to pages that we allocated for
-	 * reading/writing stripes directly from the disk (including P/Q)
-	 */
-	struct page **stripe_pages;
-
-	/* Pointers to the sectors in the bio_list, for faster lookup */
-	struct sector_ptr *bio_sectors;
-
-	/*
-	 * For subpage support, we need to map each sector to above
-	 * stripe_pages.
-	 */
-	struct sector_ptr *stripe_sectors;
-
-	/* allocated with real_stripes-many pointers for finish_*() calls */
-	void **finish_pointers;
-};
-
 static int __raid56_parity_recover(struct btrfs_raid_bio *rbio);
 static noinline void finish_rmw(struct btrfs_raid_bio *rbio);
 static void rmw_work(struct work_struct *work);
@@ -1263,6 +1131,34 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 	spin_unlock_irq(&rbio->bio_list_lock);
 }
 
+static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
+			       struct raid56_bio_trace_info *trace_info)
+{
+	const struct btrfs_io_context *bioc = rbio->bioc;
+	int i;
+
+	ASSERT(bioc);
+
+	/* We rely on bio->bi_bdev to find the stripe number. */
+	if (!bio->bi_bdev)
+		goto not_found;
+
+	for (i = 0; i < bioc->num_stripes; i++) {
+		if (bio->bi_bdev != bioc->stripes[i].dev->bdev)
+			continue;
+		trace_info->stripe_nr = i;
+		trace_info->devid = bioc->stripes[i].dev->devid;
+		trace_info->offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
+				     bioc->stripes[i].physical;
+		return;
+	}
+
+not_found:
+	trace_info->devid = -1;
+	trace_info->offset = -1;
+	trace_info->stripe_nr = -1;
+}
+
 /*
  * this is called from one of two situations.  We either
  * have a full stripe from the higher layers, or we've read all
@@ -1426,8 +1322,13 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	BUG_ON(atomic_read(&rbio->stripes_pending) == 0);
 
 	while ((bio = bio_list_pop(&bio_list))) {
+		struct raid56_bio_trace_info trace_info = {0};
+
 		bio->bi_end_io = raid_write_end_io;
 
+		if (trace_raid56_write_stripe_enabled())
+			bio_get_trace_info(rbio, bio, &trace_info);
+		trace_raid56_write_stripe(rbio, bio, &trace_info);
 		submit_bio(bio);
 	}
 	return;
@@ -1685,10 +1586,15 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
 	while ((bio = bio_list_pop(&bio_list))) {
+		struct raid56_bio_trace_info trace_info = {0};
+
 		bio->bi_end_io = raid_rmw_end_io;
 
 		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
+		if (trace_raid56_read_partial_enabled())
+			bio_get_trace_info(rbio, bio, &trace_info);
+		trace_raid56_read_partial(rbio, bio, &trace_info);
 		submit_bio(bio);
 	}
 	/* the actual write will happen once the reads are done */
@@ -2258,10 +2164,15 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
 	while ((bio = bio_list_pop(&bio_list))) {
+		struct raid56_bio_trace_info trace_info = {0};
+
 		bio->bi_end_io = raid_recover_end_io;
 
 		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
+		if (trace_raid56_scrub_read_recover_enabled())
+			bio_get_trace_info(rbio, bio, &trace_info);
+		trace_raid56_scrub_read_recover(rbio, bio, &trace_info);
 		submit_bio(bio);
 	}
 
@@ -2629,8 +2540,13 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	atomic_set(&rbio->stripes_pending, nr_data);
 
 	while ((bio = bio_list_pop(&bio_list))) {
+		struct raid56_bio_trace_info trace_info = {0};
+
 		bio->bi_end_io = raid_write_end_io;
 
+		if (trace_raid56_scrub_write_stripe_enabled())
+			bio_get_trace_info(rbio, bio, &trace_info);
+		trace_raid56_scrub_write_stripe(rbio, bio, &trace_info);
 		submit_bio(bio);
 	}
 	return;
@@ -2806,10 +2722,16 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
 	 */
 	atomic_set(&rbio->stripes_pending, bios_to_read);
 	while ((bio = bio_list_pop(&bio_list))) {
+		struct raid56_bio_trace_info trace_info = {0};
+
 		bio->bi_end_io = raid56_parity_scrub_end_io;
 
 		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
 
+		if (trace_raid56_scrub_read_enabled())
+			bio_get_trace_info(rbio, bio, &trace_info);
+		trace_raid56_scrub_read(rbio, bio, &trace_info);
+
 		submit_bio(bio);
 	}
 	/* the actual write will happen once the reads are done */
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index aaad08aefd7d..dae85717bb4a 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -7,6 +7,163 @@
 #ifndef BTRFS_RAID56_H
 #define BTRFS_RAID56_H
 
+#include <linux/workqueue.h>
+#include "volumes.h"
+
+enum btrfs_rbio_ops {
+	BTRFS_RBIO_WRITE,
+	BTRFS_RBIO_READ_REBUILD,
+	BTRFS_RBIO_PARITY_SCRUB,
+	BTRFS_RBIO_REBUILD_MISSING,
+};
+
+struct btrfs_raid_bio {
+	struct btrfs_io_context *bioc;
+
+	/* while we're doing rmw on a stripe
+	 * we put it into a hash table so we can
+	 * lock the stripe and merge more rbios
+	 * into it.
+	 */
+	struct list_head hash_list;
+
+	/*
+	 * LRU list for the stripe cache
+	 */
+	struct list_head stripe_cache;
+
+	/*
+	 * for scheduling work in the helper threads
+	 */
+	struct work_struct work;
+
+	/*
+	 * bio list and bio_list_lock are used
+	 * to add more bios into the stripe
+	 * in hopes of avoiding the full rmw
+	 */
+	struct bio_list bio_list;
+	spinlock_t bio_list_lock;
+
+	/* also protected by the bio_list_lock, the
+	 * plug list is used by the plugging code
+	 * to collect partial bios while plugged.  The
+	 * stripe locking code also uses it to hand off
+	 * the stripe lock to the next pending IO
+	 */
+	struct list_head plug_list;
+
+	/*
+	 * flags that tell us if it is safe to
+	 * merge with this bio
+	 */
+	unsigned long flags;
+
+	/*
+	 * set if we're doing a parity rebuild
+	 * for a read from higher up, which is handled
+	 * differently from a parity rebuild as part of
+	 * rmw
+	 */
+	enum btrfs_rbio_ops operation;
+
+	/* Size of each individual stripe on disk */
+	u32 stripe_len;
+
+	/* How many pages there are for the full stripe including P/Q */
+	u16 nr_pages;
+
+	/* How many sectors there are for the full stripe including P/Q */
+	u16 nr_sectors;
+
+	/* Number of data stripes (no p/q) */
+	u8 nr_data;
+
+	/* Numer of all stripes (including P/Q) */
+	u8 real_stripes;
+
+	/* How many pages there are for each stripe */
+	u8 stripe_npages;
+
+	/* How many sectors there are for each stripe */
+	u8 stripe_nsectors;
+
+	/* First bad stripe, -1 means no corruption */
+	s8 faila;
+
+	/* Second bad stripe (for RAID6 use) */
+	s8 failb;
+
+	/* Stripe number that we're scrubbing  */
+	u8 scrubp;
+
+	/*
+	 * size of all the bios in the bio_list.  This
+	 * helps us decide if the rbio maps to a full
+	 * stripe or not
+	 */
+	int bio_list_bytes;
+
+	int generic_bio_cnt;
+
+	refcount_t refs;
+
+	atomic_t stripes_pending;
+
+	atomic_t error;
+
+	/* Bitmap to record which horizontal stripe has data */
+	unsigned long dbitmap;
+
+	/* Allocated with stripe_nsectors-many bits for finish_*() calls */
+	unsigned long finish_pbitmap;
+
+	/*
+	 * these are two arrays of pointers.  We allocate the
+	 * rbio big enough to hold them both and setup their
+	 * locations when the rbio is allocated
+	 */
+
+	/* pointers to pages that we allocated for
+	 * reading/writing stripes directly from the disk (including P/Q)
+	 */
+	struct page **stripe_pages;
+
+	/* Pointers to the sectors in the bio_list, for faster lookup */
+	struct sector_ptr *bio_sectors;
+
+	/*
+	 * For subpage support, we need to map each sector to above
+	 * stripe_pages.
+	 */
+	struct sector_ptr *stripe_sectors;
+
+	/* allocated with real_stripes-many pointers for finish_*() calls */
+	void **finish_pointers;
+};
+
+/*
+ * For trace event usage only. Records useful debug info for each bio submitted
+ * by RAID56 to each physical device.
+ *
+ * No matter signed or not, (-1) is always the one indicating we can not grab
+ * the proper stripe number.
+ */
+struct raid56_bio_trace_info {
+	u64 devid;
+
+	/* The offset inside the stripe. (<= STRIPE_LEN) */
+	u32 offset;
+
+	/*
+	 * Stripe number.
+	 * 0 is the first data stripe, and nr_data for P stripe,
+	 * nr_data + 1 for Q stripe.
+	 * >= real_stripes for 
+	 */
+	u8 stripe_nr;
+};
+
 static inline int nr_parity_stripes(const struct map_lookup *map)
 {
 	if (map->type & BTRFS_BLOCK_GROUP_RAID5)
@@ -21,13 +178,13 @@ static inline int nr_data_stripes(const struct map_lookup *map)
 {
 	return map->num_stripes - nr_parity_stripes(map);
 }
+
 #define RAID5_P_STRIPE ((u64)-2)
 #define RAID6_Q_STRIPE ((u64)-1)
 
 #define is_parity_stripe(x) (((x) == RAID5_P_STRIPE) ||		\
 			     ((x) == RAID6_Q_STRIPE))
 
-struct btrfs_raid_bio;
 struct btrfs_device;
 
 int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b1fdc6a26c76..804386ee9318 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -48,6 +48,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "qgroup.h"
+#include "raid56.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 290f07eb050a..b7277291880c 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -30,6 +30,8 @@ struct btrfs_qgroup;
 struct extent_io_tree;
 struct prelim_ref;
 struct btrfs_space_info;
+struct btrfs_raid_bio;
+struct raid56_bio_trace_info;
 
 #define show_ref_type(type)						\
 	__print_symbolic(type,						\
@@ -2258,6 +2260,97 @@ DEFINE_EVENT(btrfs__space_info_update, update_bytes_pinned,
 	TP_ARGS(fs_info, sinfo, old, diff)
 );
 
+DECLARE_EVENT_CLASS(btrfs_raid56_bio,
+
+	TP_PROTO(const struct btrfs_raid_bio *rbio,
+		 const struct bio *bio,
+		 const struct raid56_bio_trace_info *trace_info),
+
+	TP_ARGS(rbio, bio, trace_info),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	full_stripe	)
+		__field(	u64,	physical	)
+		__field(	u64,	devid		)
+		__field(	u32,	offset		)
+		__field(	u32,	len		)
+		__field(	u8,	opf		)
+		__field(	u8,	total_stripes	)
+		__field(	u8,	real_stripes	)
+		__field(	u8,	nr_data		)
+		__field(	u8,	stripe_nr	)
+	),
+
+	TP_fast_assign_btrfs(rbio->bioc->fs_info,
+		__entry->full_stripe	= rbio->bioc->raid_map[0];
+		__entry->physical	= bio->bi_iter.bi_sector << SECTOR_SHIFT;
+		__entry->len		= bio->bi_iter.bi_size;
+		__entry->opf		= bio_op(bio);
+		__entry->devid		= trace_info->devid;
+		__entry->offset		= trace_info->offset;
+		__entry->stripe_nr	= trace_info->stripe_nr;
+		__entry->total_stripes	= rbio->bioc->num_stripes;
+		__entry->real_stripes	= rbio->real_stripes;
+		__entry->nr_data	= rbio->nr_data;
+	),
+	/*
+	 * For type output, we need to output things like "DATA1"
+	 * (the first data stripe), "DATA2" (the second data stripe),
+	 * "PQ1" (P stripe),"PQ2" (Q stripe), "REPLACE0" (replace target device).
+	 */
+	TP_printk_btrfs("full_stripe=%llu devid=%lld type=%s%d offset=%d opf=0x%x physical=%llu len=%u",
+		__entry->full_stripe, __entry->devid,
+		(__entry->stripe_nr < __entry->nr_data) ? "DATA" :
+			((__entry->stripe_nr < __entry->real_stripes) ? "PQ" :
+			 "REPLACE"),
+		(__entry->stripe_nr < __entry->nr_data) ?
+			(__entry->stripe_nr + 1) :
+			((__entry->stripe_nr < __entry->real_stripes) ?
+		 		(__entry->stripe_nr - __entry->nr_data + 1) : 0),
+		__entry->offset, __entry->opf, __entry->physical, __entry->len)
+);
+
+DEFINE_EVENT(btrfs_raid56_bio, raid56_read_partial,
+	TP_PROTO(const struct btrfs_raid_bio *rbio,
+		 const struct bio *bio,
+		 const struct raid56_bio_trace_info *trace_info),
+
+	TP_ARGS(rbio, bio, trace_info)
+);
+
+DEFINE_EVENT(btrfs_raid56_bio, raid56_write_stripe,
+	TP_PROTO(const struct btrfs_raid_bio *rbio,
+		 const struct bio *bio,
+		 const struct raid56_bio_trace_info *trace_info),
+
+	TP_ARGS(rbio, bio, trace_info)
+);
+
+
+DEFINE_EVENT(btrfs_raid56_bio, raid56_scrub_write_stripe,
+	TP_PROTO(const struct btrfs_raid_bio *rbio,
+		 const struct bio *bio,
+		 const struct raid56_bio_trace_info *trace_info),
+
+	TP_ARGS(rbio, bio, trace_info)
+);
+
+DEFINE_EVENT(btrfs_raid56_bio, raid56_scrub_read,
+	TP_PROTO(const struct btrfs_raid_bio *rbio,
+		 const struct bio *bio,
+		 const struct raid56_bio_trace_info *trace_info),
+
+	TP_ARGS(rbio, bio, trace_info)
+);
+
+DEFINE_EVENT(btrfs_raid56_bio, raid56_scrub_read_recover,
+	TP_PROTO(const struct btrfs_raid_bio *rbio,
+		 const struct bio *bio,
+		 const struct raid56_bio_trace_info *trace_info),
+
+	TP_ARGS(rbio, bio, trace_info)
+);
+
 #endif /* _TRACE_BTRFS_H */
 
 /* This part must be outside protection */
-- 
2.36.1

