Return-Path: <linux-btrfs+bounces-3427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B478802C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B061F2346E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12F1179A6;
	Tue, 19 Mar 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ylrLZbO1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E32107B2
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867370; cv=none; b=YZqhSLXTUVMmLzT2OzkFWHDQbyHzM9eiARDZ/gunVQiPe5qExAZ9kIZtZKchoovgv3uRk22VrGOqQfTKoMtChaIbnr0vna5NCgP2AKcm+v+azn3O7VB2e0ht8kGKHooMBZ7o9PPZw2xCBwZnyw67hbgat6WDolColE0+EhNE++U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867370; c=relaxed/simple;
	bh=qA72Tz+8tuNZU/4QviNvrzVvbKhLu3y78NAdl4BMYFs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMZOh0OMX5FuhrXOZBJHzIuHAJqQWjg4KEgztnrdM1nNC448nvejvye+wR0QfW4GI4FKqjEhYecmwAWCvbsq6vtqbPX7OuCbNP5Yeb8CcUKv1VqZq2tGpj2F/BsinKzm2t/ai7WQm4SyRzK2vnQGn1j+bwOIl8sTHooK3vT5lzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ylrLZbO1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430c76fbf05so16833621cf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710867366; x=1711472166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBbs+iA1l2yOBOmVBbjTGQGF+IQD6umOZ/ZP4nOCnC0=;
        b=ylrLZbO1RZn1P9HsswUoMKa55AXU8IVZgQp+63KB3YP2l8AxYz92P7fR9ElMjGJMxS
         +t+MJFE0Y+sg8cHlKHIS2QwBvjFEAkRd6siQdcfAE+OfkNcXJZPDh/m9DkY+4Tgply53
         TZVPGDmv+XqTIiX1D9HK4gE7fEHT5WyOaT4Pf4cWfT27GhjHn8u9DzT/jGolMeMqbFNg
         yV7lfOFsI5aCk7NRrilz9sOpuy4DpY87ohv019+VAQd32taUEqdr7egp8ba0MslcY6oK
         kw+Ur/O7OsBOlOCOG39LbAhzahRlOpTkjHcr1pmUEzgY47BTtiUB0LaOO4xc7AJMuGRB
         X0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867366; x=1711472166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBbs+iA1l2yOBOmVBbjTGQGF+IQD6umOZ/ZP4nOCnC0=;
        b=nk99IV+TiGgS76br7kkoH9LTOkldT1NNOogo4+FnDVv3BRiChdaDRJtGFHhar8EK2+
         S6d/AyCF8fdffiRJ6/wIEUPngF4NJR1LyFyChcdMdN63v0NLLN3mQd2EvXATS8lsniki
         l/bdGlxyX8zI2Nh08B0VpNXHMXye7iFWr+2e8r+JxScfTgmALB6q9WtPY5fEdIVM6yUR
         T4eij7BDh17Pw8LNINQYUx+V3ohFLBoG6ulRLb0DtKKfI6nlHsBphvXrVCgnkqmoj76R
         2VXvrGja+Fnk22DZk2qEm7X7cbYpxx/3z7a2s4hi1Y/S/fkESq7rl22L2Ir2vUVLCYiA
         ThTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcv8BkaR10nXyZH21oe+jVEqvr7ayqSSg8Hoj+d2VJjJKUMNs6TK+CT4ay1ROBFlaUONjJYuw3faq5V7rq6dPZQAc3EIg71rA7Isc=
X-Gm-Message-State: AOJu0YxkDZjlzFVP8fz6DGWgIWBWrxk7Vc3rmDVTMyNcLmPN6DBgFvgq
	Hvs2YMWbxkBRa2nHJKiHKEGFh/3FUkfQsZWi2KHzkHz9tNSDNfDJ+/Fx7YaXBoY=
X-Google-Smtp-Source: AGHT+IHLbkAjOlEgHCvWBkN/yrjOXV5/P5CAREiswnR3MUxogQRQ6+dQkFpm/qDqUfx8MPm4hiI55Q==
X-Received: by 2002:a05:622a:14cc:b0:430:a7c3:be9d with SMTP id u12-20020a05622a14cc00b00430a7c3be9dmr3190521qtx.3.1710867366063;
        Tue, 19 Mar 2024 09:56:06 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fj5-20020a05622a550500b00430b423f06csm4837298qtb.86.2024.03.19.09.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:56:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/3] fstests: check btrfs profile configs before allowing raid56
Date: Tue, 19 Mar 2024 12:55:56 -0400
Message-ID: <65177ca9d943c043f88d8ea034d1e625af3d0e58.1710867187.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710867187.git.josef@toxicpanda.com>
References: <cover.1710867187.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some of our tests we have

_require_btrfs_fs_feature raid56

to make sure the raid56 support is loaded in the kernel.  However this
isn't the only limiting factor, we can have only zoned devices which we
already check for, but we could also have BTRFS_PROFILE_CONFIGS set
without raid5 or raid6 as an option.  Fix this by simply checking the
profile as appropriate and skip running the test if we're missing raid5
or raid6 in our profile settings.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/btrfs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index b0f7f095..d9b01a48 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -111,8 +111,12 @@ _require_btrfs_fs_feature()
 		_notrun "Feature $feat not supported by the available btrfs version"
 
 	if [ $feat = "raid56" ]; then
-		# Zoned btrfs only supports SINGLE profile
-		_require_non_zoned_device "${SCRATCH_DEV}"
+		# Make sure it's in our supported configs as well
+		_btrfs_get_profile_configs
+		if [[ ! "${_btrfs_profile_configs[@]}" =~ "raid5" ]] ||
+		   [[ ! "${_btrfs_profile_configs[@]}" =~ "raid6" ]]; then
+			_notrun "raid56 excluded from profile configs"
+		fi
 	fi
 }
 
-- 
2.43.0


