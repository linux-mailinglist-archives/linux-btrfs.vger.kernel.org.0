Return-Path: <linux-btrfs+bounces-453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BE37FF333
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 16:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60A5B20FEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9996651C55;
	Thu, 30 Nov 2023 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdPUlOJi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70709194;
	Thu, 30 Nov 2023 07:08:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bc053a9a7so1583591e87.1;
        Thu, 30 Nov 2023 07:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701356894; x=1701961694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij6He2n7VfO2PU5CQDDnpNgiB61sX85VSjvJ1Sw1Bmk=;
        b=hdPUlOJiI/Ff2s7sQMMrhjFnfQbj5BZ+RruxmYyMpECMP6pggVNjA4g3xtBjkMMfI5
         H97EJmHixZFVuQjiuEOqrovzqxOCQ2M0fcirnOV1m/7G0CUSdCSQp8/byR5JqTn5KF+t
         Bom9sygTG5UmY5y9NgsaKLqUhvAOZJDh+HPj8vBKZXdWBcoxq3sQFe0vS/5XOr3xkNm+
         UztkkLbvEFtcDciFNC2Nk4LLn7iBEQnl4t/9kiN7G4KZXYdZ/6eazjVm0KYEz7CdquBa
         7uJpj/Ur/vMTLlFwLgiUdQtT27WdE8TqQKiDRRBSthQmopvpitIYExtlaQQqEx1FZ0PY
         XkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701356894; x=1701961694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ij6He2n7VfO2PU5CQDDnpNgiB61sX85VSjvJ1Sw1Bmk=;
        b=gvDI1WOLwJIAaULjAefnsovE6NUpIevOGZT435pC48JBHmzfsAKlkUl84fm5K+3Zfk
         p2uM72xAJDjem/Y789ht8ErkQ0lPIYgwW9Hnt5zXi6puiSun9MKdBIEFGQaZpcqMFPR7
         NdVnVEOl5QVVJBfTd9SWZXtWMZjl9GjIVE/6FBbP28HK/bidEy2iTJF3gALzZd0K//HF
         sB/f8suMBfcBXOPZtC89fkly81y4TDJkeeiEgbN7/79yjEbjh8B7lphgQtLR/8Hde/B2
         d9TbY+VV0xDSYK+gS6BpoKYxPXxkPt3/0w6SJfKkyXfaAyoA6f/kHgSykBgn3+/A+nZ0
         bi4w==
X-Gm-Message-State: AOJu0YzKAfwBqqlWR1G1X1Exfxbs24c+rhstLSTA6mDPSgTaTrjr5kvB
	RQzaG19vay+iFm9tAbYPf/w=
X-Google-Smtp-Source: AGHT+IFplBfPeB/2YfUE7slWK1oJxGIpl9P3JdyoKk2opcJrfaDpOQAztlmWLQTGZeiURAfWGrLRpA==
X-Received: by 2002:a05:6512:1386:b0:50b:c96b:5e8 with SMTP id fc6-20020a056512138600b0050bc96b05e8mr3051182lfb.25.1701356893308;
        Thu, 30 Nov 2023 07:08:13 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b0040b45282f88sm5865713wmq.36.2023.11.30.07.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:08:12 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: remove shadowed declaration of variable i in for-loops
Date: Thu, 30 Nov 2023 15:08:11 +0000
Message-Id: <20231130150811.2208562-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable i is declared at the start of function btrfs_qgroup_inherit
however there are two for-loops that redeclare the variable using a C99
declaration, causes name shadowing. I believe there is no need for this
local scoping of i in the loop, so replace the declaration in the loops
with assignments.

Cleans up clang scan build warnings:

fs/btrfs/qgroup.c:3194:12: warning: declaration shadows a local variable [-Wshadow]
 3194 |                 for (int i = 0; i < inherit->num_qgroups; i++) {
      |                          ^
fs/btrfs/qgroup.c:3089:6: note: previous declaration is here
 3089 |         int i;
      |             ^
fs/btrfs/qgroup.c:3321:12: warning: declaration shadows a local variable [-Wshadow]
 3321 |                 for (int i = 0; i < inherit->num_qgroups; i++)
      |                          ^
fs/btrfs/qgroup.c:3089:6: note: previous declaration is here
 3089 |         int i;
      |             ^

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/qgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ce446d9d7f23..b1f93dbf468c 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3191,7 +3191,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 			ret = -ENOMEM;
 			goto out;
 		}
-		for (int i = 0; i < inherit->num_qgroups; i++) {
+		for (i = 0; i < inherit->num_qgroups; i++) {
 			qlist_prealloc[i] = kzalloc(sizeof(struct btrfs_qgroup_list),
 						    GFP_NOFS);
 			if (!qlist_prealloc[i]) {
@@ -3318,7 +3318,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	if (need_rescan)
 		qgroup_mark_inconsistent(fs_info);
 	if (qlist_prealloc) {
-		for (int i = 0; i < inherit->num_qgroups; i++)
+		for (i = 0; i < inherit->num_qgroups; i++)
 			kfree(qlist_prealloc[i]);
 		kfree(qlist_prealloc);
 	}
-- 
2.39.2


