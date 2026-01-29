Return-Path: <linux-btrfs+bounces-21208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPVuOeDSemlX+wEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21208-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:24:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DCBAB6A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 04:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4BAA3020EE4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jan 2026 03:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B3534EF0D;
	Thu, 29 Jan 2026 03:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s7OCZ39n";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s7OCZ39n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB32BE029
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769657050; cv=none; b=e89F6cIRwCmMsflM+iz9eJal4gxFQ/b2+oIvfPP6TfWp3FdLofAOb/8dtzeiOyY4lHsjSvT6INoKjeNRffV+RM2hLbSDg03Ay5qgJmNBiV8nEaD8Q32WIX0qqLpC+TLxOwJ5KXMOPqumIFRmO7X6/StRUP3F6ABDCvtzLmPw+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769657050; c=relaxed/simple;
	bh=ZTIg7CA7k3wdQJiUQKBN0dNpHM04UeGexXf+Ev0eQg4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NJpl7CXdDGwh4Mc5EMiONmCuzdYyi5aLfUVPi0xa5jzKx7lclUH93+tfv4msyAArEJgdfNPMAP96v3oxy9eWfWyntgFOZulfHTKGjxN/Pxr7SWg0qYMOIcxdtgGjlSusfwXMIRQEcfu43LuBCpuozXql2e0KV6V1D4dXjxjuNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s7OCZ39n; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s7OCZ39n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A2CA35BCDC
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 03:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769657046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L2cJLb3jeCieWYWlN2XZ72IgoUjLME+MMH+JnbLXe+8=;
	b=s7OCZ39nwK4JXEDcFH/qYxCYy+T6m8f0MYTZDg/wFhsJt45p0lka1bfPfjajmN4CKuQa3/
	GMNak7umLvNU+XtPTLNJOk/qdJ3hF6iJmMb+ooSR17B9aRlOZi6XiI1YaZqHqRulnlgtOR
	tumKbtq+1pfUw/vV9FXPsv9LddzyUKs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769657046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L2cJLb3jeCieWYWlN2XZ72IgoUjLME+MMH+JnbLXe+8=;
	b=s7OCZ39nwK4JXEDcFH/qYxCYy+T6m8f0MYTZDg/wFhsJt45p0lka1bfPfjajmN4CKuQa3/
	GMNak7umLvNU+XtPTLNJOk/qdJ3hF6iJmMb+ooSR17B9aRlOZi6XiI1YaZqHqRulnlgtOR
	tumKbtq+1pfUw/vV9FXPsv9LddzyUKs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D5CF3EA61
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 03:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mLlKDtXSemk+TgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 03:24:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v5 0/9] btrfs: used compressed_bio structure for read and write
Date: Thu, 29 Jan 2026 13:53:37 +1030
Message-ID: <cover.1769656714.git.wqu@suse.com>
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
	TAGGED_FROM(0.00)[bounces-21208-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9DCBAB6A1
X-Rspamd-Action: no action

[CHANGELOG]
v5:
- Implement an internal compress_bio_last_folio()
  Upstream is removing bio_last_bvec_all(), and the recent stable page
  bouncing for direct IO is going to make that function no longer
  reliable.

  Thus we need to implement it locally, with some extra ASSERT()s to
  make sure the compressed bio have all folio sizes fixed to
  min_folio_size, so that we can use offset_in_folio(folio, bi_size) to
  calculate the last position.

- Fix several spelling errors
  jut -> just in patch 5 and chaning -> changing in patch 7.

v4:
- Fix a missing kunmap_local() introduced in encoded write changes
  Which only affects 32bit systems.

- Fix an incorrect unlikely() usage introduced in encoded write changes
  Which will not cause any observable problem but completely flips the
  intention.

- Fix an allocation loop bug for bs > ps cases in encoded write changes
  The encoded write has migrated to use btrfs_alloc_compr_folio() which
  respects the minimal folio size.
  This means the old PAGE_SIZE based loop condition must also be
  changed.

v3:
- Rebased to the latest for-next branch
  There is a minor conflict with the format of parameter list of
  get_current_folio().

- Call btrfs_free_compr_folio() during cleanup_compressed_bio()

- Make it more consistent regarding using btrfs_alloc/free_compr_folio()
  The old compressed read path is using btrfs_alloc_folio_array() but
  freeing them using btrfs_free_compr_folio().

  This is fine but never consistent, unify it to use
  btrfs_free_compr_folio() for all compressed_bio.

v2:
- Fix an error in error path of of compress_file_range()
  If btrfs_compress_bio() returned an error, we should reset @cb to NULL
  before doing error handling, or cleanup_compressed_bio() can be called
  on an error pointer.

- Fix several bugs in zstd_compress_bio() which causes compression
  failure
  There are several different bugs in the mostly copy-n-pasted code:

  * Uncommon @start and @len usage
    The old code allows @start and @len to be modified, which is against
    the more common practice nowadays.

  * Fix a incorrect input buffer check
    Which cause us to incorrectly end the compression early and fallback
    to uncompressed write.

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

 fs/btrfs/compression.c | 208 ++++++++++++++++------------------
 fs/btrfs/compression.h |  40 ++++---
 fs/btrfs/inode.c       | 251 ++++++++++++++++++++++-------------------
 fs/btrfs/lzo.c         | 223 ++++++++++++++++++++++++------------
 fs/btrfs/zlib.c        |  64 ++++++-----
 fs/btrfs/zstd.c        |  98 ++++++++--------
 6 files changed, 482 insertions(+), 402 deletions(-)

-- 
2.52.0


