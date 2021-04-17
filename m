Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E8B3630E8
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Apr 2021 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhDQPhF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Apr 2021 11:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDQPhE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Apr 2021 11:37:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3838AC061574;
        Sat, 17 Apr 2021 08:36:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e5so842350wrg.7;
        Sat, 17 Apr 2021 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c+F4d/dEml33345nfDC4G3PoJm5Qmt0bDGgusF3hVAA=;
        b=pg3G1wezwp+QSAiQWTByKGg8AxHR1ktpMxQFkRs8iKwJ8Y86bRwAnhU0dHuiTjAEpQ
         TyDYn+vxSWyq/HQIU5CfpRHGoWQIZgAbLt3lVI+6zNCCiNJsb1d1wowfC9dcz2PY1XnT
         5vutlOnMLEMS1Xuh06PY3Y/XMjIlvlJyGq1+komGHJII8ZyNNI2HSkLZZ49pBcjUUx5j
         G3kLNVPGvLduOUeYY/00R+yb9XBmO5yKbzgvvcE79xH+UTooUK4BRnPYmXmAqlamiuR9
         DIphQNl7Q0/vgHpqmFMWUWscqhNwFNxArnmFdEsdB0Py89Ju2wR6yY0A75x7o+XDBg4Y
         Znvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c+F4d/dEml33345nfDC4G3PoJm5Qmt0bDGgusF3hVAA=;
        b=pjkuZAq7I25ado+3XuqAm54pqK4OFjFUIlyOUY592BwjsuXJ5Hrdq4thrVJ95m1B3S
         Yn845VysOmV74QPr5emXbbXSqLGG8gK+bxBCR62Sfb+if7iPdq/RHNdWG3Tq0yz+Om5m
         QQePkw1ok1NEfgGV9ZS8jvpK4llBAC8EdDaRlRPYNjBYOYzWRBxRVnwPqnDA//yMZVeV
         +uMotZ8Ungt/9MhaQdpSDGXCmUECMgtnaMuCRLBAJ7WhgZBoZXdS7BUsHvhIaRwIgtGh
         4SuABiP1HbnXHVa4ChqhhN0cDnUccMmpi0B3vJZMEW5ybdmB+lmRzpQZ1WEhOsNOXRIZ
         ElMw==
X-Gm-Message-State: AOAM531+eGZruhe+M6QDhdak2QycK576Ku0mAwZR64oKXndJOZ0Hb2H9
        2lOiic3Lqo/BBOkQe94GNmY=
X-Google-Smtp-Source: ABdhPJwj+dRgPK3Xpn2TLtvCocLIWT4HlgdYcvvZlC2n/PDqXhJK10s2yzmiUISQcxzyUPIf4bwJBA==
X-Received: by 2002:adf:e650:: with SMTP id b16mr4760567wrn.273.1618673796958;
        Sat, 17 Apr 2021 08:36:36 -0700 (PDT)
Received: from localhost.localdomain ([41.62.188.221])
        by smtp.gmail.com with ESMTPSA id a15sm14773926wrr.53.2021.04.17.08.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 08:36:36 -0700 (PDT)
From:   Khaled ROMDHANI <khaledromdhani216@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     Khaled ROMDHANI <khaledromdhani216@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] fs/btrfs: Fix uninitialized variable
Date:   Sat, 17 Apr 2021 16:36:16 +0100
Message-Id: <20210417153616.25056-1-khaledromdhani216@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As reported by the Coverity static analysis.
The variable zone is not initialized which
may causes a failed assertion.

Addresses-Coverity: ("Uninitialized variables")
Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
---
v2: add a default case as proposed by David Sterba
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index eeb3ebe11d7a..82527308d165 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -143,6 +143,9 @@ static inline u32 sb_zone_number(int shift, int mirror)
 	case 0: zone = 0; break;
 	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
 	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
+	default:
+		zone = 0;
+	break;
 	}
 
 	ASSERT(zone <= U32_MAX);
-- 
2.17.1

