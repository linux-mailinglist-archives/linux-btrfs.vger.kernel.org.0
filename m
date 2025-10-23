Return-Path: <linux-btrfs+bounces-18217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A67C02AEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 19:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C3B2584CAE
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E79C343D92;
	Thu, 23 Oct 2025 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSm+qY26"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F952609FD;
	Thu, 23 Oct 2025 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239001; cv=none; b=n/JrpZDDcblmU0h3fsFcYGF+TQsLwGhs/anBsgHs2sAgOYQ44W63iOhf8/403S+0SFsOK71vEGZwoNEJPRDlDpvgoDoIUx2Ck63zU/GAHukj8XXoe5XUFDU2vmI775K2t/Vo6nFlCRyRzrJir0tAOSSm7dTIrg+mUrjMUnZFiSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239001; c=relaxed/simple;
	bh=1XYd8roDTSXTVWgDAtrClF6JBRNa+Uc2LjD85V1VxRA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r4YW9BKmphuDQE5TBsNJw/YRWsCUEOPhVaVDqC51Me/3+xQFeZQOQ0DgGbwZ2hEkRyw5+iWyCcGwt1XOa06lG7REyLVc1V7ptUL8HQyXWSf7xBp9SbaUvbFP9c7/ZKw5jKnyYKOK+kqAmMHQoe0UODRw2A8Gnk5vLhji7nhMjqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSm+qY26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15279C4CEE7;
	Thu, 23 Oct 2025 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761239001;
	bh=1XYd8roDTSXTVWgDAtrClF6JBRNa+Uc2LjD85V1VxRA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dSm+qY26Q+UjdsczJbdWyOyeUgAVMabnB1mSwzIaLZejd+7uH8AYJF6g2659waPWF
	 wxAQ/VsXFrNNQNaK3HujSMjEATH2U2mcNvFgT8ifkW5f4a8G8L9/gMxGRsYP1dv5Oo
	 Vy6CwnZ3Ykc9TulM7iRjRg+OZpCFQmejMUGOBAa6dSJpN5wHNA9UsfJE9Hfc5OP8vM
	 5KNfdUXxGA1iyKehD2Pd00lyR9xz/UIGb8zVAamqdg/hzieQYriwr1aZ17AR/JhUQ3
	 bD1oI6MhmI8lpanHUVzaSanrWAYU2ckme/FxIyxAOv4KuqESIJWV7nqSKu8WwYdyuk
	 yZKH9Du8v5ZYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFE7380A94B;
	Thu, 23 Oct 2025 17:03:02 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1761202410.git.dsterba@suse.com>
References: <cover.1761202410.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1761202410.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-rc2-tag
X-PR-Tracked-Commit-Id: ada7d45b568abe4f1fd9c53d66e05fbea300674b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 942048d46abac01e1219c5833701ff5b0cb52e7f
Message-Id: <176123898122.3171289.6383220414838192043.pr-tracker-bot@kernel.org>
Date: Thu, 23 Oct 2025 17:03:01 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Oct 2025 09:16:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/942048d46abac01e1219c5833701ff5b0cb52e7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

