Return-Path: <linux-btrfs+bounces-22077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QARIFILjoWmUwwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22077-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 19:33:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC29A1BC025
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 19:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C34243167078
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 18:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C8F38F23B;
	Fri, 27 Feb 2026 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O65ZFQ5/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1D396B6F
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217093; cv=none; b=lh1u9yhy42pe0ZZuNQVCdXaExG4cahXF6bT3ShaOBCC4N2HFE5h9TMKZIlKhuVi3as/EqMB+2pce0KlCWeglW4fTl+AeuR/1LtGzjbnwtHu/CQpnOO2FPIia1WtJxm7h0I+BL1wExkxXj0ec0IyPtVEsRgHCSgBpb4Lw6GIHy2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217093; c=relaxed/simple;
	bh=oFS7a9tcfMBexhfcX+QtaKV/GkG5yXbkGgkChhRjGGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwlNi0PIG/+rir9YBYaqg0TKMWFMUHO6bvwFfhgBWn+PEA0TyszR9sYXjPXnChy9ljdScC2FFyZVhH99TxilSLoCj1nOYmbMnOXSUHyzl3ou99AazsW6ajR8xwgcZmhv3Lb3N+r9nSgOmkBTRCcs2SiU3G3HrLIlc6wsoOF4ke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O65ZFQ5/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab232cc803so12730225ad.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772217092; x=1772821892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE+SoT0tniCBmbDHvTQZN8k/uRnXafqmPKiJ44BTAzk=;
        b=O65ZFQ5/F2IhocwhAbTr+HHuEvZu2iNlhummjnshL9bdyCjMVTb6gNcFqqrpBi/hHm
         6sB6F5kt7POISi0TSEZrLPMCo9H0nVK8l2us70ZeAoMCcP5sFg+UxKnvLMU4e+cpxWOY
         P5hRoQgFYam3HYfgLkCv4tYex8T6BA2833LeOanrkmCDYu1FFQUCAcX+9g4h34Z0UqxW
         EvMADCdGmJ1H0w02M3a+3YTPJBMcSAkZn7le1NloqmBAc90cjab3w0XK3XqtPS3uVfWf
         dN0pd73WZMviSa9PkLY4JpW7XCPl8DIcIKQ8RiA2R9L7WWYREZ1sxjtixe7ffrJ6VrjR
         FeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772217092; x=1772821892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lE+SoT0tniCBmbDHvTQZN8k/uRnXafqmPKiJ44BTAzk=;
        b=Ia6HUJerwd2kYQC76mnQOy4c2AvIs3N9lvEVchbroNyq1OlyauI22R6ozUkTRffvBL
         UzbdhsB4IVDMrUgCkcYdyhwo9CTwCbQLu5qIcl+PZ42PPojsds/kXmLubRz4eu9LckZV
         sFNgcu2gNnBLlKz7NqsUNziiwTvCExPcL6jvEqBHuXv8zec5YpZmfrGSrJBfNsZmqubb
         F3dTQDuivr+dWUKvm06worRCBt/nfufegUUK8YSQzHHXiV/oS4OENYgu37yyr8wKLh1C
         Fz/Hl/DdZilMaqER1AhKQ6pTGfVaQEbkNhnpFAAQReLwM/tOv078fiz3+WriBdgbvQcx
         v2wA==
X-Forwarded-Encrypted: i=1; AJvYcCXSDXydN2IVTMaQNXnddUHC0sMJpsWGd0cBDX1xspRu3s4kosl9uCXdGk3RNB1K1c1iASYwlr9Zat7z4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhaU0VugpA7NKXKlKEw7aXqLrslN4VR9hg9fF8jMcQ7xg8JUtB
	FlZlZIq4PP/cVBtR5zfGFVNRe+jEhk6MTAYTVs9IfQy+lM1IvUHE2Zij
X-Gm-Gg: ATEYQzysfburqCasDNCxaxWquAz3XGOtPQIYGA0kvm5g/Sx7zg3xsfnNMRffotNsjUb
	2k3SQDcSQLaRy67xsMG2h6TbpGK1heydAt76+BAEWaHV0WIAtJB5Knrjua3oR/vsb6chxIebbch
	a6H9W6RTzQjcD6MgrlkefJ88hTgCE7/YrFcz32ZvHTxvDTw+HrScgbGzFyZA3dx3g9uhRqpvSiY
	sQcZH5phtc395vHApITJgypiMjvWXT0ZLSXMVoUCY2+qicvJMlmw9FK5gb2aHy+xyqBDGetKju8
	GKC0Vt+phNZ2M5xPtRBZUPwv8yqD/F5gdz2JXdf+tF87Op93CgRznJcNVhXgyGe5LUv3j+N/hxG
	C5uWUAQcfIoXZKcyx9dOV5qcbiVLy+76rx72lgMcQhqtO8c739rxJYL2oHags+HGnjybFmyIdzn
	o++VSD5dF4CDih/866BTx1Um40
