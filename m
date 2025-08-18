Return-Path: <linux-btrfs+bounces-16130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB97B2AE69
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 18:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5EF580CAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C041345757;
	Mon, 18 Aug 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCTSgWva"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82638345740;
	Mon, 18 Aug 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535203; cv=none; b=GRE0WWL3rg0Ee9cD22EWoLT6w43Gq1RepfYP3r24KRfAX+R6tx6Cfyj4k66OPYy4SALAqHaFD6RjVc+8kcBmD6UbmpNAlaXP6kuQCLzb5uL+5YYjroQKnryOxcgy5MIcv4nqPGtiUvMMThFdXEbx13F6+u+PuDBGOIkiDEWtrwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535203; c=relaxed/simple;
	bh=wgD0SS3y2dTd5QcsxRDdUpYXEldP0wIWX6fqMb1gEHs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gGRO/WovnZIL1s0VfuPGxh2d8ROche+jG+oeuIEi9bTeTsT7rLt1UMTQ7RqUH8KCwvoJGHwRSRRoDhMjoljbMSZMD9CT7IFBGclolEZPyOp0qGZIL36sksqvFZ00xssTIA8JxUiBQia8H0wXBRl6KZziFT9L+6YtmA0CXmBimLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCTSgWva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67052C116D0;
	Mon, 18 Aug 2025 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755535203;
	bh=wgD0SS3y2dTd5QcsxRDdUpYXEldP0wIWX6fqMb1gEHs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UCTSgWvapgUvgxbPVouPUQDRqJUKiKyF7+34zcPlUFzsS/Sf+EDdRmeeqOx9609YV
	 MvE4O15GIAaUNaJr04w6AGkoWsdnRGUx2jbTBzPjGs8Up7zoNtHykIirpg4bH7yF6w
	 vuwyTfF38MYp+rItDi8d5V64dKA9G4zfFpvAmH1vdoXHxUwrshWZ/ojaM685AuU+Fy
	 iqJPBVFDTLM0OTKqtdbjRB9f4BtFb7Xy3vsEz5LjTBCRug9ZrcSLlYUSJlXg4t7IQ8
	 gqiCL5xm8KizSWWhn08zNzsqGkJegrllUeHiJw8H+IHnOQ4Msr9IPbte3BgLyW+W+1
	 mtQuX8ZQn6GMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D3A70383BF4E;
	Mon, 18 Aug 2025 16:40:14 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1755532653.git.dsterba@suse.com>
References: <cover.1755532653.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1755532653.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc2-tag
X-PR-Tracked-Commit-Id: 74857fdc5dd2cdcdeb6e99bdf26976fd9299d2bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be48bcf004f9d0c9207ff21d0edb3b42f253829e
Message-Id: <175553521381.2821944.5779787882183299096.pr-tracker-bot@kernel.org>
Date: Mon, 18 Aug 2025 16:40:13 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Aug 2025 18:14:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be48bcf004f9d0c9207ff21d0edb3b42f253829e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

