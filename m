Return-Path: <linux-btrfs+bounces-19511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D74CA25AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 05:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5CC830E1AD1
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 04:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0052E308F25;
	Thu,  4 Dec 2025 04:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvMxwI39"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4EF288C2C;
	Thu,  4 Dec 2025 04:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764823875; cv=none; b=h4m239rYzlz9b78VbyNgeT6i9mfpSqX6OQI+2xDqW9yvnfUB7igpzPR94x3C0Am3WMftKwlHFvibO4TgcYQijk1h5aNWVM3xXZtuUBu7QlyPwUQPPwPR9LRWEotM6ZgWExYV/nnNN6b4oMg6a9i6r8BtLA8PNHQyrF0Ujk9ykcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764823875; c=relaxed/simple;
	bh=T4D5S7K5Bhy9UN3q0uUXV+/vTnqFm0x2YXp0HgN526I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i4kGHhgsKHbWNvk8oZA3eI3RpOE3gppNTSvMBzlBrHCI7IhRZqv12Q7VD0naw4+Ocirg9txp8Wx1zYe0RQYTdWlL7GfEcouqbZNch3X5gJZE0FmgyHsptNqbe7b4FRuEsNyHs4iAvcJ/kbA+Up55zsexOYQDPDGjCfi8nmBIPGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvMxwI39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B271CC113D0;
	Thu,  4 Dec 2025 04:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764823873;
	bh=T4D5S7K5Bhy9UN3q0uUXV+/vTnqFm0x2YXp0HgN526I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MvMxwI392rzilNBUmL3wArz9JFspDlyT1X+azW4plIzsBT+a0xYIzzaaDxXZ+3DrE
	 drYY94eQih1UIUSU5gTjNN3m77MhGMvTEvhLM4UtCsVFdkbPhzzNsHFAaAv4UCy2MQ
	 Dznl9qzIzD4BqHXCK/FMvz9oDczODE8P5BHuVbK1vxJyU1abL3T1oVUab+W8oKoGgL
	 XZv5/Ly8k4YykWJirTKrvmGNGGIYD7pbGB5x1dxQ9gdtfzpPdTJVqQH8WOWf593C1Q
	 X7D5Ly1I5pzMFjVF8OJCJgbzmKWlvbzEyohy/SBOyDxqL6G1YN4yq+2t92LJT3cqFX
	 mFeCbik3sPGBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789A53AA9A8A;
	Thu,  4 Dec 2025 04:48:13 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1764293730.git.dsterba@suse.com>
References: <cover.1764293730.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1764293730.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-tag
X-PR-Tracked-Commit-Id: 9e0e6577b3e5e5cf7c1acd178eb648e8f830ba17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7696286034ac72cf9b46499be1715ac62fd302c3
Message-Id: <176482369208.238370.7833488681721840248.pr-tracker-bot@kernel.org>
Date: Thu, 04 Dec 2025 04:48:12 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 02:43:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7696286034ac72cf9b46499be1715ac62fd302c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

