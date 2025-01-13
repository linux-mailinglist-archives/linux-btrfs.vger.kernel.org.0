Return-Path: <linux-btrfs+bounces-10945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8BEA0C17F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EDB1889348
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827471D5ABA;
	Mon, 13 Jan 2025 19:32:00 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB11CEEA0;
	Mon, 13 Jan 2025 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796719; cv=none; b=Y19FHbTyUGiYV5/s/Z2Gz/1FHOP9wo95AQ7bkDJTPIBaBuRCeRY+4OzHiG1YDm/8qP+x4foaPDOwLP6KiTrG0o34LzcsQYqrepM6l/uP6AE5XjkVJIdpio1Kv6VQm4k+ZS1LM5icZPj++6PguHGQz3qtmBzEoTtNbAqVvL5N75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796719; c=relaxed/simple;
	bh=TPpzFBz1Tfok3H7Juh1nfS2qBg6gCG/rB+9bQp42q6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H1cJdjSAO1gBrt3dFuC7POXF6/CS2KvkqeOx2QfQiv1tD2DAWNHcHteZGGSMYXXWC9lRcE4HLwd1sxrF970M2rGjIsFJ3MX6jndUNs9BZr903Hwn5ZJhHOhkV/XZCWWd34k6kuFuAOcyMPd9l2YHDbYaPHLBScKS4pbdBPoH5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43623f0c574so33909085e9.2;
        Mon, 13 Jan 2025 11:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796716; x=1737401516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zCcosPCtrb/W/+0fS/Fgj8H05OM3LWN+IlkXQWO1tc=;
        b=ZsEaYpvmJzDNu7RVGunxsApSRPAsfCF5gQicBq3MxLzPrPfJRqg+ey4/A6BJsi8PK4
         OkPrdGvqu+5bpwTlBIjAo6hZbNHtGL1fSSjjEHRhHcBkTux8Ut21jemLFfSUTbfXlsmv
         GQnpcp+qFzt0ac4iAEqEZPtUlgvAeMGX8dYE5S2S4b3o44CWsPKYNjBpmbYdRL+pucMk
         5GAcUoR/qG+YtPI6y7eG4NN59epZuhQej3UF0FUxkqMq+Mdnq63q3O0jRLNk9JbNNbrd
         9xlCL5ZTgwsbkXZn0faOj85RTM21J5t8soBAnttCoOq0ji70RmJ1NMMSL0BBRB5CsmTs
         vDaA==
X-Forwarded-Encrypted: i=1; AJvYcCUtpq1HyxKR3ujAZZh7QZHO5o2AOSmsjg2b+jlxmc1IT6Srdl6me5b//x1nJSHG2J7yJ+GNhhEZ6weO9lyn@vger.kernel.org, AJvYcCVKO2IERjHInl6bCvSwCCl2w3uGEmxuiXJfkdjTvaOPq1n0kA/WoNc+QgUx8CtI6JqpCUMYvNttsksn9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBr40FsQP9icBAwPhByRHmebv8Dh7WQl02s8BUh+3fMHhgFY9b
	wNSW5ZqrnIt011TxvqWhQiPUHnqSMa9to/9XDIEy153BKyDxD19r
X-Gm-Gg: ASbGnct6CEl0EgtZhKdrkBz4FsP8AdwgDvODbotRh/no3kVCWoSSZiFssal5NUTdCU2
	N7QLllrUSmKNfTRboS4v7FN/tW1YDaQO3yIzkMs9pAsvNknAb5UYwdmGQ4sforWGEVgkS3ry6ix
	5Om9I/no3WxB1/ckrsreJySkdAgLNVKFvvhqkWV9bnKTwvpzpyS4HpeNZAZzsd7+3FdjWHdBwYr
	0CvtYL5rXwS7G8ihOp4tZwAS5CacqH3KfN03ztutOKFtVqui5wvVVup+4jIAU+B5PN8JLL+1jUg
	07Y6j/9eJeK/1XjJUiZoZCTVouNNlCpsy5Wr
X-Google-Smtp-Source: AGHT+IEuYsViG5PnE5LnRc/Ka1JVYXGAuxhgF4sCSQRRovHgJHJvwJpz0tbH8YPPqP4dDQB2K2fOVQ==
X-Received: by 2002:a05:6000:1fa1:b0:385:ed20:3be2 with SMTP id ffacd0b85a97d-38a87355790mr22313544f8f.48.1736796715760;
        Mon, 13 Jan 2025 11:31:55 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:31:55 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:46 +0100
Subject: [PATCH v4 05/14] btrfs: fix tail delete of RAID stripe-extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-5-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=jth@kernel.org;
 h=from:subject:message-id; bh=yBjlqqgQ2kb+Va+7H2jeNcFMvs3zrjoSGy7Zp6K5xgU=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaS3ZqnmlGqveVa3e83vOQvV1tT5b7hwZ3VI9opby9Plv
 taaXPJM7ChlYRDjYpAVU2Q5Hmq7X8L0CPuUQ6/NYOawMoEMYeDiFICJvJdj+Ctt6BTqPNPjcWer
 qbrTiwfbLBZu0jpa5KHi+fCFw5brHMsY/ofpR1lO5tq6uav/1Pf5ke3SnMYqTBmqf17db9fc9Ss
 shhkA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Fix tail delete of RAID stripe-extents, if there is a range to be deleted
as well after the tail delete of the extent.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid-stripe-tree.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 9e559ad48810b704c997ff5e51222aced0b91637..ef76202c3a38460c5a36d7309ac0a616f73b0cc0 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -119,11 +119,18 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		 * length to the new size and then re-insert the item.
 		 */
 		if (found_start < start) {
-			u64 diff = start - found_start;
+			u64 diff_start = start - found_start;
 
 			btrfs_partially_delete_raid_extent(trans, path, &key,
-							   diff, 0);
-			break;
+							   diff_start, 0);
+
+			start += (key.offset - diff_start);
+			length -= (key.offset - diff_start);
+			if (length == 0)
+				break;
+
+			btrfs_release_path(path);
+			continue;
 		}
 
 		/*

-- 
2.43.0


