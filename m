Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEFA7E2F70
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 23:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjKFWIk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 17:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjKFWIk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 17:08:40 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D633D47
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 14:08:37 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6cd09663b1cso3176162a34.3
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Nov 2023 14:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308516; x=1699913316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tm+FRJ/W+NXgd6Kwdpc/Qv1uQRM6BXRjdtybkaEGYq4=;
        b=qbobeG9xGxap184SxHyGKgyGq2PgyS6IpoWlojmwYfDuh3dn00WHg4W8ucCbcq2+ug
         jPPEQQRxoPpmmPkruCwdmTI9bAY4mLVzW3g2y8m/TvZugY5MKdSooovR/zz6D3vfoWEf
         iCAi20t/6gzW1ymaXBRPfbu1Nv806mksHMgL3soRLo88BEFMNcY/CvIt7jU/E2YuTlPW
         YbKhIAvYxSSLpYbmjaRDNCvzwKDnth12HlWljgUn4u5kQPSrrfgLmQDAZDa2yyeCdzq6
         aW1dJXfVN7BO9opBONdYZluLpPrZ2KPhe5U+PLg8LqO5rlj/jeXlBdgPA+YKRR+B2QHi
         SpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308516; x=1699913316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tm+FRJ/W+NXgd6Kwdpc/Qv1uQRM6BXRjdtybkaEGYq4=;
        b=TfFDL1MZr2WnL0xq6liOv1D+OKoosVPJouQYh4fq5ASHVDBxGBJJ8n8HvyN+lFYAl6
         1Fa1QXWzZptPIxHHEEac20NahOI/EbUB2BWk375Hoz97SjVxII/2ndjGzfNfnjfWkP7r
         KMWON8l21HEK/YKzXPUQlfHUe+V/IK/GKFRWajsupKFgdX2ETi5uP9cwrb05W4jRY/Qn
         f118+b7etyzDyBVoyYtXwxpoBhA/oltj6xNhoC600GRW0zx9VZPNYIzIkU+zhhZ6Keri
         YJw//aHluGZ59FpBWeQuwX4mdZrmPFd7+bqSG6QwQJGjUudW53LAT06TRcYrOYUrozRa
         t9ug==
X-Gm-Message-State: AOJu0YwqGZ4zyCfk97JPDrwOwZDdJbH5C4d2u0j1SHCbI8MhYABtf6h/
        jX+yUxJuIDFdZSE6bnLdypc5qhVz7wXavbZAWkt0Dg==
X-Google-Smtp-Source: AGHT+IE8UYS4BfJoDg85VHDCQdvWtIH0Rgry8aTYWqwQxNAxbD70mCkr6GJphA7w4l+kl1LzcZM44w==
X-Received: by 2002:a9d:6657:0:b0:6cd:a63:6ed4 with SMTP id q23-20020a9d6657000000b006cd0a636ed4mr28750100otm.14.1699308516501;
        Mon, 06 Nov 2023 14:08:36 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p16-20020ac87410000000b00419732075b4sm3760788qtq.84.2023.11.06.14.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: [PATCH 01/18] fs: indicate request originates from old mount api
Date:   Mon,  6 Nov 2023 17:08:09 -0500
Message-ID: <75912547b45b70df4f5b7d19e2de8d5fda5c8167.1699308010.git.josef@toxicpanda.com>
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

From: Christian Brauner <brauner@kernel.org>

We already communicate to filesystems when a remount request comes from
the old mount api as some filesystems choose to implement different
behavior in the new mount api than the old mount api to e.g., take the
chance to fix significant api bugs. Allow the same for regular mount
requests.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/namespace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index e157efc54023..bfc5cff0e196 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2873,7 +2873,12 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	/*
+	 * Indicate to the filesystem that the remount request is coming
+	 * from the legacy mount system call.
+	 */
 	fc->oldapi = true;
+
 	err = parse_monolithic_mount_data(fc, data);
 	if (!err) {
 		down_write(&sb->s_umount);
@@ -3322,6 +3327,12 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	/*
+	 * Indicate to the filesystem that the mount request is coming
+	 * from the legacy mount system call.
+	 */
+	fc->oldapi = true;
+
 	if (subtype)
 		err = vfs_parse_fs_string(fc, "subtype",
 					  subtype, strlen(subtype));
-- 
2.41.0

