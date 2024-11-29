Return-Path: <linux-btrfs+bounces-9974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA319DEC86
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 20:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965B9161B11
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 19:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E63C1A2643;
	Fri, 29 Nov 2024 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V/TeIhZ2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V/TeIhZ2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC35914D430
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732909037; cv=none; b=bZO3iVUYZW6lor3A4xX+nUg5vE9+7HZFHHqgPXKjNg4MpCLg7WiWq0RmPFb6E/3B3D1fYhbVKlnBG9tHsg2XS4+yXTzGdcGDQrAHpSqteGHacoFwqfPE2ghZqT1nq8hVZyMM/E60EdVB6ey4WmisP2i+Mlob/g5FU1+Ti81jGOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732909037; c=relaxed/simple;
	bh=CE1w2lNeXlizFBtZnnPhXY9Fm6oDkrqRP9pgCym8KGw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sdMpy4Y6k+SEPuQDVDJEsloeoDL7YPY+XKcIJstCmXEY1m8UWOHpcJxbaAvnX15aImr6TaNmEO8NSyvHFESxtOecKZcmGhsnMYJvbpxhD862uGDSCywWBL4IpvA893rE/fe9czbeMLI2iRGnBsHY2CDxegrXmAUSuFEEdZ44z2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V/TeIhZ2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V/TeIhZ2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC1E721183
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 19:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732909033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dT/ogGax/vsX6pKDA4braux67mteNJr3xl1OjNzzsIc=;
	b=V/TeIhZ2hLZ+sAdNu48zfWxg6y4P/NJ7WvaZIDCJo5VPhc4/wX4mvd/C1TS/h+AOa1rtp7
	D6zvZ2dkVlMYi/YTt99su5RV37AKBLsjY91H0xAI9tWqv1DrHlQNA1BzOCMt/Cdibxuub6
	6SwGXUks0Ro8afnZ6c3oRvaTi8tSIBs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="V/TeIhZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732909033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dT/ogGax/vsX6pKDA4braux67mteNJr3xl1OjNzzsIc=;
	b=V/TeIhZ2hLZ+sAdNu48zfWxg6y4P/NJ7WvaZIDCJo5VPhc4/wX4mvd/C1TS/h+AOa1rtp7
	D6zvZ2dkVlMYi/YTt99su5RV37AKBLsjY91H0xAI9tWqv1DrHlQNA1BzOCMt/Cdibxuub6
	6SwGXUks0Ro8afnZ6c3oRvaTi8tSIBs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABE44137CF
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 19:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7dLyKekXSmd8EAAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 19:37:13 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.12
Date: Fri, 29 Nov 2024 20:37:02 +0100
Message-ID: <20241129193704.7991-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC1E721183
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

btrfs-progs version 6.12 have been released.

Changelog:

* subvolume delete: add new option to do recursive subvolume deletion (for
  regular user delete only accessible subvolumes)
* mkfs:
  * new option --subvol to create subvolumes in given paths, read-write,
    read-only and default
  * add hard link detection support for --rootdir option
* fixes:
  * receive: message verbosity fixes
  * check: fix false positive report of missing checksum for extent holes
  * check: handle compressed extents when checking tree log
  * when asking Y/N user questions, flush the terminal so the question is
    displayed (e.g. btrfstune -S)
* other
  * code refactoring, error handling
  * python packaging fixes
  * documentation updates
  * new tests

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.12

