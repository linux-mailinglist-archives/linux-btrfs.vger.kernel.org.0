Return-Path: <linux-btrfs+bounces-5285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653488CE8DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 18:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9635F1C20F8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF54130A79;
	Fri, 24 May 2024 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNK2MsSJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA31304A9;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569128; cv=none; b=CnSeKmUdmgLXla4zZ4kJD0Ydj5Pbjb9RR3MjzeCIxDQQQP5T/xF1dt1pOCFZAzf97TX90K6NHZf5mDBFZjSxr0q0TEwMc7L72yEVwvxDsndHLTF7kkMs+Hqm8KoX7c8JnRKyKfI9cmI/uxHb2I3enipalqtjArNX26yPj7ortmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569128; c=relaxed/simple;
	bh=j5k416KgRdCR7nEH6eiukAgq4TdyDtOc87CReR42TMs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TUDBMv/Dq6403B/gHro6k8EPSqOwQXys/26Usbk1xzK3WUsf22FhP8oTAjmiC4dFkJRlNwKjhBwty9O55ARN/nC07CQOTeUACe/AUrjZyy4T59brntrkowGU5ja4T+AIPZFWzpHEc9Uas++fuv04ji/CMaX/VL7EQRX7oZK0mfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNK2MsSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9BE4C4AF13;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716569127;
	bh=j5k416KgRdCR7nEH6eiukAgq4TdyDtOc87CReR42TMs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bNK2MsSJpf1ZKzWvXnnVQDPpbbmm/KcdCq7k/QwvpSWAQ2gnZUIdTlsxLbFIQX/b7
	 v4qZeCK2KgPFljP/SrXpepSXCL1ZkTweDgwb5H340wkHv/Cmk4JemjOdFp4CY9Az/R
	 yIvTjOeuiXbAwlI4wgOAukpmehIlSpPmNgJOdNkXSdA4tlPHmMeRG5DlAXraA/9VGO
	 wONT4mq62dVhYdkQ+Bzc3wtNlfEYde1B8PYr/BuYZ9WoR0BIpXXnJ5ILSQf/JRsuUq
	 NxjbE0X9SXzqOn9E6+Z7dcooQgnE7Xj5Fflg24VnC8Lx7JVD03QJ+EwbFV/44DbkDh
	 eB2Ij1CSBUDQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97083CF21F1;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updtes for 6.10, part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1716556959.git.dsterba@suse.com>
References: <cover.1716556959.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1716556959.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-tag
X-PR-Tracked-Commit-Id: 440861b1a03c72cc7be4a307e178dcaa6894479b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02c438bbfffeabf8c958108f9cf88cdb1a11a323
Message-Id: <171656912761.29701.16727365323702918687.pr-tracker-bot@kernel.org>
Date: Fri, 24 May 2024 16:45:27 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 May 2024 15:59:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02c438bbfffeabf8c958108f9cf88cdb1a11a323

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

