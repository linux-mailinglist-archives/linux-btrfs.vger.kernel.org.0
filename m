Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A75C2A60E4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 10:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgKDJtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 04:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDJtM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 04:49:12 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E73C061A4D
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 01:49:12 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 205so1698873wma.4
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 01:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HRRIJgk/zWJ4ZCBL2Kbxl4BCQyn4rhE91KyNlOJr9Ug=;
        b=JC48eaF+fFQO+zggUay5zvmqIDqRxpk5keTaEyCOVv/L1U880N0QxAym6iSpk4yI0T
         m7b/71PLHzEN5NztOrktUmaeKrr2CaGOsW2oP38IVG5H5OOOmzYSp4suJr/TZ4uvftLd
         GINp++kMMXC71n09+lBO/PZ4redK5e7Jp9sH1I77g0TjkyB6bfvxZLH2l8xth41IOaVF
         eT3DdxFfNJihNU4cdPuOYJH9ElMUNPt6c7XdrECOJ9dl0kz0iwQe3IBKR5da5Cdzizdm
         deV5Z2tL/RLzVW3V9SRYv4oTVTmpciEhnbqGuJsoPDTyXk/V5znSxk8bdypOyZOCrCv8
         SMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HRRIJgk/zWJ4ZCBL2Kbxl4BCQyn4rhE91KyNlOJr9Ug=;
        b=rnrHISE1vM+ynpaQNapjEXTLZqQ4NHjUcsiRKqqJrOTNIqqKDfmRafmzSEXKLjJ0Ii
         Lv4GRymjK9zK7VuMZoG5YIkMaqwEMO28TshAPR3j2QVpNXSYTOOp1b4/gtfOKPszZxeR
         0FZr8jeDwXemmMQantlgVDEDY+XdS+A7JnnhMeYk4niauRzrYd0KIOuwO2FcTwfJw6kC
         eoOw6eNvpd9jy88H2NxigGFfkvcNJHeH52yccOt3LFffuoeJcJJomPN3zu3VoaET1+Ln
         kRVwvUKP47QOLSWtsroD9GsIjPHtsZVI84thwBYGh4hGyWBqugJOrWqnQbACAiSDjSOw
         tFIw==
X-Gm-Message-State: AOAM532KAM4HgtDCWrllOVCPmegyDm0MGnJvAd1AtOpp3s5xbH+OcNh2
        ganiobsSgorzd4NYJlS33sI=
X-Google-Smtp-Source: ABdhPJxI3WJnbVhHFijpWYozDazwQZA1GOJ+nRWQ7hVTAl686Si3vi3HTDWqpwWFXVZj2sXuOS4HKw==
X-Received: by 2002:a1c:1b85:: with SMTP id b127mr3789978wmb.163.1604483350881;
        Wed, 04 Nov 2020 01:49:10 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-228.range109-152.btcentralplus.com. [109.152.100.228])
        by smtp.gmail.com with ESMTPSA id 3sm1478081wmd.19.2020.11.04.01.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 01:49:10 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: discard: reschedule work after param update
Date:   Wed,  4 Nov 2020 09:45:54 +0000
Message-Id: <6114f7d2699147186adf70c4e82a9a22de7a78aa.1604444952.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1604444952.git.asml.silence@gmail.com>
References: <cover.1604444952.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After sysfs updates discard's iops_limit or kbps_limit it also needs to
adjust current timer through rescheduling, otherwise the discard work
may wait for a long time for the previous timer to expier or bumped by
someone else.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/btrfs/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 279d9262b676..65410d3939f2 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -433,7 +433,8 @@ static ssize_t btrfs_discard_iops_limit_store(struct kobject *kobj,
 		return -EINVAL;
 
 	WRITE_ONCE(discard_ctl->iops_limit, iops_limit);
-
+	btrfs_discard_calc_delay(discard_ctl);
+	btrfs_discard_schedule_work(discard_ctl, true);
 	return len;
 }
 BTRFS_ATTR_RW(discard, iops_limit, btrfs_discard_iops_limit_show,
@@ -463,7 +464,7 @@ static ssize_t btrfs_discard_kbps_limit_store(struct kobject *kobj,
 		return -EINVAL;
 
 	WRITE_ONCE(discard_ctl->kbps_limit, kbps_limit);
-
+	btrfs_discard_schedule_work(discard_ctl, true);
 	return len;
 }
 BTRFS_ATTR_RW(discard, kbps_limit, btrfs_discard_kbps_limit_show,
-- 
2.24.0

