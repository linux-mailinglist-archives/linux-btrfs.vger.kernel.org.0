Return-Path: <linux-btrfs+bounces-14145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74197ABEA6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 05:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15FF1B6361C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 03:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4640E22D9F8;
	Wed, 21 May 2025 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIgVHamA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F99B66E
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747798073; cv=none; b=hfLQh2R0E3GJ4V2RRYZFgQSokhck1N3XAkXicW7zi1ZbkVmmZMoQ7jzVnfM5w/o+voTtFv2CRJGpXJyYnl54zKVK2A+7DnfkPNz98J/wceU6WXtlyYbBkut/VUwaskAGGmBM+J4u0oBQA90vOFjWMhdk2rLDVP2tcMSUL2Dd86Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747798073; c=relaxed/simple;
	bh=p2KRKxmp9u1rQasnOYse21dEcTAHQxC1G79Eri5kKxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=euFLQR0J2aofte2BanI8Apf2bPNE5RR2Y1Opbxy5EboasdOJtsmcRrCLU5zW6bcpDnnbpK7opmhxNIQBLqh8Xl7t3FsrFilnQGoRjSEWceOlJCcOTVRK2oYS0nIzjYhSnzqLzPNcvKBmvY4UUqAwkKXg1SUyp6JHrd+UW+3ZL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIgVHamA; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c96af71dso4195595b3a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 20:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747798071; x=1748402871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfB+dI7pS7X2e7t7/mg+3cc3doRboIeR53g/xqg76M0=;
        b=nIgVHamAjLd5DJ+T+XPrYZnSD71mT2sYyv1hp5ug2k0jib0yGLB/aKqRw1BWUkwiU2
         +/NVimWu8nqRip7uupiwntQRQ4qLaxofkHoqwzCon8ELCPRc2ExVuaKa1jF8Bs0JKlgp
         2+4i2eFefPOBSG/j0CDHsy5mvvZU0PLb0DPtgLXROIcT/aPpI9sfgXQlm+tXIBcGmUl2
         XKUUaNX9bw+2hYFKc3Am/srYn2Lvq3PRZ5Cpfy2pxF+tHPGTGKmOlcdZbkpXOEm5Jp53
         6GhBsI8DfhQWEMC1KzN6ij9N5aU9eHxS6EBxA6QGm50RGSPvtQopljoLwyuR6NeQKmCj
         SGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747798071; x=1748402871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfB+dI7pS7X2e7t7/mg+3cc3doRboIeR53g/xqg76M0=;
        b=a4DsLT4dEBFroZm2MsSU4UrTeWCYYfSEsnwy413124MWGFcegqa3YxlcTEwV8LWd0U
         vhREt9jJuIZSElcQQjgr8AmGEM4WOJ5C/uXsOS39tC8m6UFLoNNDXiQ51riwdydk9/d+
         wx99CnHr/6emOacmcySBpZN0/Z080JlIsbQS6o1neS00R51/0dA4FFqxFNy0xxDbetbR
         +HWUwI6OpNzpwB7gEnZK7BdCCsJS3/6LmUT3/fMkNsTOvMNxbzYNt5bfIkBWnfwOBTJ7
         iOyT5nPX73V25irbH5teKmwgy3/Qn9CIBFSt9Z/kOTOLyGHWmt2dYR/tvkEZZr5Et+GD
         L+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVuPQePcBp9QjGDBOwWC+1Q8K5BrKm2hZJUNCf6ILF2FVQKP3JEopoWNyqoa+QRXUNZJwzBHitC+l7PBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz7vWT2zTLKw0c9/zorNN7jYfql5R4vNO1U2Ik3Nu4QETEvJkB
	Uh4zgVw9aYeL4RAG5SwzLVYWTlLgNKEEX9v6vvdzyyoOdn5dotqPx8KuFFEopcNs
X-Gm-Gg: ASbGncsnOv/N8Y55NUDtPJGn/z1hTV4iLX8IfvLJgiF8Y5aKxMU2CA8vE1Y8+gbjSkW
	7IjHZPO4SkkCJDJ2lIljNpDrENbGLO2xLQKWRXMw++z+GTmW4kEBoimE3dhwk+q4HlpmjYG5yIG
	mYZGEmbXdS4UYBgKBLMVvp589G7EVK7rz8Wkura5yTrMqCSRGsN78qDUq3m6PTXQk7WkXSlnhJf
	etmXEOsty6cDfn5OYp3Chs0aUUxYzj1oIbT2A5oXNqrAUNXmeVBHny1Wgom6lowEZ1TTvtDHPrA
	Q2P70Elwp1RDvZvzYwpxqSqEN+Ghg3fQ9pV57fHrISwIQQTl6xa40000aKtZ8DEcb6E9NVXJ3Q=
	=
X-Google-Smtp-Source: AGHT+IEKjCk+qKWLdmbwACmaZE18dwte8o4reeaqq8eLHOvAEssjfMOfLwxywKavDMqMJw2xoVA1Yg==
X-Received: by 2002:a05:6a00:3c89:b0:742:9cdc:5cbd with SMTP id d2e1a72fcca58-742a98abc68mr22936553b3a.17.1747798071258;
        Tue, 20 May 2025 20:27:51 -0700 (PDT)
Received: from koga-vm2.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98770c2sm8677379b3a.150.2025.05.20.20.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 20:27:50 -0700 (PDT)
From: sawara04.o@gmail.com
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: Improve logging for barrier-related operation
Date: Wed, 21 May 2025 12:27:09 +0900
Message-ID: <20250521032713.7552-1-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyoji Ogasawara <sawara04.o@gmail.com>

This patch series improves logging related to barrier operations.

The first patch raises the log level for the "nobarrier" to better
reflect the associated risk.

The second patch fixes an incorrect log message that could cause
confusion.

Kyoji Ogasawara (2):
  btrfs: Raise nobarrier log level to warn
  btrfs: Fix incorrect log message related barrier

 fs/btrfs/super.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.49.0


