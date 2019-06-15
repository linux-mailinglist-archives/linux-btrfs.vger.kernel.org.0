Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC3447197
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jun 2019 20:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfFOSZM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jun 2019 14:25:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43922 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfFOSZK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jun 2019 14:25:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id z24so6310972qtj.10;
        Sat, 15 Jun 2019 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gfbJRWowmbBmL/5PSSu1BU5VBQ2iIkWS/MK9bvMff9Y=;
        b=FAwf+6hjmWThr/Zo8e7ZPLeQ4Osz81kO6XOn01SydzL9G7yN45Gxq1gV1sDU8bZ8Ps
         FFMW53WswxVXCIz5ymPH+aojtStDVDFc9U4gzOUzoQm5z7aO4LdqWWx+0rGps4WFCt3i
         yAC+1YBfKSPmk/Rx0KOBAifiqYR+upzOWcfNjxSo/sUW9yTg5oQ89iEfb0VuH5V3kC5A
         7dJCt5OfnPvSgkYgK2OHXh79Ftd14ZNMHmmmS1DEhRy6wdKaZepGZ6VA29ZMMDldvE2d
         4TdTtSY/E3LUI5x/rycNBKJom4cvPWPtrOWTozTAnrOMUd8K9VmOU1ZlzofGVFmBbGp3
         Wo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=gfbJRWowmbBmL/5PSSu1BU5VBQ2iIkWS/MK9bvMff9Y=;
        b=kbKfcA+g/1Ig8z7c9kvktKH8yMXbC8e3RyoT5JTYrOaGM8ERmuyQk9WNIW0BSEaHWT
         VyOCYYHCgA+iX4nKnaIbMaODdDLkX2EgS+uARsbEa53iaA9j67eu34rhgf46DS6V0mVg
         RTqfRY9NQgzAQ/8DSWbnDb6cDP8tNHPY6SJs2WG/ALm+HjEXQQWXsk3/gqXCetZEKL54
         7WKfFEZ9AGH/Wnc8UR8PPZSqEnHMnRmwn0OL86V3DpYNvjsAxBQ3cUdPuD6HVVorT8Bm
         jwTeyIRCkI4+FxmYSBE5HVDD9lMncJ3MDDNYm3ku2oRLK8wZ06tDcmYfEQUIBarwnem7
         GRRQ==
X-Gm-Message-State: APjAAAXqv4fp3AqZ5UkiXJFRFWaeS/jlEhJRxAB8uhI5mrajLiouocoE
        HKZAKHV8ox9T4mxM66LsGZM=
X-Google-Smtp-Source: APXvYqzAsjP5XFJMaZa4nNVaYMsFZyf6LFDCRQlhH8zipSL5vUkPHifbL2l8oi8JL4wyS9o7nD81zw==
X-Received: by 2002:ac8:4705:: with SMTP id f5mr60570826qtp.99.1560623109356;
        Sat, 15 Jun 2019 11:25:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4883])
        by smtp.gmail.com with ESMTPSA id y6sm3413435qki.67.2019.06.15.11.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 11:25:08 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/9] blkcg, writeback: Implement wbc_blkcg_css()
Date:   Sat, 15 Jun 2019 11:24:47 -0700
Message-Id: <20190615182453.843275-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190615182453.843275-1-tj@kernel.org>
References: <20190615182453.843275-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a helper to determine the target blkcg from wbc.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/writeback.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index b8f5f000cde4..800ee031e88a 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -11,6 +11,7 @@
 #include <linux/flex_proportions.h>
 #include <linux/backing-dev-defs.h>
 #include <linux/blk_types.h>
+#include <linux/blk-cgroup.h>
 
 struct bio;
 
@@ -93,6 +94,16 @@ static inline int wbc_to_write_flags(struct writeback_control *wbc)
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

