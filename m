Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0072929085B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410111AbgJPP3d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407477AbgJPP3c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:29:32 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F4DC061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:32 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e6so1819132qtw.10
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Yx9otvDd5onkeTvAXlblsQFo6BfxZq/uyXmsV0srymM=;
        b=gd06BLzRX9qG66VRM7VOVUOYVQhEf7vFhSPG4O+dwfbL40/nME8lSaypu1fESmxlBj
         395yevBuh+I64OmR43Y1uab2sk/o6RScD6wWwd6vTbfmxdvVXn6V71d4ramh7qNq3XJV
         OI34a1Uns6Yt2/fSwc3jTKu/aruUsa9QDsIpqi6/R2wJqT4xayNepDl7dj77eUv+KUA8
         4bcQLi7VsfsnVcyDu+0sNCDmgRlGa3UqoMtBykETVXqhrEzZyJ5IBX/m+FVrkQSnu6Fq
         T6ZKkn2kApimGcwQbEGpZywUive2okzNt9GUiBCYmymLjNvF5QdKTFRW+iJby3+PBiw1
         FgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yx9otvDd5onkeTvAXlblsQFo6BfxZq/uyXmsV0srymM=;
        b=Ycre7Fjm10qGlUNw0tQ8FJWM7RVvgJNSV28nNtRkRYeNyD+8mkXIjjR1/NuMxjPl39
         1943o4LbiKOA3ztbZB8OBOg1SH+55ayJlVs6ZkfMOhMXJkN7hDCzkW2mtGWHavqPSdP6
         q5rVr8Y3FOf+afdCGDaeMmIRVYHGlEu55sKCevuvX7qrYLtoLKSGzIl/+rP7Tli81e1b
         6/7hVr7FyuCcBXDFsffga4rqgFbIKQ48kMHKphEBFL2MqQc2ZLUadVWAfoC7LwXlxAsq
         MYm64w/zF4/nwHEJsVQBj/FvWjJ+QhXIZL2yStTMqSNISL1Djb0o7/lFyvOdzfOu8waZ
         iHyA==
X-Gm-Message-State: AOAM533p96ED+lvgJwjn0P+EfgXZ1s3FT429NBd+e7vHCHuF2B7YXRBM
        enTJqy+0Cqa2ZUWpI0sWp4fVh23LDmKfWCzD
X-Google-Smtp-Source: ABdhPJxxvubOMo5eXfL79N1Bd8ghTVcbCu03N+RxJe1IwUOs8VyW0L+Fuoxyp3gvwzFQkCD6lxt3Dg==
X-Received: by 2002:ac8:4791:: with SMTP id k17mr3995990qtq.264.1602862171203;
        Fri, 16 Oct 2020 08:29:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m6sm968201qki.112.2020.10.16.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:29:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 5/8] btrfs: show rescue=usebackuproot in /proc/mounts
Date:   Fri, 16 Oct 2020 11:29:17 -0400
Message-Id: <007ef6e4d542210148bc373d3a432d801e83019e.1602862052.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602862052.git.josef@toxicpanda.com>
References: <cover.1602862052.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This got missed somehow, so add it in.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f41f7af27ff7..ca270649fe10 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1438,6 +1438,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",notreelog");
 	if (btrfs_test_opt(info, NOLOGREPLAY))
 		print_rescue_option(seq, "nologreplay", &printed);
+	if (btrfs_test_opt(info, USEBACKUPROOT))
+		print_rescue_option(seq, "usebackuproot", &printed);
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
-- 
2.26.2

