Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19646F264D
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjD2UUM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjD2UUK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:10 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E87E70
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:09 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54f6f0dae19so11448437b3.0
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799608; x=1685391608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wwspeZVlYxQaBnSE+MC74amhy/TEKZm3/Ci9zzPf7A=;
        b=a9ex1YaYxpA/JLjkXPwSASbKIJXUkUHLE3ia7t7/pFjkwfkKid+Cnf5eeKdTssijTf
         l38SzBRuI2CDhJXoN7BsW9r6CxR3cp4ASjAGUlOrY76RJeZz3m70bZiH8+S5QUrU9/Va
         zcwqOohfkvGsHagXS3UPRCzJmCA1CwOefY1HmrTakEB84/454wcnjCMc8iHF5/c1NDXN
         YTTmSbucBplH+Bfga/xZ32jBJIxviQ1jUU/kvYnkjX8UdwI/qf4AaXnUCdlDjTIN+tGq
         H9JWdNVIUVA3F9ySDw1a31/LRmF5rq5IvfXnDYXMqZQl3I4a2tVpnWeSsKydJMm286if
         EOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799608; x=1685391608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wwspeZVlYxQaBnSE+MC74amhy/TEKZm3/Ci9zzPf7A=;
        b=f/X5H15gUwBN7urGqfVzEIyhk128u4tHzkxPLFg5p5kE9kr37LU3HFphZhhRVzfAXr
         4KYrBJYckoiUKzai1ip6IzwDcUhmU85b2H6onsAn8YrHc0Ktn5eUeWVrbHPuehtkB5Ki
         YxzavWiIjc+qPIgTnz8a/3ZwKXKdr2x71HD6nTRr/NDT7zUqaOEiSdnuO6ldAu9j53sX
         FaMJrt7/20xrbJ/6iu6jYObuGnNtaUHhGB90JVrkqXkZ8hxwSK53CNSsAN4jt8SsMBfe
         D3RaF34Tt0kLz7nGh1EZobJX4dBPKExlhA2fBM0iMfP6PcAnsjvFzGhl7zgXye7TsxMP
         efFw==
X-Gm-Message-State: AC+VfDyMlKaSFoX4COrsd4eN5mrGrk9LbiMI1Mxej+iCacPVUZkSVSA8
        gww/P/5KsyJzW2wWfNCK6n/yGGGLiZ+7nMD1Rz89mA==
X-Google-Smtp-Source: ACHHUZ5bKMo+M2KKzufa6Z+kKKju8NpYGOaI/ECV3N6Wz+YDjcguJ9VRuZ7+dZCuUEPvWfZdK3Ex7Q==
X-Received: by 2002:a0d:d88b:0:b0:54f:32a5:efde with SMTP id a133-20020a0dd88b000000b0054f32a5efdemr7797570ywe.10.1682799608323;
        Sat, 29 Apr 2023 13:20:08 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w9-20020a817b09000000b0055a0c417bc6sm136748ywc.109.2023.04.29.13.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/26] btrfs-progs: remove add_root_to_dirty_list call when creating free space tree
Date:   Sat, 29 Apr 2023 16:19:34 -0400
Message-Id: <e85a03ed7b78244d4274b4a2546c741d24f9f346.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we insert the free space tree item into the tree_root when we
create the tree we don't need to call add_root_to_dirty_list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/free-space-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 4064b7cb..a8a0a6ec 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1522,7 +1522,6 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 	ret = btrfs_global_root_insert(fs_info, free_space_root);
 	if (ret)
 		goto abort;
-	add_root_to_dirty_list(free_space_root);
 
 	do {
 		block_group = btrfs_lookup_first_block_group(fs_info, start);
-- 
2.40.0

