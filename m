Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C2E228205
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgGUOXV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbgGUOXT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:23:19 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF66C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:19 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dm12so9389218qvb.9
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xmiqq+ZSGW48hf2wB/mM0xQesV//E9KoAcumehKGgc=;
        b=R3f+3HJOF/xBx8P/rcbMSn/JnI4JFR8bRZQnRQx1VTMC5YxmjgpGveDn2rQTPIAZnI
         tjA03MXIzR/J4tya53hBqmvqDmxOI7eRw+5KZOZVq5TsSuD727F49DfIvPD+SjICBsz+
         iPMOzHcDGlgr04bmCMdkkosrKBZuy6WXBltZDpB3v0PqMKRiJ+/MF6eFqKe85VVH8/4H
         3+eQl0J1GQpXklbik3Gva+R8wjaZuoHesoGi9fcUT1Pfsqyd7AwlK3zFtMrL3muAW+qv
         5IRr+XTa12me45pcIYFuBlAOo6XdzyJrXh0pIWhHCa4hEA/kpPmivfWHEpBtSJUYmkgj
         q8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xmiqq+ZSGW48hf2wB/mM0xQesV//E9KoAcumehKGgc=;
        b=Tulx+UVHDPKgdHMVJ/1deILmbjXcxgujKRPvDIWrPEL9xIRaqvt0nK7HJESV7/KmmS
         Et0hOTEi+7eXk+VnGEq+fGgYLd7fn9g9H2r5HLItYvQM55NDZk+e5hdeA9WglWTGQn/S
         mwwFkS6DovNpDjW25S0KStuuycFZtkQYrrq0HzgGTXbKpltjaeTzsiIdc5cTtNEudyY3
         urgWce58afRswrjfGIBUiE6jYobGH21l4vB0MUFuUlnxWACLPmMfbjXhwo4iwx2l4KRW
         qlOFeHs2Oj1lZUcMsG4Kd5wBOXATqAIR7fNrIW3IrCUtJ/55bn0rAIvlLIGl9IKQ4IxS
         WylQ==
X-Gm-Message-State: AOAM5337MlagLiPnCLJGnt7h9eTuitN2OA1VCcG1PqjoEdzYyarQgDFJ
        jPwD3X0L96vUIXolWE6hfs0D0kO0A6J4ow==
X-Google-Smtp-Source: ABdhPJyDWW/pSWQ5jnL+8KtRrparkctsLJT6WXNAZd+Cal6UwOVMlIHTeJOO+Z+vii/v3NV2I0/kFQ==
X-Received: by 2002:a05:6214:289:: with SMTP id l9mr27015148qvv.238.1595341398302;
        Tue, 21 Jul 2020 07:23:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q68sm1186703qke.123.2020.07.21.07.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:23:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 21/23] btrfs: flush delayed refs when trying to reserve data space
Date:   Tue, 21 Jul 2020 10:22:32 -0400
Message-Id: <20200721142234.2680-22-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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
index 092f3f62a5ef..fce61f800150 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1023,6 +1023,7 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
 	RUN_DELAYED_IPUTS,
+	FLUSH_DELAYED_REFS,
 	COMMIT_TRANS,
 };
 
-- 
2.24.1

