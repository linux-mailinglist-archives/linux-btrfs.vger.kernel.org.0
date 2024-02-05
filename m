Return-Path: <linux-btrfs+bounces-2133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DB784AACF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 00:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD3928A539
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 23:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FD34C3AF;
	Mon,  5 Feb 2024 23:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EQo0sA72";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EQo0sA72"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525744121B
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176767; cv=none; b=MSmdaIynllR6AWJnPdejzf3jrfNSsDv7BfbuNGP7tDFvi5NLDeGPpMNOMDndS4jseKFVBWJw80A7WTgNOOcxbL1MkDyEV8orRijhNvEfh36Eto3sRLt+R8YWpYuv9vF3KZmxmwKv46cs+RIv5nPNZJjmvZm2z9mq5vZPNjiD5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176767; c=relaxed/simple;
	bh=Y76Qwn/SMXEwD3lMRdsHs00pMvbtUQnLBRr3fmZX0Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxX9cW0qtWERJGRYtrG77lBpdfd3NnEgBTxLjGT0aFq/iXQgi6uImVhVG9fSTRCNOj50mY1Wcp+WCWwXyiBymjFn3oGcW66WD4qF15n0vSmHR8Va+chIej1UosrUv3+JIapKWRQn7CyBZ8WxB9TfMs01k4vEI+QMAHZOeRBy6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EQo0sA72; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EQo0sA72; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 673841FB55;
	Mon,  5 Feb 2024 23:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707176762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLm7gvhAJhftozaRPdS1PPUTI/X8w7aIxLeiMjHF8H8=;
	b=EQo0sA725VEGF09tYpr/rUpULRhdKAb1+pP6JyXxmrpw+kcA4SqrNjSqRtzoA1YYK6+MdD
	wxj6g+8Nf8wQ9wQ/jafe2b+vtAv05BvzclHbYMs63N3HYI31qdsigZZJhBoQropGoZG3Fy
	iqdrv7JAZfLa0ZpTbc8yJ5QZsR11/qQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707176762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLm7gvhAJhftozaRPdS1PPUTI/X8w7aIxLeiMjHF8H8=;
	b=EQo0sA725VEGF09tYpr/rUpULRhdKAb1+pP6JyXxmrpw+kcA4SqrNjSqRtzoA1YYK6+MdD
	wxj6g+8Nf8wQ9wQ/jafe2b+vtAv05BvzclHbYMs63N3HYI31qdsigZZJhBoQropGoZG3Fy
	iqdrv7JAZfLa0ZpTbc8yJ5QZsR11/qQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 629C3136F5;
	Mon,  5 Feb 2024 23:46:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aKFMCTlzwWUncAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 05 Feb 2024 23:46:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Anton Mitterer <calestyo@scientia.org>
Subject: [PATCH 1/2] btrfs: defrag: add under utilized extent to defrag target list
Date: Tue,  6 Feb 2024 10:15:55 +1030
Message-ID: <2188d9521696a2c5f9bbb81479c6c94ea827a0aa.1707172743.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707172743.git.wqu@suse.com>
References: <cover.1707172743.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EQo0sA72
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 673841FB55
X-Spam-Flag: NO

[BUG]
The following script can lead to a very under utilized extent and we
have no way to use defrag to properly reclaim its wasted space:

  # mkfs.btrfs -f $dev
  # mount $dev $mnt
  # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
  # sync
  # truncate -s 4k $mnt/foobar
  # btrfs filesystem defrag $mnt/foobar
  # sync

After the above operations, the file "foobar" is still utilizing the
whole 128M:

        item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
                generation 7 transid 8 size 4096 nbytes 4096
                block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                sequence 32770 flags 0x0(none)
        item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
                index 2 namelen 4 name: file
        item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
                generation 7 type 1 (regular)
                extent data disk byte 298844160 nr 134217728 <<<
                extent data offset 0 nr 4096 ram 134217728
                extent compression 0 (none)

This is the common btrfs bookend behavior, that 128M extent would only
be freed if the last referencer of the extent is freed.

The problem is, normally we would go defrag to free that 128M extent,
but defrag would not touch the extent at all.

[CAUSE]
The file extent has no adjacent extent at all, thus all existing defrag
code consider it a perfectly good file extent, even if it's only
utilizing a very tiny amount of space.

[FIX]
For a file extent without any adjacent file extent, we should still
consider to defrag such under utilized extent, base on the following
conditions:

- utilization ratio
  If the extent is utilizing less than 1/16 of the on-disk extent size,
  then it would be a defrag target.

- wasted space
  If we defrag the extent and can free at least 16MiB, then it would be
  a defrag target.

Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/defrag.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 8fc8118c3225..85c6e45d0cd4 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -950,6 +950,38 @@ struct defrag_target_range {
 	u64 len;
 };
 
+/*
+ * Special entry for extents that do not have any adjacent extents.
+ *
+ * This is for cases like the only and truncated extent of a file.
+ * Normally they won't be defraged at all (as they won't be merged with
+ * any adjacent ones), but we may still want to defrag them, to free up
+ * some space if possible.
+ */
+static bool should_defrag_under_utilized(struct extent_map *em)
+{
+	/*
+	 * Ratio based check.
+	 *
+	 * If the current extent is only utilizing 1/16 of its on-disk size,
+	 * it's definitely under-utilized, and defragging it may free up
+	 * the whole extent.
+	 */
+	if (em->len < em->orig_block_len / 16)
+		return true;
+
+	/*
+	 * Wasted space based check.
+	 *
+	 * If we can free up at least 16MiB, then it may be a good idea
+	 * to defrag.
+	 */
+	if (em->len < em->orig_block_len &&
+	    em->orig_block_len - em->len > SZ_16M)
+		return true;
+	return false;
+}
+
 /*
  * Collect all valid target extents.
  *
@@ -1070,6 +1102,16 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		if (!next_mergeable) {
 			struct defrag_target_range *last;
 
+			/*
+			 * This is a single extent without any chance to merge
+			 * with any adjacent extent.
+			 *
+			 * But if we may free up some space, it is still worth
+			 * defragging.
+			 */
+			if (should_defrag_under_utilized(em))
+				goto add;
+
 			/* Empty target list, no way to merge with last entry */
 			if (list_empty(target_list))
 				goto next;
-- 
2.43.0


