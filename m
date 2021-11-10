Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E644CA5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhKJUR7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbhKJUR6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:58 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CE0C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:10 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id v4so3269043qtw.8
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KNkMciKNt/whslgMekzPaIvfMEwa+U3L0W4rFrYFXc4=;
        b=MmxxJ9Yvtv5siczmPo7zYv1EBdtA6GdWvPV0CPgCeEsNjvJ6vtVC3yZs7iCwpcxXpF
         qskNMZWn7tGoVAfwT5CPmXkzqdzabVKHWV1/Fv6uLQ4mXpHANpFD891tQoAskaA2V7Dw
         BQN3UVHgcFWlaoAE6/tG34JjrBm3GgWSb/qXxJt/3n4JB5Id8VmVeQZTWQCHXsNKrvLi
         5X1PBUllT9OIih6elwrjUhep/RufxevHSEjbb9ACfBDUnppt2pt/YtHrhrFHnEwRp1Wk
         0aHoa45UQ621WHwPyE6HCQqSV/egrhVG10TZDhgDLwJ3axhxKwTWeAZXCOeWDYuzr0TH
         CxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNkMciKNt/whslgMekzPaIvfMEwa+U3L0W4rFrYFXc4=;
        b=2v3UeLBte+zZpT52NwbmMd5LbBd5AYmyNYqOhlqLk4zTyOUzMLT+HvF4USTO6qRXGS
         aROlsGZ4kVG2S662Xm+a+C+Vpmuza4Cc8iabKIWwtOpLjS6nTTUUSIxyx40lvZU4C3y/
         ZI2Cz+Yj9yA6/xBQIh54K62BeHthCcafa0WbMPB/81VOSc7y32tkAkRgZji4llsnAdkO
         J/Q8r6npquQAz2r8XvTOiKLrLnofRkgRR1sR1xZGlx2TvoYqpjd5GMABhapVIUTgfho3
         PbKbCzdsJBdLgHuNoVk9FsBj+xDLmFytBfh24u8ppFbjouVvsV8Ea1UPCcGyvBXWfBN4
         BPCQ==
X-Gm-Message-State: AOAM530VrYI0Toi9gTWEdK1jz6EO0zmoLYhTYBZ9tFk9hq/6iZ/FTUQK
        3HAuRqAg9a2OGNdzH6q6lNQMJBu3Vg9XDA==
X-Google-Smtp-Source: ABdhPJyJQn7WVL1SDnItdaYOFjz5GdqkCq+tXO2SdzbCp6TVErp7QhqwNRB8TwMujB/u88yddkHZ+Q==
X-Received: by 2002:ac8:5c13:: with SMTP id i19mr1873579qti.282.1636575309102;
        Wed, 10 Nov 2021 12:15:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s8sm488791qkp.17.2021.11.10.12.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 15/30] btrfs-progs: check-lowmem: use the btrfs_block_group_root helper
Date:   Wed, 10 Nov 2021 15:14:27 -0500
Message-Id: <bc42616990fea95fcf408441bd66a8c0054bb87a.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we're messing with block group items use the
btrfs_block_group_root() helper to get the correct root to search, and
this will do the right thing based on the file system flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-lowmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index cc6773cd..263b56d1 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -266,7 +266,7 @@ static int modify_block_group_cache(struct btrfs_block_group *block_group, int c
  */
 static int modify_block_groups_cache(u64 flags, int cache)
 {
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_key key;
 	struct btrfs_path path;
 	struct btrfs_block_group *bg_cache;
@@ -331,7 +331,7 @@ static int clear_block_groups_full(u64 flags)
 static int create_chunk_and_block_group(u64 flags, u64 *start, u64 *nbytes)
 {
 	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	int ret;
 
 	if ((flags & BTRFS_BLOCK_GROUP_TYPE_MASK) == 0)
@@ -419,7 +419,7 @@ static int is_chunk_almost_full(u64 start)
 {
 	struct btrfs_path path;
 	struct btrfs_key key;
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_block_group_item *bi;
 	struct btrfs_block_group_item bg_item;
 	struct extent_buffer *eb;
@@ -4591,7 +4591,7 @@ next:
 static int find_block_group_item(struct btrfs_path *path, u64 bytenr, u64 len,
 				 u64 type)
 {
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
 	int ret;
-- 
2.26.3

