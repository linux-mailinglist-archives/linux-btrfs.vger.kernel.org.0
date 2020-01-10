Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F12813728D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 17:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgAJQLk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 11:11:40 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34013 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgAJQLj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 11:11:39 -0500
Received: by mail-qk1-f193.google.com with SMTP id j9so2335970qkk.1
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 08:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DyDAz2Q0/khHEfDeawAepIW8Us8SoB1b9lUueAtktHI=;
        b=eyZZRLq8Be2EZVCdachsZxSaUJ4I//j1eBwymrO6ixR4McQNG8t1IoblDw78h9uZNf
         eoAjWIEKSHo30CyqEoWqPt13G6R0w9vn02cRKg7zpviTl3W96GNr68xgD5JJIor4os62
         MrjnHYdct2mqsasxHSaCh53q0MCbIQp9nedtXtWvhXo6zSaVXWuuMaP2hI6dtTkjemWY
         Ex/8c046e1hKKFsqEz5ZR4+gKePb6aQJ7Eu9F5VJ3+gBx4Jf28PAQfAc8KHBEDmVXegc
         vRKfAjtQhD2RzaERqaEDulsAWCmLK+OCDZSW9cJVFTGbZ252CWwSBuMW1gzh4oOY5NJ+
         dYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DyDAz2Q0/khHEfDeawAepIW8Us8SoB1b9lUueAtktHI=;
        b=Wk2fvVDbTDZbaTTpwZsoH0TpE5oQYJLKHVgOTB/pIhZbcnY4rndn5ki/OV8+bFQdf0
         OcTKQ5zmWA/LWhF3SwncVrb6/OImKs3CNABWg3xddeHcJKf740ve72qClXBMtJBlhiqW
         AGx9xfBHqN0ngvX4/wLYUMfSAYg8chURTnQHxxm9k1FjnfdeC7iQnCaMORFGSa59FgGc
         jMH9ZTwYsSIszLbGfO0i0EaDjnYhDQTqu8VrSshoWPpk5Pd/An5xLhjKABgEXDVrDZZQ
         r8LtMCICT/rUib/3w66lpqUIEK7uwza/JWU1/NsT42RPXa0ILaJxTPKFSVbI+LzbkuaK
         AnJw==
X-Gm-Message-State: APjAAAU3fEOKvgcHcOTaBan4RK5sx9CO9zOjowTrPABp+b5GDRZYDnyY
        QuHv7klrlF+Od0ev9yz0Ju22MLFM8pz7+g==
X-Google-Smtp-Source: APXvYqyrO+rtZu/B/6uU1ge+w0qVP+MvaKIufj+2LPhq5YE9dmVuGMhgchxeskEp0ccx/DRgCK6HMg==
X-Received: by 2002:a37:bcc4:: with SMTP id m187mr4062594qkf.329.1578672698243;
        Fri, 10 Jan 2020 08:11:38 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e3sm1198169qtb.65.2020.01.10.08.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 08:11:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/5] btrfs: fix force usage in inc_block_group_ro
Date:   Fri, 10 Jan 2020 11:11:27 -0500
Message-Id: <20200110161128.21710-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110161128.21710-1-josef@toxicpanda.com>
References: <20200110161128.21710-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For some reason we've translated the do_chunk_alloc that goes into
btrfs_inc_block_group_ro to force in inc_block_group_ro, but these are
two different things.

force for inc_block_group_ro is used when we are forcing the block group
read only no matter what, for example when the underlying chunk is
marked read only.  We need to not do the space check here as this block
group needs to be read only.

btrfs_inc_block_group_ro() has a do_chunk_alloc flag that indicates that
we need to pre-allocate a chunk before marking the block group read
only.  This has nothing to do with forcing, and in fact we _always_ want
to do the space check in this case, so unconditionally pass false for
force in this case.

Then fixup inc_block_group_ro to honor force as it's expected and
documented to do.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6f564e390153..2e94e14e30ee 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1190,8 +1190,15 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	spin_lock(&sinfo->lock);
 	spin_lock(&cache->lock);
 
-	if (cache->ro) {
+	if (cache->ro || force) {
 		cache->ro++;
+
+		/*
+		 * We should only be empty if we did force here and haven't
+		 * already marked ourselves read only.
+		 */
+		if (force && list_empty(&cache->ro_list))
+			list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
 		ret = 0;
 		goto out;
 	}
-- 
2.24.1

