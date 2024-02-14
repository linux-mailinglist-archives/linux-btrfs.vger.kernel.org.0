Return-Path: <linux-btrfs+bounces-2370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C61854322
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 07:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD3828253D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 06:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264AE125AF;
	Wed, 14 Feb 2024 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gh++/dqO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gh++/dqO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44971125A1
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893829; cv=none; b=Tqshqc19xKMVb/MDqxgasQtQ4Kw0Pwfday2IeURXJAcSlynyKyUK/71ZpHMxvkyN5+2HeS4qkgpYnid4iCPxZY/d9pkdFQrrYqH+dmKbGzk6CpHmuE7K/1AN7s9Jfir23MB2G6Vhtpsj6rjM48iCye7CZeYDNaZBsqLH+7l96fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893829; c=relaxed/simple;
	bh=6Rz77czUeNMW2SpD+M2aiuCd2lWpNGo13ZILzIqG2Xs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QHUaWHWajV1rYToWQR4knZQCuRK25py5mZwBR5+4vsVyGcfyu9aqbW7/xnB6uDWGM4KfrFJV4d/i8TxxxVI4HTIxnF5MLq2ZVnaP1JxiK49OsT2mhPke7cW3KxQ20rOFoaFqcsgZqNCc8WDnthyd551tnMJcLcCS+1HtZ1N60fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gh++/dqO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gh++/dqO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4769221F18
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707893825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SjCymYBC+Poa7vHHUygwx6JT29u8e0qQWrroKfS5BHQ=;
	b=gh++/dqOYBJEvop02G+mBFwBLk68FSFcmiDL5lSdULr0KxFcjvdvMWw2j/cCrtMEtCvV9L
	hhFUF0NlAOjcIJCIh/lUSCn8HUvbc7J2BI2J/b0Zp8NayL86I08in+xUqT8+dRmA+Fdd5o
	mc4PHE6FWw6oTdx3UmNGBbCCjYIDxyk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707893825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SjCymYBC+Poa7vHHUygwx6JT29u8e0qQWrroKfS5BHQ=;
	b=gh++/dqOYBJEvop02G+mBFwBLk68FSFcmiDL5lSdULr0KxFcjvdvMWw2j/cCrtMEtCvV9L
	hhFUF0NlAOjcIJCIh/lUSCn8HUvbc7J2BI2J/b0Zp8NayL86I08in+xUqT8+dRmA+Fdd5o
	mc4PHE6FWw6oTdx3UmNGBbCCjYIDxyk=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F40613A0B
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 06:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vwZsD0FkzGViKAAAn2gu4w
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 06:57:05 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.7.1
Date: Wed, 14 Feb 2024 07:56:29 +0100
Message-ID: <20240214065632.26487-1-dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="gh++/dqO"
X-Spamd-Result: default: False [1.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[48.46%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.18
X-Rspamd-Queue-Id: 4769221F18
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

Hi,

btrfs-progs version 6.7.1 have been released. This is a bugfix release.

You may note a change on the RTD site that some links got fixed and no longer
point to a document that is included to multiple sources. Eg. the link to
'Typical use cases' on page btrfs-device.html stays there, previously it ended
up in ch-volume-management-intro.html (the same section is also on the Volume
management page). If you find other broken links or formatting bugs, please
report them.

Changelog:
   * convert: raid-stripe-tree can be now enabled for the target filesystem
   * mkfs:
      * handle lifetime of open file descriptors so it does not trigger udev
        that could miss to create the UUID symlinks in /dev
      * update warning when CPU page size does not match sector size
      * merge features in summary, no more distinction of incompat and runtime
        to match the semantics of option -O
   * fi show: fix recognizing raw device mapper paths
   * other:
      * CI updates, build images updates
      * minor cleanups
      * minor sync with kernel
      * documentation updates, fix links to labels in included directories

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.7.1

