Return-Path: <linux-btrfs+bounces-22079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBUDF8fjoWmUwwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22079-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 19:34:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA78A1BC058
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 19:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80167319D003
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 18:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9006439901A;
	Fri, 27 Feb 2026 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyEtO0EF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA5938F920
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217099; cv=none; b=TxBSHTWUQXENT0bY61x1yf8U4+rt50AJfNOoOFKMYikZGKiXjqX1LFO0SgUDjyknTlvko20uwOLg7pg7ToZ8BMoTbhopUh+ECBOMP6nMDUqzzLycbljlqbjSVWvvAnO/snDsDIsTmTLaPKT8O58Qfv2qEhueLcQ8QAUjWBIAYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217099; c=relaxed/simple;
	bh=YLK623bWYOROJ9jwJGW6AmX/32QovVnZZAHPEgYhb1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrO3vaLZ+BrXaw9nrAh/L48+wNRp/iE4cLYDxvwNaze6PK9cX+2TA9PmhfbrZgJiABIitaYleGPBDv6nqewxxHa4hb6RlBHnDKScTJOdFl9uZWW2PpwGwYTmycws1KIfEdyhQyl1Y5Ip58Jr1C1VNPOu6EiTQoaP9+RcLzz0C5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyEtO0EF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aae4816912so16023815ad.2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 10:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772217098; x=1772821898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTOvqpnvslLTcxyr1zFBiT/Ggyco+fV23SsFbnjLxPk=;
        b=EyEtO0EFedb1f4uonvR1ewDkFfS64KRKBLtjyTDDL2lhXnOGNcGj3eFT+4OMxnGKIH
         01rubvPhOXFodWSuAnkhau2jumkKwXyNf8j0vkSs1+O7+vhD7/5KUoEdhi1hQNnBtqM+
         bzqvUbzqcSMIdCH09GWLI0J/FQCQ6Bgdox82SrZPir9tt3ai4AKpHnkV29ETbMdL4Au3
         RHFBN+HZyAh5wAMlegNvHTpcfSdbEBf87sibqoVJ8a46Y0x8G3qmXZBh+QFA27nnigAZ
         bUxT/hoEwz+TVLa/oA4MSuVqYmJ1SJsgPilua03qcljPVw0gyoVkIVS20/CuzmcrLFj6
         vEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772217098; x=1772821898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTOvqpnvslLTcxyr1zFBiT/Ggyco+fV23SsFbnjLxPk=;
        b=WaEB4/LQphiNTPKp/TDPbFMBGh6UXIQaAOhvE1O5ShWJgQ1j4GYj6PsxwMidxglQUq
         AOH8yHH6KsQ5gsmQzFvq/LOj0sO2XJM03h46YFLE4WcbsfxuVxwsQcbAJW+AsXcq6u57
         LOe5m9KetHY+MWo2yiRUhWLAvwQ8YuMNNjIgxDdT9o16U4d0oZSHZEEIc2ee03kdHDsK
         cxx4WoSGSmS3OrXCBbKZk/yrHuqsTW7dvefb7OcFambDNMVR1LGAI9KXWV5GkN4pJwkw
         KI7BquYlZdXJszDZrGhzDa2o9YPjZnw9q6YPIilU74gal5mtLBXzAcagcpSsS+C4cnlG
         wMvA==
X-Forwarded-Encrypted: i=1; AJvYcCUOOjLwY4pHwWJ6+l/Kcnbf9awn6sDK+1A7zISEvRapmhet0yBrL6q1ISvPCAcG2ykTtwxIkEWsdL1pGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx79YZAsVmg1rJLsnR4HenLR0IlfuILd2yzROcz/rXvfYzerfuQ
	OXPR8iZO3EbU1M81wB3ODeTjAs/x/S1tBLF/2SsqkGRV0Mw61qHSXuTb
X-Gm-Gg: ATEYQzxUkGfWGweApz5xs3qTTnD7/tJh8w20rmm6hNsxFkUq4hoRd9sq39WCfsJYqOj
	px2nnpAhUGX6uRvMku0KBDV+avuej3mLNCmaJ4KgFf3nXfp82MHFu8mwr7qJW7/iGcmtH8P/i+3
	+9MFMLkhZzf36XHV/vnlJ62uUu1pkpeOEwxOOPvvqOxRz+hZp+jdhRJLjhOmQvt9ktHxt8Csslc
	3mxuggQfwBwk98bmqWXaKDB9z0QqZskr9uRlIIlplCKRBG7QIev1dz2hULOKVIf2xPZFLU7ORR3
	NtkbSjwK10rHALZCQaiPCro3gEfxXx9lH4J7ifTR2qOtFgGEAgJn+8DO8DbV6ETfhnt7+ZyFqYk
	2HVHRtGgrF0Oeut92AWAaO2pTL+5sUTYnwK7uro3flBnJLs6HrHA/X0mReCVtII9Cxji9UKdr+F
	1Aw0S2Ua4rzEDt67zS1tIMUSrF
X-Received: by 2002:a17:902:f541:b0:2ab:344e:1413 with SMTP id d9443c01a7336-2ae2e46c080mr35386525ad.34.1772217098074;
        Fri, 27 Feb 2026 10:31:38 -0800 (PST)
Received: from archlinux ([103.208.68.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbad2sm61932485ad.34.2026.02.27.10.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 10:31:37 -0800 (PST)
From: Adarsh Das <adarshdas950@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: terrelln@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adarsh Das <adarshdas950@gmail.com>
Subject: [PATCH 4/4] btrfs: clean coding style errors in extent-tree.c
Date: Sat, 28 Feb 2026 00:01:11 +0530
Message-ID: <20260227183111.9311-5-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227183111.9311-1-adarshdas950@gmail.com>
References: <20260227183111.9311-1-adarshdas950@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-22079-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adarshdas950@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA78A1BC058
X-Rspamd-Action: no action

As the previous commits are changing code in extent-tree, this patch
takes the oppurtunity to fix checkpatch errors in the same files. All
the errors were formatting related.

Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 fs/btrfs/extent-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9748a4c5bc2d..8ea88174e4d5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2111,7 +2111,7 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 			 * head
 			 */
 			ret = cleanup_ref_head(trans, locked_ref, &bytes_processed);
-			if (ret > 0 ) {
+			if (ret > 0) {
 				/* We dropped our lock, we need to loop. */
 				ret = 0;
 				continue;
@@ -4351,8 +4351,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 			if (ret == -ENOSPC) {
 				ret = 0;
 				ffe_ctl->loop++;
-			}
-			else if (ret < 0)
+			} else if (ret < 0)
 				btrfs_abort_transaction(trans, ret);
 			else
 				ret = 0;
@@ -5676,7 +5675,7 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
 		 * If we get 0 then we found our reference, return 1, else
 		 * return the error if it's not -ENOENT;
 		 */
-		return (ret < 0 ) ? ret : 1;
+		return (ret < 0) ? ret : 1;
 	}
 
 	/*
-- 
2.53.0


