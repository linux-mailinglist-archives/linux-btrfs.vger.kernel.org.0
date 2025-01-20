Return-Path: <linux-btrfs+bounces-11018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C5FA174A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2025 23:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949E77A4684
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2025 22:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD871F1934;
	Mon, 20 Jan 2025 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuGY8nBV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B954689;
	Mon, 20 Jan 2025 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737412289; cv=none; b=OJn+56T19QL4GgDtPmxF1WHcreUa3TmQIiInt7kneyPbTFs1yGrUoyrVvfTQgFmfaCGvPHsyUH4u0rEUdJT3lbLpcbeO0E0MhWpr+BK1IhjOlIFlAMUPlOLUlH2+eaKZdaz2n59CYic4LDCMbGA+Kl0uo4sa7vuhSDGyVzvVbHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737412289; c=relaxed/simple;
	bh=ogmxQq+142Z3KeidGjQ0mrrqh9d34grgwvLVC83/WDg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D6s19tB6Gl70Mb+cxrMM9GQjsfqeNKOXAsOeOgyNlEVE4mzua9Sf50ifK704/iX05NqNNX4DWXenNiJST4RFBWxKFHD3y6MKtgjBlqkg3dq7ekqAN+Mbj52YmSwX9QDTjg6O0SndZw1qakjB++V+UUcgbTz3sm7OtY2jIFQIOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuGY8nBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D72C4CEDD;
	Mon, 20 Jan 2025 22:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737412289;
	bh=ogmxQq+142Z3KeidGjQ0mrrqh9d34grgwvLVC83/WDg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AuGY8nBVfDy+VUw7noDSiWzW5aRQGooIihy7SUX4uWJKz6W8iL6zrNQQfGZVCbkRC
	 1Z/Ldk7Cj1Ym9zP4cIAnSB5Dvq9WcVj8T8D7RqJlSXwstqg/w0yRiMeil6ysbQ+NUJ
	 QweVamULtLpvpxTa0k9jfP70itDW/CowZSi5w/gKVsI3K/V7awzbC8aL/qHUmUugbp
	 cTf8nBO7zdpbg62ppvR9trblA+zIfIQrxroxfQhZXn3f+UBJeXSedMgokecdP0ql8E
	 5qkr3TqZi2j1T14LeZzwUU7SKGRAucL9pdEd3Ox7qBEwBYgz4PVIEKZpgA2ryKaX1b
	 bTsyewlkvJ/zA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE279380AA62;
	Mon, 20 Jan 2025 22:31:54 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1737393999.git.dsterba@suse.com>
References: <cover.1737393999.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1737393999.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-tag
X-PR-Tracked-Commit-Id: 9d0c23db26cb58c9fc6ee8817e8f9ebeb25776e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0eb4aaa230d725fa9b1cd758c0f17abca5597af6
Message-Id: <173741231320.3672095.5468599438237611953.pr-tracker-bot@kernel.org>
Date: Mon, 20 Jan 2025 22:31:53 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 18:41:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0eb4aaa230d725fa9b1cd758c0f17abca5597af6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

