Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628FA304D4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 00:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbhAZXIx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730316AbhAZVZb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 16:25:31 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AF4C06178B
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:51 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id t63so4851028qkc.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V92/TdMDONhMcUvF8pa5GsBDL1WDN70Mnr2E+dYSXjE=;
        b=xNbNHuWGJSUpOtUXYEHPB4kYUQT88hSGYhM7EHFZjgry3l+mKoUj0j2E2DWJfBHEDb
         fNkt1ZgVZrgCPA7M5IQhnjZP72+hXG7vArSP4HLmx+VPqPOYc59jRWnmSS8EcerK8rG3
         epiqp12Ku5Fk3pUxP2OmcghQhhamRAIFNPejostF/XhGtEBOGz/fLx2LdhYmHO3SJNIT
         I4aezY92/90YuV0oArYYrSscToqIPUhU0N3Wq4dfAz8Q7ltC+93KQW24F+ldZuUTwg1r
         Dl+nSxc5crkllqQMvF6Km3bE+JfzWSRQaVSx9HWyPDNIsI17fAJ+VBtwnCM+gRsmVwaa
         RS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V92/TdMDONhMcUvF8pa5GsBDL1WDN70Mnr2E+dYSXjE=;
        b=JtR/rq63rZwe48zSMIEbBrW2NdJ7cOQNvGJv0eXySIfI3DTIE6UrzSvDrBIMtVdPHX
         HZwwkSqcPg5LVwQKgD5CM7QZKoehpOjFBgq/oBF2CnXdGhQioKupEi8C0Rj5k0yxCLEw
         VRFCJzJ8DtONrekeahk3l5s/s1im88m76MHlH7+tFWYoDqsbm2un14hEO/blePsbfhWK
         YvmGaFJxtPiAURHmYdMmxJ8pWJLYU3oUX7Ktjhpj+iEIJgnNnVbBh8gRcxmD7M4BZfDn
         AT5W1AB+YRh0qzXBLDyvDkIy0ZaMnlzKA/9K8h5e7TQNxcZ1V2c5D/wDRQD6829Xanj4
         5i6A==
X-Gm-Message-State: AOAM530dHZ/No6Fu0AGZVwrdiHX8uiykhn068Z0JlgssMc7SThgCV4US
        mexWIQIojFCPLgK5C8cW7DNRWA2XRVjzwUbq
X-Google-Smtp-Source: ABdhPJwvZMwFkX2E5/0C80gjvsLBhLf56RBAwVRMVNWDDbUSlyYS7gbk8fOdj2wpXocrFRVFlVDR1g==
X-Received: by 2002:a37:4590:: with SMTP id s138mr7876570qka.239.1611696290457;
        Tue, 26 Jan 2021 13:24:50 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v185sm15551975qki.57.2021.01.26.13.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 07/12] btrfs: check reclaim_size in need_preemptive_reclaim
Date:   Tue, 26 Jan 2021 16:24:31 -0500
Message-Id: <90d587ce068421771a24ab819969de3e498dce61.1611695838.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1611695838.git.josef@toxicpanda.com>
References: <cover.1611695838.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we're flushing space for tickets then we have
space_info->reclaim_size set and we do not need to do background
reclaim.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index e68cd73b4222..c3c586b33b4b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -812,6 +812,13 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
 		return 0;
 
+	/*
+	 * We have tickets queued, bail so we don't compete with the async
+	 * flushers.
+	 */
+	if (space_info->reclaim_size)
+		return 0;
+
 	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info))
 		return 0;
 
-- 
2.26.2

