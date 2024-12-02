Return-Path: <linux-btrfs+bounces-9996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC119DFA44
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 06:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD84B21B2A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 05:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02E11E231E;
	Mon,  2 Dec 2024 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KNugAj4k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7D800
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118552; cv=none; b=n5lL6o0Id4mIELW6sM9hdm38+6NmTIRXNWicEbuW6gB7pICUCEwHy22YO3PTfImQ+znK16fOvIOXMWHr9esHrkyFM1Y01bNiDaobOTOT2f7R9nJ7QHH+NrvQ0YfF/vMwcFHKEuq9EgKF+eV4wkmzQK0utxLavUlku73m2tR5rYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118552; c=relaxed/simple;
	bh=nbAI/J9PdAINoM43BGkg9CyhvXwNR7KoXQgwUc3lHo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XozhoH+F4sqTAaCbFLNvtaAi3h4LL73yGyXAkIkF0ysdUB4yffSASZN5CXO0C6UGYJvF40N8o1Br6prOQUJvc554SK8IgfMR73StkPTO315w8HOKD9ictCSoTfHwvEq/dEd/3dM+AyF9dfVSZLCNQk5/AahKva3tZHsOAbFLbyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KNugAj4k; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733118551; x=1764654551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nbAI/J9PdAINoM43BGkg9CyhvXwNR7KoXQgwUc3lHo8=;
  b=KNugAj4k9lh3Aa05SD6jVfh8iK4/N9TfgOUcEWfQ4jSc16FmJvd7V+2Z
   hV+AYGua5SkecKakqvQh7Suaizr9BE/EbuV2YWoUIB1vu7ImjwMm+dUUX
   +tLHwbdSMO7yzGT15deYCQX0lcKSydywdnF8Py+p0aa+8pIyoCaqmwl8L
   PYrDkgckZf3L73fJquT3giwsQpB7mRBWjRJyA9PpJhYvYXDktzikmNmtu
   5CMlD12Ehq6XUOjMDLzmkouAfslEEvR49lDAW6hwzqQHnkH+ATK81aHta
   7af4ug3lSy6zwZdKRqMpo3rXUr9rH/G65x0p+9G2CY0SDeYe4W0hQtUaL
   g==;
X-CSE-ConnectionGUID: eP5MHbZxTxSPgTZp9GbAmg==
X-CSE-MsgGUID: x0u2CGGSS/Kf5+RE/OWJqA==
X-IronPort-AV: E=Sophos;i="6.12,201,1728921600"; 
   d="scan'208";a="32688609"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2024 13:49:03 +0800
IronPort-SDR: 674d3cf9_YR59Xgp/mchy97QIO4JpgESMGupD1Aj3kl5th08oQVhjkJL
 tf+FT9vr8iIO50W55ArQEC0sDVtL+U+6s7tqGKg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Dec 2024 20:52:09 -0800
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2024 21:49:03 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3] btrfs: don't BUG_ON() in btrfs_drop_extents()
Date: Sun,  1 Dec 2024 21:48:53 -0800
Message-ID: <970a8c4f8a0593de2a8498ceaddc2b00ee2d352f.1733118459.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs_drop_extents() calls BUG_ON() in case the counter of to be deleted
extents is greater than 0. But all of these code paths can handle errors,
so there's no need to crash the kernel. Instead WARN() that the condition
has been met and gracefully bail out.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes to v2:
- Dump leaf when hitting the WARN (Qu)

Link to v2:
- https://lore.kernel.org/linux-btrfs/be18a9fcfa768add6a23e3dee5dfcce55b0814f5.1732812639.git.jth@kernel.org

Changes to v1:
- Fix spelling error in commit message
- Change ASSERT() to WARN_ON()
- Take care of the other BUG_ON() cases as well

Link to v1:
- https://lore.kernel.org/linux-btrfs/20241128093428.21485-1-jth@kernel.org
---
 fs/btrfs/file.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fbb753300071..b3bfd7425efc 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -36,6 +36,7 @@
 #include "ioctl.h"
 #include "file.h"
 #include "super.h"
+#include "print-tree.h"
 
 /*
  * Helper to fault in page and copy.  This should go away and be replaced with
@@ -245,7 +246,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 next_slot:
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
-			BUG_ON(del_nr > 0);
+			if (WARN_ON(del_nr > 0)) {
+				btrfs_print_leaf(leaf);
+				ret = -EINVAL;
+				break;
+			}
 			ret = btrfs_next_leaf(root, path);
 			if (ret < 0)
 				break;
@@ -321,7 +326,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		 *  | -------- extent -------- |
 		 */
 		if (args->start > key.offset && args->end < extent_end) {
-			BUG_ON(del_nr > 0);
+			if (WARN_ON(del_nr > 0)) {
+				btrfs_print_leaf(leaf);
+				ret = -EINVAL;
+				break;
+			}
 			if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 				ret = -EOPNOTSUPP;
 				break;
@@ -409,7 +418,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		 *  | -------- extent -------- |
 		 */
 		if (args->start > key.offset && args->end >= extent_end) {
-			BUG_ON(del_nr > 0);
+			if (WARN_ON(del_nr > 0)) {
+				btrfs_print_leaf(leaf);
+				ret = -EINVAL;
+				break;
+			}
 			if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 				ret = -EOPNOTSUPP;
 				break;
@@ -437,7 +450,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 				del_slot = path->slots[0];
 				del_nr = 1;
 			} else {
-				BUG_ON(del_slot + del_nr != path->slots[0]);
+				if (WARN_ON(del_slot + del_nr != path->slots[0])) {
+					btrfs_print_leaf(leaf);
+					ret = -EINVAL;
+					break;
+				}
 				del_nr++;
 			}
 
-- 
2.47.0


