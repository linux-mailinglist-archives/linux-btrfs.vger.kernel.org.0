Return-Path: <linux-btrfs+bounces-4526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF578B0FCE
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 18:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9D3283F75
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A073816C857;
	Wed, 24 Apr 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM3Chpas"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DC516ABE8;
	Wed, 24 Apr 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976216; cv=none; b=LGT4ur6gA+9kIBIMKCHmkbZpzzFr4CVuECPtpHOp5p4BiaH3R8wH30qoW82deEPefpja+PozYbQ1wJU3oYpZ+nWLwVnkH/oDxWCiX3T6nBFBMENyuCgq5ylPGtF+yN3pm1K5ktFzFAswegluajpkbUQWkUR6zx2av8uD5D39nfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976216; c=relaxed/simple;
	bh=kMceoooh+o0U/erM7ppgsFfiw0CxpT7CaHOtKzWYKdM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jXYNUPIFMMJaRZJKwLhA/wyu7FsslJCt5m5eAZ/jsSDFnx7fLWnWg7PbHW9zsBU22Lrsw1MdUVgnIAhLce3sPGLWIC2H1+dGG3T/fijkvw04AxYQGsiWnTj6/34dlTn9Njo0k8XlM5IeneU3xfKNHYXcbdiGKRmb69/tQtB61m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM3Chpas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40EA0C113CD;
	Wed, 24 Apr 2024 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713976216;
	bh=kMceoooh+o0U/erM7ppgsFfiw0CxpT7CaHOtKzWYKdM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GM3ChpaszB5TVNv66HKfnr2h6/I7nJwRYF43W3eNwh+O5YfTml5LJMckOEagN7ixb
	 ydEX2DaJZ4YUSNSZE1X+fNB6hQhg4Yf/rMGS96RlN57xzekiqMoNVPWGL7whUx9PX2
	 OZ/SKmxqNJbfu8XBH3tE1IN+XR6eYk69ZNohaqY9nFPEvOlsHHwGHB9MrE/jCbWcre
	 kY98b0/nxWAWsoez5yJOIMEw5bx8TAJcoE76f53c7ZZRzUxcsZNVgZS++RETNielzw
	 tHCd8LbEZ7qMO/k652SSnwnb0tkp7ZaoDgnlH2h3CHI54kkLNkp3K4bzVA0lsosAcs
	 Y6+EXUoO5aMRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33094C00448;
	Wed, 24 Apr 2024 16:30:16 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.9-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1713884233.git.dsterba@suse.com>
References: <cover.1713884233.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1713884233.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc5-tag
X-PR-Tracked-Commit-Id: fe1c6c7acce10baf9521d6dccc17268d91ee2305
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e88c4cfcb7b888ac374916806f86c17d8ecaeb67
Message-Id: <171397621619.10035.7064725266779071492.pr-tracker-bot@kernel.org>
Date: Wed, 24 Apr 2024 16:30:16 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Apr 2024 12:01:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e88c4cfcb7b888ac374916806f86c17d8ecaeb67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

