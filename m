Return-Path: <linux-btrfs+bounces-3685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5564F88F170
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 22:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E826D1F2D310
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 21:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26198153BE1;
	Wed, 27 Mar 2024 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tInB74ik"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF08383A3;
	Wed, 27 Mar 2024 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576625; cv=none; b=ReM7dZBo313BWvQS/NqmT29Exnt6rQmaU4LASaG4QkEsKOe4Ymy73LJqVJsBFb6axGgMEYKEwrg/BFJZ9WQmp8BZjci5uY5hjAlTSh10dtLJIbgJSHA28QGpf0f50oPUOuq7QUPf1xb3DIA3nWg1CDc/lFF063te5kIVTNLxp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576625; c=relaxed/simple;
	bh=R03k2iNA6mn8aOBmXhKL6b85cm3baq7AW4OLPbqCTmk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mBMvuYL1YhSs5KOE6qlA2bohfqu+AP/oVGLi0b/Oh/4P/oWV1/BdG47T5L1DNvscRsuaNgOoB0AYPCkiR2vFZDyWVCnpgH1ZAyQ13qmJJZoGYRYItmu2zcCy8ggOdC68rRFe2abGBfm65mjlp7iJLusYH82dDIcJ9dUSUlmIRfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tInB74ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3751C433C7;
	Wed, 27 Mar 2024 21:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711576624;
	bh=R03k2iNA6mn8aOBmXhKL6b85cm3baq7AW4OLPbqCTmk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tInB74ikrM8xoDkUeQyfMBj+oWx7Ezbq8cjXbHORzb4HU/jfQTQ5eGoqbZz6u3uaT
	 iTOwxZtJtHVoDvcL5l2Fg34ozYjqJy58Fci5CTh/eKsuHOwSSA6QjbixsUh7NhVfiE
	 D3uqxOjkci0Vsl9NP83Hpdb2sJOvR/LjvBHYNmc1lsbPKnZP7RPxH/h1xdVoBYvBUl
	 Z6X+Rd0wrBOt1LPkUaDsb5+r82D+KpmIRssa4/71Fk2FApgWNuSLznzVf1/Rk4QGFU
	 AL6dNkGjhaXUYzLKR7igNTsjpPrZSyV/cUYVVzjEofsTyRkEzZ+9lonnlhyp9rHhRW
	 /yEeWWm7foO5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA269D2D0EC;
	Wed, 27 Mar 2024 21:57:04 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.9-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1711571199.git.dsterba@suse.com>
References: <cover.1711571199.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1711571199.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc1-tag
X-PR-Tracked-Commit-Id: ef1e68236b9153c27cb7cf29ead0c532870d4215
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 400dd456bda8be0b566f2690c51609ea02f85766
Message-Id: <171157662475.29991.2167921703743876804.pr-tracker-bot@kernel.org>
Date: Wed, 27 Mar 2024 21:57:04 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Mar 2024 21:32:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/400dd456bda8be0b566f2690c51609ea02f85766

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

