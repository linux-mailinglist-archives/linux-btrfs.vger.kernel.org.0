Return-Path: <linux-btrfs+bounces-5855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D886491129D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 21:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23081B281D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A254F1BB690;
	Thu, 20 Jun 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnGq4sO4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A01BA879;
	Thu, 20 Jun 2024 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913010; cv=none; b=r6s5baJ9Qw5RCfyQRtb0MEa5pkSaG/ziICAmcnEbz5yqs+NVSLSZpcXSqqEoQBJiLtmnEKfYPTuwcuAnhxxQ7R3o0vy4Nd+w+8h+bWOJW5UpeZ4Umkt5ZMe2ewMdvR2AOFxussJZTA/0hzzyieZU125ObLn+77pVGnF58rbnP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913010; c=relaxed/simple;
	bh=DB+5RCr3s8v4D+FayRQCF7wo39GtTFNlsOvUSTzGYzQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s64VlijPbir8LcZZWf6KxBt3NTXNEcIp22aJgLjDT1jheHajlWXJnWRTXHuE1hkJg+H0bMIPfKMfZx7WlbDd1ggIyCJaHxHiH0OvjNFOsCWfreZqG/XeTkjBKe4o/uMJLVPtM3eN5mnuCDeIPy5oDzuIc0xhjSCuj+0D3UzEfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnGq4sO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BEBFC4AF0A;
	Thu, 20 Jun 2024 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718913010;
	bh=DB+5RCr3s8v4D+FayRQCF7wo39GtTFNlsOvUSTzGYzQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GnGq4sO420I3Ec62Nr2AlB2V/+MDaG2jWKJfYwLuvIB+asVBhTd6UTH9myA5RBFuj
	 x3HO6jHdzi/1BfJfex0sugcskDKh/RVexvB/sQGhU2AqYDwjX4Gf6I7xV7zEwReL/t
	 BliKofcJj8R5hMBzes6zdguwdUOmnsJMcT+V+inrb4AS/QMIs91PZlIvOmOkHSftiX
	 x+4nlXyl1OjRsdlhEdja8+dLRi4If2v4g8FtbR127ZUa2fRx25mtHCyrp77h6PmU3k
	 tsNZBq/adOs9jofOgOdxcj16YUqcZJoCUYP0WoI1/+opCemAcUJ6xzuHORNv0BQO+4
	 QQkBaocChAaJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F039CF3B97;
	Thu, 20 Jun 2024 19:50:10 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1718903445.git.dsterba@suse.com>
References: <cover.1718903445.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1718903445.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc4-tag
X-PR-Tracked-Commit-Id: cebae292e0c32a228e8f2219c270a7237be24a6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50736169ecc8387247fe6a00932852ce7b057083
Message-Id: <171891301031.2247.18207739518937749630.pr-tracker-bot@kernel.org>
Date: Thu, 20 Jun 2024 19:50:10 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Jun 2024 19:20:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50736169ecc8387247fe6a00932852ce7b057083

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

