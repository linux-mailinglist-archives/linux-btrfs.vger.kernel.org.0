Return-Path: <linux-btrfs+bounces-10041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80C29E2CC0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 21:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63BF0B33D76
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B86420010B;
	Tue,  3 Dec 2024 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ickkarxp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84E1FCFF5;
	Tue,  3 Dec 2024 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733252702; cv=none; b=Uqfh+tmZ3Bi2Fw6wqxUgONvz3Rc+vc6uCgc1zroMOqDDmCNE7mOMLgDpLSJy2J4yYztC6iES0LblFtQm4Yx0I3Twgz/hqGc4o8kDbBQLg9HGQXW0JtNOBekroRZ7zDWtRO42x6D5RpX0JP/fDS88ybltYr2CZPG5Tais195BDQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733252702; c=relaxed/simple;
	bh=pwVtKvgH1KOS+DoDlqU3FCNMBsRiFvMTiWrDWt5LEqc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qsr74ESF+2M8whsF1wQ0k1h50bxfIbWV68MK4Fe89X2ggsjnraDfMt2cq7WldpFzTrY5K9ObfCKw9njFI+x0RCdSPYklGg+r+9ic5UtSGcQGy/eQWKhvMeC2KWDfeekGCjLfYiU/1BhCeo11C1Jo5YEJseCAfOK51U5scAlJL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ickkarxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B71C4CECF;
	Tue,  3 Dec 2024 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733252702;
	bh=pwVtKvgH1KOS+DoDlqU3FCNMBsRiFvMTiWrDWt5LEqc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ickkarxpFiHTCr986IkdMAkwYlOvdjvatsQtNSi9+ACUjvoUFoYfWCgTS8MOyczm4
	 ItdLso7wm7LoPtLz0RMS2nyXaenljysdaHLe+uVTAOqFU0Uj28z0opl+NxECgXxbba
	 1npEVw9wXX0fIQdZkfzcdmhIVmBH8OH3AnyF0IfYDCL2EGARu7CochZVPgnvTUeooA
	 G/nJaH1LUgIWQvxbDoR/Iim3vIzpOUhIu5cdaJs5EOZ2Bscs2GXgBQfK9eIm1medGt
	 aC8LzZ0nijPYHqeMB+jvix9VdIDUEhk5wvjrZc3Gu5eBSR84VNqrugOdOlYTNIICZX
	 WJCRq/HdSPn5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0F73806656;
	Tue,  3 Dec 2024 19:05:17 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1733243359.git.dsterba@suse.com>
References: <cover.1733243359.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1733243359.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc1-tag
X-PR-Tracked-Commit-Id: 22d2e48e318564f8c9b09faf03ecb4f03fb44dd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: feffde684ac29a3b7aec82d2df850fbdbdee55e4
Message-Id: <173325271626.214632.6363266752775842869.pr-tracker-bot@kernel.org>
Date: Tue, 03 Dec 2024 19:05:16 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  3 Dec 2024 17:44:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/feffde684ac29a3b7aec82d2df850fbdbdee55e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

