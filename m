Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7FE346484
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 17:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhCWQKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhCWQKM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 12:10:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978D5C061763
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Mar 2021 09:10:11 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 11so14790085pfn.9
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Mar 2021 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLloRUDzgtbIO8MnHQ24DXE/sLEID0DVdZ6/soZCkCI=;
        b=m9uNvCVgsXexdNTUA7qoqvlDCR1sikLK92ZkPRFOpFAxOX1RP6N0Ne4GEoZ9/Jy6pw
         Md1OjtVbFvUngd78jMeNwnQG2xDotib7RqLQjZOB3ZhPdCMz/s41V5xAfs12+hgmsR+r
         6Y9ibM8Y903jXnObJiIHqim2qVm5cQeUq/FPD+sQMzh00xoq2vmjfVvnTM7CIx5K4LdV
         3f0JMNUKpXog6nHn365PnyiJYye9J7fbsz5yD20c+HuE9W25SC1s/eFVoo2daOKPx35B
         LdvIasncIg4wW5EDBK4+IZxXIGIB3A0cdtnu4sEWftbCPxb8dsst7IKY8JRnRQiORMXJ
         sGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLloRUDzgtbIO8MnHQ24DXE/sLEID0DVdZ6/soZCkCI=;
        b=B9iv3mE1PTadFD67y6Yt4kvDgq9Pr3CzMxbuDytBVYFOujWN93NbNnubvsyCzV7e+S
         tS5rVasUrB17zr532I09k/6mDF+8oAmZeGSWFq7TP042carTesr56bE7mz/377CCr8Zh
         RAChkyjhR0I5RSdyTEzTcf4Z6dXWvLhIX4b+NxU3VqrbxpxMsGrN8bFy7qDxmfxdi7iU
         aNz8CMfWBV5Oka3/u3EDsCBcRVZaOeVdz9mrM9lGFNW6gooSo96sExe+XOU8W/CTAoCq
         U9y54S7lYMtKrzpW5lqfXGwOgaChOglfhdPdVuAw8HAz/nBZtomFJIg4Ip3MvF/pCm8W
         g8Bg==
X-Gm-Message-State: AOAM533kid98dX/w3nBovrilytyZy8lbE7kkk4IUOsXtJjrPZR/rSe4V
        DcHnaqbJQyXJ8udJkbEXxiVry3DOrBg6YA==
X-Google-Smtp-Source: ABdhPJyeU0JTZIZcvr0PV7t7l7g6HjuTCV3AeYxS3+ycW6T8Wj04/vhnfZkDG+xqGW8nrQN4YBbMww==
X-Received: by 2002:a63:74c:: with SMTP id 73mr4654092pgh.200.1616515811181;
        Tue, 23 Mar 2021 09:10:11 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id w17sm15932961pfu.29.2021.03.23.09.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:10:10 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs-progs: qgroup: remove outdated comment
Date:   Tue, 23 Mar 2021 16:09:57 +0000
Message-Id: <20210323160957.2831-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This comment was written in fb124ee4. In this version, parse_group_id()
didn't support to parse path. but this function already can parse path.
So, this comment is outdated and it makes confusing now.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

---
v2:
  Add detailed changelog
---
 cmds/qgroup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 2da83ffd..b33f77fa 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -81,9 +81,6 @@ static int _cmd_qgroup_assign(const struct cmd_struct *cmd, int assign,
 
 	path = argv[optind + 2];
 
-	/*
-	 * FIXME src should accept subvol path
-	 */
 	if (btrfs_qgroup_level(args.src) >= btrfs_qgroup_level(args.dst)) {
 		error("bad relation requested: %s", path);
 		return 1;
-- 
2.25.1

