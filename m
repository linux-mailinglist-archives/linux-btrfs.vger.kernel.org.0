Return-Path: <linux-btrfs+bounces-6713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A98993D0BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 12:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6341F22536
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EADA17838E;
	Fri, 26 Jul 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ms3cvFum";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ms3cvFum"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064AB2D7B8
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988023; cv=none; b=kQH5tDDfGqzBSSk08a2wjegLjBRoD1GbyWLurtUns3zk/WDSilnpjtVdHXFVEy4MRItS0MxzZPBLdmUGcU5GdGL4hNSkFRRt2twqoD1ZXMGhe9VhfZMC7bdGtboNHtbXJXU7OeOpyqK0g5nlVU37br4wrdQ/egxkyabsUPUwWfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988023; c=relaxed/simple;
	bh=6u1ncc+YRQCAgkQruJkN2IFEYQ3EXYMl91N6iBkbEUU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6TWQoq9/6xZUV2bUV9/Hry4pmBgR6xBBTnkx+omRaHuaiFzdjSnTZLAQs82WAXd4BgB/7L/EIukk8PdyGchZgiNtVOSFVcMZ8cowj/tv5hMuKjmZQ8Gf9R0Vut8eOKAjq9KQBoD7oMVy9XJL0Yt/wTefDldTsHENolmn8PVZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ms3cvFum; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ms3cvFum; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FC4921BD7
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721988020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58/WfzbK0isUwxAeSCA0JIUqwmVtOyAPijGkyME3gjM=;
	b=Ms3cvFumSS8N9nQs5dZGWYw5u8ISW2RIcyVo5TTbcAkPGR5RwYr3MUowXIAFVKHhDi4RaH
	0dWIWA1ASDljBhJuBS+rPoUHMBNmcswwfrNIb8fltRu9xQ2l3lMYkm9Wu+zfWA+HWfD9De
	wyRc/kcWlCjJdCOOQ97fCN8rsJ0S7kA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Ms3cvFum
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721988020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58/WfzbK0isUwxAeSCA0JIUqwmVtOyAPijGkyME3gjM=;
	b=Ms3cvFumSS8N9nQs5dZGWYw5u8ISW2RIcyVo5TTbcAkPGR5RwYr3MUowXIAFVKHhDi4RaH
	0dWIWA1ASDljBhJuBS+rPoUHMBNmcswwfrNIb8fltRu9xQ2l3lMYkm9Wu+zfWA+HWfD9De
	wyRc/kcWlCjJdCOOQ97fCN8rsJ0S7kA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7526B1396E
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SK0rDLNzo2YeTwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:00:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: move uuid-tree definitions to kernel-shared/uuid-tree.h
Date: Fri, 26 Jul 2024 19:29:53 +0930
Message-ID: <45ed3fd946a07b7ccd3bfda9c3d34c50beb1c7ad.1721987605.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721987605.git.wqu@suse.com>
References: <cover.1721987605.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: 4FC4921BD7

Currently we already have a kernel-shared/uuid-tree.c, which is mostly
shared with kernel already.

Meanwhile kernel also has a uuid-tree.h, but we are still using ctree.h
for the header.

Just move all the uuid-tree related definitions to
kernel-shared/uuid-tree.h, making future code sync easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/send-utils.c       |  1 +
 kernel-shared/ctree.h     | 11 -----------
 kernel-shared/uuid-tree.c |  1 +
 kernel-shared/uuid-tree.h | 33 +++++++++++++++++++++++++++++++++
 mkfs/main.c               |  1 +
 5 files changed, 36 insertions(+), 11 deletions(-)
 create mode 100644 kernel-shared/uuid-tree.h

diff --git a/common/send-utils.c b/common/send-utils.c
index 173333e30a38..8c13ffa1e106 100644
--- a/common/send-utils.c
+++ b/common/send-utils.c
@@ -29,6 +29,7 @@
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/ctree.h"
+#include "kernel-shared/uuid-tree.h"
 #include "common/send-utils.h"
 #include "common/messages.h"
 #include "common/utils.h"
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 2388879d1db3..7761b3f6fb1b 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1192,15 +1192,6 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root, const char *name, int name_len,
 			u64 ino, u64 parent_ino, u64 *index);
 
-/* uuid-tree.c, interface for mounted mounted filesystem */
-int btrfs_lookup_uuid_subvol_item(int fd, const u8 *uuid, u64 *subvol_id);
-int btrfs_lookup_uuid_received_subvol_item(int fd, const u8 *uuid,
-					   u64 *subvol_id);
-
-/* uuid-tree.c, interface for unmounte filesystem */
-int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
-			   u64 subid);
-
 static inline int is_fstree(u64 rootid)
 {
 	if (rootid == BTRFS_FS_TREE_OBJECTID ||
@@ -1209,8 +1200,6 @@ static inline int is_fstree(u64 rootid)
 	return 0;
 }
 
-void btrfs_uuid_to_key(const u8 *uuid, u8 type, struct btrfs_key *key);
-
 /* inode.c */
 int btrfs_find_free_dir_index(struct btrfs_root *root, u64 dir_ino,
 			      u64 *ret_ino);
diff --git a/kernel-shared/uuid-tree.c b/kernel-shared/uuid-tree.c
index 766cd31e4234..26359520d57c 100644
--- a/kernel-shared/uuid-tree.c
+++ b/kernel-shared/uuid-tree.c
@@ -29,6 +29,7 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/messages.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/uuid-tree.h"
 #include "common/messages.h"
 #include "common/utils.h"
 
diff --git a/kernel-shared/uuid-tree.h b/kernel-shared/uuid-tree.h
new file mode 100644
index 000000000000..0cdc2228c44f
--- /dev/null
+++ b/kernel-shared/uuid-tree.h
@@ -0,0 +1,33 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#ifndef __BTRFS_UUID_TREE_H__
+#define __BTRFS_UUID_TREE_H__
+
+#include "kerncompat.h"
+#include "kernel-shared/uapi/btrfs_tree.h"
+
+/* uuid-tree.c, interface for mounted mounted filesystem */
+int btrfs_lookup_uuid_subvol_item(int fd, const u8 *uuid, u64 *subvol_id);
+int btrfs_lookup_uuid_received_subvol_item(int fd, const u8 *uuid,
+					   u64 *subvol_id);
+
+/* uuid-tree.c, interface for unmounte filesystem */
+int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
+			   u64 subid);
+void btrfs_uuid_to_key(const u8 *uuid, u8 type, struct btrfs_key *key);
+
+#endif
diff --git a/mkfs/main.c b/mkfs/main.c
index cf5cae45d02a..9a6047f7296b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -41,6 +41,7 @@
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/zoned.h"
+#include "kernel-shared/uuid-tree.h"
 #include "crypto/hash.h"
 #include "common/defs.h"
 #include "common/internal.h"
-- 
2.45.2


