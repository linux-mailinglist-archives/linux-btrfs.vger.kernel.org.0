Return-Path: <linux-btrfs+bounces-10216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445569EC20F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 03:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FBA284A52
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 02:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE0D1FC7D5;
	Wed, 11 Dec 2024 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKmtDDOn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC8818EAD;
	Wed, 11 Dec 2024 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883964; cv=none; b=DisOTYpgiEvITR8h23/6rInDESnMBq1NyRZWF2zDS4aqZVIGmeVFbZdpP5DshQJskRP9obZ1PqAhVGueemOUFvrDSOf3aq4zo4ZmLCPtvFNcbpxHG3y4vC6K2KhGGk2kBVu1UFUQ1glsR9Zosf+LMfQhLXlBmJHlIkswUCpEgLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883964; c=relaxed/simple;
	bh=coAwzavf14S9kP4Xqyrh2t4My0/Wa8fwIFduV6zKhXg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b78OboyKyiMpNOMUPwlEirgy9SKuGViMlJg93r/7Ufku875NzGXwSBKyJ05f8EGHAvfJaf8AnkPArWTcXTtq0FgmkR7u2sIUJSS1z+B8u7CCAXozDW1aUaISOhL3PQoYxW1GysJddYrxxYVGxxpacAtZiHDCrVpRw9oeKRixDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKmtDDOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCE1C4CED6;
	Wed, 11 Dec 2024 02:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733883964;
	bh=coAwzavf14S9kP4Xqyrh2t4My0/Wa8fwIFduV6zKhXg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IKmtDDOn+GsxfZx4b5UdzIrGx0DMR+316nURUphpiTxygAGFma3nSeKZAbUkDPL80
	 gyEEcpquhzVVDYhSziQBUxgWYmGk6YFadAR822gFPlv23McG9O+PVw04+wDDj2V8eO
	 PmN3vo26N+rdcDxyUka0xw+5vxTkKSkVaiHqqZIIVTiOgjJfG0jC3ulGrhjCnTfCpF
	 T9LnIJCR9wlo0DzHpmIP768PHcxqnTIFCtlwpqDp4CMgLXU/sKc+wBL8yV1BqqXDuP
	 TAyWe4rAJ5HcUmpAIzYs101awhxi0pvSoRSU4CR33qsyobIeB6bFn1RQGiQIbuOtR2
	 kNLqUHq23hlvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F1A380A954;
	Wed, 11 Dec 2024 02:26:21 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1733873735.git.dsterba@suse.com>
References: <cover.1733873735.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1733873735.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc2-tag
X-PR-Tracked-Commit-Id: f10bef73fb355e3fc85e63a50386798be68ff486
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a087a6b17eeb64893b81d08d38e6f6300419ee5
Message-Id: <173388397976.1089022.12948638547906719016.pr-tracker-bot@kernel.org>
Date: Wed, 11 Dec 2024 02:26:19 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 11 Dec 2024 00:55:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a087a6b17eeb64893b81d08d38e6f6300419ee5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

