Return-Path: <linux-btrfs+bounces-19908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE35DCD2223
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 23:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9983930ACAF3
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 22:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2803D2C0F6E;
	Fri, 19 Dec 2025 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYyUrRMm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B428DB76;
	Fri, 19 Dec 2025 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766184031; cv=none; b=DgLqjYs27z215YlDKEzB7Uh/op8PUxtzjTEuVKQxA/zDFmuLs0bGmvOCHPoEj6dll1Ssf5qdYTVeXs6wBhqY3Wn/dP0wyCzZTg2LEBGlI/FvG7r0IOBz/Q0g6CohTg23KJgML3ylZfueum1cKuWD4Z6tujZtHCZbeEqtbRdkAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766184031; c=relaxed/simple;
	bh=CH51omHx3p6qsRzlcGdmz4sS4fZYMW+MUawnsQlkKh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=edXD21bIkK8cd8YqIRjrohT9UoMJanSdhb2ZrW4UKWT9txDYggvOs2WiM+tFop5fh1oxHFD3iBlXnQ9QlJ2Cm5mSFEs2yNpcC44fB092GfoDxVCJTN395pmUZXgMx4rd8VfszO6Q4jA0uEVSGFy2Md4NT28MYzISafrAypMY458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYyUrRMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4C0C4CEF1;
	Fri, 19 Dec 2025 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766184031;
	bh=CH51omHx3p6qsRzlcGdmz4sS4fZYMW+MUawnsQlkKh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UYyUrRMmjNfCsp7IYNkf2GE3GqsLbe/e6MI4dGs0mkTAGMNlroOfNKjchxfRho3eN
	 U0Z6I5DBdmyOcwXb6dHzgLkGBfLnjZlX1d4HSxAQmdoQWNJIEjj++enKKTvImVPJ7O
	 88EvzRC+HEgvdw4uMY7cg145wzDADRZ/KVU3T8Z4RMtunlavbu431/fY/vLLgJpfa2
	 tWVwfxcTyTHbIzoXQxPqhGW/XEZu0NPqbLGXwIn6c8E/hrhGU0kZRPUbkPkNYPBhDv
	 hPK/5kMT6R8yf+usvTRELgXJGyor+GfBx3ZR1dwy12RaGV54UK87jzghOaezPAx/M2
	 zvno1rWPPLYKw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Fri, 19 Dec 2025 23:39:46 +0100
Subject: [PATCH v2 2/4] kbuild: cleanup local -Wno-type-limits exceptions
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-remove_wtype-limits-v2-2-2e92b3f566c5@kernel.org>
References: <20251219-remove_wtype-limits-v2-0-2e92b3f566c5@kernel.org>
In-Reply-To: <20251219-remove_wtype-limits-v2-0-2e92b3f566c5@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=CH51omHx3p6qsRzlcGdmz4sS4fZYMW+MUawnsQlkKh8=;
 b=kA0DAAoW0WQ+QNd/fbMByyZiAGlF1EOjMOByv0n126NSjwuXg8j/IxssPc9TKnxzsAAq/pe6F
 4iRBAAWCgA5FiEEpncJCyCIcUtWwv050WQ+QNd/fbMFAmlF1EMbFIAAAAAABAAObWFudTIsMi41
 KzEuMTEsMiwyAAoJENFkPkDXf32zwuQBALphDSFKpPBiTOKEVIuE94/+YEsRmjpYZiMQ7lDD4SW
 QAP9FGUN45c8n3tmPLKYM4wGNk16iKXQ0rB7Uoj4K7KqLCQ==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Now that -Wtype-limits is globally deactivated, there is no need for
local exceptions anymore.

Acked-by: David Sterba <dsterba@suse.com>
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

  v1 -> v2: small change in patch description
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


