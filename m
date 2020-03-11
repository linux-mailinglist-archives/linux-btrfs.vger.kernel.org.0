Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5B181C34
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgCKPVt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 11:21:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39767 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgCKPVt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 11:21:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id f17so540645qtq.6
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Otgb+VpDSgsXpZXFDW/TtT2BrHIFp431W3WYtOOqpQk=;
        b=aTQYzHzW1M5d6QlD+AxokbGi8GpvE9NNa8oqYs/ywoaetY82kAmDQE7vvQT/9x4O/X
         mbMne6ASeAtXgWyRyXULYdIFPiygVtJx9fz8Yk/bvHQIA0Lzy2fvU/8pDXnKB6wQZz28
         1IfIqItjJiXRXukgjAcMBYB8hZLZ9qiR2Eh8FFibpJ/ZNmSTAsSoFU91iDFfiLcygsL5
         fd64ekV2Po+pXFv4scPVDGX+X8bqIAtilib6Ejv1U5NX1nCB+d4607OjJI+czxq54OwC
         gZsl4XoEvDETKYTYi3mwicLnYeLFH95ydB55Ryy5P/Dpm/uw28DFfqg8UR7jgmcgHRMv
         zWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Otgb+VpDSgsXpZXFDW/TtT2BrHIFp431W3WYtOOqpQk=;
        b=Hi5NjAgS74ydrycmtZJpAGTn89e96XbIjmZ+g3fFcGfZMwT+0d/3EYdubLEcEe30xi
         rOYfHce2Jgj3aPKPM2qhUBQKAmvot6seFGJ1zTaBg6uvXFKJS5TBPDHcF6IMh2diFY9K
         Vb4/1pQ7C3jFNTUuIiNXjG7Bt8oQHNpEH4aFZoevNTs5umC8aePVnPXhEGwORjv7iy9y
         OFESnlXDmQtNEvBbemSErGlZLcd8chSqoae4sHLwqhwoYaawaM0xUcBGnPU6oKaE1HZD
         XE5HT6JF9muet63r9dYGkC1fW4TqtabFLbUhqme4joYDFTEN1EXICxISJMetpNICvouj
         UszQ==
X-Gm-Message-State: ANhLgQ0WrWetovEl7LHHffvwGnmDiY+sBai0uxN4ZQQg9xDaQP1kZy+j
        +j4Y6by+22CU6kvLtSYHmmffBtzywXg=
X-Google-Smtp-Source: ADFU+vvpECreOw40Vdh1kl60X13RefKOAsrla2tUxrvp65eeXso3PTSfxrzr69QWUMvuJOFIscQUZg==
X-Received: by 2002:ac8:5448:: with SMTP id d8mr3041742qtq.205.1583940106599;
        Wed, 11 Mar 2020 08:21:46 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k14sm1083119qkh.63.2020.03.11.08.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 08:21:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix ref-verify to catch operations on 0 ref extents
Date:   Wed, 11 Mar 2020 11:21:44 -0400
Message-Id: <20200311152144.8765-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was trying to debug something stupid I did and noticed I wasn't
getting ref verify errors before everything blew up.  Turns out it's
because we don't warn when we try to add a normal ref via
btrfs_inc_ref() if the block entry exists but has 0 references.  This is
incorrect, we should never be doing anything other than adding a new
extent once a block entry drops to 0 references.  With this fix it blew
up when I did the stupid thing, and was able to undo my stupid thing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ref-verify.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 454a1015d026..679464e5f06a 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -803,6 +803,14 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			kfree(ref);
 			kfree(ra);
 			goto out_unlock;
+		} else if (be->num_refs == 0) {
+			btrfs_err(fs_info,
+"trying to do action %d for a bytenr that has 0 total references", action);
+			dump_block_entry(fs_info, be);
+			dump_ref_action(fs_info, ra);
+			kfree(ref);
+			kfree(ra);
+			goto out_unlock;
 		}
 
 		if (!parent) {
-- 
2.24.1

