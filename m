Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D893F0D61
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 23:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhHRVeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 17:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbhHRVeG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 17:34:06 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BDBC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:31 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l3so2785614qtk.10
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EdWuxGz2Ar74vTm/hoJ2d5FS5D/XPpntpdTUUgW4DIU=;
        b=TGxYKJXkm2b9Sfs3i/c39NndOHqrGSkZCzpVu9Iv86cL0hLByKk/5L5MLb4MnZIems
         Is3lYNkPWS9iBDipUA5NlR1Rm/PrhGOK6Ru/lyxw0Uspra7ybO7DeJxG0nqwnTJa4FmQ
         x8XBnkZjgRucCkwN+hS/1kPsNT/gABgZYQ0oi+MaPH+CFk+OvTk1/WPP3m0WvpsmcqW8
         DLZFXskbWGdYv6cPwqofiMBIco6imCNerYMQXOcHfUaZjPCv2+V1lLlyt9ipGx/GGBP4
         /fzqr5cSJlSbUk15jBhs5HmLP4J14ZEkRhGIjWm+4iAxUws41/uEpylUQDyUH80ur85C
         wLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdWuxGz2Ar74vTm/hoJ2d5FS5D/XPpntpdTUUgW4DIU=;
        b=QsZSV4it0abisDO7139eJxxMooeQEVzvmzzF6hyR/Kf0LycKywSJUzZuSpxX2wMOf9
         Vv3uGz8LZ5vsZ6VUPxRWhOSfLkaEJ0tJgCxG2ArTLtfKpwB/WHCUSK16tIzDwu1H6Qnh
         H/UQwlr6jIbJGh4SNPi+FbHdFwXj/5Ph5/eZA/+69wjM18OL3k3RIxvxi436jd9EV1ft
         9HI7Z2n/PVef83eBkuZJRaxq/DstMMrqsgcH6WXheAZSvs36cGPySKjS9rrm+HnIdTJu
         SjoqySrZ5FhNIIQd9HCmPcDNaCg7C2NB3gk0LdhQMRa+dDvdQZkRTiawawFQ8TiRx3sX
         5BmA==
X-Gm-Message-State: AOAM531s2h6NW7WxBwEmr4ol0jkRDoP9ypzmm2m17KqmOPyD3xF9KZda
        sP0pvz6SwH4zcIiTN0W743Fn2C4cuC3R4Q==
X-Google-Smtp-Source: ABdhPJxsFoWStCKrzRXfDnTMQJkOrPZ8Xqqq3jbsEkl3CcHJgm/y9aK0w/jdQToqaJ7Ted8Nxud84Q==
X-Received: by 2002:a05:622a:353:: with SMTP id r19mr9765958qtw.3.1629322409978;
        Wed, 18 Aug 2021 14:33:29 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q7sm559911qkm.68.2021.08.18.14.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:33:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/12] btrfs-progs: do not infinite loop on corrupt keys with lowmem mode
Date:   Wed, 18 Aug 2021 17:33:14 -0400
Message-Id: <aaaf2cadf66d9e573e2dbcc3e8fab7984ce42f99.1629322156.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629322156.git.josef@toxicpanda.com>
References: <cover.1629322156.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

By enabling the lowmem checks properly I uncovered the case where test
007 will infinite loop at the detection stage.  This is because when
checking the inode item we will just btrfs_next_item(), and because we
ignore check tree block failures at read time we don't get an -EIO from
btrfs_next_leaf.  Generally what check usually does is validate the
leaves/nodes as we hit them, but in this case we're not doing that.  Fix
this by checking the leaf if we move to the next one and if it fails
bail.  This allows us to pass the 007 test with lowmem.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-lowmem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 323e66bc..7fc7d467 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2675,6 +2675,15 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 	while (1) {
 		btrfs_item_key_to_cpu(path->nodes[0], &last_key, path->slots[0]);
 		ret = btrfs_next_item(root, path);
+
+		/*
+		 * New leaf, we need to check it and see if it's valid, if not
+		 * we need to bail otherwise we could end up stuck.
+		 */
+		if (path->slots[0] == 0 &&
+		    btrfs_check_leaf(gfs_info, NULL, path->nodes[0]))
+			ret = -EIO;
+
 		if (ret < 0) {
 			/* out will fill 'err' rusing current statistics */
 			goto out;
-- 
2.26.3

