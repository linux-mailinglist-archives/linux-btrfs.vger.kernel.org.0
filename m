Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC927AF21D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbjIZSD5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbjIZSDx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:03:53 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8431A5
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:46 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4526a936dcaso3893040137.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695751425; x=1696356225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFj/KXZDVq4ZgILGaKQJTaXcPhA9Md3ogicPK2eeNiE=;
        b=h7SPIUK/hoH12qIw3XXXSlOqWZpuV3PHUxsgXAdMpz+77nxuGgFkY8KN3cVKJNKb1N
         LePDIi9b4C1kRkT4p26ZAOjJ6mlt3p+m0ZkJqsh0NMdTOHKqChSpDKHN+e7qWLNpACMd
         CogLLLNDJHSBGDhvsdlFevp3xheg9iDeox1vzjRId0esb7dPoJH4L/5uTJsraPIYfEeS
         nlxsXZA3OiQtce7essgfTUHaCjBnDkhi7TCDc/+ajIV++Hz1lJDFgcp20DnKu661QOg6
         6HckKnY/CtAHQN65zzUs4DM40mKyxHsgJyvLotXANR9hkk4x2Hh0rOJarzZ7Qgt5/UhV
         YO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751425; x=1696356225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFj/KXZDVq4ZgILGaKQJTaXcPhA9Md3ogicPK2eeNiE=;
        b=OSbtUrUjmgfQWgskaEGnhc5pF5Wrsij9DWuhFMGuT9vJKElb6A9tmR8X+jUN+ef2/1
         jguMngwgjQ2Vm07Oo2chZYtczoS3uWZRs9fXRumCLCjSoaMUCk46Ffme8rIWiWja+dWe
         6m5LgUQ7Xyh9rvYPZPhw6VOgY2nu3/ucbsZov/BLDz/qLfYNEHB8N9mi+/bGcmNeaBvA
         Nv/oPinC2TBl6E6Ix8hFiGw6fu82N+8FA4u4PXaF+Iqm2qXwYVRDzV8h8FraYXdq3QjU
         j7wBWOv++bA7ZA0X2wHMg4RJ/s3B14MKpOlquG363ISBs3zXBonT4PuN9Q2hv/VCXLCf
         kNtQ==
X-Gm-Message-State: AOJu0YxXp8OPt96m+5H/7ZqWUVgBum+OSVEPO7eAU2uSaB38Afxawdpe
        aSyD7u6q7GUcYIghEwcARZb4pF3isPF02Tww79EaJA==
X-Google-Smtp-Source: AGHT+IFGyPT8yrsuFzbajp6fqV2z/XBGH+EMZKsoYCnVhGAqX2SReSuEb7gPZwSZY96mZVE54W/aWQ==
X-Received: by 2002:a05:6102:3bd5:b0:44d:4f8f:d8e5 with SMTP id a21-20020a0561023bd500b0044d4f8fd8e5mr7915250vsv.20.1695751425158;
        Tue, 26 Sep 2023 11:03:45 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j3-20020a0ceb03000000b006590d020260sm5212490qvp.98.2023.09.26.11.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:03:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
        ngompa13@gmail.com
Subject: [PATCH 28/35] btrfs: pass the fscrypt_info through the replace extent infrastructure
Date:   Tue, 26 Sep 2023 14:01:54 -0400
Message-ID: <75b7606b13b59f6ded03e547b11c230593d7403e.1695750478.git.josef@toxicpanda.com>
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
index 5b0cccdab92a..b4437c1a9f22 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -341,6 +341,8 @@ struct btrfs_replace_extent_info {
 	char *extent_buf;
 	/* The length of @extent_buf */
 	u32 extent_buf_size;
+	/* The fscrypt_extent_info for a new extent. */
+	struct fscrypt_extent_info *fscrypt_info;
 	/*
 	 * Set to true when attempting to replace a file range with a new extent
 	 * described by this structure, set to false when attempting to clone an
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fdb7c9e1c210..ee1ac2718ce3 100644
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

