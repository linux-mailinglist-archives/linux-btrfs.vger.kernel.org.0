Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0F77CB262
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbjJPSWm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjJPSWc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:32 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AAAED
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:24 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4195fddd6d7so40975841cf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480544; x=1698085344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i20kOvsTj8UHy3VlsyWZ2ukU/TrpdD90cKWJsB2jbGw=;
        b=VDjo95HFOShYiI6UokP4JRbGrqQXTwJbxA/AmCsIlPKCYD6fytqYNg7GWPmhHm5obF
         4FojZ0BFFNEO+XQhFtIsSD3n4EcyeYbbm1WsU4p1ffAZ4bHsmNueuV1wAcNBl/Y4imiL
         UxAm96Ib6NWnPkYy3xOEaof8P3aRf+2H+8QjFGPHHGlrRvsSz//yU2vgXGkf+4AUxrvA
         rRxen3oG4v1mUeoOMerPX/2MdRu55YylKhOKsFbLY7jKuApIgyrWdeDGK4/CwNIK1p4P
         yETFKO42Jbl6R5W0zawMtjuoURuoPN4fBaoKxXeBvLCs/Y3I2fGTyY9XGu3qvBE1VQoN
         cncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480544; x=1698085344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i20kOvsTj8UHy3VlsyWZ2ukU/TrpdD90cKWJsB2jbGw=;
        b=FYbVLWpj09KFlKPqBv+mMpATcncn50pZSUo78c3T9tOMJVsDtik319/Xkfr3mMAFks
         1IfTsXcS6SNmGmarmJLTQCXYL7M3+jHjGHKYqqQf6g4HRIpm4Z031oiyZxZUJj9eFDBF
         UjHY76ZDG3e/IRmOTZkzxR70AjAxBtTX0a0m5Rb4TyoR7faiXgM83ko+uN/ggzdsE6dP
         dsKHcRahFuWzi9B6/xdLYhpfE8OI+Fc7zEUzdlMn2Bt0lrayWInWgCeSmqVtr0OIB8f0
         rQs/vj1sUPue5llbfCJzy8qo3HZxfM6pR4OIWHfMhCs83P1J0FWMP+hJBkUK8513s9mC
         sIUg==
X-Gm-Message-State: AOJu0YxjXnXeWNoa50br+R4hroqpOH6kX/bcrd60SvFtbtHkhj0mfkrB
        shD5RZQ47ooUieNNdg2INu/HlAQKRCoIJhouq9wWFg==
X-Google-Smtp-Source: AGHT+IGqWn8U9YlHW+bEvPCPkzoLz1iyM3DW2Rln09T24r2W8I6cYL1UlqQBtO46faXNL0GmndU1Rw==
X-Received: by 2002:a05:622a:44e:b0:403:a662:a3c1 with SMTP id o14-20020a05622a044e00b00403a662a3c1mr11720758qtx.29.1697480543852;
        Mon, 16 Oct 2023 11:22:23 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e18-20020ac86712000000b00419b5274381sm3198742qtp.94.2023.10.16.11.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 23/34] btrfs: keep track of fscrypt info and orig_start for dio reads
Date:   Mon, 16 Oct 2023 14:21:30 -0400
Message-ID: <11ef076069f303a41e846c3dde35b9d401cd94f9.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
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

We keep track of this information in the ordered extent for writes, but
we need it for reads as well.  Add fscrypt_extent_info and orig_start to
the dio_data so we can populate this on reads.  This will be used later
when we attach the fscrypt context to the bios.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7d859e327485..d20ccfc5038f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -83,6 +83,8 @@ struct btrfs_dio_data {
 	ssize_t submitted;
 	struct extent_changeset *data_reserved;
 	struct btrfs_ordered_extent *ordered;
+	struct fscrypt_extent_info *fscrypt_info;
+	u64 orig_start;
 	bool data_space_reserved;
 	bool nocow_done;
 };
@@ -7727,6 +7729,10 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 							       release_len);
 		}
 	} else {
+		dio_data->fscrypt_info =
+			fscrypt_get_extent_info(em->fscrypt_info);
+		dio_data->orig_start = em->orig_start;
+
 		/*
 		 * We need to unlock only the end area that we aren't using.
 		 * The rest is going to be unlocked by the endio routine.
@@ -7808,6 +7814,11 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		dio_data->ordered = NULL;
 	}
 
+	if (dio_data->fscrypt_info) {
+		fscrypt_put_extent_info(dio_data->fscrypt_info);
+		dio_data->fscrypt_info = NULL;
+	}
+
 	if (write)
 		extent_changeset_free(dio_data->data_reserved);
 	return ret;
-- 
2.41.0

