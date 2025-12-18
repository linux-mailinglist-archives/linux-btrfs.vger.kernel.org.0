Return-Path: <linux-btrfs+bounces-19860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F017CCD466
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 19:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D3F6305C4F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 18:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F173101A8;
	Thu, 18 Dec 2025 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMdvg261"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0601287276;
	Thu, 18 Dec 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083872; cv=none; b=D+rwaMcACmLGfQ9dVUjAzgept/JbjIFGm9qwCgEKVbE2g+0d/1qyJt11SGYCxD3S1E0lSYgtIrpnjCvtXb7KKTOOMYrErZtBoL7jzMw953jzLkpua9NGnCF4R79MJmLL3E7Cndg73rs+U8uBS3uGh3ZF6cZ2wBeARBuCk8Lzd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083872; c=relaxed/simple;
	bh=0rxFLgGIt2S6KKe6SUfsBxmMpBR2C+L3eo9hxGKmc0s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oz3YzpwLcBh1sr5gShDrDReYt5QA3bzqD4CY3Z/F0o8jcXxD9nWKnN9Ub92muKnOthBUZgffoXVZgTzwy6yTC4Nf6WcpnJN9Nrtek24/l24g26pFdrL3iEdW98rpXNgO6cbkevF5qo0xt1Pm9C5cLolCj0tznU1BY4hR4cdWotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMdvg261; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ECDC4CEFB;
	Thu, 18 Dec 2025 18:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766083872;
	bh=0rxFLgGIt2S6KKe6SUfsBxmMpBR2C+L3eo9hxGKmc0s=;
	h=From:Subject:Date:To:Cc:From;
	b=CMdvg261ETD/OA/6SdS+WUpTZqVd9abcT/nC0QI5giG5MX55zFYJ6Z9eqgRMq2rjT
	 Kc5bv7pYVr7Bkaz8FoFU6Rkudz0RCxZQKsNgLUzwWQZf7Dy+/88yrKCID6hjy+dRez
	 RwibmcUufeNgladI0iWBZertqlDzRFOA0iKRuxSSrTwHf0T2wa6Xc/qsLfTtN73XhS
	 j6teq17L8KtBvw83ar8U9uoPcmIgtjGJP7usDShqQ8b0ow/SvaaMXHAQDb3kGFmncr
	 vO/i0xcfz5bGWaVCL4d7E32qwSoVNAoJZCeGvDu/znh7A2mDkLkBxETgBuJSD3PrDY
	 CUxgerRJIBfhw==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH 0/2] kbuild: remove gcc's -Wtype-limits
Date: Thu, 18 Dec 2025 19:50:00 +0100
Message-Id: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANhMRGkC/yWMQQ6CMBAAv9Ls2TVtIxD4iiEGyqqbWIrbWjWEv
 9vIcSaZWSGSMEXo1ApCmSOHuYA5KHD3Yb4R8lQYrLaVsbpCIR8yXd7puxA+2HOK6JqGxlM96dZ
 ZKOUidOXP/3rudxZ6vso87RLGIRK64EveqVwfTYviDPTb9gPNuQNRkgAAAA==
X-Change-ID: 20251205-remove_wtype-limits-c77eb46d09c2
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=0rxFLgGIt2S6KKe6SUfsBxmMpBR2C+L3eo9hxGKmc0s=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkuvgKqSdsVlJSctu36qd7wuiSw9va8iy9mmTSzXTzXx
 nvXT3Vqx0QWBjEuBksxRZZl5ZzcCh2F3mGH/lrCzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 hjpAJgMXpwBMtflCRob92X/0uBN3TDx29O2FlognkltmSAmZbv705k+6lMeZaF4rht/sVx3WOO0
 6Fjd38zr3TzM3dFazpi9KfON0Im1T8o6wDYzcAA==
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
want. Those who, like me, use it form time to time will get an
improved experience from the reduced spam.

Extra details on statistics, past attempts and -Wtype-limits
alternatives are given in the first patch description.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Vincent Mailhol (2):
      kbuild: remove gcc's -Wtype-limits
      kbuild: cleanup local -Wno-type-limits exceptions

 drivers/gpu/drm/Makefile | 1 -
 fs/btrfs/Makefile        | 1 -
 scripts/Makefile.warn    | 4 +++-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
change-id: 20251205-remove_wtype-limits-c77eb46d09c2

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


