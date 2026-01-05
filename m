Return-Path: <linux-btrfs+bounces-20115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F6ECF60C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 00:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CECB30B4717
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 23:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E43009EC;
	Mon,  5 Jan 2026 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDg/o9QI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40CD2EFD95;
	Mon,  5 Jan 2026 23:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767657412; cv=none; b=tUwNy2ZAWVuXCeYWcTGpWwDSC8t0mxq2mkA863YdVvu3GvVgDLkm3WGKeGlaAKe8pnDXLMLJNtAeqoBkGRyWzl0f4U4QFy38yR3oHWZrvYdI/r1eJ5WDeSt/FsG1sHsbCgh/UQMJtt5GKI6letdftmw7XWwJ42GLaRIytlQboRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767657412; c=relaxed/simple;
	bh=HBefWBHNf4ymkXE1PWUOS9//5AiwqnDSrYphgTjisOw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CEUZrwbwO4Knkxh5+yATwEKppzRLRnBRXzHNbrx/Qr3mo7s03jsAlRTSdGWhhh+QnzunEtudaXJIAbnvPeR0dvh05N++57sEMUt1VkQq7JPrHZZheQ7c0DPJzKhIG7YZuVyiqc0tuqs9FxIRyPdOQxmX5o/gu76SDClYzGc1J3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDg/o9QI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CAFC16AAE;
	Mon,  5 Jan 2026 23:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767657411;
	bh=HBefWBHNf4ymkXE1PWUOS9//5AiwqnDSrYphgTjisOw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nDg/o9QIX94RGxQ8o4uWO4940lF6rBh8EFCk3iRRe/0G/kimpAVyxBjGu72E209mZ
	 Y5ZOLi28OSOum6l7U3P09kVpW9Q2LnDDcyqt2OhvRjROl0Bsj0UVcBzi6NDmpBKrsB
	 wf4GUjw9MHOHelPU40BYYO+3r9YrNQurpm2lKJojrcAOM+sEOw0Q/9F5DhoFZCzoo9
	 fWxBGf1doRNqR/a1PAaLfulyfPTtPLgYKbwz4s8i0O3VXiS5pQElQ7gweku3dkN4Tg
	 GSi+yG3RZnvRpG6OOh+KtL4zREbWF6dmCW/spLJ7som9azTud0QYzBXHd/gIFvWwez
	 +2YeHHtpWUTjw==
From: Nathan Chancellor <nathan@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
Subject: Re: [PATCH v3 0/3] kbuild: remove gcc's -Wtype-limits
Message-Id: <176765740692.3236304.10853846154010651497.b4-ty@kernel.org>
Date: Mon, 05 Jan 2026 16:56:46 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev

On Sat, 20 Dec 2025 12:02:18 +0100, Vincent Mailhol wrote:
> I often read on the mailing list people saying "who cares about W=2
> builds anyway?". At least I do. Not that I want to fix all of them,
> but on some occasions, such as new driver submissions, I have often
> found a couple valid diagnostics in the W=2 output.
> 
> That said, the annoying thing is that W=2 is heavily polluted by one
> warning: -Wtype-limits. Try a gcc W=2 build on any file and see the
> results for yourself. I suspect this to be the reason why so few
> people are using W=2.
> 
> [...]

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git kbuild-next

Thanks!

[1/3] kbuild: remove gcc's -Wtype-limits
      https://git.kernel.org/kbuild/c/660e899103e29
[2/3] kbuild: cleanup local -Wno-type-limits exceptions
      https://git.kernel.org/kbuild/c/34a1bd0b6b2c0
[3/3] overflow: Remove is_non_negative() and is_negative()
      https://git.kernel.org/kbuild/c/5ce3218d4f102

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted.

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


