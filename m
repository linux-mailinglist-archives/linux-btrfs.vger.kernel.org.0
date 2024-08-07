Return-Path: <linux-btrfs+bounces-7031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2FD94AE9F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 19:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E65B277C5
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 17:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7463713DDD9;
	Wed,  7 Aug 2024 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRLQDZ6h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AA513B58E;
	Wed,  7 Aug 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050121; cv=none; b=qc1a43X65Qg9MniucNVXUrqB8SMdqGDaGxINvM3fvaTredyFPM9kt5rq7rdenqPeYIIN4ADhK0rDiCuLqQ6mB0UBg0D1yXIa+fbpIk9cbQj/PkNJlVbESeaLzBU2rDN/NeipPZWCRHVweyvsaEiCVFfLyh4BtzJz+MshM0xsGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050121; c=relaxed/simple;
	bh=tjSuAwkUsb25i0r6fVCP1FIwcbcqMXNj+zNqGk77ej4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=T/4gWtgnubcEBKb407JOiOs+BgJCFGNoWADWfBTuzeCLFlqhUJRMcKS1DrTd9+41Gro7IGRQNgXda39mKJWPpySBdjiricqWZgSVbpBUWVWmOhnucSQDwg092Th9iF2wvmJ51uK071xOLhsaeCNGwT27i7LSOVmFz3+VkrydUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRLQDZ6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F7AC4AF13;
	Wed,  7 Aug 2024 17:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723050121;
	bh=tjSuAwkUsb25i0r6fVCP1FIwcbcqMXNj+zNqGk77ej4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BRLQDZ6hQ/a7S7f13i/R0A7RmebGZLSUgvInis5cGZdO4Xc5EXhvd6UAczdL7oHD8
	 +7YnaLb3JXeBqsIIHuWTMk/QFg7/BGO8uTd69w3o9ZlR5HZKzkqyjuKSnxsPWcWTLN
	 j+J25MrpkRe5C/bWExuTTq3mKIMZVH8Pxeb6Yr6Si8zlw8iRQN0TjUPlATiBmX/a2L
	 2szdTJUf5WB7p8Gvn3j+X8lxHkR2kPp2FtjG6TqWIRFFZC6mvgQcA1YOdC2AUjvKgl
	 e0mVEISY6HKwgR7oICmb+s7p9HkcK+Q4n6rL9dNKp4mAV21N8QbNt9TE+5NUAR/at2
	 lEMQC+iDQbGzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EF43822D3A;
	Wed,  7 Aug 2024 17:02:01 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1723037280.git.dsterba@suse.com>
References: <cover.1723037280.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1723037280.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc2-tag
X-PR-Tracked-Commit-Id: 12653ec36112ab55fa06c01db7c4432653d30a8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a0e38264012809afa24113ee2162dc07f4ed22b
Message-Id: <172305012008.2608521.12107162083426501479.pr-tracker-bot@kernel.org>
Date: Wed, 07 Aug 2024 17:02:00 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  7 Aug 2024 15:40:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a0e38264012809afa24113ee2162dc07f4ed22b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

