Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2D63F5136
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhHWTYF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhHWTYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:24:03 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF50C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:20 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id m21so20380913qkm.13
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4NTnmrnuFAuGNEWvPhwIfuHvYUiQatXzTkStXqHT+gw=;
        b=sqEmBO7HYk8uggXqyVQD5dHS1WDBQnqROucGMaSEBNSzj8XZyqE+lG7Q5G2oA/VnnC
         7XerToC+sIrLGexTKCnqmYofxIYZ/TtNTdS/0ypGes4bT1LRBWKMGKmJ6jbvMXZ5s++z
         ZtJ0tUfNkgkJNX01D7/wWQPaOczijyAq6O7P7L+dMho2OnqZp8hHIZ+5mXIcfPAFfrks
         5SvwZHWnHCxglVFPBP5edCEj6f6QHCgpidpZXetLMwqNye3SCGHND9Pom2eNOBzZ49Ut
         rw+ySLWUbLTC03hiyAZ8h8vbmSN5SEMTWvVRa935l3QhBPlCzskz5zLbirgknJX8iqU0
         rcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NTnmrnuFAuGNEWvPhwIfuHvYUiQatXzTkStXqHT+gw=;
        b=Cg0QJZ1nmUAKnR+1e6AxZQEsNcCFw0X8JR5GJI0YuMhpePB9FGVgrNIs5rPPkMJ6cq
         su7LUM1PSBne1Q84ANugDoH2i413SkCLI5g45sBP1kU5q5+Ehm/UZmTBa1W5bNfPqyn7
         W4BXcgu8X7c7/2uwhZaiWJJUvSzmsJe3gdpTPGMAspkDF9pU4M1A6UOUS8FywI0so18V
         VKt71tREFV7qqAqu8T9l2cIq5Nwvvy4b/SnCwy3aVFUAe+ALRK2SyRaKE1SSN0/nT1uK
         +2ckLx+tncynbec+F2CfHokV9+ZAIrxxm529RqDe8PW6NfACMhAjjdIWPzrvk9+JILb7
         J3bg==
X-Gm-Message-State: AOAM532uzjGoA9R004udPMMV464u7iniGYpymP5WyCtEx4RKcfkd/0sg
        8fX2MZwQNSpUV/RqaHo8a7ENhkjEND/AJw==
X-Google-Smtp-Source: ABdhPJyBIKQDR1z30F0cJkmQGflbHrPscSHqkIYPE0p47swvuPohNglWRVfpV2ISMGI/IyUNibx34Q==
X-Received: by 2002:a05:620a:b10:: with SMTP id t16mr23130514qkg.158.1629746599606;
        Mon, 23 Aug 2021 12:23:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b65sm9146163qkc.15.2021.08.23.12.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 12:23:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3 3/9] btrfs-progs: check: propagate fs root errors in lowmem mode
Date:   Mon, 23 Aug 2021 15:23:07 -0400
Message-Id: <4f0610522b39fb4f5e3b91f9a2302d68fda8b062.1629746415.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629746415.git.josef@toxicpanda.com>
References: <cover.1629746415.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a check that will return an error only if ret < 0, but we return
the lowmem specific errors which are all > 0.  Fix this by simply
checking if (ret).  This allows test 010 to pass with lowmem properly.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-lowmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 888894e8..507873ce 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5195,7 +5195,7 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
 		 * missing we will skip it forever.
 		 */
 		ret = check_fs_first_inode(root);
-		if (ret < 0)
+		if (ret)
 			return FATAL_ERROR;
 	}
 
-- 
2.26.3

