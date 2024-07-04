Return-Path: <linux-btrfs+bounces-6209-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD7C927DEC
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 21:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810561C22626
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 19:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9326B143884;
	Thu,  4 Jul 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAa9+W5r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0512143733;
	Thu,  4 Jul 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121821; cv=none; b=lGhBthbG9ZoQr5whkTaIiEgeoRcSa4Yn6/iPi+uEmQBMYS7vOoAC4SY6GjpkCaLo20mKIDRdHg/rvLx9tGjkjW5lHJgHbyDhlK+Nlvmjl3OKOt0goZff1uXvVgkjWjogbvrbgC1usKd+Vylxcot1G+/lRJr7yrAFCSxPsl1u618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121821; c=relaxed/simple;
	bh=UnWYaSKMwaRBmIHpGTkuPB39LjAlZTNhzGDMXiUu79I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eN95VQoqIX4vHMNr5oc9K4tT4DAWlR2Rwb/FIPi0+ETRIPAiMXdnCFzqIsufUt/pLy8AJz8YogbzYmuj5NT/L9HX/8T6lhIyVIFaWSLYyU/CvGvtM6+aYMnIy2i1hXv4WekyYAYWY2S23M6wk80ZCjqQWaPxLTGfD6IqXNl74r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAa9+W5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4615EC4AF0C;
	Thu,  4 Jul 2024 19:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720121821;
	bh=UnWYaSKMwaRBmIHpGTkuPB39LjAlZTNhzGDMXiUu79I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eAa9+W5rUi2QQIU4XfQ7r4WZ5xrYBcIAWu9giTIbIBOU3RGAtHAsgzbJpupxYkyQe
	 T+NlyHgmLzF/V9PeUMz+O/SPoST060CbArI5Qq1SJglYJi66BwWgbm2OFyqvgIovZB
	 3vBxasTgm7+R/FauLDjpxqC0m/QQE61hPwIwzFMpYkc9+vl3lDFDmHzQhN5j9xh153
	 Xle2haxRFf0ooEbCSOmTBc+sombpg1licCjEu08I8XaI+XkouDhle9HeS5MLjtZBwT
	 ME+tWxqJwvIMosRDOzlMR2Ek0699yuCoAYLt7F+gFaaHgCiL/ihodll2ErzofOyEcV
	 hL6Tb9vXcMIpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CD61C433A2;
	Thu,  4 Jul 2024 19:37:01 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.10.rc7, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1720111779.git.dsterba@suse.com>
References: <cover.1720111779.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1720111779.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc6-tag
X-PR-Tracked-Commit-Id: a56c85fa2d59ab0780514741550edf87989a66e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 661e504db04c6b7278737ee3a9116738536b4ed4
Message-Id: <172012182124.16688.10232019193110050827.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jul 2024 19:37:01 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  4 Jul 2024 19:08:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/661e504db04c6b7278737ee3a9116738536b4ed4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

