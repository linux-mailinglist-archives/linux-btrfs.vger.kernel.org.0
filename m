Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0674B467FD4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383402AbhLCWWF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383391AbhLCWWE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:22:04 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9BCC061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:40 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id t34so4837647qtc.7
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=auRiCBm73SRbgqtmm4dQ8LLwAEPsmUT7T76V24Lpn60=;
        b=PanWj55HtKZL/QGLTuiaKOpiaV1YQh9mbguiY5tdKnmST2FnvUED/X2pih5hmwmEJj
         IVy/XIoG2IfghGX2xtfTPhMqZwpEWJdMMlNKB3DYfQi/nS6Q7AWxZo2wRfm/hxFhSRKV
         SGnUeOZ5P2JryaM9e4eBhm8qHZ2GIerxouQN+vV9FR4WJUJ63hA/tnhmv7U+oEJAzg2T
         8O4OHHPsoAuQf+Dclpi+eFEL278yTFo4S3+98OFSXnP8gvwpoPFS7MArKtYk1Rc1lrwh
         8leBygf2FNHn0JYvBr/Ax7H5WlQCmZ8ResY9c3z7dNd0V/ojMjWksPGd7TbhN0B9ZacM
         JD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=auRiCBm73SRbgqtmm4dQ8LLwAEPsmUT7T76V24Lpn60=;
        b=7kr/T8RZL7DTVPwmNm1ZN/1YzcBuZvgSnl+Pi7A6fIXwXv6M0cKTShBQiziq3ElYtA
         zEwSga535L5oYZIWvPDi7YqVO19fKJnpfNbzRTs/7LzJIqwrGIC8nUbhKh5mKj8XGHXJ
         iYk3OMmlAfg79+1vsGZOMPURKaFFdN7QeibTd9BgyWJhf8mjcHcwmzdKF/7iyXB0glAd
         lJFK/RwlABolZrEhE1x3gjTrGWkfoaxEdZgroPg7wskHzdZSxmVqnU1KbSPDj4bRj9eD
         eM9w3yuVyuLIOWMwQrKGjBXzfQm/gUw9JDDqKosctCAO8ObEjA359cj6q8n1Lk239dYd
         9iZA==
X-Gm-Message-State: AOAM53133OCaNQD8ccFUQgTc45waPT8qNQHnuTQj0mzysE9vMHLEibI2
        KMBUFn0Roj4U6MSqc0rTAbG17y4lC3sH2Q==
X-Google-Smtp-Source: ABdhPJzcdVkTrboA5DNjjv1D8bSJUvNS+29OrTKTXy57TZ9Ft+QvAv7DTKFrYsSjdtbDnNINOBwovQ==
X-Received: by 2002:ac8:5883:: with SMTP id t3mr23555409qta.551.1638569919266;
        Fri, 03 Dec 2021 14:18:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y20sm2905755qkj.24.2021.12.03.14.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/18] btrfs: convert BUG_ON() in btrfs_truncate_inode_items to ASSERT
Date:   Fri,  3 Dec 2021 17:18:16 -0500
Message-Id: <28050d7b14a11ccf488b566192a31bbe8099da4e.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a correctness BUG_ON() in btrfs_truncate_inode_items to make
sure that we're always using min_type == BTRFS_EXTENT_DATA_KEY if
new_size is > 0.  Convert this to an ASSERT.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode-item.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index aee374e18131..652b7069f63d 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -476,7 +476,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	bool should_throttle = false;
 
 	ASSERT(control->inode || !control->clear_extent_range);
-	BUG_ON(new_size > 0 && control->min_type != BTRFS_EXTENT_DATA_KEY);
+	ASSERT(new_size == 0 || control->min_type == BTRFS_EXTENT_DATA_KEY);
 
 	control->last_size = new_size;
 	control->sub_bytes = 0;
-- 
2.26.3

