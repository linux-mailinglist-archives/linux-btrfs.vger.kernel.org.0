Return-Path: <linux-btrfs+bounces-14883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4041AAE555D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 00:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813F51BC47D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 22:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4401F7580;
	Mon, 23 Jun 2025 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzgaeiND"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1AD226888;
	Mon, 23 Jun 2025 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716588; cv=none; b=N9fMOsDvxR1DPtSU9f143zkIW2IZc+5hG771xhnE+3xeDXxFR6HJSBncTNoypSzHcJbe0HF9TuOcG/BeNWzAgTc53EQK4JkRr3fJ/M2sl74TjdTB5RdrHdSsS7OF80KliuawnafNVVNkBERpZ+R0+hWd/TZ48zToRCJEzpsNNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716588; c=relaxed/simple;
	bh=vuZCSMVYWvUtOwjE86DxK5/zdd67RYExi0NFyVxEev8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a79fuYiLmhz0gwMVj966P+LHjRwPX5M1CGl0ECtVAyNzCYIHjzyejONjU+hWOV7QFXPtyWHraBC7hT7x9pkrdxZjyV9ym1DBeTKrAfBy7y+dOpZRDElWr6TtHzMbLwvfU1vvA8uVomg2szNE5yV5hoNKtoGKvqMDP6uZddmjcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzgaeiND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20E3C4CEF1;
	Mon, 23 Jun 2025 22:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750716587;
	bh=vuZCSMVYWvUtOwjE86DxK5/zdd67RYExi0NFyVxEev8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UzgaeiND1o+dFG1gjfUYgtAnmgfTUBRX068/9TgTLx0h0n4HW+fHhQlX4XFz8uhSb
	 tcx35cpEH5qxAkMF3VL6iMI9O1k+o5bzavUsd/3N+ww3rO1hJiQK58sG5uDN6ics1T
	 biEQfLQ0YKDeW9ds/MZ0rnnxpfr2tJ85Ay2Ml3cNbNEJl53WjveKZX7QYPKNMi+3LE
	 vQO8Nrkm68naKcfBPrfB1+tGwiiRBZ3SwnyFaRd8T6nKPrLUhcgw7viKCz7kWzpOSs
	 bQHnK5fN5nhw2L72Z28emlaQH03d+Cf6iejXzBF5z8qjdPbbcyjFGWzb0uOvoaDafr
	 6goSnIafTDO5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D7C39FEB7D;
	Mon, 23 Jun 2025 22:10:16 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1750680667.git.dsterba@suse.com>
References: <cover.1750680667.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1750680667.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.16-rc3-tag
X-PR-Tracked-Commit-Id: c0d90a79e8e65b89037508276b2b31f41a1b3783
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ca7fe213ba3113dde19c4cd46347c16d9e69f81
Message-Id: <175071661476.3311076.6840053159089469088.pr-tracker-bot@kernel.org>
Date: Mon, 23 Jun 2025 22:10:14 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Jun 2025 14:43:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.16-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ca7fe213ba3113dde19c4cd46347c16d9e69f81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

