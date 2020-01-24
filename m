Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3E1A14892D
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392756AbgAXOdV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:21 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46491 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404167AbgAXOdU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id g195so2150943qke.13
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytnpG7wu0nRMJ8pe3jBKEfOsjIqrXdPt/VIAxIbGm2U=;
        b=jB/7jx9NFgxkyKks8OpZrDx8aeAn4xYvfW6hU63D40GV3OVcE12nqgKQmJjNEoVKGA
         YDvqnHP0y8NYISEF7I3l98XrweD9qdvwY+zd4cIsFxa8nRHs5WtlzRkO84sm1qAnvyPY
         guExtGTTyNu2yAP1DIl10gDCObE659iDXzinSSoij7ZFQe6hwe4K4XCzG7cYzFT5rZkR
         MVQ0AkwaWSgJ+DseUsKtLaeinwt/1B8roSX7gnGISDBSYO2agLgdZAkO1Z5O8wrcyCSM
         C6nXEKcdtotTdeJKAMWItA5Ryt5yhflHiMxxFsk1Tngvdi5814T57x59kJuRsjJj0UPP
         cxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytnpG7wu0nRMJ8pe3jBKEfOsjIqrXdPt/VIAxIbGm2U=;
        b=F+NCMe4X/QqT4oFfGtd/eqmtcBMqlFNzRxIT7NpwYWUWdYpGhKWWrf9b3/PKFYpdzQ
         raEePRVYeA+Qo/6wQwBdmm88kXgkUmEc/adQvNT0U83/h9HtE9ktEOhmX9wt45KrksGO
         18JvJSprd2MbaC5BK9myqHoCb45CaXZQXCAUg2GgYZL1r0EOr7qMWg7PY9h0fr2obq16
         j4+sAiv3+bgx6fCzSECSbBK8ZZEF7KutaY12Wu/bk18YCgkK6kk5n8pPi3RwwCXW/J7L
         LpokO4HmJGq/sWC6XZjrpw6XKXfJv7PVjePcax7K2oXHae/LGpmisEChcLDqcPe7A28g
         VXtQ==
X-Gm-Message-State: APjAAAXu8ZROsGSa/l7dJZz1hFmw8oUnwtyUVDinwQCCt0ANKY8qCcnq
        AcHy0AQwv8sPSji4ootENkUBXfkw0+3/Pw==
X-Google-Smtp-Source: APXvYqxvKDsrZ0AGf8ycjgIGXxAxg5gf7R+x4sZqzkMUGqsr2eDPj/nKuiPD2N5D056b8vMQKuGl0A==
X-Received: by 2002:a37:5d1:: with SMTP id 200mr2793629qkf.492.1579876398826;
        Fri, 24 Jan 2020 06:33:18 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l4sm3155482qkb.37.2020.01.24.06.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 09/44] btrfs: handle NULL roots in btrfs_put/btrfs_grab_fs_root
Date:   Fri, 24 Jan 2020 09:32:26 -0500
Message-Id: <20200124143301.2186319-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want to use this for dropping all roots, and in some error cases we
may not have a root, so handle this to make the cleanup code easier.
Make btrfs_grab_fs_root the same so we can use it in cases where the
root may not exist (like the quota root).

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 7aa1c7a3a115..8add2e14aab1 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -88,6 +88,8 @@ struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
  */
 static inline struct btrfs_root *btrfs_grab_fs_root(struct btrfs_root *root)
 {
+	if (!root)
+		return NULL;
 	if (refcount_inc_not_zero(&root->refs))
 		return root;
 	return NULL;
@@ -95,6 +97,8 @@ static inline struct btrfs_root *btrfs_grab_fs_root(struct btrfs_root *root)
 
 static inline void btrfs_put_fs_root(struct btrfs_root *root)
 {
+	if (!root)
+		return;
 	if (refcount_dec_and_test(&root->refs))
 		kfree(root);
 }
-- 
2.24.1

