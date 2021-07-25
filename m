Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D453D4E4C
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jul 2021 17:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhGYOp1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 10:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhGYOo1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 10:44:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984EEC061760
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Jul 2021 08:24:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c11so8615145plg.11
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Jul 2021 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YFhuhgl84eq+CxzgEPObkadee7uKOPF2CqcHW4EYgnU=;
        b=qieEA8RUM61792sVgObDfdI7/PnAGuG8EoboLqgiRy0gg63zaS3VKZq9Ug/hw/s/ma
         NdmccXd7hoA+BnbPqgpF2SThK0o8K2ayd8XEA0Zx0rIuGhD2sMenBuiYiHvWzga3B4Ja
         YjEBp43xVfzHniKDaPQZ7Wfby11fUpLOBB22AZoe08IIyY4Xar2DcM+qDa5BOF7PXsL4
         udy6XpyTLkees4oC2F1fVzsdkXNNZzJez7wn/0Wzw4QPI/+3pHvbB33zGvDBQC7kGZH2
         Ib1M6hOvr0iXkQumixZdtjKKbrfi4dcE3iYFDWkQ+MJp+2ezPCRSFQCfVfv/bks5vRin
         fPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YFhuhgl84eq+CxzgEPObkadee7uKOPF2CqcHW4EYgnU=;
        b=JO1B2QL3rN8lBfGVv+c829WDbXLY0bETWoyH9yeNf2qz7+0zoMkpZdwoiViO6zEphF
         7g5ffUZwbsJEBgZ15n7FI6aY8TjO7OTykRgFlbq1imd6SKXP8pSA/KvqrI3g4+q/OkK5
         vhYJ64nWtxCq2yd+gnbYcFi8D0sqGO1zeIFrOSpUgdzW37MTF4I+ogojygcqGa2v+NNM
         yxwt2HDHtFYRT/xm/I5Faqn6OpqNosrQTScrnRFheKOBxZaGod7nJv71LBARhqWhQ4Zd
         SKfN0gMqp2b71cnXnLZU+xwP7pWJEPoJYpkoPRUugTdUd5oJ+J3oiV7YSMBPKcmbh0Aq
         I1Uw==
X-Gm-Message-State: AOAM532ZngB9vhgN1zUj61HRLvFwjKyYH0rJzk6wIMuINDSQQeMo/t7W
        aiVFpbKEcWVDednO3cPDzbRExAEl41U=
X-Google-Smtp-Source: ABdhPJwGOsuL1SX/wuvnh6jdpIA827mNy3DvVT4gkxz8LDkyYgiYiVWBbulpXYsZosm9J1/+Sspsng==
X-Received: by 2002:a62:be18:0:b029:318:df2e:c17c with SMTP id l24-20020a62be180000b0290318df2ec17cmr13985440pff.30.1627226689049;
        Sun, 25 Jul 2021 08:24:49 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id r18sm1198181pgk.54.2021.07.25.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 08:24:48 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Su Yue <l@damenly.su>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs-progs: cmds: Fix build for using NAME_MAX
Date:   Sun, 25 Jul 2021 15:24:38 +0000
Message-Id: <20210725152438.70213-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is some code that using NAME_MAX but it doesn't include header
that is defined. This patch adds a line that includes linux/limits.h
which defines NAME_MAX.

Issue: #386

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2:
 - Added tag for github issue
---
 cmds/filesystem-usage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 50d8995e..2a76e29c 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -24,6 +24,7 @@
 #include <stdarg.h>
 #include <getopt.h>
 #include <fcntl.h>
+#include <linux/limits.h>
 
 #include "common/utils.h"
 #include "kerncompat.h"
-- 
2.25.1

