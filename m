Return-Path: <linux-btrfs+bounces-2399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1A7855837
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 01:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D352282611
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 00:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FA2818;
	Thu, 15 Feb 2024 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgL5acDF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E931EC7;
	Thu, 15 Feb 2024 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955957; cv=none; b=AsP691LFK4aFwf4pqyEt3+zab8ybbIJ5M7fO/YyJIja12+zbYEUnTSVzm+xxuHg4E5lnVP2m37BhelEPC/hoLoL6raRAGqW7xPl8v4k1WIRxMob0/0qYHotaJsgHoEXVXaMwZBDMPs+HCZveAuiM729D+HVKlOpv1heq1XudTQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955957; c=relaxed/simple;
	bh=TvyrsL9SjNp6SiEeNTLhQRnMG5/9Equ2oZeEv10YxqI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WgUVlFn4w0Nl5omf/w95pMEbiFAxUPo6L/K6g/oQpqewf7PB7YUrR9PmjFtBemJdvuS+hVpUMea0hiOx4WfhqTWznrselTgclUv9HlgvcwT9y1C+ZbX1zkDNL5nfdBHkijyDFfcFK03o9yH01w7a8sz08usNnMIPkCuNZifSvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgL5acDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E582AC433C7;
	Thu, 15 Feb 2024 00:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707955956;
	bh=TvyrsL9SjNp6SiEeNTLhQRnMG5/9Equ2oZeEv10YxqI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dgL5acDFexijkYr4kMnO7FyA+J81ZLPcfzAKzLAVU8lQ6jSG43a/yz0TihegM/rZG
	 K5L5VKJe0zSS3LYOdXEk2fav+Ss6YDF37b0OUR6RFOohq1cY8vcUB4FHaaT0e4LBDP
	 hOkmhBiuBTt5B0yU7ZP+/v7MOB4Mp0QLcgE8r9tRAn7Jok5sYf5UrqQC/Xc9zzKdYI
	 SrISZ4HXRQ/imWO17fxqf7lJJSPp/nCvwn3Bu6lPu1Se8TNrgS7TzyX+4S+6lKjIiI
	 qFt9slej2xgv+LGs/6AscrDYh58XkCNqdoHEaSYQL+1Uvuzzc3j/1QAd4hV+CdE38S
	 EZ8ZVPEi/QTFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3EB8D84BC1;
	Thu, 15 Feb 2024 00:12:36 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1707900530.git.dsterba@suse.com>
References: <cover.1707900530.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1707900530.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc4-tag
X-PR-Tracked-Commit-Id: 2f6397e448e689adf57e6788c90f913abd7e1af8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f3a3e2aaeb4e6ba9b6df6f2e720131765b23b82
Message-Id: <170795595685.14173.5160622438861725904.pr-tracker-bot@kernel.org>
Date: Thu, 15 Feb 2024 00:12:36 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 14 Feb 2024 09:52:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f3a3e2aaeb4e6ba9b6df6f2e720131765b23b82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

