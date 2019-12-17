Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450E2123755
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 21:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfLQUaP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 15:30:15 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36714 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfLQUaP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 15:30:15 -0500
Received: by mail-wm1-f42.google.com with SMTP id p17so4652340wma.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 12:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sy6yyhQbqadaY1M3Gol2XoC2NvLdZH8/SM+7etfEGe0=;
        b=l2hughmbKBRP9qwFQXwlXsXp/EN1tFFSRlyThwT1Fa6zvNhUylAAvdVZTXAZ4xPITv
         jdUF4xxMOeX6J5DRkkiNdLvLWKohYV29dXNb3Xg5wN3A1BrgCkY0T5QBU1XQqf+kYT/r
         8x6M2dDpFaquj0Lka1QE2mucP8ZVvIFS22qyZ4kagAVIsIdqtIF8Yo1TRPFUQoeJaCFl
         QIW1URtajW2FZr3cWxlIvwsdvlcRn2up7FZrDEpoat+Of8PAwMIgYaW1J9yRXjbSCl1x
         Bh3EnU5+NQQSMMkwIpI324StJ0J1B47BHzWBzEJJdsvvmzVeWO07PpGXotDW6VdS5JaD
         0G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sy6yyhQbqadaY1M3Gol2XoC2NvLdZH8/SM+7etfEGe0=;
        b=cmVmi4/0pbzqdS7QIRPt37O9+N08/EO7dm+tN+Umph/lDBVyqS/PTcrYisxmGgAc3H
         6O1iuw3cq8lkeDSwg5tRyjpU69uhPi1Dv8IbH4s6KOXHrG+hw9uNsC6L+ttyLX+nZnFa
         G8+l2tF0M/WkOF9fnzY5xBUwSvVMfHVTRWCwbCCP796IXUphlK5+IBN9deKoqlTLrjxF
         Yw7kxZx3LUWJQ8Ty9uTK3u05JtRCwdPgLdgwZd310k0R/xk363EoKlXZ5u+Fq56Gup/3
         lyqaSal3EObcoVF5qDoeVcw0NUkIipBCeuH1lMD8zSAPlzzGtQuGMY/qNP3T3GwLA3ok
         5+hQ==
X-Gm-Message-State: APjAAAWOh+Tt0OZvfcCMc6d46eGWf/reay1NAKK170RcDxYFV5S9KIOj
        6ggRyAOEAbrdPKhTFEiOv4Q=
X-Google-Smtp-Source: APXvYqzNtu+MrRb2eYrY00T9IhjSe37O3ubLGRdDX4QQx6Zx+1A8W3qhQFRxRKSuZQ8wyBVTQbF7AQ==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr7453084wmc.126.1576614613321;
        Tue, 17 Dec 2019 12:30:13 -0800 (PST)
Received: from hephaestus.suse.de ([179.185.209.78])
        by smtp.gmail.com with ESMTPSA id h17sm27910619wrs.18.2019.12.17.12.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 12:30:12 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: [btrfs-progs PATCH 3/4] tests: mkfs: 005: Use check_dm_target_support helper
Date:   Tue, 17 Dec 2019 17:31:54 -0300
Message-Id: <20191217203155.24206-4-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217203155.24206-1-marcos.souza.org@gmail.com>
References: <20191217203155.24206-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This way we ensure the linear target is available and skip the test.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/mkfs-tests/005-long-device-name-for-ssd/test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
index e7a1ac45..329deaf2 100755
--- a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
+++ b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
@@ -5,6 +5,7 @@ source "$TEST_TOP/common"
 
 check_prereq mkfs.btrfs
 check_global_prereq dmsetup
+check_dm_target_support linear
 
 setup_root_helper
 prepare_test_dev
-- 
2.23.0

