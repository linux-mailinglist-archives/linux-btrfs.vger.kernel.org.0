Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B508F58BE4
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2019 22:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfF0UkJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 16:40:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39467 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfF0UkI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 16:40:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so3979192qta.6;
        Thu, 27 Jun 2019 13:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UB496nZNnRPiORNl4LCpW+PnNNrOz863nyL0U+bIG7o=;
        b=PJdskUZFeAVMJf1A7tBLKCASPDuqGxwbiVjGtUHLv01PnRojQUgWtVdCV3XUxiM9Dv
         uet7xMu3Kc1dl6zI43zJy/4LYs0iEAoVsi5ZOxi40g2XknDD4u/jS+IKx9gXXCuWSwUH
         ypdwm0b8zE6NMFAURX0Prj/n7eQRPAV0mBSUGCNPAftALQTTyu7DfvqqySdWw5Ju+mc7
         q5o3/mz9PDs7qhb57ofgxxqb39UdKm6Gw+psPKYslnASuNoPFPP22XLAIEx0AIqrk8Hn
         bPDz7bRJAn3kVd9VMULMoyLdSjXv5pFbjBteoXehvw3BT17ZT9hFDTP6+Elyx+meCbb4
         criw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=UB496nZNnRPiORNl4LCpW+PnNNrOz863nyL0U+bIG7o=;
        b=ntCSKUhelEZw60q2yhIr6OgF9dwpDTQZVbl1aZ/UFsSzT+M33CK65huvysZMfwpRv+
         53kyjbNsJXcaXNi8YxtugiJExPnLu/+CkQTbrzEdc9Q4BG7ykOk3mgFVM0EaLpgGnpJl
         Omzitu1mcD+wefQs0HrP29SxTBv6WLdAbcUAtcxmYQhC7d78NMtndRPIE6ZuoLHE+ClS
         o7FxhZWrhTbzL3YMvkpO9OdJ/KsJDP6LbOrKwcvQE/aPRAUo97sS1R2NsEXUbKvgioUU
         VzbnCLkiPIs1FLHjkD4dUZeTYR9ozgNy9gUMqB7Na9+lz3cd8C6sazN1isIJN1Mq5Xvr
         /oew==
X-Gm-Message-State: APjAAAVXA/Wm1FQYJhERIunwP4/eNreNJTUA6PDO6D0JMXhG5t7efelo
        zN9ae2ONFGZGlhvEe464C90=
X-Google-Smtp-Source: APXvYqyALzQqBghugGroUSJDHL5rxgItlFbAzVRgCrSAfe7FnvM0oRj/34UbQyYI0+xlAUaWDpFigQ==
X-Received: by 2002:ac8:2b62:: with SMTP id 31mr5058917qtv.140.1561668007628;
        Thu, 27 Jun 2019 13:40:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5a51])
        by smtp.gmail.com with ESMTPSA id v126sm97388qkd.27.2019.06.27.13.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 13:40:07 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     jack@suse.cz, josef@toxicpanda.com, clm@fb.com, dsterba@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] blkcg, writeback: Implement wbc_blkcg_css()
Date:   Thu, 27 Jun 2019 13:39:51 -0700
Message-Id: <20190627203952.386785-5-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627203952.386785-1-tj@kernel.org>
References: <20190627203952.386785-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a helper to determine the target blkcg from wbc.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/writeback.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 33a50fa09fac..e056a22075cf 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -11,6 +11,7 @@
 #include <linux/flex_proportions.h>
 #include <linux/backing-dev-defs.h>
 #include <linux/blk_types.h>
+#include <linux/blk-cgroup.h>
 
 struct bio;
 
@@ -101,6 +102,16 @@ static inline int wbc_to_write_flags(struct writeback_control *wbc)
 	return 0;
 }
 
+static inline struct cgroup_subsys_state *
+wbc_blkcg_css(struct writeback_control *wbc)
+{
+#ifdef CONFIG_CGROUP_WRITEBACK
+	if (wbc->wb)
+		return wbc->wb->blkcg_css;
+#endif
+	return blkcg_root_css;
+}
+
 /*
  * A wb_domain represents a domain that wb's (bdi_writeback's) belong to
  * and are measured against each other in.  There always is one global
-- 
2.17.1

