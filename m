Return-Path: <linux-btrfs+bounces-1688-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C6083AF86
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFFE286214
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0047A7F7CE;
	Wed, 24 Jan 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gEF6GLkk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5F8120E
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116770; cv=none; b=Jztzd3sXc3YkeBSSPN8/qNNAoxjPuXBRK4mI+lx6AKSnde/IcfA3i0JGMsTynltVTEQklMG2m8JOQQ46wFWO6ilG5bA9PBt1UVg454W67QXJO9zJry2IEaAz36IrQZ1WubSfHXVW17bzhjFtxalXR7oe7MiQY/Sje4YKbps7nbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116770; c=relaxed/simple;
	bh=/cP3hvQ7ssw6Z0Dj3R3GpX1wEm9lki+CxQB3N65VW0A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdR5iurYONmn4S0UCiOTpoTU8bT0HZ96f+mmEz1pUXCk5NU5sAlkFNn21rsEzL7GTGxL5ckaYUQQip00Z7E3fxbChYHcFTUPmS44gbfLiv6NdS0sa7qkVDUprhAah4k9T8LYxnGbZH21WF4OsmyYWLTjPw2nko/W13PGrVc0bRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gEF6GLkk; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-db3a09e96daso4986442276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116767; x=1706721567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFQ0e9hCGetkHNdr5YnTdx0eP/4gCHtSmlT6TIRDZYw=;
        b=gEF6GLkkYannpT065ImrmuGe7ZvJ0As2IMKpBfq1ZeLM1jbBviX0VxRoHp1A3y3/rX
         FeMo/QIJ4+De4Tj4K7qjHXQ05lObyEegskDfcCNrwd+t5pUGO4B9zJOW2jUIFm2lWEUB
         lXaQfldMS4sXpTzho9WkDUSvUdS8+XHDtr79SYtSBGvsxRL5yxNOtuog/dDSDq75lpwU
         I9gfGEHSvhiZoO4KHlEHOOL4AMjXHyvodwTiWqB4JLmk1rSecjt9Tl9bxWcl9uH02320
         WAQloVDNzXsnuWbzNmOt27NZcxFUmkPQhjb9Q0+uDjqkByyaADQ6AqHDnc8hZzCk78Qh
         aCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116767; x=1706721567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFQ0e9hCGetkHNdr5YnTdx0eP/4gCHtSmlT6TIRDZYw=;
        b=Z4VWZQB370DwHzbdoBlwD6Ey6BYUYGbcr6kWAgyYRz3krTSB5Ppqef2MR1/vGFVZ+m
         mzofGX08SMbIXc43hj7HWAbGvTo6uvrzJ5wj9KLQ+V5J75PpVPWTGgnfgh2Yo2Cg/gGt
         JRS0VcGQRNIH2+ga9rNq1HK7XbuEg4h2qlOOLWbXqZr+6puM9hMJXoRh3/6ZzkfoamAR
         jb59vfghd1j/+lLJ2DJRBeEd6Skqz1ovUbkfZxIEkJTitlaaRpLMGeDMhYyhse/n0Fj6
         OayNcIkjrsInFtbLp4OTOUydpwFG2ulYcHusLoQvPv/ReVPLNeudCk9dLvwnp3U8s4p/
         UaDg==
X-Gm-Message-State: AOJu0YzcwqQSqfs+77UoS6VfGKnz91mxiboRjdHNYoZFBpH4gXhl3vNq
	nUb09eJztyLKr4CCuZigVzNglwGWXBmMmijJKiySmuaYV4GDhFaV6qMesov3/1rYU8dfGA2rJjr
	P
X-Google-Smtp-Source: AGHT+IFOSIJgorYfwjqNotdeGDlxmfy90Cbu4BNH85sILCf5Uw9ZjF0Sgm4Wt12nqSJ9/qU+mft+Dw==
X-Received: by 2002:a05:6902:2082:b0:dc2:5516:c77b with SMTP id di2-20020a056902208200b00dc25516c77bmr1061615ybb.79.1706116767672;
        Wed, 24 Jan 2024 09:19:27 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d82-20020a254f55000000b00dbd9eee633dsm2967630ybb.59.2024.01.24.09.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:27 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 06/52] fscrypt: add a process_bio hook to fscrypt_operations
Date: Wed, 24 Jan 2024 12:18:28 -0500
Message-ID: <2c638e5fa1b7868dbf79d932b15364c3c30ca9de.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow file systems to set a process_bio hook for inline
encryption.  This will be utilized by btrfs in order to make sure the
checksumming work is done on the encrypted bio's.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/inline_crypt.c |  3 ++-
 include/linux/fscrypt.h  | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 52c4a24e2657..b8598007b1be 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -171,7 +171,8 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 
 	err = blk_crypto_init_key(blk_key, raw_key, crypto_mode,
 				  fscrypt_get_dun_bytes(ci),
-				  1U << ci->ci_data_unit_bits, NULL);
+				  1U << ci->ci_data_unit_bits,
+				  sb->s_cop->process_bio);
 	if (err) {
 		fscrypt_err(inode, "error %d initializing blk-crypto key", err);
 		goto fail;
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 22211f87e7be..ea3033956208 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/blk-crypto.h>
 #include <uapi/linux/fscrypt.h>
 
 /*
@@ -199,6 +200,19 @@ struct fscrypt_operations {
 	 */
 	struct block_device **(*get_devices)(struct super_block *sb,
 					     unsigned int *num_devs);
+
+	/*
+	 * A callback if the file system requires the ability to process the
+	 * encrypted bio, used only with inline encryption.
+	 *
+	 * @orig_bio: the original bio submitted.
+	 * @enc_bio: the encrypted bio.
+	 *
+	 * For writes the enc_bio will be different from the orig_bio, for reads
+	 * they will be the same.  For reads we get the bio before it is
+	 * decrypted, for writes we get the bio before it is submitted.
+	 */
+	blk_crypto_process_bio_t process_bio;
 };
 
 static inline struct fscrypt_inode_info *
-- 
2.43.0


