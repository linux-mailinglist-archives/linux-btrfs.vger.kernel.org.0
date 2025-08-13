Return-Path: <linux-btrfs+bounces-16068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED24B252D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 20:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 858B07A6D11
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 18:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3AC2C0F66;
	Wed, 13 Aug 2025 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hYUBcwdX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NEU6Pjgh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3E2BF3E0
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108665; cv=none; b=qQPKFISbUsYBSd8opL6lqM8qY88hHmMXOp6UFLR61HtAplDor2SdtyyZaoEFDvdbredQ4Qyl2+EfgMuCDoWzPvYQul4Fa4RcAR7b6GxKwP8omTOZbVqZom77L5kySVTaVXlBaPFnGIadNsCEHjUsXei2yB9AcPJ64a3c2jGWmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108665; c=relaxed/simple;
	bh=oK00Mp0q7vnVGGhZzlSBBeIyRDGtEVXetgtyM7Nu7MI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DO9+vweu1Tc4x4MuRAtt/mWkGZZZkaFVFdZCeA3VBR75ePLb2BTWR4exZGur+qgDluomC6vPBzwM644Y3RPG17zcTctA7QMXgSe130vcOMuMIp4kTSeQWI6tBnnqbMm87to8fX+s5yTDcLq2gCdULyUZYl4l17UBSIC3TdJO90M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hYUBcwdX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NEU6Pjgh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5DC02121E
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 18:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755108660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ON/Yg+bPTqJJo/oGwQUMugIRfEbS9VWWJ6HJq6mddeM=;
	b=hYUBcwdXbME7hIYVtzERmeCmsDc4QFkVir2pMl0HVdmXB8xXeAlxc4Wo8RD0qt8Cm40l8+
	dzrmQihD21Swv8Cf5lNmpbVhDq28RVKbCs85FqwOEMWv+vu/Jm607EufL9O/r2n2hzgZTU
	nbOAAcSdD7tp7RshmmnfbMcMUzwGEtI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NEU6Pjgh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755108659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ON/Yg+bPTqJJo/oGwQUMugIRfEbS9VWWJ6HJq6mddeM=;
	b=NEU6PjghB8rrKgyVxYkuI7oIlqsq4Cs6u/nnSErQ5bynLwixGILbCQx80cWAttz8sy1Gqv
	A85NfrJykUCcOSVtbL9TQwRZHCJCx4rYm1GQ1FjN9O/E2RTNxlV+MxzIFZcpltUZ3mfNFZ
	59cRnPfBP+hcCDGQYPJAgwe95FmfhgY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBFEB13929
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 18:10:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OLdnNTPVnGjhLwAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 18:10:59 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.16
Date: Wed, 13 Aug 2025 20:10:50 +0200
Message-ID: <20250813181054.9949-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E5DC02121E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid]
X-Spam-Score: -3.01

Hi,

btrfs-progs version 6.16 have been released.

This is more of a bugfix release again with some new updates.

Changelog:

* mkfs:
  * print label of existing filesystem if attempting to overwrite
  * remove note about changed defaults in 6.15
  * discard support detection uses the ioctl and not sysfs, this should
    work for all types of block devices
* device usage: fix printing units of partition sizes, used to be in 512B
  sectors
* defrag: new option --nocomp to request no compression (kernel 6.17)
* check: detect missing orphan items for deleted subvolumes
* subvol delete: don't print warning if filesystem is mounted with
  user_subvol_rm_allowed
* build: add build support for Android
* other:
  * cleanups and refactoring
  * sync sources with kernel
  * documentation updates
  * CI and test updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.16
Python: https://pypi.org/project/btrfsutil/

