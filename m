Return-Path: <linux-btrfs+bounces-1002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0018160B3
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Dec 2023 18:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7021C216E9
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Dec 2023 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB27B46441;
	Sun, 17 Dec 2023 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uwNchll+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uwNchll+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF2245BFE;
	Sun, 17 Dec 2023 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FF8C21FA2;
	Sun, 17 Dec 2023 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702833465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Oq3clUmKpX1OJFs+fxfc2D9tD/ZemW1cg/pI2Sgpkns=;
	b=uwNchll+aFPfiG0FNSpc8RKYGPE3CSeMMd9z3ZecNaXJcbwweXjGJnD+9NuxQbL/PSacCd
	ndwNne81Z88lnB1142GWERhNYWEdG7sNzKYasLj+im/CqpLiRf6HWtIwwHDR0TAQW61T1s
	Al6t4KAwl4ymF9FDTCw4hkkx9yh2UOU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702833465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Oq3clUmKpX1OJFs+fxfc2D9tD/ZemW1cg/pI2Sgpkns=;
	b=uwNchll+aFPfiG0FNSpc8RKYGPE3CSeMMd9z3ZecNaXJcbwweXjGJnD+9NuxQbL/PSacCd
	ndwNne81Z88lnB1142GWERhNYWEdG7sNzKYasLj+im/CqpLiRf6HWtIwwHDR0TAQW61T1s
	Al6t4KAwl4ymF9FDTCw4hkkx9yh2UOU=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0644813927;
	Sun, 17 Dec 2023 17:17:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id TUA/ATktf2WnDAAAn2gu4w
	(envelope-from <dsterba@suse.com>); Sun, 17 Dec 2023 17:17:45 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 6.7-rc6, part 2
Date: Sun, 17 Dec 2023 18:17:39 +0100
Message-ID: <cover.1702832900.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uwNchll+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.10)[-0.492];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[18.63%]
X-Spam-Score: 3.59
X-Rspamd-Queue-Id: 0FF8C21FA2
X-Spam-Flag: NO

Hi,

there's one more fix that verifies that the snapshot source is a root,
same check is also done in user space but should be done by the ioctl
as well.  Please pull, thanks.

----------------------------------------------------------------
The following changes since commit e85a0adacf170634878fffcbf34b725aff3f49ed:

  btrfs: ensure releasing squota reserve on head refs (2023-12-06 22:32:57 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.7-rc5-tag

for you to fetch changes up to a8892fd71933126ebae3d60aec5918d4dceaae76:

  btrfs: do not allow non subvolume root targets for snapshot (2023-12-15 23:46:51 +0100)

----------------------------------------------------------------
Josef Bacik (1):
      btrfs: do not allow non subvolume root targets for snapshot

 fs/btrfs/ioctl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

