Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4644423160
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhJEUOl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhJEUOk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 16:14:40 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5DDC061749
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 13:12:49 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id a13so297909qtw.10
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQ0CZG1M5HZeVmkhs186o9JHl5WBClLZ/K0CTLYAY50=;
        b=1bW4iKD4jpaVOhxLMHv0lwRm6m7K0MULw8tK0OnYuOYB8WrDOIS6jsy1Cwy34pY/ax
         W38WlLnLLRwKPKr24EwIEBA6JsuFEP0hmInCz4EeUpdjCzzdQAM6is6wG33ph6xsl4e4
         kc6handlzyuGblPS5xVyQ0zXomPYnVefompb0a/9Vzaq3hu0h/5QJWdkMw3ntBJ2wOnO
         BMr2+YIyR52ZDsily9Dci7WCdbzszPpWijQIPe3BZhhdMCgyDDoIpnN4f9TvnP2wNNre
         wEksAlpfGvYX4wYk5HvvSpk106SC7gndYUMqWrThviWuWVPFg7An5oBcyo8u4CbECNa7
         f/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQ0CZG1M5HZeVmkhs186o9JHl5WBClLZ/K0CTLYAY50=;
        b=uReSyS45U28a5iLXFDGl60dJjX1ZyAPR4WO9E1V3+lS/SVqsxHBpISw+dnzCk7Vum8
         MlACeXCZU1T+mGpeiDXFaKEcMJ8TuqyQU1QH0VWCROdxENWHSeoGDGf/x+b1kaECRpHi
         TbMgZbG8yACusaCoI8qlPUAz1xc+sH69wWWmnQCBBwYPePobVR4Y6JgaYAfqo5FRee0Q
         Iu481gR8e0CVKj7B0CyapFYSXWcEgNYqE/rckuCjIEP7Jrf+efLD3ChOc9SzzR9dJs/E
         yHooFbEVUdqD2frza0SKPe9N2T3o4ecZIB2KVa+K3ghCm+YLQ96eKwk7iAxShG2ZNGrN
         A0jQ==
X-Gm-Message-State: AOAM5334Why+LVUnedHbkbOKNzBvb+u2m0KtNKoxIRUpVKxq8EarUhea
        9EFST4/PSa9uFfQDcIUDgLPCoUcbp106vw==
X-Google-Smtp-Source: ABdhPJwEiewrewLOKwtWIhMGszcN6bWwlYcpONAUZr8nC/jZG8RPRT7hwK5s8UntfXkii6knOJRArg==
X-Received: by 2002:ac8:5617:: with SMTP id 23mr22204861qtr.257.1633464768014;
        Tue, 05 Oct 2021 13:12:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d82sm10077340qke.55.2021.10.05.13.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:12:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4 1/6] btrfs: use num_device to check for the last surviving seed device
Date:   Tue,  5 Oct 2021 16:12:39 -0400
Message-Id: <57941caac7f14f631da079aaa150f305877c4e2f.1633464631.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633464631.git.josef@toxicpanda.com>
References: <cover.1633464631.git.josef@toxicpanda.com>
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

