Return-Path: <linux-btrfs+bounces-14024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E48AB7B19
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 03:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB1D980159
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 01:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F1C280031;
	Thu, 15 May 2025 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+srVxhk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D529128002F;
	Thu, 15 May 2025 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747273530; cv=none; b=j1T0mfL9DY0tpGRZB16eiF3AIyQejvosUeuhUdZ0U8mDoVI07rIMtfisAdhFVBXvf1YUtCdc7k5CDi/aAYPYk8dQuM3dSXxf0TR0xvqOXgo5FWKSQn1rXdCWvlDRi2q174X8SCEkRK3rijDUBRClnI0ff9KGy4YUbnYSdimZzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747273530; c=relaxed/simple;
	bh=bjJ0cNtZ6cnYHlxdUBktjOoyESWJ6mKN5hXaiwUlMnQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ly1NODz1IHA2P1eK7NXBw49//sl7Xcfy6fv6lLo7OFnV+9tLNJY9xhHiNHLpHiwqvXccoFOpfYAAfb2iXV6DYGG+UzPOPvrDRX6jcG77iuVJixzgzOy9vnHdc2gLjjjIqegNGSdWw/Vg0Q67Kech2y/nnBA5dxeF93l9Eqw1gNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+srVxhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD00C4CEE3;
	Thu, 15 May 2025 01:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747273530;
	bh=bjJ0cNtZ6cnYHlxdUBktjOoyESWJ6mKN5hXaiwUlMnQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N+srVxhksZ2d2QiDcjfkFrXqTHvI+nFaJpdFZRgWzNZDh3oxtyUSxI/Le0I7KxBic
	 0KvhCY+fF7iwv5LvMHtZ70uIWhwScNNUWFoY/mH7L06fo8a/kq2h1fEyqeDvmdQj1H
	 w/KqC9RV6nca1MrSqP7g+MotEy7nsV45N9n4fZZ9TatUvrorEhxmoX0pxCuSqwTHUJ
	 VSODDqMT2657hrE0Fx1KZlogipB6yeI+QtOT07yBYIcKTb6mdt6/WdR6JSOm9GsMB7
	 Yi+MM3eNJScN64mWYO18EPXbJj25rBbX+EN2uOgn/CuVP1tApwgNZnziyKZuvK3C44
	 8smIDhQpugOEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE776380AA66;
	Thu, 15 May 2025 01:46:08 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.15-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1747268650.git.dsterba@suse.com>
References: <cover.1747268650.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1747268650.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc6-tag
X-PR-Tracked-Commit-Id: 4ce2affc6ef9f84b4aebbf18bd5c57397b6024eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74a6325597464e940a33e56e98f6899ef77728d8
Message-Id: <174727356729.2574388.16619646416588893575.pr-tracker-bot@kernel.org>
Date: Thu, 15 May 2025 01:46:07 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 May 2025 02:36:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74a6325597464e940a33e56e98f6899ef77728d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

