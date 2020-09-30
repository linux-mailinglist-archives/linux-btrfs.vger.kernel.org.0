Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F69127F2DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 22:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgI3UBc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 16:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbgI3UBb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 16:01:31 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3CCC061755
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:31 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 19so2336395qtp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a1hj1a5SA2bAObnGglMssi62pVyWC3LVjnj7KYKVAPM=;
        b=crmbI0AVbAUQ5PePEe0mnYnmeVEpDqAAgnVqj7yFieL7Qk48ekpG73dufIRi9QufgG
         T7g4l51qyfXbxTWhbCyb0gcDnqpqDpnJcgBhc6T1I/6dbmN/CmOMjYY6t04VJbbOHZU7
         eRx4hG5DCAA3uNLqatDbRRwxghZkqLl/IMP2fh74XERoTb+Qns3vUnPb6oW5X9cOIuPD
         aVHVCb+WvQJR83PkR9nfGzqpsVsrZ1PgTeesscSsoMexrQl4h/cr7JJApRVs2Vhl0l0C
         yacB2X6JYfRmQsF6fVA0kgz3WsScKP0lS3uhrbH2zPp6LKulK7A/oLMU9SGsXnhPMjHD
         oauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a1hj1a5SA2bAObnGglMssi62pVyWC3LVjnj7KYKVAPM=;
        b=aDl7PJOCd4wF8wN1+eksV2N12FF1R8EqnqO3s3CSm8HjvJPfzAq/TyADkcoHuYyU4+
         4KqOPAnt3FU4Pz2VqsiY1BTkEsnLMfDdBgwBJbFz7SxchU2h6qJU/PwHYpIkf47M6rKC
         EHr1C/TISSDqXGkQItmcXZfMURInWP4CDGoqXTcVTyrGqZwFriAGfI6H7geUumqiyZe+
         vMnvF4RCrCP/WI8rQskhFE2K1KIxXE9zul2XiiR5ay+xYeFqXLDuyZjCpGHKRGkrZhcF
         5HoYJnxu3YUvuEY7IAkeJUQF0373pOSzf4SRgnTYEzuOIe15R3kpdPM4F6FIxQRalf/s
         3PCQ==
X-Gm-Message-State: AOAM530MmOkCpt9z6562ePPN10jZj6iHFK5j+uF1RLBpKQLQnqtKIMbF
        0ijwERpmq2tLnXlGT42NJl+t6luh4tfssZy2
X-Google-Smtp-Source: ABdhPJzoyE3qU5aUWLgNWpjHGQrP6d9fnsPGgbMyTZzJC21HcLazi4vlRV42LgoxWiMsd9IWKcOvUQ==
X-Received: by 2002:ac8:7613:: with SMTP id t19mr4132362qtq.259.1601496089962;
        Wed, 30 Sep 2020 13:01:29 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k5sm3317538qkc.45.2020.09.30.13.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:01:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/9] btrfs: check reclaim_size in need_preemptive_reclaim
Date:   Wed, 30 Sep 2020 16:01:04 -0400
Message-Id: <855a8376fa0d8e63e066ac323a985fe7bc1e562f.1601495426.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601495426.git.josef@toxicpanda.com>
References: <cover.1601495426.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we're flushing space for tickets then we have
space_info->reclaim_size set and we do not need to do background
reclaim.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 98207ea57a3d..518749093bc5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -805,6 +805,13 @@ static inline int need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
 		return 0;
 
+	/*
+	 * We have tickets queued, bail so we don't compete with the async
+	 * flushers.
+	 */
+	if (space_info->reclaim_size)
+		return 0;
+
 	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info))
 		return 0;
 
-- 
2.26.2

