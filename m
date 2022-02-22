Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA3C4C0482
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiBVWXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbiBVWXS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:23:18 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30916A052
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:52 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id a19so3482200qvm.4
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W+rvRUtZVNz1v5bV9gKWlKDCVW1gXcVkluaKc2htTpQ=;
        b=jdG/riD5YBzQv6dTjwv9Q3OCUngT4U5MOu1gqcTlIX6eUR5YyiasIFt+tC4Z6nnXff
         YnlMT52B29oXa7wOwyC01M/J2Pv9xkdf/wRyNL8zE2D3s8lk7ow7CwuM1Kyf5ft5QIsC
         iSVT/o+WhXjJxkC2h2y/Zm/2uf4Vr24CmGVjPTxiMPig5DHmDIC41scLWo7XlFcn6T3u
         qop7PYV4eCNGXOIbCXSSLkxwdo6kI3Dl5cORbH+4bPOmRwZbbl5TPOLZ6vHZ6HTHbn/u
         f3x2qM/UGPKxS3/s3bnIObco5/nlcHTp9+ljegeFm/R8c2rhcSI/om9h7FMeXsBIiK+E
         NIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+rvRUtZVNz1v5bV9gKWlKDCVW1gXcVkluaKc2htTpQ=;
        b=QQQMowp4ANS2hKp+1QSu3KX0UBEm9Qteea/KQuorwn+Tj2ou+XmKRKQ90RDn71sL1E
         aNXK97vCwexEansN+Yn2Pcxf2QxpzqDBTyUCkK8/3Vk/1Fyuwut19v5uNXnNhfxbnlG6
         BeXYRDmFV0Zi9uf+nph1h8vRkxTvzV24/lFbGVf8X9Hnfg+Ms7WZEesTwmZF63PVMaBZ
         T072rK2arn5SLMbHFw6J35ttfTQpLevY/A4eNHpH3y2vPO+ev0oYKEUzhVVAjByEU67N
         4caGpsoe5lGQnCjJ0981MIjes10+hP1TW/Um7vBDBoo562KOrhheBfyNoseQE1AjOfTZ
         BVPw==
X-Gm-Message-State: AOAM533jrx3tNGEjoCHJIHmNtM7wPzXilBRCwmBmXyg7dxyzyXDohXJL
        5CWktvGaOIO+R2mFE/hXkSH72ulMyB1HHR6+
X-Google-Smtp-Source: ABdhPJx1zMSeI7B/+CYIg1oaNqYqQPldOMsyfE/Ot8Gu/9r5GR1fpZdcUrd34A9AlDF02QdeKzs3Ng==
X-Received: by 2002:ac8:5756:0:b0:2de:1ce6:bef7 with SMTP id 22-20020ac85756000000b002de1ce6bef7mr11251005qtx.461.1645568571476;
        Tue, 22 Feb 2022 14:22:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h123sm504357qke.18.2022.02.22.14.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:22:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/7] btrfs-progs: do not try to load the free space tree if it's not enabled
Date:   Tue, 22 Feb 2022 17:22:41 -0500
Message-Id: <8bbb4ad9ae314e7f3eb03d7b4d6b6e75d957a8e5.1645567860.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645567860.git.josef@toxicpanda.com>
References: <cover.1645567860.git.josef@toxicpanda.com>
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

We were previously getting away with this because the
load_global_roots() treated ENOENT like everything was a-ok.  However
that was a bug and fixing that bug uncovered a problem where we were
unconditionally trying to load the free space tree.  Fix that by
skipping the load if we do not have the compat bit set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 637e8b00..f83ba884 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1192,6 +1192,8 @@ static int load_global_roots(struct btrfs_fs_info *fs_info, unsigned flags)
 					 "csum");
 	if (ret)
 		goto out;
+	if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
+		goto out;
 	ret = load_global_roots_objectid(fs_info, path,
 					 BTRFS_FREE_SPACE_TREE_OBJECTID, flags,
 					 "free space");
-- 
2.26.3

