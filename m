Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA914509C
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 02:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfFNAd6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 20:33:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35864 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFNAd5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 20:33:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so468220pgi.3;
        Thu, 13 Jun 2019 17:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g3Gi8DffQm5IvbH4amu3rwd2AgRjtOkwiizeIPZ8bC4=;
        b=rvQAZUJFX2R3lXeU2x+V5wBlwbIoWXPu3GKOpeFiQ3RXyJ1jeAL0/e17CGNft2rhrX
         C98IKGfrqAdktxu2RyjD5e1YGBrg5sfaCFVnJDNNW6Y/NSb5zoqFp+7w8XY5UkSP/seM
         bk20mFQAQQxbfMlLT+qamrbbOzCmt2KeQFlC+N+G9Qq8dYBWMYG5dfy6yAyw+93V6DZm
         +kMwOKX8sB+EoZr1wlDTQUZBnYVMT7j/CyFnld5HkKVlc6uZDffm1lZfoI7+G+jfw0PB
         tdwbWTTkcSxzFKGpX4RtffK4GeyLz2nCmYoXYmwK5yNEbtCE9zQituvUyScIaAot4bJM
         amLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=g3Gi8DffQm5IvbH4amu3rwd2AgRjtOkwiizeIPZ8bC4=;
        b=YMyBUj3GvHFnctlMF8ifG3/+8XqF0laNGJ0tyoBGbEkV4SVVqHzWTrt9AREhD0vhCT
         Y9941RDmFIyn0uhcdyoZFtZE/Yd+fmMpgGDbpWJOJFJISEj+8k3YyF0qUeQlzwuzkLYL
         emVyh76esJml5Zps15bKRkm9/24dqIfZfxJWVVxOQeCiYkD355ZPGqp9HTChsRKN7Ujc
         lUixvjvOjK1M3G8bZJocFpHYNJoC+4ExJcJm0C/LN5yDrmbn1G1A30cH1WcPCe2dyQ5Z
         Q/Cd8KJeQmogUblsyXd0Cydh9D3Bq9vanODX2t7+upt18kFRxtTa385TK6v/Yop5d24Y
         uDXg==
X-Gm-Message-State: APjAAAWkybZC8h1tZi3HerXvXRMy6cFYcA1l59seBhizETVf5Sc7UIqq
        PgL+l+EnBw//3VuII4bJbUY=
X-Google-Smtp-Source: APXvYqwSECXMKx4WcTqubSqZ2goTeL0wAPRtCcx0+/9G0MyUC9o8uoV6sIiRlA7ObP0dRXQGYDtgAw==
X-Received: by 2002:a17:90a:bf84:: with SMTP id d4mr8049813pjs.124.1560472436352;
        Thu, 13 Jun 2019 17:33:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id l7sm879098pfl.9.2019.06.13.17.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 17:33:55 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/8] blkcg, writeback: Add wbc->no_wbc_acct
Date:   Thu, 13 Jun 2019 17:33:43 -0700
Message-Id: <20190614003350.1178444-2-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614003350.1178444-1-tj@kernel.org>
References: <20190614003350.1178444-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When writeback IOs are bounced through async layers, the IOs should
only be accounted against the wbc from the original bdi writeback to
avoid confusing cgroup inode ownership arbitration.  Add
wbc->no_wbc_acct to allow disabling wbc accounting.  This will be used
make btfs compression work well with cgroup IO control.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/fs-writeback.c         | 2 +-
 include/linux/writeback.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 36855c1f8daf..6c8061a49ca0 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -721,7 +721,7 @@ void wbc_account_io(struct writeback_control *wbc, struct page *page,
 	 * behind a slow cgroup.  Ultimately, we want pageout() to kick off
 	 * regular writeback instead of writing things out itself.
 	 */
-	if (!wbc->wb)
+	if (!wbc->wb || wbc->no_wbc_acct)
 		return;
 
 	id = mem_cgroup_css_from_page(page)->id;
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 738a0c24874f..b8f5f000cde4 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -68,6 +68,7 @@ struct writeback_control {
 	unsigned for_reclaim:1;		/* Invoked from the page allocator */
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
+	unsigned no_wbc_acct:1;		/* skip wbc IO accounting */
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback *wb;	/* wb this writeback is issued under */
 	struct inode *inode;		/* inode being written out */
-- 
2.17.1

