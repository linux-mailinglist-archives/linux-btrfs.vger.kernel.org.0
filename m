Return-Path: <linux-btrfs+bounces-8978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B0D9A1468
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 22:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCFC283B7F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 20:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D301D2793;
	Wed, 16 Oct 2024 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it4US8dM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246E18CBF2;
	Wed, 16 Oct 2024 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111881; cv=none; b=IeYnxPzLmpoC/ZwA2mvSOE2oYuOZbVKMWttYtoHSGCl2s2uC1oMF0Y7crsDPV6i1wyYmzzvDsH5LfJLVFD1MBfgl6NEUzlnnIpoh1zGvY3ke03xFIayDpNNFPwt8arvq9xGbIxuFH+liaDO5JfuHyy89i8dSeCbquBrApNiLWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111881; c=relaxed/simple;
	bh=0PHGuF91s2aIjmCvHOnL3QFIwNJK60iNiEEXd/JNWIQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XVgfnxiaNcpRVElzU/igKUQR7Ewis1NIcnd6R30ICM18oGvM7m0Nnp70TkKRBawMylqV7R7CEcht9lwXWm68Z/Ra3FsApHfF+lyeh1UVNyy/XO/YvcPw22ie6xtGxi9VkK7pV0OnqwvPcV59xRqP2KS6rVSU+J0qOtnXJuERpHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it4US8dM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24913C4CECD;
	Wed, 16 Oct 2024 20:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729111881;
	bh=0PHGuF91s2aIjmCvHOnL3QFIwNJK60iNiEEXd/JNWIQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=it4US8dMnU7LTZMMVZe1f3pIaUzY8upVounhmnRk5dUfJy14fybT+ERJilAWUHr2i
	 3mbg1Iwn4DHB83rH30G2bo4IjMF7eQlqBDDgINoD3qYl7eRjDwcMYeBxk/G2e4EaL5
	 PUAcoz3TUSFd5aCI+1rgDBg7e/ZjCxd97RdYfi0YMcLCGuDHBiZPVMmT1QOFv/qstX
	 HLh/nMFUbaxK71Yg5uCzrL+w/DlJUmLxinUeuDkdLcbE9uO5YcI88IyEoICDgb/fLE
	 YUHm36/d379lf/0CqFOIe/1fbhbHBX3mPOMgcLLyIBvxkHdDfs5ydlu1LYZdDjCc5Y
	 Vm5D2sZQriYZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2E23822D30;
	Wed, 16 Oct 2024 20:51:27 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1729087733.git.dsterba@suse.com>
References: <cover.1729087733.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1729087733.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc3-tag
X-PR-Tracked-Commit-Id: 2ab5e243c2266c841e0f6904fad1514b18eaf510
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 667b1d41b25b9b6b19c8af9d673ccb93b451b527
Message-Id: <172911188617.1955101.8009774687482094253.pr-tracker-bot@kernel.org>
Date: Wed, 16 Oct 2024 20:51:26 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 16 Oct 2024 16:26:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/667b1d41b25b9b6b19c8af9d673ccb93b451b527

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

