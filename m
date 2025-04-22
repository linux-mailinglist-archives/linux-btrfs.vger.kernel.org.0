Return-Path: <linux-btrfs+bounces-13251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EFEA97809
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 22:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF951B60499
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097272DDD12;
	Tue, 22 Apr 2025 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCOAtaxU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491742DCB66;
	Tue, 22 Apr 2025 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745355238; cv=none; b=EK5OCEMv7zCr9+eIhNjzB5RkFz5ZKlfYJfAxt5CDnme4bQilKdWY9f5dapEtDOBA7EIujDqukCM/hcP7yLY1rKdMLX2Q3vQ0Ks+Om6daPL6b2geTv5038EHeizF9AmmipOcHWmIqUqKfL23MeG3QWy7ruCcKoj5sqNKzwoHejHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745355238; c=relaxed/simple;
	bh=emc+VwKYMQI73wMQlE+PSJfF3ndJu9fQIhuORNCl99U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ff+cVAiTaL2JcFwAkrcJt5psd8nLO8YTjWSSWaEc6+O4pnTn1O3z+zSSDwXIdCZUehehYx0bPxkVocD+IvKqabNCXiuqeoxPox7hfDucKgycrGMNymVi4ENATItNVoZKO9JoHc/rcIT/mxCCea2qUdQA2lMXF7QkFpdB+5Qj5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCOAtaxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE18C4CEED;
	Tue, 22 Apr 2025 20:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745355237;
	bh=emc+VwKYMQI73wMQlE+PSJfF3ndJu9fQIhuORNCl99U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oCOAtaxU9orgNTYQrp36lxdYI92v8WNReojl/iVwK0uovLDAFUaTt0jL4deTo1PN2
	 aU7UxlSNQO+pcvPFsQVwIAUFSV3QNclBobOPj26CkqHPB7EM/KVQCryxEOk3PJQvdB
	 U8hhaxyqUy4xYA/b9VVBIwpP9Q7kaSGmQE0XrI+yntriJGLiu47yWW9QPvuEKfsXfE
	 6LzRsrrEUKu5jFb2cJFs39rF7SEZ11xigSNcUX0IRAlvSMu0ztTVKY3gsKZADDjgKH
	 HCgbZZzF+Xd3dX2K/BqVQTP/EkOuL4zXKp97kDO5NGmsNzBY8qrObtpon2JJzuf457
	 BMu/8WsECMI9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA6380CEF4;
	Tue, 22 Apr 2025 20:54:37 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.15-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1745339483.git.dsterba@suse.com>
References: <cover.1745339483.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1745339483.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc3-tag
X-PR-Tracked-Commit-Id: 866bafae59ecffcf1840d846cd79740be29f21d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc3372351d0c8b2726b7d4229b878342e3e6b0e8
Message-Id: <174535527613.2047083.2610446160458854190.pr-tracker-bot@kernel.org>
Date: Tue, 22 Apr 2025 20:54:36 +0000
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 22 Apr 2025 18:52:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc3372351d0c8b2726b7d4229b878342e3e6b0e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

