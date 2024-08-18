Return-Path: <linux-btrfs+bounces-7310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C750D955DE1
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2024 19:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702251F21346
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2024 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B2315383A;
	Sun, 18 Aug 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kae0VzWS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5E1494B0;
	Sun, 18 Aug 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724001811; cv=none; b=hseufXddEJd9oTURdKzXq1+qKr5IYJSlrkIwNxRg9MSstuny8UP36f4tVGYGim0+t0LOj5HhBy7upnnFU2UXoLMYedhuKeyGqftRoVe/dWmYlwuO9FFKwkDXYhrsYnPUF/VdwBk5QwW1mi+dbw8v+nP7tw3ttdBrmLuj6Fwk6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724001811; c=relaxed/simple;
	bh=EhokqZ57o/QqAt16nN1IIhJbSPZBJ6dtG+wFQBjF3I8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=umZMkDzN4+WSoo0ni1eI2pmpVHgbNZGedZY7bvZJIZxheSNyFSfnLMgIa1Quj9+qbSATteJSRv7tVwdrWV4RDBHKFCeAd37rP/egHT2jh3XB/1w8GPxWLrvhL0UbwJxTQfoiNfw+QbguNCOGk/XQxRg1jGbjtRhYDZlgGk3jD/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kae0VzWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091A7C4AF0B;
	Sun, 18 Aug 2024 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724001811;
	bh=EhokqZ57o/QqAt16nN1IIhJbSPZBJ6dtG+wFQBjF3I8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kae0VzWSwHMPLDGQzWjKpdYkeDj2JXLa0NCuuUJSYY+SU8ZqFFhaiYlew7fv8z9/c
	 y9u4BbVPiXtFi3kosJt1awva0sME0scqcAshg2leaZ02OWdt3bXuafTKJSu51/dd1H
	 q6aHXoS0c7RSdwErRm7JHa7p0NHfodrDSFngD/tZYC/xqAETdcbT9wbStzztEhj1LG
	 7/qAbImMw1Kf6d1e7Xrvyb8DKz3CppUEL1hp8We2U9YMgZ9y6OzG4OcpCW78crjNaX
	 7MmApq4YFnYewsFYTb3lbxvhf6CFMnEOmkSEclpWUWCZLeoRaQPN5k3HWFNPh1Gcyy
	 m3jWfhORF0baw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1838231F8;
	Sun, 18 Aug 2024 17:23:31 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.11-rc4, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1723984416.git.dsterba@suse.com>
References: <cover.1723984416.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1723984416.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc3-tag
X-PR-Tracked-Commit-Id: 534f7eff9239c1b0af852fc33f5af2b62c00eddf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57b14823ea68592bd67e4992a2bf0dd67abb68d6
Message-Id: <172400181035.3949564.8616586722448146669.pr-tracker-bot@kernel.org>
Date: Sun, 18 Aug 2024 17:23:30 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Aug 2024 14:43:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57b14823ea68592bd67e4992a2bf0dd67abb68d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

