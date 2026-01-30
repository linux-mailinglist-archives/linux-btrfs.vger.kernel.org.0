Return-Path: <linux-btrfs+bounces-21228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ4HA0v7e2n4JgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21228-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 01:28:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECBEB5E90
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 01:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 278A3301B146
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 00:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A71280A29;
	Fri, 30 Jan 2026 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgaQKBoK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6D25C809;
	Fri, 30 Jan 2026 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769732935; cv=none; b=Kt/XmLjXLWUD8csN7UTJ0aCopV9etr5FHRrXkec8yjrUJAtQkREMohBZfcXcfCk64r+ZLSDYYFR23RHMFSQBWL2TjvQiEzGHI0ltPj8mlVaxDrFT6bVUU5f7ZMhiJHctwrdguTXhsIixWOTvqQxcHXmN1+/ZTh6HWqWeYouoT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769732935; c=relaxed/simple;
	bh=wTd7WhSbv9JKr9fTG+7JNPduPBN68HAyfOt9u0Bft6c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=h9xc+vkaD+Bq8MuUs0ZfnKKJeB72oSYsdqv3GQUGy9AWaGefXpRVSghCuEtGBJlTdVWtN0o7GvtWDeWfNakly3l+G7ozEPL2WmiNhKxwLv4y+zxOn8TiyHIMKMIlHPESWPlIhnGBAZno4cN/HdXeoeRN4W0CHgAl1V8tH5HQpOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgaQKBoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81743C16AAE;
	Fri, 30 Jan 2026 00:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769732935;
	bh=wTd7WhSbv9JKr9fTG+7JNPduPBN68HAyfOt9u0Bft6c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UgaQKBoKHxY9OZB2E5QZcLRjpkndnvsi+l6LdpVg5YV69fpZLbifZouY2bt/YozcA
	 fqvRpJpuIKhAQ0hl+Mxbx+ZBADAddkUwZdByKODE9JiDWfNNGOWOgwul1MuX/hj8uo
	 ofUYj4UJ8YmU2pi/nD1uM2b6a1C+Ro4qw5blYwcgHxHILA7LhAOOaymGgwm4vVqv/Y
	 mdXf+CV6W9theMbzpM+hWYqt4OeJgBTRcO/pKp45e5a7lSg5TmF4gCRrr6d3H63Oup
	 NtOY1EGX85wggm7fQmzBSNlRnHfKctKUo87Mdddjw3mTa//Twix9ZUDg+KfsYrVlq4
	 a1Aalp0YP3fEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BDB9380CEDD;
	Fri, 30 Jan 2026 00:28:49 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes fro 6.19-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1769696202.git.dsterba@suse.com>
References: <cover.1769696202.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1769696202.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc7-tag
X-PR-Tracked-Commit-Id: 0d0f1314e8f86f5205f71f9e31e272a1d008e40b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e829083bc46d3d79b9aade758c350ec12342c9bd
Message-Id: <176973292804.3113374.16041418878981083802.pr-tracker-bot@kernel.org>
Date: Fri, 30 Jan 2026 00:28:48 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21228-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6ECBEB5E90
X-Rspamd-Action: no action

The pull request you sent on Thu, 29 Jan 2026 15:25:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e829083bc46d3d79b9aade758c350ec12342c9bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

