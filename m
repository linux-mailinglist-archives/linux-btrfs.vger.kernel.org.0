Return-Path: <linux-btrfs+bounces-20068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E63BCED1C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 01 Jan 2026 16:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84A693005BAD
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jan 2026 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114382DE702;
	Thu,  1 Jan 2026 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/3e3ZpQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3902DCBFD;
	Thu,  1 Jan 2026 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767280925; cv=none; b=UkMASafe9aveKE/kC1faCBZrjipgqfj6Rvifwk8oV4tZLoteP7dTWyDIEU2XQvJycA9UE9Q3uuhWC/uwqx3waM6ejbpARASDAEw8z39qEOOLmwkq8EJwwOziV1qWZzwcszjjsuniDCz9j+UE84UkcT/KSaqo6iaF6TTsm+u4VIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767280925; c=relaxed/simple;
	bh=L+uMcFhjvgNyaeKoo+9WcKmnqk3eMvHpQewGikkzPuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmqfSrPeNQ+Hv90+oBInB6GSKO0eQ7LWBHAUo2H62KcTZCqMGqVzBffowvI5l4CbKC0qVauiJ5I9G56JaeF4DkLTakdbVZir4uIV8uvvDXAFbfNqFcYunAzYZqW9lV/iR2JhC1LvwlSI3Ouz+sVyyXEQZ7ncFlEViI6wms/XHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/3e3ZpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE792C16AAE;
	Thu,  1 Jan 2026 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767280924;
	bh=L+uMcFhjvgNyaeKoo+9WcKmnqk3eMvHpQewGikkzPuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k/3e3ZpQNXkmDxal4dOvHVtc7tbrCRLO+7ypgLtqebvCI/BQt7qTGL1UxkaAR9BDA
	 4laUXmIyBFe8vDmU/f4/9wh/iZ5nFroGXX8fLOhgOmWos/ExRCVcoKJm9uAfdstQj2
	 ZUSk1PMAeGyThh8dYLVvVch21+X3b2FfOCB3lssYaSBcR2rwhylI9EChm6GSC+WraX
	 bSAxaU1bcbcL529nm/uUmKX/XMLZLKjDg0k0SQBVoMgkRPLBzpR9iOZuENZp9x3AWF
	 xuhTaVUx/foNN/z0+wodNhCLOKCsfbxqfYuTph5SXFvbeyhFFeXzlQaT4i7eOao0pK
	 CQ3gZCbUiMxMw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 01 Jan 2026 16:21:39 +0100
Subject: [PATCH v4 1/2] kbuild: remove gcc's -Wtype-limits
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-remove_wtype-limits-v4-1-225b75c29086@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3691; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=L+uMcFhjvgNyaeKoo+9WcKmnqk3eMvHpQewGikkzPuY=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJlhE7lSzaLi5zN8Swy7+C5VRvDilhkrfUs7FjKYF4arq
 +xa+oGnYyILgxgXg6WYIsuyck5uhY5C77BDfy1h5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 Qx0gk4GLUwCm2nAFwx++4K5fJdbcIaKGrhPe/WA/kMtUFNofwK3y0f54Wvv3wusM/xQ3ljT5OPK
 aiJcyuJ7sf+FYdHzCvJfVT0tuJuyc+tZtIwMA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

W=2 builds are heavily polluted by the -Wtype-limits warning.

Here are some W=12 statistics on Linux v6.19-rc3 for an x86_64
defconfig (with just CONFIG_WERROR set to "n") using gcc 15.2.1:

	 Warning name			count	percent
	-------------------------------------------------
	 -Wlogical-op			    2	  0.00 %
	 -Wmaybe-uninitialized		  139	  0.20 %
	 -Wunused-macros		  869	  1.24 %
	 -Wmissing-field-initializers	 1418	  2.02 %
	 -Wshadow			 2234	  3.19 %
	 -Wtype-limits			65378	 93.35 %
	-------------------------------------------------
	 Total				70040	100.00 %

As we can see, -Wtype-limits represents the vast majority of all
warnings. The reason behind this is that these warnings appear in
some common header files, meaning that some unique warnings are
repeated tens of thousands of times (once per header inclusion).

Add to this the fact that each warning is coupled with a dozen lines
detailing some macro expansion. The end result is that the W=2 output
is just too bloated and painful to use.

Three years ago, I proposed in [1] modifying one such header to
silence that noise. Because the code was not faulty, Linus rejected
the idea and instead suggested simply removing that warning.

At that time, I could not bring myself to send such a patch because,
despite its problems, -Wtype-limits would still catch the below bug:

	unsigned int ret;

	ret = check();
	if (ret < 0)
		error();

Meanwhile, based on another suggestion from Linus, I added a new check
to sparse [2] that would catch the above bug without the useless spam.

With this, remove gcc's -Wtype-limits. People who still want to catch
incorrect comparisons between unsigned integers and zero can now use
sparse instead.

On a side note, clang also has a -Wtype-limits warning but:

  * it is not enabled in the kernel at the moment because, contrary to
    gcc, clang did not include it under -Wextra.

  * it does not warn if the code results from a macro expansion. So,
    if activated, it would not cause as much spam as gcc does.

  * -Wtype-limits is split into four sub-warnings [3] meaning that if
    it were to be activated, we could select which one to keep.

So there is no present need to explicitly disable -Wtype-limits in
clang.

[1] linux/bits.h: GENMASK_INPUT_CHECK: reduce W=2 noise by 31% treewide
Link: https://lore.kernel.org/all/20220308141201.2343757-1-mailhol.vincent@wanadoo.fr/

[2] Warn about "unsigned value that used to be signed against zero"
Link: https://lore.kernel.org/all/20250921061337.3047616-1-mailhol@kernel.org/

[3] clang's -Wtype-limits
Link: https://clang.llvm.org/docs/DiagnosticsReference.html#wtype-limits

Reviewed-by: Nicolas Schier <nsc@kernel.org>
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
**Changelog**

v3 -> v4:

  - Update the statistics from v6.19-rc1 to v6.19-rc3.
---
 scripts/Makefile.warn | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.warn b/scripts/Makefile.warn
index 68e6fafcb80c..c593ab1257de 100644
--- a/scripts/Makefile.warn
+++ b/scripts/Makefile.warn
@@ -55,6 +55,9 @@ else
 KBUILD_CFLAGS += -Wno-main
 endif
 
+# Too noisy on range checks and in macros handling both signed and unsigned.
+KBUILD_CFLAGS += -Wno-type-limits
+
 # These result in bogus false positives
 KBUILD_CFLAGS += $(call cc-option, -Wno-dangling-pointer)
 
@@ -174,7 +177,6 @@ else
 
 # The following turn off the warnings enabled by -Wextra
 KBUILD_CFLAGS += -Wno-missing-field-initializers
-KBUILD_CFLAGS += -Wno-type-limits
 KBUILD_CFLAGS += -Wno-shift-negative-value
 
 ifdef CONFIG_CC_IS_CLANG

-- 
2.52.0


