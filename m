Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400BD6EDDC
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2019 07:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfGTFkO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Jul 2019 01:40:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44049 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfGTFkN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Jul 2019 01:40:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so15346472pgl.11
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2019 22:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LQQ0cXom3U6A8cVVzlOULbBfO8fEGtMqapA3eGhu7MI=;
        b=s9wil83ihnhD44OkQBTS2KazGoj11U35oCuJ8O/uOfQcDyx6+pyMAuCJh/QuDiUYjB
         fd/QxPf+iIygPw220s2JlerKmJbNrEzd2YnFdSsP11iZlkORFqqlumd0YezWiuL1szJE
         7BlySEBfcrqBCJPVk37Kl0HRDXFnTYUpQJKdV9asfnfyVguRvLXuWHV/viTnruhbozZn
         wsC5QhEJ2F8BtRnO3+5DfPJ/MMWIdGPs52v1Gb3TS3TH/rs1farmgCpHxVSawxdy8H6q
         0G7kEaSpDWJcYE+7RJXU8ZTHDdjJaNdz3DlLMNG6Ilsvk6Ou0Fc060iLr8117jCsmAwu
         W47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQQ0cXom3U6A8cVVzlOULbBfO8fEGtMqapA3eGhu7MI=;
        b=bOmw91CXkiNNfM1ewWbrgbYM5oyQ/NqkZMa0Ve54nFAHN7ax6oM9em0fO8UQE3r93Z
         R1qMrTqpCSpe0GObwk1bjz3yapUIJP1xPIkOeI80QIuPS9nNdUHXWx+t8Dbw/+T5csON
         vl3MkVcYupr47n7it5KWg8bkPWA+4K4rtDANNoltbjFwROva2jJG+/FDWgWZA7EUM2i8
         +jDFn3tsyN02O7Lt435s9d8/rz5MhaVkDG7OJWhgBLriQe2tV6KrVrqsTaqzwRyI6dO7
         e1YoLxyMBD1OY1/whIs3VFmSQGoq+Zs4o+Eco+ITms1iIfrp+aj+WOd10InZsI2s/aXM
         7FNg==
X-Gm-Message-State: APjAAAUk5BWKF4/oEmKAgLc7WtQv04YMtiwktWK9mz9uRTn984g1qj/w
        tQMlmCxYhVpwuyDyuW4fa6MsUVtMlP8=
X-Google-Smtp-Source: APXvYqwH/5j/42hKlPqgyzaTI2ihUOMejSP/Ek+HjPpxP7NZJZAl0599a9UPXkcUdExxDr5MzO8qUg==
X-Received: by 2002:a63:6ecf:: with SMTP id j198mr57804208pgc.437.1563601212853;
        Fri, 19 Jul 2019 22:40:12 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1:ba1e])
        by smtp.gmail.com with ESMTPSA id w3sm28453762pgl.31.2019.07.19.22.40.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 22:40:12 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 2/2] btrfs-progs: receive: don't lookup clone root for received subvolume
Date:   Fri, 19 Jul 2019 22:40:01 -0700
Message-Id: <6af59460e12a8120bf643a923f5fa6bd3b135b20.1563600688.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563600688.git.osandov@fb.com>
References: <cover.1563600688.git.osandov@fb.com>
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

btrfs subvol create subvol
dd if=/dev/urandom of=subvol/foo bs=1M count=1
cp --reflink subvol/foo subvol/bar
mkdir subvol/dir
mv subvol/foo subvol/dir/
btrfs property set subvol ro true
btrfs send -f stream subvol
mkdir first second
btrfs receive -f stream first
btrfs receive -f stream second

The second receive results in this error:

ERROR: cannot open first/subvol/o259-7-0/foo: No such file or directory

Fix it by always cloning from the current subvolume if its UUID matches.
This has the nice side effect of avoiding unnecessary UUID tree lookups
in that case. Also, while we're here, get rid of some code that has been
commented out since it was added.

Fixes: f1c24cd80dfd ("Btrfs-progs: add btrfs send/receive commands")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 cmds/receive.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index a3e62985..ed089af2 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -753,15 +753,14 @@ static int process_clone(const char *path, u64 offset, u64 len,
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
@@ -769,23 +768,6 @@ static int process_clone(const char *path, u64 offset, u64 len,
 			error("clone: did not find source subvol");
 			goto out;
 		}
-	} else {
-		/*if (rs_args.ctransid > rs_args.rtransid) {
-			if (!r->force) {
-				ret = -EINVAL;
-				fprintf(stderr, "ERROR: subvolume %s was "
-						"modified after it was "
-						"received.\n",
-						r->subvol_parent_name);
-				goto out;
-			} else {
-				fprintf(stderr, "WARNING: subvolume %s was "
-						"modified after it was "
-						"received.\n",
-						r->subvol_parent_name);
-			}
-		}*/
-
 		/* strip the subvolume that we are receiving to from the start of subvol_path */
 		if (rctx->full_root_path) {
 			size_t root_len = strlen(rctx->full_root_path);
-- 
2.22.0

