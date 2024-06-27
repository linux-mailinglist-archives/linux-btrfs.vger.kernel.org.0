Return-Path: <linux-btrfs+bounces-6023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D30A891AE44
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 19:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB491F2479C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 17:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F7719CCE3;
	Thu, 27 Jun 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1ANrSnA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D819B593;
	Thu, 27 Jun 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509661; cv=none; b=dfKCzB/qfLf0CwonzccceDmxDEzBECN98s+ic+odoM+lEI8/1xupyNAGOjC4AtZcPvbc9GpGCFh7Pb7f7OclHt3pzaXMP5Jp1Lha+cvgU1kshVo824HaWxIDgfCyac13qcbYV831nqLblbI/ORZttrRdcTRCBz8zeE5IBvAwrZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509661; c=relaxed/simple;
	bh=jbR50wR7fOEcwPe7PpPCUWslNiFaZWf/UsFbwwEWOyQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b1KgHauxAID83tHbKQxjbx3iVdYKQJ+Z7Fljr48aIBX+hMuhVwPIZOok/6Eu0Hq6PTEhCIiARwuGw6K44qbwnOnRMbadWgVf0AVj3yGfejHK2tz0GRHdL28HY3ryMFHHISt94qxohVwu83SB2MjRoImGDij1sBC/8YJr1gDDUD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1ANrSnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2656AC2BBFC;
	Thu, 27 Jun 2024 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719509661;
	bh=jbR50wR7fOEcwPe7PpPCUWslNiFaZWf/UsFbwwEWOyQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c1ANrSnAgX0PVm0X6MnLdAyKbJsIDELUQ+C4A6yY0oB41KzsgmZ5CzsPw9yRP1No5
	 s1oMf3+fKGEtiMn3VRyDMg8pvzKX2p+Q8wJ+26Mtr7ZVDJzxdFd9n6SWXAsldJ1YPM
	 NI5GVpVJT00+NYLiliTDWRk5w9Nlo5XRfdGO/W3MjTiMoAPAkJj/CFFMSVrm1dE8bi
	 69HkhZOg5Nxa1nFWv3WJAcODcm5SnG/9zbB9kZ9TDjEmjqqys2jhldVU9cInrjpCuS
	 ztOTcuAZy37aJJh6iWxOonfB8eLF3OYOy7BiG9K7iFu2IOpB0Km0nA3XceydIvGodG
	 G1DdHHT1JCONw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D353C433E9;
	Thu, 27 Jun 2024 17:34:21 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1719501798.git.dsterba@suse.com>
References: <cover.1719501798.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-btrfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1719501798.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc5-tag
X-PR-Tracked-Commit-Id: a7e4c6a3031c74078dba7fa36239d0f4fe476c53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66e55ff12e7391549c4a85a7a96471dcf891cb03
Message-Id: <171950966111.28398.7864370294577619389.pr-tracker-bot@kernel.org>
Date: Thu, 27 Jun 2024 17:34:21 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Jun 2024 17:28:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66e55ff12e7391549c4a85a7a96471dcf891cb03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

