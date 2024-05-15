Return-Path: <linux-btrfs+bounces-5002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B78C5E70
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 02:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD551F221C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 00:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078581755B;
	Wed, 15 May 2024 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6uasugC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8BEEBF;
	Wed, 15 May 2024 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715734395; cv=none; b=GmTCK3TI6C+jYRYCGSEBCw/A2Wh/iqvV9k1hM51Jj74A1PB8uyha6PPNCadgR9qUYBePnDwIh2ANgloqYH/gbyHTROU34DMqmxvfrZSZCZuedkxHg35JQw9C1mEt4FdFVbwKJU/CGi2Y33COebsjpZxHMux+MznKE9pc/cYSF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715734395; c=relaxed/simple;
	bh=PquVyaaZywl6e1JDcDCrYW70G8BETjaYaQT/vtvYPP4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F0PlH7jbY6HnmMdD5NiMaS94kjJA2n5FISFeSrEjqxeBxLh3Rr4ncjecdOfF6V/InZIE/6RIg9wQ/WlEuHmH6hR4/8e8YLI9iFG5mYJUwrD8ATLHbfHUIZst2WR8bapGZ5PcUqa0UKJrhq7eCcUsU0QUkUONQpGpypp7ySAFfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6uasugC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B07CC2BD11;
	Wed, 15 May 2024 00:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715734395;
	bh=PquVyaaZywl6e1JDcDCrYW70G8BETjaYaQT/vtvYPP4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q6uasugC2shnDZcWQiUSaZ9wTIOuY4X5j9FRcKIFpBOjfbnfbcc+DmNECZKVhn228
	 xiGHwcV+GBf+uJ0kkfrr2AqWwLUXb5R5zevatyUDH1kgCULgzrIbpUrt/yg2kGSo9+
	 4gmPlOzo3hzSDsjCE+h1GGNskgLNgmJGe+QoYOkv+pbHEwLa5u7L61r/03x93aj7+r
	 jNXhJWYO83tAmMzzvscfsD5XXHxfJMLgtnlvNF4rW5hRJLw4IAH11f9JjXjrmpupR0
	 /kwujHa64KgevqQDlyA1IRYD9esDuSRHEsxmQIcWYSs7KSgE24c8kzfqTuqhNhyhC0
	 aURO6hGNxGTcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F392DC3274D;
	Wed, 15 May 2024 00:53:14 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1715616501.git.dsterba@suse.com>
References: <cover.1715616501.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1715616501.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-tag
X-PR-Tracked-Commit-Id: 0e39c9e524479b85c1b83134df0cfc6e3cb5353a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3d1f54d7aa4c3be2c6a10768d4ffa1dcb620da9
Message-Id: <171573439499.24206.7589465004328503878.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 00:53:14 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 18:20:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3d1f54d7aa4c3be2c6a10768d4ffa1dcb620da9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

