Return-Path: <linux-btrfs+bounces-13067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEB1A8B4DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 11:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 080987A9F4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8985E23496B;
	Wed, 16 Apr 2025 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gXT8Xtdq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gXT8Xtdq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81402356DF
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794519; cv=none; b=XAsaB5AtG99lXt5DYs9cqOYhLL01GFEdt3EWoPCevs+JwdCSzVUAGoa65GThhd9cKfkP7XHNozmBvCE5NVvdjt6Rojp/SOxvfqXvOi7V503SL3qolGKM123HaM+tqWehiqOfT1JFV7bWss+US2eLnYNH1MvQSkKj62Nfs6idm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794519; c=relaxed/simple;
	bh=IRevMO4hPXO9LYnYjOVHGVcENSr7lLjXqX/KeeG0jwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwSRAi2Y894UcculKuh9ceblOo6XNOAxb7jo/QBmZCx8m4EX6+0te9jMjoksJQOSfXK/TCCSY1wpTXphFAiYEJBrVwjxfWjKDVuVq6Mz6TwOCCzHQ4wdPQT6JgX0ftbUXzPWyX07RbJTxSI2XoT29WvYh+rofy4uFIuWVGOzzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gXT8Xtdq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gXT8Xtdq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F5C01F445;
	Wed, 16 Apr 2025 09:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744794513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZftPzvm+NMQG9r5A3pIrG6lqVrwDG66ufoMUeycmhbs=;
	b=gXT8XtdqEkpslw6lhr5pRSf7/klS+T49SMbSlCb25XyzjKShoBOm2Fr+y+Ma+1DNjMcqP3
	M9sCInvGBmovwWtQJPgkvW+AkdO+0SU6MzUvauOsgXSCSbJUvPF9LOsfO5WZ/Td2W1tYpa
	MLIzF7PUc+wp8uThhEEXT4PyAkggb+8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744794513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZftPzvm+NMQG9r5A3pIrG6lqVrwDG66ufoMUeycmhbs=;
	b=gXT8XtdqEkpslw6lhr5pRSf7/klS+T49SMbSlCb25XyzjKShoBOm2Fr+y+Ma+1DNjMcqP3
	M9sCInvGBmovwWtQJPgkvW+AkdO+0SU6MzUvauOsgXSCSbJUvPF9LOsfO5WZ/Td2W1tYpa
	MLIzF7PUc+wp8uThhEEXT4PyAkggb+8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 979DD13976;
	Wed, 16 Apr 2025 09:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hL8BJZFz/2ddbAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 16 Apr 2025 09:08:33 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs: convert ASSERT(0) to DEBUG_WARN()
Date: Wed, 16 Apr 2025 11:08:12 +0200
Message-ID: <b1d08327008deb6bb7522230ec5bef559012376a.1744794336.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744794336.git.dsterba@suse.com>
References: <cover.1744794336.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The use of ASSERT(0) is maybe useful for some cases but more like a
notice for developers. Assertions can be compiled in independently so
convert it to a debugging helper.

The difference is that it's just a warning and will not end up in BUG().
All the cases need a review and possibly be modified:

- delete it completely if the purpose is not clear
- replace/update by proper error handling
- replace by verbose error and BUG()/transaction abort if continuation
  is not possible at all
