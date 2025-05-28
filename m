Return-Path: <linux-btrfs+bounces-14274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10459AC719D
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 21:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43AA07A78B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 19:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DAB21FF41;
	Wed, 28 May 2025 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUbPH2wB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0CA21FF4D;
	Wed, 28 May 2025 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461463; cv=none; b=RYYZ+1cEMR65wwosnGIwR1m7LT+gZnR6EJKMfT12MgsAjp2JuhHYOzdZF7BEtDEF1/ctG5r/p/inneobLBBP2cEDqBALTFXOF9a5u93OaXW8/A0oz7ZcPxOgZdHnTQJLuWh1RgVEA4okRWT2ngjlQycZlB14uOazH5TClMzefIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461463; c=relaxed/simple;
	bh=/GAWSVucG8SbHamo6B76TegesWUJZ7voiwNEeP8F6G8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hJOovykz8fM+i/pg5xygscph5eirs5y/Ji3K1b7EgFKKHeln4krPaaQuTlpXxfQy9kpnEdsD4ds66M1x8lriGLLA4GD0emxGwMq1UrcaJm97d3SBWSG08g97VAReFJ7idoRG7bT35MMSM0NW7jb+QKoJnUd6Ss/sYtUl9U5ifOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUbPH2wB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CED6C4CEEB;
	Wed, 28 May 2025 19:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748461463;
	bh=/GAWSVucG8SbHamo6B76TegesWUJZ7voiwNEeP8F6G8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NUbPH2wBzW/tpeCAH5qbsHDcYs62AZUItCwzr1tBtr+a0OA5CyJWgaUTD9aGZCfb2
	 qlydUGUl/3gGYOwBVS/w5zjxc+phB1ZvX9V+RYkE27OZzMXq7ML/JedjGoj6MhJ/0s
	 oS6nTdCRssJ8TWMb6blHWG5JsIFxYBp/1MsBgQ57ZvBPRlABzLY94l7crpq1OrFiAB
	 oCnivO77KBAneghQfjk2PtiX6hv547S4Q/i10fLlwC5+ULSSGgRchNPEUEVE+KQ2+i
	 X2xLxsVu/Q18VotxEO7SfbnnjEY+wQ1Cg7m6Bb4BSJzTJQ4Jj1flwHtTWJxpS/ZLeX
	 gXIUpmEgjGziw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710DC3822D1A;
	Wed, 28 May 2025 19:44:58 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixup for 6.16 pull request
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1748346039.git.dsterba@suse.com>
References: <cover.1748346039.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1748346039.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.16-tag
X-PR-Tracked-Commit-Id: b83825a8f56a34e7352e424aae64ffe6b88247d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a56baa225308e697163e74bae0cc623a294073d4
Message-Id: <174846149712.2536722.8845147636854077581.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 19:44:57 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 13:49:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.16-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a56baa225308e697163e74bae0cc623a294073d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

