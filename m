Return-Path: <linux-btrfs+bounces-20032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B19E3CE5BCA
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Dec 2025 03:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F24E3007686
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Dec 2025 02:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E28217F29;
	Mon, 29 Dec 2025 02:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XrTyo1E6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XrTyo1E6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D62213B58A
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Dec 2025 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766975237; cv=none; b=m94600ElGh9P6UHL9qreAz0LVvXfVziLb8FGyfO0Yy57wvgKvCl1nHFa3p4OC7sy/Ax0epEd9NpGoNokhOKfd1RPOWhpei9QeMnVEoQldoweZ933629YYo7mRbdmBex47ovrmjHSaPGYQO9jtN7/+blejK7pUidTaG0evwoocdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766975237; c=relaxed/simple;
	bh=WS/O9NWhMmpSRbP1SG2ZOU71RCEQYpcfJdgTAlR/mJY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CoqXHGAFPyfNHeOFKsZZYVopc2eS6p4Fbpliax2JFqtsAbai8kti2RPZDvA/Pv37nrEFVUPPBZ2lMR+isx7KHhmV7JsS0FHvXPgkxPZBnaW0xOoEJbTz1b0Sbz2j1MdJBg/KkOwUgtaBMRyNwhGXgErlrQ4tdRNsPl1935UeTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XrTyo1E6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XrTyo1E6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 066FB33694
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Dec 2025 02:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766975232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9gUAstk38Q+++aooXETz7hfLIL25ZdaU7vXr+CVt6bM=;
	b=XrTyo1E62YmL2hqABxZHq0rFRxjpjVGqnQymTg7VVBG4la91IV/+u4vPEK2obApDWihtTn
	nd+e0L/XNymK6vNRVfxPEygagv+2oB7tXLxqCe3h4m7kMSo6m3Kf7uSOyOOe3w/+/bNTe2
	M3e7aiBGqYOV9DFpVK1tLVyo9mdepOQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766975232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9gUAstk38Q+++aooXETz7hfLIL25ZdaU7vXr+CVt6bM=;
	b=XrTyo1E62YmL2hqABxZHq0rFRxjpjVGqnQymTg7VVBG4la91IV/+u4vPEK2obApDWihtTn
	nd+e0L/XNymK6vNRVfxPEygagv+2oB7tXLxqCe3h4m7kMSo6m3Kf7uSOyOOe3w/+/bNTe2
	M3e7aiBGqYOV9DFpVK1tLVyo9mdepOQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CB781348F
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Dec 2025 02:27:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d9Z6O/7mUWklLwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Dec 2025 02:27:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: corrupt-block: allow to specify the value for key corruption
Date: Mon, 29 Dec 2025 12:56:53 +1030
Message-ID: <8460d20765914390ac2600d8e3f613f5b89060f3.1766975209.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.69
X-Spam-Level: 
X-Spamd-Result: default: False [-2.69 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.09)[-0.436];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

I tried to use btrfs-corrupt-block -K to corrupt a INODE_REF type, but
unfortunately the field is always filled with random value, and
sometimes it even break the key order.

To make it more useful to reproduce the biflip recently reported, allow
"-K" option to work with "--value".

There are some minor points to note though:

- (u64)-1 will not work
  We use that value if detect if "--value" is specified.
  For most cases we do not have key objectid/offset set to (u64)-1, so
  it should not be a big deal.

- Will keep the random value behavior if --value is not specified
  So old behavior is still kept.

- Values over 255 will be truncated for key.type
  Just give a warning and do the usual truncation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-corrupt-block.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 3d349f8cf40a..b111206e685b 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -112,7 +112,7 @@ static const char * const corrupt_block_usage[] = {
 			"metadata block to corrupt (must also specify -f for the field to corrupt)"),
 	OPTLINE("-k|--keys"," corrupt block keys (set by --logical)"),
 	OPTLINE("-K|--key <u64,u8,u64>",
-		"corrupt the given key (must also specify -f for the field and optionally -r for the root)"),
+		"corrupt the given key (must also specify -f for the field, optionally -r for the root and -v for the value)"),
 	OPTLINE("-f|--field FIELD", "field name in the item to corrupt"),
 	OPTLINE("-I|--item", "corrupt an item corresponding to the passed key triplet "
 		"(must also specify the field, or a (bytes, offset, value) tuple to corrupt and root for the item)"),
@@ -557,7 +557,7 @@ out:
 }
 
 static int corrupt_key(struct btrfs_root *root, struct btrfs_key *key,
-		       char *field)
+		       char *field, u64 bogus_value)
 {
 	enum btrfs_key_field corrupt_field = convert_key_field(field);
 	struct btrfs_path *path;
@@ -590,13 +590,27 @@ static int corrupt_key(struct btrfs_root *root, struct btrfs_key *key,
 
 	switch (corrupt_field) {
 	case BTRFS_KEY_OBJECTID:
-		key->objectid = generate_u64(key->objectid);
+		if (bogus_value != (u64)-1)
+			key->objectid = bogus_value;
+		else
+			key->objectid = generate_u64(key->objectid);
 		break;
 	case BTRFS_KEY_TYPE:
-		key->type = generate_u8(key->type);
+		if (bogus_value != (u64)-1) {
+			if (bogus_value > UCHAR_MAX)
+				warning(
+		"value %llu is larger than U8_MAX, will be truncated for key.type",
+					bogus_value);
+			key->type = bogus_value;
+		} else {
+			key->type = generate_u8(key->type);
+		}
 		break;
 	case BTRFS_KEY_OFFSET:
-		key->offset = generate_u64(key->objectid);
+		if (bogus_value != (u64)-1)
+			key->offset = bogus_value;
+		else
+			key->offset = generate_u64(key->objectid);
 		break;
 	default:
 		error("invalid field %s, %d", field, corrupt_field);
@@ -1583,7 +1597,7 @@ int main(int argc, char **argv)
 		if (*field == 0)
 			usage(&corrupt_block_cmd, 1);
 
-		ret = corrupt_key(target_root, &key, field);
+		ret = corrupt_key(target_root, &key, field, bogus_value);
 		goto out_close;
 	}
 	if (block_group) {
-- 
2.52.0


