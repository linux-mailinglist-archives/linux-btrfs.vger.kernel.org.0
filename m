Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784934469AB
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhKEUbd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbhKEUbc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:32 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB771C061205
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:28:52 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id a24so8031921qvb.5
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ErZVnWqW/DAWnHUuNuPwBIBYJTvQHjazs9UpsY0JXMs=;
        b=UgQ0KF1705hUlr81CvRu/zfAGn8yKA14M3e62PIAatZo9njnlfIrgiNHZjAGUUdx9T
         F32w0/XCRNhTPUsSSruemQQgghsjyBzBKBaxdcsyVLsQloQ/Z+xhLrqY498aFGufzDxW
         +3PHRLLIMEUoQJWDQEqeTA9Hu502Z4yp3KfZUDV/x31ZKaNUYN0DZ1386q/f81mg/5v9
         OFvpAiIkc79W4G6O61p9a1tngGe1YivtT4826s/FhGDo9FPC/cqOWI2WeY9JHr/XZZNm
         IN58yogVY7qzWLbDYwugmXNdQSribKNDjua/Df9uZwCdo+NhJTD3LRvTcp3jJdNxvHmi
         UVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ErZVnWqW/DAWnHUuNuPwBIBYJTvQHjazs9UpsY0JXMs=;
        b=dQ6ZMXx7TrFw6fRz0o36Xs3a+oBblqvnay4fncGCyxytPHUSfGSOe7ZMJ838wrYFMf
         +iVFHmhzOtqEl6+otOcLSBE6tPYl18UuMvZWwZ3xQSndDzjeR97sKHevW3YpeUR8/o9s
         a4InNw0XwsnXCa3UQbIHMJH8C7PAuY9++uFmJvNvUo+PfTvMhLVjN6vsRCGHjYdQcveM
         meZAgIREzq3WMLMiv9Rf9fe6lNXYw9jz1KRV6kHT851dI/adOhx6UMspmJX7vTBEYleK
         sgwmD3H3x0smuStGTSPi59VkH6TtL0V6Ebzb89rFzUR69zcJcbHG1ewR3EXOBezk6WHv
         AzSA==
X-Gm-Message-State: AOAM530AZMGRJLABHDmzbjcvbb8/2X4+KyLtYAb2bKZ29WBgOseKRyak
        hvhzh5m50AigBEG7emmwqib5UYAu/XCgoA==
X-Google-Smtp-Source: ABdhPJweMKKniPO8LWuOs8hAgHaCYHTedXDLBjF8LaEIInwKs9hylZx67QQdBKzpCkaRVpHeeGG2Lw==
X-Received: by 2002:a05:6214:ace:: with SMTP id g14mr20285070qvi.12.1636144131560;
        Fri, 05 Nov 2021 13:28:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s16sm4600809qtk.75.2021.11.05.13.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:28:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/20] btrfs-progs: filesystem-show: close ctree once we're done
Date:   Fri,  5 Nov 2021 16:28:28 -0400
Message-Id: <a666deeeb9a7f9194406562ee8ef632f1852b4bd.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Running with ASAN we won't pass the self tests because we leak the whole
fs_info with btrfs filesystem show.  Fix this by making sure we close
out the fs_info and clean up all of the memory and such.

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

