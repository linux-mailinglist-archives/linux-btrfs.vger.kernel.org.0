Return-Path: <linux-btrfs+bounces-17483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A87A2BBF882
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 23:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FC744F24D5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 21:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32496285C8A;
	Mon,  6 Oct 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za0ICEAK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6912566DD;
	Mon,  6 Oct 2025 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759784459; cv=none; b=CfQx+J8Q8oOYlLbGz2pblhXE7Yi4iG75sbJ2c0K7TSnIK4aG94K/u6A3gTHcbrQ8TdE+emvO5h8VoIHV6/y+DlOaSz7OmxOguocuiC2RqxD1Lv0/OiHPXUU9npCJXWJkLKMffAw9r2TRxcVahE3DSzyjSwuoVXOQUd3VbUiS06A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759784459; c=relaxed/simple;
	bh=1gmYWjlWw5E0AOlPqZJJrC7Er/rDKFgxpncGhyIsMVk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aLFoavFq+pBi2qbiSBeKJoXEtrEruKyRu4jmoMfw2txPLqvUcOEWCFMzbmNdkBkKbTIvz6ygzvNBaXgr1IxY+XlrOg/KWm1HYbBTzBi+EG3CeGz2hVlJX8/AASn9fy9uPW0a4vAInjwBEsjwCQNG+gZXvkWsQ3pUtp53gsAyQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za0ICEAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5082CC4CEF5;
	Mon,  6 Oct 2025 21:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759784459;
	bh=1gmYWjlWw5E0AOlPqZJJrC7Er/rDKFgxpncGhyIsMVk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Za0ICEAKAa291NIcIbWWSMbfsM4xf3ldDAkYo1nKzAKhVcglbUZbOASTX9IlmxTge
	 1vpSWVFgG7e3tsw8xeurgXGP3NC64K5UAN4oHqgx6AFCKZmsTOApl/jOY9P8CjcepR
	 IaUhNbIykYR8Dw1rY52nH/HACQPIh/Wgbudv+694dryOQdK4ZSXjlFsUlDRlRHDcnf
	 wHL+9LyPwCIMGn0d8umTR2HPFSfHFkC/XfgLFSeFGnU9zbYy7pzweK0RkTeZeLFIrJ
	 ANVh6zoQ5qrPUZKGkvb1BeLc5eJC+vcDOiwpP739q3jhr25yXgfhohjrGiA/8/GKb/
	 F5xqb8tfgDPNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D8D39D0C1B;
	Mon,  6 Oct 2025 21:00:50 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.18, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1759762927.git.dsterba@suse.com>
References: <cover.1759762927.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1759762927.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-tag
X-PR-Tracked-Commit-Id: 4335c4496b1bcf8e85761af23550a180e937bac6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c746c3b5169831d7fb032a1051d8b45592ae8d78
Message-Id: <175978444960.1594692.1251586137586911707.pr-tracker-bot@kernel.org>
Date: Mon, 06 Oct 2025 21:00:49 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  6 Oct 2025 17:47:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c746c3b5169831d7fb032a1051d8b45592ae8d78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

