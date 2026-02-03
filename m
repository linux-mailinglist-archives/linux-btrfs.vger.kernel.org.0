Return-Path: <linux-btrfs+bounces-21302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIkJLktlgWlMGAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21302-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 04:02:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CB8D3F64
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 04:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D0B6305263D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 03:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4409217659;
	Tue,  3 Feb 2026 03:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TkgpRYwD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TkgpRYwD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56FE347C7
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087719; cv=none; b=NuHmaAOHinkXSIjf3wOhGkJMwtIqlg1UpIMw9OHT1KTBJX4Js00uRqfYF3Gw1fwlyXM1xqPSnXqZdtgAsviQwB+fWDYZFD/hNxuQdAgsq2kfilDVHwPVNworJ55nfoSgymlm3aGmpc2QS1unyl0/EyNkg21M2ya2LY1mzhQVWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087719; c=relaxed/simple;
	bh=nUUFLvjAWHFfOpIzRsx6V4EkfQL1DMGpc/qwYbkM17Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVP03CLpF6elJ2c1jzzhNLqKlNVzho7GXaSkUdqsmaWncqYhsNtPlfuhVm4/9qYuSWcsB3NIo4NEU0KYdFbi+x0rr/8OsOyE2XJFz8oG8RtCC4MmF9fw8562LnYL+P67g4vPt1/SpY4VIyHuUgsscOy2VdF1pxaHFPdN8dt1bNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TkgpRYwD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TkgpRYwD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE7BB5BCC6
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 03:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770087712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFzMipFhTk3k7jQZo42Gh+a1A8QF35rK5ymazZD/oIA=;
	b=TkgpRYwDpC30Z6wzQUHgEIqHUi8Jze9HKkMzoD69vDu4NK3T4aOelC0OzjrYTZeIZPv73P
	/Us8sOwyFXCFiWezL4lpOOn9MyGaqaSu1g2vGptlLfvKsVYupE1yCr+MC3DYGigxMgGkG/
	TRh7U5ZCJqPiudfMb5/X9jnOqDsjWNo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TkgpRYwD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770087712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFzMipFhTk3k7jQZo42Gh+a1A8QF35rK5ymazZD/oIA=;
	b=TkgpRYwDpC30Z6wzQUHgEIqHUi8Jze9HKkMzoD69vDu4NK3T4aOelC0OzjrYTZeIZPv73P
	/Us8sOwyFXCFiWezL4lpOOn9MyGaqaSu1g2vGptlLfvKsVYupE1yCr+MC3DYGigxMgGkG/
	TRh7U5ZCJqPiudfMb5/X9jnOqDsjWNo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9D293EA62
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 03:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YCshJh9lgWnVUgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 03:01:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: update per-profile available estimation
Date: Tue,  3 Feb 2026 13:31:30 +1030
Message-ID: <6f0649b5b2bf087dbb9a881eac609bd939de7041.1770087101.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770087101.git.wqu@suse.com>
References: <cover.1770087101.git.wqu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21302-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 60CB8D3F64
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2348d4d5e0b5..43865c1ed445 100644
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
@@ -6002,6 +6011,8 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	check_raid56_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
 
+	btrfs_update_per_profile_avail(info);
+
 	return block_group;
 }
 
@@ -8574,7 +8585,14 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
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


