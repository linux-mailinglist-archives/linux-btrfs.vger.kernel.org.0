Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A0B2B204A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgKMQYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgKMQYc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:32 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DE7C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:32 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id v20so1563511qvx.4
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7WbAWRi/nfutk4PXB8ij1Y54ZavamVzLhrFlE05f8t0=;
        b=wYp4CmAqmOBuivbQtSqyClDUHxFTllmLH5Uk5NrFF/Hx3O/J5VJWZdfPsVeajCshur
         G7oaAyBJbeqPBEj6ILQCEZo5NjwI5DWk+NyqiI1EmmVl8nShECXjqvpx/n+lEvLHtRtK
         50M7DFXIFQf6EwWuf9aIey4Sb+IYUycXXnXGWkGHoLvZg2I6ZDgaIuaZLa5CAKMR14Wl
         WV5KP+8pp7Op+ApCBnv8vBHbIsUm4LkHkmEUshO4VEAztruRjVGMvxG1TvWieDe3Yq1p
         qhUsEHo5Sb80kSr03r5VK7KZUeIVh5iuXslQPjHwg4pITg993IRqNsLL0SoBhTJPoa8X
         jaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7WbAWRi/nfutk4PXB8ij1Y54ZavamVzLhrFlE05f8t0=;
        b=JfgtVtrmpVJGECgCPncUyVWrOmJuX/SzA7mPL/2EVW6UVNH2TP6hG4NqyO8N9mMDmW
         BplBA3uGvRtURRtXfHGWWeQ1DzZoKT0RdPUftkfO/qDakHATfKbAre5b7gPbb3usCTMf
         C/NUQ4AF+FvHYB8d2sC6Zd2Tlk3QwelLpfJxLKN6nSU3yHYesfucnNiu+0WniAw2RcM9
         F5hq7SUY8z1vvUBzIsA1QVe7DOyrnjmDhdG/2onBN2vjADrh5AJJjOX6VrNMpD458H7P
         GiJoqzA3Czb6Z9WOVaYwRNiW8DJPH1pxHBzfX0aYGDR77U1rtHYFJSCmvdjE+obbs8Zc
         n74w==
X-Gm-Message-State: AOAM533TEWQvlC0dOXwVnoEI4oHyK3sqcExsmj8hMCX0Rw3ZOk2XwiHi
        suYeIJlCiikp4S5Bd6F9f0CzhEYjI9kN5Q==
X-Google-Smtp-Source: ABdhPJy1UKTYpOL+Z4IFxJfRS93zPaUcVBaAAPaZsPNfVjZQ1+ytDmZwuCqKXKOmrSHGBAse0Qi0Hw==
X-Received: by 2002:a0c:ff28:: with SMTP id x8mr2771899qvt.46.1605284666874;
        Fri, 13 Nov 2020 08:24:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h12sm6776691qta.94.2020.11.13.08.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 28/42] btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s
Date:   Fri, 13 Nov 2020 11:23:18 -0500
Message-Id: <5374dad86f48d41fb63e9de54ef91144a4f9b656.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few BUG_ON()'s in replace_path are purely to keep us from making
logical mistakes, so replace them with ASSERT()'s.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ec6228de3ff6..bb393fa29087 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1202,8 +1202,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	int ret;
 	int slot;
 
-	BUG_ON(src->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
-	BUG_ON(dest->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(src->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(dest->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
 
 	last_snapshot = btrfs_root_last_snapshot(&src->root_item);
 again:
@@ -1234,7 +1234,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	parent = eb;
 	while (1) {
 		level = btrfs_header_level(parent);
-		BUG_ON(level < lowest_level);
+		ASSERT(level >= lowest_level);
 
 		ret = btrfs_bin_search(parent, &key, &slot);
 		if (ret < 0)
-- 
2.26.2

