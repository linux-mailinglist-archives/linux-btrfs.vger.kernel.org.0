Return-Path: <linux-btrfs+bounces-19917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC5FCD2DAF
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 12:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 877183019BD3
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F963090DB;
	Sat, 20 Dec 2025 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmH08eqv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7FC145B3E;
	Sat, 20 Dec 2025 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766228588; cv=none; b=PBMH9Fc7uxsjmp99iflfGmgzYBKCOLkgqE44uVZI4hzNtam9Cf+Jo9LM4cgumCqbllRCOiIiMT9bpeH64ByTsU3hg+IZudroYPwi05JLCyxoMxKxtF6rQhy1RO0cyS1hqsmVDocnL06py3IoFOVr5jr8x3HOaDsuPh8Mp2ohK5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766228588; c=relaxed/simple;
	bh=uLJ1iwUNyZ6loiMONY7vTnixCRoajdX9bamzCmel0qA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K92gehB0LA+KIU/AqIRS6qqKYL8NPa6Ez3HIZd31ODS0qON/4be7yS7GDXCB6ACJEKChZLePkegstc9w9zgfgoR/IBP+CzHV7ig/A1bFG9okK+SA7Bvl56XvHn7zmbHjZCd5XS5p0AFff3wZisN/7rklSgWVwRx7cOI6SLRNRcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmH08eqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55761C4CEF5;
	Sat, 20 Dec 2025 11:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766228587;
	bh=uLJ1iwUNyZ6loiMONY7vTnixCRoajdX9bamzCmel0qA=;
	h=From:Subject:Date:To:Cc:From;
	b=kmH08eqvO+wyPLfsonbbP2CyB5dJnssivzncsh9VBoJwzv5S3wnIPzD725NtwNrIo
	 kVypGnRnJao+KfLTryOyGnU/zAqE95jHesAwjkmhyXwijszAu5a21LBDS8GulvCnce
	 HecqW0QPbVWqk+hkQkmfDinrRVkg3AHeeR+eWfailjj27obvk4STLS6tm3Y0elzbaj
	 vNJ+L7UfJZ+VYcxK4Sqpo80NYbwYsq3a1sWCtw1tq9rlhbUz71vnRhVj92orqE7wCS
	 izRbE4XvGfVFJlKICq7LEmIkGcf5mc9RXitXOp6iYJl2hJJXRwSRGP7tLc+9L4jydl
	 k6ruCtW4OkwAw==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v3 0/3] kbuild: remove gcc's -Wtype-limits
Date: Sat, 20 Dec 2025 12:02:18 +0100
Message-Id: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADqCRmkC/22Oyw6CMBBFf4V0bUkfthVW/ocxRsqAjUJxilVj+
 HcrbDRxeSb3njsvEgAdBFJmL4IQXXC+TyBXGbGnY98CdXViIphQXDBFETof4XAfnwPQi+vcGKg
 1Bqq1rllhBUnNAaFxj9m62y+McL0l+bgcSXUMQK3vUr3Mos55QdFy8gmfXBg9PuePIp/Tyzjf/
 B2PnDJqpFpzo6Q2G7M9A/ZwyT22szCKb0nxXyKSREAhKtkora36kUzT9Aas1pSrKQEAAA==
X-Change-ID: 20251205-remove_wtype-limits-c77eb46d09c2
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=uLJ1iwUNyZ6loiMONY7vTnixCRoajdX9bamzCmel0qA=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJluTRHRbsZVmvGzLGyUrEsM52tXebBfFpwYscXC1ywwk
 0ns86GOiSwMYlwMlmKKLMvKObkVOgq9ww79tYSZw8oEMkRapIEBCFgY+HIT80qNdIz0TLUN9QwN
 dYBMBi5OAZjqBDWG/4n/+NeouHvwH/Nt05GtlXCte94128D4IueKOA/Zx+u7KhgZOuedn3Rm4wG
 nvshkw82HCwP0+yWyp/85cbv21IIeltq1XAA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

I often read on the mailing list people saying "who cares about W=2
builds anyway?". At least I do. Not that I want to fix all of them,
but on some occasions, such as new driver submissions, I have often
found a couple valid diagnostics in the W=2 output.

That said, the annoying thing is that W=2 is heavily polluted by one
warning: -Wtype-limits. Try a gcc W=2 build on any file and see the
results for yourself. I suspect this to be the reason why so few
people are using W=2.

This series removes gcc's -Wtype-limits in an attempt to make W=2 more
useful. Those who do not use W=2 can continue to not use it if they
want. Those who, like me, use it for time to time will get an improved
experience from the reduced spam.

Patch #1 deactivates -Wtype-limits.  Extra details on statistics, past
attempts and alternatives are given in the description.

Patch #2 clean-ups the local kbuild -Wno-type-limits exceptions, while
patch #3 undoes a local workaround which silenced that warning by
uglifying the code.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v3:

  - Remove patch #4.

Link to v2: https://lore.kernel.org/r/20251219-remove_wtype-limits-v2-0-2e92b3f566c5@kernel.org

Changes in v2:

  - Add two more patches to clean up some -Wtype-limits workarounds
  - Collect the Reviewed-by tags.

Link to v1: https://lore.kernel.org/r/20251218-remove_wtype-limits-v1-0-735417536787@kernel.org

---
Vincent Mailhol (3):
      kbuild: remove gcc's -Wtype-limits
      kbuild: cleanup local -Wno-type-limits exceptions
      overflow: Remove is_non_negative() and is_negative()

 drivers/gpu/drm/Makefile |  1 -
 fs/btrfs/Makefile        |  1 -
 include/linux/overflow.h | 10 ++--------
 scripts/Makefile.warn    |  4 +++-
 4 files changed, 5 insertions(+), 11 deletions(-)
---
base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
change-id: 20251205-remove_wtype-limits-c77eb46d09c2

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


