Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58601AD223
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgDPVqk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728445AbgDPVqk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC40C061A0F
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w11so21212pga.12
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KgrlD/bFbuJ+7ycGARpz9SjCx8tAPM2/16UcN5GB4v0=;
        b=AHuZiJ/IT0n10haLQJKannFT10VsuDGjHlGrZE2TWWxDKo/wulFag8Az7bg9Kv4bwj
         PuC5vbVvkBZ+JeOuqv6ecMG5wjqc2a8CeAGiYhk5LqAvHWxq8roFJKTPvLEksyTHIBUx
         xG2V3TpaDc4+7IPga76/VZ7pZSA7V4XuL/Ssg92TOKvvyYYinMRpLrQOK/ijs1jL4YDP
         NCHLGrDZAIyvmWJBQjMKK/TNruZHR1+Uy+1Vt5wzAZu1Y9j7uyj9YasC8FgUchfniacp
         BqiXAT1elyXsoD4WDv3VP64mUMdXmOLJqmt7sxGvoX1npzxYXLZUw9+VKVulMCRQY4U7
         UXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KgrlD/bFbuJ+7ycGARpz9SjCx8tAPM2/16UcN5GB4v0=;
        b=Awyl5N8mFjPbfSZTWTpwd1FzKYg6hho9F5+HMIGXtb1U2PUR4jhS5EFoR2RINNjOwb
         HMNQcTcx9F63JGQcRQNTPRHQF6hZ0FG5u4o3CGZJmA7kpibxi9JjbQi2/c8cHT6HIBtt
         pMHGCf2fYXDPts6lXqddCOeRg11WTx4M6alYMzF7FV2KfD8omg5vT6RTWeo21n47W00M
         EeHzoSllACU9nFyPR770egjcMgoZqJRuhrAuVsiQd4Ox/mGnP24inPkkFLBqrep9k2as
         dcd2v3skYif7Dv7Zy9U+VzvcVFdXT9/eVsLIKYtdcpRBAsdaf7yPo9gMNucOJdlTd/y5
         w4Mw==
X-Gm-Message-State: AGi0PubmcfS2SvMvZ7nRS+UO6WoqRMoYPg++x+c6q5FKj1T9Sz3+ZaNL
        x/lN50WQyFcxq/5B+R+2tpFsQvz4Yqo=
X-Google-Smtp-Source: APiQypJRG+qprwH3A9ByVRVAJGg6bv4AXgnOCXiJYunLF/x33aPZl8DT3LX82nbP7z7fMFKzakAu8A==
X-Received: by 2002:a62:3784:: with SMTP id e126mr14559469pfa.303.1587073599269;
        Thu, 16 Apr 2020 14:46:39 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:38 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 05/15] btrfs: don't do repair validation for checksum errors
Date:   Thu, 16 Apr 2020 14:46:15 -0700
Message-Id: <a66720d2e8acfb7370e4eca6ce3db87f847f9046.1587072977.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587072977.git.osandov@fb.com>
References: <cover.1587072977.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The purpose of the validation step is to distinguish between good and
bad sectors in a failed multi-sector read. If a multi-sector read
succeeded but some of those sectors had checksum errors, we don't need
to validate anything; we know the sectors with bad checksums need to be
repaired.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/extent_io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 712f49607d3a..25dd42437cbd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2640,6 +2640,14 @@ static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
 	u64 len = 0;
 	int i;
 
+	/*
+	 * If bi_status is BLK_STS_OK, then this was a checksum error, not an
+	 * I/O error. In this case, we already know exactly which sector was
+	 * bad, so we don't need to validate.
+	 */
+	if (bio->bi_status == BLK_STS_OK)
+		return false;
+
 	/*
 	 * We need to validate each sector individually if the failed I/O was
 	 * for multiple sectors.
-- 
2.26.1

