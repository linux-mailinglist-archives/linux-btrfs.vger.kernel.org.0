Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF107AF23D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbjIZSDr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbjIZSDp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:03:45 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AD219F
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:38 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-65b051a28b3so31676796d6.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695751417; x=1696356217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMVZOqD5qMhAARWUPM9bumwM6QRjAQ+JBEENF8lhuIs=;
        b=eBx6fdTxUa1Q+Vmi6yML2Ohg7PDzxfwCO8K689z0nsYBP2GFUMO3qLGJVHjLphW0ro
         pL7tKN+E+7bN25kXHNNcTdQiK6VVgZQkWArkoxtzZZzi2pO9+6r2tcnRoPHm5gDP+TmU
         QxKTjx0b5IGf7ReeXG+k6eZrmxkFVptBMcmM4A3H26Q+eN2gpQirJqEOuPcMAnHokJpI
         W5R0NoTRY33wlHWbdFfGpLZNkRLeaUgy4ZmulJ7TzBWQQV8sEf+icoFrPmxgZNvRTpdL
         vx89+8BlQkkdyVCRerwkD8/kM9wh/CPPHL5xP0m0OazwZa3dQePrF2oYGfAb9rSzH1Qj
         QHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751417; x=1696356217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMVZOqD5qMhAARWUPM9bumwM6QRjAQ+JBEENF8lhuIs=;
        b=X2Jw0ZmiqTFzWJgjwPbdc1LBBueiepLxmfs3UNdfzrdMVlM1DSvp5k2/sIShnyquvQ
         4B/fm0F/dL4BgAtPGynCbbybbKn6HthxfohZFhfQFea+DpNt8UwfptWZhXqGQmDbcki9
         lkdVksIwgo9z9s1jim0F1bs/dlyBT55JUjp2DIcjPBagpb2IyH0aI+FEYUFxcatxTGYh
         IiuUy9nduAMBqCjwNdOBvw7LyXLK8C3Yddad+FrEpE52K9/HRg8b6Kknq7GOJy0VN9Zw
         meWzf9Tcx6pnD1jfrgdNxmHv4KsZMpxzJphX4ERZMOitHXdbBa+G5VeJtPIUKEoyiK57
         c7BQ==
X-Gm-Message-State: AOJu0Yw9lT5aIgsBna4fPMulDc7uJNIoEtkhHU6wcraEtlNmgmM3J6IS
        B19PYWdnS9G+GTAsAFy7izGUHTNkqo3ZpuBQoG9x9Q==
X-Google-Smtp-Source: AGHT+IGkbl+aPJ9BFcngOs3WUasdj0u/1uUNnx3vaBJ9ZrmuA25de+95BHcI3QUOql1n+cL9d7ZTnQ==
X-Received: by 2002:a05:6214:5191:b0:656:de90:3135 with SMTP id kl17-20020a056214519100b00656de903135mr14335917qvb.7.1695751417304;
        Tue, 26 Sep 2023 11:03:37 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c2-20020a05620a134200b007743360b3fasm1872163qkl.34.2023.09.26.11.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:03:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
        ngompa13@gmail.com
Subject: [PATCH 21/35] btrfs: add fscrypt_info and encryption_type to ordered_extent
Date:   Tue, 26 Sep 2023 14:01:47 -0400
Message-ID: <47feb58788c2adb906a6df4c7994058a4e7d2d75.1695750478.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695750478.git.josef@toxicpanda.com>
References: <cover.1695750478.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to need these to update the file extent items once the
writes are complete.  Add them and add the pieces necessary to assign
them and free everything.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ordered-data.c | 2 ++
 fs/btrfs/ordered-data.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b133ea0bc459..d33a780d9893 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -182,6 +182,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	entry->bytes_left = num_bytes;
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
+	entry->encryption_type = BTRFS_ENCRYPTION_NONE;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
 	entry->flags = flags;
@@ -568,6 +569,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 			list_del(&sum->list);
 			kvfree(sum);
 		}
+		fscrypt_put_extent_info(entry->fscrypt_info);
 		kmem_cache_free(btrfs_ordered_extent_cache, entry);
 	}
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 1c51ac57e5df..607814876f1f 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -122,6 +122,9 @@ struct btrfs_ordered_extent {
 	/* compression algorithm */
 	int compress_type;
 
+	/* encryption mode */
+	int encryption_type;
+
 	/* Qgroup reserved space */
 	int qgroup_rsv;
 
@@ -131,6 +134,9 @@ struct btrfs_ordered_extent {
 	/* the inode we belong to */
 	struct inode *inode;
 
+	/* the fscrypt_info for this extent, if necessary */
+	struct fscrypt_extent_info *fscrypt_info;
+
 	/* list of checksums for insertion when the extent io is done */
 	struct list_head list;
 
-- 
2.41.0

