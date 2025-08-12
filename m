Return-Path: <linux-btrfs+bounces-16026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A22CB22CB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 18:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FDBD4E4249
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A8302CDB;
	Tue, 12 Aug 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/KqqORa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D642FDC4F;
	Tue, 12 Aug 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014419; cv=none; b=GbaKqmFUBPYD3lbx4kc0fMJG34fTArCPM2XIL0iP6tZS4HTALd18vv2eChFE7sLYt0mImG441aXEZkVYVvWwden2Emy09aPE9sC5o3HVCqivYYOhDVD+povSqFTv/72RrSl8U7UYlUbSGK8cGU5ALl2gTO2p75tQAjDz0VrDjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014419; c=relaxed/simple;
	bh=UX5g/gmO6xHLuNJ9vAbO7ZMw6R35A99cvh7i0kLK3/4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tJSbkFctRfuRxQrN6zgwVz7dJjHC1rFxBdoztEz6TLcoBBfqnXXFXdctWa+XpHo6iKIQZengQj0Wb39S4JyEk8673jHg2rZXxDV4nl57FxL/mVvQj6ktUz5WgVPZjBpK4cXmrbXoQgk+9IzyhDYB5vXuete9HbQiI2OMu4VemPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/KqqORa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3979EC4CEF0;
	Tue, 12 Aug 2025 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755014419;
	bh=UX5g/gmO6xHLuNJ9vAbO7ZMw6R35A99cvh7i0kLK3/4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I/KqqORaJCxOO3WvR3ZMLIj+50wok8Dg+UB3a4s/pWQ/6rFn7iBhiqxnon2oXCINP
	 rPb7ABsHtEwHzne94fAjk6Y8kBdcEkHwyarj7mzeGaUo+2TCmz9Ixm60lmlSV1d19I
	 AorzCbzFR2hlSEz5PvlRm7H50SRFpDzK8/DWkl6uXZO5vPMh346d6DwtC7ZTsJhSMx
	 AyYY66WHEDzJ+CgY2/wp+onxZMWxhVFDLU4Wn9V0G4Yisv81AB6sET37371rvMYGQk
	 qBJPSutrlsbckrWmYytFcpNECLJYn6eAUo9gV3Tb1FFj7xgv8SZPk5YTBDeH7rjEBX
	 CW/hfdth0aR1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71077383BF51;
	Tue, 12 Aug 2025 16:00:32 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1755000200.git.dsterba@suse.com>
References: <cover.1755000200.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1755000200.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc1-tag
X-PR-Tracked-Commit-Id: 7b632596188e1973c6b3ac1c9f8252f735e1039f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e39a731820ad26533eb988cef27ad2506063b5b
Message-Id: <175501443130.2711336.16429419707562273761.pr-tracker-bot@kernel.org>
Date: Tue, 12 Aug 2025 16:00:31 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 12 Aug 2025 14:26:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e39a731820ad26533eb988cef27ad2506063b5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

