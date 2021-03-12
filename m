Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EE2339854
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbhCLU0n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbhCLU0U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:20 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D2CC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:20 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id a9so25669207qkn.13
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d84BgaY9R9ceG+dXRonWeoL2a6UDUwP1QEl09QHsrz0=;
        b=P/TnwCMKQ1CHs+Jm1HxTPXVyRIXHe7Qu3yx3/3JeHvIF3Y5cKUzIsHZrdkLzlgzcom
         FNoR7utLQguvb/lzduLlFApvBJBmqHFamTR59jKJbNh75A85Id+Ty5vpQ/DUrEiwyu5o
         OvFAWrNIgPTlojwbWgnxFkTRR7GqJXimuxyXHsAUYKf7d227iSTI6pHRAI6oKk6YQyja
         hAef+ZuLaDjbSg56GB81QExgcz6R6U9hBTL7PtHMwP3ThLNweMAN4YWyIt/c1xtvtVmg
         E+URtZTR47+uYeaSO/9CbhnzM8rqEwmxRFF1qyo510ByYRqY9dQCvtF48VxEZWHqYVfu
         NSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d84BgaY9R9ceG+dXRonWeoL2a6UDUwP1QEl09QHsrz0=;
        b=Kti08l8yT2XQEqCHNzF7id6NsNKxN+x2Z0ZnpVuhtlPwwmPUv1UmVE11QM9tvF62OZ
         r/POybcuN8ZRTprOXeMb8/mGzlHfAjwDzYHkH36VBjOi01ZthQJ1OEPXvuXSvgg6I+Gh
         a1WP2JzwZIBv6/D2L5Dio0L4SCtfsC1PKMB1GPj10GwTieSjREFIkFITic5l4YbJH1OZ
         I5Ea2+dVc4KEF9yVaWCE+wLVVTJCni1Bft2eTwyobNRrrhD+Qf9qo403X2b/xf8KZg4Q
         0izMf0yeOFCM2hDxrPJF9iXFQzq9qrwc7bCrw46i8sCUKEl5bTw+HLK0MP1ZM/lCV8U8
         RHTA==
X-Gm-Message-State: AOAM5322Srd9oaL1nwU1+ses1qS460FWstVsSDF/zCSbvKSOT7QUCwO6
        yjGNUs+44ETWibllAUuWtNGmmJcgvejvcSar
X-Google-Smtp-Source: ABdhPJyjHn+pZmT9+aixqAyvGh2+B+GUlz4E1yNeSl467c2otFIGyOF4r96sQKcGuslmZiWEdq5p9w==
X-Received: by 2002:a05:620a:2f8:: with SMTP id a24mr14696719qko.124.1615580779679;
        Fri, 12 Mar 2021 12:26:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g14sm5126742qkm.98.2021.03.12.12.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 28/39] btrfs: handle btrfs_search_slot failure in replace_path
Date:   Fri, 12 Mar 2021 15:25:23 -0500
Message-Id: <1c88a3767122bd97acc2f6370cbd046bee05ff2c.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can fail for any number of reasons, why bring the whole box down
with it?

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 592b2d156626..6e8d89e4733a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1322,7 +1322,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		path->lowest_level = level;
 		ret = btrfs_search_slot(trans, src, &key, path, 0, 1);
 		path->lowest_level = 0;
-		BUG_ON(ret);
+		if (ret)
+			break;
 
 		/*
 		 * Info qgroup to trace both subtrees.
-- 
2.26.2

