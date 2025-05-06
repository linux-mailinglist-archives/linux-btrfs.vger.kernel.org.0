Return-Path: <linux-btrfs+bounces-13720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E5AAAC1FA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 13:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E54D3B0C5D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 11:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112C72798F0;
	Tue,  6 May 2025 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c9vJajQE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c9vJajQE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12627935A
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529471; cv=none; b=PUSY7NDGs5gJU1YfEaYrqIFbMpkldmlaSu6eq8kPzKjTaTWY+imx8ccoW2/+MCk0keB2kR7w4GdkSM0J67tUPCOjlIFYkaDGYAhUdFexiz2KHt0pmKET3maU8wv5WtAeCBb6QXv+0UMMELFc1hhzmkBGI6gf/ukF/iPqiaY19nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529471; c=relaxed/simple;
	bh=LPbF8fBB2EMkKDFV/2Tl1aeMsEFY8e+EON3JFW6KV6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEPthIlzHLg6fk8Y86io4coG/BdkTIaGPhDa5Di/c9R5Do66Ne4F6kEFtCTDgRebiCM4Ov1L2nvkSkglBF/67Vs4y3aYytyOjsa0HGUefgRiQaQREA4m0GzoS+IH3ohXbl/1Su5pIJTgrIk6q0FiEe8yRk2lHEfqiI42QUGhpyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c9vJajQE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c9vJajQE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 785591F393;
	Tue,  6 May 2025 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746529467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kDQsDeySolcygXRI9RSmfRp9PBgz5ruDxiG49cyB82o=;
	b=c9vJajQE35Rqzr6tvpiGglIRAm4g3E1rPc9SrJQBLVLnhOXBgE3goGgL3XZP9eWAw1nelc
	bRR5RmIJiw5PMMryy4LakalscT7NKSFsVjn6IHEYMojOVscf+y6mDbMrmIc8aBmnqZj6rs
	aVZmbjutgeV+x/jl82HnN1un2QjJVMY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=c9vJajQE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746529467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kDQsDeySolcygXRI9RSmfRp9PBgz5ruDxiG49cyB82o=;
	b=c9vJajQE35Rqzr6tvpiGglIRAm4g3E1rPc9SrJQBLVLnhOXBgE3goGgL3XZP9eWAw1nelc
	bRR5RmIJiw5PMMryy4LakalscT7NKSFsVjn6IHEYMojOVscf+y6mDbMrmIc8aBmnqZj6rs
	aVZmbjutgeV+x/jl82HnN1un2QjJVMY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7058C13687;
	Tue,  6 May 2025 11:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4RdoG7vsGWgwDwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 May 2025 11:04:27 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Update btrfs Kconfig
Date: Tue,  6 May 2025 13:04:24 +0200
Message-ID: <cover.1746529400.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 785591F393
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Update outdated information, expand option descriptions.

David Sterba (2):
  btrfs: update list of features built under experimental config
  btrfs: update Kconfig option descriptions

 fs/btrfs/Kconfig | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

-- 
2.49.0


