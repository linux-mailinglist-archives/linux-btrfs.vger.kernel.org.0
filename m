Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774D33F51E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhHWUP5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 16:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhHWUP4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 16:15:56 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFE7C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:14 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id eh1so10426077qvb.11
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=byX9w/Dz6OGdoxb/SrLuWvN50ehQZMZNsu4gsfldjFM=;
        b=XJZ0M8t1XEvxayFf/iM7062xtfOZtuZVy1YUmZCd4626pWAgh6X8CHuvv3e3hkLzLh
         E0VGEXcDp/RAhOWr6S74btJPhQAFhJFCiaVp6hcd8FVGxEGAHR83ryEDZOeayRxLU2mE
         /Ed6wTP0IoVjMYzHe6QKuWM5fPirrAu1mINzg5W8gU9Zb5Qgj3rLb0auL9OjBCd+qTig
         WQf+FEQ1oqwXOLYWrebpWyuXj+l3jcUZtPuq+gtQM4nHKW1NwcPt21w05YJqzQtJO099
         q20x6EkxSy9ZiqlJOOHysimc2iVCZuj9JFGVp+F67csmcS4ukndEShRmGFsD82QDGGBf
         HTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=byX9w/Dz6OGdoxb/SrLuWvN50ehQZMZNsu4gsfldjFM=;
        b=YfzU2VEI2sRUm/+VansIIAbQDPEnxApg2IiREA1vb+TQxfjQRTPkjd73A/sua3anQr
         1CdtB6TFi8n5EcpQQ1XwectZzDuAezuEMcqFXRrSTgWL4ohramnoA3srgzkl5kBOMAlX
         aQKGvZVDREVPbJnT+8pxQMoZKkF69eYZJ5Lwok+nKJ4u89w99w+PQD3b9Al0KTWFGlLy
         RwYw2x5YpH4W0pAIgiUyc7HVfsG1U0uWoNKaAnJHiVtAtwxo0JhLSeRxo7bMvmS4KHv9
         /9rcXd7JWs6EIZUipL3LrL0ce9JAyIG+WKOyQewi3MrQvFliWqYiI3zO9GXDzgCI/SJk
         ILDw==
X-Gm-Message-State: AOAM532dxUTBQX0+tT02eixleijKnTUaAbQ6H8yBG9y/Sh5dubAisAxK
        7L3Nv18XaW6L4RnG+qgE6R1XCkUfyJwtrA==
X-Google-Smtp-Source: ABdhPJxDtySnX40kO0yBPNVnOx4tmy6uvzCbc0rhbQmfeV6fRBDMl+iptnh8+J1eE1xnCeou7jqu+g==
X-Received: by 2002:a05:6214:4009:: with SMTP id kd9mr34811326qvb.40.1629749712861;
        Mon, 23 Aug 2021 13:15:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g20sm9056887qki.73.2021.08.23.13.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:15:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/10] btrfs-progs: add the incompat flag for extent tree v2
Date:   Mon, 23 Aug 2021 16:14:55 -0400
Message-Id: <f474a0ae757917a837b7a999b48cae2f5547e060.1629749291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629749291.git.josef@toxicpanda.com>
References: <cover.1629749291.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I will have a lot of preparatory patches to reduce the review pain of
this large feature.  In order to enable that work define the incompat
flag.  Once all of the work lands to support the feature there will be a
patch to actually enable us to select it and manipulate file systems
with that incompat flag set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 1 +
 mkfs/main.c           | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 3cca6032..fb918aba 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -496,6 +496,7 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID    (1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
+#define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
diff --git a/mkfs/main.c b/mkfs/main.c
index edfded1f..7ea6910e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -253,9 +253,11 @@ static int recow_roots(struct btrfs_trans_handle *trans,
 	ret = __recow_root(trans, info->csum_root);
 	if (ret)
 		return ret;
-	ret = __recow_root(trans, info->free_space_root);
-	if (ret)
-		return ret;
+	if (info->free_space_root) {
+		ret = __recow_root(trans, info->free_space_root);
+		if (ret)
+			return ret;
+	}
 	return 0;
 }
 
-- 
2.26.3

