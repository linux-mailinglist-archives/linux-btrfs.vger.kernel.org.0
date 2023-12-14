Return-Path: <linux-btrfs+bounces-959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF47813C78
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 22:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6721C21C69
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Dec 2023 21:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921776DCEB;
	Thu, 14 Dec 2023 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gabwmofV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D96D1C3;
	Thu, 14 Dec 2023 21:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53E59C433C7;
	Thu, 14 Dec 2023 21:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702588692;
	bh=KE9X8zx8/yKzxmP/CMHvtffGmh99L2+sN7m3Y8aqRHk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gabwmofVR6x9uqU6goIMaLT687tnB7QBCihuERAWQkEWPtYLAITfvEUrDZlHHgV4y
	 MK7NJ+dFBIEmaKLs764RI8PElNW5JC7S3trwH2MenneIZTEE29E7dG5nuw6X1R8Nmk
	 9I6rPwkZUTN6ee7vmZ1MVqBN1XOLgaZW/ZdS6+uttD58BrBCDOtxmgz4YaJRynHRno
	 RDrzyhNxGY9e+yAksimvpav72TECKzl+Um7UJLsuorv+7mQBTtOEpKDZTgJMH8+RXS
	 agl3Mc7KcQN9ex6AMpmitSn2wxP2AR9Jr+gBlepmvL4LWVMePY5uWDcNVIO8F9F0NW
	 971eYtkNH+RsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E708DD4EFA;
	Thu, 14 Dec 2023 21:18:12 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1702473248.git.dsterba@suse.com>
References: <cover.1702473248.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1702473248.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc5-tag
X-PR-Tracked-Commit-Id: e85a0adacf170634878fffcbf34b725aff3f49ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdb2701f0b6822d711ec34968ccef70b73a91da7
Message-Id: <170258869224.16863.15667975030221661930.pr-tracker-bot@kernel.org>
Date: Thu, 14 Dec 2023 21:18:12 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Dec 2023 14:26:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdb2701f0b6822d711ec34968ccef70b73a91da7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

