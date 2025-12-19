Return-Path: <linux-btrfs+bounces-19907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F4ACD220E
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 23:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DCCA309C2C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 22:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AF62D24B7;
	Fri, 19 Dec 2025 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb5vscoD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2857F18FDAF;
	Fri, 19 Dec 2025 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766184025; cv=none; b=gT5wip1ePm6bU4wwG7aBanF6twW6uyzjAlj+Ga1q+s7ZK6Bm1QiDXLNXJ3nw3X0j/xV/H7RY99UTsc6fqfWtIZdQvfIfQtYHIo1iroXvWsG6D3CABcbHCG38LXNjWLmOQQqsEN1T+6XYhMXddwnC4tGlbpN/h+UfqdnR0tlHRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766184025; c=relaxed/simple;
	bh=ap8MRB6u43PIFW27qfddd/82fqc/71rc4wGTDPI7wLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDGbl+klYnDdl1oHvKPp/+ZG71R/M1uGUg6+lfUrcHEg2OnIQAzgvQDFcvG30E6+1m+nDKGmkgpBkQmb7CTIAgXWBwcg/YOVQntssToVNSPIN2Ugavsjaj2HztFhPyYlzNII5vYnSmkePxiqp0iFjBK+05pPuSlQfvKsbB9HFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb5vscoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D82CC113D0;
	Fri, 19 Dec 2025 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766184024;
	bh=ap8MRB6u43PIFW27qfddd/82fqc/71rc4wGTDPI7wLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tb5vscoDw5UPBzWlw7lS7k32m1rdT2wMczjZSevjFzarIQwwZ8OqNpRnd+QJtpD85
	 upPevm3y9OIb2elSe+lEg73VuVA73WinBRg2hPwAk5p1wU8YP6iujSYUVj/PVlcr2F
	 5OMRtIu+bdwC2g3daGLUSNtEowGf/Vps7R6vWdxRsBAefto4/Xy/6ca+VMqjU8isDX
	 9oV3bDFfjNhxWHjoV68T2eXcZhUFNo+NOrTugH5cuyOZFGceW6VbJxuW0wG4a+R7UJ
	 JMBYOoACYCQrfCLuKd77uWKxuKGxCZQz3okCdpIvbLSx5Z0JaKsqSY1A+vYvqy+HLg
	 v6aVxQuxgPilg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Fri, 19 Dec 2025 23:39:45 +0100
Subject: [PATCH v2 1/4] kbuild: remove gcc's -Wtype-limits
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-remove_wtype-limits-v2-1-2e92b3f566c5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3600; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=ap8MRB6u43PIFW27qfddd/82fqc/71rc4wGTDPI7wLo=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJmuV+xvHvP/qS1XYXPiX433Jz/HroLZBpEzj7qU7tTr5
 /9v8fhsx0QWBjEuBksxRZZl5ZzcCh2F3mGH/lrCzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 hjpAJgMXpwBMtYYvwz+91DtK75VbhTPMdj+PszxxP9BuupS3eOuxc/8aIqavm7mMkWEBt+wHj/D
 9nSprFGdeeSnEpTtxeUrTrRg+f8M3r04nfeEDAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

W=2 builds are heavily polluted by the -Wtype-limits warning.

Here are some W=12 statistics on Linux v6.19-rc1 for an x86_64
defconfig (with just CONFIG_WERROR set to "n") using gcc 14.3.1:

	 Warning name			count	percent
	-------------------------------------------------
	 -Wlogical-op			    2	  0.00 %
	 -Wmaybe-uninitialized		  138	  0.20 %
	 -Wunused-macros		  869	  1.24 %
	 -Wmissing-field-initializers	 1418	  2.02 %
	 -Wshadow			 2234	  3.19 %
	 -Wtype-limits			65378	 93.35 %
	-------------------------------------------------
	 Total				70039	100.00 %

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
2.51.2


