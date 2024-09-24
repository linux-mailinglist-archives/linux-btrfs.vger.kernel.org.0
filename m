Return-Path: <linux-btrfs+bounces-8184-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7D9983C4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 07:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D480CB21105
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 05:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FAB40BF2;
	Tue, 24 Sep 2024 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WYhAjasi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WYhAjasi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446821B85D0
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 05:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155050; cv=none; b=GzWG88LiWdtQvJ/nqSRoecaFVjywxzk4eGfutQrCpmvw/olbBCFvuz6pm3jF9+PPcretuAxwl0XX4LvMuP+SJS5BH4FeK6ggvwHfsj1mphFB9qxB/Cf1t9VYhY0F+ledtx1DzMB3sPR0izC52BwG1+0t0R8HwN7jwmyD+MGoLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155050; c=relaxed/simple;
	bh=wcnB7HsC/Uk0iT7QJZvHJFSVjKnoXxXUtbggez+k/bc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gOqoqBOLCX0WMP9Gbj7t5xYQom3EfB6R8IJMeWDMZj6QyhOMpn+UqNKjrXC/tP00L1qP5GooeaZPPdTjqiW6VKtjIqaD4SsS4wW1qrAeUHqsU+0tA4XyQXZ+mO9YGDDHQTT5m9g7wBpvxpMGpQAB1c9NnlPiHh38sIzEv0wJJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WYhAjasi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WYhAjasi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AD161F769
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 05:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727155046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Hx+4V3gDXzYpwnOMmxIu4UvWaN3Wcj92dVeF04l4qnI=;
	b=WYhAjasi1JmtIv1Ra03O8yq4H7WA/G9e0DjPZBHbTJyuU+94NFVjA4n/S0F2Gj5X7ERVYJ
	GsXhdvpHOms6SvyqQ+KMfTj8u++qPAdjsq3atAYTwCCf8wgjooG8c5VQwkyQ16dMfGE16Q
	+hM+FBd5T3CCCFYTl9CTjhSD8VvcTqM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WYhAjasi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727155046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Hx+4V3gDXzYpwnOMmxIu4UvWaN3Wcj92dVeF04l4qnI=;
	b=WYhAjasi1JmtIv1Ra03O8yq4H7WA/G9e0DjPZBHbTJyuU+94NFVjA4n/S0F2Gj5X7ERVYJ
	GsXhdvpHOms6SvyqQ+KMfTj8u++qPAdjsq3atAYTwCCf8wgjooG8c5VQwkyQ16dMfGE16Q
	+hM+FBd5T3CCCFYTl9CTjhSD8VvcTqM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BFEC1386E
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 05:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yv5YCGVL8maFQgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 05:17:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: enhance btrfs device path rename
Date: Tue, 24 Sep 2024 14:47:05 +0930
Message-ID: <cover.1727154543.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1AD161F769
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Fabian Vogt reported a very interesting case where we can use
"/proc/self/fd/3" to mount a btrfs, then that /proc name will remain as
the device path for the btrfs.

Sometimes udev scan can trigger a rename, and get a proper name back,
but if that doesn't win the race, we got the "/proc/self/fd/3" in the
mtab which makes no sense, since "/proc/self" is bounded to the current
process, no one is going to know where the real device is.

So to enhance the handling:

- Do proper path comparation to determine if we want to update device
  path
  Currently the path comparation is done by strcmp(), which will never
  handle hard nor soft links at all.

  Instead go with path_equal() on the resolved paths, which is way more
  reliable.
  This should reduce the unnecessary path name updates in the first
  place.

- Canonicalize the device path if it's not inside "/dev/"
  If we pass a soft link which is not inside "/dev/", we just follow the
  soft link and use the final destination instead.

  It can be something like "/dev/dm-2", other than more readable LVM
  names like "/dev/test/scratch1", but it's still way better than
  "/proc/self/fd/3".

  If the soft link itself is already inside "/dev/", then we can
  directly use the path.

  This is to allow fstest run properly without forced to use
  "/dev/dm-*" instead of the "/dev/mapper/test-scratch1" as test
  devices.
  Otherwise fs tests will reject runs because it believe the btrfs
  is mounted somewhere else.


Qu Wenruo (2):
  btrfs: avoid unnecessary device path update for the same device
  btrfs: canonicalize the device path before adding it

 fs/btrfs/volumes.c | 107 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

-- 
2.46.1


