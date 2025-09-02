Return-Path: <linux-btrfs+bounces-16603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD20B40EA1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 22:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8222086BF
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 20:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0937B3570AE;
	Tue,  2 Sep 2025 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiiG780H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F842E7F03;
	Tue,  2 Sep 2025 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845762; cv=none; b=DC4iLWsrqcXj1llUJladGrFKXA7PLJyUunAtscaOJTZh6UAqABVd5hDjfiYwGIrs4gR6/LRMoUIJNHD5KPuzgfUVPMdeUJAGplyM5r9+Ca+sqgUpfOdUlLHs1bbdexLESELFvqPN95C+wQJX9G52jJTSpoaDE/4Dulgv7z/tdEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845762; c=relaxed/simple;
	bh=6PolMXr7V9/om7s5N/8bKOsiN9YgzfekkHjI7lF2tFs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k74rz8Bahmgqb8C/2fJqRyQIEOe9IyW8nfWkCntXqqItr4jHZnFNzmH0MobRZ3yQaDXsGy+fbPwZiGIVvbEYjVLohvlmHiOg2n7im6Sxf0yc7Eem8X652BW2AuMVjHy75I4Lc8xvEHkSnHJh+fGvCppmYRrk7S7dB4YdtZ8WdXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiiG780H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00170C4CEFB;
	Tue,  2 Sep 2025 20:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756845762;
	bh=6PolMXr7V9/om7s5N/8bKOsiN9YgzfekkHjI7lF2tFs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DiiG780HUKTe+BJcDQwp8PloZtzJiweFAeujIFIa6x6sGcphRneClMVgmmoH6mx9h
	 bgGOAxVFDFMb+9LOhlC0fLVqilbfnhuKVYHCOU9vjjOWjahA2llYH/UWzG2f8P6L2I
	 +CIae33IWWqzKq2sF6UOQ5xoI3Tgurg1DLvpxS+HORmslzDDU1hOAuS7MW/ge4LU2b
	 qHHAS6k8MhoQKnX1vwC37/+dAT6E2pa0tAVkczbYJVEPf8iITFcM/2CzuuTHW4uhvr
	 KBgmawgOC16Pop6ExmzIXfkVR7f+z4geCbS5v6ue+tKy6169IozpSxvEGktu2O8jBw
	 5diggCsgpWauQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE402383BF64;
	Tue,  2 Sep 2025 20:42:48 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.17-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1756838388.git.dsterba@suse.com>
References: <cover.1756838388.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1756838388.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc4-tag
X-PR-Tracked-Commit-Id: 986bf6ed44dff7fbae7b43a0882757ee7f5ba21b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3c94a539e767c7bf055be4ed6911246812fcb6e
Message-Id: <175684576730.430647.15668704873181205524.pr-tracker-bot@kernel.org>
Date: Tue, 02 Sep 2025 20:42:47 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  2 Sep 2025 20:44:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3c94a539e767c7bf055be4ed6911246812fcb6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

