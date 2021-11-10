Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36F244CA6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhKJUS0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbhKJUSW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:18:22 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F112C061766
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:35 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id i9so3705402qki.3
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VqlW8Ff7L0gtbA1t8/6orQznL1yuBGiq9DS1EvM7OV4=;
        b=syw13GvioH7GNQo1fIrziZEb5VBtIIvf+CWAzWk0wCZa+XTVzVZPhUS8yU9mom33tj
         uM2zpXNJk+UP2f8e2k47fp5aGaqIhVwwlLnnByiJLS9t+XLfwJl8EPXljKNxooHCgKrM
         vRhqUA8h7ckPmwyRevMsXmcZg1aCQo6EtI6wjx8T6xJpk2ArE5wlmMzLRE8WZ617BTFh
         soaN1taNA8uYDQnNY45yqpg+nNYsx1WEQZyA+43ynWy0EaFPtsloUmmxwQxg0m15wlHR
         Ln9fzyOKIp7qiayOXEq1P75S1T/+I8bhlcf52h1/aR14D0b70dLoz9toYSTQ93w/sB8p
         888g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqlW8Ff7L0gtbA1t8/6orQznL1yuBGiq9DS1EvM7OV4=;
        b=eEn6jSohPo796ETv3BMzaHrhwSCw2UoBxku9dC4fewLQ0MZY8b2jOLUx3TcuGTjxga
         zNYuTGS5JsR6u6tn7w1OTciQGFpdbaij0Mgna3L1Yb0wR8wauKT3yYxUsEi+vEtFG4zs
         ZMZNlM4TiKRJti5sIcFDyWLdOk8BlLD/2laXKm5rw61UGsRxLpmFzKctj3qurOV1tXe9
         AaoF0pcsxtTmxjRZLjiaM+s6cXvB/LWC92qxSB8teiKPOphsDetmiPrUkq8iNCuylj5a
         cEIgLmH6Zy4y0UdECKIx+Y9P1w1q9KlHkqoMXfVAlQp9QYYA5yyUit5iKU11cVOQO6FC
         FkEQ==
X-Gm-Message-State: AOAM532EcuSk8F4dr/yMb+oDmFGgPeh5y1MPL+3l3LBCiDL8R4i5yeyV
        MgfQ/6EgQnTC0TFbvYWnodeOnwMN5HzsJQ==
X-Google-Smtp-Source: ABdhPJyRCWbCodUymuppLzIgI4ZmPUfi251pvPLil8Zpcv7q64rVJzCkyQhdrTBnLHKrdGXh5ExGTg==
X-Received: by 2002:a05:620a:430d:: with SMTP id u13mr1749020qko.93.1636575333963;
        Wed, 10 Nov 2021 12:15:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x188sm385891qkd.31.2021.11.10.12.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 30/30] btrfs-progs: check: don't do the root item check for extent tree v2
Date:   Wed, 10 Nov 2021 15:14:42 -0500
Message-Id: <837bbfcf023cc9bd88ac1673d69260eb0e57789b.1636575147.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the current set of changes we could probably do this check, but it
would involve changing the code quite a bit, and in the future we're not
going to track the metadata in the extent tree at all.  Since this check
was for a very old kernel just skip it for extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/check/main.c b/check/main.c
index c28fa2f3..0bd87685 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10065,6 +10065,9 @@ static int repair_root_items(void)
 	int bad_roots = 0;
 	int need_trans = 0;
 
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		return 0;
+
 	btrfs_init_path(&path);
 
 	ret = build_roots_info_cache();
-- 
2.26.3

