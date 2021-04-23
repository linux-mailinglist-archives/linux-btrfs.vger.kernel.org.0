Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19C3369251
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Apr 2021 14:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242416AbhDWMmv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 08:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWMmu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 08:42:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C47C06174A;
        Fri, 23 Apr 2021 05:42:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w3so73743580ejc.4;
        Fri, 23 Apr 2021 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cigm8FoAQJCFR8BBSxQb1qtaSNBp4pLV8SFaN1EkbqQ=;
        b=C99A1yH9iuOPA7YDilWOAH5Eqbrw3NHSmFOxiJSMYi5w4kJo5XTFSmijgXxPMvaT/g
         aQiNDwBil9E3asW3C2gTw/dl4sK1Wku/ufrK6xY3Io9hzQVvk8yRrFIqTPhkgh8biJJ+
         esfve6ZPYHvyIJolS41HMXF6LVRQsv4WH/CzjBnQG0XKY31lJBfHg/OSxGz7m6/dHdcc
         6RxZ2SIWTu493LFovRgcqfEY2WmTSNpmcFpmkk7qAvpNPwCqvaF96WM86t4SUpS+1WkM
         OdD8Sv2Cges8w47SyAm+1NOpHnd6YAjr+IH/eJ/sFnvrrX4G9a8y59NAJPr51Z/rYj85
         uSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cigm8FoAQJCFR8BBSxQb1qtaSNBp4pLV8SFaN1EkbqQ=;
        b=DLd4RdKLd/2B7GdwXOP9AWRCXqKDUiCC9LcwfiwV5Q5eX54QAjce3j6v+4Cupn7yli
         b3Sab5DO47e/LxF3GaRCsuc2cvSsiL1DkEuvcBeEi9vwbgrtJ23HCvdTPI5SDoQpMKd0
         7GdM5INhpk0AbQbjlj+t6DnJ0urbDCOGl0zvawag3F8/XYGDR/HZ4hknRNbghCyth469
         cghXO29chdO5rzM3wLqPMhJeuHZ14mvYIBeKDmB17fAnNg+jDCrJd4yP+L3NhZPQnKyR
         cqThKTr2Mn8Nx+wy3s2GwwI/dFz4AsaQexSfSUa/bMDBJPkmKVRQLZrpF0LCmrQQJGmZ
         W+8Q==
X-Gm-Message-State: AOAM533kxznp6kFOe3ykx+J+T1qIVpnTkiR0Cer/rAkoagUpcy9XTdqL
        lj3UuatWp/I1LX5w0GGRyQkIH2Bj+pE1bCWE
X-Google-Smtp-Source: ABdhPJxEVyBDl9SrHFwOI9XmiRaLeOLGTbuurEQaw23ba78UH7qsNOzcWob/nfgJzAn2GOknA3DBng==
X-Received: by 2002:a17:906:f2c8:: with SMTP id gz8mr4110139ejb.242.1619181731477;
        Fri, 23 Apr 2021 05:42:11 -0700 (PDT)
Received: from localhost.localdomain ([102.156.210.94])
        by smtp.gmail.com with ESMTPSA id lb18sm3894116ejc.6.2021.04.23.05.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 05:42:11 -0700 (PDT)
From:   Khaled ROMDHANI <khaledromdhani216@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     Khaled ROMDHANI <khaledromdhani216@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH-next] fs/btrfs: Fix uninitialized variable
Date:   Fri, 23 Apr 2021 13:42:01 +0100
Message-Id: <20210423124201.11262-1-khaledromdhani216@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable 'zone' is uninitialized which
introduce some build warning.

It is not always set or overwritten within
the function. So explicitly initialize it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 432509f4b3ac..42f99b25127f 100644
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

base-commit: c05b2a58c9ed11bd753f1e64695bd89da715fbaa
-- 
2.17.1

