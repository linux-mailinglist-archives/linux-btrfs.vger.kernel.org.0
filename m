Return-Path: <linux-btrfs+bounces-13557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4114AAA51E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 18:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87A21C05F46
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 16:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9F121D59C;
	Wed, 30 Apr 2025 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qM66mEnq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qM66mEnq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E7366
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031531; cv=none; b=kqbUZ06ibWeId+ecJqcSlE9q3wIoel9B11FRgiD5XFT5hvIQhW3Uv32TksovvKhrTV0hFtERtwhixVVt/CaLUEZAmj+/8wHFFqefMLurg+vcw77K2wtsCAmIx11Po7gT5/L9QmvjZVYjZNLa07Nhu0meuj9AQ//eYQSGUyI7mXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031531; c=relaxed/simple;
	bh=L+LVS31gs8HTBbM8gQPUeglh+skEqxEjuXBboF847Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETiDtSrh3sk196fpDqIg+Dd4reFuQVyyKeZYn/C5MIE3RCBvXVo9ljZR8QXWrE47Evl5Tmd2+J8Ybl6qo5Hz26MlKHIRFlcrKYr5u6YkcIWQTRD2qVoBXrSVB7Q2Pst4I7pR4vg2+JZm0YSQFaGEiEZI1F1hL0J/lBwT6+8wysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qM66mEnq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qM66mEnq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A20E1F390;
	Wed, 30 Apr 2025 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746031527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SmUGWQyKtoDX4PPXdiY/T7++4OxulcLLQk6wC+5SKV0=;
	b=qM66mEnqDd1CEnzKs99/qh5TbFCcWZHO250lekUaq/PQyYMEdH3GdZlJtDHxc5/6nbMfAE
	LcZ2H61wIMV+61yN2uyjvyie4qgvo+wKz+ksMgMeHuWmxaad4b1Hewl6vmxNZQtPbDeSHr
	UBpTDNOSk1LgiuxPoMQnjLtK83MbBW4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qM66mEnq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746031527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SmUGWQyKtoDX4PPXdiY/T7++4OxulcLLQk6wC+5SKV0=;
	b=qM66mEnqDd1CEnzKs99/qh5TbFCcWZHO250lekUaq/PQyYMEdH3GdZlJtDHxc5/6nbMfAE
	LcZ2H61wIMV+61yN2uyjvyie4qgvo+wKz+ksMgMeHuWmxaad4b1Hewl6vmxNZQtPbDeSHr
	UBpTDNOSk1LgiuxPoMQnjLtK83MbBW4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03B30139E7;
	Wed, 30 Apr 2025 16:45:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wBujAKdTEmi+MgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 30 Apr 2025 16:45:27 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/4] Transaction aborts in free-space-tree.c
Date: Wed, 30 Apr 2025 18:45:17 +0200
Message-ID: <cover.1746031378.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0A20E1F390
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Fix the transaction abort pattern in free-space-tree, it's been there
from the beginning and not conforming to the pattern we use elsewhere.

David Sterba (4):
  btrfs: move transaction aborts to the error site in
    convert_free_space_to_bitmaps()
  btrfs: move transaction aborts to the error site in
    convert_free_space_to_extents()
  btrfs: move transaction aborts to the error site in
    remove_from_free_space_tree()
  btrfs: move transaction aborts to the error site in
    add_to_free_space_tree()

 fs/btrfs/free-space-tree.c | 48 +++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 16 deletions(-)

-- 
2.49.0


