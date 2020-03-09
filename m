Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B8917E9EC
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 21:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgCIUXf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 16:23:35 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]:41724 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgCIUXf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 16:23:35 -0400
Received: by mail-qv1-f42.google.com with SMTP id a10so835306qvq.8
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 13:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vpJ0/kSS8DBe+x7DDC9jS9as6qWh1b2sdxdmeekjT0I=;
        b=UFLD0/vUhr1ud3QdbyqBTUT5HrJRGqRmZQ8K1V6GVEMId4PL3TPFD0ZSF8zgWIWI7x
         kxtKtlUXoAGLusB4+xI1t8K7tuqed9L2+dQaRihMoVjkMK9K5+3ZqopGLSwZuajj0eg9
         mHkWDbEGPSvAb2R3i1Edl/59Sg+Yl6NvpB0XtrC15sqPf9PtQ+eQU15CnWZxAWH9bdw0
         /wHuaVJ9BmRWiyrtenIjRtkw9cwIhwhTenrY+UCDsNLHeB6RjwFZLsnYWvVW0YPqzFdZ
         WqG+2I9L6A/UjopyTI8yNc5FsBzdLXjkfgXDa6N8UllFiCOdPodNPnONer+2THx8RUOp
         ZJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpJ0/kSS8DBe+x7DDC9jS9as6qWh1b2sdxdmeekjT0I=;
        b=JfUCI3KEx+/URlrE4LyavBFHQmQi81FEtlggWkt2WQqLZ+qXSDaAqlzcg/TyFeMMb6
         SqPfoH+aKRKa6gjsvMgbTUizc6QgoPrGG7+HJ9NTxoy95P5Awe8nxDAvu2wJAdQoPuvT
         Nr7lTj0h3IAWxnEjXKiJ/CIllxDjaqaQdv5rWkCxl8f+m5NL/NVsQx3IqBxwQKd0E/gZ
         Pkb8lAcoLICiqRNXzlz6Km7lK0/aInRX88GsLHOTWdSOKDFr5vgSpZnUWYLRUqdBytgX
         f1foCiNHOuBofqRgu5E0YRL6eH1L4hOKSG0Hmh89tPJ/ykj/Df1JHQ03ggbaVdw77akd
         DQnQ==
X-Gm-Message-State: ANhLgQ0gGqUmCvwkOZgvQAfTDfUBjkhjbuchQbjODP6bjiej0aYmdXxD
        cPZ8Phh2rbQh288C4ulvN+VElgoSv1U=
X-Google-Smtp-Source: ADFU+vswTVdWM6qN1ASgv7Srr6gn1Xc+eBiFW5yQujUxnO2P4H4MHZfUD7Kay5psEwoeV9JWKtVSfQ==
X-Received: by 2002:ad4:4687:: with SMTP id bq7mr7890557qvb.248.1583785414136;
        Mon, 09 Mar 2020 13:23:34 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x7sm16790917qkx.110.2020.03.09.13.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:23:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: run btrfs_try_granting_tickets if a priority ticket fails
Date:   Mon,  9 Mar 2020 16:23:22 -0400
Message-Id: <20200309202322.12327-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309202322.12327-1-josef@toxicpanda.com>
References: <20200309202322.12327-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With normal tickets we could have a large reservation at the front of
the list that is unable to be satisfied, but a smaller ticket later on
that can be satisfied.  The way we handle this is to run
btrfs_try_granting_tickets() in maybe_fail_all_tickets().

However no such protection exists for priority tickets.  Fix this by
handling it in handle_reserve_ticket().  If we've returned after
attempting to flush space in a priority related way, we'll still be on
the priority list and need to be removed.

We rely on the flushing to free up space and wake the ticket, but if
there is not enough space to reclaim _but_ there's enough space in the
space_info to handle subsequent reservations then we would have gotten
an ENOSPC erroneously.

Address this by catching where we are still on the list, meaning we were
a priority ticket, and removing ourselves and then running
btrfs_try_granting_tickets().  This will handle this particular corner
case.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 77ea204f0b6a..03172ecd9c0b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1256,11 +1256,17 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	ret = ticket->error;
 	if (ticket->bytes || ticket->error) {
 		/*
-		 * Need to delete here for priority tickets. For regular tickets
-		 * either the async reclaim job deletes the ticket from the list
-		 * or we delete it ourselves at wait_reserve_ticket().
+		 * We were a priority ticket, so we need to delete ourselves
+		 * from the list.  Because we could have other priority tickets
+		 * behind us that require less space, run
+		 * btrfs_try_granting_tickets() to see if their reservations can
+		 * now be made.
 		 */
-		list_del_init(&ticket->list);
+		if (!list_empty(&ticket->list)) {
+			list_del_init(&ticket->list);
+			btrfs_try_granting_tickets(fs_info, space_info);
+		}
+
 		if (!ret)
 			ret = -ENOSPC;
 	}
-- 
2.24.1

