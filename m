Return-Path: <linux-btrfs+bounces-7215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A135D95399F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 20:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5FB1F253EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 18:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633FD46444;
	Thu, 15 Aug 2024 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t+ghFo53";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t+ghFo53"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC615CB
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745233; cv=none; b=BHlMTcrB1WwRNB81AooSRgXdFkDSU+CZWVLBElRAGG17DNGrQIkqW4PDAFvGMKLivwLb2fLYeZNmfG8LVifPkNHoWFezKhRZHLY8l5WHrA2av4xbSR1hRMzcVYvJgl0Hhw4cj0/dqhTUhXC9WGacOJY9OEbzkiA97C9agHUwly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745233; c=relaxed/simple;
	bh=ubreYoCnuwrhd4yuYetcX4QdT5k+dT8WK+s8IXzbXk0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VQo0IKL8rmI9uT8ktdYMUHhfG3pj2v0n0NWXdIjUvyhmHGjdBOpu4a/Iz8moly4+LwiJ1SbdLMww7ea8EpHlzsG8PHbjy4O6uZNMYxo2bB8tq8l5xRl/OsoW1ukd5LBi/iI9mw0CHVjJVScgtKpYWc0pSNW3Ri5RtvLQL/GWL/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t+ghFo53; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t+ghFo53; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9717C21179
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723745229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mhorOLfIAQYxRkcLgi6zPEg4MpIe9QDS2xCZG0Ucgjk=;
	b=t+ghFo53wjmrQgJK09XfaBo6K27ihNZdNfSaXAJ3HYdNt60PTI4BAOF4NiYPZiU8xISYMK
	U50/3auagYOFL9NUGCq1W/lZOtJGQUB7fORZkZDuoRaBm3KTXUtTrL6DgLsaJdKPUwuWX2
	osFJepNiFruRwxGG7THr6OYfxN+kC9E=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723745229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mhorOLfIAQYxRkcLgi6zPEg4MpIe9QDS2xCZG0Ucgjk=;
	b=t+ghFo53wjmrQgJK09XfaBo6K27ihNZdNfSaXAJ3HYdNt60PTI4BAOF4NiYPZiU8xISYMK
	U50/3auagYOFL9NUGCq1W/lZOtJGQUB7fORZkZDuoRaBm3KTXUtTrL6DgLsaJdKPUwuWX2
	osFJepNiFruRwxGG7THr6OYfxN+kC9E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 905001342D
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 18:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r8M5I81Dvmb7OgAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 18:07:09 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.10.1
Date: Thu, 15 Aug 2024 20:07:06 +0200
Message-ID: <20240815180707.13722-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Hi,

btrfs-progs version 6.10.1 have been released. This is a bugfix release.

Changelog:

  * mkfs: rework --rootdir traversal, skip hardlinks and create new inodes
    instead, also warn about them, this did not work as expected and will be
    fixed in the future
  * receive: search in older trees for UUIDs when detecting clone sources
  * libbtrfsutil: bindings available at https://pypi.org/project/btrfsutil
  * libbtrfs:
    * patchlevel version update 0.1.4
    * cleanup in headers, removed unused definitions, no functional changes
    * don't ship list.h and rbtree.h
  * other: documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.10.1

