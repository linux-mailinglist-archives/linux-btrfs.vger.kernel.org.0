Return-Path: <linux-btrfs+bounces-6527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2557C93431F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2024 22:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C392A1F21267
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2024 20:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B3B1862A0;
	Wed, 17 Jul 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBSQrFev"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2366D18411A;
	Wed, 17 Jul 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247494; cv=none; b=kXajgPNLDNtkDo7XBtarDhs6w52OJYY/H7VC1EnWeq8rTJ/bA8XlaiO4avuLgKJMciugLanQRTOXTt/jRQHHny6bCUxjEc0N4pmrRu5ghZ+b8r/fqRfc8FrT3rY+5k17z7dC+WJ8g/8PZMk3xb1w4J3wkzGynO4LDhbAotXPKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247494; c=relaxed/simple;
	bh=Lkz3dpBV74NsoXA5hxGco7iq2C240aTQ9v3iRAhIWWk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FJoiKsL9hwB5g4oC7E56wGvgMbr7USXikJP1VDgKPCGLFmmmZEAAl0/QpyuYAIy+eBR7Lt72MUPtvqqrY7gGZVPhHJu+Mz991u2HsB/3uSYy3oM4DJGtuL9bgovsuwcNI1AI4MXewrsQRIFoNbmz2EvkV+YmLG+1Y1psWw+i2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBSQrFev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 049D9C32782;
	Wed, 17 Jul 2024 20:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721247494;
	bh=Lkz3dpBV74NsoXA5hxGco7iq2C240aTQ9v3iRAhIWWk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CBSQrFevvdvYVL4xYGcdUaZ6WF2ppyIba5vdd6IkXQm6UcwL9J6+rloECwBCHSUSt
	 /hmPVx29cvuV8WGJfV1PN4QkPwrgjiWWIt28UBWQZSoWcKW8ucNKMktmhsXDi87Tbw
	 w4wAXy8uTOUtfNudZ1ee2OlXYqOWBJIqIgvcHLufE5HPaihDUQ2tNLJyrLZmVTWkrf
	 YYoHWP7CDrwps0HJlnaOTsGQQ97Ghui3PMQE7eWrwXHpQfLlsfDNeSeJSUyn3DDkU7
	 z+9qFUWRPe2ZXGwYTdzoCNTDVihI/CiKdIaDyndcvA3djEuMsIWyOX5OhaVARTxwqt
	 rCeI2nfIgy2gA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1198C4332D;
	Wed, 17 Jul 2024 20:18:13 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1721066206.git.dsterba@suse.com>
References: <cover.1721066206.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1721066206.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-tag
X-PR-Tracked-Commit-Id: 8e7860543a94784d744c7ce34b78a2e11beefa5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1b547f0f217cfb06af7eb4ce8488b02d83a0370
Message-Id: <172124749398.12217.874514148808412355.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 20:18:13 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 20:12:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1b547f0f217cfb06af7eb4ce8488b02d83a0370

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

