Return-Path: <linux-btrfs+bounces-5781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4671890C405
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 08:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93C81F22692
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 06:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AEB6F068;
	Tue, 18 Jun 2024 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DCZgiweO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DCZgiweO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811CC210F8
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693478; cv=none; b=MYKQI5+LQcszKK8X+KyMkuv5Y387wwBqjJcTULrp7fpvuZmrbTGF9ij8MniYZ+22OIiSL96ejwQyCFFp9wt4MYAd2a9xsTEvHfRXpUzGjtAUdJ8OF15jL75ERE4/K23Q6hMjqkRTdQX9bPp+fzmP2hyi4xP+ZYDP4L2x20Qhp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693478; c=relaxed/simple;
	bh=k12AEBGc7nCNBQXaOB46zdsCZMtUjziUStIyAsNstsY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mgf8pzmR33Uul24npLCmyvIVCb0ZRmuzSc86SWlyNu6ZJJo5kNmiewVT8H33XS59a8bj3Eh9I0dwhlw7vM4vtV3Y0wnUSVhnHFvcq+TRulsAiYPkz4TOxo839sjP594u6TlmegD8Wzg8VAUWrv4snnwMLAxWdIL5LQeeU5zWf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DCZgiweO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DCZgiweO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B227E22805
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718693473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEleke7vIjYg16jnSyikfqs5Lm7/9hLfRPI6DcIelGI=;
	b=DCZgiweOzr+p0DKCat/idIliSretgmsFfGw6dstNZQ4KH9YaC5DTNIL5dQhbraG9u0eSAD
	lWFwJU6g8roUGPeDwzgoenPWqOdqJwPV7b9cwZlWBKLdj75AxsOkxbHHnaEqzbvuHCv0oi
	6jhCWLHpiybCiw9uhgp3/JexhJhB89U=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718693473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEleke7vIjYg16jnSyikfqs5Lm7/9hLfRPI6DcIelGI=;
	b=DCZgiweOzr+p0DKCat/idIliSretgmsFfGw6dstNZQ4KH9YaC5DTNIL5dQhbraG9u0eSAD
	lWFwJU6g8roUGPeDwzgoenPWqOdqJwPV7b9cwZlWBKLdj75AxsOkxbHHnaEqzbvuHCv0oi
	6jhCWLHpiybCiw9uhgp3/JexhJhB89U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C69161369F
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aIH3HmAucWZ+ZQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:51:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: change-csum: fix the wrong metadata space reservation
Date: Tue, 18 Jun 2024 16:20:48 +0930
Message-ID: <0a232d728355ecc03465933b70b2b3d682858820.1718693318.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718693318.git.wqu@suse.com>
References: <cover.1718693318.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

[BUG]
`btrfstune --csum` would always fail for a newly created btrfs:

 # truncates -s 1G test.img
 # ./mkfs.btrfs -f test.img
 # ./btrsftune --csum xxhash test.img
 WARNING: Experimental build with unstable or unfinished features
 WARNING: Switching checksums is experimental, do not use for valuable data!

 Proceed to switch checksums
 ERROR: failed to start transaction: Unknown error -28
 ERROR: failed to start transaction: No space left on device
 ERROR: failed to generate new data csums: No space left on device
 ERROR: btrfstune failed

[CAUSE]
After commit e79f18a4a75f ("btrfs-progs: introduce a basic metadata free
space reservation check"), btrfs_start_transaction() would check the
metadata space.

But at the time of introduction of csum conversion, the parameter for
btrfs_start_transaction() is incorrect.

The 2nd parameter is the *number* of items to be added (if we're
deleting items, just pass 1).
However commit 08a3bd7694b6 ("btrfs-progs: tune: add the ability to
generate new data checksums") is using the item size, not the number of
items to be added.

This means we're passing a number 8 * nodesize times larger than the
original size, no wonder we would error out with -ENOSPC.

[FIX]
Use proper calcuation to convert the new csum item size to number of
leaves needed, and double it just in case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index f5fc3c7f32cb..371e0aa76fc1 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -224,14 +224,26 @@ out:
  * item.
  */
 #define CSUM_CHANGE_BYTES_THRESHOLD	(SZ_2M)
+
+static unsigned int calc_csum_change_nr_items(struct btrfs_fs_info *fs_info,
+					      u16 new_csum_type)
+{
+	const u32 new_csum_size = btrfs_csum_type_size(new_csum_type);
+	const u32 csum_item_size = CSUM_CHANGE_BYTES_THRESHOLD /
+				   fs_info->sectorsize * new_csum_size;
+
+	return round_up(csum_item_size, fs_info->nodesize) / fs_info->nodesize * 2;
+}
+
 static int generate_new_data_csums_range(struct btrfs_fs_info *fs_info, u64 start,
 					 u16 new_csum_type)
 {
+	const unsigned int nr_items = calc_csum_change_nr_items(fs_info,
+								new_csum_type);
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_path path = { 0 };
 	struct btrfs_key key;
-	const u32 new_csum_size = btrfs_csum_type_size(new_csum_type);
 	void *csum_buffer;
 	u64 converted_bytes = 0;
 	u64 last_csum;
@@ -248,9 +260,7 @@ static int generate_new_data_csums_range(struct btrfs_fs_info *fs_info, u64 star
 	if (!csum_buffer)
 		return -ENOMEM;
 
-	trans = btrfs_start_transaction(csum_root,
-			CSUM_CHANGE_BYTES_THRESHOLD / fs_info->sectorsize *
-			new_csum_size);
+	trans = btrfs_start_transaction(csum_root, nr_items);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		errno = -ret;
@@ -306,9 +316,7 @@ static int generate_new_data_csums_range(struct btrfs_fs_info *fs_info, u64 star
 				return -EUCLEAN;
 			if (ret < 0)
 				goto out;
-			trans = btrfs_start_transaction(csum_root,
-					CSUM_CHANGE_BYTES_THRESHOLD /
-					fs_info->sectorsize * new_csum_size);
+			trans = btrfs_start_transaction(csum_root, nr_items);
 			if (IS_ERR(trans)) {
 				ret = PTR_ERR(trans);
 				goto out;
-- 
2.45.2


