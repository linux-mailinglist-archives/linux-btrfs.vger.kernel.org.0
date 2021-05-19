Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0D3389294
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354769AbhESPa0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 11:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344451AbhESPaZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 11:30:25 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD60DC06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 08:29:05 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h21so10398546qtu.5
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 08:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=koYTFA2bJbkS9X54kynJqyY7cHPKCtBjHZcgiuZIk8g=;
        b=CiRLfGeZ7UzwMd7eIP2V2N0qttAsASj3+XDm2oyH87uDIEeFXaWhb6o9LXjmbppR5/
         ZOSfqf6weBi80RbgAWdRxsVdWAhYRxNm9azglSqH/ANImbXv0Bm5/kTrLO93MR95Zn3/
         0xIN2aKin3XXvqo11Hu/avz3voioVEF8+BLG7SnDI2SZjAMn+l9wei9lBzuOwwDsItph
         8xSholBU0bi4z01bn5pAjn5UQxi67U9f/y4XgqTN/fBsI0Kfq1S8bs5NQUNiTZ2NSO3L
         HQf0h4CDT3g79vMiJKdjMY7JpeDH5+QnAv3JZUPkAVZQkxyWT7wvScsqVkqhKpEbYhil
         XpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=koYTFA2bJbkS9X54kynJqyY7cHPKCtBjHZcgiuZIk8g=;
        b=Yr8KbVJwlGgq/cFI14fkBOMZVfv+OpGm4+vD0mK1XUVBLQQ24MvFZLvuPigswZ/xiH
         HBTHnc+VEroVzhbtdgcAtZpRulRVQYuN0A/8bwaFBrEl9dHyMXA561iwZxa1kQ8prrR5
         64y63dH3TL5cGFI3TXeA2o+Ol0n2TZwHbSFJQ6w9UoXW+Ojap4LadG4A87iRwigFK2Tg
         SE2ynqaUViPQfEXZ89MCj1NMqRwwOjaT4+9recyryHYpCrDDJ5owntDYlS20NUoPnvOr
         Ycqc1mWucwXobUmKQ5e/p+p1xQsi9uzkQemy97V/7Nlt+Mrlj0CrgEyXzBY9m9V04GHp
         WxZA==
X-Gm-Message-State: AOAM530OrLhZfBZQzaup0yLtL7brR8q3ReFMAOnCOzqSPwQB9Y395dEm
        AwG4ieva3j3Jq/1KpjxTf9QXBN0Wmwkoeg==
X-Google-Smtp-Source: ABdhPJyI4YlaRYraq9R4MFD6vqcBmyBKYWp7IexAPIJ3v6mYcQ429kuXPzXDnfxQbBYGcxs4oWcsGg==
X-Received: by 2002:ac8:73cd:: with SMTP id v13mr11794238qtp.276.1621438144717;
        Wed, 19 May 2021 08:29:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y9sm5094qki.66.2021.05.19.08.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:29:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: abort the transaction if we fail to replay log trees
Date:   Wed, 19 May 2021 11:29:03 -0400
Message-Id: <9513d31a4d2559253088756f99d162abaf090ebd.1621438132.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

During inspection of the return path for replay I noticed that we don't
actually abort the transaction if we get a failure during replay.  This
isn't a problem necessarily, as we properly return the error and will
fail to mount.  However we still leave this dangling transaction that
could conceivably be committed without thinking there was an error.
Handle this by making sure we abort the transaction on error to
safeguard us from any problems in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4dc74949040d..18009095908b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6352,8 +6352,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 	return 0;
 error:
-	if (wc.trans)
+	if (wc.trans) {
+		btrfs_abort_transaction(wc.trans, ret);
 		btrfs_end_transaction(wc.trans);
+	}
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.26.3

