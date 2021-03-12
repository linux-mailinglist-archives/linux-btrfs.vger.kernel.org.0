Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E8D33983B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhCLU0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhCLUZt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:49 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AC8C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:49 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id a9so25667739qkn.13
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yGZq1T84yQVr050eCKw8GJf16/T74xYoC5HGNX6oqj4=;
        b=jsQ3rS+sOfT2pv7XIOzXxDdTZ9geBGOAoLHPy1Gsgg8h7Onx6Cz1Ccz3nv3vrrAs+r
         PEaGucKOpKfoK7b3q6YHqmms2kMgl1KuVRp0bT11DXJGK0YT7UhCPmcImb0Y5GDnWvdb
         ZdMTW2wIhmsK1ZLuSGvO+84ibagQpFoZH9Knqc+SNiSFBaROolC+WhFekuSAjZ2rpPQW
         KMkzTaeQ4+d5FzgPTzvtECupAMcDbmJVrq3iQCQuDLXaT2423CszvQd9GUcAxbMh1KgY
         j40D5YPBEedrIBlcJMSqclk1SE9zoYZFaFfjNXOx6jL4Ejfstmfvtxbv5JN8FKnQ2j6i
         PD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGZq1T84yQVr050eCKw8GJf16/T74xYoC5HGNX6oqj4=;
        b=ctuSXqerZ2H9A1Uhb8ZliS1dTyQd1FHFIzC3MJ0YmbBr1SJk6TJRYx97Q2UepRH3aV
         JdRmEaaqMfQ0vN6StEGaPHRIxFGjk3CQMnbf4O46dqjlC4J4MTAZl3siAVQl3QLiiGf1
         ACw4lCO/rUZOU56f2//ipee/oKLdSDPg/SMBVI5RTWHqR29RR7wmOF36cqaXqpPQV+U4
         B+C+OEAZPRxr/+k2+fvfb6MxU2cStAK17J5p3gMecYM9A25md0EFQorG5HhA73dmtTvW
         vsVW/1++Ml//ffVOF2bmEZCGsAwp7/qzloOrCFoTTt234bsBEnUejMRsYmWIjWkZSWI6
         GZxg==
X-Gm-Message-State: AOAM5314ISUXNj8kNO+mN8NTeaotDEqgG12PwikASqXIxDDSDGpWTAd+
        zUkWwAjEQWEywTRt5GOyH3JlRWnPjSWCKRJX
X-Google-Smtp-Source: ABdhPJxlDlkCJobFot3eiBDTaMpHIbljcDT1AaGrgDRAlqy+M+D+Nnw6jRe4dB2SHezWRjZoJkGOBA==
X-Received: by 2002:a37:65d4:: with SMTP id z203mr13946982qkb.254.1615580748649;
        Fri, 12 Mar 2021 12:25:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m17sm5212400qkh.82.2021.03.12.12.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 08/39] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename
Date:   Fri, 12 Mar 2021 15:25:03 -0500
Message-Id: <7416cf0c51b510cf4b8f5e2505f8684d8c2630a4.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a9fde9a22fff..c64a5e3eca47 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9410,8 +9410,11 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out_notrans;
 	}
 
-	if (dest != root)
-		btrfs_record_root_in_trans(trans, dest);
+	if (dest != root) {
+		ret = btrfs_record_root_in_trans(trans, dest);
+		if (ret)
+			goto out_fail;
+	}
 
 	ret = btrfs_set_inode_index(BTRFS_I(new_dir), &index);
 	if (ret)
-- 
2.26.2

