Return-Path: <linux-btrfs+bounces-13730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34BEAACB2D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 18:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C841B9823B5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3899A284B32;
	Tue,  6 May 2025 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2jEwtMD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BCC2820AB;
	Tue,  6 May 2025 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549462; cv=none; b=mR155DBYK5OqClh8CHlHAtKCEygSfyVrF1UVz7L+gNxrpuFeWIYS2XPJZOPH9MSQTzpn7+Q+68IV6HA330+1pHE+3nGeULhtfPnxCFjvLwKoTEyhpoaijbERxs9zAgCDJL6IoKgizrFhVT95I1pEuWSMvf7GrQmcjpjaE7oo01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549462; c=relaxed/simple;
	bh=J9GWLqE0n4MqqFEJBt0JLJMcBp4u1LJMriizGxzwebw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WvWN88SHhRBJZbA1KCb7QG1sLmn9ySC/10YrhgsSSIsAEPWtj6zYO6j64KkdJE4+u7JNrlioCGF6zNnCxbwvDMywa5QJurdI0hAAW8G6LZ63yLb6qLP8vwzbISfapzlLoEH86bgrlcBqEjo7FSD23skrAJ5u5fYquqZ1eWVtRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2jEwtMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585E2C4CEE4;
	Tue,  6 May 2025 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746549462;
	bh=J9GWLqE0n4MqqFEJBt0JLJMcBp4u1LJMriizGxzwebw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L2jEwtMD0kMO9WIXzIgYHcQKF1FeZHfDEDT9oOwkk3SiIZwGJnQnL+bPy0i7tvDRC
	 VPK829YSF6EGgINFKtMlMX8Uq3g0e64g+VuJjqkWyjbddo7Uh7HPJOvlTfaaDBCYIo
	 HelLaUqa3uk1f0Sa8cCVLx7ABahb/5hE6/tN3f/aGONs+t67UJyQZ94OjVV0YPn6nO
	 Geeu7pykludSsQYSUOfhIMEsIo9c7AP2pMUUI+LhzMfZhon6EBPR4lC09tEOIx1Qgc
	 j52GoKwBKFLlfjX/PHWPQ5jIcm5D3M8ps4oKoDzIZh2hHr1M6PliHYoekvu2jcuuL4
	 ThEkpuuCntzGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE114380CFD7;
	Tue,  6 May 2025 16:38:22 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1746539430.git.dsterba@suse.com>
References: <cover.1746539430.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1746539430.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc5-tag
X-PR-Tracked-Commit-Id: 38e541051e1d19e8b1479a6af587a7884653e041
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d8d44db295ccad20052d6301ef49ff01fb8ae2d
Message-Id: <174654950116.1583977.276059746536554841.pr-tracker-bot@kernel.org>
Date: Tue, 06 May 2025 16:38:21 +0000
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  6 May 2025 16:06:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d8d44db295ccad20052d6301ef49ff01fb8ae2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

