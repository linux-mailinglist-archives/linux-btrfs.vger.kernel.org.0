Return-Path: <linux-btrfs+bounces-14873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03585AE475D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 16:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EF63B981D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 14:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547426C3A8;
	Mon, 23 Jun 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MFNAxkfp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MFNAxkfp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0526AABE
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690028; cv=none; b=RrzxhkwiEnfLDt5OjzLuoQnJT8qIIYcZNRN2XKczlJ/smI5ZUf2UC/qzuFLb4Nd85uRYKTI5E7TE4+trEH633XYTeP2JuAiyS4yv8/tDP3dJPv7q7g3TTlFp+CCH/zzI6SoT+AA0/S7IUF3pwoPhNoKHYsVSd9iAPtFbO8jI9JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690028; c=relaxed/simple;
	bh=GqjC82RK+Lx3wJNYSQeNc1/VXngMXJ00N8A8qsKARxE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jCeuxzy3bQDMWL0xE0Xcxry/PCpo671qZ3co06zYdXFIGN6svSxTacicsSrJwYANesWPa6hbEO+j1cXDwLPUGccFF5fWmIhsL17nNlu4B8QfGhweMSs1gXGPbqO4Cl208S8228Q2OjgPkTHPULDq8Has6F47pKdyAOGrxlzq6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MFNAxkfp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MFNAxkfp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDAED2116C
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750690023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vJ8YqNRKcWxCxKQAh6sSuYfud19ufk5HU4ioC1AMLvU=;
	b=MFNAxkfpLNrpwXlO2aeAKT3hbKgMq/dUE4fyTaOHvXg3pN2t8SN9qM06njYZwOK/z8rmTs
	wudVDtUx3CDsQU1raqfIMUw1DNUcR4Ts6OCjCtI4PNlJ0g+/R0Yed4QEbe55srAXgWt4vn
	TsirdYRyi+HBYO+hodEIik52lALV2Ro=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750690023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vJ8YqNRKcWxCxKQAh6sSuYfud19ufk5HU4ioC1AMLvU=;
	b=MFNAxkfpLNrpwXlO2aeAKT3hbKgMq/dUE4fyTaOHvXg3pN2t8SN9qM06njYZwOK/z8rmTs
	wudVDtUx3CDsQU1raqfIMUw1DNUcR4Ts6OCjCtI4PNlJ0g+/R0Yed4QEbe55srAXgWt4vn
	TsirdYRyi+HBYO+hodEIik52lALV2Ro=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C388113485
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 14:47:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NhJhL+doWWiDbgAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 14:47:03 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.15
Date: Mon, 23 Jun 2025 16:46:58 +0200
Message-ID: <20250623144659.26266-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi,

btrfs-progs version 6.15 have been released.

This is more of a bugfix release with a few feature updates.

Changelog:

  * mkfs: new option --inode-flags to specify flags/attributes for
    inodes/directories/subvolumes
  * check:
    * fix false alert on missing checksum for hole
    * in lowmem mode, fix false alerts when checking refs
  * convert: check feature compatibility when enabling block-group-tree
  * tune convert-bgt: fix resume of conversion
  * rescue: add new command fix-data-checksum, selectively fix or find
    mismatching checksums
  * other:
    * new and updated tests
    * documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.15
Python: https://pypi.org/project/btrfsutil/

