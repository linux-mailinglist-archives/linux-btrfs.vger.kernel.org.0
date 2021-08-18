Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CCF3F08B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 18:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhHRQJA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 12:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhHRQI7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 12:08:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF0C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 09:08:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j187so2603482pfg.4
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B39Za2CjTb6zjvfvzQzZz545GyknWuTLhPFthVHAows=;
        b=S4VSha5nq6gB3VkdVj9NdMiQJ09KoF0UR6Zt1OVczi61I318dQxhxQK6JZGp0nWi8K
         9DQr/IhflVW1bwXLHGtZdpEChZGATX7ywvxNSjplDejlQHBEIeQJmrBPTZcMGgxK/0ug
         HbcJoYnlCVhcoxPt9vsGGVhbdTqnC1n9cAlnSMacYfS4mPxky3EHCiOd/aJFXbq/cDvc
         uy1uilsILqUfBfAs8hKzU2mbjAuRz+ugG85ziSNDFuBQR7YHGOZfJR5oV3VwK5W0WPJf
         mvKjPytWi/bICOJMcBpS5PlwiwmOj5vcsmyM0pLDWI5j9bFN7/FZRoVEPoPcEzqhAaWl
         ecuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B39Za2CjTb6zjvfvzQzZz545GyknWuTLhPFthVHAows=;
        b=eXQP0qR9oOLWL0w7U6ls8A+6pn8hCYvZ+u3D6G7M2DXniBv4Gt9cvNAVfe1zalorbS
         +CVXooUUb8OHmH1FYeD11vJgpu31uvO26iXX1EUpIZVVUjDABhcxJPpCITSzhcLKbEHV
         q+6I2ni+ws7iHy6Y3vOU4Eo2PB87aajJ1eiA+BQS7JjeM9baNGADRmKBa2cUUQnmQGm2
         jBR58ZNbHHTzm/Ze0L2gqGp1iEKGHdSRQOvXH6r1c57IfdAWQM2/NU5CCpNGBgp1BmSw
         XmP//IPiIsIh6ZTSkwKPF7gq0t0zf/vWxsCR+F3JuXQAXVanV118b8gmsS37GaOptTE/
         HmvQ==
X-Gm-Message-State: AOAM530JyydN5ZlaYxRkMXeSbwCPlU4GdPH5Dg71GYyu9F2UMZhgF8sJ
        FRfddcCF8Kd+AuNYKiGnLIHY8okrklZymQ==
X-Google-Smtp-Source: ABdhPJwXYY04duiMhfz6DJnC2sKGXnfSje+35L6E3ulaF4m8YO4/wIdxYbirhf7d8nYEIDnoVEgQLQ==
X-Received: by 2002:a65:67c6:: with SMTP id b6mr9491170pgs.332.1629302904082;
        Wed, 18 Aug 2021 09:08:24 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id j2sm166772pfe.201.2021.08.18.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:08:23 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs: reflink: Assure length != 0 in btrfs_extent_same()
Date:   Wed, 18 Aug 2021 16:08:15 +0000
Message-Id: <20210818160815.1820-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_extent_same() cannot be called with zero length. Because when
length is zero, it would be filtered by condition in
btrfs_remap_file_range(). But if this function is used in other case in
future, it can make ret as uninitialized.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 fs/btrfs/reflink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 9b0814318e72..69eb50f2f0b4 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -653,6 +653,7 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
 	u64 i, tail_len, chunk_count;
 	struct btrfs_root *root_dst = BTRFS_I(dst)->root;
 
+	ASSERT(olen);
 	spin_lock(&root_dst->root_item_lock);
 	if (root_dst->send_in_progress) {
 		btrfs_warn_rl(root_dst->fs_info,
-- 
2.25.1

