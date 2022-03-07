Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17E24D0B2C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbiCGWeu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343794AbiCGWeo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:34:44 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE35C86B
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:33:48 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id e22so13256727qvf.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BWEnemSfuhREMgwxi4DwFaLVF2gKbY77x/JoJSdFd3o=;
        b=hE59fAc2kCjDZxnzF4Y9KsQQOj4eTE8efv/5KETc63IBzAvlwflC3J4yoXhw498FD0
         EKpoVClw7Dn8hi5AMuyN3lV6Bdr5gdSXgtYKO/UvCGXQ4du5BJJo7R+HS5SfShkLu4Zc
         F9C/b+bsU/h/iKDh+d6ESIF/jOCzARZuwy4C3QJ7kvW1Xvb8DCwIuyg0Rzrb6Y/6x6xf
         QoZupC2BTYovqnTR7IGDM9UtXqnUzRinYerEIlXtvhIDpn5/kcl0ku0aTAeDOzzH+pjB
         +exJWSS6Vu1N50NzMBKYMNV00wimSov0OJt7jx92pQ6+bWgx+oYMKPBSID7NDD45FaSJ
         8RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BWEnemSfuhREMgwxi4DwFaLVF2gKbY77x/JoJSdFd3o=;
        b=pfzOiB6/NjxaWuBOTKDznafzAbJUTsCO3LJGDWvSBFyfjCtoadOxI8uDp/+AqRLGmk
         zmjVplfzC8j6cbi2W2vNG3GZKWXQ5SEpwsMLyCldUUWACaI8KGR7j9NMCP4p9+rCHVBU
         38oIPOjSUy1MKC5bp1crSiyPbKUwI2she7BpSKSZJnfwoIFWssqMcrtkllrYwjEwMYRc
         SmMB4zhHJIt1Kh3SSxhDaa0kOxgmxwGvxvDf1DYU0w1Xdgc8nf9ve3F5XQben/YSRPMh
         1IXqxYGrE/Otg53dQTjwasxP7wwvRts2ZmfT2evBIoXJt5aIQ8Wx3VUiEHTiWjtjShhD
         TH8Q==
X-Gm-Message-State: AOAM531nDrwMaWiuB58gGPLz3ctHMfmPsMbKh4ec4eXjGfAZnXtZrBCZ
        hjYBF0/Xk43dvlYFnPo8Iu1Mt9HEuKik/WUQ
X-Google-Smtp-Source: ABdhPJylhV+3XhEctT1nvSYyaI2cZWN9vYZsV6XwSfGDLjK+tzVvyyTyRxTInnMbrOEzTaKBXh/SZw==
X-Received: by 2002:ad4:594d:0:b0:432:875a:ee81 with SMTP id eo13-20020ad4594d000000b00432875aee81mr10423398qvb.23.1646692427856;
        Mon, 07 Mar 2022 14:33:47 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g14-20020ae9e10e000000b0067b520a01afsm723479qkm.108.2022.03.07.14.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:33:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/12] btrfs: const-ify fs_info for the compat flag handlers
Date:   Mon,  7 Mar 2022 17:33:30 -0500
Message-Id: <df937c197eae36770e2cb47a32339da7eddb3d48.1646692306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692306.git.josef@toxicpanda.com>
References: <cover.1646692306.git.josef@toxicpanda.com>
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

We don't modify fs_info here, use const.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8187e8ec457a..ec77871ad839 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1796,7 +1796,7 @@ BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
 #define btrfs_fs_incompat(fs_info, opt) \
 	__btrfs_fs_incompat((fs_info), BTRFS_FEATURE_INCOMPAT_##opt)
 
-static inline bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
+static inline bool __btrfs_fs_incompat(const struct btrfs_fs_info *fs_info, u64 flag)
 {
 	struct btrfs_super_block *disk_super;
 	disk_super = fs_info->super_copy;
@@ -1806,7 +1806,7 @@ static inline bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
 #define btrfs_fs_compat_ro(fs_info, opt) \
 	__btrfs_fs_compat_ro((fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
 
-static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
+static inline int __btrfs_fs_compat_ro(const struct btrfs_fs_info *fs_info, u64 flag)
 {
 	struct btrfs_super_block *disk_super;
 	disk_super = fs_info->super_copy;
-- 
2.26.3

