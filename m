Return-Path: <linux-btrfs+bounces-4037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7C789CEE1
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 01:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F5D1C23A60
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 23:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D794149E17;
	Mon,  8 Apr 2024 23:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZp9ZM5S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819031474A3;
	Mon,  8 Apr 2024 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618378; cv=none; b=os2X9qqbLZhIs0hqoEIkc6gXP4f50PzfFFaN/GK1v2tDcX1S+K7tVbQdg6WRPuk2x5HkvylR83IjQmU1l5BbvZwGmzCmqTXCEmVyrQsqS5e/v7DPgKWbVDZfq9AuDG8mEsIDXD2JaC9fSONkQWq9p+r1ozCdFF4dR070Gp6EjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618378; c=relaxed/simple;
	bh=v+IPRE7iUwCR8m1iRF7nYeViXcMzlCX1j1NIKUgULrY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aVtGuTCCWnxtk1KznD2hF7kRR1CVDwQRbJrJvXbuy+czhLWlMJL+vT0P5hUFCmFknI/fWUooo/XDcGCckZTzOjGOBd875+rOptWHZTHETyhdGB59uebLrVywGk1GbEyGxfONecPxyAVfzg3sNJiM5mzNlF1r8y6Dmoutki9zpWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZp9ZM5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 588A9C43390;
	Mon,  8 Apr 2024 23:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712618378;
	bh=v+IPRE7iUwCR8m1iRF7nYeViXcMzlCX1j1NIKUgULrY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AZp9ZM5Scf7v1TpeRDJmpBACKgP80JMnJH6GjYtCX0vJw1h0VSD1rLI2m1ASwwXQu
	 Ee/KLzNXjmx1iUG/OYBthIXHg1ErLZ0Ul4aX2QU75EKxx1RIyHHhaQ1/tcYa/7sRSu
	 fjTXdlBs+lAOBWSXtdbUVfbSlXy0tp7QmnK/D7FXXBpJjJH895vkNoZOrGJ0h12/cI
	 1nCQt/5Hsouk7a2AE+FuKuVb+k4fp23iIoiUzarYl0QUuavmHn2A4EOMP4JlSDpQz0
	 aBg8SqBCdxT55hwjZ+QmRsnZbgEvwsLk8ldG9kfKtPQBR2awgN2DyfAWoR7eZ0aHMf
	 0hw+3mzm71J8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D2CBC54BD3;
	Mon,  8 Apr 2024 23:19:38 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1712333355.git.dsterba@suse.com>
References: <cover.1712333355.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1712333355.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc2-tag
X-PR-Tracked-Commit-Id: 6e68de0bb0ed59e0554a0c15ede7308c47351e2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20cb38a7af88dc40095da7c2c9094da3873fea23
Message-Id: <171261837830.1997.11002382191944745978.pr-tracker-bot@kernel.org>
Date: Mon, 08 Apr 2024 23:19:38 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  8 Apr 2024 20:30:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20cb38a7af88dc40095da7c2c9094da3873fea23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

