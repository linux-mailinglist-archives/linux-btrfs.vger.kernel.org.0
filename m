Return-Path: <linux-btrfs+bounces-10982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631C2A13884
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 12:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9893A188748C
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704411DDC10;
	Thu, 16 Jan 2025 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KstESxiS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D5ogq5t/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CFD26AF3;
	Thu, 16 Jan 2025 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025390; cv=none; b=pAA9FISYtrQd3oiKc0iSZrIhljPvH9cVRRXgygxmKuAIhWUyq2mH++wM/XiClC3oFCGgbzVJiPxwNZqTp5c8knKQxGNk8iUyWvf+mdzsgGKEMk7hLGnG8PyDMwhHByUtM7GFWQg3VaQm7Ap69Mplee6QSu6E6QLQdFXMO2CHt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025390; c=relaxed/simple;
	bh=6pDXKdJK4+my28+P7wZDwwyAeVhf0QtI+UZ4InqqdDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/0JKveuUWIxSAm23KeUW7AW+6XPnt4IwO0HrZ64SxuaLHJMwL38bnBqMxF3pwtmEi7EbY8eonedkdbTgFPlNrdXzvCytXJaH+qN1vSzJ8Y6CIp15KEoN2Bxs2iRnXA3FznaTuiWONICleYNLPE6SW+wKMzxmbd70dW25/jKOMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KstESxiS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D5ogq5t/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3925211D5;
	Thu, 16 Jan 2025 11:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737025387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1uHnDRBBmmph65/UPBqfJ7NMqMyfXwWAd6Em6h080rA=;
	b=KstESxiS2vGDEkq6RNvshihLcP+ek1/JuZp+AuC9hG3OH5OK+NVnwc3LZnSGwsSGmQ0oAC
	3X2aJvUq0ge5atDEohvP7L37b0R5TU+i2i45I3rQQJfwLlO1Fd+uFMhqXZ5nofaMfh9AH3
	K6LnHfk6qoX8G1dNsOiY5kiMlK8G0qU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737025385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1uHnDRBBmmph65/UPBqfJ7NMqMyfXwWAd6Em6h080rA=;
	b=D5ogq5t/hqNODtZM8zEekQ/WNMK9lxjn3s98MKNgyIDbk9cC4ajWpto/g6yc6BKIRJVknm
	OTs1Eo0F1futKVAQe3ixeEnx33t6pKrct1Ngkdy47+cP6IOIpnc9TUFsUZbFibuX1blvVw
	gHkQ/CuVgE5QbYBp/btSLrXupR8r3FA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB47A13A57;
	Thu, 16 Jan 2025 11:03:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dkZmLWnniGfXSwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 16 Jan 2025 11:03:05 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 6.13-rc8
Date: Thu, 16 Jan 2025 12:03:00 +0100
Message-ID: <cover.1737024972.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi,

please pull one more error handling fix. Thanks.

- handle d_path() errors when canonicalizing device mapper paths during
  device scan

----------------------------------------------------------------
The following changes since commit 0ee4736c003daded513de0ff112d4a1e9c85bbab:

  btrfs: zlib: fix avail_in bytes for s390 zlib HW compression path (2025-01-06 16:32:43 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.13-rc7-tag

for you to fetch changes up to fe4de594f7a2e9bc49407de60fbd20809fad4192:

  btrfs: add the missing error handling inside get_canonical_dev_path (2025-01-13 21:39:52 +0100)

----------------------------------------------------------------
Qu Wenruo (1):
      btrfs: add the missing error handling inside get_canonical_dev_path

 fs/btrfs/volumes.c | 4 ++++
 1 file changed, 4 insertions(+)

