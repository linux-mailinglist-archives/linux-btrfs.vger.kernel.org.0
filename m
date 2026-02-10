Return-Path: <linux-btrfs+bounces-21573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCiINgmlimmhMgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21573-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 04:24:57 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8162F116BAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 04:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E367C300A32C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 03:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4BB2F28E3;
	Tue, 10 Feb 2026 03:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SlXnIKcs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SlXnIKcs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881162EC54C
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770693895; cv=none; b=LCJXwwgGQOt9kLmGQOdikXCfHHvbK5q3nCULxz33plGtsDxDjdnBLNHHcq2jHWxGAOoXEeRfrOm8QocIglEtYokPehQjmEVHByQda+j4ApkrEw1f65h3ufV2JId4JDf1xyMfdHchjR3HbXUT4w7iR1RDn9oJobhQwAsP8X8FQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770693895; c=relaxed/simple;
	bh=ev6r4T8VBe1ElvJ39TmrOwz1QFuLmi9BMKB3R0AehVA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xh41XYezP0hU8RhAnizljEPllGD54voaJUB3yhNztq3mEsNhBKSlRtISk4k9l7n5YJ5CosT7EI7cx/QvFrqfbUnNBfFWpM+eylAc1Fx7H6+Bb6nIXvR2OamK3GlhNxiFl1+CN3BQ8hMZQFfQpfUKnz1GdE00Fz6fX9VmLHlD6fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SlXnIKcs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SlXnIKcs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B91285BD32
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770693892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02Cu6t8wq61INDr0D/B8V4SuLAgVH0+uSUaIY08u3NY=;
	b=SlXnIKcspI2TM8qpiayJW4tP0ygJVMYLDVbawB+KJnaqxqYYcx3SSYfXNJk0tRmaW3HOCq
	uoHP097lLE9bMkP2ZV3asIzJ4ZYsvZnf+wjWtapTcY0c0FvwSfN4kHce3dBnSBiTpwpMs9
	5/r+xZpGyf7k3lpu78h5sM2xgN5Lejg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SlXnIKcs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770693892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02Cu6t8wq61INDr0D/B8V4SuLAgVH0+uSUaIY08u3NY=;
	b=SlXnIKcspI2TM8qpiayJW4tP0ygJVMYLDVbawB+KJnaqxqYYcx3SSYfXNJk0tRmaW3HOCq
	uoHP097lLE9bMkP2ZV3asIzJ4ZYsvZnf+wjWtapTcY0c0FvwSfN4kHce3dBnSBiTpwpMs9
	5/r+xZpGyf7k3lpu78h5sM2xgN5Lejg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9AEB3EA62
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2NWRFQOlimkrEgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: rename btrfs_ordered_extent::list to csum_list
Date: Tue, 10 Feb 2026 13:54:29 +1030
Message-ID: <582c49225cb10091a849c8302a69e53617760c91.1770693583.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770693583.git.wqu@suse.com>
References: <cover.1770693583.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21573-lists,linux-btrfs=lfdr.de];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8162F116BAB
X-Rspamd-Action: no action

That list head records all pending checksums for that ordered
extent. And unlike other lists, we just use the name "list", which can
be very confusing for readers.

Rename it to "csum_list" which follows the remaining lists, showing the
purpose of the list.

And since we're here, remove a comment inside
btrfs_finish_ordered_zoned() where we have
"ASSERT(!list_empty(&ordered->csum_list))" to make sure the OE has
pending csums.

That comment is only here to make sure we do not call list_first_entry()
before checking BTRFS_ORDERED_PREALLOC.
But since we already have that bit checked and even have a dedicated
ASSERT(), there is no need for that comment anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c        |  6 +++---
 fs/btrfs/ordered-data.c | 10 +++++-----
 fs/btrfs/ordered-data.h |  2 +-
 fs/btrfs/tree-log.c     |  2 +-
 fs/btrfs/zoned.c        |  7 +++----
 5 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 826809977df5..73c193a38b80 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3258,8 +3258,8 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 
 	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
 		/* Logic error */
