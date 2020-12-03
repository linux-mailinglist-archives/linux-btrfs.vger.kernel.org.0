Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4624F2CDD62
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbgLCSYi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389281AbgLCSYg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:36 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FAAC08E860
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:19 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id u4so3000644qkk.10
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pg4Rs440j7qytVG8dQXueQyKh7OJmkNUbqs81SrLs48=;
        b=L6SBdEBzTrNveSsHOXSqxaK5/QzdkAiZhuZYubks6wdC78QVp5JcPECfIyKA3t7A36
         bq57KP+4W++pOCp0uQxMWt9oDTcrnmj7ySuwqEi3BWCkkWuhGz5etVWMx7itIpfDKZli
         7yNuU6Kon2HjfQJkDcQg80Gw6amuOYOKNN+4kxP93E20VcrYmJxd9v5KDI1Shl20R+fT
         2ojFO8dbN0KZLnHKIFU+YNZYd6VBlit+k99MQQ5OQ3BmIdiyHanGtPZBZlremdCZFyLH
         VqCZNxruvRX7l3DD1D07u+609HTl74R14zmJrciDcDEQKt96iUNm7cKWBCGzCiD+B7u8
         xr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pg4Rs440j7qytVG8dQXueQyKh7OJmkNUbqs81SrLs48=;
        b=bdJzsrugPw83d/wqnxYK7OPfF1M8Q6QcfwOyON2BQs5Mn0e2yeX75/i62MYbDdznZw
         RAY8x/8F1pDjUvZSfAwk3OMxE1oRq2BW8DAoiG/dZQEjwMT0oZAzur8Hgg3mO8ipKFq6
         OMGpqDXNObH87Df1jbEQCaZAW6V8K8iTJrB8fL4hLX38uEoD6u7RGgpePNaW9isfB+f7
         GrWU71hDGdrjZRMTmJTa+qrXcqfbXmlBVSHizoXHtqKquPQm8fqCiDedPKRoUdUI51Ms
         xCUvaj3WF8cabuyksI/l6t/cGv/Hg6XcI+fa4kXJ/42TugC0CRXHXO70vOkHmtgxAsOf
         IkvQ==
X-Gm-Message-State: AOAM531/DEhS5r1G/qRkxIdQTQtYaDopcqp2nkw85pvxuHUc4onGhyG9
        X35OTWzFnE3Z7wXBR7oM+AjuyityouUnqIbx
X-Google-Smtp-Source: ABdhPJzFaeRerk+4Kig7ACsXpIlV3GTOkgzPUm+mNqfsVO7e8+GX+TmxBk4xAsVHgsTt4p69/tgMQQ==
X-Received: by 2002:a05:620a:4e5:: with SMTP id b5mr4157254qkh.255.1607019798714;
        Thu, 03 Dec 2020 10:23:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j21sm1871512qtp.10.2020.12.03.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 10/53] btrfs: don't clear ret in btrfs_start_dirty_block_groups
Date:   Thu,  3 Dec 2020 13:22:16 -0500
Message-Id: <f9fdc9fbc96c18f18e709bd065aa109f94924453.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to update a block group item in the loop we'll break, however
we'll do btrfs_run_delayed_refs and lose our error value in ret, and
thus not clean up properly.  Fix this by only running the delayed refs
if there was no failure.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 52f2198d44c9..0886e81e5540 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2669,7 +2669,8 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 	 * Go through delayed refs for all the stuff we've just kicked off
 	 * and then loop back (just once)
 	 */
-	ret = btrfs_run_delayed_refs(trans, 0);
+	if (!ret)
+		ret = btrfs_run_delayed_refs(trans, 0);
 	if (!ret && loops == 0) {
 		loops++;
 		spin_lock(&cur_trans->dirty_bgs_lock);
-- 
2.26.2

