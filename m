Return-Path: <linux-btrfs+bounces-21824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id arN/NNp/m2ku0gMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21824-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 23:14:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBCD170909
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 23:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D303300EF8E
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 22:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482AA35C1A0;
	Sun, 22 Feb 2026 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="msilwsrL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uqHf8NBz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3012248B4
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771798481; cv=none; b=QfKDTTx9mYyeztKkcKnPGX0kZrOYnxySLcd6VaXFBfAfcDtwoRrJYRNC5KuruZCtCHak3x2tZCxjED6F74jjzwkHkrP/OHSS/nbwmPC/Cg6ehFTo50UXiQ/fot1GKphsXkQ0SWvbJkdc+Qzy6zvYf5fOwWJnxWN2GbW+VX26ixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771798481; c=relaxed/simple;
	bh=Y7++3MTJZkx/UR7vmNqXE7dlB8ihtWYuSTrGi0v57Ew=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ddOEd4x0wOA9OL3SXaCljM4loVbK6w0hkZEw+9P0a+70GnNcRKStzHi+RlcdQWgzp2Ebt180uNPYnra1sgSINgfCiS23+YitjGaA+ZLFhUui4dHp5Dn/8J4ZuWV74127DP3xhf3zutyWas6ZGhEf/4mZOu+nwBEeFXg4BaQURZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=msilwsrL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uqHf8NBz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A13C33E928
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 22:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771798471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VkJDkE5/BAPRLc/ux5ha24IrBIFNKIOyJqo6CowQRu4=;
	b=msilwsrLsUYYoL3vVYPHI9XjfLq+f0sruYokje1l3SGckZ039zIkaA5NyREaggW+T2966w
	tQk/UpoZCHPFJiUmGsDXqllfaIdnU7EcAdSatQDnYv5x7aihzLWjRu+mm4KjWRmW/5LCGZ
	+BlX1haliI+6b3jU9QeOFY9Rq0qi82c=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uqHf8NBz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771798470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VkJDkE5/BAPRLc/ux5ha24IrBIFNKIOyJqo6CowQRu4=;
	b=uqHf8NBz1zNbydCKlrNpIOtcdI/Ow9taaIqcPr/vFzBVFynYavzmEszu9eyGMEI1SCqp/T
	P+JzLBca47KrjYY1fxM3/PFuhLs5euTzlqKdu5Ry7AT7376ZvFJELiIXEmUIHdIZ8UdzNV
	ErAF0wAyXvS3VZfnboicLaitRYN/HcU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1AC73EA68
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 22:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vS5zJMV/m2kffAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 22:14:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: dump-tree: add extra chunk type checks
Date: Mon, 23 Feb 2026 08:44:12 +1030
Message-ID: <56d383400ae8a0ff20b5141baa1ab4068c5603ef.1771798449.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21824-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EBCD170909
X-Rspamd-Action: no action

There is a report in the mailing list where a seemingly confused end
user is passing a physical bytenr into "btrfs inspect dump-tree".

The best case is that bytenr has no corresponding chunk and will be
rejected early.

But if there is a chunk cover that bytenr, and that chunk is a data
chunk, "btrfs ins dump-tree" will mostly result a checksum mismatch,
e.g.:

 $ btrfs ins dump-tree -b 13631488 ~/test.img
 btrfs-progs v6.19
 checksum verify failed on 13631488 wanted 0xcdcdcdcd found 0xf9d338a0
 ERROR: failed to read tree block 13631488

Note that 13631488 is the logical bytenr of the first data chunk.

This can be confusing for end users, as they won't know if it's really
some corrupted tree blocks, or they are just passing wrong numbers.

Enhance this by introducing a new check_metadata_logical() helper, to
make sure a chunk exists and the type is also correct.

Now the error would be more obvious to end users:

 $ ./btrfs ins dump-tree -b 13631488 ~/test.img
 btrfs-progs v6.19
 ERROR: logical 13631488 is not in a metadata chunk, found chunk 13631488 len 8388608 flags 0x1

Link: https://lore.kernel.org/linux-btrfs/77535c20-da3e-4dfb-b3d7-9426c25b5da3@free.fr/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/inspect-dump-tree.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 2bc3f68179a5..11eb950dbdcb 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -33,6 +33,7 @@
 #include "kernel-shared/print-tree.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/tree-checker.h"
+#include "kernel-shared/volumes.h"
 #include "common/defs.h"
 #include "common/extent-cache.h"
 #include "common/messages.h"
@@ -194,6 +195,26 @@ static int dump_add_tree_block(struct cache_tree *tree, u64 bytenr)
 	return ret;
 }
 
+static int check_metadata_logical(struct btrfs_fs_info *fs_info, u64 logical)
+{
+	struct cache_extent *ce;
+	struct map_lookup *map;
+
+	ce = search_cache_extent(&fs_info->mapping_tree.cache_tree, logical);
+	if (!ce || ce->start > logical) {
+		error("no chunk map found for logical %llu", logical);
+		return -ENOENT;
+	}
+	map = container_of(ce, struct map_lookup, ce);
+	if (!(map->type & BTRFS_BLOCK_GROUP_METADATA)) {
+		error(
+"logical %llu is not in a metadata chunk, found chunk %llu len %llu flags 0x%llx",
+		      logical, ce->start, ce->size, map->type);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /*
  * Print all tree blocks recorded.
  * All tree block bytenr record will also be freed in this function.
@@ -228,6 +249,9 @@ static int dump_print_tree_blocks(struct btrfs_fs_info *fs_info,
 			goto next;
 		}
 
+		ret = check_metadata_logical(fs_info, bytenr);
+		if (ret < 0)
+			goto next;
 		eb = read_tree_block(fs_info, bytenr, &check);
 		if (!extent_buffer_uptodate(eb)) {
 			error("failed to read tree block %llu", bytenr);
-- 
2.53.0


