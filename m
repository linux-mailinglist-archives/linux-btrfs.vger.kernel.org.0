Return-Path: <linux-btrfs+bounces-3944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136208993DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 05:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AF728B73B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 03:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5FF1C6A8;
	Fri,  5 Apr 2024 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bxsRlSUo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E2hHmTeX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04415E9B
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287657; cv=none; b=Hvs3XMKVC4yTo4FM/TMTD3tLFnSIMTNB1ClGdbE7hTPkJsU+i4GNDMqkbsq797wVRPYi4x9xG5Ub5YwizkadqJN5iPTJ6tKDvszOwIZ8BFZs1FnNMMFIJtUyPPvB+6YTJ3leM5kVLv5Vzpqq1aVGqcZUsDPkjvUw291ZfxluFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287657; c=relaxed/simple;
	bh=tdKuexFOcTwkoRDAWqhzjZwHdj1ZoN2ZSJPrJUYacjc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sVtmhBtIsWWrRv2FDFfkrC6PhMWEEK5lS3N+PKC1dywnMYVplgp8KAx0vTwt/qsVCYmG0ytERPfsgT0IereV6f4xWbz4lStRble+HOwdHSzDMEDHx0knMQmiXR7DMHrAFFlrx36uip46OHGmAJeQuWGMQ2HdZtFlidpGUH4OxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bxsRlSUo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=E2hHmTeX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B0BE1F461
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 03:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712287653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O9vxqqKj7iOZKuAASjc281ijRwt1Xp15Jk5QwiyH9dI=;
	b=bxsRlSUoTNMkey1Nzo0FeTPl354Qma2X9d6maGUDu1yvaWUUClTGSimlFnA3EFChCScvW9
	3p3BXFxxcORCmoyHSGLUvgJmX8zSY/Zr0qdOeIN8N5pFc14yNwD148xLAqsXSSmRMpXv1Y
	BLgeh+ODaIcX0+60b236en3SD4JH2BM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=E2hHmTeX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712287652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O9vxqqKj7iOZKuAASjc281ijRwt1Xp15Jk5QwiyH9dI=;
	b=E2hHmTeXL7ehixcL2R73P6jBiBLKeJFp9drUOGn9g5+z78Bwua2WGqPGcMaAIAisds8e/n
	Ge/4m4lKfoPhA6IgVogJTO6YdANIcAZUNjd26S9+fzfKc0rMaZJRY2L+ZnCSDxOHOj7k/a
	MEbAkymoxl5BGAqr6TLX5rfCsOy5ofM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A824413357
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 03:27:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6u7hFqNvD2a+aQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 03:27:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/3] btrfs: more explaination on extent_map members
Date: Fri,  5 Apr 2024 13:57:10 +1030
Message-ID: <cover.1712287421.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9B0BE1F461
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]

[REPO]
https://github.com/adam900710/linux.git/ em_cleanup

[CHANGELOG]
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

I do not have the confidence to handle the mess yet, but as the first
step, I would add comments for those members mostly according to
btrfs_extent_item_to_extent_map(), and hopefully we can improve the
situation in not-far-away future.

Qu Wenruo (3):
  btrfs: add extra comments on extent_map members
  btrfs: simplify the inline extent map creation
  btrfs: add extra sanity checks for create_io_em()

 fs/btrfs/extent_map.h | 52 ++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/file-item.c  | 20 ++++++++---------
 fs/btrfs/inode.c      | 40 ++++++++++++++++++++++++++++++++-
 3 files changed, 100 insertions(+), 12 deletions(-)

-- 
2.44.0


