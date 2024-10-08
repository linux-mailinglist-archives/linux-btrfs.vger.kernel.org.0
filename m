Return-Path: <linux-btrfs+bounces-8669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1401995B60
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 01:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6431C21F7C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 23:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B75F217332;
	Tue,  8 Oct 2024 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rH3fBroA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rH3fBroA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C8215F47
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428853; cv=none; b=atwDBNnges7hG2+2X2wr0PukOpSJYAdTCQ7TQ1xgTfACSN7kbmn5/MM1AOMEVElZKuIcW+Bp7eD225SoUHBuvjAqfEH/JlePiy/yfG4gGUgDgk/A+cn6HbhYw6cpAz183VTm0Msvz+IlqAkq1Ud8FX0N4mHjQ0VZW4SUqdji3Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428853; c=relaxed/simple;
	bh=JaKPV4px5oy40aItpJ2Gnzr2yBDiA00+6eb+GBORBwU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YSaJe9tzS8+n3gA6nU3vEH2HvmxKXnmt5VaP/QAZj/hrxjLtLlTcchzIv2Hku9WieFOFo4ySzQ31DekDmWlujeYFZxcKg2krVMAlkOWyv+9T/NLGDED1MzxZ89vJjkiKinx+3gavINKSO/7mo2MUpdWaFFqeFfgoLFz9dl10ufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rH3fBroA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rH3fBroA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8EE7921D2A
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 23:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728428843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VkjEJaKG0noKxsaXy1hlxRKMjvKnnZBapURlCi4Ws3o=;
	b=rH3fBroA5J+GCjdJl81ctYjrB/M6WjrC/J8ggSo3axX27MfkeJjZ9OK8LO0MMZc/v6VHEb
	EHcxVihbZWslVM40UixA3yF/GRpxKCFB0Q9OBe41DkPzjEuzE08LnsAdnRW00EcDfZLLHO
	MgoaSKzvtrcTMarNdgJlsNOldYqjIf0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rH3fBroA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728428843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VkjEJaKG0noKxsaXy1hlxRKMjvKnnZBapURlCi4Ws3o=;
	b=rH3fBroA5J+GCjdJl81ctYjrB/M6WjrC/J8ggSo3axX27MfkeJjZ9OK8LO0MMZc/v6VHEb
	EHcxVihbZWslVM40UixA3yF/GRpxKCFB0Q9OBe41DkPzjEuzE08LnsAdnRW00EcDfZLLHO
	MgoaSKzvtrcTMarNdgJlsNOldYqjIf0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEFEB137CF
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 23:07:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xAMoHyq7BWcVMwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 08 Oct 2024 23:07:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: fixes related to btrfs_folio_start_writer_lock()
Date: Wed,  9 Oct 2024 09:37:02 +1030
Message-ID: <cover.1728428503.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8EE7921D2A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[Changelog]
v2:
- Remove the unused btrfs_folio_start_writer_lock()

v3:
- Split out the btrfs_folio_start_writer_lock() removal
  As the initial fix needs to go backported to 5.15+, keeps the
  modification as small as possible

The function lacks the proper folio->mapping check, thus we can even get
a folio not belonging to btrfs, and cause unexpeceted folio->private
updates.

Fix the only caller of btrfs_folio_start_writer_lock() inside
lock_delalloc_folios() and other sector size < page size handling of
lock_delalloc_folios().

Then finally remove btrfs_folio_start_writer_lock()

Qu Wenruo (2):
  btrfs: fix the delalloc range locking if sector size < page size
  btrfs: remove unused btrfs_folio_start_writer_lock()

 fs/btrfs/extent_io.c | 17 ++++++++--------
 fs/btrfs/subpage.c   | 47 --------------------------------------------
 fs/btrfs/subpage.h   |  2 --
 3 files changed, 9 insertions(+), 57 deletions(-)

-- 
2.46.2


