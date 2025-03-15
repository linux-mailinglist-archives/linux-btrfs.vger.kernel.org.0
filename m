Return-Path: <linux-btrfs+bounces-12292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52998A6234D
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 01:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B6219C5CD1
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 00:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C519450;
	Sat, 15 Mar 2025 00:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Tb15+RaL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Tb15+RaL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A4D2F2F
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741999362; cv=none; b=lkR8rXVHMf5kZUsKtocMNwGzW40N5xDTDaRGD/P7+3YCtvXnzkxsEjYb2H17yBtd1BH/gthro3oLyk2IMd1JtHrRoXICxeswEdvMxQgCoCHMmGXgbGhjLJYZL5biOZuObQx1K3O1Lq5f0oJUrx0eyrAsyqJ1kfJXy5vxJRCnBKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741999362; c=relaxed/simple;
	bh=Jy/LvZN22btaB5KJKXllnuGfKFZkTWgcZFA3g4A+VS8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b3heeFr8lpemKzVBlSwetgXlkCu9dNdzF1tTV3/FQcTVR0rIUkF3guQZGih/I6aqFpS0bI6o/7b0iKLav/vfHL1efZ4XvDQxUNP+G+kcILaK8wZ1BCdrSLoVoROfUM2g4ddzqRQl9gd9xHg6zuo1dDC+1ockaHgLX3vmjqQj5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Tb15+RaL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Tb15+RaL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A80921174
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=we9vrAoMDYts1mgxKe0mKxMT14E2CLOkRuw3rsOvXow=;
	b=Tb15+RaL6Jqq7CBYHXKLvOPysDCmbY29/+vmg4zJyeFGePacdAIiJG5T8ABGL0ZKY8s9dx
	11ttEYeRmbDRL0mLpiCYLrHwMcEPSfTdXgZISwqDmJctiB0jA+k8o8NKifzG5OPLANl7rE
	ZaqmDyrHR4RglddjzAOxD9d1rRErOq8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Tb15+RaL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=we9vrAoMDYts1mgxKe0mKxMT14E2CLOkRuw3rsOvXow=;
	b=Tb15+RaL6Jqq7CBYHXKLvOPysDCmbY29/+vmg4zJyeFGePacdAIiJG5T8ABGL0ZKY8s9dx
	11ttEYeRmbDRL0mLpiCYLrHwMcEPSfTdXgZISwqDmJctiB0jA+k8o8NKifzG5OPLANl7rE
	ZaqmDyrHR4RglddjzAOxD9d1rRErOq8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8203E13797
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RvBCC/3M1GegXAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/7] btrfs: remove ASSERT()s for folio_order() and folio_test_large()
Date: Sat, 15 Mar 2025 11:12:11 +1030
Message-ID: <cover.1741999217.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8A80921174
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[CHANGELOG]
v2:
- Update the commit message for the first patch

There are quite some ASSERT()s checking folio_order() or
folio_test_large() on data folios.

They are the blockage for the incoming larger data folios.

This series will remove most of them, with the following exceptions
remaining:

- wait_dev_supers() and write_dev_supers()
  They are folios from block device cache, will not be affected by our
  larger data folios support.

- relocation_one_folio()
  It's about data relocation inode, and we can disable larger data folios
  for such special inode easily.

- btrfs_attach_subpage()
  The folio_test_large() is only for metadata, just change it to be a
  metadata specific check.

- defrage_prepare_one_folio()
  It rejects larger folios gracefully so no need to handle it yet.
  Although we still need some extra work to make defrag to properly
  support larger folios.

- btrfs_end_repair_bio()
  This will be covered by a dedicated series converting the bio layer to
  use folio interfaces other than bvec interfaces.
  Until then the ASSERT() will stay.

The first patch is just a small cleanup for send, exposed during the
removal of ASSERT()s.


Qu Wenruo (7):
  btrfs: send: remove the again label inside put_file_data()
  btrfs: send: prepare put_file_data() for larger data folios
  btrfs: prepare btrfs_page_mkwrite() for larger data folios
  btrfs: prepare prepare_one_folio() for larger data folios
  btrfs: prepare end_bbio_data_write() for larger data folios
  btrfs: subpage: prepare for larger data folios
  btrfs: zlib: prepare copy_data_into_buffer() for larger data folios

 fs/btrfs/extent_io.c |  3 ---
 fs/btrfs/file.c      |  6 +-----
 fs/btrfs/send.c      | 29 +++++++++++++----------------
 fs/btrfs/subpage.c   |  6 ++----
 fs/btrfs/zlib.c      |  2 --
 5 files changed, 16 insertions(+), 30 deletions(-)

-- 
2.48.1


