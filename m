Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80472172C0
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgGGPnc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGPnb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:31 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0137EC061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:31 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ed14so8508537qvb.2
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+sX17+UelazVGYPbbR1IqUU0+Cr26BH5FHiEiR34no=;
        b=KkJ4n0kecBTpBowW9VJHfGuaQahDuG2w28fGcmV8zdShkKqgfchmyeFB3jA+pzuqUH
         /t7we8SBJRjwNrFqe+xR8kRpgvgW0aPYQkPWOv0G9NzgIEn9Uha4KTG4HlS57FGBr3Hj
         zwugpXu2FM9Db9nuqzzl/kFDIkatElhFkpABecku7+RSRp9Uz/TrLy/EZ0GPVtcpZB5D
         YlzBOJBbxqeLaJc/srSo4/O+tiqeSps/H3nzOz3pf4ukK3odjIsssgRiSgfvJ8EJPyMH
         cbJqGlNImAawMLjbqdmuglYu8eLxJU3yAITQyN8F+DgEuTdRiPCkvREjhWySKX5TffHK
         6Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+sX17+UelazVGYPbbR1IqUU0+Cr26BH5FHiEiR34no=;
        b=DIv/IGDFRYX6tIN4qBoNOPLwnu4KinOPPU5wzfUFMfbiRn3HXCKw62/hfOUbwqJjAm
         Exj3GpaL4BLioqaivunzQwgCI914U9a3JU/2hHGpAJRTF9p55Wjs19/ZftQypKExXXFH
         wBpkBaAk/a4K11Cr2yAL0jGMjCgyh7iT8VgwY3lzj1LM5IuU5cdatxwl+W4vWOp/x8VA
         UuG7fQ6N2x2pY2SAEXdJrkmF9qw9qrTxaaxMyXAiffiFaRSW7a/8u3D1FuudrXfyliKk
         zoadWucvOdhH9ynkTIeIJX8DVg0LO9AGEmLNCrS5Rb/vokUrRV01EGvaYT5xvZW1g6We
         h3GQ==
X-Gm-Message-State: AOAM53365lDHFa4+2DtbpW/mm6p4UlXYynlgiZmJtB42mjwxkr3WF1kj
        ZrL7nhwdLMU0GDtdqWkanoVjouEtR1HbjA==
X-Google-Smtp-Source: ABdhPJzhX8tufUPJ2dxozteeK7KPI/jEvrfhbCVBUdguHznnNy8nHi8i7NkcIi99WMZHjEgPGz2UcA==
X-Received: by 2002:ad4:5511:: with SMTP id az17mr52837798qvb.159.1594136609901;
        Tue, 07 Jul 2020 08:43:29 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c27sm23651585qka.23.2020.07.07.08.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 21/23] btrfs: flush delayed refs when trying to reserve data space
Date:   Tue,  7 Jul 2020 11:42:44 -0400
Message-Id: <20200707154246.52844-22-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
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
index 5a555f20ca20..db0eebe6758b 100644
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

