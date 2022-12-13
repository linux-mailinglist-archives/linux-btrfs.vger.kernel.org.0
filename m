Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA94C64BEFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 23:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbiLMWAD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 17:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiLMV7f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 16:59:35 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2261DDC5
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 13:57:52 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id x11so1028897qtv.13
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bp5Q+pxBm/4wrDqd+V2qPOjs9Ha8xM/Fl/afceInJQg=;
        b=qmILR/MzKgmWQVfLwQn1rzjA5Wx4t9aoLfRynnYezOYNO8azLe+KgO+xTqWTwZGoDt
         nW8MiYS31Lv4TqSeJJ9mlng3wlZh9hh1QeUZRc2Ozv291hdl+gO67Aewysc4prTvmTu/
         TORaebW828T2OVo4uaPINqyh7eoenuGx6wcaowEMZDO/NyauPbbvS5ouMrg5j5Tj/4Ot
         rKiX4Kgecs3Za/yh3WCKfUz3ICOPcaZovB7Nbokp4AEefORRau8oOMbGE5ijKa/LKKcB
         GNC0aFBZy+STVDGMDYlS0vKNmNP2AcD+jctmHhigI6aD0ndxVW+TiQI0bqvRWvSr/w6k
         TidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bp5Q+pxBm/4wrDqd+V2qPOjs9Ha8xM/Fl/afceInJQg=;
        b=BZKgU1evqT53+Pu/bOBIarXcpSgfPbs3FmaqRH+YhIMQ/FkfZC3g1NaddHKjFMD9Zt
         UOQpdvX9lsPzw3ViRe+cmPrKGVTdysOq0TiJGhIrMnLMwCuQJqWHc4fBh1odUJoG1asy
         XYefK5JxI8rXLbjVKW5IsMqD7FtDPLkX9jwaFGt2dKXs9SqP0o39voBCC1gcC03ZAINC
         N/Rt5MLzIl7O/DET0zQsFNCr5HAK0CEA7wIGxQdCTYeQxtmdC4i1vyiP4LmSrGQNkmX+
         Yr9KNdjToHD+zcbuuRbkLiLBrJuKkfcO6IH9R8FjaPxj0n9prtZKaONQmkhqIgIf5kvW
         qmmw==
X-Gm-Message-State: ANoB5pndmiJks5kNlsffpgDsHJDhOw00Ix/Nvz4aDC/9odc7qSqroI4v
        LKj1uQSR2WQTo4+pal24SnWFQ5Paqiaod79l1TI=
X-Google-Smtp-Source: AA0mqf4uzQTFT8M8+CEpRg/Xj42t/wMqHWI4Tzh/diMGrVDehcKNA7hXA0jHkQGEDYWMOUmhhXKZBQ==
X-Received: by 2002:a05:622a:2304:b0:3a5:e9fc:aa87 with SMTP id ck4-20020a05622a230400b003a5e9fcaa87mr7765066qtb.59.1670968666301;
        Tue, 13 Dec 2022 13:57:46 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a430a00b006fa31bf2f3dsm8710452qko.47.2022.12.13.13.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 13:57:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: use BTRFS_SEQ_LAST for qgroups backref lookup
Date:   Tue, 13 Dec 2022 16:57:44 -0500
Message-Id: <d456fe2306107280d66ceaceb8612e85f2a9428a.1670968657.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

In the patch 5850e883cf23 ("btrfs: use a structure to pass arguments to
backref walking functions") Filipe converted everybody to using a new
context struct to use for backref lookups, but accidentally dropped the
BTRFS_SEQ_LAST usage that exists for qgroups.  Add this back so we have
the previous behavior.

Fixes: 5850e883cf23 ("btrfs: use a structure to pass arguments to backref walking functions")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/qgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9e22698ea439..6b5be4a6e3a1 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2780,6 +2780,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 			 * current root. It's safe inside commit_transaction().
 			 */
 			ctx.trans = trans;
+			ctx.time_seq = BTRFS_SEQ_LAST;
 			ret = btrfs_find_all_roots(&ctx, false);
 			if (ret < 0)
 				goto cleanup;
-- 
2.26.3

