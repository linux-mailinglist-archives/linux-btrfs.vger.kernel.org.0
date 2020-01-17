Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69CC3140C13
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgAQOHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:07:47 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39448 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQOHr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:07:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so21835021qtm.6
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nOdYFKTQ7nhMEaFzaQX9PfXYFaZ8/La3GwoRrcvr2f0=;
        b=DyoKyu0fr4ggybkn8SehbQ63ggGhZ858JcHRxIG4O8007tqS7tQTclARDln5XLQjvn
         AfUNr9v/IGwq5D5s3o/3ECrZ0sS8x9PqlC/0HnfGXsFR5pIUie2GFz9gWjz81hUYhBTE
         1WiOWxdE9g4IZ6PElAlaKAezXTO1FmQBamCi5NF11bUZ1Pcv+yI/nPwytU14SadV4auk
         hiZsAj70yYbAT8ObF68u3NatYqTodxougICZ7JeUSi5wUUzmWugBHt6hblo9izgjTLAX
         ed3EgCaNF1NHHPXqJ+9y2xNyB9p+OqLNszsY+KQtGWjKCDpfXkqOcsSbxdoZPEYJe1Tm
         +73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nOdYFKTQ7nhMEaFzaQX9PfXYFaZ8/La3GwoRrcvr2f0=;
        b=biNoZJXO9dS1wAX0JnNI5Gy/1VuZ1uyU2w9Ml53UevF1R6jtdqIVqyQQEscaqGFTg1
         JfwkHk3mYx5PAJb/K69i0QcZseBs19uFN3mlU1u8sFD/nveXvctjlU+COEQbF53lpxoN
         9hc276xeF3sooSKfHYLBKtVzjBR2wPsKhENLvvsXALh3gafA86XLo/qhaJaH4RYlKFhz
         bhmy576ZBV/6X5o7JKDFPedaeS/3hrs5XIwsX3NDK8j58DMgqCKwqCRCQaA6XG3aVh4m
         AaephVCDuAURUzJraz1iie0lMru0z4SU8GjzBM+6QfvjfU493a9mW34I6fN1BPfnRvCn
         KXkg==
X-Gm-Message-State: APjAAAW9OBkGeNcWLpVQC6sFJEum/kGXyX6rAKANnI+zV7kSJ1Gcm3oQ
        PWUoyYebx3Z7cIpS47ZT3vUNcK1QBx6Crw==
X-Google-Smtp-Source: APXvYqzsxu8JOqV4Qr/ROgrdFWwjQSJtnmzagt/8x7Ez1tvY/Geyd6Jev6asf8WSS1+JNegqVH3big==
X-Received: by 2002:ac8:5197:: with SMTP id c23mr7028054qtn.212.1579270066039;
        Fri, 17 Jan 2020 06:07:46 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d143sm11853938qke.123.2020.01.17.06.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:07:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: fix force usage in inc_block_group_ro
Date:   Fri, 17 Jan 2020 09:07:38 -0500
Message-Id: <20200117140739.42560-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117140739.42560-1-josef@toxicpanda.com>
References: <20200117140739.42560-1-josef@toxicpanda.com>
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
 fs/btrfs/block-group.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 8877af541ed0..71770d04b7a3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1213,7 +1213,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	 * Here we make sure if we mark this bg RO, we still have enough
 	 * free space as buffer.
 	 */
-	if (sinfo_used + num_bytes <= sinfo->total_bytes) {
+	if (force || (sinfo_used + num_bytes <= sinfo->total_bytes)) {
 		sinfo->bytes_readonly += num_bytes;
 		cache->ro++;
 		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
@@ -2225,7 +2225,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		}
 	}
 
-	ret = inc_block_group_ro(cache, !do_chunk_alloc);
+	ret = inc_block_group_ro(cache, 0);
 	if (!do_chunk_alloc)
 		goto unlock_out;
 	if (!ret)
-- 
2.24.1

