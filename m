Return-Path: <linux-btrfs+bounces-19906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEB7CD21E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 23:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8500E305AC69
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 22:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D361B2BEC2A;
	Fri, 19 Dec 2025 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo4lqaWB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7318FDAF;
	Fri, 19 Dec 2025 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766184019; cv=none; b=SnABtyuU1z3ka2NEnNuTxYfc/ZNu0pffKaohkb+Ce0zwPPNUjUc/ESTyF9AkCmD+/T4RYk+Qbgug4ViJnVWOROYjP5p0ZxubHOlG0YGU6iB7CQKcFZkAHfZUymtCynNlA4QBxVnsYvFMwUWrTD6SsQL36om8mYyrhjBOgf0HeXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766184019; c=relaxed/simple;
	bh=4Re12oNt7Opk8DXSEZclIhGKvxuDxBrD78pnkLRJMgk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sOrqdQZ0MVVkX41dmNiCE63x+IMLFoAdXlAGnl8wSBsHLcyTABuIOe1hexeoQGaJoselSpHtbrS9uk+shNUY8OVuIHCxugdS6QPD/OyHV/JiLj+FZX1fSLXb9EQ1iXHPgPhoULdVCMflIyjljtYw8S7s3s6yUd08UlGA+NfQYWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo4lqaWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F42C4CEF1;
	Fri, 19 Dec 2025 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766184018;
	bh=4Re12oNt7Opk8DXSEZclIhGKvxuDxBrD78pnkLRJMgk=;
	h=From:Subject:Date:To:Cc:From;
	b=Xo4lqaWBOwwhuluvZVJO0Gb6rL6gadU/QhpglW6tG4R5ToQAgnkeWImbPTVM1vnkW
	 EmuyRcsNhPs1N1KRlcRWM7dWfZ0hUYOY+QRMGxkKJa3HJWLd55Qzs2X/3iaA1aH3qm
	 6l8gyQEylD4+7V8nAUnzVmh1ud+kKDkKmna7onusQMHSjoaPEPpy5UcGDpcyKOAdwc
	 GPGGlNFDZHXCiank9tDu6g5VNW81I1ZI1zQLwGjN2MyuklT6RdA7j5TzVPsbrU36M1
	 EJKmnOq63F0SOXlFsQxLmXk1YA9FumIFzmzVH4O+FEsQAsTMe0k8X/OEUukM8XBG+K
	 qXKpH7ljAZZGw==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v2 0/4] kbuild: remove gcc's -Wtype-limits
Date: Fri, 19 Dec 2025 23:39:44 +0100
Message-Id: <20251219-remove_wtype-limits-v2-0-2e92b3f566c5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADHURWkC/22Oyw6CMBBFf4XM2hJaHgVW/ochBsoIjUJxilVC+
 HcrbF2em/tawSJptFAGKxA6bbUZPYhTAKqvxw6Zbj2DiETKRZQywsE4vL7nZUL20IOeLVNSYpN
 kbVQoAT45Ed70Z2+9VAcTPl++fD5EaGqLTJnBx8vAZSEvGCkOP3Ov7Wxo2R85vruPcZ7/HXecR
 UzGacJlGmcyl+c70oiP0FAH1bZtX+EvN2zkAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=4Re12oNt7Opk8DXSEZclIhGKvxuDxBrD78pnkLRJMgk=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJmuV6xntgqcULtlUvtJ/IuM4vJAT/F/Dzc89ZpzrFM1M
 fv4DgvpjoksDGJcDJZiiizLyjm5FToKvcMO/bWEmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 DXWATAYuTgGYamEpRoaDny68fZ19vSNw1ufyWGGVA98SFsn4Z2WwuCetb226/zqTkeGJ3vydZsf
 rC85U2u1KaRBLc74erhj6z6FdNSIyrENgFhsA
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

Patch #2 clean-ups the local kbuild -Wno-type-limits exceptions,
patches #3 and #4 undo some of the local workarounds which silenced
that warning by uglifying the code.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v2:

  - Add two more patches to clean up some -Wtype-limits workarounds
  - Collect the Reviewed-by tags.

Link to v1: https://lore.kernel.org/r/20251218-remove_wtype-limits-v1-0-735417536787@kernel.org

---
Vincent Mailhol (4):
      kbuild: remove gcc's -Wtype-limits
      kbuild: cleanup local -Wno-type-limits exceptions
      overflow: Remove is_non_negative() and is_negative()
      minmax: remove useless cast in __is_nonneg()

 drivers/gpu/drm/Makefile |  1 -
 fs/btrfs/Makefile        |  1 -
 include/linux/minmax.h   |  5 +----
 include/linux/overflow.h | 10 ++--------
 scripts/Makefile.warn    |  4 +++-
 5 files changed, 6 insertions(+), 15 deletions(-)
---
base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
change-id: 20251205-remove_wtype-limits-c77eb46d09c2

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


