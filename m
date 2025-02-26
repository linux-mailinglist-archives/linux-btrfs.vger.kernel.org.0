Return-Path: <linux-btrfs+bounces-11880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3049A46524
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 16:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74CE17D6D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B21A21D3C1;
	Wed, 26 Feb 2025 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYKFj8pl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECE819D8BC;
	Wed, 26 Feb 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584051; cv=none; b=cQxi/NQXEBloqinKNZxRHVBOgEHfMg8tOGaYRPpUQkGxlvjOBs0d+UMz1Iv1Adpj4HWcANIviTILokZ4lUEnq6vB4CvcvtdfnS63gyu3wUIvQrbB8TBL6syB+4v+cxv6qAROyFtTsn3uFs06QHhSVLh5NYwuBdv2oiK2S/CoBTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584051; c=relaxed/simple;
	bh=n4mIBYZgIixrVokqwsvcaHoa8d9u1VJMq2c/C0UO6EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nB6OEXPRJmODPtrBmd4XlSrPJ2kodfR5vzsHEMciALMU/6if4mMbzoOSCwZU6xHAhIzwE8UPehnycgrx6g8NS9Mf05efThOGrcxFwfjUbfP/i2+mWjulZh197Qf6tGH7qrOSai+o8HdsSa9oms4H7xusqlGRZJ/Uf57D7B1DBLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYKFj8pl; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2234338f2bbso841485ad.3;
        Wed, 26 Feb 2025 07:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740584049; x=1741188849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5N2H7QhldHeJAoRM14lUnMCgcOLfJQcotAm+h7n6lzQ=;
        b=HYKFj8pln3S8AcZAYSptQqYshjzOehvVhefahL9ficlPkkUTVFm+g7oD5aKaHX1n/T
         ug97vy6pTQza9T6ozaYnXsna1+HIuS/dZy3IbFVhUR67HzWej/nBBPpCEAGwYa+0v/3Q
         L+8G4urIBBtVcEIIP5EV0UI3gOtq6U1iN87HCbctoSc2kw4Hp2yq14o0y9AiS5UXlFtX
         L8c2g78//c4YeeLbnGj5RoWKU8bWVO0QPMCef3dIQso4ytUajxpLGncz4LddetV0G6IG
         ubaCqs/JdGNZapnU4TEU3S8vUUapaO8Pr0ZVYRylqBDrvvnJN6a8UnODRxQMcexTZHqZ
         HhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584049; x=1741188849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5N2H7QhldHeJAoRM14lUnMCgcOLfJQcotAm+h7n6lzQ=;
        b=G++eJo/sbMWxL1S37GCUhu8a5y5DlmFJD29S3rLy53a2r+AWRlHaW2EpsOH+ZkMOXF
         wNEgBMExjBaQOLNfdg/680d9/+ZTqkYANV5ifIDWh/qnNT+vJOFMMZuSA/g3lNczYpyS
         R3wDqKxSCYMIXEReBCtWc0AQd0QG9umbEueCcgyP8YXs4MqPHjQHLSlfvotFQ04v5F/j
         ghX6k7q/PuspRru9Y8fLjpukRQYvCYZDTfRKlLMn7EL5Ve6ZQYmAuGnbmzV1ep8AUQfY
         wAXEVjtLmxmhEBFjLkXb7T0glAySgpYXZ57oovQJvESwdiWVQwNqNIUn/YhLaVRpFZkf
         UYzg==
X-Forwarded-Encrypted: i=1; AJvYcCVwvEDtREdO+4C4/ZAOCv9nJ/LTvknPE4nKdk137G9TpgQ8uyeaoTaMciBdoJ/MFuTEdcurylUCCicKdgMQ@vger.kernel.org, AJvYcCXZ1M3JZpQsnLRhBCmRavVF7pqrADPGztEFXINcSqlwFMrMFk49ckNcA7zHodYLcf0+YrJvRfPrY/Ya7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkP4Ix6B3EOGLoTHZPToajjTZDrlgY4bsYfVoTcwzOCgwei/q6
	5Sg0tt4gFrsXjoH2eLBcKI5YkOOiDbo3/ehHel3UyvF/owvAcg5n
X-Gm-Gg: ASbGnculka9MoBvpkPDhIEKmbaQOAfpo5AI5ykgThIEN47X3Ff1HtlrvhoJOhazMPdZ
	ZKqNmYn25dOYRBISbwObaEbgE716XZcaa1h1jpdrZN8w5wCpEkb6n7UnccnpjTxRbxBef8+h5k3
	SwQ78cwxzfCq331CCCah7e08JfDQL7070Hes08RekJ7Zm0eFG8N1Fz1LEsUm5dxXNcwaEr83plx
	0Dyj4WxQPipK2BF+vVgundBDfvpHFKCoL5eyRZ6DaxEnxOpTE9zQxh9On/EY9hD1uD8b5pFH/d8
	A4JNftfm5LzHj1rqzZuC1lwcTl4=
