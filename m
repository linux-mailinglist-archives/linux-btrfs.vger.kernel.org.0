Return-Path: <linux-btrfs+bounces-5567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B686900F6C
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 06:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5371C212C5
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 04:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48228134B1;
	Sat,  8 Jun 2024 04:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iKQyqap6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iKQyqap6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76531134AC
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 04:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717820037; cv=none; b=NMvV+UAmqNgOkYdWOb/tdYR9F+tp5xLFaM0eDfIEdX8y+ZDIALSQkD4VCXvgtwLwdoaGXGumvRE6fcm2463ytd8p7BTC+dUgnrTYphOui5zzqRhSwFFEU4+oIiRAoe6nnlQx9RDGwVKvYSBTguWO4Ymc2nn1NuiFLudr+RE65BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717820037; c=relaxed/simple;
	bh=3g0u5lo26Z4jxqwp0oAkVMO8RMiySmJnEc0DibUVpQ0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pcRRZQOQN3PwICmOYhgpwK/13JoS+RzFMuIOQP3Xx9o7P0OjMBmvrZmjWsFN5qztvspRE8dJssNoEzbaWJ3HzTltKBUAL98opHDVQNEPRAXBOKSTn4ZtA0apR7O0jOhn/BqlpWur554eZyS62jOZVrruF7bFMVbHt0/FArgB9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iKQyqap6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iKQyqap6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C33A21BA2
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 04:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717820033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xOlRICjCEQDQC61FVFhiggJzCYnqCB4ewuDyDAsdFfo=;
	b=iKQyqap6Lqv/CdhEydFzz52esY6ERGHiOaz99Or1jWApciXYvQlV75fzSnVr8XSHYCK1t8
	LcIqXXG9F3ewIs2xKHvtio9Q9H4Xibbagb2WGnZK241o9wMEMXU+nJNbwAwkJ27Pc0hLQX
	ZflmoRrxYoVhF1IupP4bCyJla9HEe4U=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717820033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xOlRICjCEQDQC61FVFhiggJzCYnqCB4ewuDyDAsdFfo=;
	b=iKQyqap6Lqv/CdhEydFzz52esY6ERGHiOaz99Or1jWApciXYvQlV75fzSnVr8XSHYCK1t8
	LcIqXXG9F3ewIs2xKHvtio9Q9H4Xibbagb2WGnZK241o9wMEMXU+nJNbwAwkJ27Pc0hLQX
	ZflmoRrxYoVhF1IupP4bCyJla9HEe4U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D14713A1E
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 04:13:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Noc7DIDaY2Z6cAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 08 Jun 2024 04:13:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: fix the conflicting super flags
Date: Sat,  8 Jun 2024 13:43:23 +0930
Message-ID: <cover.1717819918.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.52 / 50.00];
	BAYES_HAM(-2.72)[98.78%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Score: -2.52
X-Spam-Flag: NO

There is a github issue that a canceled csum conversion leaves a
CHANGING_FSID_V2 flag, which turns out to be conflicting super flags
(CHANGING_FSID_V2 and CHANGING_DATA_CSUM).

Fix the problem and output all supported flags for print-tree.

Qu Wenruo (2):
  btrfs-progs: fix the conflicting super flags
  btrfs-progs: print-tree: handle all supported flags

 kernel-shared/ctree.h           | 10 ----------
 kernel-shared/print-tree.c      | 35 ++++++++++++++++++---------------
 kernel-shared/uapi/btrfs_tree.h |  8 ++++++++
 3 files changed, 27 insertions(+), 26 deletions(-)

--
2.45.2


