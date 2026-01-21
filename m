Return-Path: <linux-btrfs+bounces-20864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDh5JHMccWmodQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20864-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:35:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2712D5B573
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3757A822502
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308823A1CFF;
	Wed, 21 Jan 2026 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V83KbcBk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403837E2E6;
	Wed, 21 Jan 2026 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019697; cv=none; b=RBTy+hr4OKFvRgnKS4YZRxT2BBrb0depoSAeBnvJnUY1Gkama1jgtMpdiapJk+xJ00YAVsER2N1TYG+0GIlt1N+KMxemjRh1SfbzS0LtAlBKTAjahg7Qd4+1n3coKr4J4LTN5ZPxpGPirK5Ep1vmaR8CzeEYF6fH2ZBmJ4rg1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019697; c=relaxed/simple;
	bh=0/oTLvIS6X78ZnthKCFsMcFf8ezdebr7fSXjGvxuhkA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JX6+TWCvm0kkOwW/YfhHIFsr797JVowpacSi3xJs+RReBEobga+DJGH8fzZbCz6I1iK0AFRdBd2xQIRAMJNkYD5ZFmVTcFiHRkI2C1k52s4NAsQztZ801Ehrdn+PxsHVrv1LiGOczDdZvjI+R9w41AdgTDRx6tAoL1P0qvk15iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V83KbcBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE7EC4CEF1;
	Wed, 21 Jan 2026 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769019697;
	bh=0/oTLvIS6X78ZnthKCFsMcFf8ezdebr7fSXjGvxuhkA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V83KbcBkmGYvltt1QM/9kr0m6fFBkJYFbU1bkB3W82HgMuzLxjYLWUCa25IA+m535
	 lYvTLJsDb9J9gTRrfX5CLzbVzqBhpqVBGCLAK7oTrHmGyM0ss4kFrLIHfFSpAJ4vba
	 wK2t1or6z1+WoasguHgI+ky4v8ICgphUNLlRpynfUL4pGfAoPLhEyjRx8nhO3QfJcf
	 BxleqwLHlZsPWfRX/zKUsFDP9isqD4PSfK67pckJ6bp3qdjL1ATb08O+xsoNarnQZ/
	 fulBn1LdJCM2YHI1tO4+aelDkvz0jv+mdYung9/tLbCoHEVueth90eqYAPHZdhGP9G
	 JRCLhJX5tXXZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8E063808200;
	Wed, 21 Jan 2026 18:21:35 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs fixes for 6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1768969871.git.dsterba@suse.com>
References: <cover.1768969871.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1768969871.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc6-tag
X-PR-Tracked-Commit-Id: 34308187395ff01f2d54007eb8b222f843bdf445
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07eebd934c9cb9f12f589ea5b826fa7ca056cb4d
Message-Id: <176901969429.1402269.10352506048533771133.pr-tracker-bot@kernel.org>
Date: Wed, 21 Jan 2026 18:21:34 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20864-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2712D5B573
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Wed, 21 Jan 2026 06:56:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07eebd934c9cb9f12f589ea5b826fa7ca056cb4d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

