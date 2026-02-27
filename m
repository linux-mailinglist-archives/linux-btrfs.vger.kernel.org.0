Return-Path: <linux-btrfs+bounces-22071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO4aBcO3oWm+vwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22071-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 16:26:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C71051B9C0A
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 16:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D3FF31F51BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573C643900C;
	Fri, 27 Feb 2026 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="FniFIb8Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225EA280CE0;
	Fri, 27 Feb 2026 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205502; cv=none; b=H+AbkdJ6Ah5lyw3jjEtiy0RAMNbmzrqPlcXpTVxotAQcYddJwt+92MbkWPOIBtm2pyFp+TeXiTNScmk8aG3FutpkXNks9ddBdHGxe6rVSdxmqynPDbosMdu6/FMjZFb4N2BDIBN8c8b3McybBmCXI5/Hx2VoxAtttCxpbVb4+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205502; c=relaxed/simple;
	bh=+cfb6IvSmOUNpAyIkQAjmb3z/qLAYFCDcKMtEcyfwbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VXJyBlY5BJRFb3+T3IQhFJF6BiPpk15fP2enOV/Orwkp/E9eM7oYtegyVokqGlZg3h9+bJvZXm0Le786ogFg4LxzjSkPeRSztT2uUmDi8KBDo5t6eLLxyv7loQBxxI0VhQyu08UzLLg7LBWEqSq1ApbxXagcElRBBuXJY+aNfbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=FniFIb8Y; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fMsQw2tDZz9vCV;
	Fri, 27 Feb 2026 16:18:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1772205496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gBbbdgxVzQwq3LWQYxOQfME49wY4rmVdfMiK2jHYQ8Y=;
	b=FniFIb8YiSeACR6SPqMAmyi2CORp+DqLEZCtraUxgzEv6VIhJ0wi8IxTElxo6V739NAOe1
	uVM53NrcBGfUp6BSfr8+1ezMVzDHgSN+Ynl3nImBvL4es+A48I5ISzs8fzrM/Vzc+geRSL
	Ett7S/gInB6fuP3VCrfm+T0YzgEeoQu1etFEMYdSuEvOHTx5u/r5hgo02OVogoWJBtPwUN
	TGyJFzUfBpz9UNTbXId7tBSf4EufbjN8iphkvnMTiqhR+YbgKv+FnkwT2U4yE/dHf7hmYD
	wYRzcA4qmLJ6dmZ4JzAxHMw0LkaFR0HyWeTeq/RpySkxLG51hHLMWczz+Ex/kg==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: dsterba@suse.com
Cc: clm@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH 0/2] btrfs: return early in allocation failures
Date: Fri, 27 Feb 2026 16:17:57 +0100
Message-ID: <20260227151759.704838-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.39 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.77)[subject];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22071-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mssola.com:mid,mssola.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C71051B9C0A
X-Rspamd-Action: no action

Minor cleanups I saw when I was working on [1]. Both commits are related to
a pattern where two pointers were being initialized and checked after that.

[1] https://lore.kernel.org/linux-btrfs/20260223234451.277369-1-mssola@mssola.com/

Miquel Sabaté Solà (2):
  btrfs: return early if allocations fail on add_block_entry()
  btrfs: return early if allocations fail on raid56

 fs/btrfs/raid56.c     | 29 ++++++++++++++++++-----------
 fs/btrfs/ref-verify.c | 10 ++++++----
 2 files changed, 24 insertions(+), 15 deletions(-)

--
2.53.0

