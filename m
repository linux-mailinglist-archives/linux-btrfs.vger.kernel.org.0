Return-Path: <linux-btrfs+bounces-8537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E22998FD1F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 07:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723931C225C4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 05:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9816A12C473;
	Fri,  4 Oct 2024 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mh7TGGd/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m+ottR+U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623857880
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728021155; cv=none; b=TeSo1NPtCaBkUq6tRGvquWi9cHXC3GZ5aWN1/3RbtTJyykASLki8yuhqRS3/nW+vfYTFKkgubxEadX1Alhr0jCDMJCr18l+Ha0+FoCuyrXR/xhsfvUur/T45lvxFQnOo0yUOH+yt4D+b3ASeK4pHnapzPiWXHOWc4Vl54gklnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728021155; c=relaxed/simple;
	bh=SBr9vAgOgDQ2pcvXz0/sT8fSBQ6xHIxeyhjk78Lj0i4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ir5GVnOgxuZrmJPsyMUJZaxWSSWRCIkfh12fWqwXAaOtYGNTKlwpQShI/mziydwyEkxYpWAS53TxZX9+qBxpfF33Vd3r24RY2Gz4cb7m0nd7pDe8SQ6br+6VJX/sDU5eF5dUzt1lUNIPJXyGNFQmQtQqxYr8EZENecoV+Fp2GwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mh7TGGd/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m+ottR+U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CAA9B1FECE
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 05:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728021152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7W8tKSjqUyChUJpgowpnKjXgDTzM6CoPVcmPdYqonM=;
	b=mh7TGGd/pUflBkVqMaSd1ChShiVX8oij+oh2I8dsS4KTwnQ/IiredoTOlQpB7mvcP0VAzL
	wFcbW5PC+/+WHyyY0SGQqC/dgfwBJJcMn0ZVBuJiN1Il+hxQfVa6BKx+AwJH5vqqWf4hiv
	NVaWgFtE4v4Arjg4cotlVtNS2NcfGkw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=m+ottR+U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728021151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7W8tKSjqUyChUJpgowpnKjXgDTzM6CoPVcmPdYqonM=;
	b=m+ottR+U7l5yoIPvdt0Uwf2gIAeNO/pYh6GNE754DzYv8lbRWOHrgT9R/WBDJsDFdzORcc
	xZ1SPKMuLLKGniiFH/7C/O88qapFRcdk+ht/tb1gjtvw/TMeG7rxjKlolJj2YuUP6BHQMi
	nUVojmXVj0g5LBcsTmLYOHKWP/Fxucc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 052731376C
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 05:52:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eJwcLp6C/2ZrRAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2024 05:52:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: print-tree: use readable_flag_entry for inode flags
Date: Fri,  4 Oct 2024 15:22:05 +0930
Message-ID: <930e41bc79d535733c33e3ed8a2c4a1c5a2aeb4c.1728020867.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728020867.git.wqu@suse.com>
References: <cover.1728020867.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAA9B1FECE
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The current print-tree can not handle unsupported inode flags, e.g.
created by Synology's out-of-tree btrfs implementation.

The existing one just checks all the supported flags, and if no flag
hits, it will output "none" no matter if there is any unsupported one.

Fix this by implementing sprint_readable_flag(), and use the same
handling of print_readable_flag().
Although for inode flag, adds one extra handling to output "none" if no
flag hit at all.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 89 +++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 31 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index bbd625d9b1eb..bd2117e637c2 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -183,9 +183,43 @@ static void print_inode_ref_item(struct extent_buffer *eb, u32 size,
 	}
 }
 
+struct readable_flag_entry {
+	u64 bit;
+	char *output;
+};
+
 /* The minimal length for the string buffer of block group/chunk flags */
 #define BG_FLAG_STRING_LEN	64
 
+static void sprint_readable_flag(char *restrict dest, u64 flag,
+				 struct readable_flag_entry *array,
+				 int array_size)
+{
+	int i;
+	u64 supported_flags = 0;
+	int cur = 0;
+
+	dest[0] = '\0';
+	for (i = 0; i < array_size; i++)
+		supported_flags |= array[i].bit;
+
+	for (i = 0; i < array_size; i++) {
+		struct readable_flag_entry *entry = array + i;
+
+		if ((flag & supported_flags) && (flag & entry->bit)) {
+			if (dest[0])
+				cur += sprintf(dest + cur, "|");
+			cur += sprintf(dest + cur, "%s", entry->output);
+		}
+	}
+	flag &= ~supported_flags;
+	if (flag) {
+		if (dest[0])
+			cur += sprintf(dest + cur, "|");
+		cur += sprintf(dest + cur, "UNKNOWN: 0x%llx", flag);
+	}
+}
+
 static void bg_flags_to_str(u64 flags, char *ret)
 {
 	int empty = 1;
@@ -932,37 +966,35 @@ static void print_uuid_item(struct extent_buffer *l, unsigned long offset,
 	}
 }
 
