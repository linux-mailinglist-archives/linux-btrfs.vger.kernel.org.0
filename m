Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1016B849
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgBYD5N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:13 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34231 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgBYD5N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603033; x=1614139033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RNXg1axbqdLZuo9+0jRwDCry1grvNkhf/pZs0xTqJv8=;
  b=pUeFBJG8nudcTAUqKiHq6nlIasE5UFJdKs986c2cZDaoVwgB8NpoyPmU
   Rd+7UoU656EQeZ7q3cuJit49a/xgri87LZbJ1Ug5Sc8yCLAl6M0hVA/Oh
   XIvHzWmAHhSpymHhh8A6VB+DBy3ijWZwNToJeL8kIdGdV3rfbUK1ufHJ0
   JxWr9Nfyo2bN/rhy5vZVPQ4vycmTOKBX1KE1YJ12/mjxhlDnzp89d5Ob5
   0XiKU1eyYlVCuWDN4fF4A+R3uTMyXzbF4M0si3TvGO/8WKAFF6JMbJ7cf
   Tp2qVk7DJSrIXZnO2ptve49yckWLJj2fV8oRKR5MJ6kPnIbvQT0ikm6KR
   w==;
IronPort-SDR: avIlmCml6DXzwccXDtozplQU5wIAD05vMw19zopgzEdCRXXV/RwIYc/Egckl2fiaehHrkUUvoF
 9h4H/bpTlLa5/M2FEyWyxqSJ/f4KEgMXeD5P581NX1X/Kh3jz9MTBWwC0Ec/aWYU45IEschnDc
 UNhY3UxIHImgvRmXSKY4FiErCSq5DJ0XALHtuSwIT/9WGjRmy83QQQVoVkRCOK9oEayLdacbcp
 77D4GgksbmQYiIoNKEgFz1d0nNeZiobzv5vHZMZFbKeJRS3w+wYKm0+1NqGakRMbZ2Rdk9XxI9
 ZlU=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168293"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:11 +0800
IronPort-SDR: QRxniGvbs0Hg7KSBbBZQ2DDui3Oei0n+ZXOZxTVac3eT1LcZgO9mnJvbzKspKAUlVHsCtrmnzO
 20Vv2IUUEyXmf6Ujqxo4LwwLVGsxEBLpr1O7ohdJL7tB0WqIkh9N8YrnjziyqeRTO1Z5KiarWm
 YjZd6402xQuXElViAp4KflHr+Y/hbYXGgJAgth47J5cDIru9AnRH78RV2e0Kj1rmhjKByT25gn
 oe6TDUjst2WLXBYbnNN0q0Nuk7Wv9zYhrDHV/4qmjjlIqLbd/u+pvzCQdxU5Hlgzh3iyNeAhQI
 dLxUTc+EyK9uanlrYQq1D/Fl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:39 -0800
IronPort-SDR: tpN2SGHEYZp+Vqjk8jksaptYYmMio6Uh/8USKAmtDf9Sc8iq1qVzLZFa3hhPuUPPlDXL5d2C6S
 0ko/babL13s2UTzjpBLpy5NZw3l0p1rAtth85+4hkzoN6qqE4xJAaLi3hyYxe5/j/crW3paUBk
 iEhUUx7Z6BrgcOPT2NIDKMLXa6BqoNY/b0Rtu2AGoJuYsJ4+UDdKb1E/M3QcimkjFOuj3ty8AR
 MhwXb4jnOV2erFQEm31aZgXpJ53ogirZl/TQrsanWe49smjlJCi2IsZyVRWD7OTMw9+EgCE3MD
 Mhc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:10 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 12/21] btrfs: move hint_byte into find_free_extent_ctl
Date:   Tue, 25 Feb 2020 12:56:17 +0900
Message-Id: <20200225035626.1049501-13-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This commit moves hint_byte into find_free_extent_ctl, so that we can
modify the hint_byte in the other functions. This will help us split
find_free_extent further. This commit also renames the function argument
"hint_byte" to "hint_byte_orig" to avoid misuse.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index edc72e768119..93f07988d480 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3494,6 +3494,9 @@ struct find_free_extent_ctl {
 	/* Found result */
 	u64 found_offset;
 
+	/* Hint byte to start looking for an empty space */
+	u64 hint_byte;
+
 	/* Allocation policy */
 	enum btrfs_extent_allocation_policy policy;
 };
@@ -3808,7 +3811,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
  */
 static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 				u64 ram_bytes, u64 num_bytes, u64 empty_size,
-				u64 hint_byte, struct btrfs_key *ins,
+				u64 hint_byte_orig, struct btrfs_key *ins,
 				u64 flags, int delalloc)
 {
 	int ret = 0;
@@ -3833,6 +3836,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	ffe_ctl.have_caching_bg = false;
 	ffe_ctl.orig_have_caching_bg = false;
 	ffe_ctl.found_offset = 0;
+	ffe_ctl.hint_byte = hint_byte_orig;
 	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
@@ -3875,14 +3879,14 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	if (last_ptr) {
 		spin_lock(&last_ptr->lock);
 		if (last_ptr->block_group)
-			hint_byte = last_ptr->window_start;
+			ffe_ctl.hint_byte = last_ptr->window_start;
 		if (last_ptr->fragmented) {
 			/*
 			 * We still set window_start so we can keep track of the
 			 * last place we found an allocation to try and save
 			 * some time.
 			 */
-			hint_byte = last_ptr->window_start;
+			ffe_ctl.hint_byte = last_ptr->window_start;
 			use_cluster = false;
 		}
 		spin_unlock(&last_ptr->lock);
@@ -3890,8 +3894,8 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 
 	ffe_ctl.search_start = max(ffe_ctl.search_start,
 				   first_logical_byte(fs_info, 0));
-	ffe_ctl.search_start = max(ffe_ctl.search_start, hint_byte);
-	if (ffe_ctl.search_start == hint_byte) {
+	ffe_ctl.search_start = max(ffe_ctl.search_start, ffe_ctl.hint_byte);
+	if (ffe_ctl.search_start == ffe_ctl.hint_byte) {
 		block_group = btrfs_lookup_block_group(fs_info,
 						       ffe_ctl.search_start);
 		/*
-- 
2.25.1

