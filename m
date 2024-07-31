Return-Path: <linux-btrfs+bounces-6903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C495F94248C
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 04:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4491F2419E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 02:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882401754B;
	Wed, 31 Jul 2024 02:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAn7hhH7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BA15AF6;
	Wed, 31 Jul 2024 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722393810; cv=none; b=PU2nFhFPkaJZhe/XS6qpqhTtCxqZyGo6+ZVfsGItTtRXssY9R4WXovWKqiYGBNY6JYUM2EFR+4xS2H2JKwruMhQlLKqU+229EKLvKHYVkJMnhLvUch03+S3YVgRL5lwZN4eNseiFnDUIMd299RDRcmSJXhRRisFySwCBLAbHhLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722393810; c=relaxed/simple;
	bh=NHVYHAOWP/oMMb74YLj77y9m6sisss1lurJA9m3ICoY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ouhK13qnooKlf71Wo8nUvvurjai688vOAy2JDnIFhw7tr82NvqO9XBhi4TemHd7VBwC0a7NRAh1nzMNjMTeflFI8pZWIpdivnTsVLnq3NMBdG2pEEvlKUCH0802K8vPGLHHznKGN+A3uuQ9vQ0zEtY5ukf38NJFXdDolJwotLuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAn7hhH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 856AFC32782;
	Wed, 31 Jul 2024 02:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722393810;
	bh=NHVYHAOWP/oMMb74YLj77y9m6sisss1lurJA9m3ICoY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EAn7hhH7HIdoRaXrIzvwSAJ8/A2busXB7KADGGvQ3DkNOJA2DvNE9ngau2gyWAjns
	 XI9jxMJBwBUn2DihJql12l+j1bROZDquA81lRBjTE2NgBYpMqfHKK8f+liSvGTUBE5
	 lOebT9V27H88nUKDKFtSdIUSq98z5QQyxTr+xWqXvb2WssjyTMcRie+ogJV4m4Az9C
	 +dtMJnueLTnLyGfhodO4rhzavgDurFIgWqd3KNxED3Qe5XYawfcqZlx+oFD7wPegxE
	 niC0oD2hrIfI4tDBsg1eWc8FbtHJerIYkilOwBjaOqo5uoii1Qu18wwAiipXbTwVdg
	 w5Ov6TnAfU7pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A8B5C6E39C;
	Wed, 31 Jul 2024 02:43:30 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1722390813.git.dsterba@suse.com>
References: <cover.1722390813.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1722390813.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc1-tag
X-PR-Tracked-Commit-Id: b8e947e9f64cac9df85a07672b658df5b2bcff07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4fc196f5ba36eb7b9758cf2c73df49a44199895
Message-Id: <172239381049.6103.7086730729058855039.pr-tracker-bot@kernel.org>
Date: Wed, 31 Jul 2024 02:43:30 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 31 Jul 2024 04:14:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4fc196f5ba36eb7b9758cf2c73df49a44199895

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

