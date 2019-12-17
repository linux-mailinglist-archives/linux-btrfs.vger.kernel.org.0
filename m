Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9FE123097
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfLQPhq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45069 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfLQPhq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so8563712qkl.12
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=melX/55R+mGKnJX2pY9dQE4ZsSx3WxtzyO6gYubI3RQ=;
        b=0LhCFr1ijQi9Odzx7ICMicUHkEVvZz+lb2dwhvs2nQo35VIgCdXEQWhqMZVgI145rz
         n4EbsKCMnhEbL5K/o6N7JekANxxN61yjdkcdFNoTZ5t7noDsUA1jq1nDBaA7w0DhulDk
         HWcd9OxWzoRJLF31nwUlOeLkXOHON+3RcqVVNnIeoq2L7coJyvmWA6xx36wo6N/hmuMV
         +DYBI63DbWWFVA5MgcVld0tYfkksWtovb0okzlRDiTt71momxZ3t3e2N6OqnyCfPyeBB
         dhnHgmOJYF5ZFm3IndCWs2tEcGIEcObIkeIbZh8hy7c/cD23paa0GALzQjFb9s1bY9Pa
         uxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=melX/55R+mGKnJX2pY9dQE4ZsSx3WxtzyO6gYubI3RQ=;
        b=nfyPnb5QH7DcnxBnnpI603p3nhDrRSBlO+ealLyYs9BAWmyGUM14et2ChHjDfQDIY+
         bF7Y6lol0pjmZj+Ok/YObqz4U7RAwlBRJPIg4epYDEI41i1oq5hlMwG/0yrBikyEBRcz
         F1ms2KKyHCiO9tc1etvL0GVeaJRZGFpkKzTLaggyQPOIHV95isgYBK2eWyFhF0QcKNyt
         nA4U9gIafBDEQIRqjnkl4KOb3qhnDUZS8OwKeIof5Ei7NaHV3TGeUrQRAnh3LKm1mgSw
         f3G+ee34ssO+8PkT5BvYs2E8/NYSEbL5ETqVehbbgnRBD8UCnpx4yuskBqRAykVAxJav
         b2IQ==
X-Gm-Message-State: APjAAAXu7ojt1+QrnN60moWeLWv0O3VVWoSPcDLZLsTQyp+3KZM15n0M
        A2bnyey/mwYioK2DLIx8hUta43Ra8khLHA==
X-Google-Smtp-Source: APXvYqwZS5f61qb1VOzcLmgyRSnVbsMvXcqnweMjzm7UQHWMberMIYInwh70rQwRgPHTbqQNCQbfPQ==
X-Received: by 2002:a37:644:: with SMTP id 65mr5709468qkg.309.1576597064963;
        Tue, 17 Dec 2019 07:37:44 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b81sm7102689qkc.135.2019.12.17.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 37/45] btrfs: hold a ref on the root in btrfs_check_uuid_tree_entry
Date:   Tue, 17 Dec 2019 10:36:27 -0500
Message-Id: <20191217153635.44733-38-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup the uuid of arbitrary subvolumes, hold a ref on the root while
we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 904c3e03467f..47ac3277ee08 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4379,6 +4379,10 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 			ret = 1;
 		goto out;
 	}
+	if (!btrfs_grab_fs_root(subvol_root)) {
+		ret = 1;
+		goto out;
+	}
 
 	switch (type) {
 	case BTRFS_UUID_KEY_SUBVOL:
@@ -4391,7 +4395,7 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 			ret = 1;
 		break;
 	}
-
+	btrfs_put_fs_root(subvol_root);
 out:
 	return ret;
 }
-- 
2.23.0

