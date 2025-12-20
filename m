Return-Path: <linux-btrfs+bounces-19919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C42D2CD2DC4
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 12:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A878301DE29
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 11:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62C430AD02;
	Sat, 20 Dec 2025 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3y9ecv7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE8224240;
	Sat, 20 Dec 2025 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766228601; cv=none; b=Mvhh2Hmdf3jk5yvxvpZTm2ydYuqmq1iuRlBOLlOmxuWdQkj/2DzKqDy41ZRmJlVeDX4726Q1w4D2P4Q1DTV2HM2yw4VHzi/p5rirTWvgHu/YEnZ3JdhLKKs6M908mvg4/PxGlMmRfi1Dhayk0UFnh1kPp2g+tAWMPoAqhpziNf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766228601; c=relaxed/simple;
	bh=CH51omHx3p6qsRzlcGdmz4sS4fZYMW+MUawnsQlkKh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYTdNgIWgel0zWZRsMKQOfhQXd0P7K6qM5Wrig28ABOf7qgd15U1XSd+f0cqHwu2ijbuPl0kVX0WXQ181JxzG9FVqfCNh7FX8jhcOb+ynRWIFaLfHVrD+oM2Q8TtC544P+Xz4YhgYzIsvYQB2OwXOVXnItyz1B07R+wlqoneYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3y9ecv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905DCC4AF09;
	Sat, 20 Dec 2025 11:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766228600;
	bh=CH51omHx3p6qsRzlcGdmz4sS4fZYMW+MUawnsQlkKh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i3y9ecv7bvRQk3YtF39GlefNaX3OsbHoy5nLsuWeL6PK/UBqH1hpdQIBkM7L1cpkR
	 0MgQZKsRV8qlsdWBp88FtLtxyeZ/OAzTcnkkvsM/lceYvf36X8K1Sxq212pptnhY0c
	 3jmBhS1DnfaMmRL/vpR1UDnKFWfKYMxaVF/C8gEMKJbsYWcJCxQCQVYwDLcXHozWmS
	 YS8tjzAwltomC7xfC16XuIYZAEjsXQtxtDcze9cz26Sh9RDO1RKemmsZAwNKZYd2cd
	 SlGT0920qYU5dWeF2MbvX5C1PY3mmvaAaRI2g6zUO8UxTv/1hg2N/YoEB4Bttv7aw1
	 +W+14yTrcjEbg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sat, 20 Dec 2025 12:02:20 +0100
Subject: [PATCH v3 2/3] kbuild: cleanup local -Wno-type-limits exceptions
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-remove_wtype-limits-v3-2-24b170af700e@kernel.org>
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
In-Reply-To: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
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
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJluTfGt60/e33Q355CkRrPV9k+JlVOaP/FKlmXMDF/b2
 mo7+caVjoksDGJcDJZiiizLyjm5FToKvcMO/bWEmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 DXWATAYuTgGY6n0RjAw776t6N/8vXK+pLbv8i8KtLY76jD2bZfnS0p5+XLJYrfMAw/+cjRsOWO5
 RWDQ3KGPOqaUL1jnXqB00sUopmnZYJGfRQSl+AA==
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


