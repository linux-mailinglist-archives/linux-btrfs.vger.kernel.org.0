Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C708A903E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfHPOUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 10:20:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38584 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfHPOUL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 10:20:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id u190so4839282qkh.5
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=laSrz6aSwTmfiFQuGoA2JGnNj999gBntdDTBzK/y71U=;
        b=cHQMM7Mm0XPALHKk0zQ/KBmMscTgbRJTgaveAngIoQLR8AWhvqn2OBxva6mlw2ZVdW
         7Drdhfjr4uwbYl8Z4W6TZwmrqmkEtsTz1JVOa3cm9iUX4kg/8NQ3qVahBdK+/5T033/n
         td8I42biu/0dmKKSCIhpG+lykhW5ZVq9waD0fQv21u64pvCBDWST2B7d12IzTC4yj47S
         2ccHq72w25U7dFX2qeOSShHFcToTizU3CT+fo5Dsc5rgwmgTR4DX1OI4+4N2IkOHos1I
         yH+TxcVwv40yNka/RDtMpzdc8z6N7k+DP4Cq/q+vjowliF95hGDUKtVmuZxQrO5TNPNe
         GDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=laSrz6aSwTmfiFQuGoA2JGnNj999gBntdDTBzK/y71U=;
        b=HGw/NGgxQLwDsb5KN2cWl9Y7yapqCoHZ+FMHyxmap3GJnoyh2i6PRBX3Y0XsvQeqhO
         N8WtMYZP+5TRgQpZ/9z2jOjZv1z0G8xnfraIaveoTIRaDDj/i1VXFLx4GiCCAA0H2cOa
         O918XRqYGwfC+dVvPk1xOIvN4PUIsHweayb/4eMcPScEU34IzK7oYlOUcK+3zR6nM/aM
         TN7GMP1jHt2q3MdxnCfxGQEuH3jvXZZQSvVwRhKws+BauVZHAJfKsNg97+OlArKJzPux
         8V2nSZGjRpHLOaJdNfVOjN9iHqs05566dwR6x0fJx5mXeMOk9wwmJg5zXwFTU1qEJse+
         hbPg==
X-Gm-Message-State: APjAAAVFz2+R5BuYxQUtqLu6X28lPowBoiLUjtGqkupuYXXJ0xCCV3p6
        +2Kib07KlfM7mImV2ITAKBxi9tzJOg0Raw==
X-Google-Smtp-Source: APXvYqxJw0TjSC0yb+QejgvT4A+dgZp9UgBJF098szVzezhIDoPoQ1Fhp0ua+AUNPGP4Z3mzkIsvbg==
X-Received: by 2002:a37:91c6:: with SMTP id t189mr1044028qkd.59.1565965210057;
        Fri, 16 Aug 2019 07:20:10 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r4sm3482861qta.93.2019.08.16.07.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 07:20:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/8] btrfs: remove orig_bytes from reserve_ticket
Date:   Fri, 16 Aug 2019 10:19:52 -0400
Message-Id: <20190816141952.19369-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816141952.19369-1-josef@toxicpanda.com>
References: <20190816141952.19369-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we do not do partial filling of tickets simply remove
orig_bytes, it is no longer needed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 15 ---------------
 fs/btrfs/space-info.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f79afdc04925..c8867a0d9f5a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -856,7 +856,6 @@ static int wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 
 {
 	DEFINE_WAIT(wait);
-	u64 reclaim_bytes = 0;
 	int ret = 0;
 
 	spin_lock(&space_info->lock);
@@ -877,13 +876,7 @@ static int wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 		ret = ticket->error;
 	if (!list_empty(&ticket->list))
 		list_del_init(&ticket->list);
-	if (ticket->bytes && ticket->bytes < ticket->orig_bytes)
-		reclaim_bytes = ticket->orig_bytes - ticket->bytes;
 	spin_unlock(&space_info->lock);
-
-	if (reclaim_bytes)
-		btrfs_space_info_add_old_bytes(fs_info, space_info,
-					       reclaim_bytes);
 	return ret;
 }
 
@@ -909,7 +902,6 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 {
 	struct reserve_ticket ticket;
 	u64 used;
-	u64 reclaim_bytes = 0;
 	int ret = 0;
 	bool pending_tickets;
 
@@ -943,7 +935,6 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	 * the list and we will do our own flushing further down.
 	 */
 	if (ret && flush != BTRFS_RESERVE_NO_FLUSH) {
-		ticket.orig_bytes = orig_bytes;
 		ticket.bytes = orig_bytes;
 		ticket.error = 0;
 		init_waitqueue_head(&ticket.wait);
@@ -990,16 +981,10 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	priority_reclaim_metadata_space(fs_info, space_info, &ticket);
 	spin_lock(&space_info->lock);
 	if (ticket.bytes) {
-		if (ticket.bytes < orig_bytes)
-			reclaim_bytes = orig_bytes - ticket.bytes;
 		list_del_init(&ticket.list);
 		ret = -ENOSPC;
 	}
 	spin_unlock(&space_info->lock);
-
-	if (reclaim_bytes)
-		btrfs_space_info_add_old_bytes(fs_info, space_info,
-					       reclaim_bytes);
 	ASSERT(list_empty(&ticket.list));
 	return ret;
 }
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 9ae5cae52fde..ebc5b407a954 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -70,7 +70,6 @@ struct btrfs_space_info {
 };
 
 struct reserve_ticket {
-	u64 orig_bytes;
 	u64 bytes;
 	int error;
 	struct list_head list;
-- 
2.21.0

