Return-Path: <linux-btrfs+bounces-19920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2C8CD2DEB
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 12:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CE8D305C4E0
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 11:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E562FBE1D;
	Sat, 20 Dec 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSPoVXNo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CEB304BBF;
	Sat, 20 Dec 2025 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766228607; cv=none; b=TayqaG01yIXO9fz6pQPQnBr5nMPyjBXc+tuSGjc9arT9/FoF8m13j7Kbu6QPr8oy6zG87bnn6EDrnLXcvs27IkpNJYcH/SXMZlmupc/YHIk+/H5/6L/6dWmGgSR2ThsDfETrR3CBDCsh1YceKTKPjrwhJGgQPyIdoSg70G13lDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766228607; c=relaxed/simple;
	bh=wtRlhF0E9lAMAS6RF9a/BuSBeDduKYxm9+amQIF8Ki8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xv35inQWsAqoxh06i4m2ecWewYIY2fhqbZBTNDfg+JG4YcXTHk+gId3+XUc9dueEQBsW8Pw/anlk1E1UfiQCsvDvOqmyM7D1hjqMo0YikfCKH9yq8NVYoQAFF7ixSUPIoLwnG5HfnuJH53zlTVrGA6BXJgzDPTGTMIuyw2Zjcck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSPoVXNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2D8C116B1;
	Sat, 20 Dec 2025 11:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766228606;
	bh=wtRlhF0E9lAMAS6RF9a/BuSBeDduKYxm9+amQIF8Ki8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VSPoVXNoHS3RNQvTOYjLCUlocYoKN64Jb5AHozNJBz2hFUthq8VjIPrQRpk+ZHAAp
	 L204OyuxQ2CA9zkvFcUy3BHSR26W9vsQm8jGIA5vM9yJu3gMX+pB+cDKEUsfO5NLoP
	 FE+EjDc0De7GA31kEu5dMGxdgUCW7T8zwJrLN9yPa9gPq9534EE07uEA4B+/HYz2GD
	 PrqCMutIPcWXHGMh1gHaB15xD0GfGvocsHvYG5tumarKEwCiphUMAHODcw64QFG2Am
	 BOg2iWcTKD6e77pXaYLve8sEWKsAZxUmodWRRx8A6YXQeIcFtC5yCAHICKrMy/mVPi
	 gGgc7YxGG12Dg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sat, 20 Dec 2025 12:02:21 +0100
Subject: [PATCH v3 3/3] overflow: Remove is_non_negative() and
 is_negative()
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=wtRlhF0E9lAMAS6RF9a/BuSBeDduKYxm9+amQIF8Ki8=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJluTUm3l+97LbU1RvNDcJztnoiThbzHipZctnsjGj/Df
 K5D44/MjoksDGJcDJZiiizLyjm5FToKvcMO/bWEmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 DXWATAYuTgGYasdHDP+dPpXOt9++4L208hczbeEroXx/j1fWeUvK6U209r8Xo5vFyLD/T3zCU4M
 HDjGK6xv2igf+eP3h4euUrR+ZAlbGBz40fcYLAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The is_non_negative() and is_negative() function-like macros just
exist as a workaround to silence the -Wtype-limits warning. Now that
this warning is disabled, those two macros have lost their raison
d'être. Remove them.

This reverts commit dc7fe518b049 ("overflow: Fix -Wtype-limits
compilation warnings").

Suggested-by: Nicolas Schier <nsc@kernel.org>
Link: https://lore.kernel.org/all/aUT_yWin_xslnOFh@derry.ads.avm.de
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

  v1 -> v2: new patch
---
 include/linux/overflow.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 736f633b2d5f..ab142d60c6b5 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -36,12 +36,6 @@
 #define __type_min(T) ((T)((T)-type_max(T)-(T)1))
 #define type_min(t)	__type_min(typeof(t))
 
-/*
- * Avoids triggering -Wtype-limits compilation warning,
- * while using unsigned data types to check a < 0.
- */
-#define is_non_negative(a) ((a) > 0 || (a) == 0)
-#define is_negative(a) (!(is_non_negative(a)))
 
 /*
  * Allows for effectively applying __must_check to a macro so we can have
@@ -201,9 +195,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	typeof(d) _d = d;						\
 	unsigned long long _a_full = _a;				\
 	unsigned int _to_shift =					\
-		is_non_negative(_s) && _s < 8 * sizeof(*d) ? _s : 0;	\
+		_s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;		\
 	*_d = (_a_full << _to_shift);					\
-	(_to_shift != _s || is_negative(*_d) || is_negative(_a) ||	\
+	(_to_shift != _s || *_d < 0 || _a < 0 ||			\
 	(*_d >> _to_shift) != _a);					\
 }))
 

-- 
2.51.2


