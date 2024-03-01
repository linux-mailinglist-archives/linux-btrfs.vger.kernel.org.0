Return-Path: <linux-btrfs+bounces-2977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 189ED86EA68
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 21:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AF61C253DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 20:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD1D3D3B3;
	Fri,  1 Mar 2024 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grf8UXQg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781EF3D0A4;
	Fri,  1 Mar 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325441; cv=none; b=h2AvzFMr4byw4dxJ0TbQ+LVmysW5HYwVLnRmS5czUfMYCxqiGxcptVBejIbT+K7wopHgrbBOxuZQYTcdSn55eLaX+VVSQDP9YnMY2qk88HOf5zSU31lvUxL0RMmLIw2I0DyXpbntJZb7HoQOs6d+hcKLJvDioKPF9/WLfrFIV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325441; c=relaxed/simple;
	bh=Fd5/S5DUr9PfoAyFh05f8SSDmVc33i8fOGZwceK3YE8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZK2Rfjg7rL8fjdfJnyNDcC1BKO5WH7rBsGAErmRNOM9HUEtxp/YjOXmznoTc3Ea9H3zFQ7GwGJlDOPbS2Aw/yAlrMWJBJlg7hRlUA5PDf77KZ2gWKYzT3yrSqD7nx9YbtQhvv6WjrszxBWA2zCKNhDKa5s3b239QI1CD4AKjz4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grf8UXQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54BCDC43390;
	Fri,  1 Mar 2024 20:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709325441;
	bh=Fd5/S5DUr9PfoAyFh05f8SSDmVc33i8fOGZwceK3YE8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Grf8UXQghbNlOIz8uh5aC5ihvIaiav+ggKzqv1cFUah9+gLsqLTt/lE2rVUgNI+5n
	 QRwJ30itb+gbJr6yKV89RkJGh0EyLmpqbeFX7ghVtp9i/Fb45u7gvdPa098Jt1Q1yN
	 M2Tu7pjE6NwqTGwcApeMGFqDxb6BBxRkhWElss+LGl7Yh2gdM8ps1ilvhpl9vqm5y4
	 198eE3FwSzhuebOV9Moe45zsUbt1Jy4xPnXxfPXKm9BX7ZNpn4oDF6br62g5qW581i
	 Eb3aUBIG/SH+XUIei77CuLiY9xxHm1WkkD/A1RMVcmUkXX3c36ZQb+u4tzZtiWvM+k
	 ZY7OJuwzmIRkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41585D84BBA;
	Fri,  1 Mar 2024 20:37:21 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc7, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1709299316.git.dsterba@suse.com>
References: <cover.1709299316.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1709299316.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc6-tag
X-PR-Tracked-Commit-Id: e2b54eaf28df0c978626c9736b94f003b523b451
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7505aa147adb10913c1b72e947006b6070753eb6
Message-Id: <170932544126.4935.6759162785846007356.pr-tracker-bot@kernel.org>
Date: Fri, 01 Mar 2024 20:37:21 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  1 Mar 2024 14:32:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7505aa147adb10913c1b72e947006b6070753eb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

