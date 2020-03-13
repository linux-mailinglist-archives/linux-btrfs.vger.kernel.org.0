Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDBA1850A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCMVKC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:10:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37886 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCMVKC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:10:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id l20so8860287qtp.4
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nQfdMZ10uDqFwmSxlENBRnhZE69xtmobsZCVJ2fGpCU=;
        b=xM+Qx1QCMsa94DFrJbHDiykz0asl7NkOrWbLUt7RrTvoaou93Of5nQZ3zCLDSxeAu1
         S7OfYM5NZ/CwmgLCxISh5g6UaHZn/IaqRBOAAWUsGeiZrmprfekiVLeDorwSy8vwJCcA
         1iA9+nuMkSidnWCPgTDYbp3Vd3Dsk9kUPKxPTjVQyrOntYGqQ73oTXEzOux+nW2yUTpz
         ybBCkg9MRUmwba/Y9QnOA3djBKqYMZ6uFGw2VZZPh4OK+FwL/tXidhLk+F3HQ2WBjVod
         UUxBHdrfQvLGhiLqFXdxNVG8s18XtKH49sSvF822I9qUu3GU4d7BKRRi9bmA5+d6Hg1d
         Te+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nQfdMZ10uDqFwmSxlENBRnhZE69xtmobsZCVJ2fGpCU=;
        b=mOfVk/7BDb779Yz4a4zRXj1bejMllmPszRUgsAT/IoMxDwvK/1q7fOi4RPNiT0lice
         NkHCXCdla2SBmw4aj0+mAuhvoa4xb4KQ0IYdlhCSpQijOtl69H5btIMCVQyeSE+GhW29
         HxkmvoQUNBRDaUqPxljHQVP5Z/096N45D4mokyj6/7sAlOfBrah27wzSZbTqz+yc+tiq
         MEvd5H8CehfELcXU8m+kJ2iMx/e4qJzdG3Vf7gBOiJ9vltbdqOlqWXwCYuLO8318yz5q
         yHi+LfjUkrOj/OrvFVKIvNWd522MqXymIJCghWBClheN9I6LRCXuONA2holxgOVnc/QP
         6i2g==
X-Gm-Message-State: ANhLgQ1K+jAcZ+8WNnU92EbeVWwrJLmlxVZw+5x4jz2uQcgt6DxNamB5
        19ACyNLJuSLe9cCkv9wGNuUcpRd0qBSoNQ==
X-Google-Smtp-Source: ADFU+vvYQbFZBE1xO3Cncin42JbVHWcBVetXTnl1jyg8nY/du7NYL56MvEHJOtSwvJlTKUB7QLbM1g==
X-Received: by 2002:ac8:735a:: with SMTP id q26mr14575380qtp.286.1584133801311;
        Fri, 13 Mar 2020 14:10:01 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m92sm4200076qtd.94.2020.03.13.14.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:10:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: do not READA in build_backref_tree
Date:   Fri, 13 Mar 2020 17:09:54 -0400
Message-Id: <20200313210954.148686-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313210954.148686-1-josef@toxicpanda.com>
References: <20200313210954.148686-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here we are just searching down to the bytenr we're building the backref
tree for, and all of it's paths to the roots.  These bytenrs are not
guaranteed to be anywhere near each other, so the READA just generates
extra latency.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4fb7e3cc2aca..3ccc126d0df3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -759,8 +759,6 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 		err = -ENOMEM;
 		goto out;
 	}
-	path1->reada = READA_FORWARD;
-	path2->reada = READA_FORWARD;
 
 	node = alloc_backref_node(cache);
 	if (!node) {
-- 
2.24.1

