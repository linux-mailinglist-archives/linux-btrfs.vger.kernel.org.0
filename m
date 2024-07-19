Return-Path: <linux-btrfs+bounces-6619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CF1937D85
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 23:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31EF1C215B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 21:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB641494A7;
	Fri, 19 Jul 2024 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHak9JnR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C63149006;
	Fri, 19 Jul 2024 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721425187; cv=none; b=JxJD616qpOsHdZW/u8zS5SvQ9oWkgZl93pXnZYxY2lzFwSxg0KG6+yTBmQGceW9pA1BoA18IJCIg87sJT07i2uGVxvPjco/Szp9ca4PoMyMiqovzEo2heaNtW2+Lm7OMuFqNfAXVQCix3Z1SV2YglkeK86oR4y+lkPBM3xIaWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721425187; c=relaxed/simple;
	bh=rssDkRgbfRKqSKHIW2rnYnlVT+I6+i+QgyAGS+UzJnc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sGSuJ+yEoPJ5Z64lwm/3S2mr1YYhQGOlgIYTlJydtKZcLHlV16qCU1yBrlbWfzLqBHG8m3OMTC4hwIh8JNuCkdgjDwyRF1Li29RakxPf3yakWliNsmJ4gJeT3trv2B6pL/achPsaP9TxsRbni6KkDROMWPsupHs7QdVnt5id8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHak9JnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D841EC4AF0D;
	Fri, 19 Jul 2024 21:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721425186;
	bh=rssDkRgbfRKqSKHIW2rnYnlVT+I6+i+QgyAGS+UzJnc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XHak9JnREXxfHHmgklIacTpH6WBF8FDXgkd/isf+Qvxd96+9pjYqqjUMc/zjbH1Tp
	 kcp4bzxqOfNpEYX53z4+6NxOl2fL13LT8O9g6VpwpQxzb3pzAD1YFQjtFE8ZfTaq/y
	 gENhKuko57BoTmaYTZPqI4i9L7TErtgZ7vXL+vJnlC78zG0quNFxu0EiZMBur2uMER
	 Xvdp23K5hsYi3RgN66lTJm2YI0OkHUxgDUnxPsdW0yN7AjiRQ73nlzRKaGCAdYwtwr
	 hT3Mfv6TQZKrnKlTAiTfM7R8+lRNF8otyijya0J9w/12adjGlW6CkchyQbQyAdeGp/
	 b1Ci/yVvz9ZbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D14DDC4332C;
	Fri, 19 Jul 2024 21:39:46 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs build fix for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1721414023.git.dsterba@suse.com>
References: <cover.1721414023.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1721414023.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-tag
X-PR-Tracked-Commit-Id: c3ece6b7ffb4a7c00e8d53cbf4026a32b6127914
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53a5182c8a6805d3096336709ba5790d16f8c369
Message-Id: <172142518685.30667.17457169675976747376.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 21:39:46 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jul 2024 21:08:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53a5182c8a6805d3096336709ba5790d16f8c369

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

