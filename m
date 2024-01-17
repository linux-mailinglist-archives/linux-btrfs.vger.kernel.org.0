Return-Path: <linux-btrfs+bounces-1523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F0E830BB6
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 18:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA967B20F64
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39068225DC;
	Wed, 17 Jan 2024 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LnBso4Jf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Pi/M9bny"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86068224DC
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511438; cv=none; b=hg4bogq3KsW31LavzgrwYBtFJA102Un1Uqqqxs71nvr78wOXAxyK/aRLO/CUBUIPERxcXbSj1sN9obk25fCUaeub2DzKcgC3auMN/u1QEkxT5cyCritwGP9sVdYD0fhfBeOHK5mGdXK2ijYjATh+Qd0ycNhWWtgMRahCSzv6B/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511438; c=relaxed/simple;
	bh=JiINEw85gpG6c/simSOGb7AAJjHjmeGdzL0BB9RU1yg=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Level:X-Spam-Score:X-Spamd-Result:
	 X-Spam-Flag; b=BzP5v69XQWdo6X4ANNEX5ft64VoR7Zz497eOCzBcxTUOy/R8k+iDz6Xlu7897QjUBGLvpush+QVanZEjrOlsCiJdi4AdUx5fC4RuaoE7yuziTLjvFdtgXg+/sEuunhGZtHPpK73GKS0J0wEjjjKL/Z6myo1qXmafes6uj9wf1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LnBso4Jf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Pi/M9bny; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A349A1FCDA;
	Wed, 17 Jan 2024 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705511434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TbKlE1viiynqlPJuTtTrWnwxbitUeuGL9jpMys6sIrM=;
	b=LnBso4Jf0wR8xHxkC94ZJ/Ci8JRfAn1CuTyY0eNiwYresd2wBsv2OvCOh1AU0ISiAkhi7Q
	20qi8IDgaSYxVECXpyfybuFFiFvlD/PR6DGRjN9D1AOEQobVRp5xFjuscVerQlmaOCGIt+
	NsFEicKu3vB/QwVwDvxQGbrBgW0/ifc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705511432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TbKlE1viiynqlPJuTtTrWnwxbitUeuGL9jpMys6sIrM=;
	b=Pi/M9bnyWMZqH+AQeKt+FK1RID68xeVUVuFs6ahSgoWYW49g1nct8Saz6dZttJkfMa/Y7c
	mJJ7Qe/jS6CCvQ4X4ZLQWraTopq44cDuYw9frVXNNWdLsgetAiFvWqQMGe26a4oxfWFNQQ
	rQOfSvAI0MrN5DmQ2TU/1KcRJf8QwiI=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 99FB913482;
	Wed, 17 Jan 2024 17:10:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id FT4bJQgKqGU0UwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Wed, 17 Jan 2024 17:10:32 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Block size helper cleanups
Date: Wed, 17 Jan 2024 18:10:13 +0100
Message-ID: <cover.1705511340.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.16%]
X-Spam-Flag: NO

Unify using fs_info::sectorsize for inode or superblock.

David Sterba (2):
  btrfs: replace sb::s_blocksize by fs_info::sectorsize
  btrfs: replace i_blocksize by fs_info::sectorsize

 fs/btrfs/disk-io.c   | 2 ++
 fs/btrfs/extent_io.c | 4 ++--
 fs/btrfs/file.c      | 4 ++--
 fs/btrfs/inode.c     | 2 +-
 fs/btrfs/ioctl.c     | 2 +-
 fs/btrfs/reflink.c   | 6 +++---
 fs/btrfs/send.c      | 2 +-
 fs/btrfs/super.c     | 2 +-
 8 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.42.1


