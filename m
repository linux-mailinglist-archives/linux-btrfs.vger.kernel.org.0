Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBC127B488
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgI1SfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 14:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1SfC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 14:35:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA10C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:35:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c2so1930547qkf.10
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LO9AU2zdbNOLCT1So1fmNre7jP2ZElUZILMO7GqF+OE=;
        b=DXeK5XBxBgO991Z5h6U4tPeHxKnlfGZ9ULv9Z9SUG/3tTvrp+/3mDNC8FexPZYXc/e
         oHxGrGW2RcjUnKbBdjanBmzVHhYgxG2Mw9OZsm/Zxk1m9px9uFE4aB0+Ejth9PirY07x
         tK3F5qzfVJQ6oyFqZDEOv6sROGmh8b0bcgouxCQDsymsF43Q68azftu3IEsvnIXY+D0T
         TpbYz/UsOB9iPvhayXq16+qwH+dGawV+qA8C3owvUsa6Oz/56Z/ijPrgavaH57AbUqtR
         na+dy9M4fvCCGxFZOvkLUzf9cI0ybymQbmOJIY15vAbC4fmltzBbni/1E+VDajC4UrzK
         JTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LO9AU2zdbNOLCT1So1fmNre7jP2ZElUZILMO7GqF+OE=;
        b=EBdpbX5gnNMkB/SeyKq/pY3e3XAktIYFmPL7fPkbIsNyyDiTmbwDzNVlcjcBCRm620
         Ji6WTaijcvv9gxQVhwUy08NEYgjTz28P24Aiud8mwF/Y3b26LROzcw7zXE68DYloemF4
         SvFfV7+axpnX9PKj5Wr9cIFAVv40bbw3rZq+W2jF4AFKRaTjdinLgyG+RNfiV0N8bmsP
         KQpy999jB7LBl3pYmZ3sANAiT1zIU5ZnNSZ+UDMLKrH9++rzR5smx5IngqtX1bnRM4XN
         upvOenaOS4WcxT1JpOPlxjC+ERDOBLeGFwJBx2vp3O339tSxTzACl13tZrLt1Sw+ZB9T
         pxZg==
X-Gm-Message-State: AOAM531HD4T6xlwAuykSEsB3OH80thhEqOO11D99TplX5BSx4Il9+rq4
        1Tp096IBXZvz2ml6yp6/ToWBUrpCYxUr6q2n
X-Google-Smtp-Source: ABdhPJxuwV/42LIjFWiVhVV+GvY2Rg6u81EEZMAErnyX50wS04klTF7HT3juSii5SAePwrtX9mJOkQ==
X-Received: by 2002:a37:990:: with SMTP id 138mr785540qkj.53.1601318101210;
        Mon, 28 Sep 2020 11:35:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f33sm2226072qtb.45.2020.09.28.11.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:35:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 1/5] btrfs: unify the ro checking for mount options
Date:   Mon, 28 Sep 2020 14:34:53 -0400
Message-Id: <5aed92fc4a08fc7a97233a5d05a7e0c5e86937b8.1601318001.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601318001.git.josef@toxicpanda.com>
References: <cover.1601318001.git.josef@toxicpanda.com>
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

