Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D3E446A22
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhKEUwc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbhKEUwa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:52:30 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02BFC061208
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:49:50 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id p17so8794481qkj.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B+fklvJh38lLYQAWrJelXcd8JuXYkN4BYDlN3ZlZt5I=;
        b=pO726ZK/5n4uCXjoqjWSLPyd20MijtfqwN0FtBAmR1GowTy56Gn+/7TTkqP58MCA8K
         dFBLuIPAN2rqMRRNxhWH8lttiGKKEnOP7l8PzaDA/iFbk3E+DvdFLoU7RtJhktumJAAH
         9SAbwt8ipA4oF73eiGJlcoNJSsdFWcj6pyDGsyAEVfyXDfVOwV+ftPJLn5TY6kxzEUDB
         JiTNfwbrtnkynGVnTDogt8bK0+V6ZIdT7HU54QJJMO+OXoTktBT45PWF+evuGyhNmmcY
         bPMhtPmGzLU8v1CqT0o8DAgIj13nb5ORxqISQ+Jxlc3kND63uJ15bYKzZsCuyljA8ZDD
         ra9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+fklvJh38lLYQAWrJelXcd8JuXYkN4BYDlN3ZlZt5I=;
        b=v3LahKVIEtiW7KpEl93GRwybyxKx2NM+D9QjJUa7NB9ucRY6zhXBPWeAM+uJkHcvx0
         3hXEaxyk1yVvkXm5qkkpZIsCEMCcr4V8StxObbwKW2VfA6dXHukO0YyQCz0g83gi8wuY
         FUF2ooOwZ55Dv6gPm+pLf02LTKZG/gij6QSrANPP9lsEbA8Ar9E1hnpNR306dHhekqQS
         ORflkBsOQtDxvsawlauJTZdeg7ZrsXX5HZgH4Blo1bJaJaIGKNlfsaInqrWyTYPjl7Cu
         XixC4dLyRL1vra7fLKtxMAcFiaBPG+NrubenLucqjzZPAE6Q/6X3kgyWiBea5+Wtof3a
         n3FA==
X-Gm-Message-State: AOAM531w05BTL7AGlz13/280NDY3ZoLo3Uyd3tG2yql9MORNejYlos34
        kqQZgn7YgVFMYJROskvpTKVSMbBI4vlUXA==
X-Google-Smtp-Source: ABdhPJwDw00urRD9pFB1yqV+gRc32xZdDRGjZWObyRQAgboPutRgGpI+SwHbu2oTdZblm9sh6UShUw==
X-Received: by 2002:a37:9bd4:: with SMTP id d203mr15161741qke.495.1636145389892;
        Fri, 05 Nov 2021 13:49:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bp38sm2839549qkb.24.2021.11.05.13.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:49:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/8] btrfs: disable balance for extent tree v2 for now
Date:   Fri,  5 Nov 2021 16:49:39 -0400
Message-Id: <737786b1a14e94483a7484fc3b174a2162af0373.1636145221.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636145221.git.josef@toxicpanda.com>
References: <cover.1636145221.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With global root id's it makes it problematic to do backref lookups for
balance.  This isn't hard to deal with, but future changes are going to
make it impossible to lookup backrefs on any cowonly roots, so go ahead
and disable balance for now on extent tree v2 until we can add balance
support back in future patches.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 85842eb1f7b1..5e62b97cb265 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3216,6 +3216,12 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	u64 length;
 	int ret;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		btrfs_err(fs_info,
+			  "relocate: not supported on extent tree v2 yet.");
+		return -EINVAL;
+	}
+
 	/*
 	 * Prevent races with automatic removal of unused block groups.
 	 * After we relocate and before we remove the chunk with offset
-- 
2.26.3

