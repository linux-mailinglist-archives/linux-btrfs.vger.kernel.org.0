Return-Path: <linux-btrfs+bounces-20069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1F9CED1D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 01 Jan 2026 16:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAC4B3021E7E
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jan 2026 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C1B2DE70B;
	Thu,  1 Jan 2026 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGqcmwLV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17D42DCBF4;
	Thu,  1 Jan 2026 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767280932; cv=none; b=tmNE2oRG6UHvUXai2iNLtdzGKw96YAkg2S8GA4RgLgxF9boVn7Qu4SGLHRAuCdQ3Y7beZ3h1/36dG6Zzf25pZN7L1Cn7iM7vd7VMfscRdju76xotgEabeuWSap+nv0FWEg7naP3B70oM9pj2f565Man8kwqjlvUfwYZi6lMlR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767280932; c=relaxed/simple;
	bh=mIhQkcwbxHiDGbqkIpgQI8IR3rwmgawWbN+IVj32UUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L8c4Csfm8JA+/gZjeQtWoCtcw8UeDJZusf79m9pRPCdk9DhY+4M18cuY1R6dgPnY3UxYmWj8iiDatRrPUDZOC34eYovU/77hWf4LFXGa8FW5CxlgYsJZLH7uC2Q9v+lH0uwB4Xy1XX1RVryEV2zEzjAjpCQR229kMts3Ux0QXPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGqcmwLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB30C19421;
	Thu,  1 Jan 2026 15:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767280931;
	bh=mIhQkcwbxHiDGbqkIpgQI8IR3rwmgawWbN+IVj32UUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kGqcmwLV7Ca8pob+S+kw7LGUFHbGytU1VCH0dL6/wWPfp0iy/bf+Px9uL8SKguBXN
	 3xA3qQMHp2XmmYnMEr16+BC38K5DNn/lSPBlhtLmGICsPIV+2ZClFydcg78x10VRci
	 InQV9sb8stN0QoRv/lJ+sefAIVAbtia3CQSwW6t4yjZjftMMyuC9pjmqVAL9IW7Gzd
	 tM1CPTVb6OIIR0ode4i6/ZgdHinRHmWnWDi1JO/PKI58t3/WIdTA7PftGELwGr20i3
	 rVYdKeGoWjMgerYaoi444pDmhXGYXxSSOr0UW6QJqg4BYTjmOOkBQtMtrm1o0Hihtr
	 3qpNd61NbZ7cw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 01 Jan 2026 16:21:40 +0100
Subject: [PATCH v4 2/2] kbuild: cleanup local -Wno-type-limits exceptions
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-remove_wtype-limits-v4-2-225b75c29086@kernel.org>
References: <20260101-remove_wtype-limits-v4-0-225b75c29086@kernel.org>
In-Reply-To: <20260101-remove_wtype-limits-v4-0-225b75c29086@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=mIhQkcwbxHiDGbqkIpgQI8IR3rwmgawWbN+IVj32UUs=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJlhE3mrlDPMGDaIXHSKZGlJkn9skCQg7toTo82q/yzg7
 4KDe/Q7JrIwiHExWIopsiwr5+RW6Cj0Djv01xJmDisTyBBpkQYGIGBh4MtNzCs10jHSM9U21DM0
 1AEyGbg4BWCqnfUY/mecfnenflaxkYSDPVd8NMfZjSuW5708HvG/hOen+0K9H98Y/kcvy5iQ//p
 zdKGbczX72k6b2XfD69WqygV2xl7tq034zQQA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Now that -Wtype-limits is globally deactivated, there is no need for
local exceptions anymore.

Acked-by: David Sterba <dsterba@suse.com>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
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
2.52.0


