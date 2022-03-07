Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EC74D0AB7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbiCGWOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244935AbiCGWOe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:34 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE7656405
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:39 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id a14so1687281qtx.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rTQP5MTYR9uYmxziQv7fbj2wYYhvTPa7unazeeji48g=;
        b=mewK8awPhMuKkjveZBmL5u+O2siaFYDVaZBc9K0f6Mlzb9UR5jph98L8KJnljSZLCv
         iZDhvW/JaRU7YdeNGyVfeZEb3ammXVMvifVsZ0J/wOkfYqzuscDnKSRcMye1rLM6Y9ug
         f56IBRm1fEC9anzHuJjY9OqaAR/3lSDdq3oFNityi92/747FjhmMnb8QUt9i+5/fi9qC
         J/nQnaXdRMwMz05WxVV/52meOWuNYW9AmHwtvjMUYm4QZXAXsxeu77nChAS2439fP0DI
         GySYBVZHL5Co17QOBHB3MxnWjk55YC6+OM6+wAdKqvBnvpdl6ecbhqEo0IiSHYbY6HJd
         fr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rTQP5MTYR9uYmxziQv7fbj2wYYhvTPa7unazeeji48g=;
        b=K5FwGdKgnULnEKhARFNCM6jQsvYYRNo5WR4W+HJ1Y51tkal0hxOkW8Z0yoopx3H240
         wlnHlGAeCmJJ3Xz/+Kut9DpXC60Wt8hqVcMKXTlFzZIryT08rJhvGCwYWEBqeNtp44c8
         d6McUk4kCoK9Vb387BoC2wBKwrN+q/wIsA45iFwhanacwLU86S7uzw02eD1zPVgHvkQ/
         IYg31Cx6WlRP3xoiSvJ7K82WwpEJjfRjewI+C215p4/WUiCNs7sZaTjrWkvOKHE5dMfv
         Ax4SexI/Rt4wnhJPubwBg4v6XpdPxKtbQ/FSvZOxuGsGE5GhrWrf2GQJJRfq7jubOVX6
         wsRw==
X-Gm-Message-State: AOAM531RP0SAi3gkeinZ1z78dQ44dEUafACoi/o/nhC7EZeehBca4XUC
        NQIar7YAcdOVFwrHfwJNlYQ8Iad1yu5NDveO
X-Google-Smtp-Source: ABdhPJy8Do9IllC8So4IwCoQNQlG6a+6QcfZOYqOBIIEyLWWYj+9BJKGi6PW84wXc0ba/K7xc9bRPw==
X-Received: by 2002:ac8:5ad0:0:b0:2de:3cba:cefc with SMTP id d16-20020ac85ad0000000b002de3cbacefcmr11011132qtd.584.1646691218197;
        Mon, 07 Mar 2022 14:13:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z1-20020a05622a028100b002e06cd1f623sm1230590qtw.9.2022.03.07.14.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 11/15] btrfs-progs: make btrfs_lookup_extent_info extent tree v2 aware
Date:   Mon,  7 Mar 2022 17:13:16 -0500
Message-Id: <ed03438df3c31ebabbe1c1f26c57bf79d150f425.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
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

We do not have flags or refs set on metadata in extent tree v2, make
this helper return the proper things if it is set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 8921dd07..933e8209 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1309,6 +1309,14 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 	u64 num_refs;
 	u64 extent_flags;
 
+	if (metadata && btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		if (flags)
+			*flags = 0;
+		if (refs)
+			*refs = 0;
+		return 0;
+	}
+
 	if (metadata && !btrfs_fs_incompat(fs_info, SKINNY_METADATA)) {
 		offset = fs_info->nodesize;
 		metadata = 0;
-- 
2.26.3

