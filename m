Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93507C41A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjJJUly (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjJJUlc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:41:32 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3082EC6
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:30 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59f6492b415so2463947b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696970489; x=1697575289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ArA+KNwLCyPHyCWg2jFGlY7QnT4oxTkF7KGMAsgrns=;
        b=o2WL9M6vvqd7ihKlp6i8le3L2CKa/M/xEZz9f+WL0MXJwELDCjxT8tYS0Zv/tPZN1Z
         suvZL6ouyf0CJ1o77TNYilL0e5ZYEQr5JL4lIP6x/mggNmSh8frRqzWH5aXViLEP6uNr
         zSLNrHA9OWRyrTIvpbA31jAqJvtU33GvB5t07XBzahE0Pw0L3+VU7Cr8mBeaANopdqbo
         X2+6Ek4VHZhaPyzM6cO9f0BHWTwYXTBkOiKiFyBQ50Kb2sAhcQKhT4VamC1Jb8n6uxEr
         6P4qPDDNdc7pCO3haJIDqaDdPKCiG0bcsuEVkKTXTAMMv7lViKC3hq1X2jgaUJU21jOw
         GQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970489; x=1697575289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ArA+KNwLCyPHyCWg2jFGlY7QnT4oxTkF7KGMAsgrns=;
        b=P1yyOzk+aWOWHx2JXrzxutwc8+NqFa5OMe08MMLT33c7M2TSPE01zijHc/SYAk7I1x
         MriUzszh5b8uczcbVjKwK4/2oo/9dDZRKuQ0cf1g2qGwViK/ZxqhEcyNz8So6/MCdaG0
         1dyaUd+IXhPnbsSYZdYFNGlc71NsrBgeAiXDHwL1P1D2rsBNY9WRIeM0mdkZyCaKQUm/
         Becojxs/R4T2FRV9hxb5Y+Pxz+9V6g9Srp0b95ynKYSrbr7kHBkp+9bXTaWfbLGDvatq
         De8YbrgBSp4Hvj0IQFFt3MsZ7qnE0LwrhJr+c8m5sGYqyuC6sgRqZmMI4yvVGDPVKNKj
         l9kQ==
X-Gm-Message-State: AOJu0Yy/uCmFq2GpbdKt1OYcYDAmWyD+6s4JXUhgtYE/WqBfIUzQqWsj
        dmUK964raaWtBVcWmYknAJGcdg==
X-Google-Smtp-Source: AGHT+IGUwHW7MYnoeP/dUvp25r3xI4PmEhHYpQU8QAPvDlaswQa2zIfybQy44nS3z71zlssTqD9QZQ==
X-Received: by 2002:a0d:d6d6:0:b0:5a7:bfc6:96aa with SMTP id y205-20020a0dd6d6000000b005a7bfc696aamr2241530ywd.7.1696970489302;
        Tue, 10 Oct 2023 13:41:29 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w1-20020a81a201000000b005837633d9cbsm4555416ywg.64.2023.10.10.13.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:41:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-fscrypt@vger.kernel.org, ebiggers@kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 22/36] btrfs: add fscrypt_info and encryption_type to ordered_extent
Date:   Tue, 10 Oct 2023 16:40:37 -0400
Message-ID: <4e70e172d8acb37626497837f5105eaa0ef94b9c.1696970227.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696970227.git.josef@toxicpanda.com>
References: <cover.1696970227.git.josef@toxicpanda.com>
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
index 574e8a55e24a..27350dd50828 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -181,6 +181,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	entry->bytes_left = num_bytes;
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
+	entry->encryption_type = BTRFS_ENCRYPTION_NONE;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
 	entry->flags = flags;
@@ -564,6 +565,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 			list_del(&sum->list);
 			kvfree(sum);
 		}
+		fscrypt_put_extent_info(entry->fscrypt_info);
 		kmem_cache_free(btrfs_ordered_extent_cache, entry);
 	}
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 567a6d3d4712..cc422bdb5363 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -115,6 +115,9 @@ struct btrfs_ordered_extent {
 	/* compression algorithm */
 	int compress_type;
 
+	/* encryption mode */
+	int encryption_type;
+
 	/* Qgroup reserved space */
 	int qgroup_rsv;
 
@@ -124,6 +127,9 @@ struct btrfs_ordered_extent {
 	/* the inode we belong to */
 	struct inode *inode;
 
+	/* the fscrypt_info for this extent, if necessary */
+	struct fscrypt_extent_info *fscrypt_info;
+
 	/* list of checksums for insertion when the extent io is done */
 	struct list_head list;
 
-- 
2.41.0

