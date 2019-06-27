Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4585658BE3
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2019 22:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfF0UkH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 16:40:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41061 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfF0UkG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 16:40:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id c11so2956762qkk.8;
        Thu, 27 Jun 2019 13:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rSl5Em3E7t4PowLidlG5XJQX39ZMKusUKIIGePH/ZaI=;
        b=M2xcfW5/a5KT7xxFW2u20pf83/TLWWue8R/PvJp98eItgcG0KR5HAkEJaKay6cgAYz
         hcZWI7mnqLjIWP7yuA3zpAvSyE39gFO2SBOaZXUtW9nET16EnhritPjGtxlVjF4jCc0M
         bBjy+JCy4waWrXCPeLXqoBPXdK20yC4G56Ca37Xf3Q1GTqnsrJC3PeLPI/5QhCX2KiLy
         5omBq5FrgEfiDtcrRSYyLidLrVzFQUyYd9eFS84BGqNptzBrVhhxePPfx5px9+x0jSqr
         iNMnontB+5QRT6QqVwfwE0ctQozPwpmpB60iEIFxgVjGrUkYQBerscXbZURfolLPEcKK
         /D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=rSl5Em3E7t4PowLidlG5XJQX39ZMKusUKIIGePH/ZaI=;
        b=AchmqMKmQU4rJe1Yz/WcUcOQL4Aq4pXSYDMHPyvDmMOdBiyHNcJgQ07Fq6m5V3udD4
         WEM+5+wp/IKEoDwxwMWL8EKouHib15onB7KAP1FYV9zZqnxHMxZkiB9zJJbbpPkMh1Rs
         Z7qVMcDZTZN+M2aGdr/snZTOvPMBe7D03kEhLazEkf4qjk140jLspx289Qw0MuwozPff
         bZQbEomzcyr1U55l6uZciYayujPp408CMBcPRNqs4trvZ9Oj8BI7qYyAmqPa6g02rgjb
         7/bSEplMHZN/sePOlzCP4sp9EC3yW/8B9z2WoUATntmixryVlZFJeMp8vYDVeNPHHuNV
         8m5A==
X-Gm-Message-State: APjAAAUQbEgFyhM6hYtb2+ZDTYM8bNInfWBBCabkSYIvJqVtiW84KIaQ
        if/pOtSnEjyG29uNorWW698=
X-Google-Smtp-Source: APXvYqx2JI0dl6XBW4xAWJ1qXPBVZ1WFgQyiXRixoGKykxjclQPXHWLff2XckRTwxx1XnTwBdnN18g==
X-Received: by 2002:a37:a86:: with SMTP id 128mr5373463qkk.169.1561668004948;
        Thu, 27 Jun 2019 13:40:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5a51])
        by smtp.gmail.com with ESMTPSA id o38sm120603qte.5.2019.06.27.13.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 13:40:04 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     jack@suse.cz, josef@toxicpanda.com, clm@fb.com, dsterba@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] blkcg, writeback: Add wbc->no_cgroup_owner
Date:   Thu, 27 Jun 2019 13:39:50 -0700
Message-Id: <20190627203952.386785-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627203952.386785-1-tj@kernel.org>
References: <20190627203952.386785-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When writeback IOs are bounced through async layers, the IOs should
only be accounted against the wbc from the original bdi writeback to
avoid confusing cgroup inode ownership arbitration.  Add
wbc->no_cgroup_owner to allow disabling wbc cgroup owner accounting.
This will be used make btrfs compression work well with cgroup IO
control.

v2: Renamed from no_wbc_acct to no_cgroup_owner and added comment as
    per Jan.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c         | 2 +-
 include/linux/writeback.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 0aef79e934bb..542b02d170f8 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -727,7 +727,7 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 	 * behind a slow cgroup.  Ultimately, we want pageout() to kick off
 	 * regular writeback instead of writing things out itself.
 	 */
-	if (!wbc->wb)
+	if (!wbc->wb || wbc->no_cgroup_owner)
 		return;
 
 	css = mem_cgroup_css_from_page(page);
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index dda5cf228172..33a50fa09fac 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -68,6 +68,15 @@ struct writeback_control {
 	unsigned for_reclaim:1;		/* Invoked from the page allocator */
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
+
+	/*
+	 * When writeback IOs are bounced through async layers, only the
+	 * initial synchronous phase should be accounted towards inode
+	 * cgroup ownership arbitration to avoid confusion.  Later stages
+	 * can set the following flag to disable the accounting.
+	 */
+	unsigned no_cgroup_owner:1;
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback *wb;	/* wb this writeback is issued under */
 	struct inode *inode;		/* inode being written out */
-- 
2.17.1

