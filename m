Return-Path: <linux-btrfs+bounces-4668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644B68B972E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 11:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83303B23A8F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0D5025A;
	Thu,  2 May 2024 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="esy/Z0G5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CQ6KFfIJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4118535BF
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640904; cv=none; b=L7vXoI/U2aadlOAU22yYV8U+WtWRCJ8GYgtGkZFU7ReW2fIdBPE+Bo0swaf0F2Wp4Mj45jKtJlfPqQmEiXSJ+DW5GebWV2KmjL7GcaTFAkd84pqjWq3nBEbfhwNI9iW3XFK7PtpbJ/gK36CchgfDwT/Bmt14AtPIzKg6yzhPdWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640904; c=relaxed/simple;
	bh=YNxl+LD4rysdtMn350m04o3CtftIBeZ2LhHYg1VL9s8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1Y+PwNF87RrheKBW7g9TbMYXBYeSvN9tdiaJe0ojKoTDdzQh47dvLt59Q26cfpLNjGbXZNS+yzBV+2U3b/lDSc2zli/nP9y+3ObF6yhg7AzimxryWq5+JIgC4JnuA/AoHsRUzRyw41f1ODeFEv2TXivbbMYTfERE3i90L3pD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=esy/Z0G5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CQ6KFfIJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FB091FBBF
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 09:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714640900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GIq8464ohgwLlwW8ZpjOaHMUoqQNOB9WQtDtllgvqw=;
	b=esy/Z0G5pOHdOs1pbSlVp4qNGD9QQp2/+8WLg+APWSBFM+gv0ARMI5w6UtHP1JNRG2lxub
	6s4CFKPeWDL9t1SmA7EippjxxHXAhZCWO6J4+HTI3+ZbxxzxypWDm/g5BNA5q1iebMcZED
	eR6+XPvDYsREx9sRtAvfP/surJPy9e8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714640899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GIq8464ohgwLlwW8ZpjOaHMUoqQNOB9WQtDtllgvqw=;
	b=CQ6KFfIJ4J0VljD/6fdgEJSyuID9xsf+hhkp4X0qlVdNL4B6LCtv6XTWIt6UcwakHB2B0C
	c8Gl6aK159pHKvnofFyGo4vAu/v+D3HHPSRfqnDLqybGkTe6/fenVzhoJKn/XoA3ake5G1
	gUKadNLWjlOzlQTag8A2PYkQPtqHDqE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACE4C1386E
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 09:08:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yOr4FwJYM2ZZcAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 02 May 2024 09:08:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: tests/fsck: add test case for ram_bytes detection and repair
Date: Thu,  2 May 2024 18:37:55 +0930
Message-ID: <06aecdc98f472fad3f1d3a5558fe6985561191dc.1714640642.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1714640642.git.wqu@suse.com>
References: <cover.1714640642.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[4var:email,ckdt:email,8z:email,acrg:email,s:email,ywipn:email,ysv:email,yfpj:email,gii3gazzn1mrq2fyz2owm:email,dn:email,bwv:email,ayekn:email,74cc:email,o:email,c:email,suse.com:email];
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

The new test case would contain a file system image, with the following
file:

	item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
		generation 7 transid 8 size 16384 nbytes 16384
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 258 flags 0x0(none)
		atime 1714635006.328482575 (2024-05-02 17:00:06)
		ctime 1714635013.394980640 (2024-05-02 17:00:13)
		mtime 1714635013.394980640 (2024-05-02 17:00:13)
		otime 1714635006.328482575 (2024-05-02 17:00:06)
	item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
		index 2 namelen 4 name: file
	item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
		generation 7 type 1 (regular)
		extent data disk byte 13631488 nr 1048576
		extent data offset 0 nr 16384 ram 16384
		extent compression 0 (none)

Note the ram bytes, which should be 1048576.

Furthermore, the inode size is trucnated to 16K (originally 1M), so that
offset + num_bytes would still be no larger than ram_bytes.
So the only error is the mismatch between ram_bytes and disk_num_bytes
for the non-compressed data extent.

The image is hand crafted for now, as btrfs-corrupt-block doesn not yet
support corrupting the ram_bytes field.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../default.img.xz                               | Bin 0 -> 2076 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/062-noncompressed-ram-bytes-mismatch/default.img.xz

diff --git a/tests/fsck-tests/062-noncompressed-ram-bytes-mismatch/default.img.xz b/tests/fsck-tests/062-noncompressed-ram-bytes-mismatch/default.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..94a587a83e64a9d1981d8b74e313b4ff7e497c68
GIT binary patch
literal 2076
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
G1X)@Hrty6M

literal 0
HcmV?d00001

-- 
2.45.0


