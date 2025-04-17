Return-Path: <linux-btrfs+bounces-13145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B310A9235C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 19:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB943B84D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074432550A9;
	Thu, 17 Apr 2025 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHfnZEoR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C28135973;
	Thu, 17 Apr 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909565; cv=none; b=SdGRkhw2F1m2fas0G9sqgd1gxzpC4CFkaZW11pqTF84eTl2NWyIRVya3r8Aib5b4mhi517T0ZfkG/JzxBf8xWzxrlC8U0Scm2SwIhPrdfZIxgpcxayrqh8tWw7t2zf+R7uxneBcgbukAV4TnLbfF0NSsDFJ0mOnb22wwhe4lHEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909565; c=relaxed/simple;
	bh=SBU5oiFLZZUGSuqBBdeR7h27XUsKvGUBJIMbJBJwZWY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=vF6gJEvBdiR2bRFGc/prVXpstYzhay83zRLBAck3B9mWwCm6I/1iKTMx3ITmoK6kmXNabk1st8be+VhAD2higMm0zRv6pNrTAr490S7VNgmkFPPYr0sLQ1oHHBPzI6fkVWk3e6J31rT57Q9ZHHXGHTTzvj66HOv6AUjQsIuoeDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHfnZEoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AC5C4CEE4;
	Thu, 17 Apr 2025 17:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744909565;
	bh=SBU5oiFLZZUGSuqBBdeR7h27XUsKvGUBJIMbJBJwZWY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nHfnZEoRvS8Fk1gUBhd/HoCZQOzsQogHwyJVHexfHaa9DEEP3AB0HHOtUqp25fP8n
	 y4nlk4jQUCFCtUM8Aj6Ydh0gKImBGuOiGNd+rJ1fwtguYLTHt8yt42G57LfYGuZGbU
	 CuGzP7xZ/tF99rSSNJY/hOftr1klwAnWD1TrDseTthZTl5qDea920nmkAz2RNEoMIa
	 h9qXiBOGL0sGBE0hslwdHbUz6W2hKzC64CPfcaKCedh5IsPF6o3O/DbUdJWKW/NF8H
	 PBsTPKiDq+EgBOfzMjmTwMEqtnUntZVC1/KMGMUao8w7v85bOLrGEBY0tf2IEGj/qQ
	 tPhDulR48q8xQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DFE380664C;
	Thu, 17 Apr 2025 17:06:44 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.15-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1744883021.git.dsterba@suse.com>
References: <cover.1744883021.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1744883021.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc2-tag
X-PR-Tracked-Commit-Id: 65f2a3b2323edde7c5de3a44e67fec00873b4217
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cb9ce06a682b251d350ded18965a3dfa5d13595
Message-Id: <174490960310.4147514.14308348248878569495.pr-tracker-bot@kernel.org>
Date: Thu, 17 Apr 2025 17:06:43 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Apr 2025 11:49:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cb9ce06a682b251d350ded18965a3dfa5d13595

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

