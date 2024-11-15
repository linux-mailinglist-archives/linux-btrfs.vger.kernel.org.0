Return-Path: <linux-btrfs+bounces-9682-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF2A9CDACD
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 09:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB041F21365
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 08:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975818BC19;
	Fri, 15 Nov 2024 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vKlbaxp8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mGSBnKhy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5C188A3A
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660362; cv=none; b=XXxcREMCAYCsnRmxlHv3T7uO4HxXpRdLWuCIkzVoZ1Mx9mzZS8/wbZv1o83drtrZSla/OTyjPMbOCYxPyjc3mIQ9o0NYLi2ZZvPoaksnNDU1NITEIuQK5pinOXKexbk0OWqTa/Jeir92gaa4sWeGb29M04dZkGtcMdcyGosX6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660362; c=relaxed/simple;
	bh=8Sz53YVChNIWJlS4ey00jStvnHYrXNUafoiXIfMG+NY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eM+lNFff3r4otVgCBMds1r3dA1jSFuWbkj3MlZb6T0vdG+O20Z4HOzjhXfoG+onC1SQuAAPbV5oIKvJUuxlIlt9fdlX5KUjo41W/fZ2wdMgpSci2vOvEaFRh1BD0sPxBcGVvW4ZsGXHrSBoyZc6UduJvlsuSzJcx7cfGzgwRTF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vKlbaxp8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mGSBnKhy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3143B1F78E
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 08:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731660358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nxHv+ZUvUIar/P8/+UArNtYodWSAwNYVJOnIPvlZtrY=;
	b=vKlbaxp8Klv8KNCvWfqRVNG3UvK5yB1/2iwPkw7aY6GXt14Kn13erecWDWDm7O115hE+7f
	aIWmTYVFVTHGZ+vEBUvE1Lb6LeaHwHjh7FFfCP2eG/QiSXnHISuo7B1Ybr/7fqaA+7D4UC
	2/WIyk1jVSMT6yjqRpQ6ZVmrmyeVjv0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mGSBnKhy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731660357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nxHv+ZUvUIar/P8/+UArNtYodWSAwNYVJOnIPvlZtrY=;
	b=mGSBnKhy6kHmxI7532TCJzL+MkxlE2z8gz+oNi1jFQJTg6R6fzhP655XRF97PL+4ENJEoZ
	n9MNwiJZvKoPx0UHTNbLJlV3jFgIB3hmVU65/uxhjMb5Jmyx9CEmw6lllYP+H8gWjsayDN
	YBhvwWgRVQ9oQ9w8MYBVVuJh82QnL7Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F2F413485
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 08:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wu2KCEQKN2d7NQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 08:45:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix inline data extent reads which zero out the remaining part
Date: Fri, 15 Nov 2024 19:15:34 +1030
Message-ID: <e7338d321bdf48e3b503c40e8eca7d7592709c83.1731660309.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3143B1F78E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[BUG in DEVEL BRANCH]
This bug itself can only be reproduced with the following out-of-tree
patches:

  btrfs: allow inline data extents creation if sector size < page size
  btrfs: allow buffered write to skip full page if it's sector aligned

With those out-of-tree patches, we can hit a data corruption:

  # mkfs.btrfs -f -s 4k $dev
  # mount $dev $mnt -o compress=zstd
  # xfs_io -f -c "pwrite 0 4k" $mnt/foobar
  # sync
  # echo 3 > /proc/sys/vm/drop_caches
  # xfs_io -f -c" pwrite 8k 4k" $mnt/foobar
  # md5sum $mnt/foobar
  65df683add4707de8200bad14745b9ec

Meanwhile such workload should result a md5sum of
  277f3840b275c74d01e979ea9d75ac19

[CAUSE]
The first buffered write into range [0, 4k) will result a compressed
inline extent (relies on the patch "btrfs: allow inline data extents
creation if sector size < page size" to create such inline extent):

	item 6 key (257 EXTENT_DATA 0) itemoff 15823 itemsize 40
		generation 9 type 0 (inline)
		inline extent data size 19 ram_bytes 4096 compression 3 (zstd)

Then all page cache is dropped, and we do the new write into range
[8K, 12K)

With the out-of-tree patch "btrfs: allow buffered write to skip full page if
it's sector aligned", such aligned write won't trigger the full folio
read, so we just dirtied range [8K, 12K), and range [0, 4K) is not
uptodate.

Then md5sum triggered the full folio read, causing us to read the
inlined data extent.

Then inside function read_inline_extent() and uncomress_inline(), we zero
out all the remaining part of the folio, including the new dirtied range
[8K, 12K), leading to the corruption.

[FIX]
Thankfully the bug is not yet reaching any end users.
For upstream kernel, the [8K, 12K) write itself will trigger the full
folio read before doing any write, thus everything is still fine.

Furthermore, for the existing btrfs users with sector size < page size
(the most common one is Asahi Linux) with inline data extents created
from x86_64, they are still fine, because two factors are saving us:

- Inline extents are always at offset 0

- Folio read always follows the file offset order

So we always read out the inline extent, zeroing the remaining folio
(which has no contents yet), then read the next sector, copying the
correct content to the zeroed out part.
No end users are affected thankfully.

The fix is to make both read_inline_extent() and uncomress_inline() to
only zero out the sector, not the whole page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 712157ecda08..66e341f85b38 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6706,6 +6706,7 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 {
 	int ret;
 	struct extent_buffer *leaf = path->nodes[0];
+	const u32 sectorsize = leaf->fs_info->sectorsize;
 	char *tmp;
 	size_t max_size;
 	unsigned long inline_size;
@@ -6734,17 +6735,19 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 	 * cover that region here.
 	 */
 
-	if (max_size < PAGE_SIZE)
-		folio_zero_range(folio, max_size, PAGE_SIZE - max_size);
+	if (max_size < sectorsize)
+		folio_zero_range(folio, max_size, sectorsize - max_size);
 	kfree(tmp);
 	return ret;
 }
 
-static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
+static int read_inline_extent(struct btrfs_fs_info *fs_info,
+			      struct btrfs_path *path, struct folio *folio)
 {
 	struct btrfs_file_extent_item *fi;
 	void *kaddr;
 	size_t copy_size;
+	const u32 sectorsize = fs_info->sectorsize;
 
 	if (!folio || folio_test_uptodate(folio))
 		return 0;
@@ -6762,8 +6765,8 @@ static int read_inline_extent(struct btrfs_path *path, struct folio *folio)
 	read_extent_buffer(path->nodes[0], kaddr,
 			   btrfs_file_extent_inline_start(fi), copy_size);
 	kunmap_local(kaddr);
-	if (copy_size < PAGE_SIZE)
-		folio_zero_range(folio, copy_size, PAGE_SIZE - copy_size);
+	if (copy_size < sectorsize)
+		folio_zero_range(folio, copy_size, sectorsize - copy_size);
 	return 0;
 }
 
@@ -6938,7 +6941,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		ASSERT(em->disk_bytenr == EXTENT_MAP_INLINE);
 		ASSERT(em->len == fs_info->sectorsize);
 
-		ret = read_inline_extent(path, folio);
+		ret = read_inline_extent(fs_info, path, folio);
 		if (ret < 0)
 			goto out;
 		goto insert;
-- 
2.47.0


