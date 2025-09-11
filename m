Return-Path: <linux-btrfs+bounces-16796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49944B5385A
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 17:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B01CC3981
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE23568F8;
	Thu, 11 Sep 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXrWVyw+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B631C582;
	Thu, 11 Sep 2025 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606025; cv=none; b=rvLTI3chhn375oPPOioD1hbJtpyAdShXIkOrTmzqNBqWB46zcskUtQXL/pC7m71HaaOp5CZrJZYJHq0V91tNDpusBojjaQXVcSNWTfb7IFqx7YMEY8qy08e3PGStPoNPFAWl8OncPdDUflBoSuGnJXacEUD1UwXQXsP4WV6s+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606025; c=relaxed/simple;
	bh=v41HEK8ypzXvdPKVEmkZqHW1zdoV0iERque660/aFZs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UwWWfOdVHlp1ffKI8w60aCJQI1VSJyoiK4ApuniD+IxpwDKPP6NOMidaZHHMKaeGQGDVViVSdlZsz++qTrw+f5GVFJ1lOhvI2fHPLreJnP2H9tfQGHDLdWbiamI2drXgTB7J1uJq72kEQcOIi4YWiO557OB5d9j54xltW2chp1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXrWVyw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9ADC4CEF5;
	Thu, 11 Sep 2025 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757606025;
	bh=v41HEK8ypzXvdPKVEmkZqHW1zdoV0iERque660/aFZs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OXrWVyw+xn66wpJmWJClg8/Q4osIKjpDmQVYNq4Y7AMAFn4Z7TEPn9xqyt0XF+WqJ
	 cuJlG+L2zqS1D7rniRRkKHCEguSoGxiVIxLHgZGVXBXF7cNZB1LqbBSBMmN/XkFn66
	 CsZJvSFZz0EQgP4DUAZmstUZCm/012wyFWyLmXkVE4Esityn2EmcylGTXlUqLi+eto
	 2drXoLpeAIOMt3p72c1H/mLmdPQTGpMppSU67FRP4AqVVRBpFh8TUwca5UJKJOYl1+
	 URp/wdfIa+hDQHupvGGy2YuwUxkNEzsCQsBGAmmRDSeHfDPqTWQ94Sc/vK7TOtUq0Q
	 UgbR7zHf1aXrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 720C4383BF69;
	Thu, 11 Sep 2025 15:53:49 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1757568026.git.dsterba@suse.com>
References: <cover.1757568026.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1757568026.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc5-tag
X-PR-Tracked-Commit-Id: 3d1267475b94b3df7a61e4ea6788c7c5d9e473c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b10c31b70bf00ba4688c4b364691640a92b7f4bf
Message-Id: <175760602791.2231751.7350671412246257172.pr-tracker-bot@kernel.org>
Date: Thu, 11 Sep 2025 15:53:47 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Sep 2025 07:37:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b10c31b70bf00ba4688c4b364691640a92b7f4bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

