Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB9B1812C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 09:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgCKIR2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 04:17:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35360 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbgCKIR2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 04:17:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id u68so879030pfb.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 01:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lAWYgi3WBUAGspLIIBW0G9rAvZdYdEaHNqj4FetbUPI=;
        b=sG+z5/+emHBNv394lDQnafAeLlUJJ4Qz2vULEO4wxo19ChDxNW1SZCJDU7q2k9yyhQ
         sQUvGjgX5y32/gFJHAGHLYLE+KAqqcO1nJ9SXof6ID4r63h94BAahKT9ViM9614oE+OH
         7sh9TIEwC1NbW4NUFMMnBhLbhLL3R92lWM2gqnXdYjUfIzQWhJGx2Zos36LBMLmby84F
         b2wUjrEkIa5DAI5qzqUeGOrK2yAl1IHsv8/LrR32fwI2PflOIwqfbOOHZZ/zp6VxyslV
         ZyNDTHWtUJnwkoN+Dn67maIUZYP2U1FbLVeXr31GK4xEcpePSS5WsFohZB3S5uBsPzTN
         gnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lAWYgi3WBUAGspLIIBW0G9rAvZdYdEaHNqj4FetbUPI=;
        b=ugP1Rv1dwo7sDEJPWxiYBixSxDoAYVnuyPPJAnbANPZzgWnmoNKVXIHZ7qDGFyUsdB
         o2y3+F7sXzkBEDNbZ3vCVBY/ZTBnAZtSW1wb4OQcAN37AY330GJfEaBZ56mzxOcZOdbR
         aYXjb/XyK121z2hfUZbvYtckEfw2ZBeD2NVNOsiRzxvtHfHSfU8A8X+AUcn1JUqONV2h
         s3nkrvUJq39tfMfyYQl360L5TYySj1BPNbmU1r0hHU5c/nbt+QZpO4FLtKfDylRju1Cd
         y4GxEGwxkTqBCm5rmXWSDtqP2MzG71ftZz4YUu1R1YnKIn152+idiQ+hat+OVha18rNQ
         Upnw==
X-Gm-Message-State: ANhLgQ2cRf96TG/9L1j23JH/8V20Vkss/CyhXMn5xvbgwNyAXwQkJ30Y
        ytS9XUiuKGRAFI8swNIibjOaQSpe+mc=
X-Google-Smtp-Source: ADFU+vtbxl5vMAO8Vx75tmIWGNXdg3S4oi9JmlPw5FzliHZgritxVpQkoOu87+p+CjvsZkFRClkpZA==
X-Received: by 2002:aa7:824a:: with SMTP id e10mr1753567pfn.54.1583914644951;
        Wed, 11 Mar 2020 01:17:24 -0700 (PDT)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8b80:8e0::14a2])
        by smtp.gmail.com with ESMTPSA id j8sm4692039pjb.4.2020.03.11.01.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:17:24 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Filipe Manana <fdmanana@gmail.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH RESEND v2 2/3] btrfs-progs: receive: don't lookup clone root for received subvolume
Date:   Wed, 11 Mar 2020 01:17:10 -0700
Message-Id: <f75a865c1ea46fb031713dbaaa3390093f755262.1583914311.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583914311.git.osandov@fb.com>
References: <cover.1583914311.git.osandov@fb.com>
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
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 cmds/receive.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index a4bf8787..74b73f48 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -745,15 +745,14 @@ static int process_clone(const char *path, u64 offset, u64 len,
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
@@ -761,7 +760,6 @@ static int process_clone(const char *path, u64 offset, u64 len,
 			error("clone: did not find source subvol");
 			goto out;
 		}
-	} else {
 		/* strip the subvolume that we are receiving to from the start of subvol_path */
 		if (rctx->full_root_path) {
 			size_t root_len = strlen(rctx->full_root_path);
-- 
2.25.1

