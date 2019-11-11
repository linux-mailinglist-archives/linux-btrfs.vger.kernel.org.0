Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA6C9F6FD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 09:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKKImi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 03:42:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42944 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKKImi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 03:42:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id s5so10210504pfh.9
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2019 00:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QN079/fsQ95WXf57JDbaZVJG1P10w696lhNMDZS3X2Q=;
        b=KNklETVYo5Kjer/puQWa+NvC6ncvIX3F/ktiU2KyGjVwrIc93v0pPVcmdONQLLUNJY
         hUgSVEm0FwPhpSEzQR7DeU0ZDT2dsfy+DU4aLOLDzYsY+SihW5QXZrymDrQppKuuuzJm
         uliM4zuw7DFB1XUkfQ2xEn7wQRpiGSC0BqDaMecFBvr9GzFI9jhZoftkjgHkFkOSQ0V+
         0pK27uFioIYIk3DALq9oP4Ht1/buQvo5lb54fet5tOT/nqiaTo5Veqc/5ZsVESjNfGzu
         T6Jx/hYldHXG1IqSyzC6pZCW9t72BMgDfiX7A+i+8gmXAvo97OvEPlbDpS4UT3NP+D1V
         ASzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QN079/fsQ95WXf57JDbaZVJG1P10w696lhNMDZS3X2Q=;
        b=Dd3b8nNYH/VYzeeFnQIijHHCq7r8SoosbbEec+nOLerrOwm7oHM7Zh5biZK1qf67b9
         3u2PAy06PlJ9Li4270/KneANq0N55oWZHas+WjwEnkS9IvFlKyLdYfZsccf6oBZcAV3Y
         HmDTR6dOsdaxd1KeKcducreRe6eg4jP+k39961TOn1YkYi/qntHE8KMYkAJTFNRfra/+
         bVLK/VDYlL9pz4dr3BVgRLaa1fpcoFDp72V9+4Ex6bq2sORTPy4mVv+gLfKHF4CZzDKv
         WJ37jPv3/eTeqipt/w8M7V2V4s9GnfUHYasXgp/1iIaO9WRitwIpB1q5z3ao+99ve6Hq
         TFcw==
X-Gm-Message-State: APjAAAV3zasfh2zNbTdIPJAdDVLcb8XUTiPcuZ1cjd+gy2Sqwmf7H8K2
        HjSvHWUOSFViM82X07VxEtJTcxHD3Xk=
X-Google-Smtp-Source: APXvYqwIuMjhCMVrCLOHfvjBDYcbr//+6y95Ob+VUrWSWzCA19o8BVcqn+uiKZ0RNuMRb8jzF2E5Vw==
X-Received: by 2002:a17:90a:22a6:: with SMTP id s35mr31721546pjc.3.1573461757663;
        Mon, 11 Nov 2019 00:42:37 -0800 (PST)
Received: from cat-arch.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id i16sm12771679pfa.184.2019.11.11.00.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:42:37 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Damenly_Su@gmx.com
Subject: [PATCH 2/2] btrfs-progs: check: call btrfs_lookup_block_group() instead in check_extent_type()
Date:   Mon, 11 Nov 2019 16:42:26 +0800
Message-Id: <20191111084226.475957-2-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111084226.475957-1-Damenly_Su@gmx.com>
References: <20191111084226.475957-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

check_extent_type() wants to lookup the block group which contains the
extent, not the other contains or after the extent start.

Use btrfs_lookup_block_group() instead of
btrfs_lookup_first_btrfs_group().

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 check/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index a0e5ac47c152..d18d8e9fa80b 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4530,7 +4530,7 @@ static void check_extent_type(struct extent_record *rec)
 {
 	struct btrfs_block_group_cache *bg_cache;
 
-	bg_cache = btrfs_lookup_first_block_group(global_info, rec->start);
+	bg_cache = btrfs_lookup_block_group(global_info, rec->start);
 	if (!bg_cache)
 		return;
 
-- 
2.23.0

