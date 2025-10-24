Return-Path: <linux-btrfs+bounces-18272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E74C058DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 12:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8A69342F10
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2388530FC3E;
	Fri, 24 Oct 2025 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="DevviGX8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646CD30F943;
	Fri, 24 Oct 2025 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301354; cv=none; b=GYvRiMPIOmUESWLvykS8yppC16OUQa2U/HZWld4VmolpDS81CbFWX3M4OAN061+HRYCtPAaY0sdEHqLuZO0bcMB3/ypi90/07hkJhK+ukA4htWEnrzl++dmvCOse0d/361u8udfGGICV7plLsjWu1EeDOYfoig9Eveg+rExDGhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301354; c=relaxed/simple;
	bh=AYexWKgjlC/6/XZ+rMCz8Yfsdbd8Oc2v0vGOxZNjBXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAt4PGHqrpfjrZmjgRPVbSUAFOCRA8/BT1SZOAOPjHcG98GTQJqz87yG/U3k1AiAnb5m1ulNrbxxazZoT95SlCK6ArYrPGcVkyzy2QD53cppugpxrygfirjIOjj4liOpT8V3dvcRgTmP+ktfKfCCBTVp/4xJBH4GvExwY9VGJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=DevviGX8; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ctJqm5MMjz9v3b;
	Fri, 24 Oct 2025 12:22:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1761301348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSAxISSN6q/2TqVC51fgp56Z4tqCi+4yr5cLFM6xPMo=;
	b=DevviGX8z6r1TIaKDwug0FvawULqpf6R+3l13Pu6aeSFdk0gOuN92LKf7m3ccWXgV3lEQb
	R4+FBtyecaiBtio3udOEO1WMwwQoZmO+6/eOC6qB6EneMzUXQ/jCZrLpSUNj/zvcYUAzIE
	pgcOkh0w51V6/IrWPYmgBfn7z1OaAq9BsKV/MXiZ0wfEbbjCQ/OrQ4v/9ztf7Id11JnX21
	sBa92ScWd17KrB0hs+Oy1hFcbmC0A/XCbOiZ7GZsWqNv55+dfiJypDp9G4YCrAHVtf7R37
	3YP7ey+n6JhWSNQcbbjRJRZ2zJiBeL2ZAWwLbP5EcP5MSgkCuevDbXGCyS4HfA==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com,
	fdmanana@suse.com,
	boris@bur.io,
	wqu@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>,
	David Sterba <dsterba@suse.cz>
Subject: [PATCH v2 2/4] btrfs: define the AUTO_K(V)FREE helper macros
Date: Fri, 24 Oct 2025 12:21:41 +0200
Message-ID: <20251024102143.236665-3-mssola@mssola.com>
In-Reply-To: <20251024102143.236665-1-mssola@mssola.com>
References: <20251024102143.236665-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These are two simple macros which ensure that a pointer is initialized
to NULL and with the proper cleanup attribute for it.

Suggested-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/misc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 60f9b000d644..4d0a417af77e 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -13,6 +13,13 @@
 #include <linux/rbtree.h>
 #include <linux/bio.h>
 
+/*
+ * Convenient macros to define a pointer with the __free(kfree) and
+ * __free(kvfree) cleanup attributes and initialized to NULL.
+ */
+#define AUTO_KFREE(name)       *name __free(kfree) = NULL
+#define AUTO_KVFREE(name)      *name __free(kvfree) = NULL
+
 /*
  * Enumerate bits using enum autoincrement. Define the @name as the n-th bit.
  */
-- 
2.51.1