- use DEBUG_WARN()

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c         |  2 +-
 fs/btrfs/delayed-ref.c     |  2 +-
 fs/btrfs/dev-replace.c     |  2 +-
 fs/btrfs/extent_io.c       |  2 +-
 fs/btrfs/extent_map.c      |  2 +-
 fs/btrfs/free-space-tree.c | 27 +++++++++++++++------------
 fs/btrfs/relocation.c      |  4 ++--
 fs/btrfs/send.c            |  4 ++--
 fs/btrfs/space-info.c      |  2 +-
 fs/btrfs/volumes.c         |  7 ++++---
 fs/btrfs/zoned.c           |  2 +-
 11 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e76e1845cfce14..6ee0259048cd3e 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3617,7 +3617,7 @@ int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
 
 		/* Sanity check, we shouldn't have any unchecked nodes */
 		if (!upper->checked) {
-			ASSERT(0);
+			DEBUG_WARN("we should not have any unchecked nodes");
 			return -EUCLEAN;
 		}
 
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 739c9e29aaa389..2009eb7cce334c 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -613,7 +613,7 @@ static bool insert_delayed_ref(struct btrfs_trans_handle *trans,
 				ASSERT(!list_empty(&exist->add_list));
 				list_del_init(&exist->add_list);
 			} else {
-				ASSERT(0);
+				DEBUG_WARN("unknown ref->action=%d", ref->action);
 			}
 		} else
 			mod = -ref->ref_mod;
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 483e71e09181ff..5c26f0fcf0d500 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -637,7 +637,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		break;
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
-		ASSERT(0);
+		DEBUG_WARN("unexpected STARTED ot SUSPENDED dev-replace state");
 		ret = BTRFS_IOCTL_DEV_REPLACE_RESULT_ALREADY_STARTED;
 		up_write(&dev_replace->rwsem);
 		goto leave;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fcd830a0bce20c..03d9bc1fcb51fd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3258,7 +3258,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * using 0-order folios.
 		 */
 		if (unlikely(ret == -EAGAIN)) {
-			ASSERT(0);
+			DEBUG_WARN("folio order mismatch between new eb and filemap");
 			goto reallocate;
 		}
 		attached++;
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 02bfdb976e40ce..d9b3282b1af2bc 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -313,7 +313,7 @@ static void dump_extent_map(struct btrfs_fs_info *fs_info, const char *prefix,
 "%s, start=%llu len=%llu disk_bytenr=%llu disk_num_bytes=%llu ram_bytes=%llu offset=%llu flags=0x%x",
 		prefix, em->start, em->len, em->disk_bytenr, em->disk_num_bytes,
 		em->ram_bytes, em->offset, em->flags);
-	ASSERT(0);
+	BUG();
 }
 
 /* Internal sanity checks for btrfs debug builds. */
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 39c6b96a4c25a8..6886992f24d1e3 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -117,7 +117,7 @@ struct btrfs_free_space_info *search_free_space_info(
 	if (ret != 0) {
 		btrfs_warn(fs_info, "missing free space info for %llu",
 			   block_group->start);
-		ASSERT(0);
+		DEBUG_WARN();
 		return ERR_PTR(-ENOENT);
 	}
 
@@ -141,12 +141,12 @@ static int btrfs_search_prev_slot(struct btrfs_trans_handle *trans,
 		return ret;
 
 	if (ret == 0) {
-		ASSERT(0);
+		DEBUG_WARN();
 		return -EIO;
 	}
 
 	if (p->slots[0] == 0) {
-		ASSERT(0);
+		DEBUG_WARN("no previous slot found");
 		return -EIO;
 	}
 	p->slots[0]--;
@@ -266,7 +266,8 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 				nr++;
 				path->slots[0]--;
 			} else {
-				ASSERT(0);
+				DEBUG_WARN("unexpected free space extent key type %d found",
+					   found_key.type);
 			}
 		}
 
@@ -293,7 +294,7 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 			  "incorrect extent count for %llu; counted %u, expected %u",
 			  block_group->start, extent_count,
 			  expected_extent_count);
-		ASSERT(0);
+		DEBUG_WARN();
 		ret = -EIO;
 		goto out;
 	}
@@ -407,7 +408,8 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 				nr++;
 				path->slots[0]--;
 			} else {
-				ASSERT(0);
+				DEBUG_WARN("unexpected free space bitmap key type %d found",
+					   found_key.type);
 			}
 		}
 
@@ -455,7 +457,7 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 			  "incorrect extent count for %llu; counted %u, expected %u",
 			  block_group->start, extent_count,
 			  expected_extent_count);
-		ASSERT(0);
+		DEBUG_WARN();
 		ret = -EIO;
 		goto out;
 	}
