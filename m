Return-Path: <linux-btrfs+bounces-19274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC22C7E9B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 00:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CABFE341B6B
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Nov 2025 23:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5149925C838;
	Sun, 23 Nov 2025 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GbsBfxnp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qxSMGy+p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B722A4F1
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940774; cv=none; b=fkWyxXuMZ/bxKBb3pXesgeccU5X9yQ+TNU0psj3ormWl944XqleOMditHxANhunsY6f0e03FRCFA6jHxSYLOcyGv5VldV5nZ4S/r+jFdaZTzVFjlrnLSW7sCcyA4Eu6HmUYC+PTRNl+OxLLsVaWWzUK6xmj2IpcZPPl0Xm9Rffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940774; c=relaxed/simple;
	bh=9olXxianGD+5QV62KYt/tz0t8tV2z3953N3R7uRnXss=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Wr71EDuvJokhbYlp9vAe1Gsreti7HB37PCUVBCtgcTJDyun6NHHF926NZjH0e3IKDIXynYjNldqH8nm43bJflLlqhQ/WCW2OGyMpQE8lfbresq+jC+WuqYCO1tz/wv+uL4us8aKxabbJgYdYEdmKCvW5PXwcyVBXgvYYRuyuyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GbsBfxnp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qxSMGy+p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EFFD421D5A
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763940765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yRp+RZXs28oRCwVTkTeatEIehmH1KqZbSp9Aypt9Ujw=;
	b=GbsBfxnp57g9Ucat9ThLIKT3mNCkYaDxUdg+RyYX2azU5D+oph6lR2izT4nlOaOZIPTOH5
	HLULMQc+1vBjCA2FdFnVL31Emzn+WZOH7ipfHHAnB9EQ+r3hHL+00zJl3OMG75NfrmkUjZ
	q3t+c9kPDYckLs9tx6TYqB0YlkSREoM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763940764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yRp+RZXs28oRCwVTkTeatEIehmH1KqZbSp9Aypt9Ujw=;
	b=qxSMGy+pJQWZsV54GcVKSVnAENWBzoDCAdu2lVmlnGz3NC/LdpsJ5YLi/2ov/ps46XRDFd
	cijW6AQh08ffJJb/1odpKMlf/3pEKzwIAPsW201xUSdFJmb8HQs4qvkc8yA81Y4r7N4qxx
	WpT7gEV54ONzzMh8vsqI3qswrAgTFBo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3538E3EA61
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JTHDOZuZI2kGRQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: always return the largest hole possible for btrfs_get_extent()
Date: Mon, 24 Nov 2025 10:02:23 +1030
Message-ID: <cover.1763939785.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
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
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

When looking in the call sites of btrfs_get_extent(), I didn't really
see the need of @len parameter, as normally btrfs_get_extent() would
just return the hole or the regular file extent covering @start.

And it turns out that @len is not really that much used in
btrfs_get_extent().

If we find a regular/inline/prealloc file extent, we just return the
full extent map from that file extent.

It's only for implied holes (aka, NO-HOLES feature where there is no
explicit file extent item for a hole) that @len makes a difference.

But in that case, we can simply return the largest hole possible (either
the range between two file extents, or for beyond EOF cases return hole
covering the largest possible file size).

Patch 1 is removing a hole size truncation, which in theory can benefit
readahead on a large hole (no extra tree search for the hole again and
again).

Patch 2 is a refactor to remove a weird code pattern.

Patch 3 is to make beyond EOF cases to return the largest hole possible
(covering the max file size), so that we won't really utilize @len for
hole extent map creation.

Qu Wenruo (3):
  btrfs: return the largest hole between two file extent items
  btrfs: refactor hole cases of btrfs_get_extent()
  btrfs: return the largest possible hole for EOF cases

 fs/btrfs/inode.c | 66 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 21 deletions(-)

-- 
2.52.0


