Return-Path: <linux-btrfs+bounces-19918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6213CD2DD0
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 12:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FEB73035D06
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 11:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B1030ACE3;
	Sat, 20 Dec 2025 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSp2z9oh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65C259CBD;
	Sat, 20 Dec 2025 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766228594; cv=none; b=I1TUZBU01k27oGnZvsgnV2y+wQ+rMVCaEzw8V2i9T+IqzldchWU5cFujPlAb/YTLVPdguxi4pJmNLlhd8Nz/60LRHN/HAmCK4tndPvY4Xar/n11vgGMD8WmWRrQKz0bpHIPmaeYYV3eZriKP5u+J7ZEcb0X2WRt3LcM3+GecqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766228594; c=relaxed/simple;
	bh=ap8MRB6u43PIFW27qfddd/82fqc/71rc4wGTDPI7wLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxKHlPTiqvtQG508PPU8Aea0Y6iotW0eXhKVf11oePxTxxk+Uz6a8p0LjVsYk68DjvYZzKYuLUd36OEF6xTOblpTOHIaDxHbpmGDZaigDFOAMwFXrQpD+YehHazrc3Yl19DmQAcwD+6UBbmLk0IYvj46wZSGCRVU1I8BHIAEN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSp2z9oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D249C116B1;
	Sat, 20 Dec 2025 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766228594;
	bh=ap8MRB6u43PIFW27qfddd/82fqc/71rc4wGTDPI7wLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eSp2z9ohjB6vYInRQZAjAFrvEjUyT/DzO1gHOyAbUXyzXq1as2FowCXDAAplhRIFe
	 i1vcvNC4VrKYrhCs77Nj/tm6WwIh5K7j8tQkObTiQEZLDX1JFIv5L8Zp6bO0cHc5Uf
	 nhke2tbaUU1z3fYRMkQET3wW9XLiprqu7eIBJbOhsU4Ia+aM/cqdw2W5Vux/Ox9xrB
	 Mqf05/UXcE2wUGDDse/9rIYUJhTvhWiw36T5XBOwff+aWxfLMeLZPSo8hG44WMfPXC
	 79M5/xgBIe1zTidgdDSEHpcj4ra2KZ/uF+C22MQnxnC5qG3igk2QrLrpjPgROdlTJm
	 Q6bd5aMblMu2w==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sat, 20 Dec 2025 12:02:19 +0100
Subject: [PATCH v3 1/3] kbuild: remove gcc's -Wtype-limits
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-remove_wtype-limits-v3-1-24b170af700e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3600; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=ap8MRB6u43PIFW27qfddd/82fqc/71rc4wGTDPI7wLo=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJluTTH2PxvED5iem9T/9fZyodSYGb+mLK9ffoWxL+p+h
 FkPhzFjx0QWBjEuBksxRZZl5ZzcCh2F3mGH/lrCzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 hjpAJgMXpwBM9fQYRobrzVs2h7V82sLAk8/wzdbv79rGOl+NXefexIX/WfH09bRmRoaXtQIOKhN
 vybgals7N2bjbdr6VcsRenz/nWOvPnCk0ruMBAA==
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


