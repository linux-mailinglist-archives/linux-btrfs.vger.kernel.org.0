Return-Path: <linux-btrfs+bounces-20702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5330FD3AAF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 14:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B478630D2710
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 13:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E05936D516;
	Mon, 19 Jan 2026 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAmCC+k2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7513364E93;
	Mon, 19 Jan 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831038; cv=none; b=S2zcgL23Ub2V/HHiyy08Eq3eDymQdDNOWZYhnt8Fskw+eW1jt9IlHh4ZSZDNlQI6fa+AH/mvvfFpsljT59TJ4+9uR2ULcU3eGseWRIHxCVjNASKLBvAYoIzNpb5XsErcFJ7QMMz7b7v7d61xVfeDxgol9Od/vlj9nlKRY9SxsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831038; c=relaxed/simple;
	bh=xhMusgRzPK4ogsLTvuNxEcN2afJc7ikOb/cZEXil1wU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JwFPgL4lzDFN86/jp6M6kUC6AG69NQIz1jQW8Css90soJZ+pNR09qXwPynB8rHq4y3Kr07q4JwCSUaoK6tYF4vQhp7J6SeqFl2BZm1Xr24n9SWubDN82Zq5T0Aa6XGKlzYDozhdSQO5EI7FcjbAhaQr/UANsFgrioOmMb2JGW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAmCC+k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF503C116C6;
	Mon, 19 Jan 2026 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768831037;
	bh=xhMusgRzPK4ogsLTvuNxEcN2afJc7ikOb/cZEXil1wU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YAmCC+k2389ODNa5yD56N6dfoEyI9AnXOolipD1b38mvDjy2D1U/FaNieuQJwV3Zr
	 Bu97qWYWhhrcNZ6pD79QQYv4XSVh2+4AlJAnEz5ymhN3xJAmYx2oD4GpUupXSBWn3B
	 NEVU4zH6VojpOHJfEiezjVLExn6cm3TQFvIkB9iZlPfGjmoOQxshf7vDn/2YGqqG7C
	 UaWKx3+RXSusFSa0L+2G+6AHpCXg1BwNfI4wv2uAI5LrcvJwYCkejVE2UbTJCp03EA
	 sp6mGT7nHWRvny8ybjhvlea8QOkoohb16G8+fKwcR7UZm6fBTArKaqDHw7t+O+4hrd
	 yH6pbcPzCWA8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59F63A54A38;
	Mon, 19 Jan 2026 13:53:48 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1768703360.git.dsterba@suse.com>
References: <cover.1768703360.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1768703360.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc5-tag
X-PR-Tracked-Commit-Id: 437cc6057e01d98ee124496f045ede36224af326
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e84d960149e71e8d5e4db69775ce31305898ed0c
Message-Id: <176883082746.1423140.4929004220082244804.pr-tracker-bot@kernel.org>
Date: Mon, 19 Jan 2026 13:53:47 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Jan 2026 03:49:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e84d960149e71e8d5e4db69775ce31305898ed0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

