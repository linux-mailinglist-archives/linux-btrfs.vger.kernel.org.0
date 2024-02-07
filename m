Return-Path: <linux-btrfs+bounces-2203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F087684C640
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 09:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1F9288426
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 08:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D473200D8;
	Wed,  7 Feb 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHNHlJct"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D00200C1;
	Wed,  7 Feb 2024 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707294405; cv=none; b=B6zCstqZ+HFbYjPpxUUcTZV19fR6nsnAJmMfoIRA7vrgmb4BSAc0seTJL8/rGJ4pG7TObyC3Ss3djiMBsqg0hUOOw3NpJWlNc1GJCu0PI6PzvS0JoMqkl0BVBi/ueKKcT5cJcRvH9NIv7zaI+KC4XFnqY7Qa6/jxwLafYTyF+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707294405; c=relaxed/simple;
	bh=osQMa7pCBEdS0Q9sKeFh2vkf1PHGOAnVB94u9xFcYIo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mnyAWRz+1nQ5kU9trFdw7/ZozVdZGk4lmXyQ5eeVP68ycRoKfGc5LzYBbtVKPjWQqcN1j14b8kl0saon9zyMXBzvK7ruvOAm1imItAFdHjCpw2oaMrJJ0ajsmZKAdQoA93tSdLUUtHwljU+fB4F1xVwkWXk7rUahI1jCzpcwkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHNHlJct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24C7FC433C7;
	Wed,  7 Feb 2024 08:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707294405;
	bh=osQMa7pCBEdS0Q9sKeFh2vkf1PHGOAnVB94u9xFcYIo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SHNHlJctmZvjX1BOZKXzstdT1X/dtpCanaHgMRndMhWCOk2wqsL0XFJFqvuGWtP8b
	 82IfP4QdF0zvdcQWrFimheRvu/IuEJPa+Ccb7g/M0Qoy+66rY/Dqqa7TMAq8mb/V3n
	 TO16XUh5IhSwA9OP0wTrUN+twwQMeOLIRO1rrQKkUHfPiMqfIJ405kEGPC8kilenO0
	 rVs7FM4O2ictk51B2dTjVb8z8Sj+bWiXisiRHQl4rPe3Ho5kGtaz8pv88RtRVlYaGl
	 FXTyLiu/mAobfme0mNI/r9pouusCD1eUFzCNCNZPGRaE3pIcpoKzIVmPBvi290GRNd
	 xSB0pKqdr3z8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A153D8C96E;
	Wed,  7 Feb 2024 08:26:45 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1707292515.git.dsterba@suse.com>
References: <cover.1707292515.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1707292515.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc3-tag
X-PR-Tracked-Commit-Id: e03ee2fe873eb68c1f9ba5112fee70303ebf9dfb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d280f4d760e3bcb4a8df302afebf085b65ec982
Message-Id: <170729440503.25210.17097301464046077096.pr-tracker-bot@kernel.org>
Date: Wed, 07 Feb 2024 08:26:45 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  7 Feb 2024 09:15:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d280f4d760e3bcb4a8df302afebf085b65ec982

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

