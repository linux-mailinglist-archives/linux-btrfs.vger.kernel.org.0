Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04852636D5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKWWiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiKWWiC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:38:02 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1075E9D1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:01 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id s18so11519678qvo.9
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+6H0AtY36YGq4Isf0qYbCclZ5/pEMXkv36lJm2QyZs=;
        b=ggv5xzIgtLR45wQ93MEvXXuAFiLKH11TsjP/A2wkWt57ZDKz0fCMs/soDpF9WlXQYD
         bprpj2tRyfpE6UNTrtchUJZm3srit4SzNlZkLH1P/WMrLI2N+QVaOjT9gmVVX/sHkLff
         L7Ilr41cCns2cY5pJ7QmaTcM4j/9m7FveEEw/AYlIOaRmNkpnBX4/lNPr29OdQfuhDmT
         PXb3mMJNezpYBBMlA6M1IIdqAaN+v8z3eR/ojGomkQUFaROIxYHRYwqlJ4fUXzoRyT0g
         l6Q8gEHpb55xECsINsprks9NehluNr9cDaOeTCp+LGX8WyzOWWk5NWlvkNSXQIyCpX4G
         uyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+6H0AtY36YGq4Isf0qYbCclZ5/pEMXkv36lJm2QyZs=;
        b=uMY2K0AZgRtSw090kl1XvESwYbm37Q2hbZRExqxUg7+D3iZ2Hc+vPkROgjK2SyMCzo
         +U2tVU/D8d2bqVMwkW6r0zSw4CfBvA7QHbi0GdA1+smOls4Z6c/mTR+OePABGn8rcN0X
         2dOAgiOsCUndXgXDguVOsJpAhBnm7xvUrxuWubwka4/LIwZ4hJ3FZ7AeYKPJS39XjjRJ
         4nwtr6J+Z6reYZFebuCJW3w1XkJPbfyExxN7ffCpPgCMtwNm2HT+Q7iPFq5tTi2Bgyly
         FMs062DDqlLv5xPuFZOVDK52YOG72CB/8Czx4+V38RdZ6n1oCW5bH8t+3vcHwyQbsT1G
         /c5g==
X-Gm-Message-State: ANoB5pmZRTZqMZ8zU3yI3yFYb4Tas7Jakm+eOsrLW07wgLfvczEglXaP
        hWIeC5Lntc9GbjnWDf7r2lphK0WVZhXOyg==
X-Google-Smtp-Source: AA0mqf5T+S+edVodbb3zy4r2EQ5PU7PhNLgsjdZ4uMJ3fc3uOM2BatfBZIkr8bayNB6w2YqO/kTA0A==
X-Received: by 2002:a05:6214:2f02:b0:4bc:158d:fae9 with SMTP id od2-20020a0562142f0200b004bc158dfae9mr28715667qvb.22.1669243080284;
        Wed, 23 Nov 2022 14:38:00 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id fd3-20020a05622a4d0300b003a586888a20sm10506476qtb.79.2022.11.23.14.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 16/29] btrfs-progs: do not pass io_tree into verify_parent_transid
Date:   Wed, 23 Nov 2022 17:37:24 -0500
Message-Id: <5d9e5ce4f0a12d98f07b3bbb062246a85091cbd2.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do not use the io_tree, don't bother passing it into
verify_parent_transid.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 382d15f5..8c428ade 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -258,8 +258,7 @@ void readahead_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 	kfree(multi);
 }
 
-static int verify_parent_transid(struct extent_io_tree *io_tree,
-				 struct extent_buffer *eb, u64 parent_transid,
+static int verify_parent_transid(struct extent_buffer *eb, u64 parent_transid,
 				 int ignore)
 {
 	int ret;
@@ -374,8 +373,7 @@ struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 		ret = read_whole_eb(fs_info, eb, mirror_num);
 		if (ret == 0 && csum_tree_block(fs_info, eb, 1) == 0 &&
 		    check_tree_block(fs_info, eb) == 0 &&
-		    verify_parent_transid(&fs_info->extent_cache, eb,
-					  parent_transid, ignore) == 0) {
+		    verify_parent_transid(eb, parent_transid, ignore) == 0) {
 			if (eb->flags & EXTENT_BAD_TRANSID &&
 			    list_empty(&eb->recow)) {
 				list_add_tail(&eb->recow,
@@ -2273,8 +2271,7 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid)
 	if (!ret)
 		return ret;
 
-	ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,
-				    parent_transid,
+	ret = verify_parent_transid(buf, parent_transid,
 				    buf->fs_info->allow_transid_mismatch);
 	return !ret;
 }
-- 
2.26.3

