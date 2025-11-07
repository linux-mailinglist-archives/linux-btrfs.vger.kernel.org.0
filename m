Return-Path: <linux-btrfs+bounces-18794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D34C3F178
	for <lists+linux-btrfs@lfdr.de>; Fri, 07 Nov 2025 10:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234AA3B0731
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Nov 2025 09:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492DC316918;
	Fri,  7 Nov 2025 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="orUAgzCL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="orUAgzCL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B33161BD
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506712; cv=none; b=BW9CIijBmah1E9KiqaeBSxB2dkw+LDupkAJd4TR2PVxTDdyWO+uzVxVOQ5ycxqF4yGsMf+1Z+WP4A2oK/wWmXxzgTdUgt0W9fS/hzskCzc2x57Z+4E63/wNm6brSbxHagwpT1tfKbIyy7I7RVKnxhGM1DfNWwyWp1Kl/BSAqFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506712; c=relaxed/simple;
	bh=EjBR4S8Q84VYve46wu0p2T78jdxj2Ll/8kxau9AauVs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gOglVEwwg65jzxYq6yx+qJ9XwH0wMJuingPmsMI7/Mdnk9OtuHyI5pRpu1iGt+MSqgeix4YK8DvQmYhntbke5cm71uqRAanWKYPmkcLrA87wh6Moq//LP16US+cPpnw82If6emsnz4oPIPORhkSgXfou0Y/x5b65GMb/16xjyok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=orUAgzCL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=orUAgzCL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6AD721F790
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762506708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ikAShzp98/sr2zo/4KKksVQKstEHQfFMC8vO7OxGgvY=;
	b=orUAgzCL4yXUJtsuilCumZ0QBLU4CxL2hXQXSaILFg40nA31tNzOl6luSmottlOGHxfIoK
	Eml+mI40jfWZNONrTMATPUSPAlXMKrUm7yfUn9iq+I5JOKUawrWu1Q4HA5anPYjFsIhqHs
	m2dFwjnr7E+xYpWEgsyWdGbrTGf2KW4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762506708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ikAShzp98/sr2zo/4KKksVQKstEHQfFMC8vO7OxGgvY=;
	b=orUAgzCL4yXUJtsuilCumZ0QBLU4CxL2hXQXSaILFg40nA31tNzOl6luSmottlOGHxfIoK
	Eml+mI40jfWZNONrTMATPUSPAlXMKrUm7yfUn9iq+I5JOKUawrWu1Q4HA5anPYjFsIhqHs
	m2dFwjnr7E+xYpWEgsyWdGbrTGf2KW4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 659A1132DD
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 09:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LnbIGNS3DWn4cgAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 07 Nov 2025 09:11:48 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.17.1
Date: Fri,  7 Nov 2025 10:11:46 +0100
Message-ID: <20251107091148.22554-1-dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi,

btrfs-progs version 6.17.1 have been released. This is a bugfix release.

Changelog:

* dump-tree: print compat-ro bit for fs-verity
* check: add ability to repair orphan device extents so kernel does not
  refuse to mount such filesystem due to strict checks
* convert:
  * print label if it's being copied from the source filesystem
  * drop alignment check of chunk length, kernel workaround is in place
* scrub and device replace: document behaviour in 6.19+ that
  freezing/suspend will cancel the operation
* other:
  * documentation fixes and updates
  * updated tests

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.17.1

