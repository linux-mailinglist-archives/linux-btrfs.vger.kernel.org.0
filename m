Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254AC7E548
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 00:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbfHAWTm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 18:19:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34376 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfHAWTm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Aug 2019 18:19:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so53332799qkt.1
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Aug 2019 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Xl1dTrL5seaXbUGaVnYhNkrrBWqXmhFFgquiHTthXWw=;
        b=hWh/pXUecQwD5lRK44tkh4Fae6Qqkl6Tv2tGroT0C5n0d7AafbAoE9IRbkYJ5R8gqI
         tOvcxeWOif3/TBm5TJKmwYdmiiZQPEs3klK/SMEDNa9Ayz+qehgJvVDz5SQ+6S58k627
         72uLU9sC/PazJfr3OCLy+zzyFrWu4MuKvpXx2CgSFb/zPmApDWzr8GWU8L+pgd2/OfCG
         UgKduOLBPor4cPYV7yM6c7+mkRJuiiWPbUgnIcByadg4xegFP63d8rWdBCs+Z/bwfRS5
         Dxm4DTfpuDw+mt+lIsdoBxwatNqltg4Heh3BJS0QFkgeAYx1LWzPf944M8iReHgLXGXY
         L9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xl1dTrL5seaXbUGaVnYhNkrrBWqXmhFFgquiHTthXWw=;
        b=meY+mj91d/+9Aumq1JfUcvx8+1QS6XsGatFvcU4au5CYfTO+ari84kkpUEQLUQx6Mc
         92moGfumCroetqbdpE09P3F7h35Es5cCsfemVR5VRedwPRs2dKsYGOY7A5vl7hJ59dWl
         RCZoqAO60E1qSghZc9B7FZaphSUmBkeKQn+70wGvepW/JBCE41bOpliIpbIhcSHASTks
         UYrll6l4SxR1wttYRfRtMjdVZ5vqZK+t2Xi8ibRYHixeRkXIXdgWKkuwiZBjTLFch+vN
         mF0SI7+iRlYDRvjX8NwQ37DjFXhhuMibw0+uPKz4ABv9qMCX+EX6SRUTKNtGTcOcdyWj
         5KAQ==
X-Gm-Message-State: APjAAAV7DgFlEfwCOiaIjAPSwKVpu8mjamx6KCpLOxNzX4ZMKvfEDbKo
        Sq4AjWt6qvChjyvRYZr6vMkrtzTGvD8=
X-Google-Smtp-Source: APXvYqxtPScgKvVUUDu16QQq75W+b5feFTi/AHJ3VbEjzB0x6iddgdK/YiPnJdl8+ZvXkwLuNMNkGw==
X-Received: by 2002:a37:512:: with SMTP id 18mr82009743qkf.220.1564697981023;
        Thu, 01 Aug 2019 15:19:41 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x2sm30831168qkc.92.2019.08.01.15.19.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:19:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/5] btrfs: add a flush step for delayed iputs
Date:   Thu,  1 Aug 2019 18:19:33 -0400
Message-Id: <20190801221937.22742-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801221937.22742-1-josef@toxicpanda.com>
References: <20190801221937.22742-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Delayed iputs could very well free up enough space without needing to
commit the transaction, so make this step it's own step.  This will
allow us to skip the step for evictions in a later patch.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h             | 3 ++-
 fs/btrfs/space-info.c        | 5 +++--
 include/trace/events/btrfs.h | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 299e11e6c554..313a8194c0ef 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2733,7 +2733,8 @@ enum btrfs_flush_state {
 	FLUSH_DELALLOC_WAIT	=	6,
 	ALLOC_CHUNK		=	7,
 	ALLOC_CHUNK_FORCE	=	8,
-	COMMIT_TRANS		=	9,
+	RUN_DELAYED_IPUTS	=	9,
+	COMMIT_TRANS		=	10,
 };
 
 /*
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ab7b9ec4c240..7dfac0d4b24c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -684,7 +684,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		if (ret > 0 || ret == -ENOSPC)
 			ret = 0;
 		break;
-	case COMMIT_TRANS:
+	case RUN_DELAYED_IPUTS:
 		/*
 		 * If we have pending delayed iputs then we could free up a
 		 * bunch of pinned space, so make sure we run the iputs before
@@ -692,7 +692,8 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		 */
 		btrfs_run_delayed_iputs(fs_info);
 		btrfs_wait_on_delayed_iputs(fs_info);
-
+		break;
+	case COMMIT_TRANS:
 		ret = may_commit_transaction(fs_info, space_info);
 		break;
 	default:
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 2f6a669408bb..08f294f96424 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1088,6 +1088,7 @@ TRACE_EVENT(btrfs_trigger_flush,
 		{ FLUSH_DELAYED_REFS,		"FLUSH_ELAYED_REFS"},		\
 		{ ALLOC_CHUNK,			"ALLOC_CHUNK"},			\
 		{ ALLOC_CHUNK_FORCE,		"ALLOC_CHUNK_FORCE"},		\
+		{ RUN_DELAYED_IPUTS,		"RUN_DELAYED_IPUTS"},		\
 		{ COMMIT_TRANS,			"COMMIT_TRANS"})
 
 TRACE_EVENT(btrfs_flush_space,
-- 
2.21.0

