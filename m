Return-Path: <linux-btrfs+bounces-17351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD079BB4F03
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 20:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE39189CB22
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37EB27A919;
	Thu,  2 Oct 2025 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="SVDvSoaE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lnFXkkGK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE95727815D
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431043; cv=none; b=g/sVOE9GUxIJrDs+0c6htIoqtxEDV8ApO1Aq7Xb8UGRrX2UomGZr9HDJ2bNe6ijrub5gKml8F1KGTA91iLsdPWUTcWqt57wMcDZppnqlI6OdJnOMqJ90P5yW0wk6Jlwigde7XA+F69vGuQrF4QAX9JHXpc4lioyib3BUw6RHm1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431043; c=relaxed/simple;
	bh=Lz00567+LBOOr/jPZJDOsMK/G5LYbSqcZ1M75XQKCHo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DINAhWzqyFqkVrmSYPBqIlfpVuB2TnKC1XywkfPtIEBqjxjw8K1jkGz5tobD6kU2fg4ROHXYY6kdRmOV8qr9XJdVTJ0Wmi/2pu5mEsQ0b5HcgTnGDBJlwkkx6jtOjsiiUcvmrqasmwsqQuMecNDF+7hXBzEsWpdiukETgRfsMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=SVDvSoaE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lnFXkkGK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A7079EC0118;
	Thu,  2 Oct 2025 14:50:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 02 Oct 2025 14:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1759431039; x=1759517439; bh=DrEfciGMUtyxNwG2vzflI
	voWYrOmxEsadfo5eguen8g=; b=SVDvSoaEzdvDqnX363+5w1lc2spnGXAB07J+K
	/mHYY01A7sB/7DUXcaZGqSKWR+48fk9sYvC9vtc4Yq7Edg1qgtVtooxHHLEGi8FX
	GKluiw7MkrcsFIA0jh00eS51wyWpbO5iq0Gr4hAH2lfqw3/57BzUJqohnbMcAvdw
	dmwesbiX1nU0Ml1sUGiNFOu4FFtMDIEBoXputBHGM/axKywZmXXN7+IYZ/x13uXr
	ZKDMzfiNBOC6VKSmW7R2JWuA9e+47QLFZUU/HWu+EAevskL4MGgxYSXrIAALHEIQ
	COj3bxw1/ncWswwFAJygA2uOJM56BBu99MdbhT39UUfwNoHFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759431039; x=1759517439; bh=DrEfciGMUtyxNwG2vzflIvoWYrOmxEsadfo
	5eguen8g=; b=lnFXkkGKUWnmDes1N/gYHy+RQ3rm5kJ005VboAXlxaOa+M8p7p4
	IIwzOAkgzWOksNIWXD1ypjT9Fk6OH66vwzGKOY8N7hP1wW7tTP8lW8QwzIU4jM+0
	jthvry8yMYkR8Lnqn7SYqUuIz7Db8VwleEWhQzOOkI3slInOkntZl0BUfaJvBJrx
	7iGtiLMDOipI1wJBoGkPSWQN7pVrh8bOlvvANL7TRaVNz2y5ksQwAKIZ3tzSD0lt
	Q+nShLepD5tfXyVNqqc/kuKoBt8AsXZM87l1uQvtqlDwsAcb47Ts6KqZclRJaSLk
	ik0ylzYIPDkQhnEJsq2VjZSou5z0sTpaMMg==
X-ME-Sender: <xms:f8neaBMYb3xShGEJ_hziHcvQjZq36dIp48irancZuitIOKOuWzlJ-A>
    <xme:f8neaJ_xBU9C_Mp0eMxAf9kNz8bh-_xi81iqWRN3kGjDHi6H0jYHUN-6TDV9pN0DR
    Seu96HR3ttH07vh_GBqQCuFu_j0RpJd2T6PuU5p38EKDT5GSB7Ivlo>
X-ME-Received: <xmr:f8neaN6wedGQO534LI6LhGDP7chQcF8FVTOPDdEKsny3nHSYoEM2plijAwzs5OxRGR29PMBbU_RYG11gGr408p3kiek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecu
    ggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekudduteefke
    fffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:f8neaI0LOj7FqlciSZHVW9HkZlh366aILY7leGQGR72MQb8ezV_Kng>
    <xmx:f8neaMAW2nqxoK4KOcmUD1w2RyOA-wHQADFyk5gUZ6mtjkHftsVqIg>
    <xmx:f8neaC0b5FU9w_LG7rsXlzok5JkqjXeUxba8oRdiFNRm9x4KitJEHA>
    <xmx:f8neaOuymnHT2roQzuxoS2N7B709OFOg4Zz6UAbMIqe9vqL67KStvg>
    <xmx:f8neaAy_gqKzrOHtI2YBl1YjOy90iBFtfVHF9hqW9_b3RcotOOzAJtTh>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 14:50:38 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs: fix racy bitfield write in btrfs_clear_space_info_full()
