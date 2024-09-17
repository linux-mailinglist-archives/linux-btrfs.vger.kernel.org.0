Return-Path: <linux-btrfs+bounces-8083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F070897B1DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 17:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E451F225FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65E11A01C8;
	Tue, 17 Sep 2024 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tXTgKC9k";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tXTgKC9k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63131A01BC
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585539; cv=none; b=PB+2QwRtcXzflHvE3hQgMQBzsE8r+CQNzfg6/hjTYw+8QoTtNjh+bhLIwcFd13Np2PNxT8HTua6UYktBFH1xTOynV2Lz7ARAswi3jHCA5M4nzmIKGgMsabJMCJU8QLsnvkjLzJELt0EY/M33Q1Vthv75nz18C47mzqeMaLKu5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585539; c=relaxed/simple;
	bh=fgvuAm2SSKQei4x9vVjAp+kjsjv9umVj8TsswrgyjKk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RWAT6KPfso/VnfaJH90Xq+XCgLxiLwBM65iqRMr6fIhS62h4q3xRBwW5Eiks8NdOqZMBLFWLJm5n0f1F+F4JbXuAW9y+hSaBsEEOp2pCKGM94/xe0NxSUEBM/fhxYdfKzJqzNaw9Bgyw5B+NaMv5Kca5ZM4z31fMytwBgQtccVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tXTgKC9k; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tXTgKC9k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A049200CF
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726585526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ARAcc4XE0PLWiR2sLmm+5JsrX0zfvTH/58qdaJKbATc=;
	b=tXTgKC9kKXugnGrWIdDAMNhagu6VfdLmimpo8zNgPm4EnaMcfdMr9lAy2MbY8WhnNPC7E8
	vOivXJlnIBLFAyjsPwF8cCU+wyA9z7DXhttlxeZ6cVIktxcXSLP/OxxAtulXzdLLhCx+eb
	v9azxGqIaMXYdAdX3g6OADsNZp64iYU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726585526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ARAcc4XE0PLWiR2sLmm+5JsrX0zfvTH/58qdaJKbATc=;
	b=tXTgKC9kKXugnGrWIdDAMNhagu6VfdLmimpo8zNgPm4EnaMcfdMr9lAy2MbY8WhnNPC7E8
	vOivXJlnIBLFAyjsPwF8cCU+wyA9z7DXhttlxeZ6cVIktxcXSLP/OxxAtulXzdLLhCx+eb
	v9azxGqIaMXYdAdX3g6OADsNZp64iYU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93134139CE
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 15:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eQXjI7aa6WagTQAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 15:05:26 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.11
Date: Tue, 17 Sep 2024 17:05:23 +0200
Message-ID: <20240917150526.29109-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

btrfs-progs version 6.11 have been released.  There are mostly bugfixes and
some small improvements.

Changelog:

* check:
   * check items in tree-log
   * detect invalid file extent items for symlinks
   * properly detect inode cache and suggest removal by 'clear-ino-cache'
* convert: fix symlink length checks
* fi show: remove stray newline at the end of the output
* fixes:
   * open devices in write-exclusive mode in most commands, prevent
     concurrent mount by other programs
   * rescue clear-ino-cache: fix subvolume iteration that can fail in some cases
   * map-logical: fix first extent searching condition
   * fi resize: warn if new size is below 256M
* tree-checker:
   * slightly stricter file type validation
   * verify device extent items
* other:
   * documentation updates
   * ship btrfs-ioctl manual page (incomplete)

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.11

