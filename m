Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6D72B100D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgKLVUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbgKLVUP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:15 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3B3C0613D6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:15 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d9so6893692qke.8
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/EqR0hxW+wlLlxRr4NXGWkAxoEFryPq5N1nxfJ8S3gg=;
        b=vri2CgPtmyZ+o7r13TkyDsM4F3sxM/qP/MwmjmKSP6Q+KibHIexaTTEMJ75asNZjH0
         CZk8T8cDP+Hn3RDgi2kM/pT2oROs+rsgpprQGN5z9TW2d56gWQ7oF4rIs0Y222nOdkhO
         yDMFpLlhAm2WEqh4tdrk6sJgxTqLybQGUFLzKRcBQXGbSCcDbvw5B2phHwOr9Rz58iJD
         yMVSc07WOBZWSyyHGeTF1CHiuIJWxlXj4rmmQQjo4jKqXtZONTJwynEwTcbm4nCRmJWo
         282VE7KN9VLn7unwLLTLgwgZPAuf4JTGj4YoJ0XWL2lSbzHj8IWp7p5fdxm9KOCd539M
         ZCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EqR0hxW+wlLlxRr4NXGWkAxoEFryPq5N1nxfJ8S3gg=;
        b=Lw6+qfM3KcMpzavy/PWpVef2tAIdWe36JEq6LipER+9simGBrU8d5PZidHquud/v+1
         hMTgC8NvU/DAQrUF0gv8qqEeg2aj6veWLyU3z+bw2wRloEjw8l13qju1ni6NbI6rhmEc
         4kDLRyeILd8hG6Uenh3NVk8NKJmEGTIV910BIlirVIF8BV+pNtbwMRJyljiwvpPvXvyQ
         5TTGAcTc8JfC+M/yb6r9WXZaNrN4QITS9uu++iB9+IB3IgVpRM5xDIZcwp+tUMDgKbd7
         akvCHtDURQkTuscvd+e8Y8OH+kw6mKAHBSTwG+9+L49FcGZ5WVqX64/xRmsem3+NSzzi
         BQCA==
X-Gm-Message-State: AOAM532Qu3PGtLxndMVFmom0udlDG8dNkhJ4JAAuAtwgG4I42iNIRKtw
        OaNvstrStICHddFRVIZBHstYKd61ZVug3Q==
X-Google-Smtp-Source: ABdhPJwIEAQ1wCDIj2L69ss2aZYjUbtFyQnjd3gxF9wy+rQfJSuZlL++rAeHIKuUCjDDs7jfHa8kNQ==
X-Received: by 2002:a37:a54f:: with SMTP id o76mr1685416qke.201.1605216014031;
        Thu, 12 Nov 2020 13:20:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z11sm5259794qkz.38.2020.11.12.13.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 31/42] btrfs: handle btrfs_search_slot failure in replace_path
Date:   Thu, 12 Nov 2020 16:18:58 -0500
Message-Id: <7b6365e1322a8f91c153da7699dcc1d71ef75d9a.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can fail for any number of reasons, why bring the whole box down
with it?

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 52ae6bba2261..2c7196e4ef8f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1322,7 +1322,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		path->lowest_level = level;
 		ret = btrfs_search_slot(trans, src, &key, path, 0, 1);
 		path->lowest_level = 0;
-		BUG_ON(ret);
+		if (ret)
+			break;
 
 		/*
 		 * Info qgroup to trace both subtrees.
-- 
2.26.2

