Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9128527B084
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 17:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1PHn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 11:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1PHn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 11:07:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F6FC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 08:07:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so1101697pgm.11
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 08:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bsx1HInsV2scLzzcef+tREHC7FGRmjcR9O+wKodODIc=;
        b=Q7tOppDDxi0NrmMmNQc5hgoP6WggSGD0W2AcxuVvEAR/BHq1fTMJBWJeiMAZkIIAw0
         kj+Or12n/iFbjjBndY3fss9ewVQj7HbXgwzwJwgZmjD/Mcti1ODvRZIVcub7Uj8sccIt
         QlDZFSOYmTkPQ5thzv57Sob9w7YChxZ/nojUCFVLR+5T01AOD9n8t0dDTtoVdxuOUExU
         0EGyuVDO4/2pHul+ttbZyJ9MYr8JP6GfhPxxZliV5l4pFTsEw3XdrpGI+yhb+2JvHLXD
         SGPexaTg93ib1UGfXPVukcvrAEqFBpR3CzWxDBqICMaj+c8fobqRYwhQ8DmsulPmnnWE
         zmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bsx1HInsV2scLzzcef+tREHC7FGRmjcR9O+wKodODIc=;
        b=LnKWUJ+W30xu8kFdWhJLJskTkpAW+dr1SjJEYHJvtRw59i3HzjtIE976n2v4w4u4MO
         BbgCGQ3ibWphTCp2789aCRJin+sbzTf+X46JD7veCWJzhscg9cfZQAXtYiOh0gbOkwHS
         M3pUGGaZ5wfpn3gZz8YYTpo4+rEtVIgczx46Tp+A1zHs9zaUSzCU7U8esPJkx3BNIz0Y
         iXV+r9aPsxp9uhz71ADZYJgkEInwo6dE5dwcm5yJdMRKQ3hLY6EMvXhSOMUzOELp06Ye
         wogQC/MIhE3h8ph5xboEW1Z6meEkosvPHOm2F13DKTNd4PRnE531Wvw2CvHxYSz0HGn2
         dTRQ==
X-Gm-Message-State: AOAM530RF79ce1S8bXXnxZqZ9S8SqAk3IdfuQ1wa94F1GHTtIChz7yqE
        W/6ipJhAp1Yrk3JyFiYu7lwKrP9bAAtczg==
X-Google-Smtp-Source: ABdhPJwRmwnLNiq7whfxhKPYKtMH5iFHT4FvLYk66Lbzo13FT4wGnaMRtgsqVO5p1nelFwEwVq4iNg==
X-Received: by 2002:a17:902:6a88:b029:d2:254:c89c with SMTP id n8-20020a1709026a88b02900d20254c89cmr1956890plk.19.1601305662394;
        Mon, 28 Sep 2020 08:07:42 -0700 (PDT)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id i36sm1726156pgm.43.2020.09.28.08.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 08:07:41 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: subvolume: Add warning on deleting default subvolume
Date:   Mon, 28 Sep 2020 15:07:29 +0000
Message-Id: <20200928150729.2239-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch add warning messages when user try to delete default
subvolume. When deleting default subvolume, kernel will not allow and
make error message on syslog. but there is only message that permission
denied on userspace. User can be noticed the reason by this warning message.

This patch implements github issue.
https://github.com/kdave/btrfs-progs/issues/274

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/subvolume.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 2020e486..0cdf7a68 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -264,6 +264,7 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 	struct seen_fsid *seen_fsid_hash[SEEN_FSID_HASH_SIZE] = { NULL, };
 	enum { COMMIT_AFTER = 1, COMMIT_EACH = 2 };
 	enum btrfs_util_error err;
+	uint64_t default_subvol_id = 0, target_subvol_id = 0;
 
 	optind = 0;
 	while (1) {
@@ -360,6 +361,25 @@ again:
 		goto out;
 	}
 
+	err = btrfs_util_get_default_subvolume_fd(fd, &default_subvol_id);
+	if (fd < 0) {
+		ret = 1;
+		goto out;
+	}
+
+	if (subvolid > 0)
+		target_subvol_id = subvolid;
+	else {
+		err = btrfs_util_subvolume_id(path, &target_subvol_id);
+		if (fd < 0) {
+			ret = 1;
+			goto out;
+		}
+	}
+
+	if (target_subvol_id == default_subvol_id)
+		warning("trying to delete default subvolume.");
+
 	pr_verbose(MUST_LOG, "Delete subvolume (%s): ",
 		commit_mode == COMMIT_EACH ||
 		(commit_mode == COMMIT_AFTER && cnt + 1 == argc) ?
-- 
2.25.1

