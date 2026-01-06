Return-Path: <linux-btrfs+bounces-20162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E96CF9514
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 17:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 186F7304F2F5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 16:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E06C324719;
	Tue,  6 Jan 2026 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LEvlPqlP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LEvlPqlP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04F63128BA
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716445; cv=none; b=QJJxzWkmu03BFjjtxTVeNkiSVXQ7iHxFz+17hJvBx114Wipa1YGy4aYKBlT5aBE9twFdBNhNghO0jxTsg/alOUKP1BS2y6c+M8uk9hfp1IyvFEyjd8q2JDi1kUfDv0qmhsGwlYyqpHVe6Q7lqBv/EjnGq7Ozy+m5pKC+QEzcqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716445; c=relaxed/simple;
	bh=LCXZLC6q2NoGHaGLkJ/dlqPjUzygvdodfRkU3/COCJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwiptw5v39AXT5aYlGL6EMBtikEySIBHhv7jLSpKkEcn3sS7aNd999WMsQanQO0M44XRL3qVPQTWxosdfoVNnaeDf+TC3uoLs2unNbcfPkO9NmL7QClvcnIQQNstwikdLVRQUCKEzkMu+4VDzUnMwSg8pLWs1ae1AzN+UWarnvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LEvlPqlP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LEvlPqlP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF30B33691;
	Tue,  6 Jan 2026 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FLGRbCVx9giT0/alqLnKayqigMAVvYKQFk65Un5KOb8=;
	b=LEvlPqlP1Vw1GxdRoJ+NsKTpx6QyPOxSiryrw7+kEKBCFLQk9DQUW2/pFT56P/SxlLD95C
	9FL4l3q2HfrpjuIjlt1ZqSq1B1k9z2SY33M5nlDC+FA9+oCEaE8RKAu7Oz3ZA/9M3vhgl+
	KBf7tL6OJGghRx6kScNTHIs0QT2FFfA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FLGRbCVx9giT0/alqLnKayqigMAVvYKQFk65Un5KOb8=;
	b=LEvlPqlP1Vw1GxdRoJ+NsKTpx6QyPOxSiryrw7+kEKBCFLQk9DQUW2/pFT56P/SxlLD95C
	9FL4l3q2HfrpjuIjlt1ZqSq1B1k9z2SY33M5nlDC+FA9+oCEaE8RKAu7Oz3ZA/9M3vhgl+
	KBf7tL6OJGghRx6kScNTHIs0QT2FFfA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A86BB3EA63;
	Tue,  6 Jan 2026 16:20:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4xEYKVk2XWkVWQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 16:20:41 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 00/12] Short cleanups
Date: Tue,  6 Jan 2026 17:20:23 +0100
Message-ID: <cover.1767716314.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
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
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.980];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]

Collection of short clenups that improve code that's somehow performance
sensitive. The improvements are on instruction level or reduce stack
consumption.

David Sterba (12):
  btrfs: remove duplicate calculation of eb offset in btrfs_bin_search()
  btrfs: unify types for binary search variables
  btrfs: rename local variable for offset in folio
  btrfs: read eb folio index right before loops
  btrfs: use common eb range validation in
    read_extent_buffer_to_user_nofault()
  btrfs: lzo: inline read/write length helpers
  btrfs: zlib: drop redundant folio address variable
  btrfs: zlib: don't cache sectorsize in a local variable
  btrfs: zlib: remove local variable nr_dest_folios in
    zlib_compress_folios()
  btrfs: zstd: reuse total in and out parameters for calculations
  btrfs: zstd: don't cache sectorsize in a local variable
  btrfs: zstd: remove local variable nr_dest_folios in
    zstd_compress_folios()

 fs/btrfs/ctree.c     | 11 +++++------
 fs/btrfs/extent_io.c | 23 ++++++++++++-----------
 fs/btrfs/lzo.c       | 28 ++++++----------------------
 fs/btrfs/zlib.c      | 25 +++++++++----------------
 fs/btrfs/zstd.c      | 43 +++++++++++++++++--------------------------
 5 files changed, 49 insertions(+), 81 deletions(-)

-- 
2.51.1


