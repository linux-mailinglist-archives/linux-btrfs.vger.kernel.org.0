Return-Path: <linux-btrfs+bounces-12802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0063EA7C32D
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 20:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CADB189DA59
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DBF20E33E;
	Fri,  4 Apr 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="azqio0kk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="azqio0kk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6611494A6
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790780; cv=none; b=mmYXAA0iS+3NppFnFYNZPJ857YAPV9rCBasX6eeun3INf3bonLDi7AHZYbL+kIABgjEe+fMLl0dWsIyFpvc1+AbBGq45TV93smHX2Wct77KWqw7zf1NISjg6pWLyug/ZQqIbiOA0bbodHBMXlltp2CPunDfHLzOrP3+X+sh0jcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790780; c=relaxed/simple;
	bh=fxON47+4C5fWNQ85alS+YxjmDyBWPxjQwUUlt5tvEwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpenJe5O4ybMz5tQYkbl7LfmdB9Xd9SbT4TRSbIaP0a6jgEbDmNPreqn+bV/AsFKg0W1os/3NyvMQ0zYs5vv7GAxF6YPxdARnqNeBRyAA5oa5cmjBPJ8a3cQ/R8jDNP3B9roKVidkf1o50F5q/T5eCsHqHcEWU6V/BjirvDAxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=azqio0kk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=azqio0kk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A2681F38F;
	Fri,  4 Apr 2025 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743790776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rlnYsP2nMgbLaNtlRGBD8FYgw2uqSFEpX/G1w473nbA=;
	b=azqio0kkcwihM5QO3iSRq5we/rZ0SXr0HDYMSu7dInn5eipsonaqZ4PCwzaCcMcDeRp4bw
	pNqcLcPAegYaM6Di+g374eq7bpTp8TzptOaC7e5l0cXl+gfeTHmLeGnOhr5O1XauOlIxX+
	1o9fbCqtLjXZIgEw+x/HynEPSQlz2k0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=azqio0kk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743790776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rlnYsP2nMgbLaNtlRGBD8FYgw2uqSFEpX/G1w473nbA=;
	b=azqio0kkcwihM5QO3iSRq5we/rZ0SXr0HDYMSu7dInn5eipsonaqZ4PCwzaCcMcDeRp4bw
	pNqcLcPAegYaM6Di+g374eq7bpTp8TzptOaC7e5l0cXl+gfeTHmLeGnOhr5O1XauOlIxX+
	1o9fbCqtLjXZIgEw+x/HynEPSQlz2k0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FDE11364F;
	Fri,  4 Apr 2025 18:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FtHyHrgi8GelLwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 04 Apr 2025 18:19:36 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Tree-checker unlikely annotations, error code updates
Date: Fri,  4 Apr 2025 20:19:29 +0200
Message-ID: <cover.1743790644.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8A2681F38F
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
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

David Sterba (2):
  btrfs: tree-checker: more unlikely annotations
  btrfs: tree-checker: adjust error code for header level check

 fs/btrfs/tree-checker.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.47.1


