Return-Path: <linux-btrfs+bounces-16248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA9FB3070B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19541D274C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE8C3932AA;
	Thu, 21 Aug 2025 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KZ4kpj0e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D27392A6A
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807690; cv=none; b=YoY/rX7G4bmxLv0Hy9FR26LyYTa2nAagjGmHlJpAh36JFiVtOvJ/vSob+Ks68LdKfpdfxDn/C98Tr6sVu9Jhe53S80NrHPvSpraM1KEMboHH/IlMhIOett6RpXceq3nC9fQrDZj1suL8WpSiZdKrTGUVDs4gE5pnmADJQsYIdmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807690; c=relaxed/simple;
	bh=MRbjz58EJk2DIV/CMfsuQeru3Gjlj5upRwbvX0t3mqA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zv0WoGp9ya4iKDJ8kXFwwsO/pPhN8bHmTw7KgX64XUhlx/lny/NhVQ4JeKLeT7wBmxzHBUpEO5RM18OeNZcZidphwFgd2dp41E+H2upDYkLBfhH5aq4bnZX4NxSzIeDZHK8ST6J17cjojqsOnhs7WWcDA3hHOhJLBI3wv1YITHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KZ4kpj0e; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d6051aeafso12625837b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807688; x=1756412488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6Y2vCrhkZTJ22Wp+VyocA6nDD0iA/acEwKo6i4LTMQ=;
        b=KZ4kpj0e+2nHxJkJfRRElwV/CGxxfwb2mzTyZ/Eo4Wk1OAJv0kQBcEsMBjZN+B0xk7
         sygR3Edm5/gldHlW/wGto0rv6MSQMWQrJDTvSm4AsOGnxGc438pY1862gpqlPHPUdxpQ
         PA9z0x5e4/bync/fbeLJ3FKHvBu7mCwEQvclxtHb5Pa/q2jJ5Lj++uQ3KgWqBMeJRB6U
         cbvfdzfaRx0duO7M1xJfBAA8lhgO9DriMnTJCA/E6hGVbK+QWsbhtNhhXdOSsjyqscfW
         RJT9eyGl3zevXuUhq/MBf839M4AeyOEFsU83Q9QpeqkqZInfNiv1nOh7EGTs9dG+28dw
         YSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807688; x=1756412488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6Y2vCrhkZTJ22Wp+VyocA6nDD0iA/acEwKo6i4LTMQ=;
        b=d5VvNA5HMafmfR+z0Lchnvm1lc7b7UEuJvShQBZPnSaLaaYkbRST2tl+R1pU0HB5yj
         m5TKwOoJPZMtYLFQvJ6E/iLeM2Hi3cXCe9rjJY31QBu61amlLDfxJMsySDZeO2GSDofo
         KUAeP5nz8vHfb/PTPl1qQa3qSj8IkEKdJGRCkwoz/JfNq03vH3xRhgymiQHCyclEBAk+
         XlQcAfj7PsI2e3x+OZf3zJQSR0GmCV5T4R5xLN+mSdiXEV6QFouTAsypPD4bw3z0CnCX
         DphvsTOXFTcZoe2C3CiW92r19shSz6AQxM09sKw1WZLyLz2ARw7d4PoAvCVRzXvobtXh
         bgQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO9gWXYJfwf6istbnwLVGz4cPjJ4qlPJqISzJi1OPzSAdP0PeTRKl5L23KpaomtJLbp7Tp+i1gq+gN6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKk9iydqZZEaP3vEmr2DxQ+8SCeVzb91nfkTICizNO67LkHYVl
	UuV0rw+DxZSo4Unz/M0P7xIW2ynpMANDfzGHScIw8opqQTCfCP0UjqOPWDVtdjMD838=
X-Gm-Gg: ASbGnctMSFzWNM1t7TfbAlJghmxCh8Tc0u22zg2Jgnn1c5AueFmfrpvHP7Y0rmQ7Z19
	WBowZoKfvA/27he4gYz3Jp7BB/r3HuXu/61WV7XT/nhPROr++pFL4de3JCEW5ZunPkTK6itfxtF
	Yv0EyRA+/F4vqg6UavumiRwIkXUBHfFZEk6ER3FHqr6dAPKn+bSBTWK6C/4Z5Ddzxl2jmBGcJsy
	wcBM/NwBEl94hwH6919LydmanY4RCdD/qsuosD7ZSIuW93ZicutfEij8QgmnkmMQva1Xl+l8hGd
	i9eLPWIzQl6GWVbkiQj7DEX5bfz+Ukqfz9XSkCyz7TeRALlNbZpg6J166CDjNUpjLdK2CKH3Kzg
	Ge7AQtSbrjj/nQzXDuKhuUU+PDYeAt4v58bX5qPl8sEdPmXGUFpSWm8Z4L/w=
X-Google-Smtp-Source: AGHT+IHKd05hnDdE6pxXbgnF50bB6qaOk+UowOaZiUTYV+EFuPk1zkORqkQfdOZSuLjXIecq80ZgtQ==
X-Received: by 2002:a05:690c:6211:b0:71e:814e:c2d4 with SMTP id 00721157ae682-71fdc312ff5mr7198057b3.23.1755807688184;
        Thu, 21 Aug 2025 13:21:28 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e107145sm46178057b3.70.2025.08.21.13.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 47/50] xfs: remove reference to I_FREEING|I_WILL_FREE
Date: Thu, 21 Aug 2025 16:18:58 -0400
Message-ID: <2d12a5a95496c71929b90c298bab06fdd81d75d8.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs already is using igrab which will do the correct thing, simply
remove the reference to these flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/scrub/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 2ef7742be7d3..b0bb40490493 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1086,8 +1086,7 @@ xchk_install_handle_inode(
 
 /*
  * Install an already-referenced inode for scrubbing.  Get our own reference to
- * the inode to make disposal simpler.  The inode must not be in I_FREEING or
- * I_WILL_FREE state!
+ * the inode to make disposal simpler.  The inode must be live.
  */
 int
 xchk_install_live_inode(
-- 
2.49.0


