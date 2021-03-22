Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E9734467F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Mar 2021 15:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCVODp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Mar 2021 10:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhCVODY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Mar 2021 10:03:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFDCC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 07:03:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id g1so6629310plg.7
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T60KB0d03USYfvn8ZEcCksaK0C0L2l0AXfe+6OCxsxU=;
        b=S7jD93ch9gGhhHS+EE7nfW9/ww652egPq9u77bzOriZypfptbtdekl35wp1CURJjJK
         VlSde8FDJjFWdWr4ajSWKS+WKi69quhm9lL03pyVa9eqSxJMIMh//RGN/u0r96agcKSn
         56QFfcXtMRhiSsYs5Z6/nysT9ZxMBUlyjI6IqKF2Bs+M/MMf5+kIbTugI47+rQpfANn3
         slwAW3ATzM3Q+jq5KUJ+Gv4QlqlSvRZIJY08tTQ9TdNZgiklz7SilnBVPX6p+RdNh2In
         qzmGMuXyqCjQxNwLfvH3svDR94FqYfzmxiqz1gjuf4VdfmynVQPAfnfsSlATD8tpdIV5
         s2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T60KB0d03USYfvn8ZEcCksaK0C0L2l0AXfe+6OCxsxU=;
        b=tBtG1SF2pp/PAMp96Tsvbzdmn6g5ilcGB+szhSLYoKjMCa3YzbJxAz3tJYl/wqX2Ay
         DEO40JwTSDoImX4UkJ+yPCycSqq4hR4AVDZaSYWREzEEKs3BTTwuujAJdt2lj50zwEF9
         ta3cTCTHwsEdFKwQIKdHSA5ZkPdyjVwqbzGFIJkjwRjdB8sT0k7Rc4pyzIiP3bIm1mck
         CqatYnCyvBcgLIeMHDsLOf6K2p3GL/T2YqxjmqzLhUjAZVPpp6+UqMm59S3gJpkS2+xI
         naP49kZgYBWr4Fy30rvgAoCcksPaIAm68h4CYXLMWj6Z0RAZUBniSi9/9LHifJuUl5cH
         u6iQ==
X-Gm-Message-State: AOAM533RZz3SDnPW6apFaqzvlwLcEqm9wcHdbEmRmWKnPFfSYvayxW3B
        rVXiGRaDGbD729zQeNUSp6TFRJocVftA3Q==
X-Google-Smtp-Source: ABdhPJzorJTot0UNq+r70JF2SwCvxuE9tfq1otdSdzAzNSLc5Z/qCT2trZFGjjX+440093oSP7rvng==
X-Received: by 2002:a17:90a:f0d4:: with SMTP id fa20mr13559144pjb.220.1616421804171;
        Mon, 22 Mar 2021 07:03:24 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id b84sm14822715pfb.162.2021.03.22.07.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:03:23 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: qgroup: remove outdated comment
Date:   Mon, 22 Mar 2021 14:03:16 +0000
Message-Id: <20210322140316.384012-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This comment is outdated and this patch remove
it to avoid confusion.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/qgroup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 2da83ffd..b33f77fa 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -81,9 +81,6 @@ static int _cmd_qgroup_assign(const struct cmd_struct *cmd, int assign,
 
 	path = argv[optind + 2];
 
-	/*
-	 * FIXME src should accept subvol path
-	 */
 	if (btrfs_qgroup_level(args.src) >= btrfs_qgroup_level(args.dst)) {
 		error("bad relation requested: %s", path);
 		return 1;
-- 
2.25.1

