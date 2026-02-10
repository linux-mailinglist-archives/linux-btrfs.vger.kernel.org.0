Return-Path: <linux-btrfs+bounces-21570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKoNHvqCimlaLQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21570-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 01:59:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D658D115DDB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 01:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC20530B67BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 00:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C8C32E134;
	Tue, 10 Feb 2026 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ll9KwoFg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E72690D5;
	Tue, 10 Feb 2026 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684636; cv=none; b=IBAq9DD+6JUpupG/tjT82Xcuq7sFhNdlyGB4549UeT24JRbtOYdTuvl0u2Xa7RVw3AGXm7opwxXu33NgaMdTPUwegP7Z657AAnzOizvRgQm20+DNhlGFGp0V8l1IheTycKiePXOehPs3BrpCjJfYsZljS5XLkk8vqdWLwP0j4ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684636; c=relaxed/simple;
	bh=GWyACOMTuNW+3JFAfZJLgpBLDZK50rqW2ci+Djg5jmU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eN1o+VAz1W907xr8MWTpWz5bkNxcjmM66NcHRtJ2HUCwsMqVnzu7SGcXdAAseVCzcbCTQ6yf6enT+sgMODlQFEgGfMryLPkcQo7lwE0DoA/j/DohH17IxzcCnNkUgJUcJ0ItBOFoVd+vW5gmpuFwOS6Q6JSUglU4lEO/0/TZ6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ll9KwoFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEC7C19423;
	Tue, 10 Feb 2026 00:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770684636;
	bh=GWyACOMTuNW+3JFAfZJLgpBLDZK50rqW2ci+Djg5jmU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ll9KwoFgqpFMQzfbcDavTJ+8nPNhRpCSucrvzJG2CY6iUUzdko5Z5NBtsBAgQeKKv
	 phrkos8RjwNObPPx9xvaq3J/g7yUIkIPP2HNBQ4j6igvvVxvQ+TITe1bDiCHl7ugwi
	 uB7SPkYMvL+X3jSJlg5NzKSUdQuLvFYtSNLnp8z59hwb2gwupz9zeDZcuCqGwjllYu
	 uLp6BjlNcyfuted0Jv+tq/jvzcwRvH9DlCuC0YwW4luZiTh+/ALF5cS8w6nyUsBeJv
	 xCDtS1KEx7feQcntUNbpK+Lol4z6rEBg0efFtAAU1qHamkUVjd6FTEUTitunmQrxrG
	 cNzdS3y2mwuhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E20F1380AA4B;
	Tue, 10 Feb 2026 00:50:32 +0000 (UTC)
Subject: Re: [GIT PULL] Btrfs updates for 6.20/7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <cover.1770394394.git.dsterba@suse.com>
References: <cover.1770394394.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1770394394.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.20-tag
X-PR-Tracked-Commit-Id: 161ab30da6899f31f8128cec7c833e99fa4d06d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8912c2fd5830e976c0deaeb0b2a458ce6b4718c7
Message-Id: <177068463181.3270491.4136637588216666235.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 00:50:31 +0000
To: David Sterba <dsterba@suse.com>
Cc: torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21570-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D658D115DDB
X-Rspamd-Action: no action

The pull request you sent on Fri,  6 Feb 2026 18:32:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.20-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8912c2fd5830e976c0deaeb0b2a458ce6b4718c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

