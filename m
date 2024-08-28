Return-Path: <linux-btrfs+bounces-7649-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257019630C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 21:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0FF1F25366
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 19:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387361AB53A;
	Wed, 28 Aug 2024 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDvRWTeo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE0158531;
	Wed, 28 Aug 2024 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872293; cv=none; b=IldqEvfoiGibZbNqDmj98Rud6xyo3/jRzIpBwUhTHvrFStLv6kX2RPy9TjAhHiP0IXqVh7R6KbqkKXarL7lkLddt8AhTosPuiZx8i3kRQCGKKJrSLG7udqZS9ujE5e4tRrUnk6xM1xuvfnk+Jx4iU2hOYV871didn1Miy1B2pxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872293; c=relaxed/simple;
	bh=Ta1RHHOc7qp8W4/MJvD05aRz597AH1LfdtSKsmAWDME=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aqfAN6/FkgNe99ZpjBWgaP8bh7XyC6Z27jh1xjc5+l50bXAqJUNQwEqpDKOcXZcdMHYHACD8Ilkj1Anm5M31UYeQT/cOpPv8FdZwixdYjia6xby3YGaT3he2ZQdIzAu7FN2N4JOq7W+VUWHCVSGIhd5XQG0hr150auUJP8j42SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDvRWTeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFC8C4CEC0;
	Wed, 28 Aug 2024 19:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724872293;
	bh=Ta1RHHOc7qp8W4/MJvD05aRz597AH1LfdtSKsmAWDME=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GDvRWTeoI95kg9/O4PqietvveRtNqARE9Vgt/eODC2nzWdhd/GPmUrdW3u533tvmp
	 Zr1HaYgnrlm8rbxc+s20BpinND6TZA/t+Ajg6A3m/g1cfO4qnexr7RwYs57JMmbslZ
	 E+KPg0/4iLbJZ7Aesd+Cum/YJqR+Xkxc2LBv4BY7vD+uSAg42Ou7Z4V8f3tFTa4Sif
	 7a2h7cExXJEfNkA6CTAIqJpebhO0ibOUEJ8RxC3RfUuzYgDgCTU6ltk+GPuZ7pck8F
	 ptxQzqQLFVom2YhI7zdK1BgH3ulvbnHN+nyMcFJ6A+Vsi5vHPFbbXyONKkuvDHuv+K
	 0GYvNqY3RF/lA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFD33809A80;
	Wed, 28 Aug 2024 19:11:34 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1724844084.git.dsterba@suse.com>
References: <cover.1724844084.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1724844084.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc5-tag
X-PR-Tracked-Commit-Id: ecb54277cb63c273e8d74272e5b9bfd80c2185d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2840526875c7e3bcfb3364420b70efa203bad428
Message-Id: <172487229329.1399279.18387051557340145908.pr-tracker-bot@kernel.org>
Date: Wed, 28 Aug 2024 19:11:33 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 28 Aug 2024 13:23:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2840526875c7e3bcfb3364420b70efa203bad428

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

