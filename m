Return-Path: <linux-btrfs+bounces-12100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFCEA5729E
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 20:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398C7178441
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 19:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968A0254B18;
	Fri,  7 Mar 2025 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="etNMD7Ja";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="etNMD7Ja"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FCF21859D
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377494; cv=none; b=B5FeOrwL3WBIG2PgUkRNCu+87uUVbB5uPMvHV5YUFLs/P6EUKAQ0OeeHm31BsREXxnNmLEY6SuST4d5j/VUCorgRjinRR1rOiaCy62USvCWGwDbBAg76nfc0TgRwPp7oZSOrOF/zdR9VRN7k6SVjleZwzSl4FXYhmX/UefK7aGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377494; c=relaxed/simple;
	bh=2Ng9eczj7tPs4jBzvuv2xYb3kGQzOUlC7RGiwZlIKNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBE3Z8UapYz0eKBIhWaCfKPGKinYdz74fPcgSXBB4KTGh/uijD23kUpwIqIT1Ikiwc5eOeqC5VLAxLdxUuPfaq8ECc6BAk61EXpyAcOFvUojktAJ5tNG5TzWT65XDaopMOafqVbnPDqijSHk3UKtxXQoNBO2Pkiv6A57nDTfmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=etNMD7Ja; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=etNMD7Ja; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC2D91F38E;
	Fri,  7 Mar 2025 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741377489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XQ/UD5syP1/M7NlGNoLzGFnamddeKuhAzXox0komqJ0=;
	b=etNMD7Ja6jd5501tfCs+nWaqxBWutT4i18O7+1yfsbV23g9zPo+Io/P0xJ5h2HVhxGaoOl
	Nai0chEzG7s/1AUTlVvg9R8OUoKChrtfVUOv5LLqhsUEg2ITsrA66PpfZcPZM4FkjPlnL3
	fs2+NkTzFtKwNNyCdoqbl2hfn9NYQBk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741377489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XQ/UD5syP1/M7NlGNoLzGFnamddeKuhAzXox0komqJ0=;
	b=etNMD7Ja6jd5501tfCs+nWaqxBWutT4i18O7+1yfsbV23g9zPo+Io/P0xJ5h2HVhxGaoOl
	Nai0chEzG7s/1AUTlVvg9R8OUoKChrtfVUOv5LLqhsUEg2ITsrA66PpfZcPZM4FkjPlnL3
	fs2+NkTzFtKwNNyCdoqbl2hfn9NYQBk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC95F13A22;
	Fri,  7 Mar 2025 19:58:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YyvFKdFPy2d3DwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 07 Mar 2025 19:58:09 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.15-rc6
Date: Fri,  7 Mar 2025 20:58:03 +0100
Message-ID: <cover.1741370327.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

please pull a few more fixes for btrfs, thanks.

- fix leaked extent map after error when reading chunks

- replace use of deprecated strncpy

- in zoned mode, fixed range when ulocking extent range, causing a hang

----------------------------------------------------------------
The following changes since commit efa11fd269c139e29b71ec21bc9c9c0063fde40d:

  btrfs: fix data overwriting bug during buffered write when block size < page size (2025-02-21 09:32:24 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-rc5-tag

for you to fetch changes up to 35d99c68af40a8ca175babc5a89ef7e2226fb3ca:

  btrfs: fix a leaked chunk map issue in read_one_chunk() (2025-03-06 14:40:09 +0100)

----------------------------------------------------------------
Haoxiang Li (1):
      btrfs: fix a leaked chunk map issue in read_one_chunk()

Naohiro Aota (1):
      btrfs: zoned: fix extent range end unlock in cow_file_range()

Thorsten Blum (1):
      btrfs: replace deprecated strncpy() with strscpy()

 fs/btrfs/inode.c   | 9 +++++++--
 fs/btrfs/sysfs.c   | 4 ++--
 fs/btrfs/volumes.c | 1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

