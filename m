Return-Path: <linux-btrfs+bounces-21348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBvIH/+0gmnwYgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21348-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 03:54:55 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D26DE109E
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 03:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6D3A307EED3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 02:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D82D9484;
	Wed,  4 Feb 2026 02:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nThRUV9W";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nThRUV9W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FEC2BEC5F
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173674; cv=none; b=oavMk1oU0NKqV3L91eIztQGM2kKC01fAh6zBZq8coSeGg9jG3q+DycG5nS7J29Uq4flkiSJeiinfcWrEI5/3Z5JLOYBL6QxWEK9ph1i3ayGLBMainyc62usK4/N3PvqwRtgo7JH2iLNoQQBzQLqlTpT7JH7LGPiqNtYGo33sdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173674; c=relaxed/simple;
	bh=lPD6mcABl8CryJ9TOBVnHVBMqY+1p32/EFCOcJazWV4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c5Kie+WxPtgt6QFdM1YZg13gK3zf93CkniwUU6mrDqEGzct5kN0A7ZU6WQZWcdhaHOhXRqrFd2M3/4hdwhapKrQp+47HyeTw78Tiv51VnUnXw3+eQzs9M/qs/a8h8WqaNNNmk+z1ssKf+5YN0SjVNDKjWbrcgdG0qcp6GlHzgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nThRUV9W; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nThRUV9W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B65963E6D1
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 02:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770173670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H+ij5307wPFqL6P4Rirv6Iw6YaemyInuLuGE8oPFKXA=;
	b=nThRUV9WYdLbPpO6ChMXXh/uJ+cqyiWDMAfJDLXmladLIdt1dsw/iRhqKQsF/W02cXvlHO
	RzTFIHQFcCzb1hfEgqOCpXCumyYQIaq09E1yrRTSCWwLJ1ViqqcpgVtSnP23zQhHBPncrw
	FzAdotvSDN1MrEbWwyohNv1xn6b/9FI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nThRUV9W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770173670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H+ij5307wPFqL6P4Rirv6Iw6YaemyInuLuGE8oPFKXA=;
	b=nThRUV9WYdLbPpO6ChMXXh/uJ+cqyiWDMAfJDLXmladLIdt1dsw/iRhqKQsF/W02cXvlHO
	RzTFIHQFcCzb1hfEgqOCpXCumyYQIaq09E1yrRTSCWwLJ1ViqqcpgVtSnP23zQhHBPncrw
	FzAdotvSDN1MrEbWwyohNv1xn6b/9FI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE32C3EA63
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 02:54:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id csSQJuW0gmknHAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 04 Feb 2026 02:54:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: unbalanced disks aware per-profile available space estimation
Date: Wed,  4 Feb 2026 13:24:05 +1030
Message-ID: <cover.1770173615.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21348-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D26DE109E
X-Rspamd-Action: no action

[CHANGELOG]
v2:
- Various grammar fixes

- Fix a u64 division compiling error on ppc64
  Which requires the dedicated div_u64() helper.

- Ignore unallocated space that's too small
  If the unallocated space is not enough to even cover a single stripe
  (64K), don't utilize it.
  This makes the behavior more aligned to the chunk allocator, and
  prevent over-estimation.

- Use U64_MAX to mark the per-profile estimation as unavailable
  This reduce the memory usage by one unsigned long.

- Update the commit message of the 2nd patch
  To include the overhead (runtime of btrfs_update_per_profile_avail())
  in the commit message.

- Minor comment cleanup on the term "balloon"
  The old term "balloon" is no longer utilized and there is a typo.
  ("ballon" -> "balloon").

- Update the estimation examples in the first patch
  As we allows 2 disks raid5 and 3 disks raid6.

v1:
- Revive from the v5.9 era fix

- Make btrfs_update_per_profile_avail() to not return error
  Instead just mark all profiles as unavailable, and
  btrfs_get_per_profile_avail() will return false.

  The caller will need to fallback to the existing factor based
  estimation.

  This greatly simplified the error handling, which is a pain point in
  the original series.

- Remove a lot of refactor/cleanup
  As that's already done in upstream.

- Only make calc_available_free_space() to use the new infrastructure
  That's the main goal, fix can_over_commit().
  Further enhancement can be done later.

There is a long known bug that if metadata is using RAID1 on two
unbalanced disks, btrfs have a very high chance to hit -ENOSPC during
critical paths and flips RO.

The bug dates back to v5.9 (where my last updates ends) and the most
recent bug report is from Christoph.

The idea to fix it is always here, by providing a chunk-allocator-like
available space estimation.
It doesn't need to be as heavy as chunk allocator, but at least it
should not over-estimate.

The demon is always in the details, the previous v5.9 era series
requires a lot of changes in error handling, because the
btrfs_update_per_profile_avail() can fail at critical paths in chunk
allocation/removal and device grow/shrink/add/removal.

But this time that function will no longer fail, but just mark
per-profile available estimation as unreliable, and let the caller to
fallback to the old factor based solution.

In the real world it should not be a big deal, as the only error is
-ENOMEM, but this greatly simplifies the error handling.

Qu Wenruo (3):
  btrfs: introduce the device layout aware per-profile available space
  btrfs: update per-profile available estimation
  btrfs: use per-profile available space in calc_available_free_space()

 fs/btrfs/space-info.c |  27 ++++---
 fs/btrfs/volumes.c    | 183 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h    |  34 ++++++++
 3 files changed, 231 insertions(+), 13 deletions(-)

-- 
2.52.0


