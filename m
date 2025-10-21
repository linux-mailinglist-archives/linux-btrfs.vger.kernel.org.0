Return-Path: <linux-btrfs+bounces-18100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC0ABF577D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 11:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4A5B4FC9BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1E8329C6A;
	Tue, 21 Oct 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="bs7huozD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A42E1C6F;
	Tue, 21 Oct 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038415; cv=none; b=oRH2Gvz7WxMvU2SRqHRd8VSO9+m3Aq6PGlZ+YNTM1PVYnXaE145fqpe3VZCqXGSzrMKEI2yi6oLkx1PIssiggE34wBF0WY5S62NtSwPDx4y5WAjWoYTYoB+VLsKEvQrnt/cGinVI/CxdxzELs8M/+QpUBTicrx40jMj7FE2Zwb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038415; c=relaxed/simple;
	bh=gt8QTpigXYJ1n64pcQZkB3vjbpNTcKFzI6KwGNk8iLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o29aI6DK1xwlsOPwVigaV7UK2vbLMfRy/A9EIsOssf33W2YDzGczkftQrXbj0WGRRHQ3lTw0hqHUBHLqL1ExwKNnHK7TkNsbbDtvM7lgur+912jxGUgANuSHu+ROhtMkOw1415pDtphXhtUaa+nPqW1GvDn5kVoXKeYsKgcwiVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=bs7huozD; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4crRPT2RH0zB0hT;
	Tue, 21 Oct 2025 11:11:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1761037901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p3RxAUKQ9gm37DDQ5FvmzUhdsilQPRCwahlHic7b+Cw=;
	b=bs7huozDuXZcGzwVEPlTjGVjs2xXBKjvgPUk/MVF5SHIZBlQbSNjZ6YqEGNaB8nw2yw94Z
	AOCkztG1oBtIXP6NNPyqt/Z/qyrICiQ/Q23aqpQDGRojaj42GpnTzErqFcBZ/bO3D9aRmU
	kFhcB3BWQFIFDPiSTfFIrBonTw4VkGU/RwDfJheZff4cuZIWxXojDb82RFGQ9xlcym4EDH
	I4Il+ErPZ5XryjlM0ioHIiAlM0jURQeN2ZxotGn8RnQkcO9tmeWaMB8TKC7gMeJ3gpJg7r
	T9MKC+P1/tnvCPr4LMu0TaJnodq+tHkeV89hR4mLcNLR40qbo58ibSM/pvljnA==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>,
	syzbot+d991fea1b4b23b1f6bf8@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: fix NULL dereference on root when tracing inode eviction
Date: Tue, 21 Oct 2025 11:11:25 +0200
Message-ID: <20251021091125.259500-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When evicting an inode the first thing we do is to setup tracing for it,
which implies fetching the root's id. But in btrfs_evict_inode() the
root might be NULL, as implied in the next check that we do in
btrfs_evict_inode().

Hence, we either should set the ->root_objectid to 0 in case the root is
NULL, or we move tracing setup after checking that the root is not
NULL. Setting the rootid to 0 at least gives us the possibility to trace
this call even in the case when the root is NULL, so that's the solution
taken here.

Fixes: 1abe9b8a138c ("Btrfs: add initial tracepoint support for btrfs")
Reported-by: syzbot+d991fea1b4b23b1f6bf8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d991fea1b4b23b1f6bf8
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 include/trace/events/btrfs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 7e418f065b94..f17ee9ba2cf6 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -224,7 +224,8 @@ DECLARE_EVENT_CLASS(btrfs__inode,
 		__entry->generation = BTRFS_I(inode)->generation;
 		__entry->last_trans = BTRFS_I(inode)->last_trans;
 		__entry->logged_trans = BTRFS_I(inode)->logged_trans;
-		__entry->root_objectid = btrfs_root_id(BTRFS_I(inode)->root);
+		__entry->root_objectid =
+			     BTRFS_I(inode)->root ? btrfs_root_id(BTRFS_I(inode)->root) : 0;
 	),

 	TP_printk_btrfs("root=%llu(%s) gen=%llu ino=%llu blocks=%llu "
--
2.51.1

