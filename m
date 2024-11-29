Return-Path: <linux-btrfs+bounces-9967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 631F49DE704
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 14:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AF1163F23
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C675A19D8B7;
	Fri, 29 Nov 2024 13:11:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0CB156991
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885904; cv=none; b=FPC4QeYELcEpDJ0JLDvrZ7KQDcQ6w2El6UnBG8G3J9BQ9jgQGZDYY9/uV7Y4ZIcryrkKNKgWq0bZIz0e+zc5T4nw9KtULpd6kjSn8QOvL9ugofoByLd2BIGyhZWxse6P6N8lB7xZ6MgtEGQA05kgUswW2nWM+gR4CE0K9vnuZwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885904; c=relaxed/simple;
	bh=QUiPWBt0g+z97Sd6AuKbSA4VaGfMuTFvqFhGF+NN/hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEEn4TbMqQKzpBpxgnhMzzj9GpzFniccK22n+LKO/wbNnovw5KPZYtghmS2SDv7Ib0OvrzBUKSCytBOcE/hBR8fhBcTqmasbiMxyFS4RfBE72432y6n6Em8DjFImpO0lJ+n7HjmgEOlz/Ax4Q5+6mnQA7daYUjjD5h82mPUN7H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso13226685e9.2
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 05:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732885901; x=1733490701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvhIxdlSyuuvXaCCDjGlpzvBupmAGp//zqxK9iNXT1E=;
        b=fJhvKeRMnmsZhpub6zkmALtvLn1apsXbDYz4Jih3Wu8t50dPzrmhn54Kn0iccCcWpt
         H+xBQyA0Wa9FN2x65n7AaxJtkCbOGOA6xWF1Q827Lxq/uOFVL3eWUYAZJUIHFYCzSeWq
         vEn6XRMIcD5U1E2z/LSTaUILo4exbAHkj8IOIhKCe+7acENNNbw5d2fUkCVVYri+AapI
         W6PPVGTgHeRIJWWSwInpGZYfk02/6yEKSkUhkK4QUjw5pJ2qEX2LDk4hPIZ60pLijAVj
         vvLoCxXYO+DUYiIRtgRXz24fxjlBge2KcU7UY/nDL3/r8+K+OG7k0+v0XZltdscErJn6
         CAfA==
X-Gm-Message-State: AOJu0YxJi0jKgeIH+bDIJkmCzASb7cbVJKs4iny/5G43NA7LlU24yGcb
	6ewOBmdszIT1x1gBDp/ObQjSJdtqj/5VtN4a92smB5+WzLaTlHOITnpCyw==
X-Gm-Gg: ASbGncv60cUugqFu7SfaANODXfirJLUGSqrH8YgEFP2BruUmZWANqlmoN1kL008sI/p
	llxCz57GGJp/bYcTR0eEkk/kUKNoxa/5MG+DEDWHBXBlm3jd5WkF0LcC99wAbDt2fuJzmbZqg1k
	WUHLurO2xy2DpqzqnkVnLHWiYhzdMHi7HKMRffFbzD66LfA+kR2rd/CUAt6Rv9Uk/Do7CDbLKdX
	ptzz4gzudBIboqvwPZXBsWzEI5EGlQs1lnTP8zoAANj3zEc1y8FVDFKwHWXAyliKl17AVRt0G2s
	hvlzUlXXs6n3Dmxlron8xNS0Dzb37p5c
X-Google-Smtp-Source: AGHT+IFQa++MpN20ymYZ5gXMWROQm0+XQVqMPsHYHdKszJrSbmt8Kftx2Bu8qh2pAVCcIawP4WGHCQ==
X-Received: by 2002:a05:600c:1ca7:b0:434:a202:7a0d with SMTP id 5b1f17b1804b1-434a9de44b7mr94213285e9.22.1732885889035;
        Fri, 29 Nov 2024 05:11:29 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e17574ebsm100805f8f.30.2024.11.29.05.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 05:11:26 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: don't BUG_ON() in btrfs_drop_extents()
Date: Fri, 29 Nov 2024 14:11:17 +0100
Message-ID: <be18a9fcfa768add6a23e3dee5dfcce55b0814f5.1732812639.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

btrfs_drop_extents() calls BUG_ON() in case the counter of to be deleted
extents is greater than 0. But all of these code paths can handle errors,
so there's no need to crash the kernel. Instead WARN() that the condition
has been met and gracefully bail out.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes to v1:
- Fix spelling error in commit message
- Change ASSERT() to WARN_ON()
- Take care of the other BUG_ON() cases as well

Link to v1:
- https://lore.kernel.org/linux-btrfs/20241128093428.21485-1-jth@kernel.org
---
 fs/btrfs/file.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fbb753300071..f70ce6c65d12 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -245,7 +245,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 next_slot:
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
-			BUG_ON(del_nr > 0);
+			if (WARN_ON(del_nr > 0)) {
+				ret = -EINVAL;
+				break;
+			}
 			ret = btrfs_next_leaf(root, path);
 			if (ret < 0)
 				break;
@@ -321,7 +324,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		 *  | -------- extent -------- |
 		 */
 		if (args->start > key.offset && args->end < extent_end) {
-			BUG_ON(del_nr > 0);
+			if (WARN_ON(del_nr > 0)) {
+				ret = -EINVAL;
+				break;
+			}
 			if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 				ret = -EOPNOTSUPP;
 				break;
@@ -409,7 +415,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		 *  | -------- extent -------- |
 		 */
 		if (args->start > key.offset && args->end >= extent_end) {
-			BUG_ON(del_nr > 0);
+			if (WARN_ON(del_nr > 0)) {
+				ret = -EINVAL;
+				break;
+			}
 			if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 				ret = -EOPNOTSUPP;
 				break;
@@ -437,7 +446,10 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 				del_slot = path->slots[0];
 				del_nr = 1;
 			} else {
-				BUG_ON(del_slot + del_nr != path->slots[0]);
+				if (WARN_ON(del_slot + del_nr != path->slots[0])) {
+					ret = -EINVAL;
+					break;
+				}
 				del_nr++;
 			}
 
-- 
2.43.0


