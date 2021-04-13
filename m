Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFF935DFAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Apr 2021 15:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245639AbhDMNGf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Apr 2021 09:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhDMNGe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Apr 2021 09:06:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF4C061574;
        Tue, 13 Apr 2021 06:06:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so8711292wmj.2;
        Tue, 13 Apr 2021 06:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6iIxabbABCVQUceL64W/qjOv0NrxRjxEGVm5CqC0Sp4=;
        b=ODtqRIkOff7Jy0N6cKEBiOUiIeZX70tw3vcS6hphomxgVOv13p03tIIQNVIIapLjev
         KWNynunW/hl7pENIVd7NpuRPfYaUs3LHR6jXGgtyBX/JeKafM9LTCqXhtvo2uk1hYfGV
         ko94DCrFFLNF5vjsTyRiANBUfWbilTZyT9mKAEhZMMinxQX6chFaeEgWngxlB8GMSzIp
         qxMA2w4SLm6Q0TTm5AwnWHM4ny5GDojz0gV+Vpt2HqLorY7BWY06OSqDjyTpfEDir+zD
         3W164bJJ2UcwVi8Nuybo+xjwhqMBh5Bdy0FaQnoqNIqmK6Ldyif9A/dL2ywt4Kefrfo9
         KtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6iIxabbABCVQUceL64W/qjOv0NrxRjxEGVm5CqC0Sp4=;
        b=o549LpBWF8ef7dRSBL4gmrz5c+gQ7dGUUDL/H1N763YP2KOpVh0hc0TSYUGRYzI3Zt
         HpHWTG1zWtGFbBrTYok7YC1KC5vqABEOip9US053IKa58209MggVWrjWsQ5pLbjo9/i/
         dvLRC/zoAlE7DwZ5CYjIWrZ070uB/viM2+LfEujeDb9Uk4Gyvg4Q7VJo7k1YO6S415pp
         SHBQT8IEUqYgAq5Oqdq8uP+JqTOKbUYheeQHOhz63dI5ebGDxSJ36wRT1e2pakq2lGzc
         hSdSeOAU0Iz3PNfO5em0PzLaHB4j/MSMmxHx7q6eiuX3oeJo+L8tqWwQRoo7yGdVD10e
         BBSg==
X-Gm-Message-State: AOAM5305C+wMjTz5/VitFm9ZdWI/7J4DnxJJ6OKhCcD2redz0QLEMSRl
        qTwpMAvOxJcWhZivjFwGz14=
X-Google-Smtp-Source: ABdhPJwAt7l/7XKncnUZeKMr5fkcfptD5oCB0hubq1HkPbdFV7iaS5FlVytjKSgJXngNSMDAOTyivg==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr4027963wmh.151.1618319173292;
        Tue, 13 Apr 2021 06:06:13 -0700 (PDT)
Received: from localhost.localdomain ([197.3.90.181])
        by smtp.gmail.com with ESMTPSA id j23sm2372320wmo.33.2021.04.13.06.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:06:12 -0700 (PDT)
From:   Khaled ROMDHANI <khaledromdhani216@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     Khaled ROMDHANI <khaledromdhani216@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH-next] fs/btrfs: Fix uninitialized variable
Date:   Tue, 13 Apr 2021 14:06:04 +0100
Message-Id: <20210413130604.11487-1-khaledromdhani216@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable zone is not initialized. It
may causes a failed assertion.

Addresses-Coverity: ("Uninitialized variables")

Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index eeb3ebe11d7a..ee15ab8dccb5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -136,7 +136,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
  */
 static inline u32 sb_zone_number(int shift, int mirror)
 {
-	u64 zone;
+	u64 zone = 0;
 
 	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
 	switch (mirror) {
-- 
2.17.1

