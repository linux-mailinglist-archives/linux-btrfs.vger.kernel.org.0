Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA15F7E2F85
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 23:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjKFWIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 17:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjKFWIq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 17:08:46 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3B1D75
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 14:08:41 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6ce37d0f1a9so3168422a34.0
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Nov 2023 14:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308521; x=1699913321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6T94WyWk3Zy26jisioKXt/NF7e6EzHgDufMAJz5NuM=;
        b=hW7JSU2XPVE4h7T/hFb2gkLHehvl63D14CVeDZO4QdfPvaLUGh2U1DE8RnD2NC9Arz
         fNuMA45/uOZkklxeocim24ngD7RsxIQYaSFGLmnLI3Zvx6qlzn2Kn0DjVNOt6+tc8q05
         i2SrbkLYA+JGq/bFMXCr3gE+AOp4TizT7K0zMA3qBV0i5JgKTaOE49gvlVk/puVVrRo+
         MEP08tZaAb5fC1q4gOUCQtZ5tr4BH0e9knsDf/UlVeQxC69xkBieT8pVDq9VfDzcgpkk
         SW9OT5Izesk4Kb2kxHtIehkOFWHOL1eKg+ipAdHgOv+GqiOFpYZ5MxRW5Mqr1cDQgT8y
         YBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308521; x=1699913321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6T94WyWk3Zy26jisioKXt/NF7e6EzHgDufMAJz5NuM=;
        b=fyUMZ/B/kWjQt+W5ChA+/l69wACBIGtg9/2eSY5CvRJpc11C6xXl0+UDHr4B6UezOP
         2k25VPepI+N98BsxruQ2RszU7VH/GwlxSXCllUUe2ahu9dvRIBfR/MY8870d9AgtQU09
         aML//xpT8T1MrDenU6wk4rBogxZ0GYxADauWHbBvlek2fsjLL8Qclyy1Er+DbSAz7TY7
         7PQfTCNlJgC9UeH7EHp4SoDigBbralSEA0eGd+4+BTlFGeDA8lKBXqLeHeQ+gzligRXB
         eSrWRGfUrqnDkOIzLsjjc6aibYiiJNpxegmf/1IZXyI8hGMgmq8MyFRifBkMOaZ1Y3Pb
         D0Yg==
X-Gm-Message-State: AOJu0YyBvj85Ki5Q0Anlbm1O5+H7WJotKH5o7nfIt/nFWqjjZlQuuwmU
        JGUgkOhYqmb4ehfpMM6EiUi8ShQjYXdfrkApMpQ1Yw==
X-Google-Smtp-Source: AGHT+IFf5q3nHxRPUyYMj7n7bYDMtzLSSCOnnSKvWN4mZIj4cNKJ6+P4Po20QjIkN/mV2dU1uu3A/Q==
X-Received: by 2002:a05:6830:438a:b0:6d3:165d:f19c with SMTP id s10-20020a056830438a00b006d3165df19cmr24314205otv.11.1699308520924;
        Mon, 06 Nov 2023 14:08:40 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d18-20020a05622a15d200b0041e211c5d0bsm3772506qty.6.2023.11.06.14.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: [PATCH 05/18] btrfs: do not allow free space tree rebuild on extent tree v2
Date:   Mon,  6 Nov 2023 17:08:13 -0500
Message-ID: <2d268c17698104d5ae0b1d355a10ff20223b2bff.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We currently don't allow these options to be set if we're extent tree v2
via the mount option parsing.  However when we switch to the new mount
API we'll no longer have the super block loaded, so won't be able to
make this distinction at mount option parsing time.  Address this by
checking for extent tree v2 at the point where we make the decision to
rebuild the free space tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b486cbec492b..072c45811c41 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2951,7 +2951,8 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 	bool rebuild_free_space_tree = false;
 
 	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
-	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    !btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
 		rebuild_free_space_tree = true;
 	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
 		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
-- 
2.41.0

