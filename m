Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AAB2D2F8D
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbgLHQ0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbgLHQ0G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:06 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F58C0617A7
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:26 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id b18so4935635qvt.10
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qcBvIWEBjxi5epMisBQCJPIJ9nknseBSr1K0c7sI5Fs=;
        b=DuSG89NXmk8WYpbSGNgQtmRLkUlH7LESqG8y5BioJOFDXNT8mcHc6E5W12SPD1Ol1g
         UmBcYAcQOO9TW43dikXQc20Scf/Zj7Dmfe4QQrfR4kxhEALQlVjMnBGSbZdOAtJGzEBo
         gQlh8e4IkzXqGncwAriMu1dGsD5pHv6EFmawyo2hN2TmimMTlVJVQpi32B+qUYZKZrXy
         paPym8jHJ6DdOl8vzsfWJEFe7NT5JGSLXhhaiEtC9Fu+bmp6D9mAj7j29ac279eWyd41
         vPFvLVWfYn2C2e92NZxDOMaL7iZoGUwwfrQmo2Bm6c0ns71gsFmYNCR2Oway5yBEeyEh
         DrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qcBvIWEBjxi5epMisBQCJPIJ9nknseBSr1K0c7sI5Fs=;
        b=XI+giLl4gbR4abKG4q49sbp8Sy/fsEU0MxBllJ4siYoBldONs0GaJmpImtTe4os6pn
         pg2G6wSw3e/DLZHPaLnoZZOppZJFvLgGuxVZNHeZF6n4XPtQmj7mQrNVKmrml4LZ5A0M
         0ZCUsPWwZaGouqpVkVaR259kEFLEwOUgc8b2dPEitUTpL5H91k1M2KlIz7XW1tkCHy1t
         ihg2K4d4uZdkBZimDOxZ5nQhJwKixc9ssWBGJBDYVoaoemUSGYIfDNg1ZiOEK/p6ek9u
         95hd/xlUt0qN3nJSrApqM8n30Ga2O74zUXPqvdyqvUPPY0RhIkhCMj0hY2AKtAbJhKPn
         dZRA==
X-Gm-Message-State: AOAM5316Oqk2s9W1Wg7mbTIWP+amcImRRYuiHnFcRgD0C3WoBqMxkj3V
        650mCjwLR6gigF/Rvg+J+yTv7mZ0LZtMUEpM
X-Google-Smtp-Source: ABdhPJy0np0/wWbeed3Yrn1TymTA1g70oiRB7YdlVFWFiFeW5JSD3OTuw2Op41DQrU8YmEkj1MozSA==
X-Received: by 2002:a0c:a802:: with SMTP id w2mr28543821qva.9.1607444725067;
        Tue, 08 Dec 2020 08:25:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x28sm12690905qtv.8.2020.12.08.08.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 38/52] btrfs: handle btrfs_search_slot failure in replace_path
Date:   Tue,  8 Dec 2020 11:23:45 -0500
Message-Id: <d3cc5bfd6deecccac19f320b652e4be3d65f348a.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can fail for any number of reasons, why bring the whole box down
with it?

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8d683056fd9e..01085952059b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1314,7 +1314,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		path->lowest_level = level;
 		ret = btrfs_search_slot(trans, src, &key, path, 0, 1);
 		path->lowest_level = 0;
-		BUG_ON(ret);
+		if (ret)
+			break;
 
 		/*
 		 * Info qgroup to trace both subtrees.
-- 
2.26.2

