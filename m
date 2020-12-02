Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDAF2CC70D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbgLBTwk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388163AbgLBTwj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:52:39 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3325DC061A49
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:29 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so1994347qtp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DMvNnOrRtu4yLJxhDVPBS7UDJWnYlz36sTOfG9aJkV8=;
        b=LWudZwJ2y+Uw9VNCggZkWalnL2eFUQoH9hSiWRx3xxu4pzv23jnxk3BgSKCQt0etH0
         xVnZG14jARD797ak+YTR1t1O++Yx7IOog4hffb/q8NDM0hI/lNLX+aAmmh2qRfqP2qel
         l9EcXQoMbnryr12fiKBqedesMGnYyB0BGYkBAjPefOEgomLmjf6CSuhaT3BlMCTw54xz
         PsXGdcB3JYoXI/rat+hlMBMTeAHidpNuvv+YGqqrX6MNZ9b/pmC2bZzTO8ey15kIkSpX
         WB/fR6vYCQ5ol6ttvSAzWzTEZM6k0LOOI+VwHfqYpvbylbDklPbWGDRJUSWu/KLuQTha
         WP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMvNnOrRtu4yLJxhDVPBS7UDJWnYlz36sTOfG9aJkV8=;
        b=sn3Hk1dqjgbFtayThpNEzINMi3PwO8M0ysNggd9lqfZ8Yfii+e+VGolTZ53b17eO4j
         ZnASNFY4j7Z/IgVNPsvthmmgaa72gg6YFNTrPlVIvkuyS7eYTOuWLAkBk8h9vR+L5DVV
         ef5D+3G+lgtcv3xSzacw07oaAVbntugkIdu7Wqc4ds+3nkC7ExcUkInSgx54l8TfiC7W
         qP0CKQWiN9kp5tUJqR9QSHxUbG5pTerYnRfRRYx0J6Dz5EJu8rw+8y5P/qpIhawxAdFx
         vGVebjwppvY42kl22mhVSoPGhI8WcdfxafU6Zb4iUJDlCd3MxI0D2dcLOXg92TXqVN8G
         Pl5g==
X-Gm-Message-State: AOAM531UBht/XCD4ARsWMvY04z/Efo6zMcLlfifyXwNEgLvra8BKTU/3
        pdK+uEHEbnRWr7DDqLW6kIWvvlnn+pE5yg==
X-Google-Smtp-Source: ABdhPJzpmRtApy66NQ7xR3ptpUW93jwndEcawhL307/eK3sTq46q7G3/uOYR+qfEzJezm8OauOOU+g==
X-Received: by 2002:a05:622a:18d:: with SMTP id s13mr4462210qtw.306.1606938688064;
        Wed, 02 Dec 2020 11:51:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d82sm2799081qkc.14.2020.12.02.11.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 08/54] btrfs: make sure owner is set in ref-verify
Date:   Wed,  2 Dec 2020 14:50:26 -0500
Message-Id: <9cf8f3e86cf2449dab8823ec623c832d865c0ac0.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed that shared ref entries in ref-verify didn't have the proper
owner set, which caused me to think there was something seriously wrong.
However the problem is if we have a parent we simply weren't filling out
the owner part of the reference, even though we have it.  Fix this by
making sure we set all the proper fields when we modify a reference,
this way we'll have the proper owner if a problem happens and we don't
waste time thinking we're updating the wrong level.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ref-verify.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 409b02566b25..2b490becbe67 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -669,18 +669,18 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 	u64 bytenr = generic_ref->bytenr;
 	u64 num_bytes = generic_ref->len;
 	u64 parent = generic_ref->parent;
-	u64 ref_root;
-	u64 owner;
-	u64 offset;
+	u64 ref_root = 0;
+	u64 owner = 0;
+	u64 offset = 0;
 
 	if (!btrfs_test_opt(fs_info, REF_VERIFY))
 		return 0;
 
 	if (generic_ref->type == BTRFS_REF_METADATA) {
-		ref_root = generic_ref->tree_ref.root;
+		if (!parent)
+			ref_root = generic_ref->tree_ref.root;
 		owner = generic_ref->tree_ref.level;
-		offset = 0;
-	} else {
+	} else if (!parent) {
 		ref_root = generic_ref->data_ref.ref_root;
 		owner = generic_ref->data_ref.ino;
 		offset = generic_ref->data_ref.offset;
@@ -696,13 +696,10 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	if (parent) {
-		ref->parent = parent;
-	} else {
-		ref->root_objectid = ref_root;
-		ref->owner = owner;
-		ref->offset = offset;
-	}
+	ref->parent = parent;
+	ref->owner = owner;
+	ref->root_objectid = ref_root;
+	ref->offset = offset;
 	ref->num_refs = (action == BTRFS_DROP_DELAYED_REF) ? -1 : 1;
 
 	memcpy(&ra->ref, ref, sizeof(struct ref_entry));
-- 
2.26.2

