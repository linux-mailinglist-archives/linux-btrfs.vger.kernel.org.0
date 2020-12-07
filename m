Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5222D12DC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgLGN7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgLGN7x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:53 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA1EC094254
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:07 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id a6so6965263qtw.6
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8fTlPURwi1njot0TAiCWtZWFXAYhGZrv+pY5V3rdfo=;
        b=FWQa1/NHcQZgk+D/iMZyz6sDD/y5YdcatgLncU8LIbQuuYzIi5qn/8YsyzhlMuL05n
         Y7DVPc3kOF6408skfCJd4+m0bcrjXDOSpo0b6C391iPQ0SQ3p/jvIyOugolNJDj3i2Hk
         9DarFBhMzCLXMNiTMyZZWd9YjFIZtfDNtYE22Mr6O+i4jdhjJdHS0xfakv713IYIWHaT
         ukl4IAeYmVTBYoOwHjBgC0p8D5bUrDMogyywMX6e8FA6hA+vJ1y+9DSjhaXQfZYTfmZg
         E78l5iHiX4wK+4o9bY/ggQzKJirGZMyUZw3duvzi6bTYDMwXFxNz87hmPmLzYKsd0h4I
         OMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8fTlPURwi1njot0TAiCWtZWFXAYhGZrv+pY5V3rdfo=;
        b=en0p0ZZnrpyhk2fr9OlY1DDy7+Ubjrz/CyjWBIdxy7nTTuH2Wqr2AFUnoqSDfNm4H0
         MYe37YpETqCWkw6MWGMLsGwfqCTEi4PoqAD5EUwFGEc1nuhtkCgcIIcrzJcIxv5KP61a
         MSVscQqO8q3vA4J6EMNwP3LHN+yFnsxIDt2tlYdWbq+S8hvEbPI/hkiNBD6LO82KfxBe
         nEWHO+1PbnUX4d+oKvi/7NHeKXTUvtBIAalUnwAkidUgh6HSwwuZYw9G/DTJ66B7PSgp
         rKgUt7am0+WujhB2R4vhRS+p/pmwYL6WZycMcNHzqcu3+TGbeKohpSfj5rgM64VgG7Yc
         /D4g==
X-Gm-Message-State: AOAM532326vHjq2BqG+3m1UgwlqCIMkRIA5YZNMd3G6L5FeNyBwbFnww
        g95D5gq6/H0//bjPc2Vqx63gg5vpa+6Ly9Wq
X-Google-Smtp-Source: ABdhPJzPx7utGaiyO05TLUlXXNDTLnW08X7XesJMLjyIZvXB/W3B9ZEz5r0B/j8OSc4fq0Oi1lCyow==
X-Received: by 2002:a05:622a:d4:: with SMTP id p20mr23094693qtw.172.1607349545946;
        Mon, 07 Dec 2020 05:59:05 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l79sm12124294qke.1.2020.12.07.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 41/52] btrfs: check for BTRFS_BLOCK_FLAG_FULL_BACKREF being set improperly
Date:   Mon,  7 Dec 2020 08:57:33 -0500
Message-Id: <488d199dbc5d462d1057712d2fb6be2b9acc1e9a.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to validate that a data extent item does not have the
FULL_BACKREF flag set on it's flags.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 028e733e42f3..39714aeb9b36 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1283,6 +1283,11 @@ static int check_extent_item(struct extent_buffer *leaf,
 				   key->offset, fs_info->sectorsize);
 			return -EUCLEAN;
 		}
+		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
+			extent_err(leaf, slot,
+			"invalid extent flag, data has full backref set");
+			return -EUCLEAN;
+		}
 	}
 	ptr = (unsigned long)(struct btrfs_extent_item *)(ei + 1);
 
-- 
2.26.2

