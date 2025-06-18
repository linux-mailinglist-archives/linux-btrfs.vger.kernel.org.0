Return-Path: <linux-btrfs+bounces-14767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9433AADE9EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 13:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1155E17A628
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301552BCF73;
	Wed, 18 Jun 2025 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XLTPxSrs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XLTPxSrs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2EC28000E
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246180; cv=none; b=YkL1F0lPeYVoX1HR2hj606gtNavsIeriFcOurAuhy2gTRTeRhoICq8wcdMo0ugybrGeflQ1d28OHj/4Jktaq2eEZ3VtACICtshU2LotJX2D+b7pf82ghEIsT2O99qJiLjO5SGOmLv2JXNdZ08wEbjbaEsghyChgsq6ePVZ64OBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246180; c=relaxed/simple;
	bh=6avvIPZ+TMDyafqtulYV5o9HlFZqcBpf6Qac9SouRJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFDnDnr1Da3as3OqeDa1tAPPQ6W/zZql5t90/lhTPc51YQQlnD2CPHaNwIPu/rdIuOO14IIIpBC0C8k6zjJPSniTGcucc6xBjyxd6MGJAcmKdauqiSJ449KHFRIB/0W/7C9i5WXX1AvrC+4mJSVP5z7DZ+AYyXuNZth8XO0hn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XLTPxSrs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XLTPxSrs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E2351F7C3;
	Wed, 18 Jun 2025 11:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750246176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BPA1QzEuggGhTT6O8wI4LlrSgkFwKm5FX5P0tX5Mr1I=;
	b=XLTPxSrsJKKGpinebMJ72tkgU3ICmen1zhUXHLHq3baoGxOlXiVZ06yX8nZ5p+6n+sMu1O
	PJaRA2LF/bP1wUlhxNyt05G1X3vXsIT6fOuxRJ3KsHuIQMp8bYA2WG6+YMNw/ykk3mTd8T
	/6xOpg7wJaDX5AxjdDLGn1ctyPjVGuM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XLTPxSrs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750246176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BPA1QzEuggGhTT6O8wI4LlrSgkFwKm5FX5P0tX5Mr1I=;
	b=XLTPxSrsJKKGpinebMJ72tkgU3ICmen1zhUXHLHq3baoGxOlXiVZ06yX8nZ5p+6n+sMu1O
	PJaRA2LF/bP1wUlhxNyt05G1X3vXsIT6fOuxRJ3KsHuIQMp8bYA2WG6+YMNw/ykk3mTd8T
	/6xOpg7wJaDX5AxjdDLGn1ctyPjVGuM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4579913A3F;
	Wed, 18 Jun 2025 11:29:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5V/vECCjUmiVPwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 18 Jun 2025 11:29:36 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5] Return value name unifications
Date: Wed, 18 Jun 2025 13:29:26 +0200
Message-ID: <cover.1750246061.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4E2351F7C3
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01
X-Spam-Level: 

Use 'ret' instead of 'error'.

David Sterba (5):
  btrfs: rename error to ret in btrfs_may_delete()
  btrfs: rename error to ret in btrfs_mksubvol()
  btrfs: rename error to ret in btrfs_sysfs_add_fsid()
  btrfs: rename error to ret in btrfs_sysfs_add_mounted()
  btrfs: rename error to ret in device_list_add()

 fs/btrfs/ioctl.c   | 35 ++++++++++++++--------------
 fs/btrfs/sysfs.c   | 57 +++++++++++++++++++++++-----------------------
 fs/btrfs/volumes.c | 10 ++++----
 3 files changed, 50 insertions(+), 52 deletions(-)

-- 
2.49.0


