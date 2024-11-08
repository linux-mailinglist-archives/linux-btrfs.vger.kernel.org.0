Return-Path: <linux-btrfs+bounces-9393-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0AB9C1E47
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 14:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F751C20F60
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 13:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC54B1EF087;
	Fri,  8 Nov 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aHjDW8XM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aHjDW8XM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237811E1C29;
	Fri,  8 Nov 2024 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073523; cv=none; b=RReAH92mCFY+/mc3DFwfnIQzPAICrEy6vw8Eiim4a0ZXQZm5qoWGiS+Joeidt4702MwHE3o8uZcR/z+5t9kNFPyPofp3SJ5rAjPPoFzghmayw/tD4ErVh8b+KXsuEFPlnfHICfZSKAu4BOnhcvF1kY3u6RKy/BGhdbJb7oRX2bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073523; c=relaxed/simple;
	bh=b3aKFShRcOk97EWOL4hpPJ8FbYES5Y8SHGdatwQepto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7MV0Al7s8ypo77rGU0u73jg1vwGV2yoAqOWJrJCPUoz37TjZAH+G/gIYVtiab17Z9BkXSgyDmwxSpX00AxbiAa0RDyMz3CQRpUZgXcaJ2y6tCMIJ5ZQOywI6oFLFWknJIMVjqZFTk4kzlgwUvOAtCbDiR4F+rSXX2ZM9wOgC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aHjDW8XM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aHjDW8XM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 193061FE43;
	Fri,  8 Nov 2024 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731073519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dwVIzSmKQhVsbeWBvbg6PtJi2OxH8xyFNmXxdDN/470=;
	b=aHjDW8XMNLFFjQJHhte+NsP89vV4BxljBNakGiVgkAZD+LwSMs2Rp4EJCLO3kVcQkZIGAi
	XrGz7AcdHVrRTw7hgC2ysPS/7BcsqdIpEEbL0mOotgYTIp00MfzlyXye25YW5dPOWwjMJ1
	VORz8wMHrjGnQu7HHmPrJ4TBYR13uUw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=aHjDW8XM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731073519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dwVIzSmKQhVsbeWBvbg6PtJi2OxH8xyFNmXxdDN/470=;
	b=aHjDW8XMNLFFjQJHhte+NsP89vV4BxljBNakGiVgkAZD+LwSMs2Rp4EJCLO3kVcQkZIGAi
	XrGz7AcdHVrRTw7hgC2ysPS/7BcsqdIpEEbL0mOotgYTIp00MfzlyXye25YW5dPOWwjMJ1
	VORz8wMHrjGnQu7HHmPrJ4TBYR13uUw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06B1C13967;
	Fri,  8 Nov 2024 13:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VlSdAe8VLmdddgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 08 Nov 2024 13:45:19 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.12-rc7
Date: Fri,  8 Nov 2024 14:45:10 +0100
Message-ID: <cover.1731071660.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 193061FE43
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi,

a few more one-liners that fix some user visible problems. Please pull,
thanks.

- use correct range when clearing qgroup reservations after COW

- properly reset freed delayed ref list head

- fix ro/rw subvolume mounts to be backward compatible with old and new
  mount API

----------------------------------------------------------------
The following changes since commit 77b0d113eec49a7390ff1a08ca1923e89f5f86c6:

  btrfs: fix defrag not merging contiguous extents due to merged extent maps (2024-10-31 16:46:41 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc6-tag

for you to fetch changes up to 2b084d8205949dd804e279df8e68531da78be1e8:

  btrfs: fix the length of reserved qgroup to free (2024-11-07 02:08:29 +0100)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: reinitialize delayed ref list after deleting it from the list

Haisu Wang (1):
      btrfs: fix the length of reserved qgroup to free

Qu Wenruo (1):
      btrfs: fix per-subvolume RO/RW flags with new mount API

 fs/btrfs/delayed-ref.c |  2 +-
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/super.c       | 25 +++++--------------------
 3 files changed, 7 insertions(+), 22 deletions(-)

