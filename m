Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2083E7E2F86
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 23:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjKFWJD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 17:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjKFWJA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 17:09:00 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D3DD47
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 14:08:55 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-49369d29be3so2198995e0c.3
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Nov 2023 14:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308534; x=1699913334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpFp3rJxU7BfJUsZYH5++O1ZuHpoDOwhNYkZxFVciDA=;
        b=PXCQ0Q1jbeyWFNWCy0WV/9gYRme/V4aBu0+1iYsLLZG6KTjLJq+85ALP6XtUccAWJg
         fH0WM53FLREoLfx+Pp9+z62MasBXX2W3QZFRWqoDP8JpeVMgjuvFoV63Z+gWxTQ8VZPp
         HcTphq5pBTML/7Iol12k/OlSNkbcu5cU1S4irQGkIZn8rdDxJDFytuNG1D1PU6bEDPIr
         RYGXWSTKzPOTWsAutxmbkrnLN8b2dFctTGfYSbk+V1A6VSg4qIOKIPHi3AmcgaaS0bQV
         ZhyFM2AZX+SuFhseF1APeV6sfI1i+CyORfL8YNSDhOB2YPzbm76bjABAIrmG5/DTuiHQ
         Y0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308534; x=1699913334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpFp3rJxU7BfJUsZYH5++O1ZuHpoDOwhNYkZxFVciDA=;
        b=mOdMBYLrNcV0QQKy3v9tvG8czwIa1tafgqhvnrWPdM0dN7+1RsJ7hCD2vBaq6XB2+R
         tcHSfJzyTENIAS7BXPDtjn2p32g3EsJ7X2JPvRMj8tSJqQcmZQULfrnTPTDM1x1Yuztt
         yG1gBZT1WS9ZAs7jEahnmEkAkB0SNrq9T+n0wTAeBLraB9JVXkM5IV0U6fA7yuaFxlpJ
         z0FJgkH5z25GTLvgsbMt8uO+g7/4m7jYRkASkESDUOo/WPuxD7RDmw/JJ/bXO7MtZCIE
         wfmioEMdnoohlrjIeB6VYPr3evfAJF7PFB2Oj3BksDd7ZVPRVmqJ9AmzDWS0UtIZWIx4
         ZEJA==
X-Gm-Message-State: AOJu0YzTQ2tSbxoMaKoDXbJ1FMkUVGiPU5e89d0P4WuehOEpwOQfjpp5
        rVgEO7SrwjosLkduyETluu0dMiy/JO11kmCKpn2qIw==
X-Google-Smtp-Source: AGHT+IE1EoDzaK/Q8qpV5gVavwcEqP40pF8KQuhnys9MbBv8qpQ4o3AtHXoqFj5YpNDCygccdvM0nw==
X-Received: by 2002:a1f:2702:0:b0:48d:b7c:56c8 with SMTP id n2-20020a1f2702000000b0048d0b7c56c8mr26020211vkn.0.1699308534274;
        Mon, 06 Nov 2023 14:08:54 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z10-20020a0cfeca000000b0066d11743b3esm3825415qvs.34.2023.11.06.14.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: [PATCH 17/18] btrfs: move one shot mount option clearing to super.c
Date:   Mon,  6 Nov 2023 17:08:25 -0500
Message-ID: <105aa05a5e00e8a7634a28db96532834fe4fc7b2.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's no reason this has to happen in open_ctree, and in fact in the
old mount API we had to call this from remount.  Move this to super.c,
unexport it, and call it from both mount and reconfigure.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 16 +---------------
 fs/btrfs/disk-io.h |  1 -
 fs/btrfs/super.c   | 15 +++++++++++++++
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 50ed7ece0840..8f04d2d5f530 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2929,18 +2929,6 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 	return err;
 }
 
-/*
- * Some options only have meaning at mount time and shouldn't persist across
- * remounts, or be displayed. Clear these at the end of mount and remount
- * code paths.
- */
-void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
-{
-	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
-	btrfs_clear_opt(fs_info->mount_opt, CLEAR_CACHE);
-	btrfs_clear_opt(fs_info->mount_opt, NOSPACECACHE);
-}
-
 /*
  * Mounting logic specific to read-write file systems. Shared by open_ctree
  * and btrfs_remount when remounting from read-only to read-write.
@@ -3508,7 +3496,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 
 	if (sb_rdonly(sb))
-		goto clear_oneshot;
+		return 0;
 
 	ret = btrfs_start_pre_rw_mount(fs_info);
 	if (ret) {
@@ -3536,8 +3524,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (test_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags))
 		wake_up_process(fs_info->cleaner_kthread);
 
-clear_oneshot:
-	btrfs_clear_oneshot_options(fs_info);
 	return 0;
 
 fail_qgroup:
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index e589359e6a68..9413726b329b 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -37,7 +37,6 @@ struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr, u64 owner_root,
 						int level);
-void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info);
 int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info);
 int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 			   const struct btrfs_super_block *disk_sb);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6a9561a336f3..f2c90f022233 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -640,6 +640,19 @@ static int btrfs_parse_param(struct fs_context *fc,
 	return 0;
 }
 
+/*
+ * Some options only have meaning at mount time and shouldn't persist across
+ * remounts, or be displayed. Clear these at the end of mount and remount
+ * code paths.
+ */
+static void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
+{
+	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
+	btrfs_clear_opt(fs_info->mount_opt, CLEAR_CACHE);
+	btrfs_clear_opt(fs_info->mount_opt, NOSPACECACHE);
+}
+
+
 static bool check_ro_option(struct btrfs_fs_info *fs_info,
 			    unsigned long mount_opt, unsigned long opt,
 			    const char *opt_name)
@@ -1902,6 +1915,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		return ret;
 	}
 
+	btrfs_clear_oneshot_options(fs_info);
+
 	fc->root = dget(s->s_root);
 	return 0;
 
-- 
2.41.0

