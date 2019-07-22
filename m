Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A457470986
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 21:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbfGVTPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 15:15:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37204 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfGVTPQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 15:15:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so7379417pgd.4
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2019 12:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gkFoKKPEySnLtztcregI901NZ2Uqp4xztASQ8GNuHjM=;
        b=oaiHrGsHqqS6Khd0ENC3dTljOM9C2xMCviJaeX7ZVZI4AyohBNbLUGKl3nCxymJzb1
         a7o2YZ7kC5z/Dtp8n6DKQ1uAZ+gXyHUJYvNJrumFGEvpI6MzsiuUv9E50OUPXmmrcpv9
         KJYEL8QMCybLYHqqXKo3hAdWk522GGLlobkcBGstYI6N1cPIS3LfcHa8or0hqaZci5IE
         3OwOkq7gs5o9tqqPqfXhunScqj35NiyGBCUZAi6NQHyL3UxS4jLc+6SDtLyIzoJsU0B9
         5FRTz1sQ/V6HXS8BBp3Nml/aL0QVxUFva1J8PuDTzaOxv7s4tHbzARpuJ7CTYHN6cgmM
         KB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkFoKKPEySnLtztcregI901NZ2Uqp4xztASQ8GNuHjM=;
        b=c7tMN5IIFpL1mRlCyCzbHEykviDqD+gpzizzDy+MiLk56L69NFeR8Oi+NdO82igzRC
         VrVPRArdeWmyQti/wrPUeWeOeG+nCqZ6mIrnK20UM0ecaJPYiUbc2Tp0UAGJEuuFUeXX
         BJ7IFkJjENaizOrPy0nxOKAzUZk9WeSXX3LPEIjlerJe1m6oJwtFzlfLZCr+O7+f6wFT
         3gDV2lay8dLKCaQwkNeK5kKR5iQfFvWbrdXBLK4Ft1rPgs9Qu+a19yCednKC3r6M8PMA
         8I98BqYvF85/e5pWCIf4UpcUeAf3ZUe5YqYVsDhNeobI7ebZ6sOmt/AMRvjMobbC7eA/
         cN4A==
X-Gm-Message-State: APjAAAXWFZgmOfOQyLW5yaJuKD2EhCwFB2ah2dAWxWEsYMQ8OSp4tBMR
        a/laDFOMCKeuBNHbsdpuSTh6msTVO5Y=
X-Google-Smtp-Source: APXvYqzjgrBXTfjxxQPl+VYTOe6K6gZ2H2HFLx5appE296cgf3yNOeGo6R6L7SX7pnmi7AU6RGg0/A==
X-Received: by 2002:a17:90a:26ea:: with SMTP id m97mr78692661pje.59.1563822915067;
        Mon, 22 Jul 2019 12:15:15 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::2:a31b])
        by smtp.gmail.com with ESMTPSA id t11sm47262048pgb.33.2019.07.22.12.15.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:15:14 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 3/4] btrfs-progs: receive: don't lookup clone root for received subvolume
Date:   Mon, 22 Jul 2019 12:15:04 -0700
Message-Id: <66ec0a6323c64aec74336e99696b6ad6576e091e.1563822638.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563822638.git.osandov@fb.com>
References: <cover.1563822638.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

When we process a clone request, we look up the source subvolume by
UUID, even if the source is the subvolume that we're currently
receiving. Usually, this is fine. However, if for some reason we
previously received the same subvolume, then this will use paths
relative to the previously received subvolume instead of the current
one. This is incorrect, since the send stream may use temporary names
for the clone source. This can be reproduced as follows:

btrfs subvolume create subvol
dd if=/dev/urandom of=subvol/foo bs=1M count=1
cp --reflink subvol/foo subvol/bar
mkdir subvol/dir
mv subvol/foo subvol/dir/
btrfs property set subvol ro true
btrfs send -f send.data subvol
mkdir first second
btrfs receive -f send.data first
btrfs receive -f send.data second

The second receive results in this error:

ERROR: cannot open first/subvol/o259-7-0/foo: No such file or directory

Fix it by always cloning from the current subvolume if its UUID matches.
This has the nice side effect of avoiding unnecessary UUID tree lookups
in that case.

Fixes: f1c24cd80dfd ("Btrfs-progs: add btrfs send/receive commands")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 cmds/receive.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index dba05982..1e6a29dd 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -744,15 +744,14 @@ static int process_clone(const char *path, u64 offset, u64 len,
 	if (ret < 0)
 		goto out;
 
-	si = subvol_uuid_search(&rctx->sus, 0, clone_uuid, clone_ctransid,
-				NULL,
-				subvol_search_by_received_uuid);
-	if (IS_ERR_OR_NULL(si)) {
-		if (memcmp(clone_uuid, rctx->cur_subvol.received_uuid,
-				BTRFS_UUID_SIZE) == 0) {
-			/* TODO check generation of extent */
-			subvol_path = rctx->cur_subvol_path;
-		} else {
+	if (memcmp(clone_uuid, rctx->cur_subvol.received_uuid,
+		   BTRFS_UUID_SIZE) == 0) {
+		subvol_path = rctx->cur_subvol_path;
+	} else {
+		si = subvol_uuid_search(&rctx->sus, 0, clone_uuid, clone_ctransid,
+					NULL,
+					subvol_search_by_received_uuid);
+		if (IS_ERR_OR_NULL(si)) {
 			if (!si)
 				ret = -ENOENT;
 			else
@@ -760,7 +759,6 @@ static int process_clone(const char *path, u64 offset, u64 len,
 			error("clone: did not find source subvol");
 			goto out;
 		}
-	} else {
 		/* strip the subvolume that we are receiving to from the start of subvol_path */
 		if (rctx->full_root_path) {
 			size_t root_len = strlen(rctx->full_root_path);
-- 
2.22.0

