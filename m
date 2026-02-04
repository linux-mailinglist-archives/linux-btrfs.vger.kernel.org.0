Return-Path: <linux-btrfs+bounces-21349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF4GKO60gmnwYgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21349-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 03:54:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5140EE108F
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 03:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B36553051072
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 02:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514222D9481;
	Wed,  4 Feb 2026 02:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CcQxw93i";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CcQxw93i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D12D8DD9
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173676; cv=none; b=bBwrZjKKWOR44h7bg7vt/cycgxnq9uHwXH89PneYJy8rs4IMBTsnriKtKSmvDVCTCZnu/+E5ofS/EIzdWXyrD/sv1GzJwfCKPPkPOuRDmosacl0aZvKDHEFlndCYezGDB+Nm9L3K2t5c2Tz4sC5whK8SdPuZoGAyBVkglsxGubQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173676; c=relaxed/simple;
	bh=aGte7T8jeuUkseqWy067ePgmYbbuirDxFOoAQQLowCM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbkajM3ZzZeAMzYnSLU1a5EH8Rz1BGszmGs94ZDucI6hB64IyCQYAIqpUi4PwoSbKd01cs6/3XQMTgVh6UCQNKowN9sx8oSNP1IlDksXYjg8ArStFAKBYnwe6aHQEEKSWt4w7kYjX7hF6c6q61HizUz1Cfh9xA5H9wNxQkZKir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CcQxw93i; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CcQxw93i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E13C5BCC7
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 02:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770173673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UdMhVL8FW0WVs1BGMOROWORMpaziOv0Ykl9VkEKGIjU=;
	b=CcQxw93iqC4qfUvktC6Enj3HKjyk9buAUBo1AH/Ee2GAWkpn+4B9L4Gkb3lfTb6qDc3bj/
	j0b4Io9Mbk5U2Es7uDBxHCxP7g6+/dzG6k0H5LglpSEWu1L2bwshE5l9zU/O+LE0xNtpP3
	EI34kiHvo7NScQYc/4IOlhiUh++iLxM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CcQxw93i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770173673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UdMhVL8FW0WVs1BGMOROWORMpaziOv0Ykl9VkEKGIjU=;
	b=CcQxw93iqC4qfUvktC6Enj3HKjyk9buAUBo1AH/Ee2GAWkpn+4B9L4Gkb3lfTb6qDc3bj/
	j0b4Io9Mbk5U2Es7uDBxHCxP7g6+/dzG6k0H5LglpSEWu1L2bwshE5l9zU/O+LE0xNtpP3
	EI34kiHvo7NScQYc/4IOlhiUh++iLxM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69CD03EA63
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 02:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iHzrCui0gmknHAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 04 Feb 2026 02:54:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: update per-profile available estimation
Date: Wed,  4 Feb 2026 13:24:07 +1030
Message-ID: <b4d6fcecccd3c2c3b5359131e0493f190d1f5959.1770173615.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770173615.git.wqu@suse.com>
References: <cover.1770173615.git.wqu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21349-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5140EE108F
X-Rspamd-Action: no action

This involves the following timing:

- Chunk allocation
- Chunk removal
- After Mount
- New device
- Device removal
- Device shrink
- Device enlarge

And since the function btrfs_update_per_profile_avail() will not return
an error, this won't cause new error handling path.

Although when btrfs_update_per_profile_avail() failed (only ENOSPC
possible) it will mark the per-profile available estimation as
unreliable, so later btrfs_get_per_profile_avail() will return false and
require the caller to have a fallback solution.

The function btrfs_update_per_profile_avail() will be executed with
chunk_mutex hold, thus it will slightly slow down those involved
functions, but not a lot.

As all the core workload is just various u64 calculations inside a loop,
without any tree search, the overhead should be acceptable even for all
supported 9 profiles.

For 4 disks (which exercises all 9 profiles), the execution time of that
function will still be less than 10 us.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a28e7400e8dc..af21af777110 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2339,6 +2339,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		mutex_lock(&fs_info->chunk_mutex);
 		list_del_init(&device->dev_alloc_list);
 		device->fs_devices->rw_devices--;
+		btrfs_update_per_profile_avail(fs_info);
 		mutex_unlock(&fs_info->chunk_mutex);
 	}
 
@@ -2450,6 +2451,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		list_add(&device->dev_alloc_list,
 			 &fs_devices->alloc_list);
 		device->fs_devices->rw_devices++;
+		btrfs_update_per_profile_avail(fs_info);
 		mutex_unlock(&fs_info->chunk_mutex);
 	}
 	return ret;
@@ -2937,6 +2939,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	 */
 	btrfs_clear_space_info_full(fs_info);
 
+	btrfs_update_per_profile_avail(fs_info);
 	mutex_unlock(&fs_info->chunk_mutex);
 
 	/* Add sysfs device entry */
@@ -2947,6 +2950,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (seeding_dev) {
 		mutex_lock(&fs_info->chunk_mutex);
 		ret = init_first_rw_device(trans);
+		btrfs_update_per_profile_avail(fs_info);
 		mutex_unlock(&fs_info->chunk_mutex);
 		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
@@ -3029,6 +3033,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 				    orig_super_total_bytes);
 	btrfs_set_super_num_devices(fs_info->super_copy,
 				    orig_super_num_devices);
+	btrfs_update_per_profile_avail(fs_info);
 	mutex_unlock(&fs_info->chunk_mutex);
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 error_trans:
@@ -3121,6 +3126,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 	if (list_empty(&device->post_commit_list))
 		list_add_tail(&device->post_commit_list,
 			      &trans->transaction->dev_update_list);
+	btrfs_update_per_profile_avail(fs_info);
 	mutex_unlock(&fs_info->chunk_mutex);
 
 	btrfs_reserve_chunk_metadata(trans, false);
@@ -3497,6 +3503,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		}
 	}
 
+	btrfs_update_per_profile_avail(fs_info);
 	mutex_unlock(&fs_info->chunk_mutex);
 	trans->removing_chunk = false;
 
@@ -5185,6 +5192,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 		atomic64_sub(free_diff, &fs_info->free_chunk_space);
 	}
 
+	btrfs_update_per_profile_avail(fs_info);
 	/*
 	 * Once the device's size has been set to the new size, ensure all
 	 * in-memory chunks are synced to disk so that the loop below sees them
@@ -5300,6 +5308,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	WARN_ON(diff > old_total);
 	btrfs_set_super_total_bytes(super_copy,
 			round_down(old_total - diff, fs_info->sectorsize));
+	btrfs_update_per_profile_avail(fs_info);
 	mutex_unlock(&fs_info->chunk_mutex);
 
 	btrfs_reserve_chunk_metadata(trans, false);
@@ -6012,6 +6021,8 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	check_raid56_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
 
+	btrfs_update_per_profile_avail(info);
+
 	return block_group;
 }
 
@@ -8584,7 +8595,14 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	}
 
 	/* Ensure all chunks have corresponding dev extents */
-	return verify_chunk_dev_extent_mapping(fs_info);
+	ret = verify_chunk_dev_extent_mapping(fs_info);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&fs_info->chunk_mutex);
+	btrfs_update_per_profile_avail(fs_info);
+	mutex_unlock(&fs_info->chunk_mutex);
+	return 0;
 }
 
 /*
-- 
2.52.0


