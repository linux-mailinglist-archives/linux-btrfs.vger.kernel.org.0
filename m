Return-Path: <linux-btrfs+bounces-4322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7581F8A7B99
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 06:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E61A1F22D8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 04:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB174084D;
	Wed, 17 Apr 2024 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TZVTSrYP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TZVTSrYP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7D8347C2
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713329706; cv=none; b=ThUq0xg/qY1VFMtAS/yvSW4TZaOyhdBcYbBN7dy10RWCQc3/fm/2byULVoQRUspldCpEdjNO0jrGaxzxD3/uV4FCYWuSOZgexVnFQKidk9XE8slScOQdJhByTZpScBaXzd7/GQkySyercIZ/yR038CVL660WKDiR1XqlDVqBPEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713329706; c=relaxed/simple;
	bh=djZpQHeeEzbAp2bTSKsIccVAj/0q1Gq4b5Lwjo28oU8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HM9lxFVJEPMQ30QGJdw/J1q8ZfllemTTgObii/RAU6cf4+4i6y0YLkJfXE34rPnro/s/uMeC9P5gbSeQUfKe3pSEZCtuLhSiNb7F0b+i3sWwaQl4FojgwhHY0mDIlUJmq9geu8+ODJ9/hnmWY91cKIQDYdvkJsNigkCoPqNPj9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TZVTSrYP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TZVTSrYP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8592F202D6
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 04:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713329702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/vFD2UBW80VXnG+dsFrbWzTMlCbDYoR+PDwmH74mRV0=;
	b=TZVTSrYPOEMSUFDSZkPy3P+LbJwvEs1Ti+neIpEKlihAzfiJPkyPzk0a/yVOZPgEXP0XdF
	qP2HdvzSFnL0zw6pUL/re3qafT9COZy6auS7y+xgdp6ZWepLNJs7bowg59JZJ92ZFDvTW3
	M2+2Sfnf8gM4mQf8ydhLQ1XZxd3RPsI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713329702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/vFD2UBW80VXnG+dsFrbWzTMlCbDYoR+PDwmH74mRV0=;
	b=TZVTSrYPOEMSUFDSZkPy3P+LbJwvEs1Ti+neIpEKlihAzfiJPkyPzk0a/yVOZPgEXP0XdF
	qP2HdvzSFnL0zw6pUL/re3qafT9COZy6auS7y+xgdp6ZWepLNJs7bowg59JZJ92ZFDvTW3
	M2+2Sfnf8gM4mQf8ydhLQ1XZxd3RPsI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBD611384C
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 04:55:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dQocHCVWH2YkeQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 04:55:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: fix btrfs_file_extent_item::ram_bytes of btrfs_split_ordered_extent()
Date: Wed, 17 Apr 2024 14:24:37 +0930
Message-ID: <cover.1713329516.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]

[CHANGELOG]
v2:
- Update the comment on file extent item tree-checker 
  To be less confusing for future readers.

- Remove one fixes tag of the first patch
  The bug goes back to the introduction of zoned ordered extent
  splitting, thus that oldest commit should be the cause.

During my extent_map members rework, I added a sanity check to make sure
regular non-compressed extent_map would have its disk_num_bytes to match
ram_bytes.

But that extent_map sanity check always fail as we have on-disk file
extent items which has its ram_bytes much larger than the corresponding
disk_num_bytes, even if it's not compressed.

It turns out that, the ram_bytes > disk_num_bytes is caused by
btrfs_split_ordered_extent(), where it doesn't properly update
ram_bytes, resulting it larger than disk_num_bytes.

Thankfully everything is fine, as our code doesn't really bother
ram_bytes for non-compressed regular file extents, so no real damage.

Still I'd like to catch such problem in the future, so add another
tree-checker patch for this case.

And since the invalid ram_bytes is already in the wild for a while, we
do not want to bother the end users to fix their fs for nothing.
So the check is only behind DEBUG builds.

Furthermore, the tree-checker is only to make sure @ram_bytes <
@disk_num_bytes for non-compressed file extents.
As we still have other locations to make @ram_bytes < @disk_num_bytes.

And for btrfs-progs, I'm going to add extra check and repair support
soon.

Qu Wenruo (2):
  btrfs: set correct ram_bytes when splitting ordered extent
  btrfs: tree-checker: add one extra file extent item ram_bytes check

 fs/btrfs/ordered-data.c |  1 +
 fs/btrfs/tree-checker.c | 35 +++++++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.44.0


