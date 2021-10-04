Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8B7421511
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 19:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbhJDRVU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 13:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbhJDRVS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 13:21:18 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBCFC061749
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Oct 2021 10:19:29 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c20so16580994qtb.2
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Oct 2021 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EujUb2zdQxZ1DX7m7qZ5lK5plbrk+V7MM+/HKaZss6k=;
        b=w2QKSRaMAqs7mfalZatJeHiQ2j/Ba829cwNB/VRZEOhrKjSLCJsW7tWhpsictj2jS/
         7KWFlVpfw+hQlXAFt0QTepNJBmtp64hZgteBdvTMp0+Dgg4edbZ+MApEk5/Z5Gj9v746
         RKgwN8tcZLwctqan9lBsUFkvNy62lffNvYktXHHVp5kIcG+ggEM7v1iXLCDxjeNXlisr
         3sYJz3dZ+RQp8zn8iTv8+nf0RG2bRUAXTQfDcJIZmis0a2ASUFyhyZF5s22GKF3E0Q4q
         BeT46YwP8vKnZsYWFh9YEQ3dh8uKGs0HOf/CvHYOQnOzfgnmjCXOQwAWPizZAmGaaPpV
         MDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EujUb2zdQxZ1DX7m7qZ5lK5plbrk+V7MM+/HKaZss6k=;
        b=VZO79iM1AbnUFY6BG/NRpKnthqsdrM+kK1rgIO9GqJXX2SE6bhrskWrLVFH064yQ4i
         GownOnjaYdZU0g0pcOaU7mbReVi71frKFMfTe6yCnrtwrKW+TLV/P8CgqXhEAZ5JCCRL
         uiK02wpI0+vxFmexYl+bqgxHVhdjvjvStDZowWk3nLllkSffSjbIX5jleHmij0jF1s53
         PjEkdyr/L71WdvENQSNNCxSJ8sH13NPfl702owSied9XenLv38/1RmMQzxSVgLPoZMcK
         +6JxdoqOIn9pyvFYbrZsnTaZlVFmPMdgGQmbayj14HKVAhyEypeKYT9boL43LPUgHVFC
         Ax/w==
X-Gm-Message-State: AOAM53175Dofo66ok2216T004YJOSop+sF5r28/sZnggNowdvDS7ifgk
        WTL5PWesKRiGjUBFLfzRWCXUqASqAQA2+Q==
X-Google-Smtp-Source: ABdhPJzUm3J8lX9W+rz7MW7OvKh2RXc7Ia5sntjYQyS81GlNGkaUf6VKqkNrxJN6X/a23so5nKy89Q==
X-Received: by 2002:ac8:4d8b:: with SMTP id a11mr14344669qtw.51.1633367968478;
        Mon, 04 Oct 2021 10:19:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z24sm8103155qki.72.2021.10.04.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:19:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 2/6] btrfs: add comments for device counts in struct btrfs_fs_devices
Date:   Mon,  4 Oct 2021 13:19:18 -0400
Message-Id: <de61153ec9b67271f45f63a718bac0703bc171a3.1633367810.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633367810.git.josef@toxicpanda.com>
References: <cover.1633367810.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Anand Jain <anand.jain@oracle.com>

A bug was was checking a wrong device count before we delete the struct
btrfs_fs_devices in btrfs_rm_device(). To avoid future confusion and
easy reference add a comment about the various device counts that we have
in the struct btrfs_fs_devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 83075d6855db..c7ac43d8a7e8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -236,11 +236,30 @@ struct btrfs_fs_devices {
 	bool fsid_change;
 	struct list_head fs_list;
 
+	/*
+	 * Number of devices under this fsid including missing and
+	 * replace-target device and excludes seed devices.
+	 */
 	u64 num_devices;
+
+	/*
+	 * The number of devices that successfully opened, including
+	 * replace-target, excludes seed devices.
+	 */
 	u64 open_devices;
+
+	/* The number of devices that are under the chunk allocation list. */
 	u64 rw_devices;
+
+	/* Count of missing devices under this fsid excluding seed device. */
 	u64 missing_devices;
 	u64 total_rw_bytes;
+
+	/*
+	 * Count of devices from btrfs_super_block::num_devices for this fsid,
+	 * which includes the seed device, excludes the transient replace-target
+	 * device.
+	 */
 	u64 total_devices;
 
 	/* Highest generation number of seen devices */
-- 
2.26.3

