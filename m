Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB10D423223
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 22:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhJEUhd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 16:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbhJEUh2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 16:37:28 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D20C06174E
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 13:35:37 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q125so251067qkd.12
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 13:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=E1Nvjot9w+3VxMtA1/66Po1OeJLSyjlKdtyGbNaHAsQ=;
        b=BDscTR5xW8FWuRtV5x7YFVfgOQx6U5a21GTQT+fsvBekhP2c3RrGvx1K3nfwADzhxj
         0GxeAtK4Q2rPvTOK3m/i2FQQpq9CGB0nF2ZJaaFza+ltBL34N6udO+Vhjfw825VEeev1
         xGUcsEnKlKhNciLNUCkQdLyPI6dhQ5Nj8fBC2HlHBtu9Vj79fAK8be8gdbEIN2o+dn3d
         oCQMNEYnXoGmF2OsCKKGUJ5v135/In00CoHigrFRdY8gWKZC1/j+L7gWrQkydy3Hg9gm
         6ZpftdXfGV3heNBd7J9QhGCw8iWW8iOWjNypZSmWVXQmzvtQQnvLPO1cUvSXu28vIAji
         Fh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1Nvjot9w+3VxMtA1/66Po1OeJLSyjlKdtyGbNaHAsQ=;
        b=ni8gi6bxTg69u05V1+myc47NUX0L9nmh5+e3P0RB9iyjUnRAe5GC8GmuRzIeX+x8dO
         T6g//riZo1enXiAARy5ahYsQ1Z2nAbABpnJpmmG6+fQofwmYOWYOKuTuGb6wTteglLGI
         icVR1lubanQybe609PaLb7bb/UTMAUgvSl6lzA+5Y+z8jND6FW97uP+ZTAqtC1OPWlGO
         LYcfvnTIiHU423ptoddgG35VEgqTEt8c77LvoGiQyUUXZ+F2ZXhoFplObF9tkezCNxfS
         NQ02B55GxxS0ws4bKnefBNqyOOTWKfl+wSg3yCnEHTcr+9HQhcmngHJI7FKnSSHZEmfp
         z1ng==
X-Gm-Message-State: AOAM533mi2Xhh95NNRjtbehxnMKXDnI6CImUWbT+dElE6vLLuD9fez/t
        0YzVPPRBTU8e/1wRUpjC1sfqs462Mv8XSA==
X-Google-Smtp-Source: ABdhPJwXpNUm0tlXVoQqjUmYIlKBUK2HXgqzwAgMA4P0SwfHcAeXPJSvSFlLeXVZ40v6d6RU+NQ1rw==
X-Received: by 2002:a37:43d2:: with SMTP id q201mr1629042qka.214.1633466136863;
        Tue, 05 Oct 2021 13:35:36 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v3sm10100871qkf.131.2021.10.05.13.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:35:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 5/5] btrfs: fix abort logic in btrfs_replace_file_extents
Date:   Tue,  5 Oct 2021 16:35:27 -0400
Message-Id: <92149e1c4fadff139a893282389e16f0a2f0da31.1633465964.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633465964.git.josef@toxicpanda.com>
References: <cover.1633465964.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Error injection testing uncovered a case where we'd end up with a
corrupt file system with a missing extent in the middle of a file.  This
occurs because the if statement to decide if we should abort is wrong.
The only way we would abort in this case is if we got a ret !=
-EOPNOTSUPP and we called from the file clone code.  However the
prealloc code uses this path too.  Instead we need to abort if there is
an error, and the only error we _don't_ abort on is -EOPNOTSUPP and only
if we came from the clone file code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 62673ad5f0ba..f908ef14d3a2 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2710,14 +2710,16 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 						 drop_args.bytes_found);
 		if (ret != -ENOSPC) {
 			/*
-			 * When cloning we want to avoid transaction aborts when
-			 * nothing was done and we are attempting to clone parts
-			 * of inline extents, in such cases -EOPNOTSUPP is
-			 * returned by __btrfs_drop_extents() without having
-			 * changed anything in the file.
+			 * The only time we don't want to abort is if we are
+			 * attempting to clone a partial inline extent, in which
+			 * case we'll get EOPNOTSUPP.  However if we aren't
+			 * clone we need to abort no matter what, because if we
+			 * got EOPNOTSUPP via prealloc then we messed up and
+			 * need to abort.
 			 */
-			if (extent_info && !extent_info->is_new_extent &&
-			    ret && ret != -EOPNOTSUPP)
+			if (ret &&
+			    (ret != -EOPNOTSUPP ||
+			     (extent_info && extent_info->is_new_extent)))
 				btrfs_abort_transaction(trans, ret);
 			break;
 		}
-- 
2.26.3

