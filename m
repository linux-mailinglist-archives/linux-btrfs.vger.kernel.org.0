Return-Path: <linux-btrfs+bounces-4785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A18D8BD677
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 22:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BBF31C210E5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 20:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F815B57A;
	Mon,  6 May 2024 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek/KC1Is"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A415B563;
	Mon,  6 May 2024 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028360; cv=none; b=KNBxbUGEWX7djmn8X9Dm+HRLhFOTuRnXNtEYlrZvdRIgxQmzjWgaB10QH4UricoilZ4y/fycjgYsvKPiycybFk9YJphVs/4x9toH/eSvtRb2nPEGQBQt2BzV0sUbe0tXq9uje/BscrrQvMbMzes+iAmL1cLPF8ChmRN9we2Bhm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028360; c=relaxed/simple;
	bh=utAaIy9sm57vJcG0L4HHUa0Q1yWutB0HWBPrKTsxWyE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ig3LimK8wVuF26MP//3rPIECuzp39xSqepLHoqhCcu+nkUUD1DbtPjg8N0s51R/fKZ3RrlxRRwuyjnBkqdVYzUtTV+rAKqWeM2XIC0b8poHy4wHp3xl7u/z6Slc4vVVLrXwa0jcvGStmLT8Vh+ZR+ZTC0Fk+chJST6FCp6CEZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek/KC1Is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25278C3277B;
	Mon,  6 May 2024 20:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715028360;
	bh=utAaIy9sm57vJcG0L4HHUa0Q1yWutB0HWBPrKTsxWyE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ek/KC1Isn5S2gevyu5u8HwZx0xHZagOUaO2kwJYYnbTS99xjuYjiETUMGOFUEXChJ
	 B6mpGuWEY5nJYuPBNcKTnU+GUCx43fX9b5qK7ITj4SLB6FUmYkmdbc3BnRrEBjlH3+
	 Pqlr6a136BICyi6RfSAWspmFj4inBFMzhn0P4xAH6CoEkaXRJ360Jnidh8IrMJdMy4
	 OUkqT5l1ck8Elobz+ACU97aZOsa8ZJgQ2YFDkwvo5dofA6GIj6Xkptpb8oK/lxQ9mg
	 VR8qLA7qxF8tOxHHSHMLutuPzDsM/oMzwZqFcdsLcR29cpsZ5HhamZv+l+3QR4mwe7
	 1KPjbHkvldMdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19BA2C43333;
	Mon,  6 May 2024 20:46:00 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.9-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1715024051.git.dsterba@suse.com>
References: <cover.1715024051.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1715024051.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc7-tag
X-PR-Tracked-Commit-Id: e03418abde871314e1a3a550f4c8afb7b89cb273
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dccb07f2914cdab2ac3a5b6c98406f765acab803
Message-Id: <171502836009.15177.6928904522611695311.pr-tracker-bot@kernel.org>
Date: Mon, 06 May 2024 20:46:00 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  6 May 2024 21:44:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dccb07f2914cdab2ac3a5b6c98406f765acab803

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

