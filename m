Return-Path: <linux-btrfs+bounces-5296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBCA8CF61B
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 May 2024 23:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6601C21180
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 May 2024 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C743813A27E;
	Sun, 26 May 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="XmjO/I9h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD462F46
	for <linux-btrfs@vger.kernel.org>; Sun, 26 May 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716758622; cv=none; b=LapCGsGWmNZnHmTozRCD9hbzsnJaF4aJsWAiXiCWdBOjV/p+YJ7aw9K8Tf99ZZtgezXutJkp7/PCovcHCy/pSrlcL/a706F1dFFqdw7VeWzYcv3Q48f01l/VKFBeXw/vtKTn8bRhq4Gk5kqeZK3+vDuEfEKFI6rjoNpjIDO9z6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716758622; c=relaxed/simple;
	bh=4br1+bsqarhpsUSUDMHnPY9ItAu5sQzF64WsQKB/4Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QN2feBtZS7wwH1DUhnSHgS1sZdRAdRioeZIHJp1+bLPDdcReV1RRb356R4w7DA76MJgLBBXSnQjYY4WENOd+8NhNwtAV4B5nxbojTdXoffVt+yxtuQgsmt2D4rNZ0t0D89UZJ6Fx6UA6z7aHDLB8fDHvW25KY5JNR5a2sZ0FU+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=XmjO/I9h; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-354de97586cso5789784f8f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 26 May 2024 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716758618; x=1717363418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbk0UNvpsQrSUqN6RzC4hENS9R3C9NfeLNOx5djjey0=;
        b=XmjO/I9haUhiyklbPuZ9WpTglsUZdxk9OmWkuSxY6sNAUOyzp/IR/oUhSthm6XcE3L
         wJmuerQQprftAOKfkl9baTQLYH6T36DkBMkmyNLzzcVNizzheJu/zoe/hqGeLvGM4xFJ
         +cFcNtMMWq1Kj2gQpoXAFFWhodzuiJHLp4gFEOJ35YagajD7/2Ky23oABy5shch5Hkm9
         RxcXrW93bZepY62gWQnbwK4z89bXIhXdoRgtHoM8OICVbw4qnEX+D06h9U6TwFC+OLbD
         fxE7V63w6kBqOWvtS1En49gwNijuIOJEWyzOK8Jbn4eDETFSKXIwNYRkjgPlpgSrCJNd
         ff7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716758618; x=1717363418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qbk0UNvpsQrSUqN6RzC4hENS9R3C9NfeLNOx5djjey0=;
        b=gTpXfwSlEVyzUHLUbRWa3Z4ozEXwHkvDzdqBZAsPhXHC1Owwa53dcHzRAzLcjg7kik
         a0KJF5FcZeok/ec7k2UZjp4v1f1eBADgVJ0a/qPVM0thS7HDZyWpYg5p/qdNTQVPjj4D
         Grbgec+8ElYQxN3R1XPc0dErvf08fuhqmHR2TPoWP9EGKngbo+bEKPbmHOTE1jSwAJ3+
         4ngClFyUrf4np988CvH5uRKwUCGODB+qv5rcgC3EoIj9t5pZSrwBBqdDHrqQZlnoLiBS
         73Znt3gmXiQoQihfHXlq+bxlg/lUpaQiWxbEJjqPbnGa0tU6s8pm21YyT3Py7mWW/9Lh
         QTtw==
X-Forwarded-Encrypted: i=1; AJvYcCWkA4IGhKTKaoR+liFLJfUpi0ozzlmdtLSB/lFeRJQVMkP1r5BY8v3EbnaY4sHG2cOrGAayRfzmXWersYlGFkMbOIZyE0d1cwqSI6M=
X-Gm-Message-State: AOJu0Yzki82rkzhv+xNM7mNeVz8TUJsYVw3XJDnlSu1P/mCCB/5rY/RD
	59Q3644bUk6+IoR4Xgcq6LFKFxmwJ2ymhY1MFsciCvkCaFyKuOVcGyKY4v0/WVM=
X-Google-Smtp-Source: AGHT+IFy5L/fF6HnmYmy15FzQ2I5Aj94AJhD6S8HOgJeCGnH2efGYlzLjxrfvdfR5wJ4GRUcUbR/8g==
X-Received: by 2002:a5d:4e01:0:b0:354:f1de:33eb with SMTP id ffacd0b85a97d-3552f4fd249mr5166115f8f.26.1716758618179;
        Sun, 26 May 2024 14:23:38 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7de1bsm7224197f8f.13.2024.05.26.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 14:23:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: bhe@redhat.com
Cc: amir73il@gmail.com,
	clm@fb.com,
	dhowells@redhat.com,
	dsterba@suse.com,
	dyoung@redhat.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kexec@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu,
	netfs@lists.linux.dev,
	thorsten.blum@toblux.com,
	vgoyal@redhat.com
Subject: [RESEND PATCH 4/4] crash: Remove duplicate included header
Date: Sun, 26 May 2024 23:23:10 +0200
Message-ID: <20240526212309.1586-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <ZjcvKd+n74MFCJtj@MiWiFi-R3L-srv>
References: <ZjcvKd+n74MFCJtj@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/kexec.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..d3b4cd12bdd1 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.45.1


