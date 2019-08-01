Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B617E549
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 00:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389410AbfHAWTo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 18:19:44 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34378 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfHAWTn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Aug 2019 18:19:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id t8so53332835qkt.1
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Aug 2019 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nZPrvNMXJ8qeBbBl7IHk9h8xErrr9OKxhGMLKN1MGoI=;
        b=iMqViAUVWkKVWniCnFGIROAGABOfuVxKmP8pFzIoKWO6xSPps1DyF80G2foXFDTL54
         RO4w3BIKjMGJM7vQTM8/IHJYwLLNuXdlcnCEOeGSrwZktPf7PlN+cID6txvwsr01f1r6
         dUabiqZmTMgpNvCX33NPu+5Tm9FaDt9hYfCm6XN2XMDLdm+9yCU3u8BhHUniZIwRsySy
         zWaPQvhPzxzJgKW+OHKnn269BTHe79KxazKaByDzM7GNDq0JeYhBThb1PN88FVTENOvE
         4/Z2bWzu76sDL52v46Xdq/AHX80X0+AhsRis+iR+1YZ/1i2GSDpTvNrh1ct8HNAGDVKN
         ravA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZPrvNMXJ8qeBbBl7IHk9h8xErrr9OKxhGMLKN1MGoI=;
        b=SxYbIJ1Wn3XzXowIC//ZsRUhHDswPxX2M+olI/QWSgnrjxY0E6a0oG5E9aM8cT9cMO
         dZsqQt9AzJWZbncXv+obH2u/eiXaqbiowUqfhs+xbybPhTFcgTmsV3YK4zS7hpKfIGH5
         HtMLKAgKq76PL2Bv7x9lndfMozuw0YTh8Wg9eubjH32b2fZGb1tZIpXTv14axkzf3V+n
         UwlKnABnYEvXdMxIKh7p4pCPqdBI6XowvCd681waU6aAp4mxDr15x/hy73CIg+Z7F/QT
         HoDOel0SJcHY8z3EEUtWNZ0UPltxtuSUWkKN0vnEmrTGitcNzpYLnd4rBBw3mD0XBnUS
         XrDg==
X-Gm-Message-State: APjAAAVB5jraVRAb5iGk9wP13htLTixGonN/hpu2QN6tFto6S+9b/5ML
        +cUs/lqduMNpz7JYXZ2zGEl4tNnzoH8=
X-Google-Smtp-Source: APXvYqx/+C9UlMKD4U0CExedfK86VB8zVX1ZArMtcfTBnLyVrBAlTKYQ5mto0Gku4nVKBjYT2PwMLg==
X-Received: by 2002:a05:620a:12ef:: with SMTP id f15mr9358786qkl.340.1564697982689;
        Thu, 01 Aug 2019 15:19:42 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z19sm33508961qtu.43.2019.08.01.15.19.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:19:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/5] btrfs: unify error handling for ticket flushing
Date:   Thu,  1 Aug 2019 18:19:34 -0400
Message-Id: <20190801221937.22742-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801221937.22742-1-josef@toxicpanda.com>
References: <20190801221937.22742-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we handle the cleanup of errored out tickets in both the
priority flush path and the normal flushing path.  This is the same code
in both places, so just refactor so we don't duplicate the cleanup work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 7dfac0d4b24c..ce7ae1cd1153 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -898,20 +898,19 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 	} while (flush_state < ARRAY_SIZE(priority_flush_states));
 }
 
-static int wait_reserve_ticket(struct btrfs_fs_info *fs_info,
-			       struct btrfs_space_info *space_info,
-			       struct reserve_ticket *ticket)
+static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
+				struct btrfs_space_info *space_info,
+				struct reserve_ticket *ticket)
 
 {
 	DEFINE_WAIT(wait);
-	u64 reclaim_bytes = 0;
 	int ret = 0;
 
 	spin_lock(&space_info->lock);
 	while (ticket->bytes > 0 && ticket->error == 0) {
 		ret = prepare_to_wait_event(&ticket->wait, &wait, TASK_KILLABLE);
 		if (ret) {
-			ret = -EINTR;
+			ticket->error = -EINTR;
 			break;
 		}
 		spin_unlock(&space_info->lock);
@@ -921,18 +920,7 @@ static int wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 		finish_wait(&ticket->wait, &wait);
 		spin_lock(&space_info->lock);
 	}
-	if (!ret)
-		ret = ticket->error;
-	if (!list_empty(&ticket->list))
-		list_del_init(&ticket->list);
-	if (ticket->bytes && ticket->bytes < ticket->orig_bytes)
-		reclaim_bytes = ticket->orig_bytes - ticket->bytes;
 	spin_unlock(&space_info->lock);
-
-	if (reclaim_bytes)
-		btrfs_space_info_add_old_bytes(fs_info, space_info,
-					       reclaim_bytes);
-	return ret;
 }
 
 /**
@@ -1030,16 +1018,18 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 		return ret;
 
 	if (flush == BTRFS_RESERVE_FLUSH_ALL)
-		return wait_reserve_ticket(fs_info, space_info, &ticket);
+		wait_reserve_ticket(fs_info, space_info, &ticket);
+	else
+		priority_reclaim_metadata_space(fs_info, space_info, &ticket);
 
-	ret = 0;
-	priority_reclaim_metadata_space(fs_info, space_info, &ticket);
 	spin_lock(&space_info->lock);
-	if (ticket.bytes) {
+	ret = ticket.error;
+	if (ticket.bytes || ticket.error) {
 		if (ticket.bytes < orig_bytes)
 			reclaim_bytes = orig_bytes - ticket.bytes;
 		list_del_init(&ticket.list);
-		ret = -ENOSPC;
+		if (!ret)
+			ret = -ENOSPC;
 	}
 	spin_unlock(&space_info->lock);
 
-- 
2.21.0