Date: Thu,  2 Oct 2025 11:50:33 -0700
Message-ID: <22e8b64df3d4984000713433a89cfc14309b75fc.1759430967.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From the memory-barriers.txt document regarding memory barrier ordering
guarantees:

 (*) These guarantees do not apply to bitfields, because compilers often
     generate code to modify these using non-atomic read-modify-write
     sequences.  Do not attempt to use bitfields to synchronize parallel
     algorithms.

 (*) Even in cases where bitfields are protected by locks, all fields
     in a given bitfield must be protected by one lock.  If two fields
     in a given bitfield are protected by different locks, the compiler's
     non-atomic read-modify-write sequences can cause an update to one
     field to corrupt the value of an adjacent field.

btrfs_space_info has a bitfield sharing an underlying word consisting of
the fields full, chunk_alloc, and flush:

struct btrfs_space_info {
        struct btrfs_fs_info *     fs_info;              /*     0     8 */
        struct btrfs_space_info *  parent;               /*     8     8 */
        ...
        int                        clamp;                /*   172     4 */
        unsigned int               full:1;               /*   176: 0  4 */
        unsigned int               chunk_alloc:1;        /*   176: 1  4 */
        unsigned int               flush:1;              /*   176: 2  4 */
        ...

Therefore, to be safe from parallel read-modify-writes losing a write to one of the bitfield members protected by a lock, all writes to all the
bitfields must use the lock. They almost universally do, except for
btrfs_clear_space_info_full() which iterates over the space_infos and
writes out found->full = 0 without a lock.

Imagine that we have one thread completing a transaction in which we
finished deleting a block_group and are thus calling
btrfs_clear_space_info_full() while simultaneously the data reclaim
ticket infrastructure is running do_async_reclaim_data_space():

          T1                                             T2
btrfs_commit_transaction
  btrfs_clear_space_info_full
  data_sinfo->full = 0
  READ: full:0, chunk_alloc:0, flush:1
                                              do_async_reclaim_data_space(data_sinfo)
                                              spin_lock(&space_info->lock);
                                              if(list_empty(tickets))
                                                space_info->flush = 0;
                                                READ: full: 0, chunk_alloc:0, flush:1
                                                MOD/WRITE: full: 0, chunk_alloc:0, flush:0
                                                spin_unlock(&space_info->lock);
                                                return;
  MOD/WRITE: full:0, chunk_alloc:0, flush:1

and now data_sinfo->flush is 1 but the reclaim worker has exited. This
breaks the invariant that flush is 0 iff there is no work queued or
running. Once this invariant is violated, future allocations that go
into __reserve_bytes() will add tickets to space_info->tickets but will
see space_info->flush is set to 1 and not queue the work. After this,
they will block forever on the resulting ticket, as it is now impossible
to kick the worker again.

I also confirmed by looking at the assembly of the affected kernel that
it is doing RMW operations. For example, to set the flush (3rd) bit to 0,
the assembly is:
  andb    $0xfb,0x60(%rbx)
and similarly for setting the full (1st) bit to 0:
  andb    $0xfe,-0x20(%rax)

So I think this is really a bug on practical systems.  I have observed
a number of systems in this exact state, but am currently unable to
reproduce it.

Rather than leaving this footgun lying around for the future, take
advantage of the fact that there is room in the struct anyway, and that
it is already quite large and simply change the three bitfield members to
bools. This avoids writes to space_info->full having any effect on
writes to space_info->flush, regardless of locking.

Fixes: 957780eb2788 ("Btrfs: introduce ticketed enospc infrastructure")
Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v2:
- migrate the three bitfield members to bools to step around the whole
  atomic RMW issue in the most straightforward way.

---
 fs/btrfs/block-group.c |  6 +++---
 fs/btrfs/space-info.c  | 22 +++++++++++-----------
 fs/btrfs/space-info.h  |  6 +++---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 4330f5ba02dd..cd51f50a7c8b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4215,7 +4215,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
 			mutex_unlock(&fs_info->chunk_mutex);
 		} else {
 			/* Proceed with allocation */
-			space_info->chunk_alloc = 1;
+			space_info->chunk_alloc = true;
 			wait_for_alloc = false;
 			spin_unlock(&space_info->lock);
 		}
