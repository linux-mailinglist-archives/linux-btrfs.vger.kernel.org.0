Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C3B4762F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhLOUPN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhLOUPM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:15:12 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7568C06173F
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:11 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id b11so21354382qvm.7
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f5ZB5NAz+Q2MocYhpm5WUHphxhoD7b7ULgL1X9LpFQ8=;
        b=vHTIXrnwygMzSNrSSd1rk2slfXug7wBbRXzuvTzIMzL6t4/z9cBN3HQ92NVtnIsAkG
         a4vn2G/OLs2OV6wxETvH9vMdb5N0DhqlYwiAbu92uy2DpkqjqTLTdUwl6RnDeMTroHcQ
         V5eRK96T8aYVAtgSsiNDfp+Cq8TH3jT7tEEgbIM0jLFOr+auNeXuPNBhNN/7SszMFIV0
         Q0aOuPemVKPAOZjAEgDqv2IB0SBqp22jqyg67gzmj2faB2zV2wEo9FZkKX/ofwk/3qMK
         g9CEkmtG2mjeSG4ppGsc7B8DYUSyNlvLhqjlk96bl+GXyy4398RG3zu+pfCjyk5mhR8p
         J6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f5ZB5NAz+Q2MocYhpm5WUHphxhoD7b7ULgL1X9LpFQ8=;
        b=v2Xu+UaZ1RZV1KqHssMMajhKo56mlU9JCVlA25lW46sClTyyD5pQfh/ZutpLT3o8FB
         XPhEIEoi/8R5A3bJUnsJwOEH6x70Frd865a1cApju77jn/Fp6ftvPRhaPvufqI9daG4V
         XSo6fr8Y45rvgm601SHb9lOYUQFDxV1SbvMWrghWKQmTiQAdQ36sYMVHYBVB1WuMlH1x
         fC3gMtLbs5FgbtnbmZXeOzhcjAAqG/pdeBHXKNbVBccwjqyEPYUVlAHwgx/eZZH9ahZ1
         kGQ48xxVm87NQ9MPZSpdtA8f8KkFo1skXjn8VdzFYC7CW510wD5AA+DWBVGz/5yFwRv2
         M5bg==
X-Gm-Message-State: AOAM531qM7c9waWsoFRGtVhJ5rCmvupw7hfRFg1VX6KHFIJRyk6yqWMi
        QQ0pMZx+7QpjCeU0MOJwiAqX8codSaY6mQ==
X-Google-Smtp-Source: ABdhPJydJpEwQvQ5B02yR3Qay2P5rOQcpqaRJjDJyiv7olSk6oJT/XDYaS+Vki5OHMR6dwBIej1jJw==
X-Received: by 2002:a0c:c78d:: with SMTP id k13mr12999159qvj.112.1639599310567;
        Wed, 15 Dec 2021 12:15:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k14sm1572095qkh.100.2021.12.15.12.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:15:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/15] btrfs-progs: make btrfs_lookup_extent_info extent tree v2 aware
Date:   Wed, 15 Dec 2021 15:14:49 -0500
Message-Id: <ac18013c5914d85a9917ec6a919d0bb03b004490.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do not have flags or refs set on metadata in extent tree v2, make
this helper return the proper things if it is set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 1b4e6a02..cdfa8f8d 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1309,6 +1309,14 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 	u64 num_refs;
 	u64 extent_flags;
 
+	if (metadata && btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		if (flags)
+			*flags = 0;
+		if (refs)
+			*refs = 0;
+		return 0;
+	}
+
 	if (metadata && !btrfs_fs_incompat(fs_info, SKINNY_METADATA)) {
 		offset = fs_info->nodesize;
 		metadata = 0;
-- 
2.26.3