-		ASSERT(list_empty(&ordered_extent->list));
-		if (unlikely(!list_empty(&ordered_extent->list))) {
+		ASSERT(list_empty(&ordered_extent->csum_list));
+		if (unlikely(!list_empty(&ordered_extent->csum_list))) {
 			ret = -EINVAL;
 			btrfs_abort_transaction(trans, ret);
 			goto out;
@@ -3308,7 +3308,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	ret = add_pending_csums(trans, &ordered_extent->list);
+	ret = add_pending_csums(trans, &ordered_extent->csum_list);
 	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 5df02c707aee..a17f18673bed 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -197,7 +197,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	entry->flags = flags;
 	refcount_set(&entry->refs, 1);
 	init_waitqueue_head(&entry->wait);
-	INIT_LIST_HEAD(&entry->list);
+	INIT_LIST_HEAD(&entry->csum_list);
 	INIT_LIST_HEAD(&entry->log_list);
 	INIT_LIST_HEAD(&entry->root_extent_list);
 	INIT_LIST_HEAD(&entry->work_list);
@@ -329,7 +329,7 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 	struct btrfs_inode *inode = entry->inode;
 
 	spin_lock(&inode->ordered_tree_lock);
-	list_add_tail(&sum->list, &entry->list);
+	list_add_tail(&sum->list, &entry->csum_list);
 	spin_unlock(&inode->ordered_tree_lock);
 }
 
@@ -628,7 +628,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 		ASSERT(list_empty(&entry->log_list));
 		ASSERT(RB_EMPTY_NODE(&entry->rb_node));
 		btrfs_add_delayed_iput(entry->inode);
-		list_for_each_entry_safe(sum, tmp, &entry->list, list)
+		list_for_each_entry_safe(sum, tmp, &entry->csum_list, list)
 			kvfree(sum);
 		kmem_cache_free(btrfs_ordered_extent_cache, entry);
 	}
@@ -1323,10 +1323,10 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 		}
 	}
 
-	list_for_each_entry_safe(sum, tmpsum, &ordered->list, list) {
+	list_for_each_entry_safe(sum, tmpsum, &ordered->csum_list, list) {
 		if (offset == len)
 			break;
-		list_move_tail(&sum->list, &new->list);
+		list_move_tail(&sum->list, &new->csum_list);
 		offset += sum->len;
 	}
 
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 1e6b0b182b29..e178d4a489af 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -134,7 +134,7 @@ struct btrfs_ordered_extent {
 	struct btrfs_inode *inode;
 
 	/* list of checksums for insertion when the extent io is done */
-	struct list_head list;
+	struct list_head csum_list;
 
 	/* used for fast fsyncs */
 	struct list_head log_list;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e2806ca410f6..6ff1fe284ee9 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5063,7 +5063,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 		if (test_and_set_bit(BTRFS_ORDERED_LOGGED_CSUM, &ordered->flags))
 			continue;
 
-		list_for_each_entry(sums, &ordered->list, list) {
+		list_for_each_entry(sums, &ordered->csum_list, list) {
 			ret = log_csums(trans, inode, log_root, sums);
 			if (ret)
 				return ret;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ae6f61bcefca..f3049890368c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2114,9 +2114,8 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 	if (test_bit(BTRFS_ORDERED_PREALLOC, &ordered->flags))
 		return;
 
-	ASSERT(!list_empty(&ordered->list));
-	/* The ordered->list can be empty in the above pre-alloc case. */
-	sum = list_first_entry(&ordered->list, struct btrfs_ordered_sum, list);
+	ASSERT(!list_empty(&ordered->csum_list));
+	sum = list_first_entry(&ordered->csum_list, struct btrfs_ordered_sum, list);
 	logical = sum->logical;
 	len = sum->len;
 
@@ -2147,7 +2146,7 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 	 */
 	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
 	    test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state)) {
-		while ((sum = list_first_entry_or_null(&ordered->list,
+		while ((sum = list_first_entry_or_null(&ordered->csum_list,
 						       typeof(*sum), list))) {
 			list_del(&sum->list);
 			kfree(sum);
-- 
2.52.0


