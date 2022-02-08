Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041694AE244
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 20:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386099AbiBHTaV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 14:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386123AbiBHTaR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 14:30:17 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C687BC0612BF
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 11:30:07 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id b22so14579987qkk.12
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Feb 2022 11:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3XGYL9ZUcnrr/zboBZqzQdx0xhS1t/G3PunWu5ada9c=;
        b=7bO5GqJUk4g9AOJL+YVIRDowOjO/jUKrTTr1SaE0XbMj4gmxyGmo6F/itpk335RGql
         X/aM8ZdLH1VNjRiOw+bM+UN6zsNHyvprm/mKt+G2BluvVtyxGObNCxAx4U0I1UzBlrqH
         76s2K1XgtQJ4/XELI0VztV2sSFEb/WnNFV5pglETbGun478AvI53iRKD2q4yUERvyp2/
         oG3DBQfkEGEF9WPSrRDxHZmW80tgzGpMmjU9xwebpYNrMDFdzx79gPR/II7A4V+/UVfc
         zrg1+lCbpiZc19q/l5IDQWjLxBTPpawHEg853obUo0rr0drXGrfGsCmEdtSqPA4M3rzK
         sGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3XGYL9ZUcnrr/zboBZqzQdx0xhS1t/G3PunWu5ada9c=;
        b=MZ73VRMOiCUqNmGLz1fVS87YTY8C9FasQc9rEuylWhaiUG5urofRQOw1IJwxKMBk2N
         e9SEV7cxPvaJAjVuYHrzngpn+m5r4q6Aj+qfSNayzTWg295X23teAvc3KING8DvSVzDH
         WNdpwhfUKKq3hLAhNjJOaD1SWpOdNY53Q5UNZfmfADpvz/LxpqBMeVW3BBINV0QzpnAO
         knK6JWD0ya2p09j90Nk0ik3soB5wVzGgP3dd91uKwp03Ft3jfDcuD+/S3BKO0LXSnkPp
         Bz2lRWtyxvZiyIBlbEf1PHUJ7BWmmEBkiIvE+VtksA8p+dc+nLdNwagr5PNd/SkgXu1t
         vsKQ==
X-Gm-Message-State: AOAM531FB4WdPRSn582837NYscH+Oc5Lf5eoln4+lBq64HbDjGlD7d50
        h9X2dzIlS8i0rsGK54jzWTfxUPP9t+Rj7fiL
X-Google-Smtp-Source: ABdhPJyYEmip+H18XpVYAd1m+e2qXw944kSlPyJZXcSa3cPbMupdbn6t9vUSzeShJXATpbKy0BDQcg==
X-Received: by 2002:a05:620a:198f:: with SMTP id bm15mr3439488qkb.359.1644348606668;
        Tue, 08 Feb 2022 11:30:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h20sm213755qtk.21.2022.02.08.11.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:30:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: sanity check global roots key.offset
Date:   Tue,  8 Feb 2022 14:30:05 -0500
Message-Id: <a5b18eac38f561d7f671454b0601f5173b5cc2cd.1644348533.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

For !extent tree v2 we should validate the key.offset == 0, and for
extent tree v2 we should validate that key.offset < nr_global_roots.  If
this fails we need to fail to load the global root so that the
appropriate action is taken.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Dave, this fixes GH issue https://github.com/kdave/btrfs-progs/issues/446, the
problem was we weren't catching that nr_global_roots was incorrect and then
segfaulting later.  I think I sent this as part of a series, but it stands
alone.

 kernel-shared/ctree.h   | 1 +
 kernel-shared/disk-io.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 6ca49c09..bf71fc85 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1233,6 +1233,7 @@ struct btrfs_fs_info {
 
 	u64 super_bytenr;
 	u64 total_pinned;
+	u64 nr_global_roots;
 
 	struct list_head dirty_cowonly_roots;
 	struct list_head recow_ebs;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 364a0bd8..c03211ef 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -933,6 +933,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	fs_info->data_alloc_profile = (u64)-1;
 	fs_info->metadata_alloc_profile = (u64)-1;
 	fs_info->system_alloc_profile = fs_info->metadata_alloc_profile;
+	fs_info->nr_global_roots = 1;
 	return fs_info;
 free_all:
 	btrfs_free_fs_info(fs_info);
@@ -1075,6 +1076,13 @@ static int load_global_roots_objectid(struct btrfs_fs_info *fs_info,
 		if (key.objectid != objectid)
 			break;
 
+		if (key.offset >= fs_info->nr_global_roots) {
+			warning("global root with too large of an offset [%llu %llu]\n",
+				key.objectid, key.offset);
+			ret = -EINVAL;
+			break;
+		}
+
 		root = calloc(1, sizeof(*root));
 		if (!root) {
 			ret = -ENOMEM;
-- 
2.26.3

