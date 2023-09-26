Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647AC7AF245
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbjIZSDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjIZSDb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:03:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99DA19E
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:24 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4180adafdc6so44463291cf.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695751404; x=1696356204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1X/0Zt7z+oOh2YdMAkIlfw4aC9CST8nDgU19CDUdTeo=;
        b=WLNpH+i55iMeC2wrjZcx7lyoHFaw+oHCxkqfbX3Ca9UW4rdeN962wVVj3rhkeO89Pi
         /xH/FH0YTUpXKU9xUP5n0/aV050hPwfs6fJRWidOxNVZUfEu5UTTuZsyfCo9JFEeUqDt
         TF1RgiCrYAM3BRGvyacTDCML33qDvRzPuCjsGfa6Or60IynKfQlC+khjkzMokg3lsIMP
         qWL5vydJV4TgJAoei3AX34fiW40cMd4GeBa+hxLLWkS6CedLoBMdEqcyquQ6r8iK7INU
         ENwCZFHaRolxyFjd9CJ0rdPUqWgFuMNti0mvS0WN2BfrrlSwwtLSw73Z9LbwAnXusHs6
         SAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751404; x=1696356204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1X/0Zt7z+oOh2YdMAkIlfw4aC9CST8nDgU19CDUdTeo=;
        b=a+B6DCTCFrOW/B9s8FryIIRh2Ktg+KfZw136SgxAy7hCsKdGn+jX7jLvxI+dqmu/ml
         P9UxeCHQdO9IWc917E4AigKig6OOaIaYtPQHRb7pKJrpod+gxoNzMJvsucwff48ijO2x
         D0NQ7Tcbgz+jnrwKw4rUNVFsHVGQSKZyQIVoy2Z8OxAa17AMFwm2UitUIKlme7cgyhbu
         3WKi9K0B98D0K00jlnzJ0ozkMLOjEMlLDstYotGt/4i7pd8yR5MtPIIQ12s+g8jUwwLJ
         64h4Qxb7JFmWpZaDpDLhJyoSH1h29Q1SI/I03aZUMoDSGuEZyAzLM+VnheGk0MmivS2p
         XZ2w==
X-Gm-Message-State: AOJu0Yw5Y1y7s+X3Z1hWdfVXtVO85razrnHdIppQ40k0iowsDEx6yedn
        RrFxgK0OIVYxdUkLOu5pbHZ/0/3wW9tDNacYWO64Xw==
X-Google-Smtp-Source: AGHT+IH6PNxwFL432DfaPRHZ68/+mdDkldoTR7HOMu7wPlfBa0i9UL0sFgc9BGkEzDV/1Dz8YKKvjQ==
X-Received: by 2002:a05:622a:1819:b0:419:51d1:5456 with SMTP id t25-20020a05622a181900b0041951d15456mr2166009qtc.22.1695751403859;
        Tue, 26 Sep 2023 11:03:23 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fe12-20020a05622a4d4c00b004109928c607sm4825887qtb.43.2023.09.26.11.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:03:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
        ngompa13@gmail.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 09/35] btrfs: disable verity on encrypted inodes
Date:   Tue, 26 Sep 2023 14:01:35 -0400
Message-ID: <ec25bd8540fb43d38a1f58d3df2f43299c50f7d2.1695750478.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695750478.git.josef@toxicpanda.com>
References: <cover.1695750478.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Right now there isn't a way to encrypt things that aren't either
filenames in directories or data on blocks on disk with extent
encryption, so for now, disable verity usage with encryption on btrfs.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/verity.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 66e2270b0dae..92536913df04 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -588,6 +588,9 @@ static int btrfs_begin_enable_verity(struct file *filp)
 
 	ASSERT(inode_is_locked(file_inode(filp)));
 
+	if (IS_ENCRYPTED(&inode->vfs_inode))
+		return -EINVAL;
+
 	if (test_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags))
 		return -EBUSY;
 
-- 
2.41.0

