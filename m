Return-Path: <linux-btrfs+bounces-18115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7BEBF7150
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 16:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE29426CFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43042F5A35;
	Tue, 21 Oct 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="leh0EJf0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6825EF9C;
	Tue, 21 Oct 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056908; cv=none; b=hGm/9j4RvXYYJgDGlz5AoP94SrNKvkDIeWpfsxK1pcVIKFKXc/q1zRk7NyevGSCNPHwf62MJtwc0hcs2f6F0j2N8ArjbN25lWVD9CY/6I+lRm9281M3WwgmmJhxDpdm8VtyE1ZaBLUMPzlGjtD2ins2zwg4aeLjgd1dG0j//Efw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056908; c=relaxed/simple;
	bh=zMyKREAOYWVFCApr0xhtd/UF5pT71OuhTStzFWNDAmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThOv1G8C05fxRpncTKWyeIqOPvR7iCLsEKw9yMUU3fyFNVfAtTcNrSv/tE0kc95dtPZaFOtFx3RYJnHZKLVt6LGGsReVv38+fckTBTot6tVLbR9Ya725/QMGoVOsqsqH6/nOEmz8SFT1zMA4Ad6hUxYUeibZ2mEUezZ8b4rMAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=leh0EJf0; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4crZQs4qGpzB0gr;
	Tue, 21 Oct 2025 16:28:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1761056901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Zc8N7D+mRZxcFLHziOmGNcp6TISGWgy+Cb4QBRBUK4=;
	b=leh0EJf0P5HWxVFPIWGAjUFrnLlSYqmD/AF/h3zyQiXHmO/Jjwnal7/tu5Q7PHUi6m+XEF
	ao3SjedTtA6uAQQp26kZZlGnCuPH5HSXTBXJkTinwgKgXuPYo0w7txx3RTmNzffZMOMMHl
	edgXoW9BPhJspi1PLcdqswMlW2jiqtPTeeABGXhGsW/eGWaozRyeXQMAhrPGz6eRRRRqy4
	CwKmhE2JFDf/g6xejtkqBx1nHp/YKl5+D+Pnvg1KUksWDOj5GdvkYjH1TmvfgHRPIX/AqL
	bgr+qyLj7ysUYmKWUN2Nd3s7pP4Fg1CI5pHVovDCUlbRo/HgQYo/i0B5Mv9oNA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::102 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com,
	fdmanana@suse.com,
	boris@bur.io,
	wqu@suse.com,
	neal@gompa.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>,
	David Sterba <dsterba@suse.cz>
Subject: [PATCH 2/4] btrfs: define the AUTO_K(V)FREE_PTR helper macros
Date: Tue, 21 Oct 2025 16:27:47 +0200
Message-ID: <20251021142749.642956-3-mssola@mssola.com>
In-Reply-To: <20251021142749.642956-1-mssola@mssola.com>
References: <20251021142749.642956-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4crZQs4qGpzB0gr

These are two simple macros which ensure that a pointer is initialized
to NULL and with the proper cleanup attribute for it.

Suggested-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/misc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 60f9b000d644..0e33327e70d9 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -13,6 +13,13 @@
 #include <linux/rbtree.h>
 #include <linux/bio.h>
 
+/*
+ * Convenient macros to define a pointer with the __free(kfree) and
+ * __free(kvfree) cleanup attributes and initialized to NULL.
+ */
+#define AUTO_KFREE_PTR(name)       *name __free(kfree) = NULL
+#define AUTO_KVFREE_PTR(name)      *name __free(kvfree) = NULL
+
 /*
  * Enumerate bits using enum autoincrement. Define the @name as the n-th bit.
  */
-- 
2.51.1


