Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F653704A2
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 May 2021 03:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhEABMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 21:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEABMs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 21:12:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875D0C06174A;
        Fri, 30 Apr 2021 18:11:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so2541461wmq.4;
        Fri, 30 Apr 2021 18:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xPblVCEaArGgHbp1X7XGnW+D1CWWpswQPWTndCDP/GI=;
        b=sHVQuBjXOSBuWh2JrfAgHReMokw8R2v3/fzfk5cpRU3KSpYV8w9vB/rxJUetPrzkYS
         YiVVSrHqr5KnYnReQ1xLsRva9e98uzb+XwqYR4IguT20fBzvhVC/l3D7IED5NYH7eki8
         oXcIshoTY6SZLNddkMPiocaP73Esc/hJk79NxsRKfCxan5C74PKXlWhKAubKZEqXtL9R
         SbV2r2YLBiATpuccu7EFWEDcybLAVH1c7nKSQwT8qRrl5Gz5GorEzi7ElFG5AQfb9r+B
         XNyp1+cAgjVHVwXoLOkgwmJ+t4/k6+jJGxVT2xVbj7GBlLVCGxFM8C+hNAwMtKwGnL5E
         CEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xPblVCEaArGgHbp1X7XGnW+D1CWWpswQPWTndCDP/GI=;
        b=BHQazefE6UEKn2dRCg/RU/pxqjeCT9pAr8oT3ChyiAI++N5BwTmRb8aa00U6D8+vKJ
         yCwqZr8G6c7sNC+m+eDDO/x3i+IQzW0CRpkoHSKb17NqFfs/9hrB69NtQwGiaUmLnLRY
         vfSGw/dtAHEsB5e/9mhUpjDJyOQMYcJBWGXGIyt+rW9ibxmRJyFMoGDdt+bOUJJuAmdr
         y4nZg0sMuEkj2T39I6N9/NVsbGNyqIGQWqe1G+Bi2lnSqJU/Q7EtYSqQDMUfkLIC4OMX
         GdPjWXhmPY+uLN7+vUmQZ3niOly1hHbtH0V/xniCcE1evxhCZ9sjsARj6b53wZDGJE5g
         S7KQ==
X-Gm-Message-State: AOAM530Yk9FFmTVsme3e/UXDH2AC9HCXTrCZtNca26yCUstrmPm1oVH9
        SazORtg9ERnbeSwQEuckzBY=
X-Google-Smtp-Source: ABdhPJz3D8kChOC5NxvJr0DA1jCNSsf/HtSQbVWqTUdO9jRcj/nR8Of5KWBgCnraatZIpAeaS4AZBw==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr11748140wml.93.1619831517149;
        Fri, 30 Apr 2021 18:11:57 -0700 (PDT)
Received: from localhost.localdomain ([41.62.193.191])
        by smtp.gmail.com with ESMTPSA id y5sm4081960wrm.61.2021.04.30.18.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 18:11:56 -0700 (PDT)
From:   Khaled ROMDHANI <khaledromdhani216@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     Khaled ROMDHANI <khaledromdhani216@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH-V3] fs/btrfs: Fix uninitialized variable
Date:   Sat,  1 May 2021 02:11:36 +0100
Message-Id: <20210501011136.29240-1-khaledromdhani216@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable 'zone' is uninitialized which
introduce some build warning when introduced
within the switch.

Fix that by changing the passed condition:
Catch explicitly any invalid 'mirror' value
as an assertion failure.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
---
V3: catch explicitly invalid mirror value
V2: force assertion failure by zeroing the zone variable
V1: initialize the zone variable
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 432509f4b3ac..8250ab3f0868 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -144,7 +144,7 @@ static inline u32 sb_zone_number(int shift, int mirror)
 	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
 	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
 	default:
-		ASSERT(zone);
+		ASSERT((u32)mirror < 3);
 		break;
 	}
 

base-commit: c05b2a58c9ed11bd753f1e64695bd89da715fbaa
-- 
2.17.1