X-Received: by 2002:a17:902:e744:b0:2aa:e3d1:1438 with SMTP id d9443c01a7336-2ae2e3ecf36mr41838105ad.12.1772217091806;
        Fri, 27 Feb 2026 10:31:31 -0800 (PST)
Received: from archlinux ([103.208.68.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbad2sm61932485ad.34.2026.02.27.10.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 10:31:31 -0800 (PST)
From: Adarsh Das <adarshdas950@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: terrelln@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adarsh Das <adarshdas950@gmail.com>
Subject: [PATCH 2/4] btrfs: clean coding style errors and warnings in compression.c
Date: Sat, 28 Feb 2026 00:01:09 +0530
Message-ID: <20260227183111.9311-3-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227183111.9311-1-adarshdas950@gmail.com>
References: <20260227183111.9311-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-22077-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adarshdas950@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC29A1BC025
X-Rspamd-Action: no action

As the previous patch is making changes to compression.c, this patch
takes the oppurtunity to fix errors and warning in compression.c

Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 fs/btrfs/compression.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 29281aba925e..6c3be3550442 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -36,9 +36,9 @@
 
 static struct bio_set btrfs_compressed_bioset;
 
-static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
+static const char * const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
-const char* btrfs_compress_type2str(enum btrfs_compression_type type)
+const char *btrfs_compress_type2str(enum btrfs_compression_type type)
 {
 	switch (type) {
 	case BTRFS_COMPRESS_ZLIB:
@@ -478,6 +478,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 
 			if (zero_offset) {
 				int zeros;
+
 				zeros = folio_size(folio) - zero_offset;
 				folio_zero_range(folio, zero_offset, zeros);
 			}
@@ -780,7 +781,7 @@ struct list_head *btrfs_get_workspace(struct btrfs_fs_info *fs_info, int type, i
 	struct workspace_manager *wsm = fs_info->compr_wsm[type];
 	struct list_head *workspace;
 	int cpus = num_online_cpus();
-	unsigned nofs_flag;
+	unsigned int nofs_flag;
 	struct list_head *idle_ws;
 	spinlock_t *ws_lock;
 	atomic_t *total_ws;
@@ -1163,17 +1164,17 @@ static u64 file_offset_from_bvec(const struct bio_vec *bvec)
  * @buf:		The decompressed data buffer
  * @buf_len:		The decompressed data length
  * @decompressed:	Number of bytes that are already decompressed inside the
- * 			compressed extent
+ *			compressed extent
  * @cb:			The compressed extent descriptor
  * @orig_bio:		The original bio that the caller wants to read for
  *
  * An easier to understand graph is like below:
  *
- * 		|<- orig_bio ->|     |<- orig_bio->|
- * 	|<-------      full decompressed extent      ----->|
- * 	|<-----------    @cb range   ---->|
- * 	|			|<-- @buf_len -->|
- * 	|<--- @decompressed --->|
+ *		|<- orig_bio ->|     |<- orig_bio->|
+ *	|<-------      full decompressed extent      ----->|
+ *	|<-----------    @cb range   ---->|
+ *	|			|<-- @buf_len -->|
+ *	|<--- @decompressed --->|
  *
  * Note that, @cb can be a subpage of the full decompressed extent, but
  * @cb->start always has the same as the orig_file_offset value of the full
@@ -1295,7 +1296,8 @@ static u32 shannon_entropy(struct heuristic_ws *ws)
 #define RADIX_BASE		4U
 #define COUNTERS_SIZE		(1U << RADIX_BASE)
 
-static u8 get4bits(u64 num, int shift) {
+static u8 get4bits(u64 num, int shift)
+{
 	u8 low4bits;
 
 	num >>= shift;
@@ -1370,7 +1372,7 @@ static void radix_sort(struct bucket_item *array, struct bucket_item *array_buf,
 		 */
 		memset(counters, 0, sizeof(counters));
 
-		for (i = 0; i < num; i ++) {
+		for (i = 0; i < num; i++) {
 			buf_num = array_buf[i].count;
 			addr = get4bits(buf_num, shift);
 			counters[addr]++;
-- 
2.53.0


