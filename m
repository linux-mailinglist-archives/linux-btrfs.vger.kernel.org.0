Return-Path: <linux-btrfs+bounces-13563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1892AA538D
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 20:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24F23B79D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 18:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D419293757;
	Wed, 30 Apr 2025 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpsgbQ+Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F236293745;
	Wed, 30 Apr 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036705; cv=none; b=BkkItS+/cJ8ktbJd6EmAN8xWqLupYGJIln2+55954I/T97MdEQwCyrF4cotooAAnGPkc3Au6QP6lILd3eUf9gmiNYvM+S9mq8GzhIIYH1m/Af1Bzu6TNH2ehFKQWnArA8Ffbw7Doy9zvVMCszV9N7Uc1lceBxLcxGk/i4tMAAsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036705; c=relaxed/simple;
	bh=DdtBlZ1traGxIM9zclQJAwWBzLqGBYwrtfiAe1c3rHg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VjA0nGv6FPkfjfvF6SSRsZlzCeMaAH3dMx0Q6pBjsQEuU5GgSoL+PV6593vtVZlDLdm+GexBv7dVUjrQzZurN0uimzJtSa5hO0kZe5cfBo2reAUBYKkltUj05lL7nDd7p+cyYcBPCch5Io9KKku3qhrl3MXtvPM2bbiDXkTR+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpsgbQ+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A1EC4CEE7;
	Wed, 30 Apr 2025 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746036705;
	bh=DdtBlZ1traGxIM9zclQJAwWBzLqGBYwrtfiAe1c3rHg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hpsgbQ+QCZmOohV5xLvr9akBRqNFZsLmjE1bW5iahx3nwnbgSZn2VxjUPyvguYsF4
	 XzyFyHja2aAdbzH+/XWgZODGmsYiUYNhsZSdVzhoEp4piebDT/AlhEgBPnkyTNnCtC
	 KX/tk5ZKVlR+BhJAd+PzEb9AZeWZxRna7v1XjNfKeGvJ6lsx+sR5qGRc+1aGw6mwzQ
	 TwZ9mbKpGROgNjjdaKhSMB++OvN3LWG746R9hEwXvRxlr4BOUJ2U7/1pdK+tkPBrgR
	 b2vaGjxJjDmrZNXxURvvJOZ9iSYZDCQ3xBdl3TRyqsv5MHaz7DyRcIEMOXakdma1J6
	 Wvcy2Dd65G6Ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C2239D60B9;
	Wed, 30 Apr 2025 18:12:25 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.15-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1746021929.git.dsterba@suse.com>
References: <cover.1746021929.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1746021929.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc4-tag
X-PR-Tracked-Commit-Id: e08e49d986f82c30f42ad0ed43ebbede1e1e3739
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a13c14ee59d4f6c5f4277a86516cbc73a1383a8
Message-Id: <174603674410.2436692.8319097664158648842.pr-tracker-bot@kernel.org>
Date: Wed, 30 Apr 2025 18:12:24 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Apr 2025 16:16:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a13c14ee59d4f6c5f4277a86516cbc73a1383a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

