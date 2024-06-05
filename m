Return-Path: <linux-btrfs+bounces-5482-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180268FD5CA
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 20:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21AE1C238EE
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 18:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A1713AA2F;
	Wed,  5 Jun 2024 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reHdWzIG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF937345D;
	Wed,  5 Jun 2024 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612320; cv=none; b=W7766H9/auzq6xHZFuYNx6yPgT6NAdyXeOe/8geNKmynCeDwJF77ZyH2XKOt/SWBDUM8l/TSRy9Hx7JihH8goo5rIblZnEYapCnlMYUBx6BxF3sPWkEH5GuyBaREEBIiuLTo0Zf59CVe3lwndWVWs0BwGLhlrgfQQSgstbMm7Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612320; c=relaxed/simple;
	bh=vB5OVbRhLJjfXRhaC/805KYIfiR4qXFZuXHoLY/xIq4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kmOYSOZ7YuCwviIoCQFHUdJhbFYCUUhcmwSDk68he/F3vMTFed2TIGiHF1OC9CE0AzslauuRdgAtdSFZoyQG05RdrnRaLzmTQnYwPbUJZLnamdOlIpYugaEdRiWcJUiLqjLM109gNlmgTAyfmZrsLGAIJdv+h16et+ApAEy7R9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reHdWzIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A433C2BD11;
	Wed,  5 Jun 2024 18:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717612320;
	bh=vB5OVbRhLJjfXRhaC/805KYIfiR4qXFZuXHoLY/xIq4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=reHdWzIGoneUFq4hpDLg7LwMzN7YXlnTC3m8u01dh9AS04jk1Z3IMfeyRABDE2QOZ
	 LYCMaPMJ2EfZXRXkqQ0008BjSVgr5D61iO66eMWUZApMYtQtNVsYsiDuoelhmM6Fz7
	 Ym7X+tJ0EkPAYgwPk8mMUaNMH1DuhV5cELvWKshEGxekamnxNglQvKPhvIR6ZtuA4e
	 HrvCjA8t1p1CauMowPckJU56zNgEIMeBwUe1jj+e4fW+SoPTrO9XHEnacqtoNVEyl9
	 iaukN4ZuwWssmkRoXj1xV9bWAx8oEIDk7cP8NBMmCdcIck7Tmhzd5REm8zW6c/TCpR
	 n53IiKrSsh6nA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FA2ED3E996;
	Wed,  5 Jun 2024 18:32:00 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fix for 6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1717600881.git.dsterba@suse.com>
References: <cover.1717600881.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1717600881.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc2-tag
X-PR-Tracked-Commit-Id: f13e01b89daf42330a4a722f451e48c3e2edfc8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
Message-Id: <171761232038.20262.14497278528007459609.pr-tracker-bot@kernel.org>
Date: Wed, 05 Jun 2024 18:32:00 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  5 Jun 2024 17:26:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

