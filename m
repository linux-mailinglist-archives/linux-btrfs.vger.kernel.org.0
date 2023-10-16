Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D807CB251
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjJPSWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjJPSWe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D41101
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:29 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-777252c396bso292481785a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480548; x=1698085348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMKykqBQS3RwEEufY+WMuQHq/EYaymfByQ3Narp/qxc=;
        b=Kyn/KHEjzU0R2wjfLcMthHqkdvxJW6jKY+BrrQbJtWUUmwvkTYP/RizN2zbsY0AXbZ
         mgewLsqPHhr5m7Nx5M2Kb0OFcDE6X0Fpbqnybtchc7/UU36YcJMBMEWHjzw6SyQV2WAg
         wyGdDeJe+mRdywKVK2VSjMWVZCLOBSDr7aYLy2mDnLIlSzGSkQqiEjJW7cz3NNbCpeYi
         8cGyoKIA4JTjcssVrBqO7hWc+cNf4QJ1k/J00bzvComlFEFsG+tKubd1jY0m+SlfRPZF
         VWRL/3UtFQrja6uyUjO4MGm866yOFK5ysXCJcZ410bdzemaiOHNRXRFzQWJO/puMoVMt
         Rmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480548; x=1698085348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMKykqBQS3RwEEufY+WMuQHq/EYaymfByQ3Narp/qxc=;
        b=Oyn4YesqCoGnv3l4GpicnwmdMvB9FMoNww0u0VTnTaEU1+27a1y7B4jdLJITPz47Gh
         CaSwmVWKhCwn0gsHyjTVv8DMbkDGM2dPNZiOx8uxJGYvoyHDK0GUdGmcjj5poK6mhcYC
         LgLaaXehdW1glSLE5HbBtLQR61wZquCzOQggs297j3npBJCEKywWKM20Y9PuYixv/hzM
         DASlElfEuykO0UEZ6DMDREkAcyODSejG6RyVfDLLXCudRLTrdHd1jbTPa1XUA8ztYI0V
         d9s2iZBhspOYgy/8J3cXVXas7EFS9MU7pmaSVWI3odNDQZk/ZxNGITi/u/m/Air2ZqAx
         OLiQ==
X-Gm-Message-State: AOJu0YyHbHTooxTgIq7cAiFP7e/0aAa3pOgnn303eEeEP/qCf6SDOawD
        u4OUzKXR8k9meYkPyRKYrSqJZSO1OYxnOtWR2NnwOA==
X-Google-Smtp-Source: AGHT+IGl535gWvFBprfwS2MqSOD8DF66P7h5HONRLJ0m1tCQ2yZk3mfVEkB6/41KexJ+dH8HvCxiPw==
X-Received: by 2002:a05:620a:29c1:b0:777:5fa:501f with SMTP id s1-20020a05620a29c100b0077705fa501fmr27631253qkp.21.1697480548227;
        Mon, 16 Oct 2023 11:22:28 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v15-20020ae9e30f000000b00773fe8971bbsm3172815qkf.90.2023.10.16.11.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 27/34] btrfs: pass the fscrypt_info through the replace extent infrastructure
Date:   Mon, 16 Oct 2023 14:21:34 -0400
Message-ID: <9168ec2623c55ee714622472f27e1e45765b370a.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
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

Prealloc uses the btrfs_replace_file_extents() infrastructure to insert
its new extents.  We need to set the fscrypt context on these extents,
so pass this through the btrfs_replace_extent_info so it can be used in
a later patch when we hook in this infrastructure.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 2 ++
 fs/btrfs/inode.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e5879bd7f2f7..f5367091c0cd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -374,6 +374,8 @@ struct btrfs_replace_extent_info {
 	char *extent_buf;
 	/* The length of @extent_buf */
 	u32 extent_buf_size;
+	/* The fscrypt_extent_info for a new extent. */
+	struct fscrypt_extent_info *fscrypt_info;
 	/*
 	 * Set to true when attempting to replace a file range with a new extent
 	 * described by this structure, set to false when attempting to clone an
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 87b38be47d0b..99fb5a613fb8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9714,6 +9714,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	extent_info.update_times = true;
 	extent_info.qgroup_reserved = qgroup_released;
 	extent_info.insertions = 0;
+	extent_info.fscrypt_info = fscrypt_info;
 
 	path = btrfs_alloc_path();
 	if (!path) {
-- 
2.41.0

