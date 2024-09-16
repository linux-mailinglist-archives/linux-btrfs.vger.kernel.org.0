Return-Path: <linux-btrfs+bounces-8059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DD597A039
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 13:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B819E1C20A46
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 11:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220D5158DBA;
	Mon, 16 Sep 2024 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUFEfAbi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C815687D;
	Mon, 16 Sep 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726485965; cv=none; b=bI09NDPPKc87IzVcSn9nnAZceBvcsVv+/wKJkRVY0urXn0LkHf9h1Oo7e6k/zyC37iUFJnYN4ZmXcM6BJ9pB1je2oZ7/vQtC3Aic4lOMIPP/rkuHQQJNSDq6Hnew4EzUYKRbnBFeqDyr5ibAjZezwnY/yWAZok4NQFcdpKtBNdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726485965; c=relaxed/simple;
	bh=W57S6AxpGsc3P1d0msCUZwX5AjdIrVuQiYi5hQFS9Vs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iOEv2g6/sGm9RXh2GsDl3zdaJW1lXt8yTkgJrjrXT4GGrLiugzjaqW0nKYQuftuum/UNBSQPqg9/Tg81AV+YsgD+94wAbxD7vC5xcqdnEoygmoWr1bH5S/A35rhXmV7EjPC5hx05iZX2WxarsZwksw0QRp+uoc+scd4z0ICN/Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUFEfAbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294A0C4CEC4;
	Mon, 16 Sep 2024 11:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726485965;
	bh=W57S6AxpGsc3P1d0msCUZwX5AjdIrVuQiYi5hQFS9Vs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DUFEfAbiL/skhEulQL+1Dle/LEE6UDgN7QPOKJuQNJrZ/Lzww4LYalt7cEnns3jlq
	 f8tJsUYJ6AW24wjXtUkPOp4hsIIS3GB7kDtyag5X5w/xogDo0fZDGbeqbQdbgbRnQi
	 +26oJoNZjmaGW9UEi1otOLfJc2ddn2rIYGtEfVEHWE0FNyND/z3CTWKIS3eKxn/TZh
	 zZhw2W4Is3Wktf2Z8v06GOoYIWX5Jvm3cssS62il+yTEJpxICoSVPcCZaODBw2X69m
	 8LWDYuyRV00NlsKV+mzx/m7JBaNK/8DXSAZIuw9N2AG3UVqqIJZwtFp/oEOUvqYjPH
	 nIDY47XAUkDNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD373809A80;
	Mon, 16 Sep 2024 11:26:07 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1726154772.git.dsterba@suse.com>
References: <cover.1726154772.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1726154772.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-tag
X-PR-Tracked-Commit-Id: bd610c0937aaf03b2835638ada1fab8b0524c61a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a40974fd0efa3698de4c6d1d0ee0436bcc4445d
Message-Id: <172648596663.3656894.1216810674713564618.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 11:26:06 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 18:08:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a40974fd0efa3698de4c6d1d0ee0436bcc4445d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

