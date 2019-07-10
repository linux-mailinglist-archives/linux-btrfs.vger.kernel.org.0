Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2577764CC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 21:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfGJT2h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 15:28:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44867 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfGJT2h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 15:28:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so1689796pgl.11;
        Wed, 10 Jul 2019 12:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AMHDCQJp00b0GaJRAcbgw9/cQ+XdnOJMO0emTYwVbRg=;
        b=dFXO1h8FL9+uwk8NuikXeMlIOY+2EtJeG1pODvDW1BJWdwxUCE92e2o4M0ty29UNpq
         TcKJcmVQqlo6NPT4atT7VQgeCwtcyt7i5meNQkjORcow/RbPm0BL4qM4rOafHrx8wskM
         /q9bP3BrgeXVczkJy4ebFbtzsisB2QIjATFyGtI5KXL4tAH/pY/sZByfaHFyBkv3symS
         kC6jxh+Rv+ncSrxXTEJhEEbS1wQZCWYC4QJ0aDz5tXmRPaGA/OxAi3fTDHoufU53lH8F
         H6Fosk+09N7Hn5XGML5i31/QzGGODuh8T9z2pPKYKFZfNBdCxY4KWQbVhz9l4sl9mEqs
         Ho8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=AMHDCQJp00b0GaJRAcbgw9/cQ+XdnOJMO0emTYwVbRg=;
        b=QMzslUaepMEH15/dQFohemB8zH5RqUTX9ygET3/OzIVTyPa/ZMBGXlt08IeUBjhQ38
         9FVvlw/jFBqcjcfNzmdzA+Ku1kvW522Ol8G3oryEtGRRDo59oQhZKkTGJTCTwJnSPF1J
         pdkCbOQIexbn480829qifJ+qkNpGzJo//zhwd7nCoz04Lm+IawZQJlYBgyXmbBeKG4LD
         XMiMZkr0YLSUg/cDyK5HoI9hOrwvruHIZvqe1k5r2ve7amSK5B1CekUS4vmCZqkzMvBP
         eu/aksJOIV7qqT6MGstv3p5gM0zFay5TiurjnAnAUBw+Sz40+v69gBpQoj4ns72lmHYr
         XGjA==
X-Gm-Message-State: APjAAAWNvljMWzOXUXvogUfIutKcCLWb0z+NG1s+/1ap0WUgiuQu8Je+
        VY9TXThwqMgeAiZot0oqQs0=
X-Google-Smtp-Source: APXvYqxMQkIH3kGzvJAbYuoN2UhpbBfgR6Zwo0oeACvIVcQgajo9nf/l/U4eklqRAzJHsPSIYWXAwA==
X-Received: by 2002:a63:fa0d:: with SMTP id y13mr38722141pgh.258.1562786915400;
        Wed, 10 Jul 2019 12:28:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id q22sm3049645pgh.49.2019.07.10.12.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 12:28:35 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     josef@toxicpanda.com, clm@fb.com, dsterba@suse.com
Cc:     axboe@kernel.dk, jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] Btrfs: extent_write_locked_range() should attach inode->i_wb
Date:   Wed, 10 Jul 2019 12:28:18 -0700
Message-Id: <20190710192818.1069475-6-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710192818.1069475-1-tj@kernel.org>
References: <20190710192818.1069475-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Chris Mason <clm@fb.com>

extent_write_locked_range() is used when we're falling back to buffered
IO from inside of compression.  It allocates its own wbc and should
associate it with the inode's i_wb to make sure the IO goes down from
the correct cgroup.

Signed-off-by: Chris Mason <clm@fb.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3f3942618e92..5606a38b64ff 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4178,6 +4178,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 		.no_cgroup_owner = 1,
 	};
 
+	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
 	while (start <= end) {
 		page = find_get_page(mapping, start >> PAGE_SHIFT);
 		if (clear_page_dirty_for_io(page))
@@ -4192,11 +4193,12 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 	}
 
 	ASSERT(ret <= 0);
-	if (ret < 0) {
+	if (ret == 0)
+		ret = flush_write_bio(&epd);
+	else
 		end_write_bio(&epd, ret);
-		return ret;
-	}
-	ret = flush_write_bio(&epd);
+
+	wbc_detach_inode(&wbc_writepages);
 	return ret;
 }
 
-- 
2.17.1

