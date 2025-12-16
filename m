Return-Path: <linux-btrfs+bounces-19779-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94732CC17BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 09:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6C2C3069C99
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 08:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC3E34AAE3;
	Tue, 16 Dec 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWx3uqXO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBCC33890D;
	Tue, 16 Dec 2025 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872433; cv=none; b=jSxIXjoVDWVjXM8XvD9Ks5XfY9mHOX2Wc14Wq6MNMrvZVBOTjrgZsPy3k8PySTCCXMpDErRO6+p61LwuClrme8BseKD8H8vFEwZc/6ueFhebCEbRrxA5uI3tqNpxtv81UOutEbM/d4dQi67o7nk1aFZe1PJMS16sloh52klf4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872433; c=relaxed/simple;
	bh=0ERlj2N+OZdnMbIc4kiWhVAcnzPzototnzvtq4zg9vE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zt+XCVozWsbVPIpqwSVsKkpkYciX8AJKE5lylgNjMhWQOkub9AQZyapaPPgzRvhUz3lUOtDKby2BCWkiLypCfLsh64zmvPdExsTHcTadChMSamtiKwcsHoOqkgeyUdnGbpZgODCACx4s/DET1mhoaPg5m4PJn0aFJtpU47hl+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWx3uqXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC45C113D0;
	Tue, 16 Dec 2025 08:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872433;
	bh=0ERlj2N+OZdnMbIc4kiWhVAcnzPzototnzvtq4zg9vE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eWx3uqXOngwA8uS8kEl93HZnb/jMEcEoE2Bmqx1H8sv2r+U5ZorsOLnquSglbSWva
	 FoQYBUNJicEFKqSu7fFl2QI8Bab7AqmMz7yf6w723olmd9nk+GaIYTaqDmE+10Xi5j
	 z3kG1c8DRWkDKDnUc3pbeqdY4Sd8F6LsmeXJcPkjzM2o6BoROiKC3ORfp3ZIoTqEGE
	 btz0i5sklVfiCELf8fVPvt7J0Tmep39bSMQ5afFWX2GShCL8axczRtaJTuEu0Caj6A
	 2TSJRl8zy14vMQGCmkTUmV1oez+1clZ9HkGC9XbpNtYRvK3Wn2AbGtEHd+doZt4syn
	 5eUjrAa4tOCsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78954380CECA;
	Tue, 16 Dec 2025 08:04:05 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.19-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1765827039.git.dsterba@suse.com>
References: <cover.1765827039.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1765827039.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc1-tag
X-PR-Tracked-Commit-Id: 37343524f000d2a64359867d7024a73233d3b438
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 115fada16b5a9a5ee371ad656e56419fe0e63cfc
Message-Id: <176587224399.917451.11540108310321720952.pr-tracker-bot@kernel.org>
Date: Tue, 16 Dec 2025 08:04:03 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Dec 2025 20:50:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/115fada16b5a9a5ee371ad656e56419fe0e63cfc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

