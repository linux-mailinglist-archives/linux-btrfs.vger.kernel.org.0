Return-Path: <linux-btrfs+bounces-10653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E79459FE027
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2024 19:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853E31881D09
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2024 18:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB4E198E78;
	Sun, 29 Dec 2024 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvLDkyo9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0012259497;
	Sun, 29 Dec 2024 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735496534; cv=none; b=Dyy76f6Tz0Kt954oJc+5UEt7a5u7noNx7BhrUM2kf0MEZIompf0lxp34MvLTdc/nKb2T8qqNDey1qJoTDOa7sDgrCDhgfE13MI5ALrnmwOkZ+zcPnlG1GIYHWddib314mk/GPFnYJXXVU15CrXXwRCbms3ACmTgRMbDEtYv7BBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735496534; c=relaxed/simple;
	bh=KDAjsVkLuTq5c9glr2ComOzkZMlG50v9ryz8mNsd9Jo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nlcFGyNkUd2bY3UMEyQqdTkgqznwUqJAhCRkRI4C4IZiUgvthsU1DDmgvmt9vPMO70emdAilLdZpYcgxwDaxfH9H2T5KSouuLRcHVjPO+pBz0bZd3QhI36oi9V/E+p14+0ZlVtouuarvLFQGC3iu8hogwujt5caHT8RRPncXhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvLDkyo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9DBC4CED1;
	Sun, 29 Dec 2024 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735496534;
	bh=KDAjsVkLuTq5c9glr2ComOzkZMlG50v9ryz8mNsd9Jo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZvLDkyo9hlrZFZAs3hwPNxANbAdrh5CzajM+OQLhafUlonFYAKVYDM4KfRvOhedGG
	 NMmlu3GeFdjNhAJqhEekU4QIPga81Omi9f3Ru9JqM7LhB7Om+8FBNA9ZpA8dCwcVc1
	 P5YOqaTOIEcppMjv9zMakWukxXEmPqfpWtMGKH0WmE76XCZpZvkq15eOSPnPTz6HPf
	 GZiwJbIriSBSjbQymmy7aMu3D+m6oXYFjFLRTB1F7okbv5mmTV0VKAUutq0T3LpXuv
	 IzCvsXORVtRM0KYXvZDKa2q6dwBylFRmSrJ6L0VTHi/z0GjKE0K4QLsATaEOS/xXAM
	 ZjSQlhhc/3pHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713533805DB2;
	Sun, 29 Dec 2024 18:22:35 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.13-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1735454878.git.dsterba@suse.com>
References: <cover.1735454878.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1735454878.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc4-tag
X-PR-Tracked-Commit-Id: fca432e73db2bec0fdbfbf6d98d3ebcd5388a977
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c059361673e487fe33bb736fb944f313024ad726
Message-Id: <173549655405.903038.4973819165119138289.pr-tracker-bot@kernel.org>
Date: Sun, 29 Dec 2024 18:22:34 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 29 Dec 2024 08:40:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c059361673e487fe33bb736fb944f313024ad726

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