@@ -843,7 +845,7 @@ int remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 
 	block_group = btrfs_lookup_block_group(trans->fs_info, start);
 	if (!block_group) {
-		ASSERT(0);
+		DEBUG_WARN("no block group found for start=%llu", start);
 		ret = -ENOENT;
 		goto out;
 	}
@@ -1036,7 +1038,7 @@ int add_to_free_space_tree(struct btrfs_trans_handle *trans,
 
 	block_group = btrfs_lookup_block_group(trans->fs_info, start);
 	if (!block_group) {
-		ASSERT(0);
+		DEBUG_WARN("no block group found for start=%llu", start);
 		ret = -ENOENT;
 		goto out;
 	}
@@ -1463,7 +1465,8 @@ int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 				nr++;
 				path->slots[0]--;
 			} else {
-				ASSERT(0);
+				DEBUG_WARN("unexpected free space key type %d found",
+					   found_key.type);
 			}
 		}
 
@@ -1555,7 +1558,7 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 			  "incorrect extent count for %llu; counted %u, expected %u",
 			  block_group->start, extent_count,
 			  expected_extent_count);
-		ASSERT(0);
+		DEBUG_WARN();
 		ret = -EIO;
 		goto out;
 	}
@@ -1619,7 +1622,7 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
 			  "incorrect extent count for %llu; counted %u, expected %u",
 			  block_group->start, extent_count,
 			  expected_extent_count);
-		ASSERT(0);
+		DEBUG_WARN();
 		ret = -EIO;
 		goto out;
 	}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 19acdd9ede7964..27fdfeb7d04326 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1931,11 +1931,11 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 	 * reloc root without a corresponding root this could return ENOENT.
 	 */
 	if (IS_ERR(root)) {
-		ASSERT(0);
+		DEBUG_WARN("error %ld reading root for reloc root", PTR_ERR(root));
 		return PTR_ERR(root);
 	}
 	if (root->reloc_root != reloc_root) {
-		ASSERT(0);
+		DEBUG_WARN("unexpected reloc root found");
 		btrfs_err(fs_info,
 			  "root %llu has two reloc roots associated with it",
 			  reloc_root->root_key.offset);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f0e49a813ccbbf..0315fd56242667 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -383,11 +383,11 @@ static void inconsistent_snapshot_error(struct send_ctx *sctx,
 		result_string = "updated";
 		break;
 	case BTRFS_COMPARE_TREE_SAME:
-		ASSERT(0);
+		DEBUG_WARN("no change between trees");
 		result_string = "unchanged";
 		break;
 	default:
-		ASSERT(0);
+		DEBUG_WARN("unexpected comparison result %d", result);
 		result_string = "unexpected";
 	}
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 77cc5d4a5a4774..434df9aa9b7123 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1584,7 +1584,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 		priority_reclaim_data_space(fs_info, space_info, ticket);
 		break;
 	default:
-		ASSERT(0);
+		DEBUG_WARN("unknown flush state %d", flush);
 		break;
 	}
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e8b944aeb2e189..284bac76dbef8c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3342,7 +3342,8 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		 * user having built with ASSERT enabled, so if ASSERT doesn't
 		 * do anything we still error out.
 		 */
-		ASSERT(0);
+		DEBUG_WARN("errr %ld reading chunk map at offset %llu",
+			   PTR_ERR(map), chunk_offset);
 		return PTR_ERR(map);
 	}
 
@@ -5665,7 +5666,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 	lockdep_assert_held(&info->chunk_mutex);
 
 	if (!alloc_profile_is_valid(type, 0)) {
-		ASSERT(0);
+		DEBUG_WARN("invalid alloc profile for type %llu", type);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -5677,7 +5678,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 
 	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
 		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
-		ASSERT(0);
+		DEBUG_WARN();
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 7b30700ec9304f..7fc2f73dc8d8a6 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -989,7 +989,7 @@ int btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
 	}
 
 	/* All the zones are FULL. Should not reach here. */
-	ASSERT(0);
+	DEBUG_WARN("unexpected state, all zones full");
 	return -EIO;
 }
 
-- 
2.49.0


