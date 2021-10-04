Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FD5421510
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 19:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhJDRVS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 13:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhJDRVQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 13:21:16 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988DBC061745
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Oct 2021 10:19:27 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 138so17172034qko.10
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Oct 2021 10:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQ0CZG1M5HZeVmkhs186o9JHl5WBClLZ/K0CTLYAY50=;
        b=LOqMckR9B7Hkk8QbGfMsyf4epf9IHA/Y30FRRIlUH3+DLPsfpc1w9M9+hFCXRQmyw+
         4OP8bIc/YKL8cmasoHVGeWiwjwtEJm+P+fkMB0yIxxMvLFjNcsHwdYANzd0nEGjfJ/P/
         o4GFixZsukPxguzlwsYV0uirp/SLMIk2UmBoGqZO3Q9k4QpxN4AO9FWwfk6+hn8AtEW+
         kXTOMVOldF/t4iCFYp6OpUkbY3ITJcYNPHkExxc5ab7CxlOVHXgOK95DS/pO30KetSJ4
         62gMuDf0xcHhSm4b+3i2Oe4fa868egxodKalN4EItp+HDiplC+xVcxX5mnEVu1BJSsTX
         gR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQ0CZG1M5HZeVmkhs186o9JHl5WBClLZ/K0CTLYAY50=;
        b=XtE8GTiyZC5CRvTGb3a13ATvdlwxBZmN74Ex7EoQH9bG9zTEmfrZ+nUGZjahYgEr1d
         WBMGnmS+kWpjLWzQ5Q/2KrM8T6bI3IIvXCR2gQ2txyRSPnEMMwW9moVfeFj/U8SnFwPV
         AVj7jLpckkAD7QJJfo9ckDhZ8oVVnxAzbid7znZYuuPgn87cnrLPSw8z2fDwNxm0evOG
         /ghFhQ67Zn2tPu81nooFdoR61k1/r8YbUKVQzKfUCiAec5AwVWSuybp5Wo41OAZ2KUFP
         maLYHq60xNA6zuwwyJPO3NziKz0Wq/M5x46i+mY85vZ4W5ZL8nwaYTNwt1OXzjof2kha
         y2Tg==
X-Gm-Message-State: AOAM531eHPLqJ71t7GlYvEMFpejOD+CHXlqCIfzeyoECGsdBBYlnYzI3
        Yw5vBHEzk3Q6b4YGjNwKv1+kSafjVgKgAw==
X-Google-Smtp-Source: ABdhPJxJNhoYyUdzAtvAmgSNcyztpbrgBbuf5ruejlaULsF9xmxiiq6i3JnI1MrZIeeOjQOi6o2tGQ==
X-Received: by 2002:a37:b0c6:: with SMTP id z189mr11209453qke.344.1633367966484;
        Mon, 04 Oct 2021 10:19:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y13sm6940667qtw.62.2021.10.04.10.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:19:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 1/6] btrfs: use num_device to check for the last surviving seed device
Date:   Mon,  4 Oct 2021 13:19:17 -0400
Message-Id: <57941caac7f14f631da079aaa150f305877c4e2f.1633367810.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633367810.git.josef@toxicpanda.com>
References: <cover.1633367810.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Anand Jain <anand.jain@oracle.com>

For both sprout and seed fsids,
 btrfs_fs_devices::num_devices provides device count including missing
 btrfs_fs_devices::open_devices provides device count excluding missing

We create a dummy struct btrfs_device for the missing device, so
num_devices != open_devices when there is a missing device.

In btrfs_rm_devices() we wrongly check for %cur_devices->open_devices
before freeing the seed fs_devices. Instead we should check for
%cur_devices->num_devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6031e2f4c6bc..0941f61d8071 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2211,7 +2211,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	synchronize_rcu();
 	btrfs_free_device(device);
 
-	if (cur_devices->open_devices == 0) {
+	if (cur_devices->num_devices == 0) {
 		list_del_init(&cur_devices->seed_list);
 		close_fs_devices(cur_devices);
 		free_fs_devices(cur_devices);
-- 
2.26.3

