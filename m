Return-Path: <linux-btrfs+bounces-21303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJqqIltlgWlMGAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21303-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 04:02:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32269D3F6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 04:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FFEC3055801
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 03:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D097B1F0995;
	Tue,  3 Feb 2026 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D/Z4qD0V";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WZoue+Xx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B743BB57
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 03:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087725; cv=none; b=s4z3KmC17IX4sb09xusqOwV+Fb3f5hyo3cdN95kOmykrtajCdPIfWB14LpQUem6mKM4Unis4rYwAHjUQj0AzzCQ5hVMGsL6HmAI4G8uMdlzhmCare5SCoZmeuX65uscZAW0S0cl7IoahRdlGjEswbopf5cBDa74Lws6NZeSEpKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087725; c=relaxed/simple;
	bh=qO50DjIbCfaC+odm5zGh8ThTFrxC9SsNIpQz28560l0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mq0JFECz3gX7lvlmF7XwLIipBghBZa6Lm4GyaveRNmLrBl8id7Mrti9Gt6Jg5ePafhgOdDn0bKPN36ZO/w+lZO46/ZZYkrpN40mqn4bEcMTOqU46mqW5rDm01Rhuy4ftG8CQPRl+8ljbKIng6FFc7E7uU1vR/sDGYPX9jjzRKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D/Z4qD0V; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WZoue+Xx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED11C5BCC3
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 03:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770087714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JoReeVm8Ez2F3dzjnNjgihpuRtTDFfUzbrGhRSnh3jU=;
	b=D/Z4qD0V1pHxYs3gTMuVqfk/9SPeedCjeCFya2+Fbk8/TJo4j0MYdY5Tnx7qT2sAikn2SX
	alWZ8cuI9A9GevX/zAjZ2kJTwB20fOpuxq2HPH/R7x9kwsU3w+ZEDhTX61Y8LRBDfVO5Pg
	i0fieFdfeKl4LwWyjl/mBJjMPaosNTI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WZoue+Xx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770087713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JoReeVm8Ez2F3dzjnNjgihpuRtTDFfUzbrGhRSnh3jU=;
	b=WZoue+XxqmVDKqfQNWurbqBPpzczEhDy85qqAHdCt4uSmzpiq3e+WwLJJrii7OoMUSbezx
	07r8I8EfE0xSsB/elffd/kn2kkn0bm4z1T9krHd95VsOSMJ1EuvfHUQq/ddWK27HO4ybJP
	EVZIInt7IlGCHWgdGGZICro6IxZtAN8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 258AA3EA62
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 03:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6LvBNSBlgWnVUgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 03:01:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: use per-profile available space in calc_available_free_space()
Date: Tue,  3 Feb 2026 13:31:31 +1030
Message-ID: <f09490cb717f184549b937d3c3ec0bbd63c7b46a.1770087101.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
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
	TAGGED_FROM(0.00)[bounces-21303-lists,linux-btrfs=lfdr.de];
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
X-Rspamd-Queue-Id: 32269D3F6B
X-Rspamd-Action: no action

For the following disk layout, can_overcommit() can cause false
confidence in available space:

  devid 1 unallocated:	1GiB
  devid 2 unallocated:	50GiB
  metadata type:	RAID1

As can_overcommit() simply uses unallocated space with factor to
calculate the allocatable metadata chunk size, resulting 25.5GiB
available space.

But in reality we can only allocate one 1GiB RAID1 chunk, the remaining
49GiB on devid 2 will never be utilized to fulfill a RAID1 chunk.

This leads to various ENOSPC related transaction abort and flips the fs
read-only.

Now use per-profile available space in calc_available_free_space(), and
only when that failed we fall back to the old factor based estimation.

And for zoned devices or for the very low chance of temporary memory
allocation failure, we will still fallback to factor based estimation.
But I hope in reality it's very rare.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/space-info.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index bb5aac7ee9d2..78b771d656b9 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -444,6 +444,7 @@ static u64 calc_available_free_space(const struct btrfs_space_info *space_info,
 				     enum btrfs_reserve_flush_enum flush)
 {
 	struct btrfs_fs_info *fs_info = space_info->fs_info;
+	bool has_per_profile;
 	u64 profile;
 	u64 avail;
 	u64 data_chunk_size;
@@ -454,19 +455,21 @@ static u64 calc_available_free_space(const struct btrfs_space_info *space_info,
 	else
 		profile = btrfs_metadata_alloc_profile(fs_info);
 
-	avail = atomic64_read(&fs_info->free_chunk_space);
-
-	/*
-	 * If we have dup, raid1 or raid10 then only half of the free
-	 * space is actually usable.  For raid56, the space info used
-	 * doesn't include the parity drive, so we don't have to
-	 * change the math
-	 */
-	factor = btrfs_bg_type_to_factor(profile);
-	avail = div_u64(avail, factor);
-	if (avail == 0)
-		return 0;
+	has_per_profile = btrfs_get_per_profile_avail(fs_info, profile, &avail);
+	if (!has_per_profile) {
+		avail = atomic64_read(&fs_info->free_chunk_space);
 
+		/*
+		 * If we have dup, raid1 or raid10 then only half of the free
+		 * space is actually usable.  For raid56, the space info used
+		 * doesn't include the parity drive, so we don't have to
+		 * change the math
+		 */
+		factor = btrfs_bg_type_to_factor(profile);
+		avail = div_u64(avail, factor);
+		if (avail == 0)
+			return 0;
+	}
 	data_chunk_size = calc_effective_data_chunk_size(fs_info);
 
 	/*
-- 
2.52.0


