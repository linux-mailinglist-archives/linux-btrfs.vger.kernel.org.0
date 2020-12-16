Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F812DC407
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgLPQXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgLPQXo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:23:44 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DF0C061257
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:35 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id h4so18142713qkk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/duB1ggEKPbOnyoRYK1dtOEXOFf1fpJyMPvSa7NXoEM=;
        b=dv7AmJs6H9A8ynqdEoGUxw83UDwBF/TZq+bLHgpV4owxMzbk8bpPwdTI7PLDXsNtwS
         Fze8QVA7TaaI5suwo8NWsPvffr1g1c1E4BoWRuJHyVlBS6vjil40JaciLg4C5Oy2ttJi
         Nlj53vCPdwPxgJcgN4+kGEPZsyOu6TW5FjEyOrufI92II7FuCjM6LkjLCpTqfPgItivR
         esJVf6G4xH4Wq3g66MZzoDkdS5Fd/FVYsbBybumjNrwsEtH/BzfHE+rv8qLbwjyH1qIx
         Q4m7B4Ow1Fz06E7Z3Aw/0AhjicB1Z4lV7rwv5kI8RNobV+GhL3y5or+7fQvqOeqCuqtQ
         o80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/duB1ggEKPbOnyoRYK1dtOEXOFf1fpJyMPvSa7NXoEM=;
        b=mO6fh1DbxglG8chMa8f8FSWXVPbr3aag8UiOJVy2Ef8G5aKLEOO38rY5oZxFfPRB/j
         U/xJcghmf9wU+9g6m+BrG0j/hcHb4UN5cLwl3LK+c3U4jVNm7NDiPmUVtGQnOhPmtbKp
         7pZS8hxn4ti1IWTR4HBmCJLoxdlyLANdAqUXxVN9UxgPpRXXUg/hLkfI9ZmtKmEWrbqL
         7uzDHB3C3jQpa5ae+xt6utX+n79/ATnGEdnxBfRoC1Y7PgDdZ0OZBcJ0jbXpQS7OILa9
         NN06JsyCyfpyBJHIN5Z+PEnxH8S5nG/s4gjN1FwfWAB3TFnSZI/jDDwUdAsOtJjRzM1i
         XE2A==
X-Gm-Message-State: AOAM530noy9mD6UFTTrpHoyB0GbhIs8P+ltFrUoXy1KwULDD63CQ1WZy
        an71hG1jpj1G8vxo/qJciRoTMyrFnZv6u8vN
X-Google-Smtp-Source: ABdhPJzWNwJsoMajXi+bAr6A+FLY599G0TVnTflAV1tFufr6nO/jQIBVsPcElpM7Sd3VdOUu9hPXMA==
X-Received: by 2002:a37:584:: with SMTP id 126mr44733215qkf.332.1608135753947;
        Wed, 16 Dec 2020 08:22:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j142sm1382389qke.117.2020.12.16.08.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:22:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/13] btrfs: abort the transaction if we fail to inc ref in btrfs_copy_root
Date:   Wed, 16 Dec 2020 11:22:12 -0500
Message-Id: <464b00efa5cbf3e97c795c56605fbb4291839247.1608135557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135557.git.josef@toxicpanda.com>
References: <cover.1608135557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I hit a pretty ugly corruption when doing some error injection, it turns
out this is because we do not abort the transaction if we fail to adjust
the reference counts in btrfs_copy_root().  This makes us miss updating
the references for the new root that has already been allocated and
inserted, which is the problem.  Fix this by aborting the transaction if
we fail to do the reference modification.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 56e132d825a2..95d9bae764ab 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -221,9 +221,10 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		ret = btrfs_inc_ref(trans, root, cow, 1);
 	else
 		ret = btrfs_inc_ref(trans, root, cow, 0);
-
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		return ret;
+	}
 
 	btrfs_mark_buffer_dirty(cow);
 	*cow_ret = cow;
-- 
2.26.2

