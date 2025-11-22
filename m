Return-Path: <linux-btrfs+bounces-19266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2325C7C8A8
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 07:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1FB3A7A29
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 06:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2433293C42;
	Sat, 22 Nov 2025 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN+J8a+S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4236D4E5
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Nov 2025 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763793396; cv=none; b=Oq9BpOmCV5DtALs6ARtn1mukuVgrqPEac6NpHt6xHKTdfvTKyR+UtUht87jJ9TWyqMYqTMd5d+FSahRXTrfXnQ+IJOtjDXz+7/Avql4Hwk0FkS3lsT2mpgQSYiVL73e6YMjcv2LiOxluonobTVl9h9tiI3PX2lkBwlWSPKCrPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763793396; c=relaxed/simple;
	bh=NkzpNVgxMAVPyseiMi6Phfrz4r3Eseu0EHiseaXATM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsKQSZywR8VF8KZWZWCvjfxd7/wDx6FbSSENyihRwvwyujE3V9l9BYHKFaztx2u2IwaXI5Av9SqW2K6wauNUJ1L1JxSZQk+U7G6nYoMNrUWS9o1fLS4MI49mE28kYA2Ksaf6DyX3QdVMUcyiq6yuw8Bf3g327NBPmTj+MGQQ1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RN+J8a+S; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-bd2decde440so185603a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 22:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763793394; x=1764398194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dq8fJAxy3nOvPaNDWdvqdt4+s+tq0xKi9xtqeJDe10=;
        b=RN+J8a+S4wePcJjbQZa4eFmzA17hzjd/xP9FOwnXizyXN3sZEMSBwb+MeRMBnqQnlG
         AGd/Az1N+TF96jd9/12rHpHQuhTzufDmuqXxNOzC8Fe7jRRqpAI5fUOaW2WTPgpTsSaC
         QvOi9QSnOswmAmUW6pZjlyeyqd0OQJbgO4RCBLVDQtHNUIarPzMJrnLV2ZumjiCkcoGg
         e26KNRwzOqIFiLHEZg9rXcocToypygB49Io7FeUQ0mMQHffiYGD/pSaw5oz36p6b510p
         S4fx0OU4b8K8af+0moDBn74QMQIJOU+zjBGpAKlOWtYXn6rzgTp8CGkV9+voUFf2iRyB
         XXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763793394; x=1764398194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/dq8fJAxy3nOvPaNDWdvqdt4+s+tq0xKi9xtqeJDe10=;
        b=c2Tcuray1udtAMlkJlV+RBSWb84vfgwbMUv8skXnLD3fwjfWS31Atk8NmTNKfuCqJQ
         79zUbi/sKEwcQOgyF4OlwDaTy3SjMuyyw3uS7qLI1iLIazThmr7tfrhMu8Ht/ThcG5dZ
         5dUOlhLGw1u+YFRN28jtxaD6YF2KaXrsNxlCtf4e1eUOj4v4rYdnAQ3ZVQK/8M08rjNJ
         myzDPx/RJ+teLaup3XPxKB451uX9u69AUdXPdu9fVTHBnAf/OlB0Iv3NEeBDKio2f8AK
         6rkehXunSvBRN9XdJAOluRvHOdwXoFW4jW2pU8lbhaJJ9FQZjzNg097ePNOVlHrB8l5P
         7Kiw==
X-Gm-Message-State: AOJu0YzLEfpdaQaotB+TPDtGJsEZyGCIgWSvaII6wa4bZF8DkILjFjaI
	zobqNP4h8nIN1t/lM6BYvZznCfdiY+Way575fFuKKX63BGJmO8Py0ZEQx3V5S4MJdILiFirp
X-Gm-Gg: ASbGncsVNNlmzSjoyNX1FfQxmc+X6LcvpX8LAyMneE2UO3DUGMxgMq6M1y9O9ifZgu8
	NiUMrHrjuXPkIPMZCnE1zKiLfXUsDksH96EZKTB01QMXQ0h6TtciqCov6PXghAIYKUcrHMGpfYN
	ZLPqH01AZCd/H1JAGzD0Zk6iK2zXmguCKXu5PWrd2/RQ0kMBN766o1bZOoLIlVqrcZK4nUX07Mf
	/PzFojCyDlw+MF+WCr/m+IfpVcH9H+P5eHBPfmMHKBIyf68of+fycXDVoYs7jGxgvxTPQ4iQFgh
	NukR2wwFqkmIZDfMaPZnaVqbA7/LqmHDzaPmABQfQtl6+Sw/YlF3jKAeNs3v5zcnSze6kn0OfhJ
	5lXi6SPmZNM5fbBBCdJoTLhKU7nXqTh5cNnt5SHraRyIW8HqX1sPXp1avIHwfrAgFCsy1gbI485
	/iDQt+GWGMDGifsn3gZ56nMQ==
