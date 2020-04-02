Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5611819CA95
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 21:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgDBTvV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 15:51:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46575 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBTvV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 15:51:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id g7so4438840qtj.13
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Apr 2020 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2pim1DnH3jE4V1aszF/BfJ3lpHHY5l2vaJugOmmzpcg=;
        b=s1QWTLVNg54/H4ICWSSV5/8kxDBHl2Rh5GQmr4HoN9SwWiTtAIl9Qai3DKYI9nAA2Q
         IJfxY9IFX/TnkFRNi1NuJuYWaRoBW8Ru4ZEbuip6mHaDFlo07ChVIY6aCRT/BykzAyQJ
         caZLZ3Bc/2pF3C+sHE5ASZOD6GfOUqVvRdoP6H9uW9xH0pP6FzlLKOSHmi9KEreOZX6m
         PFzEIS2faN2ZCVs45Z+drGUc0N9l1iCBlxEuinqI5fgMLq9DMMS0kUD5HSaXv4OppPTw
         iwMULRRjWRpwdMfSy0DDm52WbxtG9XbS2IZO1FQFt/iPgymu8V7SOdMlhio6Im7+y1oR
         PvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2pim1DnH3jE4V1aszF/BfJ3lpHHY5l2vaJugOmmzpcg=;
        b=l9+QRm3xIoTkbylZbjZ1y8e5fDwfqXB3PNpPXboBUDhM3WoMTDokojSZyvCmoeoPT0
         2q/R58iRaL4Makx6Lx1dfvD+QLrHUCv0ob4t2rEFwmTBYsIFLEG00s1Upf2ivuSCTdsD
         u/g35QTFg8TIwG4VjxQ+FIJ/7iIsM5+fN7U5x7II2cAOQ3PtONk0OlWVcfoFr/gyVLh4
         huOl7uusu/F7PKL6O0lkkA6xl946wjjC+YL1Z3VERXZeC7/EkGHwhwxs9PrSaNbWz+7C
         j5KoQVlHFW8aEyZTfEvjnugYcn8Jf1PHIIRzIxdstASit8nn4qfmq8Eu4mc/wS6/xs08
         IBCA==
X-Gm-Message-State: AGi0PubmBxLX10MpW3+6ZHIW2Y1vuBvWIzf5jgfY+B83lK/I/PWmS+ug
        krS2GHO9DhTGzgoylM3dgbfZNIC90/8VkQ==
X-Google-Smtp-Source: APiQypLwmbI763PKlgzpYyPyFmzE3BGhMJMKoT+PCHFJjkNRyHHrPfLDeJL+JgbjvBdY+PkZ6a2wgw==
X-Received: by 2002:ac8:6b08:: with SMTP id w8mr4646701qts.326.1585857080003;
        Thu, 02 Apr 2020 12:51:20 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k124sm4215395qke.108.2020.04.02.12.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 12:51:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: check commit root generation in should_ignore_root
Date:   Thu,  2 Apr 2020 15:51:18 -0400
Message-Id: <20200402195118.4406-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously we would set the reloc root's last snapshot to transid - 1.
However there was a problem with doing this, and we changed it to
setting the last snapshot to the generation of the commit node of the fs
root.

This however broke should_ignore_root().  The assumption is that if we
are in a generation newer than when the reloc root was created, then we
would find the reloc root through normal backref lookups, and thus can
ignore any fs roots we find with an old enough reloc root.

Now that the last snapshot could be considerably further in the past
than before, we'd end up incorrectly ignoring an fs root.  Thus we'd
find no nodes for the bytenr we were searching for, and we'd fail to
relocate anything.  We'd loop through the relocate code again and see
that there were still used space in that block group, attempt to
relocate those bytenr's again, fail in the same way, and just loop like
this forever.  This is tricky in that we have to not modify the fs root
at all during this time, so we need to have a block group that has data
in this fs root that is not shared by any other root, which is why this
has been difficult to reproduce.

Fixes: 054570a1dc94 ("Btrfs: fix relocation incorrectly dropping data references")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 89a218cb81ef..7cb8d4123169 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -616,8 +616,8 @@ static int should_ignore_root(struct btrfs_root *root)
 	if (!reloc_root)
 		return 0;
 
-	if (btrfs_root_last_snapshot(&reloc_root->root_item) ==
-	    root->fs_info->running_transaction->transid - 1)
+	if (btrfs_header_generation(reloc_root->commit_root) ==
+	    root->fs_info->running_transaction->transid)
 		return 0;
 	/*
 	 * if there is reloc tree and it was created in previous
-- 
2.24.1

