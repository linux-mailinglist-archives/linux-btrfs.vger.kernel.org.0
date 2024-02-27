Return-Path: <linux-btrfs+bounces-2838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85213869086
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 13:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EED928246E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461911474DE;
	Tue, 27 Feb 2024 12:25:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E8813AA47;
	Tue, 27 Feb 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036736; cv=none; b=JNj0N0EbzTlYxkIh+PyeNe7N9sHEpGu+mWFcZHwAIkEmEL0dSkyNQzbx/40HY274Xo7hlWWl09BPJNQR4T5v/LksCNA8PMKDhcn2yjA2bhb4U6xRuS32H6n+iI+dKvExVFqJANHj6Fpalk6W0ZVEOkvXThLrL4lioeNKUU84rio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036736; c=relaxed/simple;
	bh=cXyV73QRFV9H9hjPoogFsl56DiOTGl3fsrws0Rm3xaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LG1Zv6cfDm70GyCTyHkVzDyT/G8SNOyhs93NUE0aHrMMDx5JQXmzsaOJPqRchPxWzUdmmWwoEIexkab2919pRWdRl5RRZeX2zu2Qq8F3OrGA3N9/BtmfyOfQzuanyfd2tqCJW/iaotUkNDnyuE08wymH+sti3rnlNUC/mwABVZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso690714666b.1;
        Tue, 27 Feb 2024 04:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036733; x=1709641533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VubS9gSyHqZkpFHj7uvWsTNv8yVN+0Og+LuVo7tWJCM=;
        b=we+R+kSDJSbgPTjwkMt+kn6q+VWqnPB0MlmjdMu6YtjrupW3VRb+vr8n/FvUw0wha0
         mfby3EbgwE5z9S+9JBdSg/o+MfXei1NroE21azNr9Z5LI+4ro0DlIIC6q5CWZyIKi4Mk
         c2Jh0gJ0E4uxamSGWsOMT7f9JguwUOR4wbkHExUINfuiVXWqbyw/30nX3XxbzTs0USRk
         3t65FmnbXo6E6xp+50AllKefg0YoEPiFMHd9HqNj7FaBcmmPK45wGXYp4Ktk9ZYF1ZRK
         Ykq4IDw7HlzU87Z7Hl2ZDAV/tMjXTUEZ6dEBM6HM1cXFVt0STImvtwUCSxrA428EsOjJ
         HZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCVf9TPQdW+SLO5ISnklSJVlVl4wG+5By3Aro0H4KxYlbXR9/nRHyFzUvZ2FY/XsFnvO9QzqvCv/fzhLYyEFlZaFTWuKUJuFpXsvRZ3xe62fjy4+mlQTybEOAN6oNA4NCcSAABta
X-Gm-Message-State: AOJu0YyDGP3TyPoFT+ybFY63j5xPAE/wHnoXojCEOmzNY/1I9mjHYXf+
	4bK22EY2QVhdM6hbFCX2/nM+p/JELEvrZqlj1Eag9GCaXfqt38ElrWaoxmXESqU=
X-Google-Smtp-Source: AGHT+IEA/0Abcxs8b9gB8E4WsB0tOvnErTLbn2K/QIWYx6WdOzoryky4vdl/pQr0O+DjUubL620Dlw==
X-Received: by 2002:a17:906:579a:b0:a43:2827:9c73 with SMTP id k26-20020a170906579a00b00a4328279c73mr4989652ejq.36.1709036733468;
        Tue, 27 Feb 2024 04:25:33 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id vo14-20020a170907a80e00b00a4136d18988sm721938ejc.36.2024.02.27.04.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:25:33 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 27 Feb 2024 13:25:30 +0100
Subject: [PATCH v4 2/3] filter.btrfs: add filter for btrfs device add
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-balance-fix-v4-2-d22d63972d93@kernel.org>
References: <20240227-balance-fix-v4-0-d22d63972d93@kernel.org>
In-Reply-To: <20240227-balance-fix-v4-0-d22d63972d93@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org, 
 fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a filter for the output of btrfs device add.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/filter.btrfs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index ea76e729..9ef96761 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -147,5 +147,14 @@ _filter_balance_convert()
 	_filter_scratch | \
 	sed -e "s/relocate [0-9]\+ out of [0-9]\+ chunks/relocate X out of X chunks/g"
 }
+
+# filter output of "btrfs device add"
+_filter_device_add()
+{
+	_filter_scratch | _filter_scratch_pool | \
+	sed -e "/Resetting device zones SCRATCH_DEV ([0-9]\+/d"
+
+}
+
 # make sure this script returns success
 /bin/true

-- 
2.35.3


