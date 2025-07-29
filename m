Return-Path: <linux-btrfs+bounces-15736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A00B14B49
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 11:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0AFA7A92C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C5E2877C9;
	Tue, 29 Jul 2025 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MB4Zcbz4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MB4Zcbz4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D910213E66
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781529; cv=none; b=SZhdgPOPLqeYxlLSW9q0NCb+lxCpV2bZmcvHJpa8JUFzSrcp7O3Cbb4TKb3pLaLYus/ORxxbTkILcR8fh244EZtTnjqlQJG0azs0+ECr9rSWnsM2kb5cGKuWGLvUU4s26azFFWkba31lv65aGUPu/j5rWkEqez+fJgbgrPqPeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781529; c=relaxed/simple;
	bh=+P64Rs3XNEPpce65G5LkOP5WOE51kLB+xlFwQZsb/Ck=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hFPvH+UqddUb5nPNXasMKyrCkN+EMfboHOuz2jQYKiLZ22Dr5gd+zcBVC7+fRuFtQ+C877SLqKb2rQtc9QC4AO5d1B9WR4r0EemaqokTjCl4AhmPSQZGVLaZFlvtcMeLuYcHaw5BYWuXzTKnuyQdJ/rZ424bc0FLW+K8JCzWhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MB4Zcbz4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MB4Zcbz4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24E4221A3D
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 09:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753781525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=02QkjTm4d6PQ/6p1xOAPaXAnTcil/cUN8yLuklcrHL0=;
	b=MB4Zcbz4E2ZxPgcdu2wsIJHjwnDZigcQF5iVPDIPiQu4Zli++rsbH5G3/8NAcs0x/G8Ih8
	UlOjMd4m7gsoUSeILC8jvaoRIaCL4AB8yydAbu0dIjl5539DQVEFvWTXkd9IyXivC5+iB5
	G/oiNwZgaajFKCrTkiAMSXzKYWhW7fo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753781525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=02QkjTm4d6PQ/6p1xOAPaXAnTcil/cUN8yLuklcrHL0=;
	b=MB4Zcbz4E2ZxPgcdu2wsIJHjwnDZigcQF5iVPDIPiQu4Zli++rsbH5G3/8NAcs0x/G8Ih8
	UlOjMd4m7gsoUSeILC8jvaoRIaCL4AB8yydAbu0dIjl5539DQVEFvWTXkd9IyXivC5+iB5
	G/oiNwZgaajFKCrTkiAMSXzKYWhW7fo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61BB813876
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 09:32:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V5NBCRSViGgxUQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 09:32:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: follow regular writeback error handling by clearing block dirty and start/end writeback
Date: Tue, 29 Jul 2025 19:01:44 +0930
Message-ID: <cover.1753781242.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80

Recently I'm working on various error handling fixes during
run_delalloc_range(), but sometimes I also hit generic/475 kernel
warnings where no failure from run_delalloc_range().

It turns out that extent_writepage_io() is not following the common
writeback error handling pattern, and leave failed blocks dirty.

This can lead to writeback of those failed blocks again, and the next
time we will hit various possible problems, but the most common one will
be the DEBUG_WARN() from btrfs_writepage_cow_fixup(), exactly the bug
I'm hunting.

So this series fixes the two error handling paths which still leaves the
blocks dirty (even intentionally, and of course that's caused by
myself), to clear the dirty flag and start/finish writeback for involved
block(s).

Qu Wenruo (2):
  btrfs: clear block dirty if submit_one_sector() failed
  btrfs: clear block dirty if btrfs_writepage_cow_fixup() failed

 fs/btrfs/extent_io.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

-- 
2.50.1


