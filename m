Return-Path: <linux-btrfs+bounces-2823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC7D868103
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 20:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364F8B291E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 19:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A23D130AEE;
	Mon, 26 Feb 2024 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfaMZJ/H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2212FF63;
	Mon, 26 Feb 2024 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975766; cv=none; b=owrXHRr6M8WeZvzzfP0mh0JzdjUgDx2aEHXFAdHum0qa1l4reOEscXL+WD6ru+qm0vzSdayBTiQ/Fe7bHkraFjCi/LCn/mHzn2SOOZhTjYK1yHS4PDZKZD3CpcXlEPwPn4r2U/u1PRA45DEBHBDqm8upuW5c05dsMohaLnittR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975766; c=relaxed/simple;
	bh=tdDlsTw7j4EibK7LKtzEHBFRiWAzX1MMDnNGDMpWa/I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EomqENC8j4hZ9TxubqjpThtoAPj0k05W6aEKTKjIRE3lK3LLvOZ1fT4PIqrqNJ0uBdaP6kSBwcODV+b69L5AfKd27iq0FAwpWJPid9oGU3EBWQYCmUPpNJik7nXTmOK832zh+EZdPiflhMf2+oZ+PETXi3YqPkUtXnlwcasPKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfaMZJ/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C200C43330;
	Mon, 26 Feb 2024 19:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708975766;
	bh=tdDlsTw7j4EibK7LKtzEHBFRiWAzX1MMDnNGDMpWa/I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AfaMZJ/HmHdZHz3Wg7WlV2iJrhcPBhZ1OoNqvVMBiky7dA7fqqawQ3KqWOmRk1/Fa
	 dCNlxcpdPNWm01EuGHnV2pVHLdQ4Rjki5XbAllsqNVVOxwn4HtKbNdPBJ5ZDxjFU5X
	 3u/qs8adKqbvsaq1oG45DkOckfKqmEAJLUHfjS17azWRn5rtDpXWjwO4ke2C938f1M
	 ny21B2khfbBP2KHHCgsyUj9ZQJTnTzb7g8v4IRDo+7V6sGHtUcvjZJAXT3DwaSVB0S
	 tHdAAdN6LNlMNzI/pm6GKqcWgzC8ExZkdW8W4qkn11cUs94nWvQl4b3Z7nuvkBQ7cH
	 +nrKM3fA3VfPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B1FFD88FB0;
	Mon, 26 Feb 2024 19:29:26 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1708962398.git.dsterba@suse.com>
References: <cover.1708962398.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1708962398.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc6-tag
X-PR-Tracked-Commit-Id: c7bb26b847e5b97814f522686068c5628e2b3646
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6c1f1ecb3bf2dcd8085cc7d927ade623182a26c
Message-Id: <170897576616.25041.5256070108579096024.pr-tracker-bot@kernel.org>
Date: Mon, 26 Feb 2024 19:29:26 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 26 Feb 2024 17:49:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6c1f1ecb3bf2dcd8085cc7d927ade623182a26c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

