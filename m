Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5154114162
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 14:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfLENUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 08:20:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46493 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbfLENUK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 08:20:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so3485884wrl.13
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 05:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJYL0L43GwvtAnJidqIWN/JjxWUixYHQvCd4q9ayaWI=;
        b=ujSPioT3Fx5he4hRGgtl37e3soaecxuXjwCQHR0+XuS/1LjvteEhh+1rMFqdUDA1/F
         UfVTg6vCmHhwEa10ylaTu3xZTbjkAS9VUz9aevX0mWH5eEZWugsYm9G0AbREycGANnvG
         x/4Q39qCcd8+6C3nk95u7LKxma8azmmN7ggoMMqMxACbYmw51LUlxqlfunjq+8az9Pmo
         ExpwZIVsEA7sCaxZ+DW65N61bZHqGRlKbN2qf02KIecD1/YMzyQBirqGSRjyAFpOlBJj
         vsGhofW/scReRAXfm7g4qs+wmWcVKsaivAHDtH/AlMpl/HEoSIn/VFW/lA23FhwJEpr3
         686w==
X-Gm-Message-State: APjAAAXRltv1XPHenTyb+BdQnNRbg7RjVTh9Wqaq/u4PdraG7poNvaj0
        LdFuQhSxwJV6JidkGuPt9mU=
X-Google-Smtp-Source: APXvYqzTY4+bBXo3DDaZR/u0azkGC0/EGbRyV94+2XP+B0OwagZtZaWienwCvaDwyxxKseiiutmYUw==
X-Received: by 2002:adf:8541:: with SMTP id 59mr3990453wrh.307.1575552007847;
        Thu, 05 Dec 2019 05:20:07 -0800 (PST)
Received: from localhost.localdomain (ppp-46-244-194-187.dynamic.mnet-online.de. [46.244.194.187])
        by smtp.gmail.com with ESMTPSA id f67sm10482515wme.16.2019.12.05.05.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 05:20:07 -0800 (PST)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 2/3] btrfs: remove superfluous BUG_ON() in integrity checks
Date:   Thu,  5 Dec 2019 14:19:58 +0100
Message-Id: <20191205131959.19184-3-jth@kernel.org>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20191205131959.19184-1-jth@kernel.org>
References: <20191205131959.19184-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfsic_process_superblock() BUG_ON()s if 'state' is NULL. But this can
never happen as the only caller from btrfsic_process_superblock() is btrfsic_mount()
which allocates 'state' some lines above calling
btrfsic_process_superblock() and checks for the allocation to succeed.

Let's just remove the impossible to hit BUG_ON().

Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 fs/btrfs/check-integrity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 72c70f59fc60..a0ce69f2d27c 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -636,7 +636,6 @@ static int btrfsic_process_superblock(struct btrfsic_state *state,
 	int ret = 0;
 	int pass;
 
-	BUG_ON(NULL == state);
 	selected_super = kzalloc(sizeof(*selected_super), GFP_NOFS);
 	if (NULL == selected_super) {
 		pr_info("btrfsic: error, kmalloc failed!\n");
-- 
2.21.0 (Apple Git-122)

