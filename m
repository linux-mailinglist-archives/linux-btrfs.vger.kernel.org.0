Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5D9289927
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 22:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390922AbgJIUJ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 16:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390859AbgJIUIY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 16:08:24 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9974C0613E6
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 13:07:25 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o21so8930147qtp.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 13:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LO9AU2zdbNOLCT1So1fmNre7jP2ZElUZILMO7GqF+OE=;
        b=Nx3n4n7GSQ04i7vasiPDdSBR+THHxsdt0R1K5Irim2FgJpUdItsYjDLq2WZ69aTAPS
         IW9dHi1utm0ijiAMkh/x71o/Z1FSKEyja8MtNMakLoB/x9MUDhSJgiWaN9csbhT4YZW5
         xC7FRW1lmjjRiiQfOmgkiULpBaHrKVMPY/zvqb/RjUi16Lycbn9gRI77aUvne1tYO2y8
         BNf33YK/FuxnROgn2m5zDcefc5oBQQoku39Jl5OvbS7/PouVTVfQJBEya1P3TNw2WEIs
         fKmO0CLYV47xWaISMIWVk9I+LPWBPdJoi3LoZMUhlvUvxyuuEM/4YtJTbiG6RIjEYwGg
         uX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LO9AU2zdbNOLCT1So1fmNre7jP2ZElUZILMO7GqF+OE=;
        b=kPC6q45Oj13/D9Tn3iPh3h/QNwb1XUiEkaLP1IzYsxyUs0qc5tnD4cDbwSt443YGex
         Bau9clE+C0sqqTZF7McI4/Yruc8V4I2ILJ+yjEwTcVri2rD9r7gR17WIARhelgTOkXmW
         kvNPj9LNCvfDxX5HZ16OueuKLpavYmbSNiwkzrxDvfW2xZv0UZ9knbhwiI7qvcwZ8X/T
         tyuPkBhlVhwLMucKyO5BvIThyqziHB58C0KpIcMiOYUhqmhIom3Cet4GMkvgckyKR5yb
         oDtXyaAVOb54Dcu5rroaieEIsKa2HqRQTis206ChL+c7fDO+gPDoV5kcPo0p3sxQrmYv
         LXig==
X-Gm-Message-State: AOAM533Agv4L1lyPkLStaqdX7zr8ULQ5dtlIz1GiSzjASQq8Axo0/Q9d
        Ql+2jjpnS85/fFI9Mjd0D828DZlXpJ0oyDEf
X-Google-Smtp-Source: ABdhPJw6AHrtGqLGBF5GWxEwMwJGYWvZCzfx6hVvZkfXqhTbXkDU1BG3UbX93MBlz8v4E4yhM3WkaQ==
X-Received: by 2002:ac8:6d2d:: with SMTP id r13mr9465021qtu.279.1602274044624;
        Fri, 09 Oct 2020 13:07:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g1sm6914123qtp.74.2020.10.09.13.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:07:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3 1/8] btrfs: unify the ro checking for mount options
Date:   Fri,  9 Oct 2020 16:07:13 -0400
Message-Id: <b339269ff176fd575cab81b40a15f2bbabcc94f7.1602273837.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602273837.git.josef@toxicpanda.com>
References: <cover.1602273837.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to be adding more options that require RDONLY, so add a
helper to do the check and error out if we don't have RDONLY set.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 8840a4fa81eb..f99e89ec46b2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -458,6 +458,17 @@ static const match_table_t rescue_tokens = {
 	{Opt_err, NULL},
 };
 
+static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
+			    const char *opt_name)
+{
+	if (fs_info->mount_opt & opt) {
+		btrfs_err(fs_info, "%s must be used with ro mount option",
+			  opt_name);
+		return true;
+	}
+	return false;
+}
+
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 {
 	char *opts;
@@ -968,14 +979,12 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		}
 	}
 check:
-	/*
-	 * Extra check for current option against current flag
-	 */
-	if (btrfs_test_opt(info, NOLOGREPLAY) && !(new_flags & SB_RDONLY)) {
-		btrfs_err(info,
-			  "nologreplay must be used with ro mount option");
+	/* We're read-only, don't have to check. */
+	if (new_flags & SB_RDONLY)
+		goto out;
+
+	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay"))
 		ret = -EINVAL;
-	}
 out:
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
 	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
-- 
2.26.2

