Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5E044447C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Nov 2021 16:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhKCPTS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Nov 2021 11:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhKCPSi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Nov 2021 11:18:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DD2C061714
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Nov 2021 08:16:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s24so2777163plp.0
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Nov 2021 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWUoQpJ3n1pbVknpUSJ6oJKcMGcqPTvpJL65j8DUc7g=;
        b=SYx3tOMp1+Jo07x7CCeY7XtJsOL4RxfXqzyUv8wYcY/zrXJ7LbXw8W9PIjGsWtlAun
         YaUC4mZDVc5wcUhp32JS7grYerRex7DDV6s7k+vFkl7jnktu3TmM6Aczihx1JYHlaCT3
         ATGw1wHvaKHXyiQe39YXRMnhF7D58tcH2aS9dxJcaiQG35rEdbs3k/9wUzDj2JEVOqg8
         I2rwIxfdfLBuntnLNWNybxAOpoCMnOD+EML6wZDcPTpgk1s9BRRgtCwVCEVhcyTH3EUl
         Ld2QchNMfcVA0Jwhu4V4Zx82WRlGtPra7Q5AJ+Svg8P5qIKQ0TfyiihCa8xeQbc7h/CU
         jXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWUoQpJ3n1pbVknpUSJ6oJKcMGcqPTvpJL65j8DUc7g=;
        b=oe7VC+IllcRcqLUrQWzqkBvaGfrhCEiqdxLbCZ4xITeqddhTB3HmIMYzlkYNC4nZBq
         WOu26juwgML6Jb/KWmO3YBHARVejdz0y4M9JVKIhrOu6eZEqaNTy1foaBbvB5ufqUCWa
         aiOr0OYkD82TK80hxNQmqHG0L/fYlUtnrfr9074oI90yzknY1jLqcFRlIcozd54YESLp
         Unye5dUL6xM41zxsUs6gYgAMPcqcXZNWxdyuIggJmj5swZXdZ7AAwWow1R17Vtga0Xs5
         y6Ky91Vj7q+S431CJWTaQ2WhTcfYvAtME5VDGtZaPE5lIiUucv0rgvoDvQLvyesTKWaH
         38yA==
X-Gm-Message-State: AOAM532bRu7DzNf/c91jtgi9KfgDmUwZgYE54Quda/fghYEAnj8RT0+O
        YaXmQ3TpZCszzH/ixXMcyT7Hn3PT4iMHJw==
X-Google-Smtp-Source: ABdhPJyash5/dbzEX/CVunIyo2BzFZsr8K88kJX5oXfiukEUF5XwvbQWHRHM0qsJnCw07Jyf/nWnEQ==
X-Received: by 2002:a17:90a:e005:: with SMTP id u5mr15405368pjy.17.1635952561686;
        Wed, 03 Nov 2021 08:16:01 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id n19sm5702052pjq.40.2021.11.03.08.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 08:16:01 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: check: change commit condition in fixup_extent_refs()
Date:   Wed,  3 Nov 2021 15:15:54 +0000
Message-Id: <20211103151554.46991-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch fixes potential bugs in fixup_extent_refs(). If
btrfs_start_transaction() fails in some way and returns error ptr, It
goes to out logic. But old code checkes whether it is null and it calls
commit. This patch solves the problem with change the condition to
checks if it is error by IS_ERR().

Issue: #409

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 check/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 235a9bab..ca858e07 100644
--- a/check/main.c
+++ b/check/main.c
@@ -7735,7 +7735,7 @@ static int fixup_extent_refs(struct cache_tree *extent_cache,
 			goto out;
 	}
 out:
-	if (trans) {
+	if (!IS_ERR(trans)) {
 		int err = btrfs_commit_transaction(trans, gfs_info->extent_root);
 
 		if (!ret)
-- 
2.25.1

