Return-Path: <linux-btrfs+bounces-22274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKBsKmPsq2lYiAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22274-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Mar 2026 10:14:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4952722AD5B
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Mar 2026 10:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71F133015D82
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Mar 2026 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA83876CF;
	Sat,  7 Mar 2026 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OAMabFY4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OAMabFY4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B671382391
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Mar 2026 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772874845; cv=none; b=ibVIuzn/4/STr4JjAhDIC3PJN+73qs/9Ca9qqamX1ys9i3UmEykZbQZzD7lEEnB6S9E9utV9+JkZ9UB+id4wX29UWHXhjgcgLlfK2VqxwYmHclTLwDkqQbGSQHrN0/SEYl4vocLDgYiDrI1OA7gRv/hpd6RK2QEw7nJGV02OXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772874845; c=relaxed/simple;
	bh=gUx+A0PrmtXkdjpT/gPTg0QIm/L5wEg76xQOePOBg8w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfX3gSEh0mKtwuBLt9YYbIVHzWSCTBn0MVudnsFGY9eVgj3+a91iiErfV1+HiJhrMbo7jerf3z5rY52f8DV0eAHcwv1zdUIQWm2alTRBTRs+ZYCzgT2QG9fSdGSkiX4aMjbMup0Ts4ibRXq9ordA3vxFNMce1RFUlSMOZWcJd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OAMabFY4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OAMabFY4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3092F3FCF8
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Mar 2026 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772874837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbG6vQgqlJcHpGTkZeR0TmCvfdtN52b/ZQ9nmNRsCAI=;
	b=OAMabFY4O0lFsik9EklNdVo9mm19nnTrkkCrzy0jwW1FBKI2iTTA3yoCTJPFQ/L1tClcB3
	8iBMYRMEQOt8L5QOE2Qr8ijzBxQLH5Ch8GjTErwgEHSHgWay7OEpWWaGOqPog6kg/ldI8F
	PXHj8DveFytVMCImz7MkNPuCClO9Grc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OAMabFY4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772874837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbG6vQgqlJcHpGTkZeR0TmCvfdtN52b/ZQ9nmNRsCAI=;
	b=OAMabFY4O0lFsik9EklNdVo9mm19nnTrkkCrzy0jwW1FBKI2iTTA3yoCTJPFQ/L1tClcB3
	8iBMYRMEQOt8L5QOE2Qr8ijzBxQLH5Ch8GjTErwgEHSHgWay7OEpWWaGOqPog6kg/ldI8F
	PXHj8DveFytVMCImz7MkNPuCClO9Grc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C3153EA61
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Mar 2026 09:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WFrsC1Tsq2kkLQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 07 Mar 2026 09:13:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: check type flags in alloc_ordered_extent()
Date: Sat,  7 Mar 2026 19:43:36 +1030
Message-ID: <64098387a91f8ad825699f318f9980c0c8f7caa3.1772874800.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772874800.git.wqu@suse.com>
References: <cover.1772874800.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 4952722AD5B
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
	TAGGED_FROM(0.00)[bounces-22274-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Unlike other flags used in btrfs, BTRFS_ORDERED_* macros are different as
they can not be directly used as flags.

They are defined as bit numbers, thus they should be utilized with
bit operations, not directly with logical operations.

Unfortunately sometimes I forgot this and can pass the incorrect flags
to alloc_ordered_extent() and hit weird bugs.

Enhance the type checks in alloc_ordered_extent() by:

- Make sure there is one and only one bit set for exclusive type flags
  There are four exclusive type flags, REGULAR, NOCOW, PREALLOC and
  COMPRESSED.
  So introduce a new macro, BTRFS_ORDERED_EXCLUSIVE_FLAGS, to cover
  above flags.

  And add an ASSERT() to check one and only one of those exclusive flags
  can be set for alloc_ordered_extent().

- Re-order the type bit numbers to the end of the enum
  This is make it much harder to get a valid false negative.

  E.g, with the old BTRFS_ORDERED_REGULAR starts at zero, we can have
  the following flags passing the weight check:

  * BTRFS_ORDERED_NOCOW
    Be treated as BTRFS_ORDERED_REGULAR (1 == 1UL << 0).

  * BTRFS_ORDERED_PREALLOC
    Be treated as BTRFS_ORDERED_NOCOW (2 == 1UL << 1).

  * BTRFS_ORDERED_DIRECT
    Be treated as BTRFS_ORDERED_PREALLOC (4 == 1UL << 2).

  Now all those types starts at 8, passing any of those bit numbers as
  flags directly will not pass the ASSERT().

- Add a static assert to avoid overflow
  To make sure all BTRFS_ORDERED_* flags can fit into an unsigned long.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ordered-data.c | 13 ++++++++++
 fs/btrfs/ordered-data.h | 55 +++++++++++++++++++++++------------------
 2 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 8405d07b49cd..b34a0df282f3 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -156,6 +156,19 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	const bool is_nocow = (flags &
 	       ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
 
+	/* Only one type flag can be set. */
+	ASSERT(hweight_long(flags & BTRFS_ORDERED_EXCLUSIVE_FLAGS) == 1);
+
+	/* DIRECT can not be set with COMPRESSED nor ENCODED. */
+	if (test_bit(BTRFS_ORDERED_DIRECT, &flags)) {
+		ASSERT(!test_bit(BTRFS_ORDERED_COMPRESSED, &flags));
+		ASSERT(!test_bit(BTRFS_ORDERED_ENCODED, &flags));
+	}
+
+	/* ENCODED must be set with COMPRESSED. */
+	if (test_bit(BTRFS_ORDERED_ENCODED, &flags))
+		ASSERT(test_bit(BTRFS_ORDERED_COMPRESSED, &flags));
+
 	/*
 	 * For a NOCOW write we can free the qgroup reserve right now. For a COW
 	 * one we transfer the reserved space from the inode's iotree into the
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index cd74c5ecfd67..2664ea455229 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -47,8 +47,25 @@ struct btrfs_ordered_sum {
  * IO is done and any metadata is inserted into the tree.
  */
 enum {
+	/* Extra status bits for ordered extents */
+
+	/* Set when all the pages are written */
+	BTRFS_ORDERED_IO_DONE,
+	/* Set when removed from the tree */
+	BTRFS_ORDERED_COMPLETE,
+	/* We had an io error when writing this out */
+	BTRFS_ORDERED_IOERR,
+	/* Set when we have to truncate an extent */
+	BTRFS_ORDERED_TRUNCATED,
+	/* Used during fsync to track already logged extents */
+	BTRFS_ORDERED_LOGGED,
+	/* We have already logged all the csums of the ordered extent */
+	BTRFS_ORDERED_LOGGED_CSUM,
+	/* We wait for this extent to complete in the current transaction */
+	BTRFS_ORDERED_PENDING,
+
 	/*
-	 * Different types for ordered extents, one and only one of the 4 types
+	 * Different types for ordered extents, one and only one of those types
 	 * need to be set when creating ordered extent.
 	 *
 	 * REGULAR:	For regular non-compressed COW write
@@ -61,37 +78,27 @@ enum {
 	BTRFS_ORDERED_PREALLOC,
 	BTRFS_ORDERED_COMPRESSED,
 
+	/* Extra bit for encoded write, must be set with COMPRESSED. */
+	BTRFS_ORDERED_ENCODED,
+
 	/*
 	 * Extra bit for direct io, can only be set for
-	 * REGULAR/NOCOW/PREALLOC. No direct io for compressed extent.
+	 * REGULAR/NOCOW/PREALLOC. Can not be set for COMPRESSED nor ENCODED.
 	 */
 	BTRFS_ORDERED_DIRECT,
 
-	/* Extra status bits for ordered extents */
-
-	/* set when all the pages are written */
-	BTRFS_ORDERED_IO_DONE,
-	/* set when removed from the tree */
-	BTRFS_ORDERED_COMPLETE,
-	/* We had an io error when writing this out */
-	BTRFS_ORDERED_IOERR,
-	/* Set when we have to truncate an extent */
-	BTRFS_ORDERED_TRUNCATED,
-	/* Used during fsync to track already logged extents */
-	BTRFS_ORDERED_LOGGED,
-	/* We have already logged all the csums of the ordered extent */
-	BTRFS_ORDERED_LOGGED_CSUM,
-	/* We wait for this extent to complete in the current transaction */
-	BTRFS_ORDERED_PENDING,
-	/* BTRFS_IOC_ENCODED_WRITE */
-	BTRFS_ORDERED_ENCODED,
+	BTRFS_ORDERED_NR_FLAGS,
 };
+static_assert(BTRFS_ORDERED_NR_FLAGS <= BITS_PER_LONG);
+
+/* One and only one flag can be set. */
+#define BTRFS_ORDERED_EXCLUSIVE_FLAGS ((1UL << BTRFS_ORDERED_REGULAR) |	\
+				       (1UL << BTRFS_ORDERED_NOCOW) |	\
+				       (1UL << BTRFS_ORDERED_PREALLOC) |\
+				       (1UL << BTRFS_ORDERED_COMPRESSED))
 
 /* BTRFS_ORDERED_* flags that specify the type of the extent. */
-#define BTRFS_ORDERED_TYPE_FLAGS ((1UL << BTRFS_ORDERED_REGULAR) |	\
-				  (1UL << BTRFS_ORDERED_NOCOW) |	\
-				  (1UL << BTRFS_ORDERED_PREALLOC) |	\
-				  (1UL << BTRFS_ORDERED_COMPRESSED) |	\
+#define BTRFS_ORDERED_TYPE_FLAGS (BTRFS_ORDERED_EXCLUSIVE_FLAGS |	\
 				  (1UL << BTRFS_ORDERED_DIRECT) |	\
 				  (1UL << BTRFS_ORDERED_ENCODED))
 
-- 
2.53.0


