Return-Path: <linux-btrfs+bounces-5562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDC6900DFC
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 00:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9C41F23EFD
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 22:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA70915539F;
	Fri,  7 Jun 2024 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P24qrvku"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3946558;
	Fri,  7 Jun 2024 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717798673; cv=none; b=o9fn7Zh9OTF99YlrWXs6McBi1SKaNho9DDGVSXEWkmutfwZmxUTC+AyOZHyKBStb78fHFhZMoAHxbQx7nKwt8LHSuhBDHslReDlqeV5jLovD0nUXV/OXUXJKOWp81H6HKivCRh59F+nre+dryv92U/biBI5Ph5eRlvWqRATKIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717798673; c=relaxed/simple;
	bh=aoQ9gBtQl676G97u1viTxm4xwINy5e73+D1Y9KTJL94=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cwk6IHkZ0GyGC8RqW/JJ3vBCzljYQGKicQHEtHnJjCu1sOk0V5w5dt3tQxAZ3FBb+6fFTXghteKk+JvLkkmO7K2irXn7KdH9tFnnrnDBWR0euamg8tY01Pfnu46ey+ZbfXPVse08q20xAEeULj607RCC+U+uA0szmuOtz3AmRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P24qrvku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 581DAC2BBFC;
	Fri,  7 Jun 2024 22:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717798673;
	bh=aoQ9gBtQl676G97u1viTxm4xwINy5e73+D1Y9KTJL94=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P24qrvkumInko3x0duuVRxB7hnJUxvF6z1UGs+zkApeuYdyLyLHa3CFpjgQxLkLtg
	 t+/k6nJj/FX3gft5x9K5I8xPM7XYYb0plaal7zUP0mziBfColHli48WMeug417pWoS
	 DIiMnUm48sX0ybYQDmPvkJ8iK5yeclJkR0sLogRmH8K7Xc8GzmhQUT3h5hfQIOXd5X
	 WBfURbkGUw3fRIg6Nx6a6dBAgX+kBEA37UXzWg+NjS5mqPDoq+PJRC/f+NXwvai7xe
	 vsg6Mhwf9bp4IpaDkJNBEa26nQ48/wvfge3SAh60zhwSc3UZAF94HsGyML8Cx9CmUN
	 CjsBn9n67s4Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BFD4C43168;
	Fri,  7 Jun 2024 22:17:53 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.10-rc3, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1717771196.git.dsterba@suse.com>
References: <cover.1717771196.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1717771196.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc2-tag
X-PR-Tracked-Commit-Id: f3a5367c679d31473d3fbb391675055b4792c309
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07978330e63456a75a6d5c1c5053de24bdc9d16f
Message-Id: <171779867330.7177.6187152959628646392.pr-tracker-bot@kernel.org>
Date: Fri, 07 Jun 2024 22:17:53 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  7 Jun 2024 17:18:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07978330e63456a75a6d5c1c5053de24bdc9d16f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

