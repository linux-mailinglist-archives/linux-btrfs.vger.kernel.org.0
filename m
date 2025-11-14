Return-Path: <linux-btrfs+bounces-18987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ACFC5BC85
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 08:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E607B3469B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49452F530A;
	Fri, 14 Nov 2025 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvO4m8TG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD392F39CB
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763105231; cv=none; b=eilLL8MKSWr//hJP2WzDlsAco7qC4siAUnDsNLZotc0h2rb7IY86/vpDrZjPz2Cut2rZGNsrLsbo8e2JlbrUAyGsaDgCbB2BQXXoJPUggjwKymE391hKNcNvE4WuRSxVXVGNsvwhEM9jemz9/NjoeGKk5ca3NaBRzoHya9QQc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763105231; c=relaxed/simple;
	bh=o01ImnvyIDeF59kNEOI99cCENA+Ax3OUHsL6LpmWsgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjmuppvjjf7QHeXzjJ7vjrMYcYMMI9nRqOcxLbeFGBrFLHjucOfuJJIKMXo+Nyb7oINEiZSyfPfWDXvr3QoQgVkqyTYeJVBenzwMMGrJaD5q1VmZSj48cDecUFlzTgqIuoyWMFZRCKRnD8oHjkXFDoYbqr78AZmUCNV004HkdlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvO4m8TG; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7b827ff341cso119049b3a.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 23:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763105229; x=1763710029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACxswKVe14Veay1+azOVSFxq6LN6BpyZyNfeehp8ARE=;
        b=dvO4m8TG13z1jHsHu6zzhfvFcwqVZkjIngWX0ZFgyLNzsh/DDTbrg9lOPCTcslTDWQ
         6Dv9md8RgNIMONR9tMof7kdKt37NeSIQc4SU9Iuh8jl66STUGxq4sXS5LI0Bi/nrA+NL
         aIPGklBMovtkhhe9Qu8QsIRyskOEwglnTPjYew59uak1cOvWfTjCqFdkVfG0W3h9f1up
         OZeU32uD7ETccE7T5oZ4DRYQBnTbFoE3Vxsw7ElVSL0LnSyBhEXCTAekwjQ6+T0nJIDT
         ddYRK/drW1fOUH2GciCm+F7ta8UWkLxdBzL8p0+Yg81m/XHghw6EHxrCU5XWHbcgIeSX
         aYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763105229; x=1763710029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ACxswKVe14Veay1+azOVSFxq6LN6BpyZyNfeehp8ARE=;
        b=S1ndGmvEUQMgKJXTbbytniqupJ4Qb0HDEQj5nf0pvMGxp9T6+nz8IkktnqQy8EknQO
         f0pMb2tpRN5dWKNWPibOFwWkc/SlYxXZHCN6T6CvWYldxE7ziX08x/nnrRDe/SQpJXAg
         QjbJyfPv5f0fmW4rzbrcnS2QKpGfeXB7MAV1DOxbSBO4pi/cJF8WxY7hy3hhyFHJTJg2
         C7qtsGzntPuuGULPPfJ3AfLhpHv3Zl7lE62buzRjTxXC1iqquKWXlsbD56CFZ0ABBve8
         ag/4yLudECx+Kp9FwEMS8QKN2Nft6HjV2T4bRxBB1GcWHNWmi1aD6bgQSCiBPF9QuuB/
         QVlQ==
X-Gm-Message-State: AOJu0Yy+AaEDvdixwv+LlKRfKsP+S1YeErlFEFN++zJA69ENDPuPBE7e
	yzzlXfSr0PE6AA8xB5CpSJ9agKShp1lRU9w/AL9smK+BrSooZ4ppJCCpNWhFjyTLD7yPypjX
X-Gm-Gg: ASbGncv/C/6hV50an/VeLnJByUVH1MR7HxZYIHM5UnJb21xcjTqaEPZwN883agTr2Kk
	kk59EGLJymathys1VHUOHgOYrUX+fXL73esRVRHNqrqDXe4T28EKCNNYzJWCBytakkjZgls7Xl+
	HtjeF4OXuuTYCnmRV3/iugyI1z9VMuuBZ8wM5qiT+6THPjqIyVydhUI1RneWFr0uU2WFSog3ad6
	JnXUT8EEt13zsqBcpO5VKBqOa9Ot6ShQPlVZ11hjiRbQE6drwIU4AEAK+nO0jvPzhqxOuAtWA3h
	IKQ2PwaRVbA2zhKF98Hrq0b8HiSEBPVuNQ/mD8WvBdvNe/IULRIHJ1GnwKVXmgspwMbw5wDIDDR
	0Auq9fUm6mw9RFvCoPA5bV5QkoLIZaZ+HscA+fkJSUZjp1GLyNe7npomohL0Mj899MNcVTb3nvs
	JyaubgCfCt8uhcN72/8XsCZWUyUgKWHwLBF+RQn1twOqBnnnI=
X-Google-Smtp-Source: AGHT+IFjFfoZe1UDjHRx7+lj4fDuAb7iMGIckpl5SK/zvzjFdkWvDgBAIaoaec1JtXvHtxEV3HoAkA==
X-Received: by 2002:a05:6a20:3d82:b0:345:42cb:50b8 with SMTP id adf61e73a8af0-35bd9900346mr1301465637.8.1763105229059;
        Thu, 13 Nov 2025 23:27:09 -0800 (PST)
Received: from SaltyKitkat (160.16.142.119.v6.sakura.ne.jp. [2001:e42:102:1707:160:16:142:119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36f42eb0esm3947084a12.13.2025.11.13.23.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 23:27:08 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 2/4] btrfs: optimize balance_level() path reference handling
Date: Fri, 14 Nov 2025 15:24:46 +0800
Message-ID: <20251114072532.13205-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114072532.13205-1-sunk67188@gmail.com>
References: <20251114072532.13205-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of incrementing refcount on left node when it's referenced by path,
simply transfer ownership to path and set left to NULL. This eliminates:

- Unnecessary refcount increment/decrement operations
- Redundant conditional checks for left node cleanup

The path now consistently owns the left node reference when used.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 2369aa8ab455..a477839cf22c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1127,11 +1127,12 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	/* update the path */
 	if (left) {
 		if (btrfs_header_nritems(left) > orig_slot) {
-			refcount_inc(&left->refs);
 			/* left was locked after cow */
 			path->nodes[level] = left;
 			path->slots[level + 1] -= 1;
 			path->slots[level] = orig_slot;
+			/* left is now owned by path */
+			left = NULL;
 			if (mid) {
 				btrfs_tree_unlock(mid);
 				free_extent_buffer(mid);
@@ -1151,8 +1152,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		free_extent_buffer(right);
 	}
 	if (left) {
-		if (path->nodes[level] != left)
-			btrfs_tree_unlock(left);
+		btrfs_tree_unlock(left);
 		free_extent_buffer(left);
 	}
 	return ret;
-- 
2.51.0


