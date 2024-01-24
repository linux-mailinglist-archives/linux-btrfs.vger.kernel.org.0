Return-Path: <linux-btrfs+bounces-1732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E79083AFB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A171F2B643
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C9E129A89;
	Wed, 24 Jan 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PNKvmHqg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E4129A94
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116813; cv=none; b=fAx3XxRFugSXSnirG+Xn+X7sBYatzKI034K23cUp22/MTpDWTn91yaHfzsfwPeOjHMKZh5zPTm6DS9fg13162uvh6tUIEUFa1SUddFmvAJW8aySDWh85sTu6SQKYoJvsRNTVzDXjJ7q6IoX7mzktLt85T1KeODIkI2h2MS2VDmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116813; c=relaxed/simple;
	bh=Mdbz6fI6yt4KcZYHMZ3rowlJCvbLWQd/dfWff2jEnEo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbUuSJM1/sTTRvrHzw/EN/uv62xrHsDMK6oLp/mEpHclTzlSdMrbNKseVXm7ssyl8fkh59WUNMDfnRjvxpOs11BN/Z5R5Ltojn8uXHYuvQfgoMEWd2yzNnQRhGdiiqFVkGvZdiRElyI2mOXy9tK6FUOFZFAZyYMSJJViPM3WVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PNKvmHqg; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc372245aefso2029915276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116811; x=1706721611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6KwyOzIoCI6QL+6zOEq6JXNT1wkBSzB1pOwGOeLqao=;
        b=PNKvmHqgypA6cotD1ftoeh6FrTx0mGfz9vS03RESjIlI9/4bkgpxWOIxfGWZgJYh2J
         w4m3iuDQ0dlg/kpmfo8ZEZG6yAbt25ncy0Twnh5kJsqQavDog9uwSD+Vdnp6Ma3IYKqE
         EtFnMftos3UJPpheTs0f6tDx+Fljw/xz7nGvAVtcWhO1wHRlT4ftRFlZBinlcG1wiA8D
         6DbjfIyYCy2Wj6tWt0eaQSg65vGdy1LbTSG8ZIHijgj0K8HOyMLFtIpGPyiBuqs57us9
         LX3IluDuk+ZnPgLAecaBylS/oUYTAY3hmNVTU2YhsevB5zwHbQtUUK5STAE0rF0CxxOd
         k9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116811; x=1706721611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6KwyOzIoCI6QL+6zOEq6JXNT1wkBSzB1pOwGOeLqao=;
        b=xBy5uD6t5KlmzX0pHq1ML0TaHNEq0gM2dyldrseErTDQ6bn9gyIxyWWlm+LnEaSfF1
         N2vXytSlPx4qSKuTWeJUMjnU56wrTFOSpYPPfy1IXLiKXvEHMybdUidGr1jcFuHS4xZi
         kFyN7z+xiULLj5AI9cZFEz4hwMDhpqHxfWGqyfR/cfYVVVAiE3GUEW4WGDx2Ys/0kOY9
         5y4Y+2ieeSUwY6VUlORZdsQ1D3tZCpb0ARNfPuIAuZyoUf/xLJ6SwLEHfGgy09N9klac
         NDaTvaFmm2q/BmSwHrgonfCZI0NmafLrWeHrSicVUJFx/LekAj46nn7Lbxzh9XiVSeyr
         PB2A==
X-Gm-Message-State: AOJu0Yyjy0NFaXpc1i39dMyx7MCghtO+hXEt5gVpQl1KdXFq+h7anma+
	Nvn8hWt7jB1Vgdwk/sCPzb81BgHGdr7d8hYx/gzk7UHeskDZQyVw0OGb+qofpk/wD8zIhqFJkg2
	a
X-Google-Smtp-Source: AGHT+IHECwav8YbGSMzTwfGEyo1U21jET+ZBmwgEDh9OkVF5Stw7fF0ES3JN9mZxmcYTwZ/kmfESww==
X-Received: by 2002:a81:a191:0:b0:602:a760:8142 with SMTP id y139-20020a81a191000000b00602a7608142mr594963ywg.12.1706116810871;
        Wed, 24 Jan 2024 09:20:10 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fu7-20020a05690c368700b00602a88f43cbsm65856ywb.7.2024.01.24.09.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:20:10 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 50/52] btrfs: disable auto defrag on encrypted files
Date: Wed, 24 Jan 2024 12:19:12 -0500
Message-ID: <b717912bf88797b3044a3c2724b59b1ecc17ea78.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will drop the inode and re-look it up to do defrag with auto defrag,
which means we could lose the encryption policy.

Auto defrag needs to be reworked to just hold onto the inode for
scheduling later so we don't lose the context.  For now just disable it
if the file is encrypted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/defrag.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index c3be0d1203ba..1f538fb192d0 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -135,6 +135,14 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 	if (!__need_auto_defrag(fs_info))
 		return 0;
 
+	/*
+	 * Since we have to read the inode at defrag time disable auto defrag
+	 * for encrypted inodes until we have code to read the parent and load
+	 * the encryption context.
+	 */
+	if (IS_ENCRYPTED(&inode->vfs_inode))
+		return 0;
+
 	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
 		return 0;
 
-- 
2.43.0


