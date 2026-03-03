Return-Path: <linux-btrfs+bounces-22170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGIPDXeZpmltRgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22170-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 09:19:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6191EAAF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 09:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3E4F3058B8F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33C63822B4;
	Tue,  3 Mar 2026 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XgKYuRD5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XgKYuRD5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CC6385527
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525744; cv=none; b=YnI+IZlGul30h2NQQjnT/C6Psxczo/gE4vO3/XB434cBlqyFbk8PSnV1p+FuhRDt5aVRDUlb/PcsqUOQP3fV6jd3EfRpDpY0f2vHPg6jiw7jpCKeg2ZP+7wJuUY+E9O9Rv8+LwRP6vowquyTdJDsER4XJJIAmMV3bSZF+lJ+P5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525744; c=relaxed/simple;
	bh=X6VpWpAjMZwjR+CwZ09/D5tuTMpyQ0p9ijJiUDa8kjw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nOMEllbHWg9SHgGS5pB0lGyXn05kvfbIZQTKLvKhAt9y8Xo336bcZ3Z9GKq9BT/Blg8qSJ+gmg0XgD+rPPITym9GPDkmwwr7Djk7szcoZn+gchL4zFVSNsunXck7vaRhpb6CWPaRHM7iDz+C5yqihXAiQzhx9dlxwvYoLQngdME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XgKYuRD5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XgKYuRD5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0528E5BDE8
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 08:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772525734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x1iFIFttd/iYWvyOk3kHA0ezAKTQtl2RZaXBLxhy4Uk=;
	b=XgKYuRD5RdYv5EbMTy9u4VcfnxlL121jJKb3XTz/5oSn4ny3n9mMUvkn4iv4LjXo0ALfDH
	5pfbtx63s/kDApnmLUnpjbfVegUSkIxUi8iLJY4n5tWWsQk1VoTBp7Q+tWiVAKsmpQA6H8
	9AqS8iG4aAAyLiSWHc9BtNXV03Q4zPA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772525734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x1iFIFttd/iYWvyOk3kHA0ezAKTQtl2RZaXBLxhy4Uk=;
	b=XgKYuRD5RdYv5EbMTy9u4VcfnxlL121jJKb3XTz/5oSn4ny3n9mMUvkn4iv4LjXo0ALfDH
	5pfbtx63s/kDApnmLUnpjbfVegUSkIxUi8iLJY4n5tWWsQk1VoTBp7Q+tWiVAKsmpQA6H8
	9AqS8iG4aAAyLiSWHc9BtNXV03Q4zPA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 363D03EA69
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 08:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pmMmOqSYpmmHeQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2026 08:15:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: trivial cleanups in end_bbio_data_write()
Date: Tue,  3 Mar 2026 18:45:08 +1030
Message-ID: <cover.1772525669.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
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
X-Rspamd-Queue-Id: 8C6191EAAF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22170-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Please check the changelog of each patch. All of them are pretty
trivial.

Qu Wenruo (2):
  btrfs: remove the alignment check in end_bbio_data_write()
  btrfs: move the mapping_set_error() out of the loop in
    end_bbio_data_write()

 fs/btrfs/extent_io.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

-- 
2.53.0


