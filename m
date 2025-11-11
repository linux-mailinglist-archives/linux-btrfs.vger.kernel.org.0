Return-Path: <linux-btrfs+bounces-18874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D8C4F8AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 20:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60C6A34C14A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70302F3601;
	Tue, 11 Nov 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hva1dXIf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85C2E62AC;
	Tue, 11 Nov 2025 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888267; cv=none; b=fILwXbBazZEhYboLTgn0P9rbg/6UZl3+Vla7NiCQrELOmWrcMzcPmC5IiB+W+RUWfH3PKkerEGNdQZLG3F9UY+aY8+J1c/8eVNMyNUTks4C579v1nH6SYaq63b1+LHcskqJDWnh5ZBHA2ByJga7YSBpmv7Xts7bWMzyam2fTetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888267; c=relaxed/simple;
	bh=ZS+4A8wFUKQwKWeHSKTeWIBLeNVhUl2e7Xsnlnu7c+0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X0zvpsggGJCXLOym/8mhaWg4/C7QdeGjdS/yyOvyQiCPzCrAUHkw9+R2D5OBBf3hs6Z6AieNMZHFd2Pv1C64nUx4zt8tU4zCiAFJDJ7GdpnWVhszxyg8024RaFNTevb4OJpjgzag+0Xx/Du3EndQN5QoLB8w9vJv1Ew0LUp7NaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hva1dXIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D88C19425;
	Tue, 11 Nov 2025 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888266;
	bh=ZS+4A8wFUKQwKWeHSKTeWIBLeNVhUl2e7Xsnlnu7c+0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Hva1dXIf2XAMlc1gbalqqJxw5vqu4QNPI59qW8hnwoDDqKolHb0Evm6xz13L73rlf
	 puBHfh1CUWLLWDHPhzld49d46uGyjCsZUHVY37TliAqK7Ey5JlsFszT3cbxENgCsIj
	 SSvfQyHiMgGM6Ptn52wptrCyX6u/NFuxprUcn8hP+D1S1mNUf4gEylAbtqjYDOsDJC
	 E8FNQWow1gRTsjeo+D8N7EcFfxZKDJ3mgiB0i/tJgxqC9KKzsOoPzbYCD9QinC8aCe
	 n0snqJwhWmUttnB171w7Q6MH8TTuhFTOFCEBM+X80DfXaX+xUgakwRetoXwthRfh7X
	 dD8iE2Rx4QHTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3443D380CFEF;
	Tue, 11 Nov 2025 19:10:38 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes fro 6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1762852601.git.dsterba@suse.com>
References: <cover.1762852601.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1762852601.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.18-rc5-tag
X-PR-Tracked-Commit-Id: c367af440e03eba7beb0c9f3fe540f9bcb69134a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8341374f67f6e6350de98baaf5b05bca88f4ad81
Message-Id: <176288823681.3549715.1671980215452797411.pr-tracker-bot@kernel.org>
Date: Tue, 11 Nov 2025 19:10:36 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 11 Nov 2025 10:22:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.18-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8341374f67f6e6350de98baaf5b05bca88f4ad81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

