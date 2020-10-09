Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF192889C1
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbgJIN2f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 09:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgJIN2f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 09:28:35 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A66C0613D2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 06:28:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b69so10504973qkg.8
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=y1tgzWpKlN+xmsSRXuylHGmouzEntA5WwkpLspxtsRA=;
        b=0jYN9AV3TQyyUrPxgCgbR4rKNSsDsXL7+0si0+5WBSUctTz3Vx/HeH154s/MGDTH87
         /xuIigcaj1HOkuPKKpF0l42ILCKWtT9oPV80GSR6idPnHoOj/vMu/U2C5SNRrSopQi0l
         neX4q9HQGXlQx4IkU4I72bi9zFf7RptSklmfPzk63dT8G9RsgJLYzYSuntQJVXdkPweC
         Oey4ryrRnBFg0Ma35obxZs2XzRPalj9Nr6ro3BjFPokeu8SOvaqxNF6hB1qdwWzD1REt
         87EypZzZgtpYnQ0tAoHC+pIK5R8p0mbZNAPwqRzxyBMebBniGD9e398XMUnmvQ0cyLqU
         Fy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1tgzWpKlN+xmsSRXuylHGmouzEntA5WwkpLspxtsRA=;
        b=G/y2vLGWvaofmGBirB+w6HJ8dOHzoU0Wdws5rLUXTHpoHeq2qnLNqmEZkKpXM/VkkM
         tamFaubuglHUIjIr2yH9NqwilwIYu934jm+7K05GQvK8/uM/c79Rc7rP9EzbDiI/mFhy
         3wlrE/w2KgIe5E7SzJE1MPrl8VMNHxYOqTYhTVZRFsHB0Ztw0d4WwlKQ2RgHE/Soo5Yj
         gs+i6W4k/rbqSCRQg5FcxJG3y/hsPWsA9hRIdLrUItufFiFXDFdD1AUiYKeQBQ2gH38g
         X+zW3pF/ox/qPBp20sh5wpPy/+N57QtSN2GHnLL2e6eU8AmRAgEQ6vVkIkDDBBqWLBBR
         aY3g==
X-Gm-Message-State: AOAM532IE/L7ic6nVSQ+bulOgC8OdPl/4y24G7jnqclFEhK0fCUB3Uc4
        Is2n4IEkSUHah2eehWiucUdqzvdQ5TMPX0+W
X-Google-Smtp-Source: ABdhPJwadgE3JJfnVkVi2o6qwFkbh+br4QrdwT7jTPc8JaRgd/f6doURPkGUh72oZaJ2KfeIa76FqA==
X-Received: by 2002:a05:620a:1322:: with SMTP id p2mr4487859qkj.211.1602250113595;
        Fri, 09 Oct 2020 06:28:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i62sm6301698qkf.36.2020.10.09.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 06:28:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 01/12] btrfs: make flush_space take a enum btrfs_flush_state instead of int
Date:   Fri,  9 Oct 2020 09:28:18 -0400
Message-Id: <397b21a29dfe5d3c8d5fec261c3246b07b93e42c.1602249928.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602249928.git.josef@toxicpanda.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I got a automated message from somebody who runs clang against our
kernels and it's because I used the wrong enum type for what I passed
into flush_space.  Change the argument to be explicitly the enum we're
expecting to make everything consistent.  Maybe eventually gcc will
catch errors like this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 64099565ab8f..ba2b72409d46 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -667,7 +667,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
  */
 static void flush_space(struct btrfs_fs_info *fs_info,
 		       struct btrfs_space_info *space_info, u64 num_bytes,
-		       int state)
+		       enum btrfs_flush_state state)
 {
 	struct btrfs_root *root = fs_info->extent_root;
 	struct btrfs_trans_handle *trans;
@@ -920,7 +920,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_space_info *space_info;
 	u64 to_reclaim;
-	int flush_state;
+	enum btrfs_flush_state flush_state;
 	int commit_cycles = 0;
 	u64 last_tickets_id;
 
-- 
2.26.2

