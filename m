Return-Path: <linux-btrfs+bounces-17266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9925ABA9BF4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 17:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC35192244F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E701302CBE;
	Mon, 29 Sep 2025 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VqUBSoYQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QqWBjjka"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287D17736
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759158147; cv=none; b=KEGETUbnoSLGeI2ZVA28PegpVQ4+57Kmkf8TxCqjyyWeLCQlAjjNiyMVxpmcWhwuuSr1H3rRH/lI1jh6zbTNKVUBWsEd4UULo47eXBf+4vbQG3sjGu08OAvPsq5HHI+HgUpFsBcUoAilFhJx+YPssCv0X5NStN/Sw7YzKuQ6wTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759158147; c=relaxed/simple;
	bh=bSDs9RQ7jG2BNu8MHP8cER/ZtIe4YmCOwVmzJQGECoM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j74CyCgtvrvOc70jW/5fJXxql7ZEurwdNozgeyYQ0rXLxosWKJ7gNYhEyKm4sHxM4Ovi0dMTNboNr2U8JydGNLfko86gcD6bh/kjWwLtnp+560nKb5qnrlRRpE71K4Nr7CnohVPmYmb+fSlA/40K8kv7J/fDhrCGwh1BMa0yDQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VqUBSoYQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QqWBjjka; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52A2D331FF
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759158143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qmtrUBDqA87UOFNyNqV3mfkgZ+swFWVoymrUmkx5V+c=;
	b=VqUBSoYQHZB0wTIamC+7epQKWMBOI9QiEPbqmdPzdni2TT+GJLE3aan0K9TKVkRFQMUIlm
	ag1a61980NQQZC71iNBJ+fvyuw8YG6D9s6NXAccZ0FzU0zTWEgubESTGupP1w38engH3sn
	M21NolVqhc/eVV6ezD42m5ZuDIIUFEo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QqWBjjka
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759158142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qmtrUBDqA87UOFNyNqV3mfkgZ+swFWVoymrUmkx5V+c=;
	b=QqWBjjkaNrOMIQEaxjuwnt217UPBW56pjXyXU8s8Mb3wv7FG+kcBM11TzIMYSni6IpLZh/
	EQswLsGn1cx423LTzR/Z9q7dGwyKaq97Vv0ZDksG0S8WTGAW69jsj36rVjNZgkQmBr+KXD
	a90aANuWkpKVzCu19N+wxLYILJ+BtaU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C09A13782
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 15:02:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HhKMEn6f2mgTPAAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 15:02:22 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.17
Date: Mon, 29 Sep 2025 17:02:16 +0200
Message-ID: <20250929150217.1186-1-dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 52A2D331FF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Hi,

btrfs-progs version 6.17 have been released.

Changelog:

* inspect list-chunks: more sorting keys, descending order
* fi resize: add support for offline (unmounted) growing of single device
* device stats: add support for offline (unmounted) reads
* quota status: new command, overview what mode is enabled, tunables
* fi commit-stats: new command, print various commit stats from sysfs (since kernel 6.1)
* balance start: print warning and delay start if there's a missing device in the filesystem
* mkfs: print zoned mode (native, emulated)
* check: verify device bytes in super block item and in chunk tree
* other
  * updated CI, new and updated tests
  * cleanups, refactoring
  * documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.17
Python: https://pypi.org/project/btrfsutil/

