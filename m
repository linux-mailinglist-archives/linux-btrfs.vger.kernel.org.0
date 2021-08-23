Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1A13F51E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhHWUPv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 16:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhHWUPu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 16:15:50 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4724C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:07 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id ay33so9108690qkb.10
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0tFf9JN+Jo8kT/tPISRImGoNIQDDhS8Strz5dXKSgkg=;
        b=DOa3R0mpv8Zn1D6/kCLvbvISmF8x9EfXItepQho5ykjWnH8Gnpp8BtGLba0gg8II1m
         0WUN6ji3u9eQRNWg7uYMczlTtmwm5lzmGKPuOEGYwCam+kG3pjiYOodzzsN5aeIM7DgP
         0DLwdGHSaEaZON6O+QvhTpjoEFqJ71eFPWCDnNTq8182+pbInD7bWrRqe5joaAD3UTyD
         H5ZCBuvsCnf0uEtMpVx+80KrDiJVYiq/6w8JxRr0VNQnMZD3HC4YtaGrosXMLHXMVLjb
         +Sm6FL0j10sZi4mwHdGRzbH1qQ4G0QLyJ7LOjfRDtRZqFfuU/nsWnY6AXCWKs9h8/Svj
         Z6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0tFf9JN+Jo8kT/tPISRImGoNIQDDhS8Strz5dXKSgkg=;
        b=VVnl0v7wptJePs2zKT0Soiv3jtIqhoAhtvCd0BTku6a/c6lWGbMLHwti5duq713yuN
         kQ0ETkkkGsRez+7PvwC3K85MrWQ5tEg/WEGtssz+TCJp2jhq4WzkJkdm514eQU2p5+7n
         XYmA9GJlkkwrzyGQ++50UyHPl0QL6rAgpma3kxf2deXUerm3/FuLqhRwNkTCiIG3Z+M/
         PoaRRLgSvgkVA/5uL3TP3R99buyTCaWglGlEwb95jWCDV4446dt6Sj2n5/ZjL59iCMor
         Md7PzcDxWiRaCBVAOgtc6ldsaAUQu5GjYzkxAFIus4B/T2o4Bm6UurW8NrG776nrwbeS
         QvQg==
X-Gm-Message-State: AOAM533sJA0ljaIjObFYmBoVKqfJSVcbSNjKPmZUnDLoCPW2IEOkKfqz
        FgGFFWvbIDGr+O8iHdwG/3+yLbnpPq0BXQ==
X-Google-Smtp-Source: ABdhPJziDC8bKyqIom/2u8fNU/aa2Ui6Q4UfDMpLWuUyBJZz80ucWbPEElF/kUrojyw14qt3GJmQ2w==
X-Received: by 2002:a37:c94:: with SMTP id 142mr22925821qkm.78.1629749706459;
        Mon, 23 Aug 2021 13:15:06 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x9sm9254507qko.125.2021.08.23.13.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:15:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 06/10] btrfs-progs: make sure track_dirty and ref_cows is set properly
Date:   Mon, 23 Aug 2021 16:14:51 -0400
Message-Id: <ce8c770705df22993bdcd9adc3e6004734e4a940.1629749291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629749291.git.josef@toxicpanda.com>
References: <cover.1629749291.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Adding support for the per-block group roots means we will be reading
the roots directly in different places.  Make sure we set ->track_dirty
and ->ref_cows properly in the helper so we don't have to do this
everywhere.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 84990a52..7f99fc8d 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -720,7 +720,10 @@ out:
 		return ERR_PTR(-EIO);
 	}
 insert:
-	root->ref_cows = 1;
+	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID)
+		root->track_dirty = 1;
+	if (is_fstree(root->root_key.objectid))
+		root->ref_cows = 1;
 	return root;
 }
 
-- 
2.26.3

