Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5305D6745A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 23:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjASWOV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 17:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjASWNp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 17:13:45 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD54D9B12A
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:32 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d16so2725603qtw.8
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXIbIDcurwlxm0mOrA0RAfX0zhSSMBXnUrjrgo+hop8=;
        b=N4un+rqVye3XT13G8KC5RwiaM6+8ZiZ5NFzwWP+jZgQ43Y96JHm5YMIhHuQqtw5ap5
         /O7UdyDkAXZKBAKCqIyt3YtrMjEJD3YaZLnjbzMsat1mfEsQVxwHk5y1wNUB39JT4CwJ
         HmE7FWkkSxq8Pbl/tF6ALzc/9tCr/+xVXO9+axQtPkoSy3MkjOxsMJw8rKXuY6jgZfbC
         u0nDJR+tWf+MZ6heXK8pTlJWVzh1gHOtvWL/eclxqGfpgfEoVfpC9tm802VTf3fNlrij
         2Zr3liee/geN6Lt6UcSCXlFofRK7LwOGuRd+h+RWWvoNDWZ9j9MNxlRhiA1JTSdh6adx
         WhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXIbIDcurwlxm0mOrA0RAfX0zhSSMBXnUrjrgo+hop8=;
        b=Hd5W4fdC6eBU02VZZ4C0jaB2oZhToNJ7+b/9bssbC+iUHyoSHM1zwJCCZZHTQGKPgH
         TFzqibfX0t280AwqIYacaW4KoxdCPKT+/gBUom8WUZzqxqqOmX6FONEV4J+etuBmJSHK
         kpJZXSSPBP+mjo5SUQcdTxCZkxJIZEQHLCwXPreMk0QN+vyPf4V06HGHYksfZexyYxil
         FIFVFIm5LINC3jwMjjX6o7RmqATMaIgkC+smUhiA7JpBEkSq86oHPVNk5lN5lJsVURBI
         Q/KBtwRUgEZOG9J3ZWovCOmBkcUb3+d15u+YA6MW2cE8Uxc0eU7NHawU7vYo8JI8hxqU
         9w/g==
X-Gm-Message-State: AFqh2kr57H2cwR2qbfcnOH0VC5NivmeXfIm6F+Jfm7cGAYcSWcp/M2Iw
        Mhf5Ae7nUqdNxn9CyVfv6fCamgCZVHzbg9gzstA=
X-Google-Smtp-Source: AMrXdXu36i0IlZ3cXETZRr80jYV9YeNZCLsi5GqGDCKqTJ5v3CDlpWk6z9LVGKcSM59Mz4jNExVJzA==
X-Received: by 2002:a05:622a:514a:b0:3b6:3f4a:8154 with SMTP id ew10-20020a05622a514a00b003b63f4a8154mr18117958qtb.65.1674165211214;
        Thu, 19 Jan 2023 13:53:31 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id w25-20020ac86b19000000b003b63c08a888sm4685032qts.4.2023.01.19.13.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:53:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 3/9] btrfs: do not check header generation in btrfs_clean_tree_block
Date:   Thu, 19 Jan 2023 16:53:19 -0500
Message-Id: <a2301b576ce057a0f9553c107d469a8ed61ba37e.1674164991.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674164991.git.josef@toxicpanda.com>
References: <cover.1674164991.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This check is from an era where we didn't have a per-extent buffer dirty
flag, we just messed with the page bits.  All the places we call this
function are when we have a transaction open, so just skip this check
and rely on the dirty flag.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d0ed52cab304..267163e546a5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -968,16 +968,13 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 void btrfs_clean_tree_block(struct extent_buffer *buf)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
-	if (btrfs_header_generation(buf) ==
-	    fs_info->running_transaction->transid) {
-		btrfs_assert_tree_write_locked(buf);
+	btrfs_assert_tree_write_locked(buf);
 
-		if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
-			percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
-						 -buf->len,
-						 fs_info->dirty_metadata_batch);
-			clear_extent_buffer_dirty(buf);
-		}
+	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
+		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
+					 -buf->len,
+					 fs_info->dirty_metadata_batch);
+		clear_extent_buffer_dirty(buf);
 	}
 }
 
-- 
2.26.3

