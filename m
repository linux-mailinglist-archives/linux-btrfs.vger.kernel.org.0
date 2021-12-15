Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E76476380
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhLOUkR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhLOUkR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:17 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB17C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:16 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id m192so21342597qke.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3iTFlYtNrMYgDXIfuU04hbupZdDoxqqS2koMZHGozfw=;
        b=5DkYLkSf1mLMrXKPWDcFHCYpPzoAujt1ydOYko5WbJysPglJzYOjr2pK96avhekQmn
         zn+o9YmeX1KnXwcVglioLxmNNYFx6/EsVF0/Bkm7WPu1D46IdN1Xb3yXGb5DkLFpTE+q
         UTsJ2nK6yW69TFjHZVTlaLutgppiPrAyh9piXkuWESxu0a1DiIgaWg4h8g15unhZWAIM
         2bZFcsTdUdXe/6CSdKIl6yVmCum7s1U82N1UOhKQrqnJWpRO+uAs79ykih3HiHf1isA5
         hQrMF64NRcDGUdADVJRdlXoQ5aMbghYGN5muwcHWW9T9TSoGuh3D8xtVe4WmAHRvU26N
         HG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3iTFlYtNrMYgDXIfuU04hbupZdDoxqqS2koMZHGozfw=;
        b=Y7BPyTUHsAdVWtYveQMVByX4QVhxosAG03iS2mKvQjDLWbAwPDab7vEdphyXLdgPnN
         AmSI6Pgc/abys1cUT36meNz3JFhO9jgpTjWMKkjIX+jwKGpnsOrTHoneAofk9+L12G2j
         8Q7rcH2P5Ul8/gdm7pQDIq3lHp/jblRlTTNTFYT9vWURGZF64JtnA+uc/OZUh6JgFXpS
         6d3dwx1E/k60ITV/HYZ/AYqxqQgLEKWdLLSzwNV92qahRb7texDLKoG8H0oygssN0Bva
         aNMu1a31+uxiDI9mcuuBYcJQ3DxDXVGoHtdfkuKINut9cHcNh6UBxLnqbY+YCvhox2gC
         gw5Q==
X-Gm-Message-State: AOAM5323kXHWtFtXEVnaGUAWYRtJ13UdO6vdTrLW2B+OsZVgLN+f02Bv
        wUbhadRse6gvrtQ0Z0l+NjPrREoU8A9n4w==
X-Google-Smtp-Source: ABdhPJzfmErXTnqhq3ttJov0ffZoZEDv8nEv0ejP8MATlGpbvxIV79w72aIW/SJVtpvmGNzTQWiAtA==
X-Received: by 2002:a05:620a:1727:: with SMTP id az39mr10170039qkb.567.1639600815890;
        Wed, 15 Dec 2021 12:40:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 2sm1602498qkr.126.2021.12.15.12.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:40:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 04/11] btrfs: disable qgroups in extent tree v2
Date:   Wed, 15 Dec 2021 15:40:01 -0500
Message-Id: <5860e4d1ca5ea800b762b4b3a8865bde1ea260fc.1639600719.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600719.git.josef@toxicpanda.com>
References: <cover.1639600719.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Backref lookups are going to be drastically different with extent tree
v2, disable qgroups until we do the work to add this support for extent
tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/qgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b126cc39ffd4..1c686c0be352 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -948,6 +948,12 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	 */
 	lockdep_assert_held_write(&fs_info->subvol_sem);
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		btrfs_err(fs_info,
+			  "qgroups are currently unsupported in extent tree v2");
+		return -EINVAL;
+	}
+
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (fs_info->quota_root)
 		goto out;
-- 
2.26.3

