Return-Path: <linux-btrfs+bounces-21319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKPyBxMXgmmZPAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21319-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 16:41:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E42DB627
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 16:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E07A308B43B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CE23B95F5;
	Tue,  3 Feb 2026 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzAPqyY5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D792DB7AE
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133166; cv=none; b=g+EYFEEUjX/AUucDjvIGhB/FA9kw4lzDjAyUFf4mv1DUpts9MjFJcFJzKZBa4O+MMdTLReSPlS29BZumYZ6isbrVShQ9M3Ldmx/yYSiGzcIPLUA0kW03C1BXHVVHGBPaeKq4YBeKteLW2j+vZZpzRoaYEPvkKlmr/DLvy88dwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133166; c=relaxed/simple;
	bh=RCfW27BeLZUsNtnllnwPSQaGZb+eFQOdZizVd9z37UU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rz3MxTAY0hQpBCzCIr+eDMqjroi6pY+3ZRI5n+q4P0H4wQegNOv3DCpwaT+8qQIbBHDvXC+skh08d2mJDAiwJWTvDOAQXZ4V3DyhEhpbuzKollegihuiYvAxbt8Q/wZeSmy5Z4N7CwB5YlwwmlZiyo8LhxEVMKK0bnAMJfkgwBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzAPqyY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D9CC116D0
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 15:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770133165;
	bh=RCfW27BeLZUsNtnllnwPSQaGZb+eFQOdZizVd9z37UU=;
	h=From:To:Subject:Date:From;
	b=XzAPqyY5PcQhZo8rKLy326bnMTKuaiUmLry8wJPf0042jbdYkbPYygCNutx/IYkys
	 T/7LRw4fpywfUtLoeV5ybqa3iesbZTLvxt1rCkaTLk/eH7SvTJRyG/lEeILIbHCgyA
	 j4U12p0+hy3tGnH/LH5D/ilj1VS6mMTXA/YSf1xOF+KkHXM+B5nhhMxrefUJ92fsAA
	 nwxoLWilvCSdWr1A4QDSIvbnvtzpFvqymC4q2C4pvHZUbwVD9l85oOEA1IEbbe3RpR
	 bH8dmsv0bDoAx7kFPXV1WcCJihd5RXpby/8F3p3ckkkb+PsaHMsxMdMUF6zWyNhiZY
	 ZtkTKgWYV6K8g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: cleanups to the sys chunk array checks
Date: Tue,  3 Feb 2026 15:39:19 +0000
Message-ID: <cover.1770133086.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21319-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4E42DB627
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Details in the changelogs.

Filipe Manana (2):
  btrfs: remove duplicate system chunk array max size overflow check
  btrfs: move min sys chunk array size check to validate_sys_chunk_array()

 fs/btrfs/disk-io.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

-- 
2.47.2


