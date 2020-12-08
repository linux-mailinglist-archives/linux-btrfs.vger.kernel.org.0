Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62ECD2D2F9D
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgLHQ0X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730486AbgLHQ0W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:22 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3647EC061749
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:45 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j13so1080208qvi.8
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ks8S6fmIdnffRKk53DpIusthhK43EixCopiMTYjdIP8=;
        b=xhy/crMWK4unVhTccoVAusOyAYeC0TZRyR+WoIDMmng04Vw5q8e8FMLuwjqEJHHGhW
         0CUey8iA9MGmVPF2av3do2KW9SLbiueYLx1yrOCR8slEsSHli42BxXfUQTZCORPrEnji
         xn70a0/wdw83mf1PQ/jFtE/Ai5wu3R98muUoLW5+L4UiJFRiFvAVJGPpOEbAM+rgMruH
         QG6703PJb2lTNi9MF9uth2iN4GfUNl6qQ4pn6+8/N3/3Bn1QxE/dypnUD0czHIq2sqdX
         7vnM797Cd/poUltNy0iIhgYilcpZfikI85Hjqo1ZF78d8i/cvfzv9pUL3XrAwqyqwux6
         9BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ks8S6fmIdnffRKk53DpIusthhK43EixCopiMTYjdIP8=;
        b=ihP6zlFUFYAAWHcG11fNuhVsj6s/wbY7tHVT1hcF1OmEsqU6q3CU6j/ami5YUrKVkb
         ukiyzjLZFi9Xg6acplrXJXK59ONHO2hi2/tiPQeSMa4N5JDf9q5fm0lTpLh13e68RJdW
         JABfr39WFOmWs75Wm38XHNUOMk1DRR1+PWbGLKWWUVILAV/Vf6N71QiSQpzNP8lDiRHC
         AKZfShxeYHB8ZVNCXvsn6DjCwhAhwee4PQWfI9+JV9wDKq4vOugkW5iEiX8WfCRCSbRA
         BklU+R2HdcODK4+/Mgq7ejl8G9unQIHz6Zn2l6UL1Y3IOdQQr4NSSyr0Fc16eR3GqVe/
         1F6g==
X-Gm-Message-State: AOAM530FE02qZJ/39QggIBnsuib1cMOOZUoJSei65ukpLAQlq0miqaxu
        SI/j/XR889Y1Nz0PZYmksip7BeJMQwztncIl
X-Google-Smtp-Source: ABdhPJwdtvBxxVr5S+DDJvR7MCdhYcgM+NWdEVhnYLm9KCmlGKDPuuBOVthnY7k5vQe5sMMihIJLhg==
X-Received: by 2002:a0c:f2cd:: with SMTP id c13mr5794099qvm.11.1607444744110;
        Tue, 08 Dec 2020 08:25:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b197sm14629480qkg.65.2020.12.08.08.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 47/52] btrfs: do proper error handling in merge_reloc_roots
Date:   Tue,  8 Dec 2020 11:23:54 -0500
Message-Id: <e1ac662997d4e2c238bbc6c463216b2aa696a0be.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a BUG_ON() if we get an error back from btrfs_get_fs_root().
This honestly should never fail, as at this point we have a solid
coordination of fs root to reloc root, and these roots will all be in
memory.  But in the name of killing BUG_ON()'s remove these and handle
the error condition properly, ASSERT()'ing for developers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9a59adaf178c..066d06575dbc 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1950,8 +1950,29 @@ void merge_reloc_roots(struct reloc_control *rc)
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					 false);
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-			BUG_ON(IS_ERR(root));
-			BUG_ON(root->reloc_root != reloc_root);
+			if (IS_ERR(root)) {
+				/*
+				 * For recovery we read the fs roots on mount,
+				 * and if we didn't find the root then we marked
+				 * the reloc root as a garbage root.  For normal
+				 * relocation obviously the root should exist in
+				 * memory.  However there's no reason we can't
+				 * handle the error properly here just in case.
+				 */
+				ASSERT(0);
+				ret = PTR_ERR(root);
+				goto out;
+			}
+			if (root->reloc_root != reloc_root) {
+				/*
+				 * This is actually impossible without something
+				 * going really wrong (like weird race condition
+				 * or cosmic rays).
+				 */
+				ASSERT(0);
+				ret = -EINVAL;
+				goto out;
+			}
 			ret = merge_reloc_root(rc, root);
 			btrfs_put_root(root);
 			if (ret) {
-- 
2.26.2

