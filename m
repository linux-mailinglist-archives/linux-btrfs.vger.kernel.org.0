Return-Path: <linux-btrfs+bounces-13225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434F3A96B7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 14:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30243A3886
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A5280CC8;
	Tue, 22 Apr 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSbu9uNW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F1277805;
	Tue, 22 Apr 2025 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326727; cv=none; b=OZTgD6raCYFkP3YxDNPWo8sovmdVU6zyF0Omp7BxVqtiaiqKB7flUXAeC7kBFR1tpU0GaEutxDPKtT26GjMa4vgaxaiincfTPyRKmGpZOGC87a84aqPA+kGBXrobqwJOAhLmMKmnPKPf4COuATc1CbRgqRak5LRJWxVjETwNf0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326727; c=relaxed/simple;
	bh=Oz6qd+SEwDAy7DYeHq1XLrFuBfupLvBjneFgJ5xUVC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5dfkfSpb2uh3t1jw7WqFLE/TdFoV0veopx5NGbVD6ET5+ELZYAFy8VFCRkYRi2Gjr1683Licm797FfrSEm+ThAVLzxVScwOWHRRMC219cWzkZ1+dCa2Ea+lQaAMre+RpX7J74EdRsBRjWObBuRFjoj7QwcC2q2sctGqt1QzsZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSbu9uNW; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-73de145c639so166142b3a.1;
        Tue, 22 Apr 2025 05:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745326724; x=1745931524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1caaeNBE9fBOa9chq6ixADhTDWpp9vn4eSoKuPgQVQ=;
        b=aSbu9uNWCz3jVa5wuY7g2Ldjit6vEKjJhNzlbX4GPERIgr6tmDteLaLlme8nXKSzrQ
         cRjDTu/H5KcEJUSeaGC0hNf2MPFHPWpyBDHfM/1fSYhGD8czhamxu1hyBm13cesvXN80
         ydKprOiWSvBy6ikCTq9ATcf7GUJ7JAyWSo9uq+6R/+dhV4kdhOnbGnH8ObnU7TgIRoH9
         Ao2lbsB0Wg+lgq56Myms9Ufk3Vzz4execD3At3SmeIq26/ab5/33/VCCPe5edUYUfCEe
         pVVAO/+v4HXoEYUqd3Aji6nYeLByybuNvePAi8jbO7VHLbaPCVkETiPD9XAYDMZudtrs
         8fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745326724; x=1745931524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1caaeNBE9fBOa9chq6ixADhTDWpp9vn4eSoKuPgQVQ=;
        b=n9xfmA8OcJtI9+2gNSpPFmOhla9CGLPqRolI40/YTa8PGnIFKt5/TYPZ+A2Q4S8NOy
         BmkA8lc2sK/L1QKLtjw2yS0ij/5K0YdhqQfaLeI6OURmQVMFth4RXdTaLmBiA/sCkZ/q
         xrmyWk2FgxsHIJ0pUysZmgZnc60MEC+ec6fFPT4Tx/SllKBHO75EHAbwjBr5kL4X5cip
         t8rTZK7MRBRbSqVJv04SOyVT4+N5PvoeDlyejJrpm2pUf4aILBFp4rMgmrvzNSUJyXwA
         WG6jSWYzetdzHAQETlDd2ucoy2yUYgCsiCteTVSK7G5ikqhp6G6BYA6zBwZowaOWxLM/
         LobQ==
X-Forwarded-Encrypted: i=1; AJvYcCViKA2r3/2IBf17dPOwjCMRJbt8HvdXorBynKYAiH+NkruQlDAAPKvUnhe5dVUfoi19Fy80yddq0+la/Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXEh1Fshv4FlCpteuNPFNE7H2S9bxbSysMjPStHQUEhd6o6Zz
	RZSxOpjEBZX+6a6fkPGar3/qpIjbJ02Je/k41LoiUeF8Rx6Hcgor9fReFQMXgDQbWA==
X-Gm-Gg: ASbGncvFkVaeKAOKc/yIqgpOkVQGSGZKMDqxLdu4+DdqYMWmr7kTYAXLHZLET/B4GrY
	DPfpjxyqx4f/fRAcR4lxsVsYZzoaGsVq2R0qyqH+Pp24S6HHQPLxOENNMJQszprOVcPfQW+v4cZ
	HU32WEFEgQYZgtIOZhfGqwjquDpX9Ey65jbITOCAgCmt6dgS+TTvCYlEEIXll4LLnwglcCzSFk4
	efuDWi1gpmfv/VtblaSn6C3D0Uc4Ro4/ShCFiwpbqP2CyHfJC30ukVGFYb1BR5mnhO8u1JnjgCs
	3IL/WAcr4kHOuA/f/OdOvoBrORMUs7G4jJqTwMglqu00mdiqakBz19uN4n3CAmTUgmvB3U/XRu+
	3vmY6s0NG
