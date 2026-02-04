Return-Path: <linux-btrfs+bounces-21351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LJjCvW0gmnwYgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21351-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 03:54:45 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 126E5E1096
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 03:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0ED01305480D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 02:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE152D9484;
	Wed,  4 Feb 2026 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XY+MBTny";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XY+MBTny"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB432D9481
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 02:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173682; cv=none; b=Z5wBw13kQCox7PZq9Evbi2r4YObLLMInKPOf769JRzPk520zmjk+L5Tg+OCIW5A5dYbr8WcgL24yyqZTPL0ZJ4nbNsJ/xh2nX2cdOCqVYuIke83DNX/Xh69xjN2bONtByRQAm5UnxOKCRISE16g74clZ2TLkQbCiYf58gH0Eee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173682; c=relaxed/simple;
	bh=qO50DjIbCfaC+odm5zGh8ThTFrxC9SsNIpQz28560l0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxafMm5RbqebNth0Sb/lhdxCy/gqItgfPNsHuG0AVxk7pFTC+fcDG8OhOat99C/DhW8t5na68ozRwY6eDBzSzmopiPTGxukl4PAPUry5/yyimi5Y8z61H1xycz6ZErJuFVQ1fpbDzXRZzHfIIlUeTcQ3Fhu+w7UJfYrHI/37apg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XY+MBTny; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XY+MBTny; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C8CF5BCCB
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 02:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770173674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JoReeVm8Ez2F3dzjnNjgihpuRtTDFfUzbrGhRSnh3jU=;
	b=XY+MBTnynrhfwvLzlzY6/n+55uWPVVrJpaf4zU7eAS4dCM/sBb7FzQdCne14HH7JusVqvJ
	sYhdha6cHmdMaX2K47oPq2RsfpLa3EX3ed4EcDbn1ytEPbykilIuFy7F6CoHicYIBgTxuM
	2j/49ExV68obn4UOTDYyDI5UM2P0PVY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XY+MBTny
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770173674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JoReeVm8Ez2F3dzjnNjgihpuRtTDFfUzbrGhRSnh3jU=;
	b=XY+MBTnynrhfwvLzlzY6/n+55uWPVVrJpaf4zU7eAS4dCM/sBb7FzQdCne14HH7JusVqvJ
	sYhdha6cHmdMaX2K47oPq2RsfpLa3EX3ed4EcDbn1ytEPbykilIuFy7F6CoHicYIBgTxuM
	2j/49ExV68obn4UOTDYyDI5UM2P0PVY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A96D13EA63
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 02:54:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AGViGum0gmknHAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 04 Feb 2026 02:54:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: use per-profile available space in calc_available_free_space()
Date: Wed,  4 Feb 2026 13:24:08 +1030
Message-ID: <9972fe271795271b21f9cd0db81d450473993374.1770173615.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
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
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21351-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 126E5E1096
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


