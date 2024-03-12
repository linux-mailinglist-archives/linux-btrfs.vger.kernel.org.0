Return-Path: <linux-btrfs+bounces-3236-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1758879E86
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 23:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D035283A3D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 22:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9A7145B32;
	Tue, 12 Mar 2024 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLQhkjve"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D4F145B08;
	Tue, 12 Mar 2024 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282253; cv=none; b=RLwimsl+ZqUHOyW74fEZRVrwV2YVf6VvIP9jWlKj6i68+j8h9YFec/fmu4/hv/BJlJfwiwFi+eFsoLp/bVH20xgW9ut3ojcTQHRx3WOhESCN6CKh7V32i+Th9gR6h8teKlVPVnar7FZ/gPrTpw/7kA6EJMj8K4Oi346Qi568V9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282253; c=relaxed/simple;
	bh=4mYWtvYspbmI5YS40g24oXq7wwFSpUKBWK0ckqoUI2A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rpijxgObc4j5jDimV10msbgSIMUiEaQ0QC1A5HLCILvUBLMI6q6kStIUt0pKKtVBpC3+ZB3BoXNXVjRzjAUoMe/SjfEk+iy4aLlQ0COt03T1ivq/x/SK8EI6aggX26TDJb0N4cXbZAN6ZrkgujfT2b+v/XHR4GAVvgxgNNAcMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLQhkjve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A0E3C433F1;
	Tue, 12 Mar 2024 22:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282252;
	bh=4mYWtvYspbmI5YS40g24oXq7wwFSpUKBWK0ckqoUI2A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KLQhkjveYBtvX0WyV/0NCao7ebjqMBXW90GiRokICbbX4eu6ORWq4mCFz1yezLtZg
	 l6/ola8TU5Ku7i5chMWUiYsM8PG/GjH0B7HgVEaYbR35agdJTnq1nWOPuAE1YMRx3L
	 8RLWtsylvmkb6tjbDJRfz2Fjv+5J7e0VihNzPUcmj2fSo4Pfh5zISkXosvxRLekMw0
	 ZRr3GoiwoZQlBty2+b7ie56o7qYs45A11UnjSrZ0d0k392vYTVBUr+6nEFVXu35r75
	 dOyobwcQkmjUdPMy+LZFEaftiBMH3/o7YPWx2+h3iPmjrmRCy2zp3ergaXIVBl1jXM
	 FtLS0wmFB4eQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86C8CD95053;
	Tue, 12 Mar 2024 22:24:12 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1710183792.git.dsterba@suse.com>
References: <cover.1710183792.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1710183792.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-tag
X-PR-Tracked-Commit-Id: 1cab1375ba6d5337a25acb346996106c12bb2dd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43a7548e28a6df12a6170421d9d016c576010baa
Message-Id: <171028225254.16151.9271790987036999384.pr-tracker-bot@kernel.org>
Date: Tue, 12 Mar 2024 22:24:12 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 20:18:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43a7548e28a6df12a6170421d9d016c576010baa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