X-Google-Smtp-Source: AGHT+IGNgCrqjP1nVnwwReV8z+2yiOpMMnqEo49Df4ul3C7TGKTFuqZJLep+oTF6QeIQx30qqyd4kw==
X-Received: by 2002:a17:902:f650:b0:267:8b4f:df1f with SMTP id d9443c01a7336-29b6ff75accmr27706635ad.1.1763793393811;
        Fri, 21 Nov 2025 22:36:33 -0800 (PST)
Received: from SaltyKitkat ([203.106.195.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2ada18sm75555515ad.90.2025.11.21.22.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 22:36:33 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 1/2] btrfs: use true/false for boolean parameters in btrfs_{inc,dec}_ref
Date: Sat, 22 Nov 2025 14:00:43 +0800
Message-ID: <20251122063516.4516-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251122063516.4516-2-sunk67188@gmail.com>
References: <20251122063516.4516-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace integer literals 0/1 with true/false when calling
btrfs_inc_ref() and btrfs_dec_ref() to make the code self-documenting
and avoid mixing bool/integer types.

No functional change intended.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c       | 20 ++++++++++----------
 fs/btrfs/extent-tree.c |  8 ++++----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3c4aea71bbbf..1b15cef86cbc 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -292,11 +292,11 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	}
 
 	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID) {
-		ret = btrfs_inc_ref(trans, root, cow, 1);
+		ret = btrfs_inc_ref(trans, root, cow, true);
 		if (unlikely(ret))
 			btrfs_abort_transaction(trans, ret);
 	} else {
-		ret = btrfs_inc_ref(trans, root, cow, 0);
+		ret = btrfs_inc_ref(trans, root, cow, false);
 		if (unlikely(ret))
 			btrfs_abort_transaction(trans, ret);
 	}
@@ -420,15 +420,15 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 		if ((owner == btrfs_root_id(root) ||
 		     btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) &&
 		    !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)) {
-			ret = btrfs_inc_ref(trans, root, buf, 1);
+			ret = btrfs_inc_ref(trans, root, buf, true);
 			if (ret)
 				return ret;
 
 			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) {
-				ret = btrfs_dec_ref(trans, root, buf, 0);
+				ret = btrfs_dec_ref(trans, root, buf, false);
 				if (ret)
 					return ret;
-				ret = btrfs_inc_ref(trans, root, cow, 1);
+				ret = btrfs_inc_ref(trans, root, cow, true);
 				if (ret)
 					return ret;
 			}
@@ -439,21 +439,21 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 		} else {
 
 			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
-				ret = btrfs_inc_ref(trans, root, cow, 1);
+				ret = btrfs_inc_ref(trans, root, cow, true);
 			else
-				ret = btrfs_inc_ref(trans, root, cow, 0);
+				ret = btrfs_inc_ref(trans, root, cow, false);
 			if (ret)
 				return ret;
 		}
 	} else {
 		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
 			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
-				ret = btrfs_inc_ref(trans, root, cow, 1);
+				ret = btrfs_inc_ref(trans, root, cow, true);
 			else
-				ret = btrfs_inc_ref(trans, root, cow, 0);
+				ret = btrfs_inc_ref(trans, root, cow, false);
 			if (ret)
 				return ret;
-			ret = btrfs_dec_ref(trans, root, buf, 1);
+			ret = btrfs_dec_ref(trans, root, buf, true);
 			if (ret)
 				return ret;
 		}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b22b0aaa99e4..527310f3aeb3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5469,12 +5469,12 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	/* wc->stage == UPDATE_BACKREF */
 	if (!(wc->flags[level] & flag)) {
 		ASSERT(path->locks[level]);
-		ret = btrfs_inc_ref(trans, root, eb, 1);
+		ret = btrfs_inc_ref(trans, root, eb, true);
 		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
-		ret = btrfs_dec_ref(trans, root, eb, 0);
+		ret = btrfs_dec_ref(trans, root, eb, false);
 		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
 			return ret;
@@ -5876,13 +5876,13 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 	if (wc->refs[level] == 1) {
 		if (level == 0) {
 			if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
-				ret = btrfs_dec_ref(trans, root, eb, 1);
+				ret = btrfs_dec_ref(trans, root, eb, true);
 				if (ret) {
 					btrfs_abort_transaction(trans, ret);
 					return ret;
 				}
 			} else {
-				ret = btrfs_dec_ref(trans, root, eb, 0);
+				ret = btrfs_dec_ref(trans, root, eb, false);
 				if (unlikely(ret)) {
 					btrfs_abort_transaction(trans, ret);
 					return ret;
-- 
2.51.2


