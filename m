Return-Path: <linux-btrfs+bounces-3272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1B187BAB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 10:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431B22834C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 09:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD1C6D1AB;
	Thu, 14 Mar 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o3Quffzh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o3Quffzh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D36CDCF
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409829; cv=none; b=TS0rTl3Yvrwubae0DfQWbMl+HDWE6DH0Op4Su34gKUU0FfmE+S4+I3fN1k2ikOWWhoGWixoLyQNCwxoU6qa6eE9029AShI6PslCwh11B4FyGytd3mv3cx37rkjUxoHtvfyVvKjSe8MCTWPiktJKxdBxDLfiiLc8Hd92ja1WvkFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409829; c=relaxed/simple;
	bh=XFZygC7d0n9IyJcDJ49t+Dr9wFa6u3NJK1rMyJN26lE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ls4dfj3iuPWfKFoK0ZWY6Mp2q6TpYWjBFNtD15VpSGI+7Q+wEGkebq0WNYdICf8HstXWPxvIoJIRZexhEVQzMZlZB4WiYRchglDQJHdRS+V7/+PnThXQXoDKLGSsZFVX7maJg5O0qTgocIFE1KiJS5iaGkjeV4mJaAr8vkmKbyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o3Quffzh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o3Quffzh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8AD021C81
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZsQqu5DsYMgz0+0kv2YdjKLsaz41Es6oLLkZE20AXdo=;
	b=o3Quffzh/e8ghi05NQup2OITpvAw0cCnQVFHA4euDi6CDmr4yT+UhEz6TUZtgfovBIGlR4
	V/B/vShuTKpdcL33/gPJS5naFQE87ci021HigFhBWGoHJ3ROEw3kPG6M+oJA/12E+jrhKK
	jcZI/YBVLQSj8UW7n520fJIcbbQSNlI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710409824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZsQqu5DsYMgz0+0kv2YdjKLsaz41Es6oLLkZE20AXdo=;
	b=o3Quffzh/e8ghi05NQup2OITpvAw0cCnQVFHA4euDi6CDmr4yT+UhEz6TUZtgfovBIGlR4
	V/B/vShuTKpdcL33/gPJS5naFQE87ci021HigFhBWGoHJ3ROEw3kPG6M+oJA/12E+jrhKK
	jcZI/YBVLQSj8UW7n520fJIcbbQSNlI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEF881386D
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h9iEIV/I8mWPQQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 09:50:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: scrub: refine the error messages
Date: Thu, 14 Mar 2024 20:20:13 +1030
Message-ID: <cover.1710409033.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

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

 BTRFS warning (device dm-2): checksum error at inode 5/257(file1) fileoff 16384, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872

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

   BTRFS warning (device dm-2): checksum error at data, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872

  And similar ones for metadata:

   BTRFS warning (device dm-2): checksum error at meta, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872

The first patch is fixing a regression in the error message, which leads
to bad logical/physical bytenr.
The second one would reduce the log level for
btrfs_dev_stat_inc_and_print().

Path 3~4 are cleanups to remove unnecessary parameters.

The remaining reworks the format and refine the error message frequency.

Qu Wenruo (7):
  btrfs: scrub: fix incorrectly reported logical/physical address
  btrfs: reduce the log level for btrfs_dev_stat_inc_and_print()
  btrfs: scrub: remove unused is_super parameter from
    scrub_print_common_warning()
  btrfs: scrub: remove unnecessary dev/physical lookup for
    scrub_stripe_report_errors()
  btrfs: scrub: simplify the inode iteration output
  btrfs: scrub: unify and shorten the error message
  btrfs: scrub: fix the frequency of error messages

 fs/btrfs/scrub.c   | 185 ++++++++++++++++-----------------------------
 fs/btrfs/volumes.c |   2 +-
 2 files changed, 66 insertions(+), 121 deletions(-)

-- 
2.44.0


