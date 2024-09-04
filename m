Return-Path: <linux-btrfs+bounces-7820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B37D96C6EF
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 20:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE6B285982
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 18:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D941E203C;
	Wed,  4 Sep 2024 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZOMnESg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC881723;
	Wed,  4 Sep 2024 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476261; cv=none; b=qYuOsp5FDDUnsUqP0H/cmjT/mTRHRnizQNS43YLp9AT9bWrgsr44+VDFWTHCQYvQDfE3AwGbcSpY4Jb4OBJ0m8n1/ztmjh5kinR1e6/QCLCSWZRVidlxDrdT6a+oVmqOVeUE4USebL2u1+8SDiwpHdiL9kokl/LxNgcry4wLVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476261; c=relaxed/simple;
	bh=RFEKjnlbO6/zS3iLFxXPt8v8CwjHCNpToyy272wIq+g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DKVD7o/vc0xH3AV5Jj0DP0yFjacU4t5+tgk8/Wa/9DxwX+KMz/z+fWZBgA85Yxcm3b41Hd7f5JtDPfhJWpf7zaU+1HjLRvca6dpWHhTTAJpRrrW28izXi7AEV0ZzmttX3io0v6IuiRHjcB1yUu1Mw8PzU0ZHRhzLaMS1Ro4ZdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZOMnESg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AB1C4CEC2;
	Wed,  4 Sep 2024 18:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725476261;
	bh=RFEKjnlbO6/zS3iLFxXPt8v8CwjHCNpToyy272wIq+g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BZOMnESguSRagCFdCjRr1IKtLijdsYQm9pnnIp80ITx4ss4m+U35cDVH/4Lz2/9yE
	 3ZO3hmKzlHG3FuMl2Dp2XMSE/jVkwGEfeF02e3epZcFYWRuvBo6v14dZkHsiwOVtY6
	 jpCpZbkBEoY7LNk6O5myhdd+G6mbpQnp7FPOwFhYeSjmgunB7kmXI73AqTnWk0KZYQ
	 t4b9mdaq35tagZMagGgcbEQEYypEZ/hMEvtb36OCu32l/6Mi7fYwgkCt+hK4Bpv/rp
	 8QuvlK8C0A+WawSvAn1V5W7PcT3JlKGSxf+GF99g8zp+ShahD/is6OsjvFZbYXZ12J
	 psfxVF3QQ7sOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F993822D30;
	Wed,  4 Sep 2024 18:57:43 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1725472780.git.dsterba@suse.com>
References: <cover.1725472780.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1725472780.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc6-tag
X-PR-Tracked-Commit-Id: cd9253c23aedd61eb5ff11f37a36247cd46faf86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1263a7bf8a0e77c6cda8f5a40509d99829216a45
Message-Id: <172547626162.1132966.6865981355892175702.pr-tracker-bot@kernel.org>
Date: Wed, 04 Sep 2024 18:57:41 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  4 Sep 2024 20:11:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1263a7bf8a0e77c6cda8f5a40509d99829216a45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

