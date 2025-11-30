Return-Path: <linux-btrfs+bounces-19428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A3EC949C2
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Nov 2025 01:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0126347742
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Nov 2025 00:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881641CEAC2;
	Sun, 30 Nov 2025 00:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lCrK1YG8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7C235950
	for <linux-btrfs@vger.kernel.org>; Sun, 30 Nov 2025 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764464151; cv=none; b=iQEPLHmi5sHG7nUpPFpgmWFS0KW5nk5KZOwgcsxLHtc9zcTbAknmoeJD+Vv7pIkUqDC1AvoppJfYD9iPT83MY0BaTW/QTRsad1p07b6feBbTAuS0C9Sw8wcdMtGo2h9j7PRnPYq1J5ItwNqrIk+E/j8E3mW2G+Wj74ElpVbh0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764464151; c=relaxed/simple;
	bh=BkUuxsKZKN00r2RjiS4MxSZFxrKime88v+Bansi5xds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIbiXQ12/k1UAomycRLsdI/+dPywp1qCtRu4fHMoGGnR6d3Mk6ub6GQdphrCvdvJ/gSm6PvM1iSml/7xsRJHXYcQfM0OiVQ5W3QUYLbIq9fFvG0tYtD62RHC3Pju0+jj5vZuqqVt0a7k1kSD3NGWYyswc5AAcMuqmVBBF9gppdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lCrK1YG8; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764464137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c8jsj49RlqxO9evpv8BMnWQhpCHg8/alPpixATKFWQQ=;
	b=lCrK1YG8WlICWYVF+G3mPgRT+nQDfeKx8+i0ghYvmxEIDlJuXSDLJLDxMuI9onrxiedxn6
	xHdP5rgfNGJBuC1lcKVbcuWOyVHq0oKPhoUEFDi8Igg8L6IJoUjNZ8QbCk1Hp/nbL7X2Sc
	GHafEXnRAsL5dD21r1T0f655iYxnPWM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Replace memcpy + NUL termination in _btrfs_printk
Date: Sun, 30 Nov 2025 01:55:17 +0100
Message-ID: <20251130005518.82065-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use strscpy() to copy the NUL-terminated source string 'fmt' to the
destination buffer 'lvl' instead of using memcpy() followed by a manual
NUL termination.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/btrfs/messages.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index a0cf8effe008..083e228e6d6c 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/string.h>
 #include "fs.h"
 #include "messages.h"
 #include "discard.h"
@@ -229,8 +230,7 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
 		size_t size = printk_skip_level(fmt) - fmt;
 
 		if (kern_level >= '0' && kern_level <= '7') {
-			memcpy(lvl, fmt,  size);
-			lvl[size] = '\0';
+			strscpy(lvl, fmt, size + 1);
 			type = logtypes[kern_level - '0'];
 			ratelimit = &printk_limits[kern_level - '0'];
 		}
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


