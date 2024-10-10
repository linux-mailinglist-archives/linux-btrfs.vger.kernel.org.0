Return-Path: <linux-btrfs+bounces-8818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FA6998E52
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 19:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5C51F259BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68419CD19;
	Thu, 10 Oct 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkQsFpk3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E593199E88;
	Thu, 10 Oct 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581418; cv=none; b=JJKxuPi+Vzb3GTjiVWqIG47CCKpvujuHzQAKuxrA8S1fKKGR9q2f3d6w+r6LZEKSiEaDaqbWpXFzq/79HAkybgi3+u+APRZuW2hOpwzsUQERdgiRGtXqvsgfPjKdASQF+n7aE37nz5gyIsldlBiDnEl9K40Dzm+NpGni9SLEiNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581418; c=relaxed/simple;
	bh=XpGRAGtyIsiEHPmjp/KaxtwHf6HZzgXUKIaW/Wjya58=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JEvBxODfFiTsghujc5uWTqyGDiki5gKOa85Cm4FJjxTHvACJA1TMOoHozmRQkVi+4BpMMmJzpufJBrQjpUrXJrOyly7rm/yMTpAhBXZsjK8LwBgdtqHkOf+bnm1efrBqhzMDryoaOzhnU4XX/Xa31If6XwOg1so/xUM/p3kY1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkQsFpk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BC8C4CEC5;
	Thu, 10 Oct 2024 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728581418;
	bh=XpGRAGtyIsiEHPmjp/KaxtwHf6HZzgXUKIaW/Wjya58=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QkQsFpk3jc348bLUkR6DV5qw1h2SmIHN6xJi5xxpUeF7nEjimWi0+OKuNK3nQM1Cl
	 jgFEFleUVicrTMgNRshAkamAxcmVrRPZOAdBg7Ko3DDXu6gxP5nI9JYuths3ji320G
	 emQQsa9plZHnDO+1sYT9QeJExTacCqVh2iMh8/68RhLrA546SoUZ0bV63Tx44vdH93
	 gIpkhVJPjXzZ/TdKLa2eN7bZt0gxQtNJ1xd8ywYQ6RLsgvecJ9X3g/g68Ci5khY9rK
	 V46b6k/alcIPFTFAaSyqIxO7blWGeOH8Khv5MNoQyb3qG8qES//g/EyRi2ZA9zeCXP
	 Urg+/S/LHaykg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77F103803263;
	Thu, 10 Oct 2024 17:30:23 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1728571063.git.dsterba@suse.com>
References: <cover.1728571063.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1728571063.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc2-tag
X-PR-Tracked-Commit-Id: e761be2a0744086fc4793a4870d4b5746b7fe8cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb952c47d154ba2aac794b99c66c3c45eb4cc4ec
Message-Id: <172858142218.2104012.8283558730005244193.pr-tracker-bot@kernel.org>
Date: Thu, 10 Oct 2024 17:30:22 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 10 Oct 2024 17:01:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb952c47d154ba2aac794b99c66c3c45eb4cc4ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

