Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627FB449C68
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbhKHT3j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbhKHT3i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:38 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D224AC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:26:53 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id gu12so5206848qvb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5xUuI659t30AD1pZp9xW4jARRSRvXgqIMVzU6dSKBo=;
        b=hpfGv7DBQNQW52raeQWCGwlre6pcn0keYJlC5ukxbGrzrIEBHO30u9d4uNQ3u9EW4R
         HtYTr65gbeGnsDU6ifu37gVEpzszFD5v2aw+9irFkLEMKQMalbFeV3l93ldoW0M4icII
         6ginnIw1P+12y3hB4mhfnetAS7IvK+G6a54SyWvqQkDgH6aRAnu+a9tiaM47hCQsB4Nl
         LrJwDNxbJQZgnFwwLokerlR5W4UFp1Zy6gxgiXEakkrzullvgK9ZUEE7pZYV7fhJclWA
         4BgeSLVpvhavm7VQW1fsnF7prTbncy9lM5GAAzc6EB63J7OlHwAfH/XMY0mA+lSV/wSb
         210A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5xUuI659t30AD1pZp9xW4jARRSRvXgqIMVzU6dSKBo=;
        b=a5gexiQU2AUg7bJzWo20P3gyToiDp14UpbvUBVzYszYyQP+9KeCIgFI0MKxgcPACBA
         BxDCJnxVjhgkjSI2DYmrhPtODutneFv9JM0Zwssammwe63L6gyYKDUYDeuq/gKrARpk3
         SiH9HFZ2rAweqV9xXz/LjJREK2wt+h4j7snhuFUXJZC5BTD07/1UFZQxK2CYbvZ6iU5U
         2uqOwBRJG4hhx7IStc7RPEc8TM/xWtGKdTlYyyuHlAezla5pzyVAVnF/H4pmPnK+owEK
         RDnjy00zv9ujNSQ5sVETTGiFY5kfkdkYCqtNwaBNmnUuZGlpq54XVNlm1O7eEWKT95CV
         hEZg==
X-Gm-Message-State: AOAM533ORosP/zPARv548EeCoqAjxz8xrQR+uxtH8EisPB52+S2SBf7d
        +3N5MuRFq99hUlysCV/BGFLaWz/1N3VOhg==
X-Google-Smtp-Source: ABdhPJy8GJQTxRjm4f8clzXeVdTY4BrM1KXg25zZdPhjknh7X+Otrh+i01Vv0prOHOwJBLlArmgLyQ==
X-Received: by 2002:a05:6214:2307:: with SMTP id gc7mr1527622qvb.34.1636399612654;
        Mon, 08 Nov 2021 11:26:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w9sm10591108qkp.12.2021.11.08.11.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:26:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 02/20] btrfs-progs: check: don't walk down non fs-trees for qgroup check
Date:   Mon,  8 Nov 2021 14:26:30 -0500
Message-Id: <323068a93a30f1c87bb9ead806087e86bc8a6824.1636399481.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will lookup implied refs for every root id for every block that we
find when verifying qgroups, but we don't need to worry about non
fstrees, so skip them here.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/qgroup-verify.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 14645c85..a514fee1 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -765,6 +765,10 @@ static int add_refs_for_implied(struct btrfs_fs_info *info, u64 bytenr,
 	struct btrfs_root *root;
 	struct btrfs_key key;
 
+	/* If this is a global tree skip it. */
+	if (!is_fstree(root_id))
+		return 0;
+
 	/* Tree reloc tree doesn't contribute qgroup, skip it */
 	if (root_id == BTRFS_TREE_RELOC_OBJECTID)
 		return 0;
-- 
2.26.3

