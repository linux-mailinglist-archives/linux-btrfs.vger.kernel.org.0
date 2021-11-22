Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536AF459717
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 23:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbhKVWHe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 17:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbhKVWH3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 17:07:29 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C7FC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 14:04:21 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id gu12so13489210qvb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 14:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JtfLawQ6+982U/+FVo7vvfcLpdg1QfhSOB02c3boJew=;
        b=zcnWWtb56WYwkAfu4DM+ygr1Jxs/olDDwB8R4ZjtavuUcL0t4Tk3LV5adSGf/+IuKn
         MRpjt5JNpgLlvAn/FmjROR+UNaYj9lTDT0HP8GoX8RTlTvlhy3HGIQRUy7J4TA1xRYK1
         jukbgZHTwQW+9N4DDpyKfS1AeGVY5WI/9CyqJKnZmwisvHAnotZHPipUlytZxwdsYnLx
         88ELrvkGsv2ha3s4tEQnW6SEFhALGyY5eqR8X6OYXyZjJ/MY1MzkN5D0ckONfyhMfiZy
         CruXEoGZPa/S10NVgek7kqieJJisHu91akeWLh7EmwAUomX0JsJB0wPASyItN8cDhDre
         ehZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JtfLawQ6+982U/+FVo7vvfcLpdg1QfhSOB02c3boJew=;
        b=DQSqd0+/uai0QI8CWpG9IesVpw/KElU/m+TlzPObzrtNZq3p/m0lEW5JMqFXalxoux
         of8qc7IfFZSD5pqGMHAa9+bg5u5swl6dKENrJyoGzNE5khGEAD5dou8dFR2SI3QPJtGS
         vL7WN/0Fxa1ePkqnWmSc7e/wqm5G7xPAYBazOd3nexEug2WkneuIR/sxuRhxm96BYf10
         8Sk/xqmH4/ckAkr/ycH9RGvoqlScLTVFjYIyUk2T2w6Zy5UlyzY15Hxv+qaQLSXKKRnM
         bPQauXp6CoM3gCEv4URjkZS57+3ewcSXLUR9faoUM3h2cUJ8MFCbCm4265s1A6yvOYvR
         ka/Q==
X-Gm-Message-State: AOAM531RYZJIlOW+SeEQKrdDB3OVjDtGkJlEoo7UNsSgFgmkbczDfsy+
        oXHHuotX1LhANFrjZYySNWHZpRdEkScgIw==
X-Google-Smtp-Source: ABdhPJwkUdZy4EYbIKAHm7irvKg7dhYrz2TChbG+pmI0NDYhzOoMIgFXzsIWSXMba0Vy8U82/1N3XQ==
X-Received: by 2002:ad4:4e49:: with SMTP id eb9mr102977425qvb.22.1637618660800;
        Mon, 22 Nov 2021 14:04:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v12sm5313713qtx.80.2021.11.22.14.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 14:04:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fail if fstrim_range->start == U64_MAX
Date:   Mon, 22 Nov 2021 17:04:19 -0500
Message-Id: <3990fc5294f2a20a8a4b27c5be0b4b1359f7f1a6.1637618651.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We've always been failing generic/260 because it's testing things we
actually don't care about and thus won't fail for.  However we probably
should fail for fstrim_range->start == U64_MAX since we clearly can't
trim anything past that.  This in combination with an update to
generic/260 will allow us to pass this test properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 13a371ea68fc..6b4a132d4b86 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6065,6 +6065,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 	int dev_ret = 0;
 	int ret = 0;
 
+	if (range->start == U64_MAX)
+		return -EINVAL;
+
 	/*
 	 * Check range overflow if range->len is set.
 	 * The default range->len is U64_MAX.
-- 
2.26.3

