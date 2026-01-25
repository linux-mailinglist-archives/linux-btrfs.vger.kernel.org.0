Return-Path: <linux-btrfs+bounces-21000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJTTF4efdmmOTAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21000-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 23:56:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA3D82F2E
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 23:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 488983035C56
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 22:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A132F31328C;
	Sun, 25 Jan 2026 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L4Ixu66j";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L4Ixu66j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703AE31079B
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381352; cv=none; b=Z6xMVea/m/HiVAajct7AfmzR5wWvIrqkHhGYn5Hjk3mH3xwRDlnp7YahNtI+LF6qA1j1Wm8/NSlfCheK3b20ABfVfP40yA58KyIOVDAQSoMQEx9r1Xj8Lf+78jiT2aNgrJsoVkmpQIVNmsZ14BdRDyH0XXk88DuHrink8TvwRXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381352; c=relaxed/simple;
	bh=RJO/MvwbYDEQp0k95rEjr9lDrEPQqukhw1O/1fvjT4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRU+0LX1TLFv46N5e4fkAdHb5iuGZOy7+WeIht63L7ntoAv8kSTlrool/LuI5gTdDhQj47+DYU/VHbYDG2AUJvXdHfjpB3QIeOjvM+GJodLCzmjhyF7lFgxZfDTyn4wcvDLfzYZbWUF+PCCGCaFG5H6wfwsgW0IcaxiyAnATbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L4Ixu66j; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L4Ixu66j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8972D5BCCC;
	Sun, 25 Jan 2026 22:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769381348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yh5iTP+2dJxVBlOnph6ReIH+YRVU5WTjTFDh56g+p0E=;
	b=L4Ixu66j4Vp5GTLyMgv7WPl+a/k0gY2NEjpNgawS86kB/urSx6FvEnVTrixDvxU6Thn//m
	K05lazWqki4ABp8JSKqB6s1jiHOchDJD8g6+mvz+xDzSz6yxVDH0vIDfuZLeytzIdgIF/e
	xHvNhtlhsRVknIWDqgJTocfVjycxZOU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769381348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yh5iTP+2dJxVBlOnph6ReIH+YRVU5WTjTFDh56g+p0E=;
	b=L4Ixu66j4Vp5GTLyMgv7WPl+a/k0gY2NEjpNgawS86kB/urSx6FvEnVTrixDvxU6Thn//m
	K05lazWqki4ABp8JSKqB6s1jiHOchDJD8g6+mvz+xDzSz6yxVDH0vIDfuZLeytzIdgIF/e
	xHvNhtlhsRVknIWDqgJTocfVjycxZOU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 342F8139E9;
	Sun, 25 Jan 2026 22:49:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZNohNeKddmnSTAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 25 Jan 2026 22:49:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: linux-block@vger.kernel.org
Subject: [PATCH 0/9] btrfs: used compressed_bio structure for writes
Date: Mon, 26 Jan 2026 09:18:39 +1030
Message-ID: <cover.1769381237.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21000-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEA3D82F2E
X-Rspamd-Action: no action

Cc: linux-block@vger.kernel.org

Cc bio people first, there are some uncertain/tricky usage of the bio
structure:

- Is it a good idea to queue unaligned range into a bio?

  Bio means Block IO, but bio_add_*() never requires alignment (to 512
  bytes), so not sure if this is expected or not.
  Only the bi_sector is sector related.

  Thus this patch is queuing a lot of unaligned range into a bio,
  especially for LZO cases.
  (ZLIB and ZSTD are properly filling all folios except the last one)

  But the end result should still be fine, most ranges (except the last
  block) will be properly merged and fill a full folio.
  Most unaligned parts will only be temporary before merge.

  Btrfs internally has extra alignment checks thus an unaligned 
  bio will never be submitted.

- Will there be a public helper to "round up" a bio

  Since we have unaligned bios, we will need to round them up before
  submission.
  For now I'm using internal helpers to do that, but a public helper
  will be appreciated.

The remaining part are all btrfs specific.

I was never a huge fan of the current btrfs_compress_folios() interface:

- Complex and duplicated parameter list

  * A folio array to hold all folios
    Which means extra error handling.

  * A @nr_folios pointer
    That pointer is both input and output, representing the number of max
    folios, but also the number of compressed folios.

    The number of input folios is not really necessary, it's always no
    larger than DIV_ROUND_UP(len, PAGE_SIZE) in the first place.

  * A @total_in pointer
    Again an pointer as both input and output, representing the filemap
    range length, and how many bytes are compressed in this run.

    However if we failed to compress the full range, all supported
    algorithms will return an error, thus fallback to uncompressed path.

    Thus there is no need to use it as an output pointer.

  * A @total_compressed point
    Again an pointer as both input and output, representing the max
    number of compressed size, and the final compressed size.

    However we do not need it as an input at all, we always error out
    if the compressed size is larger than the original size.

- Extra error cleanup handling

  We need to cleanup the compressed_folios[] array during error
  handling.

Replace the old btrfs_compress_folios() interface with
btrfs_compress_bio(), which has the following benefits:

- Simplified parameter list

  * inode
  * start
  * len
  * compress_type
  * compress_level 
  * write_flags

    No parameter is sharing input and output members, and all are very
    straightforward (except the last write_flags, which is just an extra
    bio flag).

- Directly return a compressed_bio structure

  With minor modifications, that pointer can be passed to
  btrfs_submit_bio().

  The caller still needs to do proper round up and fill the proper
  disk_bytenr/num_bytes before submission.

  And for error handling, simply call cleanup_compressed_bio() then
  everything is cleaned up properly (at least I hope so).

- No more extra folios array passing and error handling


Qu Wenruo (9):
  btrfs: introduce lzo_compress_bio() helper
  btrfs: introduce zstd_compress_bio() helper
  btrfs: introduce zlib_compress_bio() helper
  btrfs: introduce btrfs_compress_bio() helper
  btrfs: switch to btrfs_compress_bio() interface for compressed writes
  btrfs: remove the old btrfs_compress_folios() infrastructures
  btrfs: get rid of compressed_folios[] usage for compressed read
  btrfs: get rid of compressed_folios[] usage for encoded writes
  btrfs: get rid of compressed_bio::compressed_folios[]

 fs/btrfs/compression.c | 205 +++++++++++++++++--------------------
 fs/btrfs/compression.h |  40 ++++----
 fs/btrfs/inode.c       | 217 ++++++++++++++++++++-------------------
 fs/btrfs/lzo.c         | 223 +++++++++++++++++++++++++++--------------
 fs/btrfs/zlib.c        |  64 ++++++------
 fs/btrfs/zstd.c        |  69 ++++++-------
 6 files changed, 434 insertions(+), 384 deletions(-)

-- 
2.52.0


