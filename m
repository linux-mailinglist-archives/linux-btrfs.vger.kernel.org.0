Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8153F1202
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 05:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbhHSDlV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 23:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbhHSDlU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 23:41:20 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166EBC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 20:40:45 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bd1so6665642oib.3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 20:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWwjtPQYwNlKP935Iz/IKwxIbGdwRNeaHUJuTwGQO6Q=;
        b=MPyJtXW9RJHxHRLqegaPuMe9hgpVKTxpYZe+Cis7U18KZ19DPL/7nhVL/cXRSgLpik
         CETa1u0eJettPLNvxkUy0i2xGOsfSj5A2XOvMLUan5J6fSFfb+RoHSF9yqx5WuONvTW7
         JLBNJhzZe5RG5RgeCI1Ez8XaMPYhUc2wAG9c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWwjtPQYwNlKP935Iz/IKwxIbGdwRNeaHUJuTwGQO6Q=;
        b=LSlX/vYMYFAXTG03hJ23vSxr287uH6Gt9v3qREehdlC+VijXy7/dglzWyjAZaLdGAb
         KlSphmmbj6bVK1uCaCsTkO0ZEiu+4IzVQ+peG38oY764iS5MhrfQI9+85XwLxGpgr8XF
         gJpNSiOZ2OOTJVJbQ8ZB4mJMbYnqlcCxOzgaEj5x2BI8S/Otz4dlLXwIDvQL9brbe9AU
         bHmPi0Rwfmg/wEmK5NKiCUCypGJTRSMoGip3jkHyMZUt5YVsHw+Rcz/kdZMttncSL+Ji
         Bvxr+8iqzHdpVhQcTLxORjU5+dwii0rygfXjZRzEFU9OEz7uot/Y2Wo3qjwUPZwQepQ4
         fxwA==
X-Gm-Message-State: AOAM530wO6AJxg5pMr4sSTf3MDcCYh+/9tDd8PpjBkE6CoUAI6DyPMen
        gudW2Y+FFueDkwCF+e/lPB1b+Q==
X-Google-Smtp-Source: ABdhPJwKdU45dUaH6F4Eys9KJrWAu0KFv4tnL+QqyAVD4oZLdKBy/fCwaQywmpPGiIMsGt0cUbu63g==
X-Received: by 2002:aca:c005:: with SMTP id q5mr1099119oif.153.1629344444479;
        Wed, 18 Aug 2021 20:40:44 -0700 (PDT)
Received: from kiwi.bld.corp.google.com (c-67-190-101-114.hsd1.co.comcast.net. [67.190.101.114])
        by smtp.gmail.com with ESMTPSA id q27sm415877oof.12.2021.08.18.20.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 20:40:44 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     U-Boot Mailing List <u-boot@lists.denx.de>
Cc:     Simon Glass <sjg@chromium.org>, Marek Behun <marek.behun@nic.cz>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 04/11] btrfs: Suppress the message about missing filesystem
Date:   Wed, 18 Aug 2021 21:40:26 -0600
Message-Id: <20210818214022.4.I3eb71025472bbb050bcf9a0a192dde1b6c07fa7f@changeid>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210819034033.1617201-1-sjg@chromium.org>
References: <20210819034033.1617201-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This message comes up a lot when scanning filesystems. It suggests to the
user that there is some sort of error, but in fact there is no reason to
expect that a particular partition has a btrfs filesystem. Other
filesystems don't print this error.

Turn it into a debug message.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 fs/btrfs/disk-io.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 349411c3ccd..1b69346e231 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -886,7 +886,11 @@ static int btrfs_scan_fs_devices(struct blk_desc *desc,
 
 	ret = btrfs_scan_one_device(desc, part, fs_devices, &total_devs);
 	if (ret) {
-		fprintf(stderr, "No valid Btrfs found\n");
+		/*
+		 * Avoid showing this when probing for a possible Btrfs
+		 *
+		 * fprintf(stderr, "No valid Btrfs found\n");
+		 */
 		return ret;
 	}
 	return 0;
@@ -975,7 +979,7 @@ struct btrfs_fs_info *open_ctree_fs_info(struct blk_desc *desc,
 	disk_super = fs_info->super_copy;
 	ret = btrfs_read_dev_super(desc, part, disk_super);
 	if (ret) {
-		printk("No valid btrfs found\n");
+		debug("No valid btrfs found\n");
 		goto out_devices;
 	}
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

