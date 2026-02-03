Return-Path: <linux-btrfs+bounces-21326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMBQEmo0gmlTQgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21326-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 18:46:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCACDD0A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 18:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCB90303E0FE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 17:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787B33659FF;
	Tue,  3 Feb 2026 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bOjOdLPd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bOjOdLPd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CC4324707
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140741; cv=none; b=nV28GPMFoWGLKGI0JgwgW52HytPlasudYOs1MUyz9KGma2ua2Acw5UMYvoYbEg+y4l0RUTgkEbCrys+7kL9h3h4Pzz/cydXGwy1iHnnHgFEj2/GvKygjem3ytBouxJbGKXSY5CvDAE2qf3hTmexykj4IffklzbUJMAUs3PV7EjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140741; c=relaxed/simple;
	bh=BmtOh4t8XNgRg071+WHJozvxbVn9vaNZ1NKE6ArEOjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=esDlETR7oEkfO+DjRX5zYbEitpkKRItPObjlGuYtt551MTu6XAzgcvW+wun3dTBx5dO/XPH8wBazmMlD+T/H6G+KsnkqPtuiZePxTumUpRoH1VNifQcKwqBwH4M1P/U0Gu0wclBzYoh9Wh+Pm5/H8xBHciOElNUuJe2Y79GH7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bOjOdLPd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bOjOdLPd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76C105BCC3;
	Tue,  3 Feb 2026 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770140737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2eeMrccm5hQAtP9oZTFQ+qTVpE7Nwc8/3NmPGHRw89Q=;
	b=bOjOdLPdvNPmBT4diemr2zQRHOAP2PkxK39T0TV5wd6glozGtaforQrwLpkxYe3lqWHGHM
	cFeIEHAomh/+lsqw3cUEgBE1lCm0QneIbbSS9JUugA3UviaP86IsYlvr6B9OjUZfldXPrk
	S8Asd95cxjmT6e3YRmpCv6UmZvdUAfg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770140737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2eeMrccm5hQAtP9oZTFQ+qTVpE7Nwc8/3NmPGHRw89Q=;
	b=bOjOdLPdvNPmBT4diemr2zQRHOAP2PkxK39T0TV5wd6glozGtaforQrwLpkxYe3lqWHGHM
	cFeIEHAomh/+lsqw3cUEgBE1lCm0QneIbbSS9JUugA3UviaP86IsYlvr6B9OjUZfldXPrk
	S8Asd95cxjmT6e3YRmpCv6UmZvdUAfg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 652803EA62;
	Tue,  3 Feb 2026 17:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 19SoGEE0gmmgXwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 03 Feb 2026 17:45:37 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 6.19-rc8+
Date: Tue,  3 Feb 2026 18:45:22 +0100
Message-ID: <cover.1770137071.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21326-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: DCCACDD0A4
X-Rspamd-Action: no action

Hi,

please pull the following regression fix for a memory leak when raid56
is used.  Thanks.

----------------------------------------------------------------
The following changes since commit 0d0f1314e8f86f5205f71f9e31e272a1d008e40b:

  btrfs: zlib: fix the folio leak on S390 hardware acceleration (2026-01-21 19:35:41 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc8-tag

for you to fetch changes up to 29fb415a6a72c9207d118dd0a7a37184a14a3680:

  btrfs: raid56: fix memory leak of btrfs_raid_bio::stripe_uptodate_bitmap (2026-02-03 06:37:29 +0100)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: raid56: fix memory leak of btrfs_raid_bio::stripe_uptodate_bitmap

 fs/btrfs/raid56.c | 1 +
 1 file changed, 1 insertion(+)

