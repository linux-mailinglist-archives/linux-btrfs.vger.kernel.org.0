Return-Path: <linux-btrfs+bounces-17133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF8B982CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 06:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD4F19C4DC4
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 04:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A9919CC37;
	Wed, 24 Sep 2025 04:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bmeHbmzx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bmeHbmzx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E213774D
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 04:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758687404; cv=none; b=Q5vm3iO2kJ4ww7qZSo/ZJtb+WqEII17T/MtRivKHqeq4ZWCW1OYkMkojBJ9exuRdUwc4S3Bc45y0LOddVO/J7o3KDrHVTIR+gy97Ky0S0zi5diLWKNuufo9sY9Aga6ndne3NuzMbAUd+gIUncA4mgKqWMZwvLXoNgLRpGe+NwcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758687404; c=relaxed/simple;
	bh=SyUUtadqmBYCKZknDNTBy0vi+ixxscbG8vBWARt6IGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CcrdHirzE5jhLJtvBIiAMnfbdSQoex51eXEeoJejbdWtX8PZxG9iBwD5jt2kw4iz9j2NoOQp/l1zpY+cdpEiXWJ0lmx6iM3a6QcGdkEbyDfZKKAp78emYrhNcm7t401R9G0f4gUViyL5aVU4EyPVZHedUqNI496PAXsfbzLCXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bmeHbmzx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bmeHbmzx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DB5A1F7D2;
	Wed, 24 Sep 2025 04:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758687400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UkQE0P/EV9YVyrgN6jq5mPISKEEtgXkXIEQEjmavDfw=;
	b=bmeHbmzx78RRkFL0gv3XcjK1Co8vIXWObK68cGTW+r/8NkyMVQw+qbQOG1/nMBpY5gPPqO
	EW13pomil/BmtVpiraMdQsDbF+Tz+SKYs1fscP8q1uGGnF23r53/8rfIBmbBBEF/5V11bg
	zeO1CXV8fjdsOp69DADlgRbbdisQDWw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bmeHbmzx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758687400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UkQE0P/EV9YVyrgN6jq5mPISKEEtgXkXIEQEjmavDfw=;
	b=bmeHbmzx78RRkFL0gv3XcjK1Co8vIXWObK68cGTW+r/8NkyMVQw+qbQOG1/nMBpY5gPPqO
	EW13pomil/BmtVpiraMdQsDbF+Tz+SKYs1fscP8q1uGGnF23r53/8rfIBmbBBEF/5V11bg
	zeO1CXV8fjdsOp69DADlgRbbdisQDWw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2446C133F3;
	Wed, 24 Sep 2025 04:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id taeTCKhw02i3NQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Sep 2025 04:16:40 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 6.17-rc8
Date: Wed, 24 Sep 2025 06:16:31 +0200
Message-ID: <cover.1758686611.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 2DB5A1F7D2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Hi,

please pull one more regression fix for a problem in zoned mode. Mount
can fail if number of open and active zones reaches a common limit that
didn't use to be checked. Thanks.

----------------------------------------------------------------
The following changes since commit b98b208300573f4ab29507f81194a6030b208444:

  btrfs: reject invalid compression level (2025-09-18 13:18:49 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-rc7-tag

for you to fetch changes up to 53de7ee4e28f6e866ac319b9db6e6c1b05664c32:

  btrfs: zoned: don't fail mount needlessly due to too many active zones (2025-09-23 11:22:21 +0200)

----------------------------------------------------------------
Johannes Thumshirn (1):
      btrfs: zoned: don't fail mount needlessly due to too many active zones

 fs/btrfs/zoned.c | 6 ++++++
 1 file changed, 6 insertions(+)

