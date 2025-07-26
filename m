Return-Path: <linux-btrfs+bounces-15684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA13B12ACE
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 15:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FBF17B03F
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 13:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C7528689A;
	Sat, 26 Jul 2025 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrwU8qxS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92928641F
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753537952; cv=none; b=sFe/lfb6UqjxrwfOLBVBMicjEI5/DbyROlJ0ttAUokzXOIBRzSrnY7hYL+ZmgAXQWmY1zSklBNIdpJF9pQiAbvw8kbC/9GUX3Ztf4c+lfzOvf527W7+y2uYUYRkj52Uqt35OxRNp232UOP1wU619lMesAv+jGJdujVLGe2b++OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753537952; c=relaxed/simple;
	bh=7gd476IolKXvWtWM5PNLArlzNpOchO48gQXbyAHiX74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bir370w6qFZcHz8YL3kR+hvbE0kvQl/QRBLld7WAHGfyjlpjpU+vCInn9aupl64YnZUIqLcjONdMpdOYIDQHigzSelfpXp6Q9A75yi07o0WE9JLaBKKy4W2w0JCHqUjmZ2htl/mAaXRzVNt97exxLvvrsd54jcEKi1Mhy2DUr3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrwU8qxS; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-312a806f002so305113a91.3
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753537951; x=1754142751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0hCcc2QcdtSVEA5+KgHrzUWXLl2RXopv82WotQy3oQ=;
        b=PrwU8qxS02MMnPYZvkrEmX2Gk2DBvyERHH1WhYLn27/uYQ2ZZC4Y8NxB2oGkXONiQ9
         awh5s0WrHBBofLYSViEolnxVuvmfrBylUJ5MLttocwHg2u0Pnh2ybM1ZM3WWpib4Awig
         Pgb3LlZ3Oh6t6C+/ZbdxPX4WYos457euXB+L1bNcaOsyop6tKneyZNqo6I32SK2QK3IC
         A1jBNeAiHQEV/3cMs/9Ke4h/y8ngXOzJfbEXRAj2IiC+fzadElMKqfvffFt46d0d8O6I
         IoQ9re2i6F90lY1eQ5tZFEbFQd2Y9DvAxNFW8/gZjFOdSslNIssVOrR2eT//U7Kd79rt
         KJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753537951; x=1754142751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0hCcc2QcdtSVEA5+KgHrzUWXLl2RXopv82WotQy3oQ=;
        b=A/h0eKZs2iai4RTOsmOqPPJEiy5XmnDCeuNlibIQQ+lGKrb0BTaHMmu+Vn+ENld/d8
         y3a01rzoJuO3DRCZfA23ks56oGXbUVhYlUpIPAdZJ1o26JsViwVhB/Tixao1eGNwPx3O
         prrVmfaCbbkYGia85huXbSsqhj11YPEJcu+pifumfjrcWJIchAmFe5qaZrQvOZpnxRxV
         LXQ9qJjyJSogxg3aauhN+E7nO4vfnE8NemvcM7ol2OcXyZW59o6yltRO1rAKe5ibWen6
         UiGpHtxaErUxa1wisWBn318iZ5A1NgbBEF+Amevqpk+ctykqgN0xRnZFARTImrCq7of2
         PsOQ==
X-Gm-Message-State: AOJu0YyYrpSpOkGAnGt9oPuA+p0QXFJvy/IRNmrQS488s4Jx8hVLvzxT
	E5r6DvgLYt3bdfpSs/VjDJ6nO5F9vb2QtEYdjmwBbRDzD1ArkBgdPUQP
X-Gm-Gg: ASbGncuFmlaGYUjp/EYuMJIbs3qeYtas3W61YjU4EqW04uA/1EgxjP9bMc+/KuQBNRi
	9x8eaUno1IWNJEPRDj2VbYLpdGt5uoD1f3ghP4wkBi857ybpxX4uKCuYM2QcJva2B+g18MOtovd
	8WXikntx3ZK8FIYwA5g4FGhl+WjZeSrfGftAZ64WhJuxeInoas0b+Hgl1vvkfFX7iX7scee4YOV
	DzHbFD/HSW5zmqomenP12fRqrAtcf+AzxVraQZO8DC0p7GO85KV9Sm9nsOzKH34Qu1El0GvVhiL
	I85592b9YFGO2WL9pUzehZSvv8w3wtlSX8aGT6STf724vgWNz+uQqAGbZWp3lpsroo2SXwTrYtA
	dff2aDqc805aIj9nxuCZuXh0Xg4s4+5kgdw==
X-Google-Smtp-Source: AGHT+IERPiGGOfe9Rhx1e60gOucoZc6DCzSdDs4GZUctFAVzWN7Tyr+7viw3XxrSRBQ2kawi3AjYTg==
X-Received: by 2002:a17:90b:548f:b0:31e:a421:4de1 with SMTP id 98e67ed59e1d1-31ea4215464mr554559a91.5.1753537950823;
        Sat, 26 Jul 2025 06:52:30 -0700 (PDT)
Received: from SaltyKitkat ([2a0c:9a40:9210:2:be24:11ff:fee6:cbe9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83580856sm1874234a91.38.2025.07.26.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:52:30 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: sunk67188@gmail.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: narrow loop variable scope in copy_to_sk()
Date: Sat, 26 Jul 2025 21:51:39 +0800
Message-ID: <20250726135214.16000-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250726135214.16000-1-sunk67188@gmail.com>
References: <20250612043311.22955-1-sunk67188@gmail.com>
 <20250726135214.16000-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop variable 'i' is only used in the for loop, so move its
declaration into the loop header to reduce its scope and improve
readability.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ioctl.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8a60983a697c..9948a12fd5e3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1485,7 +1485,6 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 	unsigned long item_off;
 	unsigned long item_len;
 	int nritems;
-	int i;
 	int slot;
 	int ret = 0;
 
@@ -1493,13 +1492,12 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 	slot = path->slots[0];
 	nritems = btrfs_header_nritems(leaf);
 
-	if (btrfs_header_generation(leaf) > sk->max_transid) {
-		i = nritems;
+	if (btrfs_header_generation(leaf) > sk->max_transid)
 		goto advance_key;
-	}
+
 	found_transid = btrfs_header_generation(leaf);
 
-	for (i = slot; i < nritems; i++) {
+	for (int i = slot; i < nritems; i++) {
 		item_off = btrfs_item_ptr_offset(leaf, i);
 		item_len = btrfs_item_size(leaf, i);
 
-- 
2.50.0


