Return-Path: <linux-btrfs+bounces-16502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C71B6B39F40
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 15:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085961886DBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 13:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030A73112BA;
	Thu, 28 Aug 2025 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu2X1yJ8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490313C9C4
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388639; cv=none; b=hlLjJiG27vwGaWWsUZFLYsDVM57C8hfisr2Ih6xRai4ECtfx+PUIEIUH8ZZAMC6kKS/gb6WoAjRktOAWGBQHInumYAND+RRfcEG6NikbNdsEIhyTKbA2SI+/hIRkMd8jXbQ9YWIbnuxOotby0ucqbxRLqyk33pJWQRv7imL292M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388639; c=relaxed/simple;
	bh=mCER7NFPFO3FcBkQoZG1qgbFG+rgthZLm8ywdlGKDHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=PDpaXSdsUWr3WNNaBmRmAD4SniMQ68cYZLol1TP/aQLNZlQksr8VrIdqoLx1WsFbU3JSa1F1NU7UySZzQqIdm8U252V4GgVgBQv6fnZec1oiAknKDxMvmYs31sf/EbBAHSP2ayhyvwcjx5janOVF6KFyn7oDJMVIpoJPLBlrOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu2X1yJ8; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-248e01cd834so1261475ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756388637; x=1756993437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf6na7MGKnCwxfzWGPH9jodPnb3YyDqt+IknCagMZG8=;
        b=Yu2X1yJ8AYHDAMJY0FQeMYoxXN9WGtQUWDRmhmyNqAwLCrEBQRHPtmhg3lVaD45N+Y
         /DdSN//5DdslYoaL3nj9rO89iWx9Oib4/7gTXWrQvluCi3KvqARfSL4BpZLaWlrlSQa8
         Hc8EB+MA1f/fsWaab4rK5SxRxT4jzQuQvFROMhIpTfDJus+DbpwdQiePBDLAeMfCPifJ
         fBxhgzSKKHOWQd6D5t4+JBKomnzuaH9ace7aru3GrGWF+vuhU1KtmDoHpmT3Vz0yWy+m
         zaWUyipZH3wRkZPhvPQkqG0h9MzJpfOxx18Y5J5whEnhPXmGeWpli3hyyDEeBV1b5+Gv
         br3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756388637; x=1756993437;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kf6na7MGKnCwxfzWGPH9jodPnb3YyDqt+IknCagMZG8=;
        b=m4SRF0a8EumM2xgRAjBwhpCyVM1GrnJLxu8e+2i3OdNC47vnpcP0oBpP/DBWS3cYpW
         6DQLUSRv4PfV99nNFQiK9rGcPEUPsMXBFwWHaP/bcQ6cTg1wfzPSuXJllDenni8yE+Rh
         G1bRFLU9pig2yAnNkuVFOCDkBvX62+MkWjMhw3Zl8mr52sMUdojD2noHZ45n7emhi0mq
         mD8lKCUQphZG94GLBCKwGE5Kzj/CH5TKU04mqjAD1QPcUl6virPWJ5+tzxnxR0o+4iFw
         BwB9EcSobk8T2HvqQ++yqZ/YHhsZhjGnsHKlmcoPXs6CZ/ck4Pi4vzoUEcEZ408f40EK
         Jh7w==
X-Gm-Message-State: AOJu0YyYTJfVcXj5ivsFuRPbKWFpFqXdvkc5Gyw4KEVyku/TROdijFux
	NphH6klFuetY8uJDQMjwldOy3VJFSwfuT1bCwMGT0z8Svx4+yi5Zh6Vy
X-Gm-Gg: ASbGnctoD58IRDDAldodBsCBVeC1Xa7jq1fziExHQ/q/Yr3IQ0m3hUhLvwJRaujK7Og
	VLG9/v6qG/t46R/jXqmtraCi88scYDN8So0P8XB5zavlEpUZx/pTahQMUGLOrr6iedQB1Nko/4y
	pHieOkDTRXLRazwTJmiWV52PtW9kJHmQu8D8i1tdfn72Gl6HfkNGM6u3QXVwqwpQTMmvEmhDmG7
	MitDXno/GMAk65zxZpcJQGpF1NBxA7O2VXpDqAclduR1x98lUPmVkirlGnLxbxj9jiAe9PNh/nC
	WaSWZzzU80Zn4Dyn7gaMOCnEkRLIn1OwaCOQZFXKRzjEjQWtP4UjDzO5E3LLKRul2/qirUIbV9t
	jywkQe/7wkIHFlGFBp6aK1TtbaB9ZpXHZxoiHiuQ0UNVezGiQIhY=
X-Google-Smtp-Source: AGHT+IHZ3eSDqSAvmp9e2INkmCvgCoW0a2u6A0mX4tTJex5gL8KfFcEzHPfnh7akD1a5Sv2fklXBJQ==
X-Received: by 2002:a17:902:f689:b0:246:b3cc:f854 with SMTP id d9443c01a7336-246b3cd0030mr115366245ad.2.1756388637245;
        Thu, 28 Aug 2025 06:43:57 -0700 (PDT)
Received: from saltykitkat.localnet ([154.3.38.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327ab0dc2e8sm2554232a91.22.2025.08.28.06.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:43:56 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix typos in comments and strings
Date: Thu, 28 Aug 2025 21:43:51 +0800
Message-ID: <12730365.O9o76ZdvQC@saltykitkat>
In-Reply-To: <20250821225742.1151914-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

I also found this when reading code ;)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c5c0d9cf1a80..13823e838107 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -103,7 +103,7 @@ static struct kmem_cache *btrfs_trans_handle_cachep;
  * | attached to transid N+1.			    |
  * |						    |
  * | To next stage:				    |
- * |  Until all tree blocks are super blocks are    |
+ * |  Until all tree blocks and super blocks are    |
  * |  written to block devices			    |
  * V						    |
  * Transaction N [[TRANS_STATE_COMPLETED]]	    V




