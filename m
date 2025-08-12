Return-Path: <linux-btrfs+bounces-16024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE81B22AB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 16:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE153AFE17
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 14:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF7E2E8895;
	Tue, 12 Aug 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VbdZr/97"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF362D46B1
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008974; cv=none; b=gKWXMv4WUxsYkcCVovnJiYuacfeGCmltTAH+B3hNPpw2cPhZHymfNn9o39By6K+MNgUqdduz49l5tg+OOV4pNS0mUQ1m9t4YSsdzGXIIRqembpiA/mc6RxaH5mtMICz1cz45i9IjKcBgi6eGhmvAc7QoaZLeBH31hu8qimUr0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008974; c=relaxed/simple;
	bh=hdCEU7Mzso1IzaQu4c+7M23NvH+TYeTeC/91CCEpUVk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kjSDeLPzgiJvZPRUBG0HcsUEQWBmkjnRI060FbSOdzd0Q1i0qVcXsqCCDnXTQwdv0PKtDKbO8U3Wzl2vCdluAve3oNG2v1tjRaDqLlknQjvDTpdSC9fWIU7oszwvEREYLljHI9+FuyqWtDv533N7CsPV/AI3N3hGSQtAG8uy/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VbdZr/97; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-718389fb988so55813697b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755008971; x=1755613771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GIWqSH0Hh43yFso7Zw4LnKg2Q0y9W8XE8TYQL0WCY14=;
        b=VbdZr/97EEjZullhNa7vALt7VhTySg2Uoks42/oTbrmsxOogw4ztfg18HPtTzpqCVu
         xO3T5QkZog0kaXqPTfxDYjMRKrfWysqsw3BkoaZjK+8fNIc+N+xsr85OexEEDS26T5uC
         kCCxvsF7wYjyq3KlHDmZetYMLczXDMJUZYv79JlPnFD+jLD9mqhOXQLwHlIWo5hApIaL
         sLcvf7O5NwHR2efSLOAsqqF2nUKoV98PoB2+tSg7okMVjy7iIbfYPpOoGr6La92TYHWu
         cAkzYykoh+mDtpyjhyd9gXLsY9WwEVr48fU+LLelzTbo08P/DfETHckYlbRBdDztnBia
         51hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755008971; x=1755613771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIWqSH0Hh43yFso7Zw4LnKg2Q0y9W8XE8TYQL0WCY14=;
        b=v+fz8bhwBUADUssINEkDMZw2k89mRnPQb4iB6EyrEbFK1rlap56R95UoRMoKQc6nsd
         KcLdLQxY8pjZWuJ2scG5qG1alCp0a9bOHn0ZFCI/dxVaYpnCsXvsQ9ZOkUR/qilWhmkC
         HCAFHY8xG+WXqmkwwplx56rRYWDV+rAuy3UNVZhQ0SZ8HpBgi1pMGG4Ew6514vGXSEze
         cuRqag7EPgNTpMzrdXPXMhX6B3tRHwOCXyS4DjZLtQmFXAcBc8wdQFmXnb67LBwuk7DI
         yhXbdZjgezOoxiT1FiranZrreyomglDOupxHs3xULIqtEBUArSaaVmJf4J8nvGyonrhe
         N5OA==
X-Gm-Message-State: AOJu0YwSI1x/47AdCrF7J0FxdE15pEzIUgZfklQdBx7Dqd1dRaVL6L/b
	U3b7QJ6OdrV422vwqjKm+z8aNQRm4vDo1PVwzPMu2J9DvhTsQoUT+gpPnK/W5k2m7qdKX5KdXol
	lFNXp9tQ=
X-Gm-Gg: ASbGnctqJF4jYLRVeNdvshQ0GtN2piqhz7E8kcCZHS2ab0PFQzouGRG1Yc9dAmVDfrQ
	VHeE5eK1K+nkkvgxiCDZmxHjMf2/lrVspKIMow8RxqBDlyv1y/uMl3XEO/zI9o3HnuKlqtPDEdU
	OzYICVv6YgFpMul2seKAGFaiqReJVLeGrpnBBBfxCg6a7/lq6OXBB4ezXXD7m5XSR0IcBkz3mge
	GW3q1L6Slgm6RcNU7Sj4sVPxLtFaVkew5kiEbXJUzlqSMBbLoGADA8cN9JKeOR6ngqAvQRqRcBs
	eCHDS6BZ3oKYLHDO5jZyvyamhPuTKh4z40QTBG7J4iFVbKUglaHp9r/irWWaS2AJrjrH83oONQ1
	vNQJlMQ==
X-Google-Smtp-Source: AGHT+IFNVSu/oXXdbgbKfwDY2lPqDHFGBsn6wQjBiJ/eKZoJ4WhLby4pQZONSHZQ8Iv53z7+CmQ3yA==
X-Received: by 2002:a05:690c:708c:b0:71c:4091:3c96 with SMTP id 00721157ae682-71c42a3db5bmr47185817b3.26.1755008970689;
        Tue, 12 Aug 2025 07:29:30 -0700 (PDT)
Received: from localhost ([2603:6081:59f0:8370::176e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5fa3c6sm75785707b3.85.2025.08.12.07.29.29
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:29:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: update MAINTAINERS entry
Date: Tue, 12 Aug 2025 10:29:23 -0400
Message-ID: <6edc186a32ad2bc18b26932b4b5d87b977a55726.1755008933.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an update to reflect reality, not a signal of any seismic
change. Dave Sterba has been the acting maintainer for almost a decade,
I've simply been here as a backstop in case he gets hit by a bus. The
fact is we have a strong and thriving community with any number of more
active developers that can take on that role if it's necessary. I'm
exceedingly happy and proud of the work that Dave has done in keeping us
all in line, and know that if further changes need to be made it'll be
with the development community we've built throughout the lifetime of
btrfs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..cb0e0a324f56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5258,7 +5258,6 @@ F:	drivers/gpio/gpio-bt8xx.c
 
 BTRFS FILE SYSTEM
 M:	Chris Mason <clm@fb.com>
-M:	Josef Bacik <josef@toxicpanda.com>
 M:	David Sterba <dsterba@suse.com>
 L:	linux-btrfs@vger.kernel.org
 S:	Maintained
-- 
2.50.1


