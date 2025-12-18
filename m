Return-Path: <linux-btrfs+bounces-19862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11089CCD457
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 19:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C141D302C5D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 18:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67DA313541;
	Thu, 18 Dec 2025 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3yxV3VY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CF308F38;
	Thu, 18 Dec 2025 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083883; cv=none; b=Rpldvei83KOyAasnSZZQbAY/foC5hsdV2wfi+Wf2JaLPDbXWrZvTNiBSnk+h4UbP756ZMHI7sSHLKBFGonS4AfvlhHl5A6RUJbay893HKBEXJRRQToYfruW+m6EYqKNe3AQGQdXwEjQSoOf6imtOJGE7Ejt9fx6S0fLj0vWkTao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083883; c=relaxed/simple;
	bh=thjKrci90DOEocQ/rS1/i+0kk0jw1nCk4eiI3odlwtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbTH14HJHEC6yQzhbHsb2W8JneSZsi5o1hI7fktO7+3k9Wh/BqObP/oIT7OlGKXt7ahNXxALgAyz884fVbcwTAXnNsArtdAvCvF1IIu5G3tf1BjYkHfv8SXqsQaoPKU1jf7Mj6V+6R4Q726x0rCqZXaOxHGULoxeRGWLzfKAqe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3yxV3VY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E00DC4CEFB;
	Thu, 18 Dec 2025 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766083883;
	bh=thjKrci90DOEocQ/rS1/i+0kk0jw1nCk4eiI3odlwtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E3yxV3VY4hw24X9BzuHN50F7estKLZMSBxdEf8vkYlsezUev+K71iClCx9ajSj89D
	 vXuo0DpMtnBT2r6/NaQponQBdWM7rkpFr5Y9J6hAhuWl8Fpykr7Ak6MvYdoJ7qZ9R2
	 o8VZKhrsbvrCNbQ865dfDYKgoADMYzlttAFfF484rqgyMrOxvIne8H9PIEMxTNe2yN
	 gfTTDHJd0LhEA2cxkEfydKG/XLAU790laxmMMmMu1bGCWeA/X1uYGli3K0vfAQW57m
	 CL2EHISIf+epUVFJWnLT3cfwfnV3wpH2VmdXsXuL8uTCfx1mWfTBvU8EQ/cJe1/1ob
	 KC6nMh8XtzM2Q==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 18 Dec 2025 19:50:02 +0100
Subject: [PATCH 2/2] kbuild: cleanup local -Wno-type-limits exceptions
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-remove_wtype-limits-v1-2-735417536787@kernel.org>
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
In-Reply-To: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=thjKrci90DOEocQ/rS1/i+0kk0jw1nCk4eiI3odlwtM=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkuvuJ8x/mLPlRs/htqPvPzRfW4F6uZr5fOYqyt/lSva
 l7HZqHWMZGFQYyLwVJMkWVZOSe3Qkehd9ihv5Ywc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ6h
 oQ6QycDFKQBTfaiLkWHiwaMMpQddj6e7v/h6JG8Ca3m+bHoTB2/1tRbpJ2ucF0owMny+teOPMsP
 BbUsmcqQ9nLXVYcqjdI1lrFqLr8/UczhkYM4IAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Now that -Wno-type-limits is globally deactivated, there is no need
for local exceptions anymore.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/gpu/drm/Makefile | 1 -
 fs/btrfs/Makefile        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 0e1c668b46d2..b879a60ca79a 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -22,7 +22,6 @@ subdir-ccflags-y += $(call cc-option, -Wstringop-truncation)
 # The following turn off the warnings enabled by -Wextra
 ifeq ($(findstring 2, $(KBUILD_EXTRA_WARN)),)
 subdir-ccflags-y += -Wno-missing-field-initializers
-subdir-ccflags-y += -Wno-type-limits
 subdir-ccflags-y += -Wno-shift-negative-value
 endif
 ifeq ($(findstring 3, $(KBUILD_EXTRA_WARN)),)
diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 743d7677b175..40bc2f7e6f6b 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -17,7 +17,6 @@ subdir-ccflags-y += $(condflags)
 # The following turn off the warnings enabled by -Wextra
 subdir-ccflags-y += -Wno-missing-field-initializers
 subdir-ccflags-y += -Wno-sign-compare
-subdir-ccflags-y += -Wno-type-limits
 subdir-ccflags-y += -Wno-shift-negative-value
 
 obj-$(CONFIG_BTRFS_FS) := btrfs.o

-- 
2.51.2