X-Google-Smtp-Source: AGHT+IHUkEmnPXQSMqTediebYjWiSuSk6ge3LwPbPbrdWL0b+9tYBp4tfNmLQnDxQ6RRPUzbOTb8zg==
X-Received: by 2002:a17:902:dac8:b0:220:e04b:839a with SMTP id d9443c01a7336-2219ff39359mr137441585ad.3.1740584049213;
        Wed, 26 Feb 2025 07:34:09 -0800 (PST)
Received: from SaltyKitkat.. ([2403:18c0:5:400:bca6:d6ff:fe8f:8ac0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a00054dsm33926355ad.4.2025.02.26.07.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:34:08 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: 
Cc: Sun YangKai <sunk67188@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] btrfs: simplify copy_to_sk() by removing unnecessary min key check
Date: Wed, 26 Feb 2025 23:33:36 +0800
Message-ID: <20250226153402.19387-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The copy_to_sk() function, which is used solely by
search_ioctl(), previously relied on the helper function
key_in_sk() to evaluate whether a key fell within
the range defined by the search key (sk). This function
checked the key against both the minimum and maximum
bounds in the search key.

However, within search_ioctl(), the btrfs_search_forward()
ensures that the search starts at an item whose key
is already no less than min_key. This guarantees that
no keys below the minimum threshold will be encountered
during the traversal. As a result, the check against
the minimum key is redundant and can be safely removed.

This patch:

* Removes the key_in_sk() helper function, as
  it is no longer needed.
* Refactors copy_to_sk() to directly compare keysi
  with the max_key from the search key. If a key
  exceeds max_key, the traversal stops early since
  all relevant items have been processed.
* Remove the inline mark for copy_to_sk(), since
  it is only called once in search_ioctl().
* Updates the comments in copy_to_sk() to clarify
  the reasoning behind removing the min_key check
  and to document the new logic.

By removing the redundant check and simplifying the
traversal logic, this patch improves both readability
and runtime efficiency for this code path.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ioctl.c | 57 ++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 61c4c6ac8994..857de98c5f27 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1447,31 +1447,10 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	return ret;
 }
 
-static noinline int key_in_sk(struct btrfs_key *key,
-			      struct btrfs_ioctl_search_key *sk)
-{
-	struct btrfs_key test;
-	int ret;
-
-	test.objectid = sk->min_objectid;
-	test.type = sk->min_type;
-	test.offset = sk->min_offset;
-
-	ret = btrfs_comp_cpu_keys(key, &test);
-	if (ret < 0)
-		return 0;
-
-	test.objectid = sk->max_objectid;
-	test.type = sk->max_type;
-	test.offset = sk->max_offset;
-
-	ret = btrfs_comp_cpu_keys(key, &test);
-	if (ret > 0)
-		return 0;
-	return 1;
-}
-
-static noinline int copy_to_sk(struct btrfs_path *path,
+/*
+ * This is a helper function only used by search_ioctl()
+ */
+static int copy_to_sk(struct btrfs_path *path,
 			       struct btrfs_key *key,
 			       struct btrfs_ioctl_search_key *sk,
 			       u64 *buf_size,
@@ -1490,6 +1469,9 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 	int slot;
 	int ret = 0;
 
+	test.objectid = sk->max_objectid;
+	test.type = sk->max_type;
+	test.offset = sk->max_offset;
 	leaf = path->nodes[0];
 	slot = path->slots[0];
 	nritems = btrfs_header_nritems(leaf);
@@ -1505,8 +1487,22 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 		item_len = btrfs_item_size(leaf, i);
 
 		btrfs_item_key_to_cpu(leaf, key, i);
-		if (!key_in_sk(key, sk))
-			continue;
+		/*
+		 * The btrfs_search_forward() ensures that the key of
+		 * the returned slot should be no less than the min_key.
+		 * This guarantees that no keys below the minimum threshold
+		 * will be encountered during the traversal.
+		 * So we only need to check the max key here.
+		 * 
+		 * If a key greater than max_key is found,
+		 * no more keys in range can be found in following slots
+		 * and all keys in range have been found and copied to
+		 * the buffer. So we should return 1 here.
+		 */
+		if (btrfs_comp_cpu_keys(key, &test) > 0) {
+			ret = 1;
+			goto out;
+		}
 
 		if (sizeof(sh) + item_len > *buf_size) {
 			if (*num_found) {
@@ -1575,12 +1571,7 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 	}
 advance_key:
 	ret = 0;
-	test.objectid = sk->max_objectid;
-	test.type = sk->max_type;
-	test.offset = sk->max_offset;
-	if (btrfs_comp_cpu_keys(key, &test) >= 0)
-		ret = 1;
-	else if (key->offset < (u64)-1)
+	if (key->offset < (u64)-1)
 		key->offset++;
 	else if (key->type < (u8)-1) {
 		key->offset = 0;
-- 
2.48.1


