Return-Path: <linux-btrfs+bounces-1374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF5E829F4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 18:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7A21F22B13
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C895B4D10D;
	Wed, 10 Jan 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZyVcUxX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C24CB4E;
	Wed, 10 Jan 2024 17:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF8BFC433F1;
	Wed, 10 Jan 2024 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704908239;
	bh=20m9pfQwSTYVdWjsLTChXbg5kUuBspn5BNzyyTUs/9Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rZyVcUxX+hMqa9Q+Dmvo71/CDdsZuQiSLTGpFl9K+Xnom02EwdOXoq9eBXVA2licg
	 mldVPvQ1QOHQvm4EiRt2bW3/KUsL8ez7WlGUBw2LO71gi8Rn5rYZWKCKezmrUc02sb
	 rzHmBPPOV7t4VczvpAuf0RXiuv5pfHd3Edw0i9IiOgjOYGhwtnfbRMZHjBNzzyWDLW
	 hhHAmHpy+u6suLrV9X9O7Ut9IsGaY+1pwUxtz1elzOTtK8oQu76x+tIJFAqIu7k+nh
	 GTpGwI5cfLiB1Nfbmzc459SY12Fqu9i/6O/BR3Tbj8gI7wn9w0rubn0E+tD+CddaQO
	 3UUkKxubN/k6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCA33D8C96F;
	Wed, 10 Jan 2024 17:37:19 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1704481157.git.dsterba@suse.com>
References: <cover.1704481157.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1704481157.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-tag
X-PR-Tracked-Commit-Id: e94dfb7a2935cb91faca88bf7136177d1ce0dda8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: affc5af36bbb62073b6aaa4f4459b38937ff5331
Message-Id: <170490823976.14271.16074825448993474489.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 17:37:19 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Jan 2024 20:03:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/affc5af36bbb62073b6aaa4f4459b38937ff5331

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

