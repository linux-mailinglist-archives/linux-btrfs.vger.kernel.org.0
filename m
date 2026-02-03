Return-Path: <linux-btrfs+bounces-21323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJrQJfgvgml5QQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21323-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 18:27:20 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1550ADCC62
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 18:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C01B30CD445
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7128C31ED73;
	Tue,  3 Feb 2026 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iei0sEHn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2E2D0C8F
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139465; cv=none; b=Lb1SGuie3TIixRFonc7/MAbvjpbZiYzDxFq3y4CopxdJHCysWmDLp8tRN4qki6W0WP7IxA1aGUaY3Cb41uDQzx8owDRIHGtOQgH3G1Y1BtrcWJlUyqaPXQaVi0wcQ6oAuopGTP43Eh79PZuDBZXTRtdUeolHW3/rX8eG3C0jcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139465; c=relaxed/simple;
	bh=0pDadfXZD2BD20L2lYJnlOl+5a7N3k4V6nBAQaGTeG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cU5MdfDYV0ltvU9xkV9DhaVb84jF63ZWnOyFAySFQp0dssSFG14TwVHk2ATszuv8QuQNrtQDJKrEZd6tX19gA4VPxuwKS4M/syS6zRGCJU5qmyxGaba4URVqIoorXyVO/lQ2pnRHUwygurpbMC+dy4NiN5Vr0+yQV02q3OOlLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iei0sEHn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8220bd582ddso3499243b3a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 09:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770139464; x=1770744264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH64yHIZX3KkZaMyb1NeM5197qBECCBgD9Lqqh1xbWk=;
        b=iei0sEHng27v/y7zabiBmu85SS5klDr1K5vSsKhDB3CXCJdF0PwZdGpI5LGVgdUANK
         wszrOgVam1ynH4t+ufHRPKcwU/UT536PTuRFlEpPtxmtuqMx+yt9S20jQ15naAhbukg9
         Eg4joz0HGV3x3kpyhqWDQ+gng0wmuR7k9jw4KN1ZNXlC7Ndq62qdK+IiDYgRDLGwLqTO
         N/WPKi8R1yMaJe61Sp2lIlOpf00JcO9wNKnQIjZmqqqarXxqAGIKubBUTkcwNXILQC8W
         +1SeePpMKYN/4QEnxR1DHGZlRnMK1F2iUNK5tCa+ixPQ+tymXtrV4grQGFKnEopx7nNB
         v5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770139464; x=1770744264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dH64yHIZX3KkZaMyb1NeM5197qBECCBgD9Lqqh1xbWk=;
        b=a2EanES7lTngV4h0VkxWYH8z9rcsGb/RZz2zfFl2LgEYj8757HHNtwmDc64xfrAqoM
         iajN3xnE4xG0SVasO2/Pz6o7OtaAR/LRn6Cdj2cWVgJM8FVIWru+8E24a1ytv4LpliNB
         9U4OrhhHDnGCRZvRwtJ3eFQ1J/WkkXeD2zCIyfSX+UFM/C2rJv78AzBjlJtfTcG7w0w3
         eoIT3R6/Ymn+S9RarGZiGKWS5gzOqa00PpFUqBeTieMVBhftKQsc0CMLKUPx7ht9kqYn
         Z39C/kpaMHxV/5cYKS+ViU1X36lKWDzC6emPvNnjgxvnM4tWKGYtiXZDs4/8CzNLvzJy
         IrxA==
X-Gm-Message-State: AOJu0YzplpSW53gN43qCXCC5dd2uf2VQamgzUORee9J0nFQXLgv30b8F
	NcTD0b2wK5xhyuMdf09f8vwvsuBMdpz6fApmFFHjBgBh/Y5iHbHwdJ1H3sVrOg==
X-Gm-Gg: AZuq6aJenijBQ2N5JGhZbk4oHdYQZUtNlFOo4mhb8zdYpwZOnWfLU9aCPdAn1SFZ9o2
	cuLPzcWRElm7ziRYYhHPNoisdv6OWKoyqRs15KZA1IR88b6Tj+6m7soKvGOgn9b7jwrhx2CYETA
	+J/NZkfbFb1Ws0GaUYko3p6PnMAEBUr7GFcBbnf1EHuTSRSuX49KRftuJYofRQzHj1Ewoo5rP1v
	tANR2LvniO5I81/Q/ftiwuf2hk3Gqw2LE59CrIN7+58rEbLvRoOobflITHDne3C32KNzwpHWKFf
	jRlWOLen60/+3e9AAjujDBYSN29LX0SGz+ADFFPthTXWIdlTfheUlLcpDzznTuxPYE4DWdgg6p9
	NZtegMS7u1XJkfNsoInKJgmSjHr/GwN/8ES5KBdHAWfKr5MCJEwZlUfcvme3Gurn1BacVpVU6Ry
	m9BBM4pvhC
X-Received: by 2002:a05:6a21:104:b0:38d:e674:b5ef with SMTP id adf61e73a8af0-393724c9047mr117902637.75.1770139463978;
        Tue, 03 Feb 2026 09:24:23 -0800 (PST)
Received: from archlinux ([45.119.31.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f70fesm17099299a12.25.2026.02.03.09.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:24:23 -0800 (PST)
From: Adarsh Das <adarshdas950@gmail.com>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adarsh Das <adarshdas950@gmail.com>
Subject: [PATCH 1/2] btrfs: handle unexpected exact match in btrfs_set_inode_index_count()
Date: Tue,  3 Feb 2026 22:53:56 +0530
Message-ID: <20260203172357.65383-2-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260203172357.65383-1-adarshdas950@gmail.com>
References: <20260203172357.65383-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21323-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adarshdas950@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1550ADCC62
X-Rspamd-Action: no action

We search with offset (u64)-1 which should never match exactly.
Previously the code silently returned success without setting the index
count. Now logs an error and return -EUCLEAN instead.

Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 fs/btrfs/inode.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a2b5b440637e..9f46bfff1e4b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6105,9 +6105,18 @@ static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
-	/* FIXME: we should be able to handle this */
-	if (ret == 0)
-		return ret;
+
+	if (unlikely(ret == 0)) {
+		/*
+		 * Key with offset -1 found, there would have to exist a dir
+		 * index item with such offset, but this is out of the valid
+		 * range.
+		 */
+		btrfs_err(root->fs_info,
+			  "unexpected exact match for dir index key, inode %llu",
+			  btrfs_ino(inode));
+		return -EUCLEAN;
+	}
 
 	if (path->slots[0] == 0) {
 		inode->index_cnt = BTRFS_DIR_START_INDEX;
-- 
2.53.0


