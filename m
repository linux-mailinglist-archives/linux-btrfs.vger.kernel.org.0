Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07114F4D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgAaWge (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:34 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33940 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgAaWgd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:33 -0500
Received: by mail-qt1-f194.google.com with SMTP id h12so6745957qtu.1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m89TUixA1F2eueluk4MjDZtHVKs272tFOVWQ6OnEAc8=;
        b=BxdXSBQZxwrwyT/ML5kGDaklv/AN9RZ68dN4QOm0CJ22+BzyhtJ9xqeE0TnfYOXgf3
         aF3OKB6NEsITyewpeP9muqLR+b4nMmnEQmbMVoEB/SileHzpBfniEVyAWB5dDXh20knN
         CNReuGEsxovytfmgqyY4Cb7lM2sfi8UhctVCq/aKqlsIwdsSNYlBDrowu2tViXhm1iVI
         Y2OItosnhhSPW3liX+vYsn9+bMnBG1FHzybxAyTNOIiYWDdCzjESUPHiQ2JtE/aRzy5Y
         QQ5i/aPc6BKaP6y4py0Kwq0rwaHSxsK9b6dJRjAtn/+CSn8wMjG+KeJLL7403YmSCk/k
         MMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m89TUixA1F2eueluk4MjDZtHVKs272tFOVWQ6OnEAc8=;
        b=Kngpyxt8GIL+wpr7L9GLuW89DQ2g4LTWpM0Gg6VpK02AJgSY3/ZJzJ+SbCr6VxzMqh
         K5PtXpFxc4g6f1pzIxfBpqPBXq/B+eRAwQYuZwrLwAVlPJBy4wiDzipfCEdKnyZ4a1KH
         ahumq57BEiiIPUnuuNLvRaaMtXUh7lUsEVe5/GvCR1jmqUDJHN3uuXATn/p2q4S3udKF
         sS30IX0V/XSxAc1nEseuBV0BIQpVVRGUxkw/7mVYXq45lBQgtCegmEYZrK6/LyVNofdF
         pqL/9pAYt9+copZe3nYZvlBm48HDbDtL96jHu57jqRLiQbHu7Zjc5BUU1oHencofrVvQ
         ltMg==
X-Gm-Message-State: APjAAAXWBDujB7Lg+9xMZL6X5kRhqDW4rV6+eDWTBEmVcH3eUWCnyOPB
        PSBUutaNDbJTvwrAahA0KCBGDXrKO8HUIA==
X-Google-Smtp-Source: APXvYqwWlu+0CnKGw5v5kycFBIxfmVeZo4wJ2Bl/jW40wZSBvLjUyIoqlIZYFbI2ju7IMs+6HA7CJQ==
X-Received: by 2002:ac8:1206:: with SMTP id x6mr13312630qti.55.1580510192362;
        Fri, 31 Jan 2020 14:36:32 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j1sm5176808qkl.86.2020.01.31.14.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 09/23] btrfs: use the btrfs_space_info_free_bytes_may_use helper for delalloc
Date:   Fri, 31 Jan 2020 17:35:59 -0500
Message-Id: <20200131223613.490779-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to use the ticket infrastructure for data, so use the
btrfs_space_info_free_bytes_may_use() helper in
btrfs_free_reserved_data_space_noquota() so we get the
try_granting_tickets call when we free our reservation.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delalloc-space.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 4cdac4d834f5..08cfef49f88b 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -179,9 +179,7 @@ void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
 	start = round_down(start, fs_info->sectorsize);
 
 	data_sinfo = fs_info->data_sinfo;
-	spin_lock(&data_sinfo->lock);
-	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, -len);
-	spin_unlock(&data_sinfo->lock);
+	btrfs_space_info_free_bytes_may_use(fs_info, data_sinfo, len);
 }
 
 /*
-- 
2.24.1

