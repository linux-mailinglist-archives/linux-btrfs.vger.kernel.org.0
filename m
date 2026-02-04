Return-Path: <linux-btrfs+bounces-21367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJvHHsdrg2l+mgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21367-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 16:54:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FDCE9904
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 16:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72F56300615C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4D421A15;
	Wed,  4 Feb 2026 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekjH3KZq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2305421A00
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220334; cv=none; b=NYHtBPs4iqsKho3pqiJ8/lZOB/KupVjBQjeVXZOSseua6Zj1e6zS4UJMGwxtHMHwXeVOtZxqdNIQYH8Ic16LjTrXrcYHroAsekpJ4L16AI99TG7qrlc2rpNFoEOy0H95uVuZHLntBdxr8/5J8/n0dSrZwb3eJz/P6UKxhr7zRis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220334; c=relaxed/simple;
	bh=P309dstdmX5jHS0Ec2kts2CZwgN/GgEToKj42kmqjnM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gDM/f65X1p8eEIklJVDW0JvzONLmIbKghiPMaH8KsiaYCEwYKI2ixlT6WNSsAfTr0l4mYl6erxvGAnhcV90y0ccoMjJVyFwJZhCMK6ismRp9rHT5KWMPiOlB2n6AUzTFf+LIIxanxxXRIcKGMTnIdwL9V/x3GmQIuoRTiPLvsdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekjH3KZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186CEC4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770220333;
	bh=P309dstdmX5jHS0Ec2kts2CZwgN/GgEToKj42kmqjnM=;
	h=From:To:Subject:Date:From;
	b=ekjH3KZqrqsLB6MIaazebCPO0xWFA3ISwyrO+bYduV6E3V/ppRLW7DQEualfhIWBQ
	 vz55/wnkkUCPll+lmPMqLsRN18ybp+EWTr1AnjsjVPXbp7hMvj79ZLonsAV0l+0Gg/
	 grRtpvplHjQLFAPcBjCSJs6rKWrg54HLGzfSd6zU7uuK/xUvQqGHHKw679b3EV8s/A
	 de0y54DzfX2AjgJCImc3Yx9apNuv9kTylgzxWWlMoD1pfr5gdhOsJ5fMKBRKrC/O9o
	 bVViwIx92oPkizatTiOR7f1yN4nNxx37M6etH5JRt9fq/RHbtZiYyPh3U//UFqOCnY
	 1hBelZYYekpyQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs: minor tweaks and cleanups to the super block writing path
Date: Wed,  4 Feb 2026 15:51:57 +0000
Message-ID: <cover.1770212626.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21367-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24FDCE9904
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Details in the change logs.

Filipe Manana (7):
  btrfs: change unaligned root messages to error level in btrfs_validate_super()
  btrfs: mark all error and warning checks as unlikely in btrfs_validate_super()
  btrfs: pass transaction handle to write_all_supers()
  btrfs: abort transaction on error in write_all_supers()
  btrfs: tag error branches as unlikely during super block writes
  btrfs: remove max_mirrors argument from write_all_supers()
  btrfs: set written super flag once in write_all_supers()

 fs/btrfs/disk-io.c     | 167 +++++++++++++++++++----------------------
 fs/btrfs/disk-io.h     |   2 +-
 fs/btrfs/transaction.c |   2 +-
 fs/btrfs/tree-log.c    |   2 +-
 4 files changed, 82 insertions(+), 91 deletions(-)

-- 
2.47.2


