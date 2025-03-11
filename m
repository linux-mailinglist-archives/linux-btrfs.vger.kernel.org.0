Return-Path: <linux-btrfs+bounces-12181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882CBA5BA96
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 09:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FB33A8FB9
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992961E32DB;
	Tue, 11 Mar 2025 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itGqkTO0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A9C22424D
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680832; cv=none; b=eb5ZGN9OyvjgXQFjGMoBgU5JDd47MZBJ9EwpnasgBHfp4TQ7dn/L2+b+u8Y+uLp08C9TGDw+ypx3L+o/Cv18FCAdyOxtAOBmdjptZ2KYKAn11XT57/dWcQnnMtgkZucYrsGEneoZVes1Wf6a+D9ptuNNCOVfmVRl25cs2R0SrVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680832; c=relaxed/simple;
	bh=azmgcxDlEMkbz/7g7z29i1xHMvyruUTz9bJ+3ND+MH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKgnJ7E+IA8WBsMy19Uon2Opf6Cw94TO8mKL3oUfr3FLsLM547tbI3INE0yXR2+xJUa9k/ZkB70hzFhJFqNUmuVNzV6m4hyWkwAcVhTeIaX1Ky5MhVU+HBeZmBxWV4NMRTgkv82jVCiWpiGWkoWHX6O3ECc/BA7BQojfGfC5fU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itGqkTO0; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so1298619a91.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 01:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741680830; x=1742285630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGvsEwl+QgfiYAvu22GsPUjaCyd2Fecud6lvlrtcaCM=;
        b=itGqkTO0NKwjwNIRIQyUd37frWjVI4kp/XEAoqRymL9oalj3UqrEKilN2uKzpLRn8S
         /8DLyP1KQKk9jMCRewiNb13IQG9e31BKJAyRW0+N3fI+3MZbCGwny1bZUsbGcfU15nWD
         pMnSk5vBPB96XZGCyjkmP39vXXZjYryRm04CtOZY0Jcrun+Ag7Y0KlPBhOQYml25vvAe
         vJRedzIYjKoAKLF+yuVNLGyqEFk9hfSuwx+RnnNkkgf24wXwVfUQgliGtrNblCeo4c5a
         /OnJVYaV5dZtVV3sVjEsCZ9NT1C1MhnG0XRQOArEVu9k1CbAhd+2iGNf7eBnvT+KLJa8
         j2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741680830; x=1742285630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGvsEwl+QgfiYAvu22GsPUjaCyd2Fecud6lvlrtcaCM=;
        b=OBUGxBnDuP0W5M4izrEjid4xMi36Fdu/eF3N4oS6VBmrCiuJowRQdTYntdINI42Q10
         B7I9fDP3qE9ZjGmKsnSadB5GY7ky4bA9K0S2KUmLpHL4nFkEwORAVWE1WOxAhD7RQPTh
         m6af6IGWQBlUjzzogvm9PwEf2ZDRrRR5uVQA86RrH/PqB3Ajulei9u03C3kV1+XXx0/r
         B6jGGNVN0BDG5TJXbiiaUL3TJCFfhynWylQQUPM790O8VhMl+sq0tarQdq2xxgS7cX5w
         oxX7uue6d9A1jYKrgBT+6mhdEx9oF5N7ntBzuR9QRMKz66NA0fR3SATYkmFINMSI+MLv
         +Rdw==
X-Gm-Message-State: AOJu0Ywltqha0RzkzbiMUWCKtsPRNpt4pmBkDgZAC3/R50ZFkdhKoweC
	T3ED1Rx1vOP/hBv2IWpy6Lz2EJkX6ReqOa7VRlMLJVtpzuXTCtmatFOllr4d1Geljg==
X-Gm-Gg: ASbGncsjKMSA52rIWY5qLFcqRT9dXkoIT4rdT6DePx3cBcxo9RE/IVBVNM+hFpYtK8s
	f3oGqPtHLMpWFXJR6BxGbIdqqJHkgdYQbDOE4XG5OqvpmUUIW1eNnfkkMyeDNb9DZ5JdZzHMdct
	vpJfNXwSqTAM+kszog+aUNZR3gluGJ4O3jlNYajv5T1yqWpjPNit13JeIS/alQt/NAxBNV3C6kS
	jCT51Rw7lDGqbR3i2bRwOnbmuTPC85S8alm2UBt0UsOBj6vsXQXVDRuRapT0kkmvniVO+jTO4On
	xxJ1Wao5ZLGBN293R5YvNbUU7TCMBJHdHcr8fyFVoFYyhGY=
X-Google-Smtp-Source: AGHT+IHgpJRCHa4+VNLUYF2HGmwJTNHOmUSqmasmhf1QEP+CExTo3tJU20UlLjyP5qxLWM51fgfYEA==
X-Received: by 2002:a17:90b:1a90:b0:2ff:682b:b754 with SMTP id 98e67ed59e1d1-300a2b70cb9mr6774469a91.2.1741680830406;
        Tue, 11 Mar 2025 01:13:50 -0700 (PDT)
Received: from SaltyKitkat.. ([198.176.54.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa5cdbsm91203635ad.230.2025.03.11.01.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:13:50 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>,
	Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 2/3] btrfs: remove the unnecessary local variable in btrfs_search_forward()
Date: Tue, 11 Mar 2025 16:13:13 +0800
Message-ID: <20250311081317.13860-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311081317.13860-1-sunk67188@gmail.com>
References: <20250311081317.13860-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'found_key' variable was only used to temporarily store the found key
before copying it to 'min_key' at the end of the function when returning
success (ret=0).

So eliminating the 'found_key' variable, and directly store the key into
'min_key' at the exact loop exit points where ret=0 is set, maintaining
identical functionality.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3dc5a35dd19b..5f7c937b0f4d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4608,7 +4608,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 			 u64 min_trans)
 {
 	struct extent_buffer *cur;
-	struct btrfs_key found_key;
 	int slot;
 	int sret;
 	u32 nritems;
@@ -4644,7 +4643,8 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 				goto find_next_key;
 			ret = 0;
 			path->slots[level] = slot;
-			btrfs_item_key_to_cpu(cur, &found_key, slot);
+			/* Save our key for returning back. */
+			btrfs_item_key_to_cpu(cur, min_key, slot);
 			goto out;
 		}
 		if (sret && slot > 0)
@@ -4679,11 +4679,11 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 				goto out;
 			}
 		}
-		/* save our key for returning back */
-		btrfs_node_key_to_cpu(cur, &found_key, slot);
 		path->slots[level] = slot;
 		if (level == path->lowest_level) {
 			ret = 0;
+			/* Save our key for returning back. */
+			btrfs_node_key_to_cpu(cur, min_key, slot);
 			goto out;
 		}
 		cur = btrfs_read_node_slot(cur, slot);
@@ -4700,10 +4700,8 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 	}
 out:
 	path->keep_locks = keep_locks;
-	if (ret == 0) {
+	if (ret == 0)
 		btrfs_unlock_up_safe(path, path->lowest_level + 1);
-		memcpy(min_key, &found_key, sizeof(found_key));
-	}
 	return ret;
 }
 
-- 
2.48.1


