Return-Path: <linux-btrfs+bounces-20114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D2FCF5F73
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 00:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF1373079EC8
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 23:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF143126B3;
	Mon,  5 Jan 2026 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUGlqkA2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C4E2D6E72;
	Mon,  5 Jan 2026 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767655237; cv=none; b=tH6RkqostItOpd5sFOageOUK4M1QyqMIs5TktZ38m4/i9IOhNMYENNtruU9HfnwgB/59V9unZa0aAoBuvO3OFtLlwcDlcRPHj+ez2Kg3v4t5cntSx1u5wABy8yncZFojSUtPsoKTQTB9ppYNy4FUIjKAtrSPKMmYZIRZl3i4j5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767655237; c=relaxed/simple;
	bh=kC46GGb7UJ1QZM/xbU2WzdbFE8MH4cKykErG7OnjcTU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WbwP4Hi1ov/VmxGjuOOxO3UDq/7dU20jEAfRSvTDNIMGY2wrkguTWBv2sDjpsBsXDArMJR6SNhAwOVHJz4s5kVT5rzEFMYYUWw4u+yUQPiL1+VkZoxHo7ce4uot/b1azc2QlypnUsOyH630JtCArEwBnH2CCwNtSaLOcR1InTPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUGlqkA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63880C116D0;
	Mon,  5 Jan 2026 23:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767655237;
	bh=kC46GGb7UJ1QZM/xbU2WzdbFE8MH4cKykErG7OnjcTU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WUGlqkA2fiV0hm++i2KMxsDFdx7cIFHtFo5tUHhbkl6ys0yP8vxsUgxe+iXxR8/Ay
	 HnajnH9XhyDVjZlpC0rUuiavsYDAUfEMrXByxzQ+r4SpBXfJOpT3NuOSTOBGkIj+tY
	 8nHnAloT8cbdwQrSEJ1EAWVE8hkTYkj4OLGh4QyCXxy2WH00ahKDKLGVGWJJMIovVR
	 PL2Hs+13uI5F1UuGw5tsLJ2/UrQdsx/1uYlgbZfwIFzA4mIGQJpuOxFiZlbQVxxcGh
	 h4XoFlLbeRBkcl95RGx4BHsv8HXm9b5j8XGuvoUVFkG9eY+SLHzCkEJZTlnmZcwSBz
	 b9sPmbxN46n8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5D1E380A966;
	Mon,  5 Jan 2026 23:17:16 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.19-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1767635222.git.dsterba@suse.com>
References: <cover.1767635222.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1767635222.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc4-tag
X-PR-Tracked-Commit-Id: c1c050f92d8f6aac4e17f7f2230160794fceef0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f98ab9da046865d57c102fd3ca9669a29845f67
Message-Id: <176765503533.1326725.9670057283386001661.pr-tracker-bot@kernel.org>
Date: Mon, 05 Jan 2026 23:17:15 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  5 Jan 2026 22:58:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f98ab9da046865d57c102fd3ca9669a29845f67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

