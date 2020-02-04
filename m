Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A3E151E31
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgBDQUa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:30 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45133 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgBDQU3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:29 -0500
Received: by mail-qv1-f66.google.com with SMTP id l14so8781769qvu.12
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q26IXUUvT6RphWnFX6XbHmtTfgZSiMdubDnixlxgxj4=;
        b=sG2VFsTXNrLKAcWm7Dd24e6kVy4KJqUAmE56oGfz9Rdbc4MxlQ0e0FLaipXeqOYHng
         40JJjTb7Gz1I+1bE0Drg9volWjISDNH51pdAJZAOhDGj68t/yv2fPRHhmwlv64cAefjz
         a+SXgTEJ0t+j3rWW0eS+SJqvKkTJxNEcPkh8QzDqtdYbrGDDG2cH6TDW+VKImxW1JQF4
         7Mm7X4kJ80mV3dx8sIR1Rx+KSP83k0PxQb3D0rYEI5MZ3GKhj+NigHlZs0XqG2tMrh1+
         +2MTCtGXu9CsTwUeoiusAPCSP5/jPJpzoMQTVXEU72saqZhbBCtJEWxWSNVN2AB42/XA
         soig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q26IXUUvT6RphWnFX6XbHmtTfgZSiMdubDnixlxgxj4=;
        b=Rizg1SqK/v8nON6ymYkf10L8Bjtf6d8uhyrOdcroKn+U2qWerEsLRyyWMP/4UmO0yT
         EdHACOSS53mzdd20Ry6410tf3f8UlBULyaebqaR2p26XprmCoam1DxRhaBgKiisprhZE
         a8Xz1pRXIv8v3cD928bOhZY8wWxYy2RiytG84yLoAH4dWS3Fxv4NYiiGwothOaOEHrUT
         ooqW1WKIvReAlevnEnbAmiHoBA9XCsXkCWRRvk69e/j4VvgBY503xr32JeOPEArC13B7
         s3t7ele36Y22sxJQC3ULJBwwJdsuBptFv9P1ZL6ILTK1X5GKr5p1ollCrKAEYx/jE+AU
         3+5Q==
X-Gm-Message-State: APjAAAXZLzj8+NVp4GiJbn8BDlpPitPyGzUl+vALyXhfuXvQoKMo2EH6
        zq3CbEmGl7Ykxvb0NZM8zkp5bkS84aP6QQ==
X-Google-Smtp-Source: APXvYqzvO+A4ryqwBYOqJZlWx0NICMypeFlGLeAyH2A0j0WsKVPInIW3+r0eEhUn6RgYxHidkRYf4Q==
X-Received: by 2002:ad4:46af:: with SMTP id br15mr28454928qvb.216.1580833228671;
        Tue, 04 Feb 2020 08:20:28 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v10sm11755295qtq.58.2020.02.04.08.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 21/23] btrfs: flush delayed refs when trying to reserve data space
Date:   Tue,  4 Feb 2020 11:19:49 -0500
Message-Id: <20200204161951.764935-22-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can end up with free'd extents in the delayed refs, and thus
may_commit_transaction() may not think we have enough pinned space to
commit the transaction and we'll ENOSPC early.  Handle this by running
the delayed refs in order to make sure pinned is uptodate before we try
to commit the transaction.

Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d9085322bacd..8d5d57d4aba3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -805,6 +805,7 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
 	RUN_DELAYED_IPUTS,
+	FLUSH_DELAYED_REFS,
 	COMMIT_TRANS,
 };
 
-- 
2.24.1

