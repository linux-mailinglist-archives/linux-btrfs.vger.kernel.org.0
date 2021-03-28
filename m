Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF61034BAA5
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 06:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhC1EVd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 00:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhC1EV0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 00:21:26 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB31C061762;
        Sat, 27 Mar 2021 21:21:26 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o5so9402753qkb.0;
        Sat, 27 Mar 2021 21:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+s2ZHU4MLGwgPKXvljdliWpBcEZHkmbEZLjfYsEP/0=;
        b=WeT8Ko6IQUX2cug0963eXwC7iC3m/fCvQ0pD7X64n100rYt9ED/3TQAWwg4iRc6EoE
         89Y+PC1phZcqhZyCMaN9XtgrdBKleoQMjvenTM/hcUk0OQH/au7zTj1ZrKJ6js1P8Tbn
         KCdt4oqkrLUwNQly87BRrIhaE0r1IlFAocOA2tI6G9yZycPzhEqNarjSxW7EbwyG6N6G
         EeU2SttKFiMdsNC/+6TvkHUKTgYfVW1CS9cQ4aeKhAC64eH+jW7IThDPf2RcDvJUWV8F
         tnW9a35Rske2s0PkYwHN9P/BYmcHjz86uObA35OTO4R06k7zUurVQaLf6b5zxmexa1pZ
         cr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+s2ZHU4MLGwgPKXvljdliWpBcEZHkmbEZLjfYsEP/0=;
        b=iHqDjMiyz0/8+InrsJcuWovS1NBe8uZOhNh1tj+T9VRK7pI7McNFQ/VYCuceIyduMW
         H3QjIhcrV8sMDXyM60BW0va+Pw51gURO/nW3VTTIUqRCzYreWS4CDfOKkLRW36FO+Y+C
         7ia7ZrZ+5cG/dYCyun1EmTwZggbi0mmZebNU2dbN1PVC6x5CjoDLEFJJndLD0CfR9/VL
         Rp8Kt2cbp1gViJerwYVaHxqQYq2V4Q0iPAbsjwjbk7XITSHRgU+uptN1WvRWHOHA+cF1
         nrX8/5Jgj3BqDHqqludsuo/g+EkUeOZCE7dyTSawzxqRTC9YyqN2N5BSUaEJC9+eeWIK
         7zeA==
X-Gm-Message-State: AOAM533mTRlXpW0BlA2CI/0kes7waG7p1xRCNMXVrryWCM636MJ1n9vK
        4xKJ+QkBkHOOrvVyu6h/uEU=
X-Google-Smtp-Source: ABdhPJzzYusB6538+ZVzYEUTF/ZAC7Aj1ztKQig4Z6Ojh+EZWfPsoZqXtPIr5TbuSnIx8NMFH5HGLA==
X-Received: by 2002:a37:589:: with SMTP id 131mr20187750qkf.97.1616905285694;
        Sat, 27 Mar 2021 21:21:25 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.118])
        by smtp.gmail.com with ESMTPSA id i6sm10092237qkf.96.2021.03.27.21.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 21:21:25 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] zoned.c: A typo fix
Date:   Sun, 28 Mar 2021 09:48:28 +0530
Message-Id: <7eb66663f50d873df4a7290ed316802885729c30.1616904353.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616904353.git.unixbhaskar@gmail.com>
References: <cover.1616904353.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

s/beggining/beginning/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1f972b75a9ab..d6cd0d4eb1a9 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -383,7 +383,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 		}

 		/*
-		 * If zones[0] is conventional, always use the beggining of the
+		 * If zones[0] is conventional, always use the beginning of the
 		 * zone to record superblock. No need to validate in that case.
 		 */
 		if (zone_info->sb_zones[BTRFS_NR_SB_LOG_ZONES * i].type ==
--
2.26.2

