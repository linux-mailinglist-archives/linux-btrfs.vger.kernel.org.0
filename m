Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152814D0B37
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245593AbiCGWiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343867AbiCGWiI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:38:08 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6DB6158
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:37:13 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id t18so3716505qtw.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8xs3unOqTZ2OaFdfSYYysocG7EJUvUmZ2ukGM5xN5aU=;
        b=2QmpzGgKL76SGEjUrsgcH9Htx7HdbTLSS/M2x4edVG+T6FuaGLTjAzp3ykCn0bzHAe
         jERms425InBAZDlJ+zCfLtdYWBSwpyfYdlMdrAkgwntFSM82UKrBFdBEYdl5t8b9pB38
         UF+deR1jAPvOEKSgSLpPhYKJwJTTfPVwNf9R1Ap5p6QeURZ32TGSCTvi8uw132iqnB3c
         AokXRZEK4PCjVDuTF4toPMBj4MyoN1/H2u0GTj0uFhi+6KEkes7MGct85fPnihaM/jxF
         WEobk6VYQe3l09W3FDdMG3ZobkPeUSQc01MramT3Bs1nklwPQqP7S7R2JUNsqdMpECHm
         Bc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xs3unOqTZ2OaFdfSYYysocG7EJUvUmZ2ukGM5xN5aU=;
        b=0/oC565JsTfKgAS0znfH2jgWB643TIHrMPv6SFAr5bZyF4AfTn6ytk4nEOEUed7q4A
         13JJDaa8yWpnn+vGBjBgav+ROh1ByorgPMmV8rHyKvaQHPYrOY3w/ZCmJJHHE2iCYjHW
         GQRdR1A77VH8H7x6Ek0ZRJQY2ATE4fFvBgZYQTjsNIQpgpJ2AxA1MdlvypfKR10TpxeL
         a0AuWG5qkOosxQfRVgnBP+gl8w8nV/fasi2okFd+OHkkvHajlvbTfvYHicHRzF63OuLk
         otG9BlVeJfTnhg3842ZynjxqmzDbvdxW6YgNy8FmWqElQsGRQe04HFs9jOewInsW/GWy
         ukVA==
X-Gm-Message-State: AOAM530f8yLHIypKb9VdGLLryd2aEnk8xX8XFjyhJEr/9afxbAc69wRG
        HeCH4r5NtL87zEdx9iJDFE6Chv8l/DwKdxYo
X-Google-Smtp-Source: ABdhPJxBQNHwc3g/rn6YHX/ha1WeAdbG+9HqmMa1Qm1UNVesj8wGqP919lpbCtGrD8UOSaO3dJIsVg==
X-Received: by 2002:a05:622a:648:b0:2df:f368:e12b with SMTP id a8-20020a05622a064800b002dff368e12bmr11299568qtb.226.1646692632670;
        Mon, 07 Mar 2022 14:37:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e9-20020ac85989000000b002de2bfc8f94sm9205657qte.88.2022.03.07.14.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:37:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/11] btrfs: zero out temporary superblock buffer header
Date:   Mon,  7 Mar 2022 17:36:57 -0500
Message-Id: <5f0d31d6299aacfce2df98e338afee2c20dbdb51.1646692474.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692474.git.josef@toxicpanda.com>
References: <cover.1646692474.git.josef@toxicpanda.com>
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

We use HEADER_FLAG_V2 to determine different offsets into the buffer, so
we need to make sure that we clear the header of the temporary
extent_buffer we allocate to read the super block in, otherwise we could
have this flag set and do the wrong math for the different item helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1be7cb2f955f..fc2d3db8e539 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7403,6 +7403,8 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 	set_extent_buffer_uptodate(sb);
+	memzero_extent_buffer(sb, 0, sizeof(struct btrfs_header));
+
 	/*
 	 * The sb extent buffer is artificial and just used to read the system array.
 	 * set_extent_buffer_uptodate() call does not properly mark all it's
-- 
2.26.3

