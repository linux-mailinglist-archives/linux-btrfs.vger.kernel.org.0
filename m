Return-Path: <linux-btrfs+bounces-15720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D21A3B144C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 01:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C4B54255A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 23:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2778624A04D;
	Mon, 28 Jul 2025 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OY15szH6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661662459FB;
	Mon, 28 Jul 2025 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753745994; cv=none; b=jczZnRX59euO6fF5ya8QVexRvjYkenDLtMcCIZmMQxDSQdREi/X1djhiqrb6JeqOTEXVj8gABj5r9SwOl0e9W4IoUdlpWJ6qpzgPXHo6vD/+KPPLfwglXQX1cX9sheXQhCeab868GZXSboyaJ9W4+k35mVz7HBHk7KdaYoLNKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753745994; c=relaxed/simple;
	bh=8OlPuDyOjNnOvo/FgTlAEWon7OWNfvk37xfRv1g106U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oKn8oZRN6vxgkjlVtoX/voEUSg3e3V5mIBHmpl9Nd4iTxfbNw6U9ziI2mtyGWy9YRuyDxkS2Yw+TOZqDHaBa6GyEPtfm2digt4ix7hW5cOuIllogRV/80p3cfSfcv7Mzv7L/ag4QZm1hdUQkU5tFst5YAI6YdjnhqpJ4wJ0ac7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OY15szH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4975CC4CEF6;
	Mon, 28 Jul 2025 23:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753745994;
	bh=8OlPuDyOjNnOvo/FgTlAEWon7OWNfvk37xfRv1g106U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OY15szH6Y+CkWT37v0uqFRhortFzeP1mKlCecOIll1zmqyGhXOcMuqlx+BTQd6DEd
	 2QaksYCThsvpsCADliwawBSBlUGBIV+oNA5P+ju6Q6HBO+jZhu4QmR0UTGFSE3neX+
	 v3zIzqA86t9gpXSnivKPKmdBOovqvWVyNoFNzK7znZcJXlfxMQeqnAdIKtJG337DBo
	 Ib4f2eQc1wMbcUdJJXu2FofQCkUUAVBlqWXOWrHba7Zem1t7QMBzyANTpDZSgyHjck
	 IP0UVNLNeFDvtEcknWVRH8Vfs6AlwtRh9exqY2Nh0q6bVUh/qPVVUKdzZQyf2NhAOl
	 kFETeSD6YqA8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B91F383BF60;
	Mon, 28 Jul 2025 23:40:12 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1753226358.git.dsterba@suse.com>
References: <cover.1753226358.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1753226358.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-tag
X-PR-Tracked-Commit-Id: 005b0a0c24e1628313e951516b675109a92cacfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f92b71ffca8c7e45e194aecc85e31bd11582f4d2
Message-Id: <175374601098.885311.7269613443650588441.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:40:10 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 23 Jul 2025 01:23:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f92b71ffca8c7e45e194aecc85e31bd11582f4d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

