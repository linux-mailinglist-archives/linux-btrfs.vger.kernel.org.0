Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01C3449C69
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbhKHT3k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbhKHT3j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:39 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA35C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:26:55 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id br39so16527154qkb.8
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BOUE7wzYiP49Wf9ee/1TVE4FBYic7xZ69o2T50x6XU=;
        b=exHcI9k/NlB/OuYtr+V6SXvs4Ec11+ws8BVTwZ139++X8lrhCQHmhRh5MRqQgIX2bP
         EIWsVL7RpGC4dLJKNEZFSGfj0NmJ2RpyVhW0rIEphIEHItIZrjoZv356KXpZ/pYtJ4FW
         +Fw6PlNpDvCsIwgSd3KYTpQv3rVqBtuZOGVImu5meWdZ8sGHuq8dDa5NHsnLyuuN06xk
         Q2t8uD9gOKktEikvEImusMlk0zdJdEdNaYtvsm4UG/e/LYYYscA3bz8ZgwnWn7aV22Qi
         iCvsNturoLsl5jnubgjwaZc+WSux0EOIh/SCzj36UeIpy7ZtJ8naBrDrnVoUOdLXwki5
         hT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BOUE7wzYiP49Wf9ee/1TVE4FBYic7xZ69o2T50x6XU=;
        b=r2B0GtcJwfIBiOU/zNoJthqZuMijHJWN+UMeeetGpqAHUsX0jH2jgwPCCIyvI2Sqff
         N17v7SDCIM50qQbIJnQse05LT2OETORq3PrLyaRtznaLGb1bvMKpMXLrbDQDKDF8Mj9e
         xaq8l/t0yDuoAQJqWIWNehmwEoBnc8gcbweLsIbYbVAg+/V24lTTa6ZKA69gJmaz9MJl
         Xf5mNpICd2WOHeYmWY6qQdWCUVSXPdy/u1bbsE0YDIrZRNtxnsnpzvGLM3ll7o8d9pdJ
         ry6Vvbde17x0g+HNsqKsD2ya+vjI//Dsr5wXLEqEO5tHICUt1SAVKYguCCI6ttI+vJA0
         GScw==
X-Gm-Message-State: AOAM53026vNk2+ud6SEjvdV4BBLBX3Hqr3zYJNPyP4LkPrzm47Lc7xka
        7KYKmuUqR+9Y3GXFO2RPQES0f8b4QbjY0w==
X-Google-Smtp-Source: ABdhPJzs4c+CY+3Zpa9stoBF8puf5twTc03ALx1pFYXRBB47e3IuMSLpNHCqdp5dGp+OHq3riajYeQ==
X-Received: by 2002:a05:620a:2790:: with SMTP id g16mr1168655qkp.403.1636399613975;
        Mon, 08 Nov 2021 11:26:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id de37sm8284956qkb.117.2021.11.08.11.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:26:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 03/20] btrfs-progs: filesystem-show: close ctree once we're done
Date:   Mon,  8 Nov 2021 14:26:31 -0500
Message-Id: <a6c023d896eb5932adc34b08b0b9546dab210d2a.1636399481.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
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

