Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412742D2F8B
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgLHQ0F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbgLHQ0E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:04 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F1EC0617A6
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:32 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id h20so16453083qkk.4
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8fTlPURwi1njot0TAiCWtZWFXAYhGZrv+pY5V3rdfo=;
        b=pUc0YpsHiMbggfobjchJGpmEfcW4hCDcFlALBLL7N5uAC5Ymiyxqn9Z2R+aBtyHENk
         O8Hy1ph3521oyZUCf7FHAuiIjqHUZ/4mzm5tXf9CbMOADaNomtupGISLjpfnbolNjsqB
         l7Z7Fppju8FblwoOaMq39N8g+0UDSczMt9luI9YzVSY0Qx83pfhF3LcT7IYBNE74E5yx
         LJWsYEDmRKL4h5t1oy8e2sCtVlAG96mcc6E2Ro7vx+aF6ScPOuAym50Jq/A+gn/nbXxO
         x1Z9B16VBfL9JGGjyDYhwYzpDvoUj2xC6GrreIEflQ1ki/RArXVgChM4vO2HSCk5eU84
         2aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8fTlPURwi1njot0TAiCWtZWFXAYhGZrv+pY5V3rdfo=;
        b=s9VACiJ/BJpmdgh6XrY2GlnuDlCph1Hp+xOQCiGNWTxTCUOFw9leOx2VibvzYyh83c
         8BYaItFBicuconHKa0buIxbnA0HLCIkezONu5TMdDbdmOQeQYMe3gWfHlxfGzG3kvW6U
         7qbEquNZGxSbUIOODhW3zfNuxDf0iLY81GVUVE3+ps+v0nJJZb32fhb4NylPTkN+Mfhj
         4K33ukM8Rrxd+OwQESkBqJsQ36J9mMDstrPF3wDzbzqWJwmDpNPqJPJbq579WayNPbTq
         1H+cwWqthhfkYLPtuOl0WVb3ANgWhPO0EdMlUv87PFblgr2ZZSjOY6A0IwEzEamqpbUF
         EFKA==
X-Gm-Message-State: AOAM532a+TimQJkzrRzpOpUvP1Qs/8oIGvlRGG0pfCLABK7lBNhy6o0Y
        98YUxCkhs8dmZzRdpX5kHrpJcEmc4CiXzUxs
X-Google-Smtp-Source: ABdhPJy61a0ErtAsRtdA1og/Va2H31OgCX+8UxY+n2lxQ9ny0dJV9NCUTnuIVYTV+ZPZ95/a5FM59Q==
X-Received: by 2002:a05:620a:14a:: with SMTP id e10mr13575584qkn.103.1607444731628;
        Tue, 08 Dec 2020 08:25:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r1sm13187632qta.32.2020.12.08.08.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 41/52] btrfs: check for BTRFS_BLOCK_FLAG_FULL_BACKREF being set improperly
Date:   Tue,  8 Dec 2020 11:23:48 -0500
Message-Id: <a7c076cf039e3c55ee0a5782ce54ff421eae1293.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to validate that a data extent item does not have the
FULL_BACKREF flag set on it's flags.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 028e733e42f3..39714aeb9b36 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1283,6 +1283,11 @@ static int check_extent_item(struct extent_buffer *leaf,
 				   key->offset, fs_info->sectorsize);
 			return -EUCLEAN;
 		}
+		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
+			extent_err(leaf, slot,
+			"invalid extent flag, data has full backref set");
+			return -EUCLEAN;
+		}
 	}
 	ptr = (unsigned long)(struct btrfs_extent_item *)(ei + 1);
 
-- 
2.26.2

