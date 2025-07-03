Return-Path: <linux-btrfs+bounces-15234-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CC1AF8320
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 00:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975293B2526
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 22:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6329A2BEC20;
	Thu,  3 Jul 2025 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rh/E3xXD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9422DE6EE;
	Thu,  3 Jul 2025 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751580699; cv=none; b=eJP9Ec+cOawi3iTz0/MOkmxoW+4ua7j1nZ1Kaxp4bOa5bMcZZcugX3Ox8QJkD7hti2FUe3uUJkqdtRN7BDqJfx7QEd5DG11GX7ocVyZFO5OBkrFuQCotTUPmsdaXfDweVc7M+vUcRLXlmG8/5PZhSRJvT5F3z15gZq0qyK8n7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751580699; c=relaxed/simple;
	bh=g9SCffIKzZ24dS5eY3YbP/pqd56TdfLL1V00Io3Jh1c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IcWOHdFXLxqZCyvzHfQsq7PM2+/ZN0VQ75kAkvrkgny1AvXVlDojZ5PP/2NOdXiBElVjoJ/6Zg2IoaFD2A/3HjhlmMINDykDvrMhWA1B5cx7MsT9LF0HH61PLlXs+alrrX82pfcMoCEjS/mZmOF/Q+mX1YbPbVs7dGNtDGUeHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rh/E3xXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F282C4CEE3;
	Thu,  3 Jul 2025 22:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751580699;
	bh=g9SCffIKzZ24dS5eY3YbP/pqd56TdfLL1V00Io3Jh1c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rh/E3xXDcrKTBPziP68klMeItd4VpuF3PZKHvU+JrMCgDlWWdGRTYS47YaFvG7tIH
	 ZDoeB4uDJaV9+2yZgaxVjc+fvfUvsG16KfDcvByYnlC7ZHpsrGy1gSoT252CwWQfea
	 Hlg0776ZvqWGfa60oQ+NuErlx1U6+TIlK1NFqa97QFjRVfh6p5Ei1dkU5svLlthoWM
	 OJSbYXh4hwUuNwCBpm8VIF+gv25VMZwzD1xkexm3QZIOYs09Ebdpi3mAXeb1GTWs9e
	 J0izQWpmBlOspRrWt/S9g9WY5U+d6ZRa9Q7nWOTMopjKzSdxo2pae1qhm6gKq4xjZp
	 wPoajCrtFEa4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB243383BA01;
	Thu,  3 Jul 2025 22:12:04 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.16-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1751564436.git.dsterba@suse.com>
References: <cover.1751564436.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1751564436.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.16-rc4-tag
X-PR-Tracked-Commit-Id: 157501b0469969fc1ba53add5049575aadd79d80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c06e63b92038fadb566b652ec3ec04e228931e8
Message-Id: <175158072351.1631256.15942682648522222538.pr-tracker-bot@kernel.org>
Date: Thu, 03 Jul 2025 22:12:03 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  3 Jul 2025 21:29:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.16-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c06e63b92038fadb566b652ec3ec04e228931e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

