Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9227CB263
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjJPSWi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbjJPSW3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:29 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E2510A
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:21 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41b2bf4e9edso50138721cf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480540; x=1698085340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ArA+KNwLCyPHyCWg2jFGlY7QnT4oxTkF7KGMAsgrns=;
        b=e3uuOMyw/6MBsvZZqgkYXLNhR0lsIoiSTt7dMTi1SRSiN8gi1higtMGnAxnbxXpj4Q
         6gj6byRwWafP4wb+pfyIupsvaOnrC+JyvqzjlDQz8WAUyYDLNpkHFzU000I9TGpV8F71
         7Iy/v/N2/lMzbzozfddqA9DoY3veg2x55uivUWiejm/YoH7AMlwNAYFpW50w3yLxgT4J
         NeoFlc8z/Zja8hi3dZrjtyIXEzOGN6jOW2nTqLeNzKn19XAshUohMKRPAQ49dOYAxcat
         etjyP5Xrnnug1p8AQILSjcGab/yvQn2HEDFE+SemHt5SVt/4D/iA0Hnf+7qDVEMeLEl2
         tVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480540; x=1698085340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ArA+KNwLCyPHyCWg2jFGlY7QnT4oxTkF7KGMAsgrns=;
        b=rkTEwAQ6gD3E1wtO0snvV3FA7DrDPQeWvTs/NaUFrQQbog8256sGCMDtmfaae6XylC
         MGLxh4ZhMia+ZweOdRgS/o2AyQ6XASuNDqIU7ndgakNR+yqhwsV8+ulUcohc8KNG2apI
         umUtDzZHT/2LUt8K0uSljzvnUFHAJJ1X//Wlxt6sEzdrbXzL4IEoA01xzzqW5rIKRvHg
         isxWD89V+BDvScoZwujMZb1Hu9C66YHMNVPbmgJDBbo9fYZ1iWOM1HIicxGqJv3MvzM8
         kCVj4MqR71xSbpj58BLEfopwaEZ+Nn5VHH+fmBxdxN0UqOrONXsBNQqGuE5VtZs/W3rc
         gr+A==
X-Gm-Message-State: AOJu0YwypVL2h4RYNhGJFUbii+5AsvVum3NAK6V1Neea1uLfsImc+33D
        C4FQVsi4FbXv4R17LQfO2edVkfAd5RuFDTY0dOdhrw==
X-Google-Smtp-Source: AGHT+IEEej2iGXZwGqfnbWu/PJgHfbretUxDe3LBgla3hSDT1XDmYh3MaldgZqaLEjYS9C1SsJwx7g==
X-Received: by 2002:ac8:7dc6:0:b0:410:20b8:967e with SMTP id c6-20020ac87dc6000000b0041020b8967emr385697qte.12.1697480540317;
        Mon, 16 Oct 2023 11:22:20 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j9-20020ac84409000000b004181b41e793sm3220060qtn.50.2023.10.16.11.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 20/34] btrfs: add fscrypt_info and encryption_type to ordered_extent
Date:   Mon, 16 Oct 2023 14:21:27 -0400
Message-ID: <4dd30c8e2ac6781e0d57fa1f0c88e4b77fac29cd.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

