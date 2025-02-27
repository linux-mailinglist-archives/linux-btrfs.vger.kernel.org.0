Return-Path: <linux-btrfs+bounces-11898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5EAA476AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 08:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BD13AD764
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FBF22069E;
	Thu, 27 Feb 2025 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAV7nAGC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945C21CC78;
	Thu, 27 Feb 2025 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641726; cv=none; b=CoEAAMS06yrNl80z676L3wBVfReS/quSMKLQVuNqGxj8hVP1syKib88DBxbIdk85X+ZxozdCQbolDn56MjNZ1RNuLqQu/jbsLifPwY2Q7P0sjzyO86vsT/qiDd+fg2vdoNai+kl9XrPB7AmK77jRPxhBFjIMu/iZfbLkJJMsFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641726; c=relaxed/simple;
	bh=8hg+9araqvEMPI2HTgeHHZA6fNAP81AgSp6OmVnX3Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVJP1oN4lpgDX2BobAEQD3MjyckvYITteM2a6+/xEct/EF21L+ml9xIQ7xJsJxJCkVOAk9WfhltM8fRlp80TW3wnPuRhIzQzZ7Qq5DLuJ+489oJRHX0wSTl+UULTNh9WsofC8GCnPNM6WW2Mh5xCtLFZekw3vC9mVVHGHtoeExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAV7nAGC; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2235025322fso1019565ad.2;
        Wed, 26 Feb 2025 23:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740641724; x=1741246524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tuiEsUqTezBrxInrICHfQuSg7HvE344EU1ThXTmLiXU=;
        b=MAV7nAGCnv/V4C2VZm9eIZNMbSPBoSNaOt+m8imndl6wwcWmrqVLl21V8M2vnYOH9l
         SX//W2F99QgcbbmP2GScopTxVYN1GZ+QJMtyMbGymI5onAkIGGzG/v87Keqb0XqG+yXO
         +FSZA+XLVtmaz4gADqQr0gUgC6Uk65vkcH3y+3GccdgNlxoeuRz1y/MGR2ujEEXCVMiz
         eKHG4xxqN+qDFpyNWTljEXOW+FyuwoWqoDD+72YWX2fH7lG3rSIiF+D64x/hpqXWJyjF
         thSmy33kY/lG2nfn5HG7ho0wgs5mHf/PSz5OtX0xPJ8yHauB6nZ6acUR98jmO9Ob6cvJ
         oC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740641724; x=1741246524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuiEsUqTezBrxInrICHfQuSg7HvE344EU1ThXTmLiXU=;
        b=aPqc4kUh8nJsefbdXcdQEsv22Bt3FNwJmGW9FdW6p96ckpncTNllzzI3J1r09arRcg
         61uBE/8Jbcn9VsEKjA6Ta53asZ5LuNfS+aBJ1rmgDbLGRWe511DSzU80lUI7Xgg16wE4
         wrXbOpotC4VD3Gvm3yQ8IN2IqwAyHcq9AxrToArvGCmdkvE8ibssoDjCgvtK2LELK8XY
         gOyXxmIDJesum06hjkxPHkAqfYps8kWH0el0UDshvcJPv3H/yjx0DKr4D3jd/nc8afi1
         saisKAp2JAbhK0Afj4DN85VzpOB84A+AGDPz/0sNLfYvTn/lKt7weCUKDSmiZo1lHBzN
         J/lA==
X-Forwarded-Encrypted: i=1; AJvYcCWyYQ7J9Vscf2FIBFiWdyzpHvn8qQBdUsIBkHs8fdX/4MJEUS3VxGJPy8jAvkXSI1jaid/qn9WeVZ4r4hMX@vger.kernel.org, AJvYcCXZNG2VxuutPb/4+DbW40rnUDkBCWd27w9j5k6c2h9I6GPFvSnVzBsnIj4mJxwnbaMKyF4tQsuplWF77g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDI+8BbYxfn1Ix4PJN/aUOViqvq7oDI91ZAvLc7cfIVPYOXDh
	9n37RN+WNNbtEi2zxV+UagsquPqjkt/GJv9fDNJ8z/6aMS92CNV6
X-Gm-Gg: ASbGncsrgJ16W+gBpiyMSvwtJ4tddfUDSf3ZHJkTuz4GpNalWgJnoiutK0NC6oOds0/
	BFXljVdKy3lMAT3/yHEpTausIN3tso6dRO/Qml2ba8WHaS11bcpSKGMEV7M0jDqq3Ex1mMRz+B7
	MPrlAwHd4Eb1/rkb2FYZpbhfn3uSn/dsocfdR91m4q3+r2qnIj8BrGB0oK3wRQ1M39QRUkL6LVm
	iNh3ZvKaQfGByQcfH6YE6BBeiL2aiq1GgE4+ld/Ia5CGboRvG+kT9TYcb0Il4FwLkCPNhc+uHTE
	7qZYcVTZ106gvH8ZmNyO9nvnJ6I=
X-Google-Smtp-Source: AGHT+IFVNaKaThEpZWarAFUAoVnKLdGRyEHbvuziklT+DeHtIeeC/OIp3vD5A6k3YedUKxSAKj4yOw==
X-Received: by 2002:a05:6a00:1489:b0:730:8526:5db2 with SMTP id d2e1a72fcca58-73426db0babmr13541342b3a.5.1740641724316;
        Wed, 26 Feb 2025 23:35:24 -0800 (PST)
Received: from SaltyKitkat.. ([2403:18c0:5:400:bca6:d6ff:fe8f:8ac0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48858sm868340b3a.51.2025.02.26.23.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 23:35:24 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.com
Cc: Sun YangKai <sunk67188@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] btrfs: simplify copy_to_sk() by removing unnecessary min key check
Date: Thu, 27 Feb 2025 15:35:04 +0800
Message-ID: <20250227073509.1764-1-sunk67188@gmail.com>
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
index 61c4c6ac8994..abf1ce7e9208 100644
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


