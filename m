Return-Path: <linux-btrfs+bounces-296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E464A7F4E19
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AE1CB2122B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3FB5789A;
	Wed, 22 Nov 2023 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="R+SyihnV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77831A8
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:09 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-daf7ed42ea6so25173276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673489; x=1701278289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3n+aVZ94c68BQfM0UZeR4DnPly/rOTpXllEpIAZgtwA=;
        b=R+SyihnVYOe65OMXfLYgS3WMFMwCm0eEOUpWGd/dnJiAaHSjymgn3tAweDTew/1tPm
         h87T2nzc+iR7q8mzfGE45egJrzsnqsVuC54CboRQ7GlHNtB3iXgxSz2RGOuKFkdNc9yv
         JJF/LrpWDcVvrl6ih1WwAEufY8aHmGx+P7cfuzNs4h96Q0bQa0+xkZHNmCWJCB/u86/F
         r1Si1mSGqxoO2CueVotPktDhMV0UDSKIF7raaMEdKOkuagVg6/sG0rLugRLpVcg6caFx
         Re5l+dTtEqjQ5x46k7Vla3SYSWNYfF/LoUvHLdlt7gy4u5ShJwg+pj+xI+ZQIuvarvGf
         gKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673489; x=1701278289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3n+aVZ94c68BQfM0UZeR4DnPly/rOTpXllEpIAZgtwA=;
        b=Cp7Sqa2lOOK7Tbf0q5pihwUruFU755ZBJKAKo4klwPjGTuc4p6WBBjNoHpw/GwaggW
         pP7DnOs4TBxIKaM+HQxHWtch0d8/hAjMePV67+kdcUr3y6x3l9y9KY9exDjADKHIo6LE
         mii9vtKy+PY+8emiH0Su0/d5Fn39d5PUtg+d+NuNHoKZrX9THsM/YpGUJc6/GSextSY3
         I1HcCZIt2Vypuy72aUE14oiq2WRDxU/fbUaitXFGCJfkqJ9DXqy1nL4O80AD8weP6yex
         87dYlV+Hi3tqGL9DYbCvwSZknWycxooyhAv5TugIlOC8aUTotebQ4xMt/St4pkcL4oUw
         DWpw==
X-Gm-Message-State: AOJu0YxL2oe7mcFGSQT19MSC96RqTBA3uvWKO2F1MDRVlwUMQa9o/RYQ
	4XUYPzSjyYT+TYLJtr7TCVeHusRZQYXZ+OnQJzsbD06x
X-Google-Smtp-Source: AGHT+IHzimPvMRejY6ACVnMZicqLUZj/07XGxIX3GzPaToIiDZn6GCo+eLofcFpJrBD0z5AN/xrOcg==
X-Received: by 2002:a25:b847:0:b0:daf:6333:17c2 with SMTP id b7-20020a25b847000000b00daf633317c2mr2544519ybm.14.1700673488431;
        Wed, 22 Nov 2023 09:18:08 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u6-20020a25ab06000000b00da076458395sm1476811ybi.43.2023.11.22.09.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:08 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 05/19] btrfs: do not allow free space tree rebuild on extent tree v2
Date: Wed, 22 Nov 2023 12:17:41 -0500
Message-ID: <d754f55c810b490b90ccfbd8fe7a093dc8bf9646.1700673401.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700673401.git.josef@toxicpanda.com>
References: <cover.1700673401.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently don't allow these options to be set if we're extent tree v2
via the mount option parsing.  However when we switch to the new mount
API we'll no longer have the super block loaded, so won't be able to
make this distinction at mount option parsing time.  Address this by
checking for extent tree v2 at the point where we make the decision to
rebuild the free space tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 065a2e3831d0..42da84a186c7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2961,7 +2961,11 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 
 	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
 	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
-		rebuild_free_space_tree = true;
+		if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+			btrfs_warn(fs_info,
+				   "'clear_cache' option is ignored with extent tree v2");
+		else
+			rebuild_free_space_tree = true;
 	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
 		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
 		btrfs_warn(fs_info, "free space tree is invalid");
-- 
2.41.0


