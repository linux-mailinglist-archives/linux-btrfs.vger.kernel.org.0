Return-Path: <linux-btrfs+bounces-6111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D81391E967
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 22:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE59E1C2295C
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82E171096;
	Mon,  1 Jul 2024 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfCSE4pN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8D170855;
	Mon,  1 Jul 2024 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865009; cv=none; b=JMATKn0dWBoQ0NTThu8ii2k1a0rNKmqGYVUisQz0wnFJ1iEf7i6cLq8WEM2BextLVqicqZVg5Tj2T84W+sQDWqB6MujZhx26ZCls42FrxZkDCZWKEhvNghpG5l9jyO8za9xvfdp0iiGgdu6KtzB3jrchbnueevqVmTHPV2RjfVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865009; c=relaxed/simple;
	bh=Gv4r8sx6Tu3wxrHS+75UjHv/KD00tiLjZTo4ckRgvdA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y2yDsJBLCvY7u7iDzWxJ6vd27KNu6lKig3ysuhrRrMDoyTFLf3FRttrtnNH/iTcaNbBau2/mb8vKL4EFwkLTeGSvzFlHlBTMyyqA3/gB4PgAXUdLoRKRudXCjlUHZGQ+c9cPx52j5DKaegaPxDpNn8kC26HdPc8Mp+Bk3qj91WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfCSE4pN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81FBCC116B1;
	Mon,  1 Jul 2024 20:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719865009;
	bh=Gv4r8sx6Tu3wxrHS+75UjHv/KD00tiLjZTo4ckRgvdA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FfCSE4pNVKNeFiuC3o8BbXMgXkzujpAQMRlGFiJATRdCiNxF7CWkVUQBW+BZYAEuN
	 dV6JinBzDs7zEW4l2cs3OF24p0DTEeb7rbyEo+BC1Hm8qR+7NYdaMjOW9iWF2Q5pJY
	 QX8aBj0kbAyT/lc6w9f9HEZuPu8jbVBJQ1Cj/J6ZQGz0vU9NhxA5eNrUuX86MEzkD3
	 cbaUS7U/qRxUrv7RZtP8n4Uc/NO9fmRpsxKcSjPQtSZPlAiIhPJsCRijJt8t05i/Gn
	 GVIExsrqAIrkb99KIq9MmEB3y/MClivCWCIIff1DNk5Ht33xPrlCFe2qm6PHrgIYgW
	 jCAQz6EAPqljA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77519C43468;
	Mon,  1 Jul 2024 20:16:49 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 6.10-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1719854274.git.dsterba@suse.com>
References: <cover.1719854274.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1719854274.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc6-tag
X-PR-Tracked-Commit-Id: 48f091fd50b2eb33ae5eaea9ed3c4f81603acf38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfbc0ffea88c764d23f69efe6ecb74918e0f588e
Message-Id: <171986500948.16343.5915143754758462508.pr-tracker-bot@kernel.org>
Date: Mon, 01 Jul 2024 20:16:49 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  1 Jul 2024 19:36:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfbc0ffea88c764d23f69efe6ecb74918e0f588e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

