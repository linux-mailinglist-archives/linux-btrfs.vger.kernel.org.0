Return-Path: <linux-btrfs+bounces-5560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5669009C6
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 17:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32EF287E76
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E916199EAB;
	Fri,  7 Jun 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jjNKR9m6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jjNKR9m6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D9194AD1
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775971; cv=none; b=SBeDugEDBYmeop6zWdWha65ZYQVDR6FGVkSDOHFqMDQlKQ0d99SPbLPP3Oh0tduNTdcOM8nyx+JqlOOSKFvfMgduKS0pyDMYjquq8olxktcTx0BoukWS+bj/BrjeKh5pjdJr9DoUFEvdSYBRTFFHis5nsybHAg4VBjv+iWHUGOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775971; c=relaxed/simple;
	bh=4C6EZa5jgxXknefjSQMQT/H87kTcqmqG0HW5/7ulqTE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a3AUYDyyRAMc1lG5jihN7Ye0UepsuamnsoqPFCcBLHR8P66JUHUiEpJfBQs2zk93FMkD4zBDEuuPwUmd9GbJK5jY/xFz15yDxOpMx/yGehH0tQr0Zq/UBG6NutGUlCKG51RvpuGpjToixtDsNbL+Rlc9DEDeQdzWJzmyngFHAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jjNKR9m6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jjNKR9m6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 405571FBA4
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 15:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717775962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oWoVXKcxYus2suMfVK4T8fpBxSud4szr5o4d2bXF1VM=;
	b=jjNKR9m6uW625G4mqXgZ+hoFfzUd5OwN5nDUUmPQO6C/VGRGQjo3ioObiML+kmw5bE1+NW
	p4RyVIAkdUtZfpL+u52Ylrpypetk8scEkYsUc1iFV8KSZtjLDccs1UtZMy/r2d6Qn+i/aB
	xYgI8aRROZaX+DF4y+OAvS6Dv5jVkxQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717775962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oWoVXKcxYus2suMfVK4T8fpBxSud4szr5o4d2bXF1VM=;
	b=jjNKR9m6uW625G4mqXgZ+hoFfzUd5OwN5nDUUmPQO6C/VGRGQjo3ioObiML+kmw5bE1+NW
	p4RyVIAkdUtZfpL+u52Ylrpypetk8scEkYsUc1iFV8KSZtjLDccs1UtZMy/r2d6Qn+i/aB
	xYgI8aRROZaX+DF4y+OAvS6Dv5jVkxQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A531133F3
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 15:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xjs4DlouY2bjJwAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 07 Jun 2024 15:59:22 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.9
Date: Fri,  7 Jun 2024 17:59:20 +0200
Message-ID: <20240607155922.14362-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi,

btrfs-progs version 6.9 have been released.

Mostly bug fixes, libraries have been updated and are backward compatible.

Changelog:

   * mkfs:
      * if --force used, don't continue if the mount status cannot be
        determined (e.g. due to permissions)
      * fix minimum size calculation on zoned devices, make it work with option -b
   * check:
      * option --clear-ino-cache removed (functionality still provided in
        'rescue' command group)
      * detect and repair wrong file extent item ram_bytes value
   * qgroup clear-stale:
      * sync the filesystem before search to read the up to date state
      * handle cases where qgroup cannot be deleted due to uncleaned subvolume
        or when squota is enabled
   * qgroup show: display status of qgroup regarding the cleaning of the
     subvolume or if it's squota
   * receive: fix stream parsing on strict alignment hosts (e.g. ARM v5 or v6)
   * tune change-csum: fix check of dev-replace status item, continue if no
     dev-replace in progress
   * dump-tree: print contents of dev-replace status item
   * convert: fix extent iteration to handle prealloc/unwritten extents
   * libbtrfsutil:
      * patchlevel version update 1.3.1
      * fix potentially unaligned access to send stream
      * create library links to all version levels
   * libbtrfs:
      * patchlevel version update 0.1.3
      * fix potentially unaligned access to send stream
      * create library links to all version levels
   * build:
      * fix compatibility with e2fsprogs 1.47.1
      * fix header file dependency tracking
      * -O2 by default
   * other:
      * new and updated tests
      * ASAN and UBSAN test coverage in CI
      * documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.9

