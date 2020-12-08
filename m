Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD52D2F8A
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgLHQ0E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgLHQ0C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:02 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5612C061285
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:30 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 19so8854996qkm.8
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rDzKVwtkiSahpWv8OJlNI4e3Gr8IwTzTfIZwdt7++HU=;
        b=JOa8FI5V9gNVGjrnXMd+YUp3IZi+D67HVBWphNvQ/s4EPnsRxWK3ViDR0oalU8YrBO
         vf4nPH4Kd+fJvIqjOkql8e7kh5UT9sDnFhdhPHUSZC/cscDCvbb8uyhrcQeCd+2FHua+
         IWUNKCeZgZH2fLVNVA1MGWKz6n3qAl/4x0eMPG7d7m707TjkEeV51WBRe3tEOaMISMuW
         ThLWdpfWz/lMEVFPAnlMYpmgnwCU9F9yuWxAzdhcelrkAUwmrPGCOD7ZW7930WJKWWmP
         4DVz/taYoZqoe9ZUlV+KH0EJhH8lpu2SOL+UIBUNimvcKbIaQM5UlT5O99yiQSCj0/Xb
         9kgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDzKVwtkiSahpWv8OJlNI4e3Gr8IwTzTfIZwdt7++HU=;
        b=MijxxNzagCnXewuJeOA7zD+EmBrIIaqHbWx3/IYljNkSdzIGTA5v4Q4/QtmX6wEXk9
         XnaXoHMK/pL9kmrNHzMnM7T2Of2Awuf9DjYVLGBez9tHHkOEAvMrv+OW/DfgbFuFgXhU
         9cAbodr5GYefrdoaHAOxBZws1QFvtV6eslC/MTVKIzG66XMCYiOUgOafO4nVEkNLg/pT
         dIIP70a2bxkDZhEmzsCHwA6xoFy8W82aR48wa2YyR/jqE5FFG8G6TozjhDLr6OOhzRQ3
         VvAyaGQoLHJkEVi29Xj8AdtyM0qgXTmb2mvLm2QzLgx6xgFSjSMtCDST7WeBXZAJVsdA
         g1UQ==
X-Gm-Message-State: AOAM530l38+5LTxt8Wdn5aH/NH8nUkRrUKfJa0K+0Pj32wa3G14vNUT9
        vjlN832su/aEoYDaWG9/6St1VA8sRn0/ybcG
X-Google-Smtp-Source: ABdhPJwubhLfTgk3oJxY9NQmH1kMy5yQaW3U6o8bI66p2Zm9LCms/Qx+4JZvBhN2K64e/aXlbkwTlQ==
X-Received: by 2002:a37:b6c6:: with SMTP id g189mr11059339qkf.10.1607444729707;
        Tue, 08 Dec 2020 08:25:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v4sm15234624qth.16.2020.12.08.08.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 40/52] btrfs: handle extent reference errors in do_relocation
Date:   Tue,  8 Dec 2020 11:23:47 -0500
Message-Id: <c3ed5919213c5d04234ef939dc395ef581449c76.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already deal with errors appropriately from do_relocation, simply
handle any errors that come from changing the refs at this point
cleanly.  We have to abort the transaction if we fail here as we've
modified metadata at this point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5ddd9e6e354c..1097d1b3c492 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2424,10 +2424,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_init_tree_ref(&ref, node->level,
 					    btrfs_header_owner(upper->eb));
 			ret = btrfs_inc_extent_ref(trans, &ref);
-			BUG_ON(ret);
-
-			ret = btrfs_drop_subtree(trans, root, eb, upper->eb);
-			BUG_ON(ret);
+			if (!ret)
+				ret = btrfs_drop_subtree(trans, root, eb,
+							 upper->eb);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
 		}
 next:
 		if (!upper->pending)
-- 
2.26.2

