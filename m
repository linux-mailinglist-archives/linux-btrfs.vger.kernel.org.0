Return-Path: <linux-btrfs+bounces-17143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE3B9BAFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 21:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2652C42784B
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 19:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18831AF2E;
	Wed, 24 Sep 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJutD7Gd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025E263F3C;
	Wed, 24 Sep 2025 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741793; cv=none; b=YGsTAd3EZX+FZSnQxQPwMkni9Mu1ahQdx8V0dwmKoU2PdTemoUFvpeG3DBlHG2wPwi8tLsiNp4l6+Zip1jD3KAbh7rwdRY3PY+HYGxP6ogzYP8VE7Kc/nqw0hN1BbmmYJEFir+YuSrbxLxNNbt98c4kanOyS9nBlU1soOTXyFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741793; c=relaxed/simple;
	bh=YPi9y6hpo+su4MNBvdpsIJIjb3+QEfymzf2opRRE3/c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DXiqM0DPLWLqX+WhPC08z4NOwEv3EfcgnyFhW3gpyhhpZ79d44ky+SgmaX5IfjvpVhuIeJn/tuB9I5e44LW1+I05fZRWQolZnLm5h8jJGtIZsYyFALbonWQBYspakOLZ1g70sF9M/eXF8fgvCcEH0oizpvRG4aOxDbhu1EGPAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJutD7Gd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8213FC4CEE7;
	Wed, 24 Sep 2025 19:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758741792;
	bh=YPi9y6hpo+su4MNBvdpsIJIjb3+QEfymzf2opRRE3/c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TJutD7Gd9ULnun/7cHkAr9RkM691SeKNvgBus5JPcAQReN7H6WU68dX2QbtBLzZID
	 9hAyUpRXpCp4VSCJW4fEBVXYpTPp7YgM0XQp+wTk9MsFcU1NO3vPqb6QVElC0BHEyU
	 nTjXcDAn/7rHyjxZfLg7+66U7TzF4wyUhTyR3jTRsxGlptpDDCb7xOHcnjnMUSxuJn
	 eZpVYirIgfo+GpkasvcN6knO+3IxDOzuA2jLor4jWBnsMIXFRWOqPeoNRcUyOAKCOB
	 pwNweOW1d1ruwUcEY42vEz5Qcfof/JY9Lk+9hjBayxyMmTwS+whPDU3UwPHwYErwdP
	 E+qISGf3wi1rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D8C39D0C20;
	Wed, 24 Sep 2025 19:23:10 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 6.17-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1758686611.git.dsterba@suse.com>
References: <cover.1758686611.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1758686611.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc7-tag
X-PR-Tracked-Commit-Id: 53de7ee4e28f6e866ac319b9db6e6c1b05664c32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74c7cc79aadf40fc14cfa04379693d2a3751e6e5
Message-Id: <175874178876.2659978.3447230396824136612.pr-tracker-bot@kernel.org>
Date: Wed, 24 Sep 2025 19:23:08 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Sep 2025 06:16:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74c7cc79aadf40fc14cfa04379693d2a3751e6e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

