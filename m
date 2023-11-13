Return-Path: <linux-btrfs+bounces-95-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67017EA1C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 18:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F1C280E4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 17:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135A3224D2;
	Mon, 13 Nov 2023 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhvE/T8p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4C0224C3
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 17:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F879C433C8;
	Mon, 13 Nov 2023 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699895779;
	bh=Rbfv91x+BKBH2FbFB6c3iwawLdkT0jy5zhy29xwzIc8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JhvE/T8pPlsRU+aZ5YwzL4znZ+bW73PH+7MKCjSMUARCZSgzINmGFWh9wpNVK3j0N
	 ZSSlmnNv3ELnIexK4P7RwkBdsKPcN2oSBMMzAP6MLpxvNVIv2iYvHwGo1hhiG4Qd98
	 v6J8yATlXPAcrSar6Q5sR6NOhAXVH61QnzQHZlg7PJWRYhKJ+k1B8YdcVOcxScW3ib
	 YLVd5ZMCdZmAOCRDRZqxAyh1mavE4iyZpBR4M1FVXSUToWFUg9xcTYZtAOo2FCgDhe
	 I+ljP61V2xZ+WBjVQQq68yChqKCYCc4nErXz30VX25tX3QNs6W/oX+2Vw6a8UzDQos
	 rQZ2qZo9G5IFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D9E1C04DD9;
	Mon, 13 Nov 2023 17:16:19 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.7-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1699891630.git.dsterba@suse.com>
References: <cover.1699891630.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1699891630.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc1-tag
X-PR-Tracked-Commit-Id: d3933152442b7f94419e9ea71835d71b620baf0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bacdd8996c77c42ca004440be610692275ff9d0
Message-Id: <169989577944.20902.9323359004196842840.pr-tracker-bot@kernel.org>
Date: Mon, 13 Nov 2023 17:16:19 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 Nov 2023 17:22:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bacdd8996c77c42ca004440be610692275ff9d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

