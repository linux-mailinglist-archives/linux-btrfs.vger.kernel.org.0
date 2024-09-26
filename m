Return-Path: <linux-btrfs+bounces-8265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2331E987638
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 17:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533D51C24EBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA0C14BF8B;
	Thu, 26 Sep 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Duc255lC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D01EAD5;
	Thu, 26 Sep 2024 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363177; cv=none; b=sUGyiGizBopfUIl53Cl05GzTLYOCjK75DeCM8YGKu5bQ+QLxa0HPJGXqEs0pRcI+AvmJ9dgswInk9bcYjCmf2eVQhybNYDUX0fKtltwJpGndy6gjmLJ5zMSwJFemkVIaFuE9HL8BRnE5A2UgY3M3bBwC6GCGBGWjyWFiSGMy53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363177; c=relaxed/simple;
	bh=VMgdYxqwZw2CBmoTc0olJuVK9+Rj042dsdpbAHc2qRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IswJ6hAyZViLBgbzwledc7+gXpkTyFkjW+VnSCYe4iqMiTWvmTcc5xFtgKlCEVgpmIn2F+f4i774y+jPltu7cPtSUk741FtAqiwSkII4H9Z5RSKnE3xh3g7nZdxPVGy7HQ9xhrJykMtJGitk7G+e9dbzZIWKwoR4RXR2AOVwPJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Duc255lC; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-710e14e2134so637534a34.0;
        Thu, 26 Sep 2024 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727363175; x=1727967975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+t9mzZCgU476gMWQ4P/6LYkVX8h6Med+hDfNmEpc/1k=;
        b=Duc255lC6oPJ/HpBTAGrnzWIij5Wl79Hx01pSLbTqMlbOB2EqOd3nWf2i76L4mNcLw
         oyA6e+Fip+3ePebQd/hEuE9B0TD2BXIPEh5fsHXm7cFg3bNOiM6OksaeF/7Efz0GLOhe
         UrgmnD56H5WdjdUWqjFWdZrJXXrFoHLAHuk8/Bp9OCY7QSrqtxXgDYV/ZW37BklVX12U
         ekkNik1/5LIa3sS/Ly6ZcMnY8Ubp9kz78cYyR4Zl4yCQCr87YxJO+/R1qvtwdC6/js0+
         d9sDGtDyEZ3WIp9Ql0aRKR8r6RXW0tUl/4AYRNtA2CS4h6wmB4604wxeDAq6hgieKrtM
         zImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727363175; x=1727967975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+t9mzZCgU476gMWQ4P/6LYkVX8h6Med+hDfNmEpc/1k=;
        b=Mw1ykZJ1g7pzqxzmEjd1daic5tENiHqLAvfFidwE7PU9BiCQRJwcP46h4WFy7wC+jg
         Tep4gZ2m+HlzexV/AMER25JjiWxNkJqIMxYqJO+RGDFNfrL8V1502C2QeDDMLGVPeURB
         tUqf+uHxnH7nr4zebT7P/XSgXYNDWfAiHkH3dHnsHlKwBQlLE+E7hwrjDMFECzTmjzDw
         Ipk4gaJktXRLhkA9DH0przi+vg5lRhv0JGRDxsJ+Q/Yidw+zOpAafbtm0tnTO9437fE3
         qQbmFrUIRSOv3Ppzl6x8D9REtQYwLJ+RysQ2abajzWNMYjd6yGxJwaPvaBkChFJQ2ezn
         iV2A==
X-Forwarded-Encrypted: i=1; AJvYcCX4NM3GPWClrKyG+2fvHEZjUf4pqLeINIg0fNtk/JHFYGS455gOh78+nYXafamUek4BRUe7gJXsNw85SX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3lgHpdKej9DkazN14Gn9phm2GtyzIG1wJ9q8sW41Qr8r737a
	QpceM6ukziY62PtF3P5IYgM/IsJj6veCIS2mfcbnjmSZCDfmsL85
X-Google-Smtp-Source: AGHT+IEbKUb8qPOQKB9YD1j0rocvtAxgd1Na0LBfHO2qlQqfBv5UZ335WpXW+4TFkNDuCvwHFStayw==
X-Received: by 2002:a05:6358:8a9:b0:1b8:33f2:7c81 with SMTP id e5c5f4694b2df-1becbb5f930mr17747955d.8.1727363175271;
        Thu, 26 Sep 2024 08:06:15 -0700 (PDT)
Received: from fedora.. ([106.219.166.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2b974bsm6198a12.34.2024.09.26.08.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:06:14 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH v2] btrfs: add missing NULL check in btrfs_free_tree_block()
Date: Thu, 26 Sep 2024 20:35:56 +0530
Message-ID: <20240926150555.37987-2-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 3ba2d3648f9dc (btrfs: reflow btrfs_free_tree_block), the block
group lookup using btrfs_lookup_block_group() was added in btrfs_free_tree_block().
However, the return value of this function is not checked for a NULL result,
which can lead to null pointer dereferences if the block group is not found.

This patch adds a check to ensure that if btrfs_lookup_block_group() returns
NULL, the function will gracefully exit, preventing further operations that
rely on a valid block group pointer.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
v2: Added WARN_ON if block group is NULL instead of jump to out block.
v1: if block group is NULL, jump to out block.

Compile tested only

 fs/btrfs/extent-tree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a5966324607d..be031be3dfe5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3455,6 +3455,13 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 
 	bg = btrfs_lookup_block_group(fs_info, buf->start);
 
+	if (WARN_ON(!bg)) {
+	    btrfs_abort_transaction(trans, -ENOENT);
+	    btrfs_err(fs_info, "block group not found for extent buffer %llu generation %llu root %llu transaction %llu",
+				buf->start, btrfs_header_generation(buf), root_id,
+				trans->transid);
+	    return -ENOENT;
+	}
 	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
 		pin_down_extent(trans, bg, buf->start, buf->len, 1);
 		btrfs_put_block_group(bg);
-- 
2.46.1


