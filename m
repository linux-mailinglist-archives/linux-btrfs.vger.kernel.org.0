Return-Path: <linux-btrfs+bounces-9152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6FE9AF3B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 22:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3691F233C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 20:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1621733C;
	Thu, 24 Oct 2024 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzngCsO7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95642170C8;
	Thu, 24 Oct 2024 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802013; cv=none; b=umv3JpMuto4aJ2JHd3Y5CfkdcVho74X/I3+L0Ocd/1sr1gxgZRgv7SVdZUZRrvra6BvWn1hAVBDarzNG+5GMzRTrwMD39WQKou1gDVXYsOEKofu6KjwLQEgMJVq4Rm8H6b09iyVC3bKUKtuI2mmcJhMlItZciW8fw136XX4m03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802013; c=relaxed/simple;
	bh=Tp5ZDAJeowDuC6t4OmwW98MAJS6XqiZUg79PtiHjBfs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lLVbKLNRoVkaMkBr6RItVhdXJL5XXZCAjd4Ht8xtwxbG578O+5QEWAGGH8wk32x4lJEKGy0bDWYqQ9a05D5HjOicdxPriST280frDUqevUrLLh7tU6VOa6eRZ1k9T9FGUilgKaIfWem49r08Un57u1gpPRFLEfO1upENF1zyEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzngCsO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CE7C4CEC7;
	Thu, 24 Oct 2024 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729802013;
	bh=Tp5ZDAJeowDuC6t4OmwW98MAJS6XqiZUg79PtiHjBfs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dzngCsO7OIG8yHxxuzZHhMa2M9WDor8vVQn9WDFOZi43uImEb77jT+C5BnOkG39sv
	 DlkzqjCn2YnuCk8mzKDSGmYuFQrlIqpIddgbukR9ywNitxA75TRH8M2Fin9oYEO8XQ
	 OSA/223CwV31+EJT5IPrjZAR3KPq/CwadZbQyvLAPAsFmevIdQdKum6HplQ6l1WElV
	 KUJZF7mD/YlRgSeuWMxAMeobQFL/+ufnQsURjeOsTYbgo75QOGLL3WmJhMqYy7izI0
	 Z5KXR2dbueRa0PJRh455ZY5zqTLFsJlz+pmWc02I3agWlWaiuhFcAfzUZT+kdjIYoY
	 Ltx8KazXEopow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7133D380DBDC;
	Thu, 24 Oct 2024 20:33:41 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1729698780.git.dsterba@suse.com>
References: <cover.1729698780.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1729698780.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc4-tag
X-PR-Tracked-Commit-Id: 75f49c3dc7b7423d3734f2e4dabe3dac8d064338
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e46774408d942efe4eb35dc62e5af3af71b9a30
Message-Id: <172980202004.2376768.16927447334209514312.pr-tracker-bot@kernel.org>
Date: Thu, 24 Oct 2024 20:33:40 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 23 Oct 2024 18:07:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e46774408d942efe4eb35dc62e5af3af71b9a30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

