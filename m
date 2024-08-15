Return-Path: <linux-btrfs+bounces-7206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F1B952773
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 03:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6946A284BFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 01:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084C663D5;
	Thu, 15 Aug 2024 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyYNFDDv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9117C9;
	Thu, 15 Aug 2024 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723684625; cv=none; b=MXqF7LHcSB0qC73JQWDc6NpU+hqenXgKOUar/z0eMmSl0CdextVRdx3mJODFpHqT+F6rtIoKji93nh5O7ub+rqlugFCM90zN1USJHeRIdgIckIGxwoGYZUQQdNPns4shGb3K/SfPONAuW04jubTotPRc+/QsrdHXSMM7WtwY9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723684625; c=relaxed/simple;
	bh=ksdUOy1YT4pqUNLGGurwvtCsdFS4MjN7b0589KuOLHo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NM2r0A64jFzEiQC6FsDRXp0C2qio7GoU5+gqu0zWhIl6aO9sPdwZulEZNA8FqNwadkXXFgiFwtpOUfT2RVYAlxt4BWtcpO+U6iGbpv+EeJl7qV8BjX0eEy4oagfaZ9NO10Jz8FXLM47A7cmlnvvmHwmwJo5gn9hW74BtWhHZe4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyYNFDDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0640CC116B1;
	Thu, 15 Aug 2024 01:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723684625;
	bh=ksdUOy1YT4pqUNLGGurwvtCsdFS4MjN7b0589KuOLHo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lyYNFDDvMzEBz+e4tdmtaNa1LdYgBPD/BlhTwgXfCjUMhOLWhfSu6+uwyCIyKwvc6
	 AQk+U5KZsetSqhwfkCTf3HksgNn/OECv/4qbyn90eW1LO5f0rUXysCp+U/wzZUDTOJ
	 ZFHs27WapGib5vBFDudgXZYSgo9tXz/j8oKcidtw9P8bw2Tw6Y072UnLjw8+EZ3DMV
	 75rW6Hofnymxondw88ls3hqMcv0anTbwrFFOwo/4F4vWoAYi46T64oj+6i7sXGhWP2
	 SO19+CoU84Jl8yybygmZw/6msASLWqJvCGeVMX6mzbi8QAra8eQTBOe8eaHl1ZmIdY
	 CJ7ycFIHyZs2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715423810934;
	Thu, 15 Aug 2024 01:17:05 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1723673272.git.dsterba@suse.com>
References: <cover.1723673272.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1723673272.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc3-tag
X-PR-Tracked-Commit-Id: 6252690f7e1b173b86a4c27dfc046b351ab423e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fb918967b56df3262ee984175816f0acb310501
Message-Id: <172368462398.2434276.7304703431773863835.pr-tracker-bot@kernel.org>
Date: Thu, 15 Aug 2024 01:17:03 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Aug 2024 02:38:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fb918967b56df3262ee984175816f0acb310501

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

