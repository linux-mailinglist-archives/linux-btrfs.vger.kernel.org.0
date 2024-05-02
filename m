Return-Path: <linux-btrfs+bounces-4677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418D08B9FE4
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 19:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17E5281C3F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 17:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F9A174EF7;
	Thu,  2 May 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcZbEwIX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B8173356;
	Thu,  2 May 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672675; cv=none; b=cjEv7SRv6uFxaBUlREuS+7rr0Mi4g90RCGPvdMGtNAfYZJJDcA87otKKyclo+WpJeMEwxNw4hEDG1jqdQfkYq9gAXtYp/5hDeTES2zSM0njxYoIcgFmerTe4hiVH3Zk+tF1+AbbDT+9nUIheWQxgH+1wamAltIPiAMZXEIPamWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672675; c=relaxed/simple;
	bh=m/DyzW9iBsECQcyK/0hhjZDgbz9SLzDLARlyJrup+Bc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VN0sK/vbSsLC5YjcGSfqkoz3o48tKXgYFg9byvBUVetL8JtE9/FtpK25kNJiYCT3F6HfBY0Ar4w8GtdBfqz/wFbxwrJEF3oWDtNbC0VvyXf/5UrDvoXd5F7Knao4N5F4bAb2GcgVHIYjBQqthtoCRekeN6xtunw/Y54QQW23uhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcZbEwIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EEEBC4AF19;
	Thu,  2 May 2024 17:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714672674;
	bh=m/DyzW9iBsECQcyK/0hhjZDgbz9SLzDLARlyJrup+Bc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kcZbEwIXGZlSXA8U+MvYD2td0rqus5SB4AxnA4yOfsnowf6iHNKSUlY5AMcsuAjib
	 KRUNtai6B7+0r/qd0uRC3owAzYB1+FHyB0o4OC5b/04W5NDUMqW+xuoRc4L5OpzPXA
	 uCSJHSKpSOu9GS8WX2pb0agP+HXCSALCY4qh4B9J4dllSSyMUxiiReyUlAhJ2q9RXN
	 MLJjtcan+peQtnLyDwTTpF0wehi+xUg9sMZKt7q8X73HdqSt6WUT39neFVCKqBhn5c
	 BGlEvKr7hF9QYPw70vF1pAxi3N8GiKBWhry0YPhSaeVY9UY5WvKVWidwWvq8izK5kP
	 pY3kcfCcDgAXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6316BC4333B;
	Thu,  2 May 2024 17:57:54 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1714654371.git.dsterba@suse.com>
References: <cover.1714654371.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1714654371.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc6-tag
X-PR-Tracked-Commit-Id: 63a6ce5a1a6261e4c70bad2b55c4e0de8da4762e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f03359bca01bf4372cf2c118cd9a987a5951b1c8
Message-Id: <171467267439.26516.17671229558988334018.pr-tracker-bot@kernel.org>
Date: Thu, 02 May 2024 17:57:54 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  2 May 2024 14:57:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f03359bca01bf4372cf2c118cd9a987a5951b1c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

