Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDDC44CA22
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhKJULC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhKJULC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:11:02 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C51C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:14 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id t83so1287042qke.8
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BOUE7wzYiP49Wf9ee/1TVE4FBYic7xZ69o2T50x6XU=;
        b=hvW8r1PVwfF9eGsYOWwgbiBDpd8mH+OMTYPr546wJUsubqPrmdQFA736ph2FQr7Aaj
         akaNTJeBubJu48M/Urvu+QR4AF0RF970UxZt8mV8Ls8ZUljwlHP+A5YHjBelrCTC3Sf9
         N+2IsoRFBp94YDI70yUoMgHCfrzwbSsxI+J9JHj6/LGYH47fOdd8/d2xrZlhv9nM5BZ6
         nQikc8WOCgciWueY1MtbgwgF7I8DiUHH+wIIAAjC1W3UYADmMrdPYzkiuZqpRl42uW4J
         k9udZRrFkKbO3FUQ8J/lDgEHMig0H4PzT8mYksrARSGFqMGibZDhPcMjGVRj4p6h08vr
         oVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BOUE7wzYiP49Wf9ee/1TVE4FBYic7xZ69o2T50x6XU=;
        b=xod8D2aWc4jmdcx6zC8fc3Iv+M6iWxDoHTcKInLdYJkdBWlxMsbdFF9Q7yVpoALEGR
         mz5tTBjMg2GynVl71q+wQ1B1Yh/lH3fTCi4sdlfNjVTQLVWf4hPLkUg0nmhNdFrfeq9J
         4Z2mjlp1z2GXFa5dhbq9/Vsbg81C5aN0Drc212DifZvKpSTom9SfwrCrtcrKiJUEj4jP
         cYLDri/hMsVKorGeLxbtj03vnDXIEvh5u7lvP0rnv1k/4i8DD96nCaN4DOh2OIqwTxIK
         8p+zBxX+p2K20WL49Jv2iOpQGa6euvVvfkHrbovqx/SOq+sGd/r6q4dCymaFxeQgqfTm
         NGOw==
X-Gm-Message-State: AOAM5311un+4gb3RxnIPObxM9atBQTAlkL+Vce2GqdAiCkloXXsv3zn4
        IolRd713nzJkh+Qs16mMkOj205yC4KRppA==
X-Google-Smtp-Source: ABdhPJyB32oHtR3W4Ai4jKFr7IW45ZlXbxi5FjpclFx24kmFHH+hY2IPhMJxfRqzDDwjOPYn1xzBcA==
X-Received: by 2002:a37:6254:: with SMTP id w81mr1665016qkb.391.1636574892474;
        Wed, 10 Nov 2021 12:08:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c3sm481066qkp.47.2021.11.10.12.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:08:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 04/13] btrfs-progs: filesystem-show: close ctree once we're done
Date:   Wed, 10 Nov 2021 15:07:55 -0500
Message-Id: <0a5ead7ba7759ecf6da7fe19405e6df86fb8c6c0.1636574767.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636574767.git.josef@toxicpanda.com>
References: <cover.1636574767.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Running with ASAN we won't pass the self tests because we leak the whole
fs_info with btrfs filesystem show.  Fix this by making sure we close
out the fs_info and clean up all of the memory and such.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/filesystem.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 6a9e46d2..624d0288 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -655,6 +655,7 @@ static int cmd_filesystem_show(const struct cmd_struct *cmd,
 {
 	LIST_HEAD(all_uuids);
 	struct btrfs_fs_devices *fs_devices;
+	struct btrfs_root *root = NULL;
 	char *search = NULL;
 	int ret;
 	/* default, search both kernel and udev */
@@ -753,12 +754,8 @@ static int cmd_filesystem_show(const struct cmd_struct *cmd,
 
 devs_only:
 	if (type == BTRFS_ARG_REG) {
-		/*
-		 * Given input (search) is regular file.
-		 * We don't close the fs_info because it will free the device,
-		 * this is not a long-running process so it's fine
-		 */
-		if (open_ctree(search, btrfs_sb_offset(0), 0))
+		root = open_ctree(search, btrfs_sb_offset(0), 0);
+		if (root)
 			ret = 0;
 		else
 			ret = 1;
@@ -768,7 +765,7 @@ devs_only:
 
 	if (ret) {
 		error("blkid device scan returned %d", ret);
-		return 1;
+		goto out;
 	}
 
 	/*
@@ -779,13 +776,13 @@ devs_only:
 	ret = search_umounted_fs_uuids(&all_uuids, search, &found);
 	if (ret < 0) {
 		error("searching target device returned error %d", ret);
-		return 1;
+		goto out;
 	}
 
 	ret = map_seed_devices(&all_uuids);
 	if (ret) {
 		error("mapping seed devices returned error %d", ret);
-		return 1;
+		goto out;
 	}
 
 	list_for_each_entry(fs_devices, &all_uuids, list)
@@ -801,8 +798,10 @@ devs_only:
 		free_fs_devices(fs_devices);
 	}
 out:
+	if (root)
+		close_ctree(root);
 	free_seen_fsid(seen_fsid_hash);
-	return ret;
+	return !!ret;
 }
 static DEFINE_SIMPLE_COMMAND(filesystem_show, "show");
 
-- 
2.26.3