X-Google-Smtp-Source: AGHT+IGc6Y7VzDrAEv0qKQ8NFZq/gV/HRdZUoZ63PHfgJaFoc5GY2ESiq4ndT4P7o34jwKl5M51fZA==
X-Received: by 2002:a05:6a00:3901:b0:732:2923:b70e with SMTP id d2e1a72fcca58-73dc11819b8mr7902018b3a.0.1745326724459;
        Tue, 22 Apr 2025 05:58:44 -0700 (PDT)
Received: from SaltyKitkat.. (tk2-227-23497.vs.sakura.ne.jp. [160.16.103.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfacd6e5sm8432398b3a.120.2025.04.22.05.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 05:58:44 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] btrfs: fix nonzero lowest level handling in btrfs_search_forward()
Date: Tue, 22 Apr 2025 20:56:42 +0800
Message-ID: <20250422125807.30218-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 323ac95bce44 ("Btrfs: don't read leaf blocks containing only
checksums during truncate") changed the condition from `level == 0` to
`level == path->lowest_level`, while its origional purpose is just to do
some leaf nodes handling (calling btrfs_item_key_to_cpu()) and skip some
code that doesn't fit leaf nodes.

After changing the condition, the code path
1. also handle the non-leaf nodes when path->lowest_level is nonzero,
   which is wrong. However, it seems that btrfs_search_forward() is never
   called with a nonzero path->lowest_level, which makes this bug not
   found before.
2. makes the later if block with the same condition, which is origionally
   used to handle non-leaf node (calling btrfs_node_key_to_cpu()) when
   lowest_level is not zero, dead code.

So Use if conditions to skip the non-leaf handling code instead of using
goto to make it more clear, and handle both leaf and non-leaf node in the
lowest_level loop exit logic.

This changes the behavior when btrfs_search_forward() is called with
nonzero path->lowest_level. But this never happens in the current code
base, and the previous behavior is wrong. So the change of behavior will
not be a problem.

Fix: commit 323ac95bce44 ("Btrfs: don't read leaf blocks containing only checksums during truncate")
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a2e7979372cc..3e69e705b5dc 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4636,38 +4636,28 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 			goto out;
 		}
 
-		/* at the lowest level, we're done, setup the path and exit */
-		if (level == path->lowest_level) {
-			if (slot >= nritems)
-				goto find_next_key;
-			ret = 0;
-			path->slots[level] = slot;
-			/* Save our key for returning back. */
-			btrfs_item_key_to_cpu(cur, min_key, slot);
-			goto out;
-		}
-		if (sret && slot > 0)
+		/*
+		 * Not at the lowest level and not a perfect match,
+		 * go back a slot if possible to search lower level.
+		 */
+		if (sret && slot > 0 && level > path->lowest_level)
 			slot--;
 		/*
-		 * check this node pointer against the min_trans parameters.
+		 * Check this node pointer against the min_trans parameters.
 		 * If it is too old, skip to the next one.
 		 */
-		while (slot < nritems) {
-			u64 gen;
-
-			gen = btrfs_node_ptr_generation(cur, slot);
-			if (gen < min_trans) {
+		if (level > 0) {
+			while (slot < nritems) {
+				if (btrfs_node_ptr_generation(cur, slot) >= min_trans)
+					break;
 				slot++;
-				continue;
 			}
-			break;
 		}
-find_next_key:
+		path->slots[level] = slot;
 		/*
-		 * we didn't find a candidate key in this node, walk forward
-		 * and find another one
+		 * We didn't find a candidate key in this node, walk forward
+		 * and find another one.
 		 */
-		path->slots[level] = slot;
 		if (slot >= nritems) {
 			sret = btrfs_find_next_key(root, path, min_key, level,
 						  min_trans);
@@ -4678,12 +4668,16 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 				goto out;
 			}
 		}
+		/* At the lowest level, we're done. Set the key and exit. */
 		if (level == path->lowest_level) {
 			ret = 0;
-			/* Save our key for returning back. */
-			btrfs_node_key_to_cpu(cur, min_key, slot);
+			if (level == 0)
+				btrfs_item_key_to_cpu(cur, min_key, slot);
+			else
+				btrfs_node_key_to_cpu(cur, min_key, slot);
 			goto out;
 		}
+		/* Search down to a lower level. */
 		cur = btrfs_read_node_slot(cur, slot);
 		if (IS_ERR(cur)) {
 			ret = PTR_ERR(cur);
-- 
2.49.0


