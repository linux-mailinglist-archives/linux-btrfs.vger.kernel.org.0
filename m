Return-Path: <linux-btrfs+bounces-6274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7366F929B75
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 07:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A49628139E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 05:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA13311C83;
	Mon,  8 Jul 2024 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B6zGeMCN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B6zGeMCN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE8AB66F
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720415688; cv=none; b=g63F4n83GcEc2kEV8Sim7LEus/vbqcAtGUa3606weXOl2RlgwzYb8WeykJkCFH8NkHpe1Kyi5POzbsUDZxscyRp5mReGTksaweBjNqnRYAl7UD3Sl4q2NCkmIQKyWavlwgo4LEsyLkHPpdSlsQH/yIFDUX4geBKNRoeYIw9V5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720415688; c=relaxed/simple;
	bh=gC6Vv+CfFZJZn5DPeeaYpKHkfCkbVY46X9rAB6RqR4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzQaS1HvGng/U980QNn8yXo33n3HK3AXLcnwcnDQ5ZOJWo1UNAosajLBdiW7hgTYf9IibE0uT7wrx7oTt77NwdSkooDkUbqMqD5o8MLsK95ePL3BCiKSulP+dEbvYoMrNkwIptXMkcpwex776tsWfqPrhXG2jetaivvNbelgOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B6zGeMCN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B6zGeMCN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D2361FBDE;
	Mon,  8 Jul 2024 05:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720415684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGmR9WiQSYTeidQEcStvt/brLxl8HzWeYogUS42fGzA=;
	b=B6zGeMCN5FgLimglgPC5eQ9dLt0tSD1OCNQbp1CE4ZySOHLUO7hzdbtPeR3ikd+rWfLY22
	VvVmAmJ3q9K4heGnVY9d3dBGZT48WS+1hSoPA18MDK53kWsMi2ZGCJjcvQ6igWboweGmXk
	PSOnjQ3RlnkYEBfMPIQSgLx0aiUmVwE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720415684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGmR9WiQSYTeidQEcStvt/brLxl8HzWeYogUS42fGzA=;
	b=B6zGeMCN5FgLimglgPC5eQ9dLt0tSD1OCNQbp1CE4ZySOHLUO7hzdbtPeR3ikd+rWfLY22
	VvVmAmJ3q9K4heGnVY9d3dBGZT48WS+1hSoPA18MDK53kWsMi2ZGCJjcvQ6igWboweGmXk
	PSOnjQ3RlnkYEBfMPIQSgLx0aiUmVwE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CD101396E;
	Mon,  8 Jul 2024 05:14:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8PiGNcJ1i2YbZwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 08 Jul 2024 05:14:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>
Subject: [PATCH 2/4] btrfs-progs: image: fix the bug that filename sanitization not working
Date: Mon,  8 Jul 2024 14:44:16 +0930
Message-ID: <697356d9b33836d8c8ced54195b463866ced4297.1720415116.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720415116.git.wqu@suse.com>
References: <cover.1720415116.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

[BUG]
There is a bug report that image dump taken by "btrfs-image -s" doesn't
really sanitize the filenames:

 # truncates -s 1G source.raw
 # mkfs.btrfs -f source.raw
 # mount source.raw $mnt
 # touch $mnt/top_secret_filename
 # touch $mnt/secret_filename
 # umount $mnt
 # btrfs-image -s source.raw dump.img
 # string dump.img | grep filename
 top_secret_filename
 secret_filename
 top_secret_filename
 secret_filename
 top_secret_filename

[CAUSE]
Using above image to store the fs, and we got the following result in fs
tree:

	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
		generation 3 transid 7 size 68 nbytes 16384
		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
		sequence 2 flags 0x0(none)
	item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
		index 0 namelen 2 name: ..
	item 2 key (256 DIR_ITEM 439756795) itemoff 16062 itemsize 49
		location key (257 INODE_ITEM 0) type FILE
		transid 7 data_len 0 name_len 19
		name: top_secret_filename
	item 3 key (256 DIR_ITEM 693462946) itemoff 16017 itemsize 45
		location key (258 INODE_ITEM 0) type FILE
		transid 7 data_len 0 name_len 15
		name: secret_filename
	item 4 key (256 DIR_INDEX 2) itemoff 15968 itemsize 49
		location key (257 INODE_ITEM 0) type FILE
		transid 7 data_len 0 name_len 19
		name: top_secret_filename
	item 5 key (256 DIR_INDEX 3) itemoff 15923 itemsize 45
		location key (258 INODE_ITEM 0) type FILE
		transid 7 data_len 0 name_len 15
		name: secret_filename
	item 6 key (257 INODE_ITEM 0) itemoff 15763 itemsize 160
		generation 7 transid 7 size 0 nbytes 0
		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
		sequence 1 flags 0x0(none)
	item 7 key (257 INODE_REF 256) itemoff 15734 itemsize 29
		index 2 namelen 19 name: top_secret_filename
	item 8 key (258 INODE_ITEM 0) itemoff 15574 itemsize 160
		generation 7 transid 7 size 0 nbytes 0
		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
		sequence 1 flags 0x0(none)
	item 9 key (258 INODE_REF 256) itemoff 15549 itemsize 25
		index 3 namelen 15 name: 1���'�gc*&R

The result shows, only the last INODE_REF got sanitized, all the
remaining is not touched at all.

This is cauesd by how we sanitize the filenames:

 copy_buffer()
 |- memcpy(dst, src->data, src->len);
 |  This means we copy the whole eb into our buffer already.
 |
 |- zero_items()
    |- sanitize_name()
       |- eb = alloc_dummy_eb();
       |- memcpy(eb->data, src->data, src->len);
       |  This means we generate a dummy eb with the same contents of
       |  the source eb.
       |
       |- sanitize_dir_item();
       |  We override the dir item of the given item (specified by the
       |  slot number) inside our dummy eb.
       |
       |- memcpy(dst, eb->data, eb->lem);

The last one copy the dummy eb into our buffer, with only the slot
corrupted.

But when the whole work flow hits the next slot, we only corrupt the
next slot, but still copy the whole dummy eb back to buffer.

This means the previous slot would be overwritten by the old unsanitized
data.

Resulting only the last slot is corrupted.

[FIX]
Fix the bug by only copying back the corrupted item to the buffer.
So that other slots won't be overwritten by unsanitized data.

Reported-by: Andrea Gelmini <andrea.gelmini@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/sanitize.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/image/sanitize.c b/image/sanitize.c
index 084da22e401e..ef4f6e515633 100644
--- a/image/sanitize.c
+++ b/image/sanitize.c
@@ -449,6 +449,8 @@ void sanitize_name(enum sanitize_mode sanitize, struct rb_root *name_tree,
 		int slot)
 {
 	struct extent_buffer *eb;
+	u32 item_ptr_off = btrfs_item_ptr_offset(src, slot);
+	u32 item_ptr_size = btrfs_item_size(src, slot);
 
 	eb = alloc_dummy_eb(src->start, src->len);
 	if (!eb) {
@@ -476,7 +478,11 @@ void sanitize_name(enum sanitize_mode sanitize, struct rb_root *name_tree,
 		break;
 	}
 
-	memcpy(dst, eb->data, eb->len);
+	/*
+	 * Only overwrite the sanitized part, or we can overwrite previous
+	 * sanitized value with the old values from @src.
+	 */
+	memcpy(dst + item_ptr_off, eb->data + item_ptr_off, item_ptr_size);
 	free(eb);
 }
 
-- 
2.45.2


