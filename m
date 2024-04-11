Return-Path: <linux-btrfs+bounces-4166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1367D8A21E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 00:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C9BB22EAF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 22:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0854654F;
	Thu, 11 Apr 2024 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R1WqClKJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R1WqClKJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1E1862E
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875687; cv=none; b=LZM8qvwVr9HEvJ/uMV0E+3//niARPoh9s7JSyR3Z5mUL1kHy4i7aBWBfq95xCmL1SHfJ4s37n+l8YOsscdd2GET7NPXkeDqHtNxoT+Qe8n0WkBqq2orJRDOen3kTss6bThvblWiO7Bs8cCGfXZwQsH9ZvWSUjVpMecWyLX4Bstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875687; c=relaxed/simple;
	bh=lzGnnUmDvwtHlsDIMaSmAgqcwlMIQ03USGGn5NOFTPk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FLB7WRjSO3LP61OmfT6liSlsGhoHIz34KkDT22WcOvn7M7FvHLhBQjPOIQdjLmcmraalb5LMDHqMTBpGfsngmqC1jjE38wLBUZmD0gZBlDUdhnP7mOfKLGtejbsTOU77G+X8SzRMoW2CXFLblcsQ3BEs/NvPudv7Ktbg6OMU+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R1WqClKJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R1WqClKJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D32122BB7
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 22:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712875683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5mf9mkEKDdZkFAkh7nj36DIiqLz/fSLc9dVaPPBxjU0=;
	b=R1WqClKJ2IPJr/LSDFiEJqTcviCE9Dt+kANEh4wZrB3RvTNItzCOx6XNhNuNERcUJPMe9T
	JGYq4aUhjj+UjVxtAGsRBDXXYw4ttwIU9diLP4MrmTEYEKRovhry8Mu/Msi6eg3iyMpN3z
	avT2gkUDvzHugI9vpHYge38JSb7sdfg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712875683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5mf9mkEKDdZkFAkh7nj36DIiqLz/fSLc9dVaPPBxjU0=;
	b=R1WqClKJ2IPJr/LSDFiEJqTcviCE9Dt+kANEh4wZrB3RvTNItzCOx6XNhNuNERcUJPMe9T
	JGYq4aUhjj+UjVxtAGsRBDXXYw4ttwIU9diLP4MrmTEYEKRovhry8Mu/Msi6eg3iyMpN3z
	avT2gkUDvzHugI9vpHYge38JSb7sdfg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37F651368B
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 22:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TrJbOaFoGGbbXAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 22:48:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/3] btrfs: more explaination on extent_map members
Date: Fri, 12 Apr 2024 08:17:41 +0930
Message-ID: <cover.1712875458.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

[REPO]
https://github.com/adam900710/linux.git/ em_cleanup

The first 3 patches only. As later patches are the huge rename part.

[CHANGELOG]
v4:
- Add extra comments for the extent map merging
  Since extent maps can be merged, the members are only matching
  on-disk file extent items before merging.
  This also means users of extent_map should not rely on it for
  a reliable file extent item member.
  (That's also why we use ordered_extent not extent_maps, to update
   file extent items)

v3:
- Rebased to latest for-next branch
- Further comments polishment
- Coding style update to follow the guideline

v2:
- Add Filipe's cleanup on mod_start/mod_len
  These two members are no longer utilized, saving me quite some time on
  digging into their usage.

- Update the comments of the extent_map structure
  To make them more readable and less confusing.

- Further cleanup for inline extent_map reading

- A new patch to do extra sanity checks for create_io_em()
  Firstly pure NOCOW writes should not call create_io_em(), secondly
  with the new knowledge of extent_map, it's easier to do extra sanity
  checks for the already pretty long parameter list.

Btrfs uses extent_map to represent a in-memory file extent.

There are severam members that are 1:1 mappe in on-disk file extent
items and extent maps:

- extent_map::start	==	key.offset
- extent_map::len	==	file_extent_num_bytes
- extent_map::ram_bytes	==	file_extent_ram_bytes

But that's all, the remaining are pretty different:

- Use block_start to indicate holes/inline extents
  Meanwhile btrfs on-disk file extent items go with a dedicated type for
  inline extents, and disk_bytenr 0 for holes.

- Weird block_start/orig_block_len/orig_start
  In theory we can directly go with the same file_extent_disk_bytenr,
  file_extent_disk_num_bytes and file_extent_offset to calculate the
  remaining members (block_start/orig_start/orig_block_len/block_len).

  But for whatever reason, we didn't go that path and have a hell of
  weird and inconsistent calculation for them.

Qu Wenruo (3):
  btrfs: add extra comments on extent_map members
  btrfs: simplify the inline extent map creation
  btrfs: add extra sanity checks for create_io_em()

 fs/btrfs/extent_map.h | 58 ++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/file-item.c  | 20 +++++++--------
 fs/btrfs/inode.c      | 40 ++++++++++++++++++++++++++++-
 3 files changed, 106 insertions(+), 12 deletions(-)

-- 
2.44.0


