Return-Path: <linux-btrfs+bounces-1622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AB7837596
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 22:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361721C20D85
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED56A4879C;
	Mon, 22 Jan 2024 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMTRc6Gc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E59481D0;
	Mon, 22 Jan 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959878; cv=none; b=mhDoNto8voUvdEmAas0AhEEPbOnHOVFtbzG+rLH3F72PGR+PQMEknK5gcbu1WIcS9bpdPEA/OOipfNcKG2s56OMptGDLnM8MOSddUnFalsDHI4+pKM6akn7nf57B6YOWzaY5bJD82qCS8aowzVXT1N0hFtVP9hJBkfMA8ubXE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959878; c=relaxed/simple;
	bh=j8rCJPrH0opyPn7g1x7+Sagl1pkcqo5+J3j5lU+glpk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G0oXRfn/t1tXXtlFwW1h/fwg18X9vcyyFCGg98qX+PFqHdPBUeM7b2qC3oxIF9fmGqq0SwIpy9KoXKKvH/Z6b7cYUZgQZr2QfVT7F2DYTpuQcKX7zhz/NX1pwQ9JwIlJWPR9e7tJDAEEtfsNERuuPpQkOgeJSeIx/WsIa/Qx6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMTRc6Gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84559C433F1;
	Mon, 22 Jan 2024 21:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705959877;
	bh=j8rCJPrH0opyPn7g1x7+Sagl1pkcqo5+J3j5lU+glpk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kMTRc6Gc7OUirmwIX6H/kIvDUWbyIdMQig28EaXt6UimoAcFR2+ei9N5gKXl6RVui
	 QmOgdTpE65WsRdsdb6+XzVGdy/4cJNmVV6iB4CgudouRVjulx9UjRe4P0PILM8yxb7
	 LSAbYjNrLznV2qedujPB3ZRGNL3/UmkqhpNouyyeLDft5oqyo2xsFPevqgkEnPnyaW
	 3o+EWQ7MopA1v+Cnk7R0ifTKUh/UKvBEzoSYhRtXfKaA4249IrA1FTbbtzPB+8XYeP
	 rVnGnPaKcdV4EfDrhKLu2kgiVj83Mh/NLCesHskRFoKl7UfUD6B5q+6y5HO030qRP0
	 lOUqG39PwViqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70CA4D8C9A8;
	Mon, 22 Jan 2024 21:44:37 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1705946889.git.dsterba@suse.com>
References: <cover.1705946889.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1705946889.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc1-tag
X-PR-Tracked-Commit-Id: 7f2d219e78e95a137a9c76fddac7ff8228260439
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d9248eed48054bf26b3d5ad3d7073a356a17d19
Message-Id: <170595987745.4413.7633969849838857336.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jan 2024 21:44:37 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jan 2024 19:33:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d9248eed48054bf26b3d5ad3d7073a356a17d19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

