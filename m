Return-Path: <linux-btrfs+bounces-14403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63948ACC204
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 10:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06EE1890F7F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 08:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F32C3244;
	Tue,  3 Jun 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nJAv5+sR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TstGQJ7i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75342EED7
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938596; cv=none; b=e96+biuSmT/ErZytCSpdGL+kZ+xDDHKQtmUC7NwhhiwuoYLtK4GljmbTbl+j+5qWsCcFbBaU2bHX62D/cATjBwoFOzndE5sBjHsRCH7lPjzg5oSrlzaW8lkBIkomkBAcQ+B5Lz1fdstSa2hJ+1UufUOEFQRAG4sby3rksCx4f14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938596; c=relaxed/simple;
	bh=yj3DhgRk4inZWpq+9xxnHM5JryBFQ4wmlR8YcfnaJb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5k5A/p0NpbNy20bQliJIXV6uEYIXdOoPYOoTsqU3nbSHqSVoz2wEOBWKNKKlELU4rIx/pQ+Ffi5u5jfijhe7heTRP01CbNmaH8VyYCYSpjTX09YwSn6wa4TwaBc0PeXLk0v/GtVOAqDcSlZv0Hfz6syNRnRF2hEmRwm9Fh0fmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nJAv5+sR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TstGQJ7i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74C062111F;
	Tue,  3 Jun 2025 08:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748938592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zdvFE2VBGJ73GNRdUZdLdF1hEmbUWHDxP1HHvW/308o=;
	b=nJAv5+sRdq+lwfaehA0XxYhCMQQkxssV+jRdvZmYwocCGa9toc64x4C/1FecOLxPQt31Mn
	M4VenUcoZfJj/fysUe/3u0SNWF2zcd78mM0zRoru4VNT0gsjsbLVUdu4h/elvEoFUDRZOY
	dsfLva0Mc0nzZ2xRf+UHyMBwHE6WlfM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748938591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zdvFE2VBGJ73GNRdUZdLdF1hEmbUWHDxP1HHvW/308o=;
	b=TstGQJ7ix+fFZPIpHBZbUUqHr19utLsncg4J/LFGeC5GuMURm12HyhbQPwqzGU6OmU8ANJ
	G9vAKH5jf29Ewlk2EJjMbbfyPxqYFbSGOh7oRpO6k+lWevDmh3Da3DfaiIV7jGykwaCcI9
	4W9EiC5of7kT+OacmM+hrvXOJrUo6yI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E63113A92;
	Tue,  3 Jun 2025 08:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WsPtGl+vPmibIgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 03 Jun 2025 08:16:31 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Folio pos + size cleanups
Date: Tue,  3 Jun 2025 10:16:16 +0200
Message-ID: <cover.1748938504.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Helper to simplify numrous folio_pos() + folio_size() calculations.

David Sterba (2):
  btrfs: add helper folio_end()
  btrfs: use folio_end() where appropriate

 fs/btrfs/compression.h  |  7 +++----
 fs/btrfs/defrag.c       | 13 ++++++-------
 fs/btrfs/extent_io.c    | 17 ++++++++---------
 fs/btrfs/file.c         |  9 ++++-----
 fs/btrfs/inode.c        | 10 ++++------
 fs/btrfs/misc.h         |  7 +++++++
 fs/btrfs/ordered-data.c |  2 +-
 fs/btrfs/subpage.c      |  5 ++---
 8 files changed, 35 insertions(+), 35 deletions(-)

-- 
2.49.0