@@ -4264,7 +4264,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
 	spin_lock(&space_info->lock);
 	if (ret < 0) {
 		if (ret == -ENOSPC)
-			space_info->full = 1;
+			space_info->full = true;
 		else
 			goto out;
 	} else {
@@ -4274,7 +4274,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
 
 	space_info->force_alloc = CHUNK_ALLOC_NO_FORCE;
 out:
-	space_info->chunk_alloc = 0;
+	space_info->chunk_alloc = false;
 	spin_unlock(&space_info->lock);
 	mutex_unlock(&fs_info->chunk_mutex);
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0e5c0c80e0fe..04a07d6f8537 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -192,7 +192,7 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
 	struct btrfs_space_info *found;
 
 	list_for_each_entry(found, head, list)
-		found->full = 0;
+		found->full = false;
 }
 
 /*
@@ -372,7 +372,7 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	space_info->bytes_readonly += block_group->bytes_super;
 	btrfs_space_info_update_bytes_zone_unusable(space_info, block_group->zone_unusable);
 	if (block_group->length > 0)
-		space_info->full = 0;
+		space_info->full = false;
 	btrfs_try_granting_tickets(info, space_info);
 	spin_unlock(&space_info->lock);
 
@@ -1146,7 +1146,7 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
 	spin_lock(&space_info->lock);
 	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
 	if (!to_reclaim) {
-		space_info->flush = 0;
+		space_info->flush = false;
 		spin_unlock(&space_info->lock);
 		return;
 	}
@@ -1158,7 +1158,7 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
 		flush_space(fs_info, space_info, to_reclaim, flush_state, false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
-			space_info->flush = 0;
+			space_info->flush = false;
 			spin_unlock(&space_info->lock);
 			return;
 		}
@@ -1201,7 +1201,7 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
 					flush_state = FLUSH_DELAYED_ITEMS_NR;
 					commit_cycles--;
 				} else {
-					space_info->flush = 0;
+					space_info->flush = false;
 				}
 			} else {
 				flush_state = FLUSH_DELAYED_ITEMS_NR;
@@ -1383,7 +1383,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 
 	spin_lock(&space_info->lock);
 	if (list_empty(&space_info->tickets)) {
-		space_info->flush = 0;
+		space_info->flush = false;
 		spin_unlock(&space_info->lock);
 		return;
 	}
@@ -1394,7 +1394,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
-			space_info->flush = 0;
+			space_info->flush = false;
 			spin_unlock(&space_info->lock);
 			return;
 		}
@@ -1411,7 +1411,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 			    data_flush_states[flush_state], false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
-			space_info->flush = 0;
+			space_info->flush = false;
 			spin_unlock(&space_info->lock);
 			return;
 		}
@@ -1428,7 +1428,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 				if (maybe_fail_all_tickets(fs_info, space_info))
 					flush_state = 0;
 				else
-					space_info->flush = 0;
+					space_info->flush = false;
 			} else {
 				flush_state = 0;
 			}
@@ -1444,7 +1444,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 
 aborted_fs:
 	maybe_fail_all_tickets(fs_info, space_info);
-	space_info->flush = 0;
+	space_info->flush = false;
 	spin_unlock(&space_info->lock);
 }
 
@@ -1825,7 +1825,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 				 */
 				maybe_clamp_preempt(fs_info, space_info);
 
-				space_info->flush = 1;
+				space_info->flush = true;
 				trace_btrfs_trigger_flush(fs_info,
 							  space_info->flags,
 							  orig_bytes, flush,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 679f22efb407..a846f63585c9 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -142,11 +142,11 @@ struct btrfs_space_info {
 				   flushing. The value is >> clamp, so turns
 				   out to be a 2^clamp divisor. */
 
-	unsigned int full:1;	/* indicates that we cannot allocate any more
+	bool full;		/* indicates that we cannot allocate any more
 				   chunks for this space */
-	unsigned int chunk_alloc:1;	/* set if we are allocating a chunk */
+	bool chunk_alloc;	/* set if we are allocating a chunk */
 
-	unsigned int flush:1;		/* set if we are trying to make space */
+	bool flush;		/* set if we are trying to make space */
 
 	unsigned int force_alloc;	/* set if we need to force a chunk
 					   alloc for this space */
-- 
2.50.1


