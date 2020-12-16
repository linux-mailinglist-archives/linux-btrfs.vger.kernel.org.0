Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3A82DC425
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgLPQ2T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgLPQ2T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:19 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4129FC061248
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:09 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 22so12826952qkf.9
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q72SsyFPmd92BdpyPLFGmykrVJ0f82G1Rus+LCwtD6s=;
        b=jJxOsCRxgjoaueUI9LC1VAdtHooNzzJDi2oDRzNof0dIwFZ6Qs9nz9YUvfaXoHXHnQ
         zV9khHLU/UW17JjEOuHCEGFFouYeeYUc7DZv1JxqJMLmKtbHWYX5/dVqhMR40u1JJ1UY
         mB6wDRugrMYpqJzf1LEtFs52zS/YONwIy6tZ8vG+D9ZpDsGg8tsqxmbEVwQh7httpKzv
         7dcOO+yzgF2QOKWNcaFUQvB8+V97j3vm7v3uilmVFtlTIvO1jWL7N+eJLAYkjM/+LVox
         CinuXJH5eA0fYhXH/X9PMOjKi3gU53ASoju9MIh5nbXiVnwmw72j7NEAl7SHA2XsS2Xe
         bFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q72SsyFPmd92BdpyPLFGmykrVJ0f82G1Rus+LCwtD6s=;
        b=MmauwYKFBjKL014LVkM3LIkcJAuA4C/KkoA0CLUIzxPyvM7Iduc/LXIqF3977sSPDj
         ZPeXg89YxeFkiqOZEEKm7v/65lExmEuTjXRrak8WPCFHsAOYsbxQ65xtC/Sp1eGT0Eju
         CHOKM9YE5322dYpukkkR1X0r/8KJqcT/L+o/M1ezvlLGWXXFfnF13QteJYFx/z1kqjlx
         nc5/b8aXbufFDH0lFJ7kDTKP2StHMQBZbPS7YXdVMR5orO8EEeLZB9UUFsyqHZcoz7J4
         ofjqKoNjMiHlT5QzMpd4xXzLLvcTxYEdzr++E3V8UZ7cZNoYdJ+rhPNaonCIf4PRteW8
         tByA==
X-Gm-Message-State: AOAM531G4w4yNUbq5RLj8KGpFFg93V69qp9OkSEj0E6WjpG5UCqzxw+7
        FvIz/IBpZ7aGdJqdPD3IrHbFrvPDVYuSldjW
X-Google-Smtp-Source: ABdhPJxlhV36m4PwNJbTMzsXWzw5uVLYFXuMk6Tx8Ud3UGmD+WSReTo431L7cYApKWPU68bWBBE+Ag==
X-Received: by 2002:a37:8d01:: with SMTP id p1mr24526965qkd.31.1608136028178;
        Wed, 16 Dec 2020 08:27:08 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v1sm1381390qki.96.2020.12.16.08.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 07/38] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename_exchange
Date:   Wed, 16 Dec 2020 11:26:23 -0500
Message-Id: <b73f546020b5c76f29e097603585a0e729a94fbc.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename_exchange.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 070716650df8..2f8bb8405ac6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8897,8 +8897,11 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		goto out_notrans;
 	}
 
-	if (dest != root)
-		btrfs_record_root_in_trans(trans, dest);
+	if (dest != root) {
+		ret = btrfs_record_root_in_trans(trans, dest);
+		if (ret)
+			goto out_fail;
+	}
 
 	/*
 	 * We need to find a free sequence number both in the source and
-- 
2.26.2

