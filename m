Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9182889C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 15:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbgJIN2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 09:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgJIN2s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 09:28:48 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B00EC0613D2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 06:28:46 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z6so10544496qkz.4
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d99dx4jM28zJlRp3ANErbAewCnq3r4ED5sBLfe7V+0Q=;
        b=KB4sTonrBIVkBxMIRixIB67VfpN6CgCRGCkEt1xnt6QxSesdPvEAAdK9RPtX6vsQWg
         uzDRHVuHk67mC+Uaq/vBI1GZYV8Jtg6dXgBKhDn1NtkE9AWNXyiXrgmr7hYThI4pd6qP
         PIXbchqlFDck8OnSsNHGe8x6ZWf+ZPq4vCH8gHBCuu3E3utJc9NXDGVSBL7MHLMkbJp4
         a7fiIdWp4RT56LccxQBpJSRYPRVm+b64cxwuINjbRTmNPBHjojpAte93oz4rmvIwJ6KW
         YrRwsrYPomI7Rj3Ze9nEVK0PBl8k2Tt/JA1+6+lUnHMyBBj2AenqlxVdNrZvEvb6aUva
         ybCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d99dx4jM28zJlRp3ANErbAewCnq3r4ED5sBLfe7V+0Q=;
        b=avGrdRvoYRCbR7oJvXeTMNhF9irUcsMXnwJp78LkwI6xIZCxjQBjQfDyxXLQVTaBLI
         nLf5vl9lrxmWgifw1H9m/bzJIr3cZZdSJgRAd2fR23ii6qLQvEfBSFgAAo8xmhjdDZtM
         r6ZpsaT9FxKXCsUozTU8bFfSIEVR1NuppsCr9+iCButyIg+0ExVAvmVc7TCxg8H7ZYK5
         RRCeb6lF5K8sOoUCMBFz/f7Nh9Tz/eRQFk0NYLVCzXCVm8JG7ycAeyweLawYXyYMcLnf
         vIwTOGeDWsCpwd8qSC8moC5IRmwmT5G95tVRiGumQQBuyBO+Ig8ME67NASNc0CwGaVUr
         bd4w==
X-Gm-Message-State: AOAM533amASGMRgh4/ea84vWm7jJr5MdvuMPyqarnin9KnGzoXFjcIw4
        82x2HHDByyHdFahUzaS2NjGqju6eam/w7rF+
X-Google-Smtp-Source: ABdhPJymMDqu+1UaMXoikgdYBm6uXj1AElm+RkZM8rsxAE9tC++zjN+hJXDPPddUWnFACWfwKgJ2Lg==
X-Received: by 2002:a37:b882:: with SMTP id i124mr13759491qkf.51.1602250125262;
        Fri, 09 Oct 2020 06:28:45 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d47sm6405162qtk.53.2020.10.09.06.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 06:28:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 07/12] btrfs: check reclaim_size in need_preemptive_reclaim
Date:   Fri,  9 Oct 2020 09:28:24 -0400
Message-Id: <ea52fe431b7c4a5c8729d6fd624dfa416206b35f.1602249928.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602249928.git.josef@toxicpanda.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we're flushing space for tickets then we have
space_info->reclaim_size set and we do not need to do background
reclaim.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f37ead28bd05..4a25f48fa000 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -809,6 +809,13 @@ static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
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

