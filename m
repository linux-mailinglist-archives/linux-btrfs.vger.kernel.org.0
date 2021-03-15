Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9BE33C09D
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 16:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhCOP4u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 11:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbhCOP4r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 11:56:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B159C06174A
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Mar 2021 08:56:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t18so9024816pjs.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Mar 2021 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0QRKWzYD02wz9MQzXvIt8Lh3btE5/2DeGwizYTNOvtU=;
        b=P30pnnjPtlmHeQ0eraDNoWz0tq44PHYmyO9LBVkOrh7YKlQpLMqVoy452Ub17FNNZt
         SddVzG7M/v27sH5aWzmoXa3JEA94Rv20UaEPZtMl7DvLEMan5li5k/fZvW/LKJDHhiav
         e7gqzPD1ZL8GRncq9QiroOrSXnJbuLU85LYtQ0LIIwaGrCq/dkL4lnoiGAH/w8TMoqjT
         J8/+5GMT9HPMiDs7shO9s9LTHevPmzmXdho9cEO5tS4VHpWh9ZZ/nEhCV49KSGUFIm7s
         w+Ibb7NH0RewLPKNVBaIRG6ZAZbWUw0s8OiEB1UruAahX2RUCJsBur+67yUNueEqhDHd
         RVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0QRKWzYD02wz9MQzXvIt8Lh3btE5/2DeGwizYTNOvtU=;
        b=k3s0wOh/PBkKf87DvoypUhrDgsyaRHnRySheZILqp0DeORBYQb7fbywAUBvNnsDSW+
         ZwAln2TigwSWuG14gA/7zR5nOmw+jxMrH5wFa8In4qAxY7QYuUvYJyg7YORyMEexEjsL
         lASTkIw/1GMMmGnHW0zsCmEJhmSeiGdw1+VGAZYQpIxvEbVptjkBA/L2/yO8pm57Yp1p
         wmQxbSUd5sW2AKdvZGX2RyLptt6NvJhD9mZQR6RY58NTTInIzu0uKIqiPcyywf3VaVX/
         j5Sll42zgUSouNCPvPHTnphHTkaWsGhtJ5uB9E8qXBRlGxkHe1BsecZkh5bZlYW54mxI
         gfQA==
X-Gm-Message-State: AOAM532vvKd5wSXls5WXr9eHZPZZCQU1bEO+gg0UWjMxHPWl2RtAba4p
        UKlizt7TH+mtbsKFdsKgkP9MD5HMWXdSeA==
X-Google-Smtp-Source: ABdhPJwKHqGMxPXjpR3J6KXS1ZEXDWqOUEvTG+t2fR2Hq8zGtzaK1C72eyNnNLxo9zO+foGMI8cV6w==
X-Received: by 2002:a17:90b:310b:: with SMTP id gc11mr13680316pjb.186.1615823806605;
        Mon, 15 Mar 2021 08:56:46 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id l4sm13724620pgi.19.2021.03.15.08.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 08:56:46 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: common: make sure that qgroup id is in range
Date:   Mon, 15 Mar 2021 15:56:38 +0000
Message-Id: <20210315155638.18861-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When user assign qgroup with qgroup id that is too big to exceeds
range and invade level value, and it works without any error. but
this action would be make undefined error. this code make sure that
qgroup id doesn't exceed range(0 ~ 2^48-1).

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 common/utils.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/utils.c b/common/utils.c
index 57e41432..a2f72550 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -727,6 +727,8 @@ u64 parse_qgroupid(const char *p)
 		id = strtoull(p, &ptr_parse_end, 10);
 		if (ptr_parse_end != ptr_src_end)
 			goto path;
+		if (id >> BTRFS_QGROUP_LEVEL_SHIFT)
+			goto err;
 		return id;
 	}
 	level = strtoull(p, &ptr_parse_end, 10);
@@ -734,6 +736,9 @@ u64 parse_qgroupid(const char *p)
 		goto path;
 
 	id = strtoull(s + 1, &ptr_parse_end, 10);
+	if (id >> BTRFS_QGROUP_LEVEL_SHIFT)
+		goto err;
+
 	if (ptr_parse_end != ptr_src_end)
 		goto  path;
 
-- 
2.25.1

