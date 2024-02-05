Return-Path: <linux-btrfs+bounces-2135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E34A84AAD1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 00:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0825D1C22771
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 23:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED1F4D9F0;
	Mon,  5 Feb 2024 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ViZ+WsG7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PhefNBvT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6BB4D12D
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176779; cv=none; b=t8XS1TXNbw5mk9ezGR2y08ji2bXaC4cDA0AeWeErSAXihuky1A6YBwCbWC9aLNQdXcZjK9vyKnTpWMheofSohmAH+462us9QrwxJMnoffHmqOp+URGjknwb82tFH4SrbAh0gXPL6reARK2JdE0WoUZc75FSr0nMInB+D8CKflyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176779; c=relaxed/simple;
	bh=zSOe3wauGDMsoDrz3O+1yUG097vRV/p7KyiIsuUbrJY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K15josOFsE1fIwJjtpZs/MBrFI++5z70/69nryj7Z6j+3ihAAOlyvXcwyNMjgJNenCT3p3E0uG93kyg1Ip3ClP1e1qyme05n1UqeD2smjMgUGdcXuX+e+U3zdmh5k2lkf8CPhfLpKBSRUuEpkovpJ2JgLTeKklKSI0T3cbCZ2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ViZ+WsG7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PhefNBvT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8D192212D
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707176776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TaKL+HnjbNYT0pp91469LSocxmkUrwQMou/+Wlc+NB4=;
	b=ViZ+WsG7WykLSb+0SFFCafjDIP2gKJXOr1c0/92xs8/P2Hw1jCDZKChsaQSufkaJGO/Unn
	tSI3blsuedpgFSQPWZHVyno6gf1AurhywogUTDpgvZy32bf0e/YT/J2zyV2doHvsdfnY0p
	9Ti1ug41sZldklmRuKuT9AcsVoccg8g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707176775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TaKL+HnjbNYT0pp91469LSocxmkUrwQMou/+Wlc+NB4=;
	b=PhefNBvTkwG6LyLYDq8vlhiLcNhWb+F63dGIQ5b2QSdZ8leq9w/y1XnjVlm3p5ixsDMmNH
	alBgZx2n+7gteTOqniehFhL8qzccmNvW+cAkElZiWzkKdj711dmceQ+Bo1umGtUR2NE/rR
	ndTifE4B71lHUNBw4DcIeGSkU2zObgg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3154F136F5
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LjAfOUZzwWU0cAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 05 Feb 2024 23:46:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: add lone extent defragging support
Date: Tue,  6 Feb 2024 10:16:10 +1030
Message-ID: <cover.1707176488.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PhefNBvT
X-Spamd-Result: default: False [4.11 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.58)[81.41%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.11
X-Rspamd-Queue-Id: E8D192212D
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

This the progs support for the new kernel defrag parameters on lone file
extents.

This adds 2 new fine tunning parameters, --lone-ratio and
--lone-wasted-bytes.

The ratio is between [0, 65536], and wasted bytes is between
[0, U32_MAX], but in reality the value only makes sense below
max file extent size (for both compressed and regular extents).
Any value higher than max file extent size would mostly disable the
wasted bytes check (as it would always be false).

The end user interface is not yet deteremined, especially for the ratio
(RATIO/65536 is too trikcy for most end users).
But it is already enough to address the lone trimed file extent case
mentioned in the kernel patchset.

Qu Wenruo (2):
  btrfs-progs: defrag: sync the new lone extent fine-tunning from kernel
  btrfs-progs: cmds/filesystem: fine-tune lone file extents defragging

 Documentation/btrfs-filesystem.rst | 18 ++++++++++
 cmds/filesystem.c                  | 53 ++++++++++++++++++++++++++++--
 kernel-shared/uapi/btrfs.h         | 26 +++++++++++++--
 3 files changed, 91 insertions(+), 6 deletions(-)

--
2.43.0