-/* Btrfs inode flag stringification helper */
-#define STRCAT_ONE_INODE_FLAG(flags, name, empty, dst) ({			\
-	if (flags & BTRFS_INODE_##name) {				\
-		if (!empty)						\
-			strcat(dst, "|");				\
-		strcat(dst, #name);					\
-		empty = 0;						\
-	}								\
-})
+#define DEF_INODE_FLAG_ENTRY(name)			\
+	{ BTRFS_INODE_##name, #name }
+
+static struct readable_flag_entry inode_flags_array[] = {
+	DEF_INODE_FLAG_ENTRY(NODATASUM),
+	DEF_INODE_FLAG_ENTRY(NODATACOW),
+	DEF_INODE_FLAG_ENTRY(READONLY),
+	DEF_INODE_FLAG_ENTRY(NOCOMPRESS),
+	DEF_INODE_FLAG_ENTRY(PREALLOC),
+	DEF_INODE_FLAG_ENTRY(SYNC),
+	DEF_INODE_FLAG_ENTRY(IMMUTABLE),
+	DEF_INODE_FLAG_ENTRY(APPEND),
+	DEF_INODE_FLAG_ENTRY(NODUMP),
+	DEF_INODE_FLAG_ENTRY(NOATIME),
+	DEF_INODE_FLAG_ENTRY(DIRSYNC),
+	DEF_INODE_FLAG_ENTRY(COMPRESS),
+	DEF_INODE_FLAG_ENTRY(ROOT_ITEM_INIT),
+};
+static const int inode_flags_num = ARRAY_SIZE(inode_flags_array);
 
 /*
- * Caller should ensure sizeof(*ret) >= 102: all characters plus '|' of
- * BTRFS_INODE_* flags
+ * Caller should ensure sizeof(*ret) >= 129: all characters plus '|' of
+ * BTRFS_INODE_* flags + "UNKNOWN: 0xffffffffffffffff"
  */
 static void inode_flags_to_str(u64 flags, char *ret)
 {
-	int empty = 1;
-
-	STRCAT_ONE_INODE_FLAG(flags, NODATASUM, empty, ret);
-	STRCAT_ONE_INODE_FLAG(flags, NODATACOW, empty, ret);
-	STRCAT_ONE_INODE_FLAG(flags, READONLY, empty, ret);
-	STRCAT_ONE_INODE_FLAG(flags, NOCOMPRESS, empty, ret);
-	STRCAT_ONE_INODE_FLAG(flags, PREALLOC, empty, ret);
-	STRCAT_ONE_INODE_FLAG(flags, SYNC, empty, ret);
-	STRCAT_ONE_INODE_FLAG(flags, IMMUTABLE, empty, ret);
-	STRCAT_ONE_INODE_FLAG(flags, APPEND, empty, ret);
-	STRCAT_ONE_INODE_FLAG(flags, NODUMP, empty, ret);
-	STRCAT_ONE_INODE_FLAG(flags, NOATIME, empty, ret);
-	STRCAT_ONE_INODE_FLAG(flags, DIRSYNC, empty, ret);
-	STRCAT_ONE_INODE_FLAG(flags, COMPRESS, empty, ret);
-	if (empty)
+	sprint_readable_flag(ret, flags, inode_flags_array, inode_flags_num);
+	/* No flag hit at all, set the output to "none"*/
+	if (!ret[0])
 		strcat(ret, "none");
 }
 
@@ -1876,11 +1908,6 @@ static int check_csum_sblock(void *sb, int csum_size, u16 csum_type)
 	return !memcmp(sb, result, csum_size);
 }
 
-struct readable_flag_entry {
-	u64 bit;
-	char *output;
-};
-
 #define DEF_COMPAT_RO_FLAG_ENTRY(bit_name)		\
 	{BTRFS_FEATURE_COMPAT_RO_##bit_name, #bit_name}
 
-- 
2.46.2


