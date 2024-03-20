Return-Path: <linux-btrfs+bounces-3456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97026880A39
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 04:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE0A1F22F1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 03:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC128125AC;
	Wed, 20 Mar 2024 03:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RvZC/tcM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RvZC/tcM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8541171D
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906908; cv=none; b=vFHXN5AuchxPCaz70+lkYK9MtuNEvkKpaILEEpiSPITya6U9IGlNTTgzp+bakRQ8Hi2dzyVOeKjELy7BrrRvznXoFghB8n1QWczzqb2u7nmT2qtQMoItPhmj2HHZ/n2KdVCbG/7lR2Hv/m/aWf7dHrZ3GCyKUJ0W7wr5LN+YA7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906908; c=relaxed/simple;
	bh=sjgVEdxL0Yr/MIroQgi9j7KbY34lEJLrkHvKj3KG9R0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tDi77a0BIDv9i+yOUzYWCqnDk1kJvJv8NivSHwcad+A3oPb1KSoxP9NpO7JvxtKYahLSMSXpFGckYMs+y6Ci7YtHtFJtErGGnRgbqCG+XgY8Odp0JiOIqFpO3JWOmoOA8ub/3gLR7KUEIOX0gYDmHfVZ2p8SFTx1+z0DwbkVwQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RvZC/tcM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RvZC/tcM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 939ED205F5
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rYHzvywLvCfTGdBVTaS97pNC8fkeaC/6Jqn8R7DDDz8=;
	b=RvZC/tcMLOd7cf51r7nfpuBC+J/Dw+2RTd8sJGKSWjxdrVFEvI+LujdqLOm8pMrMOj8Bq9
	Y0wxU3ddTUVwKb/H/6H2Zje8w5px3QCZd66etA7mLFOsJf9fQFUscM4xww3QaK87p/cMbr
	UnUSYSGXMUdNrdcU/3QubKYVOoQx/Zc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710906901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rYHzvywLvCfTGdBVTaS97pNC8fkeaC/6Jqn8R7DDDz8=;
	b=RvZC/tcMLOd7cf51r7nfpuBC+J/Dw+2RTd8sJGKSWjxdrVFEvI+LujdqLOm8pMrMOj8Bq9
	Y0wxU3ddTUVwKb/H/6H2Zje8w5px3QCZd66etA7mLFOsJf9fQFUscM4xww3QaK87p/cMbr
	UnUSYSGXMUdNrdcU/3QubKYVOoQx/Zc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEAA3136AE
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ph/5IxRe+mVlbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 03:55:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/7] btrfs: scrub: refine the error messages output frequency
Date: Wed, 20 Mar 2024 14:24:50 +1030
Message-ID: <cover.1710906371.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.50
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.19)[-0.958];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="RvZC/tcM"
X-Rspamd-Queue-Id: 939ED205F5

[CHANGELOG]
v2:
- Remove the patch that reworks the output message format
  That change still needs quite some debates, as it's a big trade-off
  between easy to read for a single line and easy to batch floods of
  multiple lines.
  (Considering my personal experience, I would even recommend to go CSV
   like output, as all the real-world reports are floods of such error
   messages, never a single one)

- Split the ratelimit work into its own patch
  The last one

- Address the feedbacks from the mailing list

[BACKGROUND]
During some support sessions, I found older kernels are always report
very unuseful scrub error messages like:

 BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd 0, flush 0, corrupt 2823, gen 0
 BTRFS error (device dm-0): unable to fixup (regular) error at logical 1563504640 on dev /dev/mapper/sys-rootlv
 BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd 0, flush 0, corrupt 2824, gen 0
 BTRFS error (device dm-0): unable to fixup (regular) error at logical 1579016192 on dev /dev/mapper/sys-rootlv

There are two problems:
- No proper details about the corruption
  No metadata or data indication, nor the filename or the tree id.
  Even the involved kernel (and newer kernels after the scrub rework)
  has the ability to do backref walk and find out the file path or the
  tree backref.

  My guess is, for data sometimes the corrupted sector is no longer
  referred by any data extent.

- Too noisy and useless error message from
  btrfs_dev_stat_inc_and_print()
  I'd argue we should not output any error message just for
  btrfs_dev_stat_inc_and_print().

After the series, the error message would look like this:

 BTRFS info (device dm-3): scrub: started on devid 1
 BTRFS warning (device dm-3): checksum error at logical 13647872 on dev /dev/mapper/test-scratch1, physical 13647872, root 5, inode 257, offset 16384, path: file1
 BTRFS info (device dm-3): scrub: finished on devid 1 with status: 0

This involves the following enhancement:

- Single line
  And we ensure we output at least one line for the error we hit.
  No more unrelated btrfs_dev_stat_inc_and_print() output.

- Proper fall backs
  We have the following different fall back options
  * Repaired
    Just a line of something repaired for logical/physical address.

  * Detailed data info
    Including the following elements (if possible), and if higher
    priority ones can not be fetched, it would be skipped and try
    lower priority items:
    + file path (can have multiple ones)
    + root/inode number and offset
    + logical/physical address (always output)

  * Detaile metadata info
    The priority list is:
    + root ref/level
    + logical/physical address (always output)

  For the worst case of data corruption, we would still have some like:

   BTRFS warning (device dm-2): checksum error at data, logical 13647872 on dev /dev/mapper/test-scratch1 physical 13647872

  And similar ones for metadata:

   BTRFS warning (device dm-2): checksum error at metadata, logical 13647872 on dev /dev/mapper/test-scratch1 physical 13647872

[PATCHSET STRUCTURE]
The first patch is fixing a regression in the error message, which leads
to bad logical/physical bytenr.

The second one would reduce the log level for
btrfs_dev_stat_inc_and_print().

Patch 3~4 are cleanups to remove unnecessary parameters.

Patch 5 remove the unnecessary output for nlink and reduce one inode
item lookup.

Patch 6 ensures we get at least one error message output before
ratelimit, and if we failed to output anything, output a fallback error
message.

The final patch would rework how we do rate limits, and use the same way
(btrfs_*_rl() helpers) to do rate limits.

Qu Wenruo (7):
  btrfs: scrub: fix incorrectly reported logical/physical address
  btrfs: reduce the log level for btrfs_dev_stat_inc_and_print()
  btrfs: scrub: remove unused is_super parameter from
    scrub_print_common_warning()
  btrfs: scrub: remove unnecessary dev/physical lookup for 
    scrub_stripe_report_errors()
  btrfs: scrub: simplify the inode iteration output
  btrfs: scrub: ensure we output at least one error message for
    unrepaired corruption
  btrfs: scrub: use generic ratelimit helpers to output error messages

 fs/btrfs/scrub.c   | 142 ++++++++++++---------------------------------
 fs/btrfs/volumes.c |   2 +-
 2 files changed, 39 insertions(+), 105 deletions(-)

-- 
2.44.0


