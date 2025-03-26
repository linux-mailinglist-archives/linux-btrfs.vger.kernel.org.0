Return-Path: <linux-btrfs+bounces-12599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69189A71FC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 20:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EC93B69F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 19:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED8E25290D;
	Wed, 26 Mar 2025 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wpiz6eC8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="urYYnU30"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC563CB
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Mar 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019144; cv=none; b=psTiPEeK+rBnex0hfOwkjtwlVQpayp/77FlY4PpkC5s1hE6YkxyxDCS99TYirRJy5QsLEtBrYSVqb/xM14G49PyCa5/jD6IiozMax9QCasR6n9l3WCtSFjbIhfB65+1S25HfZ5Fz4AgwZGiwsRUefy38Wa4FTCYcZchmgw11tv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019144; c=relaxed/simple;
	bh=th3Fi6gkckQ/tAhpRNILPsvd1njuZREBejB/qUTHvRo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RJuPEhoo4400Szbky3VJ2DNuwczNz/0dAXJj6DCK9D1UtoDlG/6GRJcOdFI2SesCJdCdfHg0ROPdisp6mzJU+S8bAu0Hpsu6NRPi8GWTb5LkCru6yAhWbavxwN/gpji6foLhDuWHC3LGxOZ0wo86qgcvhOSD9KB+2zn2LZW2Z70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wpiz6eC8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=urYYnU30; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E62051F391
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Mar 2025 19:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743019140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JKemAL3oghtggjBrYIRN+H5uV1Fk126d03QuTU1Iv+Q=;
	b=Wpiz6eC8yFKFWfRJwizGLms10og0DxUBLhj226ZH7yfvQqMHkk+9ewRdvf3PHojwJNsyGX
	m12w1qffJLGtNxG86OqIw44k1R+lDVpUe+gyh1X8FCVIZ6iECh4jj6qw1rm1g+2x+/E0QC
	/MQhqDP8cPotboo5LwBBGg+l/7uEEgY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=urYYnU30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743019139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JKemAL3oghtggjBrYIRN+H5uV1Fk126d03QuTU1Iv+Q=;
	b=urYYnU30eHuNKKiuH0htw8PSoIq7T+SLb6x3Sgrv/nufRU+eIEGUzQB93sgKrR/AaJXwrp
	xEiPBbvuPmJhtOlMabuKgeoA9mcgxOZLUqEb4LiRmGWGvmnykFwJiSiuqF3AAHyndXrFQ/
	fFlQDq1FIigmSRA2NwAK4/TAHnJ+cGA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB5C81374A
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Mar 2025 19:58:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cdZBNYNc5GcNLgAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Mar 2025 19:58:59 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.14
Date: Wed, 26 Mar 2025 20:58:52 +0100
Message-ID: <20250326195854.23901-1-dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E62051F391
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi,

btrfs-progs version 6.14 have been released.

This is more of a bugfix release with a few feature updates or support for
upcoming kernel changes.

The recent security incident with compromised tj-actions/changed-files affected
the git repository, but with no real impact. The only branch that uses the
action is for devel branch and there was only one run in the critical time. The
leaked tokens were the internal ones of github that have a short lifetime.

Changelog:

* mkfs:
  * allow --sectorsize to be 2K for testing purposes of subpage mode (needs
    the same block size supported by kernel)
  * fix false error when no compression is requested and lzo is not compiled in
* convert: support 2K block size in the source filesystem
* defrag: new parameter -L/--level to specify compression levels (kernel 6.15),
  also supports the realtime levels
* subvol delete: show names of recursively deleted child subvolumes
* qgroup show: use sysfs to detect up to date consistency status
* zoned mode: support zone capacity tracking
* other:
  * CI new and updated workflows
  * documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.14
Python: https://pypi.org/project/btrfsutil/

