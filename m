Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483DB47627C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhLOUAj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbhLOUAZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:25 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63C9C06173E
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:24 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id b67so21226328qkg.6
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MeB7qzN9omFrJm0TY5wbtElJmtf/WV69WqRzL1Yvmnw=;
        b=PETvoPeTmHGzQtHHzWE9Qf+b2+3fMl5QOB7Ra6XzYYlfzO+IIUjxH6HxBxMNFjY2Hr
         Yonr7+UcqZFh2+xzpkLImBb6gFajah3J4ThVfOFGXFRufc5rlPLvRxGfP1Ywvo7THQM8
         d9H31KZn5e7mhnNZQtzjdcTpk0vgsJRm8iMY1ZbjE9sxwahHQypVVgJWxYwF1uZ9ZVEG
         iuheTWAsUWnHz7I90XhEt/OfU2zKLktcxdcvx/cP8sQYpnwS42ZR4bsEI2nOO3VdHFhp
         jpPP9hjj/Y61o0NR6zvGqqCE8y/NVEwHUKD6yDztaHYwhOIAp8kSsN+1RThHFyqk5buN
         pitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeB7qzN9omFrJm0TY5wbtElJmtf/WV69WqRzL1Yvmnw=;
        b=n1u+VnEY9pWMTDyYweDCPUvBZbr/SQhqAsWKyrZScJn+w63OZiFJLtCq+vdC3EWpZb
         fHJgSWxe6RmmcG040AHH55qIudUGgF4l1PpB3qbRMnylVPjr1e8euDigbNdWhEEQam6m
         Eb4/481PmiY+vrawb4DytMi9VvRQosnmubNnBo4fGL/ApCgo0Qo6ipqYV918FKRQxP5j
         +fU82Di0fb360cwx1NKkHLrE5mM4woOtEKlSY6akGUtnbuvkEqloAWYnnOmM27wUEF1U
         bY+k731j05UxSnOXHY8Sn2p91nTC/hDzXLfBTf7q2k8xQZ03WYuaosjuL2O+hm9G94cQ
         Nayg==
X-Gm-Message-State: AOAM531W/ZnfGn7l0zNGuFDHx029mpB69Ged6bQTOPMhqmJcDbL54LAa
        /jakidIMraTCqCaLjcrsCJ3LEHgzvCmIJQ==
X-Google-Smtp-Source: ABdhPJySPQF30+fB8PD1rP4/XKTCBDsy6wggnAB5IMOg5dHR427hlq0GArwx0klxVoXOBQCbz3ntdg==
X-Received: by 2002:a05:620a:1424:: with SMTP id k4mr10014211qkj.433.1639598423503;
        Wed, 15 Dec 2021 12:00:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l2sm2181578qtk.41.2021.12.15.12.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 22/22] btrfs-progs: check: don't do the root item check for extent tree v2
Date:   Wed, 15 Dec 2021 14:59:48 -0500
Message-Id: <374ed07a6661b6a560f897048ef93f82269f6a18.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the current set of changes we could probably do this check, but it
would involve changing the code quite a bit, and in the future we're not
going to track the metadata in the extent tree at all.  Since this check
was for a very old kernel just skip it for extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/check/main.c b/check/main.c
index 36352543..0eab91b5 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10091,6 +10091,9 @@ static int repair_root_items(void)
 	int bad_roots = 0;
 	int need_trans = 0;
 
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		return 0;
+
 	btrfs_init_path(&path);
 
 	ret = build_roots_info_cache();
-- 
2.26.3

