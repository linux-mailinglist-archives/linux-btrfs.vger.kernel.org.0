Return-Path: <linux-btrfs+bounces-12628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF2A73F78
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 21:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23001781A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 20:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5009B1C5D44;
	Thu, 27 Mar 2025 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuHhyN91"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8EA1CD1F;
	Thu, 27 Mar 2025 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743108493; cv=none; b=VuNwTtMa2B+Z5FF1d1e9jGHmESu2zES+gqQh3pLmnG5rw5QZVp1ayM6RXh8DeGvOuVPBSWdue7IIddWJm8dBNEpVF5RrLWZ4sia0QUq0jom4wh8ODFrDDKdp8d1AJVE7idr1QUEQPM/JSaWSUkIEZFH+upA0hSHP/B6WA0hYpbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743108493; c=relaxed/simple;
	bh=hvrtJzut9P+ZZY9O46eNABanhE1pLtYPk34bOUSKwns=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jLf8Ve+MGMFYDFtOSA/pPLKPfyonW8XW8i5YsnRXmkfh/6MwYVt4E8kMyH0rxTUN8P3Y//5++IVwkGTOj3D6buh53CoDTG7peub0XLrX8jxm48RIvf4asDQVf+tG7OuZ5/4o7BUYHozuftOwpXvtSo9At7AR0R8sxpGXUFvgFH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuHhyN91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F76BC4CEDD;
	Thu, 27 Mar 2025 20:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743108493;
	bh=hvrtJzut9P+ZZY9O46eNABanhE1pLtYPk34bOUSKwns=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HuHhyN91DyPv02FUVpvSHDqm2TzeZyId1PBDAtglAViaGA0FhiSbZE+NF40OGgoAb
	 a//bZoMVUfsfnG6bOcj1WN472Avd8ZMKDafzh5TWYYKuEXEyWJOSxv3ie96TPHjeqr
	 QQqVHXea5AxT0UUbrm5nHVywjYXojNtb9Vri+wxUSB22WxLf2KTW4zKjx72kOHPYpp
	 yom8vFf7EyRDSOuEaY7ZLXoYNpNo/UQUs88bJAXaIFtp4g+Ve8ZwHwk3WlFLeUtArj
	 7skTl2LbHXXLdjDWQotmEL7O2E+E+/amPrYITewiz2x+CQQBjpgZ/RJRCJ3DRBoqzE
	 O40jmZ0ku4Nbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD76380AAFD;
	Thu, 27 Mar 2025 20:48:50 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1742834133.git.dsterba@suse.com>
References: <cover.1742834133.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1742834133.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-tag
X-PR-Tracked-Commit-Id: 35fec1089ebb5617f85884d3fa6a699ce6337a75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd71def6d9abc5ae362fb9995d46049b7b0ed391
Message-Id: <174310852961.2212788.18169823982955970522.pr-tracker-bot@kernel.org>
Date: Thu, 27 Mar 2025 20:48:49 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Mar 2025 17:37:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd71def6d9abc5ae362fb9995d46049b7b0ed391

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

