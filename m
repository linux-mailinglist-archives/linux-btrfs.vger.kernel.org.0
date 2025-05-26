Return-Path: <linux-btrfs+bounces-14243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C83AC44C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 23:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB201882ABD
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 21:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA592475E8;
	Mon, 26 May 2025 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKLKu2h9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D552472BA;
	Mon, 26 May 2025 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748294420; cv=none; b=Pt3x7LXlJs2EI2YfcZEHAywXzLc52aRgwqRHAZa+USbrteiFf3AHv8V951Ab4MiOmGSD0DO6PzjSZmGwxHER8Jlb1YoD4FFMlFtq0SnARHy606TVnaneDf0/ZjB19gUhJLr66UklIFjGIVxMtMEHrX6w/7rTCiS9b2Fsfuqa/Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748294420; c=relaxed/simple;
	bh=9jT3/zOG9qPaOEZV0ibvv/JRK51ws8ugr2D8F4HbPoI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YZm98noYN/uMRYnvyo2NicTdJ3OUa5OWWL7I5sE2Kx+Xqd0URZsfM+vUydLiuF88GVEHLyl4TfCZgn/WFu5q+TaZM5oJ1vyqWb5pYE+zM/YbXEJHWhBt3O5RcHncB9liwDCGoj4kavC4e4QiuZGZAhb8BiB3tmHVVY7PynTdHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKLKu2h9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B75C4CEEE;
	Mon, 26 May 2025 21:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748294420;
	bh=9jT3/zOG9qPaOEZV0ibvv/JRK51ws8ugr2D8F4HbPoI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UKLKu2h9dtCAhSBd24wm7DKEdjPtarAoa2DkkXx4MWfND0+kuIYXaHmv8ONP3B0Ds
	 5GwTcZspb7Qc6bo942EipQGOpXAOo46LWhDmpZjMoqmFvXVMD3HwRFTiuIpqigUe92
	 N1YzacJaYOhV3g4kdJrT25mdADKq2oqXnN6Szvuf5dRJIv0Dw5OVzMs+2KPaZXua74
	 znaxQiJAM2tmINND95bYbUvPiUa1zwzqgNW1jwruMFzhj6OYsJ/LOHRIok0IEpYc0U
	 EJS87GqtXkau96x6Rn3YyOs/AogYSAxEbN9bU04cY5XxzXYkZ/4ftOuwx6UBI2QWvw
	 puVKAPiZXJbUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 36DC13805D8E;
	Mon, 26 May 2025 21:20:56 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1747826882.git.dsterba@suse.com>
References: <cover.1747826882.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1747826882.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.16-tag
X-PR-Tracked-Commit-Id: eeb133a6341280a1315c12b5b24a42e1fbf35487
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e82ed5ca4b510e0ff53af1e12e94e6aa1fe5a93
Message-Id: <174829445502.1051981.7648836311921832304.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 21:20:55 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 21 May 2025 14:51:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.16-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e82ed5ca4b510e0ff53af1e12e94e6aa1fe5a93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

