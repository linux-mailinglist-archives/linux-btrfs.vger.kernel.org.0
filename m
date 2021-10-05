Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0BB422FD7
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 20:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhJESXD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 14:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhJESXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 14:23:02 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C518C061749
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 11:21:11 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c20so5548qtb.2
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ogx/LaoBEcBhDb4RdfxbGzIbmUauIe1SU2EUJs6d28E=;
        b=H+yRD365TQpeFgYT5+sjrEWLbTi5m98zVmHNOhyN0iIqJLMdMeEuVYLO5ERbUDnrCj
         PR0qxEnuxXiUbi5QgcLHTDB8q2V233F+hYmTDvF6u7ThIQIqJAgRIrcy87WGORRYtxKE
         uAEXV+PI2MayPTy1objaRSNm2XPCX3HTN1pri+0qzZTDUkyHB8Yk6s4QzPD/vdXp+uSu
         n3EfLkVtxCR6ou48rzvL07ERpxqCzHSTDijreeVasOPBfDxJiTuHG+uzZWy68PBPS2WQ
         Urn0zB7xtONp506l8X4/uLrDWltu9UaR6j3FUU/lTzZi9GZkn7ttCjqmZqaxtt13MBnZ
         kvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ogx/LaoBEcBhDb4RdfxbGzIbmUauIe1SU2EUJs6d28E=;
        b=D+zAxu1KX9rgW9a02pizMy7YCOVeecDijjmHnzf2BEcz3niQ6N5Xk8lCn7gN0qppUv
         WqkRrW309RljPxH7+BbFotbrz6Le3FZZ5REDN3WCAaOfpjGBpkmwFGCvseXESkHz32cz
         A0RepDNoBbggBRBhd3n9jfxnshhUzbJUHxAOMjdkCGFZNifuUe2DRq16xzcFsbg+zP9G
         26RiBHF0Gx9vxGaJHoUJi9E4HH3DLCP7CHuZaHyF85eBMsM+PCcPx3jcOtuTp6fvtGwW
         lQszLlaX/deTRejGXdVbIwvQAqIzh+Xr6r0N1FwJ77sio3vpYsQmqdbdAYWY1rU5QEKA
         SbjA==
X-Gm-Message-State: AOAM5326OV9orfo4UcqUTKrrOQg5pYz7Sr1lmHb0bR/XMUk5x5ty75b2
        gXTvd9JioGqPBOMiGgzicQ9rVDPegaKruQ==
X-Google-Smtp-Source: ABdhPJyqrrBr6PqlPkJpxG+LI7G3lfTlIviQI2PhexSon9r3fKX3K1ouSu0TSvMMNPiBx2tJu/c2Jw==
X-Received: by 2002:ac8:7458:: with SMTP id h24mr3511028qtr.355.1633458070211;
        Tue, 05 Oct 2021 11:21:10 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m27sm9700717qkm.57.2021.10.05.11.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 11:21:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: remove data extents from the free space tree
Date:   Tue,  5 Oct 2021 14:21:08 -0400
Message-Id: <0394a30e2d64f3a418c7f502a967b9add5632577.1633458057.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dave reported a failure of mkfs-test 009 with the free space tree
enabled by default.  This is because 009 pre-populates the file system
with a given directory, and for some reason our data allocation path
isn't the same as in the kernel.  Fix this by making sure when we
allocate a data extent we remove the space from the free space tree, and
with this our mkfs tests now pass.

Issue: #410
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 4b79874d..90733d55 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -3483,6 +3483,12 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 		} else if (ret != -EEXIST) {
 			goto fail;
 		}
+
+		ret = remove_from_free_space_tree(trans, disk_bytenr,
+						  num_bytes);
+		if (ret)
+			goto fail;
+
 		btrfs_run_delayed_refs(trans, -1);
 		extent_bytenr = disk_bytenr;
 		extent_num_bytes = num_bytes;
-- 
2.26.3

