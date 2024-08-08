Return-Path: <linux-btrfs+bounces-7042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D1694B679
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 08:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1B8B23D6E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 06:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAE3185E64;
	Thu,  8 Aug 2024 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kZeYmPP3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kZeYmPP3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C31126F1E
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723097185; cv=none; b=I87JSCdWze0/WWA6YzaXTqD5+ap9uaDgqcKOCK0VO4VGNT9oa+ZDm5WGgYShlFnJM9RtKaTArwVHp+2BjxgavkWcc89fiygKZOGXLkGhzk/UNEBIa294XooNETeE/Qiz7hfXJDY12Z6W0LTu7OO4u2HlrWb15QPmykgpM9+J+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723097185; c=relaxed/simple;
	bh=OztyckMTY+k4D8svUzND/C+zSphwyTjDS6Vz0n8nIyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WZnxtZPWdznYovT6dKB1HiikjpiCh7slWObPHriShM6YhPpu2IEyCzIh9UB3WTAXUKB98sGarn1r+gkknnAUmE8499u+RzmD6TNgJPFu6LWZcypOB3KjntrXBNXqbkeE8jOUcw+NXymOHZl6GrsUC6Z6c43hmyEqTTT6+x1/Zzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kZeYmPP3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kZeYmPP3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5FC021B58
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 06:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723097179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j0oepcrThqjew/uhRCtBYt4YqW+a0RN2XKJbalbXcjw=;
	b=kZeYmPP3gyEKsrjAcTWoy4Xpzz8kQhvOpAnXAnw0yEKivoQp6o3f7Lzqadsrvzcj9UN9nw
	H7BpV49at09RnMkD2IZy/010kn0kAVncuDDih38WJhBj1DBcTnnG4DUSjzXJ0gQGXnaV/t
	Ced0xbUd1gd26JKz5yzux/ElSzDfIXg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kZeYmPP3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723097179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j0oepcrThqjew/uhRCtBYt4YqW+a0RN2XKJbalbXcjw=;
	b=kZeYmPP3gyEKsrjAcTWoy4Xpzz8kQhvOpAnXAnw0yEKivoQp6o3f7Lzqadsrvzcj9UN9nw
	H7BpV49at09RnMkD2IZy/010kn0kAVncuDDih38WJhBj1DBcTnnG4DUSjzXJ0gQGXnaV/t
	Ced0xbUd1gd26JKz5yzux/ElSzDfIXg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C795613946
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 06:06:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B42rH1pgtGZIZgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2024 06:06:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: reduce extent map lookup overhead for data write
Date: Thu,  8 Aug 2024 15:35:58 +0930
Message-ID: <cover.1723096922.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A5FC021B58
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Unlike data read path, which use cached extent map to reduce overhead,
data write path always do the extent map lookup no matter what.

So this patchset will improve the situation by:

- Move em_cached into bio_ctrl
  Since the lifespan of them is the same, it's a perfect match.

- Make data write path to use bio_ctrl::em_cached

Unfortunately since my last relocation, I no longer have any dedicated
storage attached to my VMs (my laptop only has one NVME slot, and my main
workhorse aarch64 board only has one NVME attached either).

So no benchmark yet, and any extra benchmark would be very appreciated.

Qu Wenruo (2):
  btrfs: introduce extent_map::em_cached member
  btrfs: utilize cached extent map for data writeback

 fs/btrfs/extent_io.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
2.45.2


