Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D0347195
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jun 2019 20:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfFOSZI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jun 2019 14:25:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43916 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfFOSZH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jun 2019 14:25:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id z24so6310897qtj.10;
        Sat, 15 Jun 2019 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9sm1pVtM6HiDSHPec5dQ2RrXdzESv3uF6n2cxGS4b90=;
        b=LaQmOARvbblztTTfLS5Ehee5ijSLh4q543RGtynnH4HkuNB7M4uzAhQLD3JXJarPmn
         JRDk8C6WcBIsYUEngq32//h7IhZto6U5aH3rLMQ6H4GnH067999tO6/YxQS8kysWuc6s
         gVn3YdJx+RYd4DKUmUaVW1fRxrO0kbSJsFxRSLasWGOb1ptV6thdmM/0gX14C9ptyEFn
         7FJnGd9lr1jgSpXt024xBXGvqRzWH0uYdv9HpEZU4lvrZf0oKydBQTvcvE0RZjWy6zOB
         v4glJnAua7DpxyBdwhVD9fm0exxkGt0DEqIpfwagFte8xga4BIgqkcT7PBHU6LuE99/K
         5jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=9sm1pVtM6HiDSHPec5dQ2RrXdzESv3uF6n2cxGS4b90=;
        b=llz+ei3au7FArEK8xwr6/VqeTJpG0t31Xwsd1hNkYzyt8N2a4T+IkDRRUI0tNeqqGY
         sxgHdnrv8iRrfRQYDrwpOQgDvhk+Rrfsaq6Vth4guSeBE/YEe5eEXst8fcf4/2x43k1T
         CQ4c9rZ6JHeH0t8PC7DyA2M/qL830x0QVZ+wxmNRuaipj80VHdQrKrX71wyxzN0Ji66w
         GPfZWMlIiz8wJH2RdC4Tu4h2B8VxpyLxSo/uMpNwezfvNMOU2h7dhdZbgFExI/cUtTux
         Sxyaef2OQ5rc1U8xtbcq9aYdXQcCqIh5ROG6Q7funIocKYwolzrAMZxSsW78ySWqEzn4
         wabA==
X-Gm-Message-State: APjAAAXuK/UxOBO+VbqG1HZ+pUer+Tid/iWAHAySt0+YhWQY5tK6J32+
        wC2OhAQ2Yl0i0qdPsbKMTrM=
X-Google-Smtp-Source: APXvYqwCG3rONyzLg+di3X49mi3qomyEHccDtC6yZgNxwCjZg1WAD2VALGRr2jdBrcID4Cylu6mjsA==
X-Received: by 2002:aed:3b25:: with SMTP id p34mr86126011qte.289.1560623106540;
        Sat, 15 Jun 2019 11:25:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4883])
        by smtp.gmail.com with ESMTPSA id l3sm3499902qkd.49.2019.06.15.11.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 11:25:06 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/9] blkcg, writeback: Add wbc->no_wbc_acct
Date:   Sat, 15 Jun 2019 11:24:46 -0700
Message-Id: <20190615182453.843275-3-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190615182453.843275-1-tj@kernel.org>
References: <20190615182453.843275-1-tj@kernel.org>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c         | 2 +-
 include/linux/writeback.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index c29cff345b1f..667ba07fffcd 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -724,7 +724,7 @@ void wbc_account_io(struct writeback_control *wbc, struct page *page,
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

