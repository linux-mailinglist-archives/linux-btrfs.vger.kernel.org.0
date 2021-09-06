Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F2F401C57
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 15:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbhIFNfp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242482AbhIFNfp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 09:35:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9688AC061575
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Sep 2021 06:34:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c5so3958380plz.2
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Sep 2021 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwloAR36W/p6vXlIWIqtNOL/yOJESCe4TSraHJC/sx4=;
        b=FrBrUDfgYkRPOgIBVTcr/RwEdb4fw5TORiuxdVmk8FfHk7bYvPTNlfAfcGns8lJm4A
         ly1CPZq9vZzDJQOgUa2k3QmZ6LMGdSGzpJ+0YVb0ik1r7iRUL8SsdNT+MvGYHErWZ0NA
         6sGkfbwYgCcmZTIdK8NLgLZqIoo8NWDupygNzgSXwT1SAaY8kZ7PC1foEFx+klDhA+4l
         orqrcd7+5pap7JOWx8uZqcYNjfWWRy0nmIvehLGj/x19LIJ2JAJexLcHmPs5Li520K8a
         mIKdKsttKhicB+F1Je6USgcmOTy65X9nV2nmyA3Rt0r5CAuJ9rVTiPvc321id94aIK5+
         RDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwloAR36W/p6vXlIWIqtNOL/yOJESCe4TSraHJC/sx4=;
        b=PkevsCtY9IWhCpHf4AKt8Utf1saBBCQdfrGXonyj18aN62ZHICo+v9cDDn1TEb671O
         UmnX7qrKlAQQdcXEuf1zse21wuN7ytlaFKrDAszQxSUf9Jmq+sdj8WYQx02n6lZEoR7A
         /1OhyH7g9140La7UKbW8FrDLw7MhKIL+D4g87VkqoY5SgMoNUpHELlERPU6dKfhWVPT0
         toKf7PQzwg4J1/f4idwmO3W7SYe5dYdTIb8eLxqUml01oA43MeHEKkPbYGOemMhu2R8s
         89we5Rj2MSl6Nv5Jp7SkGxIi2pF9BRs4mPrD+ZQRIUJQ8VqB+BXIthMld3RWTxRB0GSX
         LMyQ==
X-Gm-Message-State: AOAM532LR01qqCO1EWRyseO0cn6Tn6lydsnLp1H/503ScHKZo5352/f6
        80QUdqX5lQxIwiUJx0YRF3Z3vqMJAYY=
X-Google-Smtp-Source: ABdhPJwTY+zEORT9ODqygMR3rOeQD7vexZZVRfFJESIIjAGuvXuxkewFBYBTW/AnVAZIhT8lIhFg/Q==
X-Received: by 2002:a17:90a:9912:: with SMTP id b18mr14306407pjp.46.1630935279921;
        Mon, 06 Sep 2021 06:34:39 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id p9sm8046371pfq.15.2021.09.06.06.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 06:34:39 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: props: init compression prop_handlers with field name
Date:   Mon,  6 Sep 2021 13:34:32 +0000
Message-Id: <20210906133432.5485-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Compression prop_handler is initialized without field name. This patch
corrects that it's initialized with field name.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 props.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/props.c b/props.c
index aeb48679..81509e48 100644
--- a/props.c
+++ b/props.c
@@ -186,7 +186,8 @@ const struct prop_handler prop_handlers[] = {
 		.name = "compression",
 		.desc = "compression algorithm for the file or directory",
 		.read_only = 0,
-	 	.types = prop_object_inode, prop_compression
+		.types = prop_object_inode,
+		.handler = prop_compression
 	},
 	{NULL, NULL, 0, 0, NULL}
 };
-- 
2.25.1

