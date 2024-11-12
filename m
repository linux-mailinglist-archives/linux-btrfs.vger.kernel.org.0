Return-Path: <linux-btrfs+bounces-9496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57619C4F54
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 08:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69020B21A9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 07:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBDA20ADC0;
	Tue, 12 Nov 2024 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V8ZfT9gM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V8ZfT9gM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A061BF58
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396243; cv=none; b=eEjSm9kplNb8/Ig5xsvDFbWmuPn/ojLmoHYMwdKH9R6ULml+DdK5HiwZUjBfIxJr9LuDOGkQ7slpMRoZddDGcUwAPNhWi+FJSVehbT6Rf2aKLimrvC2L3xBqmDgJCaULjLFDYSPYHcJnWkb6gDKOE68XR12eyLwq6TlVC3jM8fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396243; c=relaxed/simple;
	bh=ULHSNTRI0cp7R52002Mbse8OPSlVWfkwP8qaUbDhD4M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QMUXsKZj5xgtZC7EIZLHY25uHsvK/HpIi8Gqrva5c40h2wrBHEnRLUV//ouRXX+bBqrpRhG8mwhi0iW1+DxKw/C7obuufXzSgrQ/ZbaDIfBH4n50NPvcx3wyRPug2P9M+rX7hCCtHclROzJxw/wJjsEcORkaBd2IgFykvpRpr+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V8ZfT9gM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V8ZfT9gM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 274A11F392
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731396240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jBQxpVdaZWbcoJT/fcNcPE9ghzSremyyRJr05QhrInc=;
	b=V8ZfT9gMbyWuOLJ+xnMITJ2Vhh0YEUvFJftbwRSNU6XJhF89LxKME4QWrP5NvlCeCrWtbg
	rbyzWzhnP/Q2GeZ+JqBwwEzrP5IAVLjnL4/5qKMdCnIX1QqSeBx+SJ2pi4Z1TU1cOBYpO8
	AY5Vg78zlsrcthKst1FqPscGAHINPVI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731396240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jBQxpVdaZWbcoJT/fcNcPE9ghzSremyyRJr05QhrInc=;
	b=V8ZfT9gMbyWuOLJ+xnMITJ2Vhh0YEUvFJftbwRSNU6XJhF89LxKME4QWrP5NvlCeCrWtbg
	rbyzWzhnP/Q2GeZ+JqBwwEzrP5IAVLjnL4/5qKMdCnIX1QqSeBx+SJ2pi4Z1TU1cOBYpO8
	AY5Vg78zlsrcthKst1FqPscGAHINPVI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5266413721
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P4ryBI8CM2esdAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:23:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: btrfs_buffered_write() cleanups
Date: Tue, 12 Nov 2024 17:53:34 +1030
Message-ID: <cover.1731396107.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This series is to cleanup btrfs_buffered_write() so that it's more
aligned to iomap_writer_iter(), and makes later migration a little
easier.

All those changes are inside btrfs, and the last 2 should improve the
readablity, and prepare for the migration (since everything is now done
inside the loop).

Qu Wenruo (3):
  btrfs: make buffered write to respect fatal signals
  btrfs: cleanup the variables inside btrfs_buffered_write()
  btrfs: remove the out-of-loop cleanup from btrfs_buffered_write()

 fs/btrfs/file.c | 90 ++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

-- 
2.47.0


