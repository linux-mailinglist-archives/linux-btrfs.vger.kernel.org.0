Return-Path: <linux-btrfs+bounces-11785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1138A44928
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 18:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF673B98A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D980519AD90;
	Tue, 25 Feb 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvwV8xpi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A914F9C4;
	Tue, 25 Feb 2025 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505916; cv=none; b=o+f9gj5lhuJIWFqmDac9meTwjVeM/xOrMMTGhouNUq/3yFixQst8rMeljLM4ncuJajsU9av72/uQw3SdbTe74r1inKZaJaLviXOzqxwTXZZjDdl1nBQBslfmhc+zE1NiWLBj5DxhRWjElGN0Oy5Agpi1fNG+4MNyhgr2ECyRTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505916; c=relaxed/simple;
	bh=6OJuVi2QVz37WuJ/yt0tL5/TEJdcMac3xwN99wyFgSw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Rf0hKp4lLgZRCOjFCC8F+bP55MHhPiErr8Gf1hDyUchA3n2Od/VB7RmOP0IA2gVUZB6YMhuPfRaRQIH0B7OuNbC3J8bvPVMMQwK2nb8UlovO1xmbKlsfCWCQ9qnP2Xeb0jQnb0lq/L8mv9CsLtvJ1QrkSCpnhEq8JWAwkvjtYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvwV8xpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896E3C4CEDD;
	Tue, 25 Feb 2025 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740505915;
	bh=6OJuVi2QVz37WuJ/yt0tL5/TEJdcMac3xwN99wyFgSw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MvwV8xpi23gFdavOHd6WX1fEkKX8U2t0bJ6mQGEAaZWLWmlcbQvpSwxEnRxdbh8A6
	 aoX2nqhX+mgP1tCi394VAgAkjDmNTwRe9aoRZfuyMH4c4raxg0rJx9b+nj2PeKqzbZ
	 PwJS6Inpidux0nNv+pYcCY+BcxRmdMLZHqj2me8SE4PGm+l0RKe65nj+RSgvh8RmkW
	 EyVQB6bAq7LnZN9HKtDC69pDyrRAoaJ/qkwkNFJzVE/ADe2A89TTRfrqx9h76wpfSp
	 4kUTNPrf6YwRPIdvEux7NxbrdvPVvXdyq2C69vmsh5QQP2WBQq3QbhWnhO+7+STLSW
	 8x27OOztAubug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71158380CEE8;
	Tue, 25 Feb 2025 17:52:28 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.14-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1740498490.git.dsterba@suse.com>
References: <cover.1740498490.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1740498490.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-rc4-tag
X-PR-Tracked-Commit-Id: efa11fd269c139e29b71ec21bc9c9c0063fde40d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc8a0934d099b8153fc880a3588eec4791a7bccb
Message-Id: <174050594702.66280.5164113758737539434.pr-tracker-bot@kernel.org>
Date: Tue, 25 Feb 2025 17:52:27 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Feb 2025 17:12:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc8a0934d099b8153fc880a3588eec4791a7bccb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

