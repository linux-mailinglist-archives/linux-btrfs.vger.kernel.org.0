Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABCF7AF223
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjIZSDm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjIZSDj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:03:39 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B2B136
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:32 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77433e7a876so284184785a.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695751411; x=1696356211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFmLojnAQHX9YXUek43MmCebXJuRqe4GXtQt5j98L5c=;
        b=PfBq3zaZ0pBC1BrJyRE9dW5sYMqAeiiHWww56Dp6EH40n6Ck2eFifE81k0Z1XBxclK
         5Ip427Pne1SRRqDncudKBWY/x4kJ0wXuS197uugNB47oNIFtyfcZvCU0HBcxuP8boSD3
         e/ZN/BM4kx/0OYgsN8BLb+91LvSgQD0kX5GHuRiJN4QWFQ0uaHMDMrUB5R6XiqkcvP6p
         7v/I8mhMuVlx+H8upcFH3I1hWLrR4Px2XeXQyxBFTyKrXzNj7p1DMa2eV2j/CXHXYcb1
         FmQpMyXD+v7MLPkdMfU9KL3rSC1ldKDs34t5K6yz9rh/6z/XR3A+6dpwExaHuuxXtvbS
         wMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751411; x=1696356211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFmLojnAQHX9YXUek43MmCebXJuRqe4GXtQt5j98L5c=;
        b=cLMDn7BKOd1fUJwcQSXtQtzKDQm36uTR1NoGXZ332RjwhRebVqUxegeOjapqaADuv6
         RYOkHg7TFu5ogu42Si4GLpv7evEJwGzv9v4dMmz/DlTxOgnR8/IpTRJv8tRJVC5zBOqJ
         PO+6AnxdlodEVJ+PmDZp9ZKiXuCe44JDk6h2VLOapJN75O2WicqY0YqVsYLONyBx6kTE
         PIudOb1naSrGeDu0MICwIKno4xf2qz284nVUJK4s9O3ZqxFiPKIdERvS39VXTO8bh27T
         HilOGZ6QDsHs02vuZyxto8eyViGF/SKt6gKv7M2KTReAW5AzNjQPTJm/30zbhMF2mo1L
         +ULw==
X-Gm-Message-State: AOJu0Yxqym+BxIX0V/c478u0lmQz66ewbD+PsHoWaoRVddRNadIhe980
        nNF+RHN/jCMD4slcTqwIU5Mc8OWJs4GXI46goF43pg==
X-Google-Smtp-Source: AGHT+IF0jSltUuviG8KvY1FN5h0GExlxFexp4nMp13D6VaWn7ON/O1uWrDh6lZh+i7fEv1MXko7mZA==
X-Received: by 2002:a05:620a:1a87:b0:76f:f64:58bf with SMTP id bl7-20020a05620a1a8700b0076f0f6458bfmr12674146qkb.18.1695751411725;
        Tue, 26 Sep 2023 11:03:31 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e15-20020a05620a12cf00b007756d233fbdsm379708qkl.37.2023.09.26.11.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:03:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
        ngompa13@gmail.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 16/35] btrfs: add encryption to CONFIG_BTRFS_DEBUG
Date:   Tue, 26 Sep 2023 14:01:42 -0400
Message-ID: <1b65ae762b4039cada3f29b996de690b34aad0c1.1695750478.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695750478.git.josef@toxicpanda.com>
References: <cover.1695750478.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Since encryption is currently under BTRFS_DEBUG, this adds its
dependencies: inline encryption from fscrypt, and the inline encryption
fallback path from the block layer.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ddc2d2c7fc7f..8e5f9dbb547a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4587,6 +4587,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_fslabel(fs_info, argp);
 	case FS_IOC_SETFSLABEL:
 		return btrfs_ioctl_set_fslabel(file, argp);
+#ifdef CONFIG_BTRFS_DEBUG
 	case FS_IOC_SET_ENCRYPTION_POLICY: {
 		if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
 			return -EOPNOTSUPP;
@@ -4615,6 +4616,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
 	case FS_IOC_GET_ENCRYPTION_NONCE:
 		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
+#endif /* CONFIG_BTRFS_DEBUG */
 	case FITRIM:
 		return btrfs_ioctl_fitrim(fs_info, argp);
 	case BTRFS_IOC_SNAP_CREATE:
-- 
2.41.0

