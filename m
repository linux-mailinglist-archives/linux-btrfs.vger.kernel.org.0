Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C617C4198
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344018AbjJJUlt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343967AbjJJUl3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:41:29 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D798CEA
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:26 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7b91faf40so19281747b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696970485; x=1697575285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncefcNQo/6u3yr6RKhoA0m0GLVQ1MY8hnt6OMBhNPts=;
        b=lXPtO989sSG987fR0CX+DyfFgw7plP9LQGDEeyL2IIiippkZ8Hn0pP7IirtdYQeuYs
         Ra8QnhAISzBiVDkPGLL11s8uptCWjoPer/PwoGCxpL4iD9mmQkd7sQQFARkTwhUv4l16
         tPf8lShwNsWhuXBVIh217L/nwNxqZl0qRHzHe7LvplN5VHf4bClZhstPHrzTyeWC+lSK
         Q6vWzCZrgw1qNEULfPcQYi4U2TYju/T5yfoDQy3eedBxTYRDk3C8GiTA+q7NHMFFNk/o
         F8VVSusQX7hAUU+qCCWeHt4BAzgTA3NaHa6iyCDQqCB48rNLR8kPWPoAQmDf/w+rlmRr
         6jlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970485; x=1697575285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncefcNQo/6u3yr6RKhoA0m0GLVQ1MY8hnt6OMBhNPts=;
        b=V6Qpho6WrIT9fg1TRzEPgfnX/zTYHlv3GKBs/yNX9GC4nQJagt/1NWWtC84hIHG6qC
         YX4SYtK+wlvN0AJvINvRPg6Sc/HDpyKIDsdJiTr+rbikMfPtVJ2GZ9ixsyicKLOCJOaI
         3t3avtkWb4YXzQ6rMHMD2uGfYyoE/ug6bAv36d0tck1BqW0EQsmA//DAWcAg8RFNWmVY
         YWUTQorP5iqBYyf4dZX4RrRUKUVot1sTpoCQuQh+PUesg4bpO2Lh6WblIlMHVZPpvGoM
         XM7m2wnFmKUgG9wvFJVPongFrk/Lsy6D4mZJ4IVx2yuIFl2ul7oNk1XfErhk4HFSN7/l
         Ufmg==
X-Gm-Message-State: AOJu0YxprrbPYR3Wfj7fanYIcBuIVUi5uSJfvhodY+AH2m5Oy6pyRmbD
        YFttn9EU43BCA0RheKx+P64EUQ==
X-Google-Smtp-Source: AGHT+IGI47BK/YNWxhDw3A3V3kdysgH8sid6WO69cVWJTKj4MpY2+819JDrDUgrEwfmMQeKrDmj00w==
X-Received: by 2002:a81:8284:0:b0:59b:c0d7:6766 with SMTP id s126-20020a818284000000b0059bc0d76766mr21450605ywf.37.1696970485395;
        Tue, 10 Oct 2023 13:41:25 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r5-20020a814405000000b0059bc980b1eesm958495ywa.6.2023.10.10.13.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:41:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-fscrypt@vger.kernel.org, ebiggers@kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 19/36] btrfs: turn on inlinecrypt mount option for encrypt
Date:   Tue, 10 Oct 2023 16:40:34 -0400
Message-ID: <65b4dedde4b0e52b7e1d7980e4b205ab8b313939.1696970227.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696970227.git.josef@toxicpanda.com>
References: <cover.1696970227.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

fscrypt's extent encryption requires the use of inline encryption or the
software fallback that the block layer provides; it is rather
complicated to allow software encryption with extent encryption due to
the timing of memory allocations. Thus, if btrfs has ever had a
encrypted file, or when encryption is enabled on a directory, update the
mount flags to include inlinecrypt.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c |  3 +++
 fs/btrfs/super.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c56986031870..69ab0d7e393f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4587,6 +4587,9 @@ long btrfs_ioctl(struct file *file, unsigned int
 		 * state persists.
 		 */
 		btrfs_set_fs_incompat(fs_info, ENCRYPT);
+		if (!(inode->i_sb->s_flags & SB_INLINECRYPT)) {
+			inode->i_sb->s_flags |= SB_INLINECRYPT;
+		}
 		return fscrypt_ioctl_set_policy(file, (const void __user *)arg);
 	}
 	case FS_IOC_GET_ENCRYPTION_POLICY:
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index bacf5c4f2a5c..224760cc72b6 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1124,6 +1124,16 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
+	if (btrfs_fs_incompat(fs_info, ENCRYPT)) {
+		if (IS_ENABLED(CONFIG_FS_ENCRYPTION_INLINE_CRYPT)) {
+			sb->s_flags |= SB_INLINECRYPT;
+		} else {
+			btrfs_err(fs_info, "encryption not supported");
+			err = -EINVAL;
+			goto fail_close;
+		}
+	}
+
 	inode = btrfs_iget(sb, BTRFS_FIRST_FREE_OBJECTID, fs_info->fs_root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-- 
2.41.0

