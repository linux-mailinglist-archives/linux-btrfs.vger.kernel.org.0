Return-Path: <linux-btrfs+bounces-11008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EE3A16149
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 11:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30BC1886278
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 10:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D151B86EF;
	Sun, 19 Jan 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqg6GrTu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E5A19D081
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737283859; cv=none; b=rdUfrJE80KO8zkpQhcOS/uzlReIg96ZfTsuoHeowGfnkx5EVOWDuD+TToy7MaEmpepznHRLWywAzfY4b0Ac1iMW07luAyvl8sp368sWPxhWa0mnhZTufktb7xduC1Q5nAkigDN+Ek91u8cr5E8Bm9AlHT0KWIRNy6p5iYPBcKmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737283859; c=relaxed/simple;
	bh=kAK8aLQ1gQ+g72HVqW5fECLUlDawY+rAMljFrrsssYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EgTsSqb9ZZNKQMD6ibXi4mpj9xWm/BQ4mIY7Y9fROFstnfHbRnGjhNgk6gQnJDToIdDh5vUXw48oQnxXg9fh2EH8cu2zj02sAsBLzi77vf1Lm7H9gyhIrccZVChccCHojCp4YEMDXLoRduIhulDRVHljAeiYRPiDHAvCgMMZR/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dqg6GrTu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2164b662090so64017635ad.1
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 02:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737283857; x=1737888657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIxMbMqFSfGftBT02XRBjX+imISqWW9AL0i2P7oA2R0=;
        b=Dqg6GrTuOgA4M2U0UvCiACTItiYNpnxsyfydyuVTUhrNELf5ypRjhT0ksBhHYXCqX3
         3G3B3uMuBJLZz86fgr0L7kslnlvsV4CRlhBCfTy8p8x2UvPD7Ubi5KuPre2xM3S0Rm4V
         eD7QUBY6Jco1OzDo1tOkVwyul0hQopfmjMXfkpp0JJLB6AnTq8STvhhlrkBgNS/FyTXX
         nVS7vFVwD8FkIc2w2I5iAgCHTDOnmK7LwEq/xagJDPrFkI3r4306g/SVc0254DjfOOBw
         l3yPyeRahAPNCxOkoZcEDFON/UjIi9jk+BND5rxYSWzVYywGktUtGX87ObXzGKTsPyHw
         F0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737283857; x=1737888657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIxMbMqFSfGftBT02XRBjX+imISqWW9AL0i2P7oA2R0=;
        b=JkTcuVgJ0iWRniLuT46gMBcakux2Z6lrLozmMSwrrepTia1pjYnRyAjix8gcLQBxL9
         BCDuzJ4NmsCnBwkSGVdzA/xkFbdoX9ayzxFKVMcEXaL3aIlAxhSaBSYqnMZiqHeTO7DU
         smk2sEhjvb3k7aFAt8pnzejuHhQIMHApCShLibYIUkCGEC8M27TJ+XIk5M0BxSYE/tO0
         XGJsR9pXCWkWrZtxCPpQAmIdbMzRL22FgayCmF+z75IbUcha9CJI01iVjcUD6HPAAjsG
         kGtfZaIRvIY4uWapDPaZUVMfM87zQ8aHXYRbeTBfZJVZpgWG1DGx+MrYQsffoaCaMip6
         Jd9w==
X-Gm-Message-State: AOJu0YxoqrskeHGLnQTd9F606BhjlotitAkTT7X43+xQwBzpasT5r7RI
	YNvTie9Id1mLif/c1oVQwk0h+Pzp6JQ8NwZfza7VReHs1fC46+IZPzVkKg==
X-Gm-Gg: ASbGncsMG8wcbPSUv1rlA9/cOEiAbzkfcdb5uRIownO816xngtI+H69hSp7iZVCAWZX
	WfHtdKLu+ECYeJue8GYpcPieRWJuUr5LcTZPfqC5/ximxQWcrV7kcNaj5f358mLlzbFuqGgmhSM
	KIZXddeLmpxPr9PqEdoZk6Sa2AFKZaovWloa5na0aibApEU1/BfCLgcV136H8V1w5c9uQNeXk3h
	M2V9p6yScmBSzF0MJO4vgSwOJ4iI0+YjzCT3Qy8nA16oCeSLg/E5Pfu5h6WJ6Jh63CQUgt+LAVW
	ZprvVCyCRlrtDKkUe6v4VAd9gew=
X-Google-Smtp-Source: AGHT+IHK2nkymolyXU9U89OxeHwsine/qvTcB9pg+GRiCt2Hiyve2tFd1JLH6eghD2VrCrcnmu9/kQ==
X-Received: by 2002:a17:903:1ce:b0:216:4a06:e87a with SMTP id d9443c01a7336-21c355dc64bmr139735395ad.40.1737283856619;
        Sun, 19 Jan 2025 02:50:56 -0800 (PST)
Received: from sidong.sidong.yang.office.furiosa.vpn ([58.238.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3aca04sm42961215ad.135.2025.01.19.02.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 02:50:56 -0800 (PST)
From: Sidong Yang <realwakka@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: cmds: show child subvolumes during recursive delete
Date: Sun, 19 Jan 2025 10:50:46 +0000
Message-ID: <20250119105048.5452-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a subvolume is deleted with the recursive option, any nested (child)
subvolumes also get removed without report it. This patch modifies the
delete subvol command to print a listt of child subvolumes during
recursive deletion.

Issue: #923

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/subvolume.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index f34d9400..586f2071 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -507,6 +507,33 @@ again:
 		goto out;
 	}

+	if (flags & BTRFS_UTIL_DELETE_SUBVOLUME_RECURSIVE) {
+		struct btrfs_util_subvolume_iterator *iter;
+		err = btrfs_util_subvolume_iter_create_fd(fd, target_subvol_id,
+							  BTRFS_UTIL_SUBVOLUME_ITERATOR_POST_ORDER,
+							  &iter);
+		if (!err) {
+			char *child_path;
+			struct btrfs_util_subvolume_info subvol_info;
+			while (!(err = btrfs_util_subvolume_iter_next_info(iter, &child_path, &subvol_info))) {
+				pr_verbose(LOG_DEFAULT, "Delete subvolume %" PRIu64 " (%s): ",
+					   subvol_info.id,
+					   commit_mode == COMMIT_EACH ||
+					   (commit_mode == COMMIT_AFTER && cnt + 1 == argc) ?
+					   "commit" : "no-commit");
+				pr_verbose(LOG_DEFAULT, "'%s/%s/%s'\n", dname, vname, child_path);
+
+				free(child_path);
+			}
+			if (err != BTRFS_UTIL_ERROR_STOP_ITERATION)
+				warning("failed to iterate subvol : %s", btrfs_util_strerror(err));
+
+			btrfs_util_destroy_subvolume_iterator(iter);
+		} else {
+			warning("failed to create iter: %s", btrfs_util_strerror(err));
+		}
+	}
+
 	pr_verbose(LOG_DEFAULT, "Delete subvolume %" PRIu64 " (%s): ",
 		target_subvol_id,
 		commit_mode == COMMIT_EACH ||
--
2.43.0

