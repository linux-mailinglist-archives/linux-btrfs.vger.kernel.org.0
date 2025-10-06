Return-Path: <linux-btrfs+bounces-17453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E2EBBD76F
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 11:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBF2D4E9F2D
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3151F462D;
	Mon,  6 Oct 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KgJc39OK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KgJc39OK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B81F1527
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743529; cv=none; b=JfdyYBiAyi33YflFRgzluPKSyErovex/M3rn2NjyyHXEiSkfatZaH1e+8N/7Q24WNv+lzG1ajDqJIK4Y565Dw0BgGgvVSTt9EHa6AZTpQUOFZFNpQC4Oux+0xCtRkDdavnG52Ii9NhZeoI3HcQVflW9LB3o3GJ2bhsqb1LnBGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743529; c=relaxed/simple;
	bh=HlAJJ7TCRCEgEy+33PQKamIFpKbguJRowRny1VhlUE8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZSzahJ9Dv16Lm4K4y5upYaYyLtagnN814S2VznnvSfNhdqBFqQqa7bxcBE5kdzzoAd50LfjhIK9TmAX8e9CcLieBTflf0t+OV9gzlX9mQtwi1p/qemnLFQrrT9Qp/1AzD8QOLf/kPUFRglh1CudlQCou6i7RW1O70sSd9fIznXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KgJc39OK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KgJc39OK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45DBA3373A
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 09:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759743524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=exsyctA6mlPeJPFxGBkF0dRaIk9pnSvnEt9cQZ7aAAI=;
	b=KgJc39OKHoVt3n8q0d89kLX1jX3tXvMoc9q3P7CoFf08qvDpaa7YRum2w6DLxd4CTF/2SQ
	DEFEANUqB7jNXRqmS4z7QK/8lUYBIaC8FsPbdGpWT60oKjojRKG03umWpNuE8U5AElKkJV
	Eh7WpqXeI3g7/OCTyAL2VNLq60ly7i0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KgJc39OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759743524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=exsyctA6mlPeJPFxGBkF0dRaIk9pnSvnEt9cQZ7aAAI=;
	b=KgJc39OKHoVt3n8q0d89kLX1jX3tXvMoc9q3P7CoFf08qvDpaa7YRum2w6DLxd4CTF/2SQ
	DEFEANUqB7jNXRqmS4z7QK/8lUYBIaC8FsPbdGpWT60oKjojRKG03umWpNuE8U5AElKkJV
	Eh7WpqXeI3g7/OCTyAL2VNLq60ly7i0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A4E313700
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 09:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E32tDiOO42iUQgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 06 Oct 2025 09:38:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: check: add repair functionality for
Date: Mon,  6 Oct 2025 20:08:23 +1030
Message-ID: <cover.1759743405.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 45DBA3373A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Currently any orphan device extents will cause kernels to reject the
mount.

But on the other hand, btrfs check is unable to repair such problem, so
end users may fall into a situation where they are unable to mount the fs.

Add the repair functionality to btrfs check, for both original lowmem
modes, and add a new test case for it.

Qu Wenruo (2):
  btrfs-progs: check: add repair functionality for orphan dev extents
  btrfs-progs: fsck-tests: a new test case with orphan dev extent

 check/main.c                                  |   6 +-
 check/mode-lowmem.c                           |   7 +-
 check/repair.c                                |  78 ++++++++++++++++++
 check/repair.h                                |   1 +
 .../068-orphan-dev-extent/.lowmem_repairable  |   0
 .../068-orphan-dev-extent/default.img.xz      | Bin 0 -> 1784 bytes
 6 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100644 tests/fsck-tests/068-orphan-dev-extent/.lowmem_repairable
 create mode 100644 tests/fsck-tests/068-orphan-dev-extent/default.img.xz

--
2.50.1


