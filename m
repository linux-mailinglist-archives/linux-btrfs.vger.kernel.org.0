Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F8F2908E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410448AbgJPPws (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410441AbgJPPwr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:52:47 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C56CC061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 188so2256368qkk.12
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ghpm1rFe6nXWxZmYL7Uxj9Jqwlby9jiSGaEhStnXm2I=;
        b=k73zDfswD6w/Q8ifujg1sQV2nyOOQ6JMxdlQfXrrThf/waWRpq31vX/P969XP7bfAH
         YQteAhHYZ75uuVG8rhCkKWb5MfeHYzQyptee9gobmbE+ZPh8YbhkzhabdUq1bHsJ6hBB
         FCHEskHV8rUzE7zpE50GTLLHtYgaxHiSmb9wEyq5A9Nf+iZ6ESscglKcn6OU9UkXobQx
         B0NKpzpPuxNaINr8cFf0R4YE2GetPYFDsYoyLArUexpTlRh9CwFV/HoixCSa00BLFeT1
         soYFXDsMXXYZWhQNkYsaIGumgLj1SXnInivMew1l2NgvJ9pQMeWl+WZilCqhh5Lt5iQU
         5Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghpm1rFe6nXWxZmYL7Uxj9Jqwlby9jiSGaEhStnXm2I=;
        b=bYtrNawrZfwMRLkageO6EeiK+ULrM06/rthP5XpXIuCUiPGs8PiGaWdbinRA1ka0q7
         B5qpXMs8WiWQu0Y60TO3VlPkKt1FVGAQj8KtEM2WQN47JS9waAPboNCvgeXIEdD1xc8N
         RLHYhD5dSnJl/mNmRhCHuH0cT/BJw7Q+GLQgUQ0KOj18iZ2fotY+9Iw9peVCia2HW4Ho
         YGlb+Z1PkBLq4pC3xgw6BBWOBmUGHSAiN08+VCpIm8GYI9LpR/2zJM4cnyjeO2ZwhBCP
         l+bKdVkVT/VlUHF768mjwDqC0u4pukr4P/jaWlKV9T+p3QtNr22HEDEMKOXRaOybG1UW
         Kvbw==
X-Gm-Message-State: AOAM530Tt5z4O7Yf2qBWPsV5mwlqtPXWNnpzslHMonNUg1E4BTFxU4Ri
        /xmh+3dNIMsEQYELCJh00lN14MS7n3q/uytY
X-Google-Smtp-Source: ABdhPJzLq6QiRcQ6vaH90Bas5Pt8zmVdm937ZcokHa0IoEvrQDa6m9qEbGHoVbyHp7CQxZ23IpLxcQ==
X-Received: by 2002:a37:2dc6:: with SMTP id t189mr4510588qkh.394.1602863566213;
        Fri, 16 Oct 2020 08:52:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p5sm1160641qte.95.2020.10.16.08.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:52:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 5/6] btrfs: stop running all delayed refs during snapshot
Date:   Fri, 16 Oct 2020 11:52:34 -0400
Message-Id: <b11ef0601aeee9cfd98347e1bf74b68473c9ec3c.1602863482.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1602863482.git.josef@toxicpanda.com>
References: <cover.1602863482.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was added a very long time ago to work around issues with delayed
refs and with qgroups.  Both of these issues have since been properly
fixed, so all this does is cause a lot of lock contention with anybody
else who is running delayed refs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 1b6fef512121..93006da039a3 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1650,12 +1650,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
 	/*
 	 * Do special qgroup accounting for snapshot, as we do some qgroup
 	 * snapshot hack to do fast snapshot.
@@ -1703,12 +1697,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
 fail:
 	pending->error = ret;
 dir_item_existed:
-- 
2.24.1

