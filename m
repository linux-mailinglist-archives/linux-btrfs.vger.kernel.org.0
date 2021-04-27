Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE0936CA33
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Apr 2021 19:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhD0RRr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 13:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0RRq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 13:17:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ED2C061574;
        Tue, 27 Apr 2021 10:17:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k14so10343497wrv.5;
        Tue, 27 Apr 2021 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JAwJWD2K/z4NOs4JYYmy89+KMQq66aqzk+TmY4WqcLE=;
        b=LzfBipELGPmofL7v1VcLOuCmchjuoEP73ix5Ryj7QBqGAzKznB0YO0FH67waGAH3UY
         1HWiajpCaB9Co015BJhMsPTBLLvOkj7X4E2TX1V3/F1NyCaDL648anYVAVPXEq5gfKPd
         vp9jzqpsDf+8jGmGxwo/vJB2PGMOcH6Skg0aoXjPSM9XY6Z47E3Cx9g/InAFI68Gec5L
         yGEmfJv9ermo8oVfeZmSYmEB+C7418GoEpYEE+88x9W2gf46yEdbZYTUQbzkneknpOc3
         Yvm9ubPS1qhchxJ8DSucxxGskSJf3HHGpm6rVnSbqdglXe527Z/8AUO/57hqhVA9zThm
         owQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JAwJWD2K/z4NOs4JYYmy89+KMQq66aqzk+TmY4WqcLE=;
        b=L2rlhkARqVhKUy4B5X6YSSBzHor0Q9swfPpMpw3lymnkYo4WEuoyQb9cGbtgNkC6zg
         ll0oEAjYVu7OH6ULsXt2mHSoda4OuuPhZs9czyAQXpvJm/21DDqh8jWb5/6l5673XGt7
         8iQb0P5P56q90kEslHp7P4JhbwqjgUiR/jM8iDRa0DM2DlxjZogQ9tGuA4DG7q7T8uxt
         3zQEzxJjJV7BcMnIIR/ZPseaJjQtWa6JmD6J104yTYDP6QEjqqBINxEQE2+KWij1emPY
         Hk3+KYXYYOwPun5Yt31ZwDdyQxOZt6BSz7wHy3s1uM/eHtCbumVNia97GwXbQp2nIqsf
         prvQ==
X-Gm-Message-State: AOAM5324bykkxnN+vspKCdXnz/QGDmJ38nOvb7h5XTFPeFwS41YfNVcN
        0lmE/gGlVSsbc1YYW8WXYMI=
X-Google-Smtp-Source: ABdhPJzacnrR9JNatuLHXu/ndsPFiFTeB+6UXuJTuEtETjLwu/N1OnOSM4j1dKoGJXEStz+FUxsvCA==
X-Received: by 2002:adf:ed4b:: with SMTP id u11mr22030727wro.293.1619543821896;
        Tue, 27 Apr 2021 10:17:01 -0700 (PDT)
Received: from localhost.localdomain ([41.62.108.163])
        by smtp.gmail.com with ESMTPSA id l25sm544998wmi.17.2021.04.27.10.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:17:01 -0700 (PDT)
From:   Khaled ROMDHANI <khaledromdhani216@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     Khaled ROMDHANI <khaledromdhani216@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH-V2] fs/btrfs: Fix uninitialized variable
Date:   Tue, 27 Apr 2021 18:16:27 +0100
Message-Id: <20210427171627.32356-1-khaledromdhani216@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable 'zone' is uninitialized which
introduce some build warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
---
v2: catch the init as an assertion
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 432509f4b3ac..70c0b1b2ff04 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -144,7 +144,7 @@ static inline u32 sb_zone_number(int shift, int mirror)
 	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
 	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
 	default:
-		ASSERT(zone);
+		ASSERT(zone = 0);
 		break;
 	}
 

base-commit: c05b2a58c9ed11bd753f1e64695bd89da715fbaa
-- 
2.17.1

