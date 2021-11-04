Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F350B445532
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 15:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhKDOWz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhKDOWf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 10:22:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33673C061230
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Nov 2021 07:16:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o14so7440286plg.5
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Nov 2021 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6o8YD5en5fFTJkKKvRwp/gnfd76mDFz0ZTc6iYyo/w=;
        b=OzNb6bD/xaHfosFmiEVQCP+jE60/IwZAC4xUMZ4w4+F2YgYZqPZPW0lalihDYQl0uk
         SwGHv0x/E/EPZpDBvjzC1tOukTw07fqCOmpsIvR9RT4lmtfzEwv6sj6GLUjPUvs74neN
         RwMsulC+Nn5eQDuOaIXSAMh2DKlXlqekpEmJQ0CXanCekll5tGLvlvurNRn0OO71YdXX
         wsngAlAeHdPRV0n2dkc2DMOcHddGYX+g+OFI5Pj2YI+iBTDeAvymqgaGyArJu1cX6n9u
         1M4A4FBCQ4BY0CUHQuLT8XKFWcz0N3ylH/aq88td1OvpBV0sVmD6R/HSU2hPUOm1r79R
         WQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6o8YD5en5fFTJkKKvRwp/gnfd76mDFz0ZTc6iYyo/w=;
        b=QwItiqwZDIcqlu89TqSNKPZs1xOy/v/924WAb6I7gQD/Lw1EOWCBzL/EGCuNe4Krb5
         5kcP+QXbh7IUuzR/1C27kErtXP8q6caz5SOUEmPBGUiYqJk6o/XBo4TAwX9R58B8oVCj
         gBzCBp6mMrs1v5ErJKsd30U5KvgEDrEt3bcmQR6lnPDKf/nfNRk8lZn4HJDdsX3LElGF
         QxEzNEshXexg1ITJVwxnEQu9H+hYjzevg4uyeGL12wS/peeYcTqSpRLFGvI5iEa8b0Sw
         T5HUOfmRy+76zDIRKre7FAZysCR2W+k2YF5+KQ8eC7sRk3kbFqwkdxpNFKTrSflLcZD7
         6XoA==
X-Gm-Message-State: AOAM532FWeX8YyXLCjVMwdCuA0LYDVcTndfKecP9rhKwrmP4MY//iyag
        2z4LYK2YVU1oysUYXi8NrV0DhWHW45u2kw==
X-Google-Smtp-Source: ABdhPJz+f85ZUsOocR7PnRcFD/0ItB0GN6Dc0zPdTHgB+8ZdOczLzBLkUgXmuxwFF936DHoQ9ipHlA==
X-Received: by 2002:a17:90b:2502:: with SMTP id ns2mr22374972pjb.51.1636035378620;
        Thu, 04 Nov 2021 07:16:18 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id d18sm5291457pfv.161.2021.11.04.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 07:16:18 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs-progs: check: change commit condition in fixup_extent_refs()
Date:   Thu,  4 Nov 2021 14:16:10 +0000
Message-Id: <20211104141610.48818-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch fixes potential bugs in fixup_extent_refs(). If
btrfs_start_transaction() fails in some way and returns error ptr, It
goes to out logic. But old code checkes whether it is null and it calls
commit. This patch solves the problem with make that it calls only if
ret is no error.

Issue: #409

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2:
 - Checks ret as well as trans
---
 check/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 235a9bab..ddcc5c44 100644
--- a/check/main.c
+++ b/check/main.c
@@ -7735,7 +7735,7 @@ static int fixup_extent_refs(struct cache_tree *extent_cache,
 			goto out;
 	}
 out:
-	if (trans) {
+	if (!ret && !IS_ERR(trans)) {
 		int err = btrfs_commit_transaction(trans, gfs_info->extent_root);
 
 		if (!ret)
-- 
2.25.1

