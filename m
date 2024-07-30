Return-Path: <linux-btrfs+bounces-6894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256C6941F46
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 20:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C2A1F24BB2
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 18:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07AC18A6B7;
	Tue, 30 Jul 2024 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kDCMEjN+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kDCMEjN+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2A633999
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363112; cv=none; b=tvMiX9r3ZQaAn/BrL3hOwUyi/HN8VExDiqYEEB5QI43LnixOY6BPPkHRIYlPy/2wd0e4wqZSndZYMpkFg1PQqbTbdBHY7/orJrZCuOf8idPnL73deiDfHymAv9b0rnAT8V8rBiPYxF1ODcuxRTRUJHljDLeNGie1MpUOCJ8BMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363112; c=relaxed/simple;
	bh=Oo/Eodg2Rh9dItguGgyAU1oJ4QeNTEC61je0eLEYwDY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OPgnaFe7Oe5xUBc5gDnubmTkDLgrbYeKRrRwnfyvXuDmo5p9Cb1X6jGE3M8msxQaho+i2xpJXiULlLcj65JJSMKG+1XT0VwSALWmImUxnakuAQ9auSdDpgnp995KjMxqB45AlJJveBk/GMP+pb5ijRH8pWyHyHkJyTJpD+0LeVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kDCMEjN+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kDCMEjN+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1586721A65
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 18:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722363109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3zioxr6CZRVQyvCVEmEpeE+0QZKk2Qk8qCGRnOE9wws=;
	b=kDCMEjN+JeIVVenB5zVuLhg3wngqd9f2dd6bwN+aKZZaNitW9pG4PpM0hdo1mi8UKYyT7n
	x4FV655CdI0WfBJuVJHFi95vuHW47B+2V/r1KD43/mRuTSdz/GLWtBx29aX3EHvNC9ImfC
	a4Ldvcym/YQFRD1Tu85GSi/PiKgEpe0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kDCMEjN+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722363109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3zioxr6CZRVQyvCVEmEpeE+0QZKk2Qk8qCGRnOE9wws=;
	b=kDCMEjN+JeIVVenB5zVuLhg3wngqd9f2dd6bwN+aKZZaNitW9pG4PpM0hdo1mi8UKYyT7n
	x4FV655CdI0WfBJuVJHFi95vuHW47B+2V/r1KD43/mRuTSdz/GLWtBx29aX3EHvNC9ImfC
	a4Ldvcym/YQFRD1Tu85GSi/PiKgEpe0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F54C13297
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 18:11:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YMi6A+UsqWaOLAAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 18:11:49 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.10
Date: Tue, 30 Jul 2024 20:11:43 +0200
Message-ID: <20240730181146.12586-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1586721A65
X-Spam-Score: -2.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

Hi,

btrfs-progs version 6.10 have been released.

Changelog:

* inspect:
  * list-chunks: new command to print information about chunks (i.e.
    the physical chunks as stored on devices), sortable; requires root as
    it's using SEARCH_TREE ioctl
  * tree-stats:
     * new option -t to print only the given tree
     * add long options for size units
* filesystem df: with increased verbosity print per-type information from sysfs
* version: print a line with built-in features or options (+FEATURE1 -FEATURE2)
* image: document option -s and its potential problems
* fixes:
   * scrub status: user selected base for Rate values
   * receive: escape special characters in paths and xattrs
   * dump-tree: escape special characters in paths and xattrs
   * image: sanitizing filenames did not work properly in all cases
   * convert: fix displayed restored image path on rollback
   * tune change csum: do conversion in smaller batches
* other:
   * CI workflows updates (sanitizers, code spelling, manual page preview)
   * build fixes for uClibc
   * build fix for python 3.13
   * documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.10

