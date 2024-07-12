Return-Path: <linux-btrfs+bounces-6433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4873E9300BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 21:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04717281081
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4493BBF2;
	Fri, 12 Jul 2024 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izAUY2UU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BD3A8D0;
	Fri, 12 Jul 2024 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720811565; cv=none; b=F3oEQCorv8x0JWLRrNBOAjKz9wl4WVaPfnfS+IzRkw5HnIPcrHH2cNLgfQ+5EmbCtw2I6k2hCEYfG/Ht6t9+vUhnn4MSTie9yQQepbmpS/0DB5l+AgiUo08jfYya5oS1m/6eb8EamBrRXxHRSA8tb6Bi2INFiSkSs7qRoJNxW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720811565; c=relaxed/simple;
	bh=XxFNGbaVZd9e00Q1jyvXiZK02JT1q1kT4RMYpX1Do7E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Itjep0ar9VxX3VPyaNhXu8FMxLpVmpTlIDA3GKbwu4Dhpfk08l7IGYMtpyo6p3KsR7XDRavRiwvUQxKpYDet0UGWAb2ct45L8l8mnzI9Ri2Z88Sqf7w2R6gXE0Hy12QIzIDF4p4OGJYlJY9kRpOIYbepj0jDf/TuMghZBWVX2Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izAUY2UU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71C5FC32782;
	Fri, 12 Jul 2024 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720811565;
	bh=XxFNGbaVZd9e00Q1jyvXiZK02JT1q1kT4RMYpX1Do7E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=izAUY2UUpds6euNrPuPgMiCQbafDA+f6osgPMC6Re2bnpGGByW6eRaTlsFxvgk2ln
	 Dl/qUa6XdaXqtu9lWsZeg+O2f7BaG7bOKkwlyPMWAO8o76Leo3xbzZGMKUMGmT4lzj
	 jedpTkFptlquANjaYwOXCQlGeRHHSwCg9RVNeAUGarBk+a0gs9CmRSxSVJOZZEW9aV
	 EFBGa3a2NXQocYz3GIRM0HQeszYcHOMpHy/OOdge/9Y24WomqbmQF8olpIozf488mj
	 AbQu9uveNOKJjerpOAAo9wRkT+nicU+CRn2wc127kChxxwZKmvB7g84RB5/XgFkVIC
	 nv1knUeC1J8GA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64D61C43468;
	Fri, 12 Jul 2024 19:12:45 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.10-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1720807949.git.dsterba@suse.com>
References: <cover.1720807949.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1720807949.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc7-tag
X-PR-Tracked-Commit-Id: 4484940514295b75389f94787f8e179ba6255353
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 975f3b6da18020f1c8a7667ccb08fa542928ec03
Message-Id: <172081156540.20584.3492536363431545564.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jul 2024 19:12:45 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 20:48:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/975f3b6da18020f1c8a7667ccb08fa542928ec03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

