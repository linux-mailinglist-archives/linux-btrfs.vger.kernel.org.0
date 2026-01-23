Return-Path: <linux-btrfs+bounces-20956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOxmMilLc2lDugAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20956-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 11:19:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5897574376
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 11:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF7653015D04
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 10:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F333A9F9;
	Fri, 23 Jan 2026 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+TGheqC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1064E1EA84
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163482; cv=none; b=jD1vubrtQgnHV0i8K9/21JNcV6yl7yd+hZXlCATKchRfe+bVtAIrlE6WxNXN6ABKZDn1Hu1eiUQYEsfVtNVeKMgvIqZCeiVSES3ox+KzY5BKc6spthEoABomncOhveCmCDy/7GogWS0/hpYffhsdNU4YfUh2cjbyMAXkTgz7Ltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163482; c=relaxed/simple;
	bh=IAaZhXB6HhwrTsE2osbxXFCGyRa8jHT/BU3N2CstOIw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=de3nFdfB5bXzLnaRI3MsS/dRB7v1pERl+KrVn/rOmc49uAdOTq4RdYYq+sk3xGkJni1FxD+OkNykwYwBroOM8crm+yTFvzalR2/EJpe0i48DAU9lkzZ9sAFWWLwoQM6Az9l0PGZ1QJyod70SSnzODvlFZO+xUjpgaGRSeQffyaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+TGheqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E183C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 10:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769163481;
	bh=IAaZhXB6HhwrTsE2osbxXFCGyRa8jHT/BU3N2CstOIw=;
	h=From:To:Subject:Date:From;
	b=D+TGheqCHEgwYuCidDxh7tHhW0cI91lii/rKudjv8ku6pYTji5vhQlG3wbSU5jnMX
	 bYX5jOslgDFD2H3IwlYKZRBljRVX+6KhHO4lhpeeDTNpOOeRV/DXwP/whUZ/iGkWbu
	 W4xS9NqPp2p7R2RDOP0EtUJ8ptEnjgNlufVO2bTGzECr6XKwMrUh++rKEeY8IoOWcH
	 I3DG5FrpcZ9fLqYkHqHu9nIzPvhjW5we46vwhmRYuf7yE61KI6BXn7uAUIqZG3jQX3
	 OuEsa+DAEescHKW9XbSkme60A//vurg7xzgmx6Gww5FU6wcj4ZFWqX1ZEnik875cmf
	 vMzyLYy8jfuoA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: unfold transaction aborts for bg delete and get rid of a BUG_ON()
Date: Fri, 23 Jan 2026 10:17:56 +0000
Message-ID: <cover.1769163248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20956-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5897574376
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Simple changes, details in the change logs.

Filipe Manana (2):
  btrfs: abort transaction on error in btrfs_remove_block_group()
  btrfs: do not BUG_ON() in btrfs_remove_block_group()

 fs/btrfs/block-group.c | 26 ++++++++++++++++++++------
 fs/btrfs/volumes.c     |  7 +++----
 2 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.47.2


