Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5692CC73B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389864AbgLBTxl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389862AbgLBTxk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:40 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B788C061A4A
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:46 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y18so2454673qki.11
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SCXwhYzFuPwr3RgnPUSmchJkHEK96nIte7RNTMMphEw=;
        b=LJ8onik8hQvgr+Mm/qxackeQazeVuy82irE9cr48aECCCR5VIVLH+VZaMJ4V0VtYvV
         waMIJdoQ6NYKoFe8GseqGGjaC6yHLJCShcIAttPKDFYAWbGUcAzx5oHR4Gjcs2zemu8N
         uRxfv3oOLln3T3uXOa1WkSOrTdJEv+LEC4H8grVAYopgUzib4qq1EY1Q7NCtJ0mj0gj8
         1j8Nw+CoEuD+ZjHv43W5ViSQJpcppWvi/QkSSED/KiB59qULDC/4PhTls5lF7d70LQKD
         +b3r1GxoDwNZCv8z9NX/LybeXDQomVnr3S3FUqlux+ivxk0uOMGQYNiciLUdwip6Udsc
         kyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCXwhYzFuPwr3RgnPUSmchJkHEK96nIte7RNTMMphEw=;
        b=WAYefkFFVoGkIPxlvGaDveXgcB+ISXzVlelktpkM0cea1m7mPZc83lJ666LtIneMpj
         hcfzrRgB6wRzEAUmNWUTnIvgQ71gg/7NUHiCLZTgKW/XWVAqO/4Gqd4FKqU0GowzPQEQ
         gvlPoFLIN4FV13mS036XUEt6X5XHI9LDEq4h3sfobyNCuFUK4j0TfVRKq5BAP1uP+5UB
         EI1vsJ7j/TzgHe+x0VZ1Ag0XEeXRKEsQ4i/DKz+4MsCJHqMrOEyb52xvysHUM/+5LaoO
         Gl4SyOGMJCZ0manc0L95XPRlxT4+nB86ThWLwFOktJTtkqUCg/evD5hQkkVqK7WdG59t
         ixpA==
X-Gm-Message-State: AOAM532ILNDrk81wfzlFs4Ba4EAeHxHEFS6RMrxVmp4fnbCDDFacHEBi
        +mfFU/IYDvv7OTdTMgOeSjFKkgUvkftgNQ==
X-Google-Smtp-Source: ABdhPJxVAAUVmp60FlhGAkHSQaeU4+2iXXssZzX1RvaYwpuAU6vUtauSu+3aSSelFCjclZHd/BcdRQ==
X-Received: by 2002:a37:9d04:: with SMTP id g4mr4222516qke.358.1606938765087;
        Wed, 02 Dec 2020 11:52:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n21sm3004395qke.21.2020.12.02.11.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 50/54] btrfs: check return value of btrfs_commit_transaction in relocation
Date:   Wed,  2 Dec 2020 14:51:08 -0500
Message-Id: <dd0d601ca7d0b24c316159e2c631f623863daafd.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a few places where we don't check the return value of
btrfs_commit_transaction in relocation.c.  Thankfully all these places
have straightforward error handling, so simply change all of the sites
at once.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 099a64b47020..15b6e54394b7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1905,7 +1905,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -3436,8 +3436,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+	return btrfs_commit_transaction(trans);
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -3596,7 +3595,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+	if (ret && !err)
+		err = ret;
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
-- 
2.26.2

