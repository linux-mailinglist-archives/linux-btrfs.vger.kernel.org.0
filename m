Return-Path: <linux-btrfs+bounces-8149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7022297DB70
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Sep 2024 04:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D7A1B21E84
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Sep 2024 02:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845AE14F6C;
	Sat, 21 Sep 2024 02:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dP4u5WFk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dP4u5WFk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370923D2
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726885613; cv=none; b=tsPf9vY/jX+C0LAtD7A6Shfuhk6iAc3Rf6XcKg/GPRv8dhhCRfTLrlPfP+AewyTfYXSf/B3jIzYyiaVfbaYYEbRQFhCBGQzPkalYynAjxv96Zf3HfJhZoIBMKuzxUUv//LV6+Ijp7ioeC17W5oShSLZuGBb2BGkSvDS01Tvf1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726885613; c=relaxed/simple;
	bh=O07yCB4aZ0WmFdILpizWV8G295aXOVt+lVK8/2ENask=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MUAY2KX/jB00fU12TuPEDXQtOZHGgw1d2OoTWeb/jjGDUOxSGXJcKCnRy2vUzSSJVRS8IQjoH8I7rj12q4GdUfa87jbeVoTr0bGaRQLq7NfpNZr3uCFnaxpbmxBSaK/XmdwID+gw3oMFVgXDjIFhUt9G0/eqmP4OblL25jVTXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dP4u5WFk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dP4u5WFk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6423333A7B
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726885609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q0iVi3ogoeN5MUnez9wOo/PED/G424ifueZnI2nVloo=;
	b=dP4u5WFk2wSaee7CBSfbrMA9QuHGg66EAxfYYPkw42W8eXv0DylsnmNiApnwi8lbsJDxW/
	HKPLXWR6mlqh7+Zeify/Xc4Ol/xs+PaEQcY4ydxIrLWwmMV8m69gW3Ifd3+jJDMEV21Kls
	MPViGZgloii2gUdn9Fx/LcZFALOa6A0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dP4u5WFk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726885609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q0iVi3ogoeN5MUnez9wOo/PED/G424ifueZnI2nVloo=;
	b=dP4u5WFk2wSaee7CBSfbrMA9QuHGg66EAxfYYPkw42W8eXv0DylsnmNiApnwi8lbsJDxW/
	HKPLXWR6mlqh7+Zeify/Xc4Ol/xs+PaEQcY4ydxIrLWwmMV8m69gW3Ifd3+jJDMEV21Kls
	MPViGZgloii2gUdn9Fx/LcZFALOa6A0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CF7913882
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /k5PF+gu7malAQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: libbtrfsutil/python: fix all the warnings
Date: Sat, 21 Sep 2024 11:56:23 +0930
Message-ID: <cover.1726885304.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6423333A7B
X-Spam-Level: 
X-Spamd-Result: default: False [-2.83 / 50.00];
	BAYES_HAM(-2.83)[99.25%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.19)[-0.961];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.83
X-Spam-Flag: NO

There are the following warnings when building the python binding the
proper way (directly calling "setup.py build" is no longer recommended):

 $ python -m build btrfs-progs/libbtrfsutil/python
 * Creating isolated environment: venv+pip...
 * Installing packages in isolated environment:
   - setuptools >= 40.8.0
 * Getting build dependencies for sdist...
 /tmp/build-env-2u6q_udl/lib/python3.12/site-packages/setuptools/_distutils/extension.py:139: UserWarning: Unknown Extension options: 'headers'
   warnings.warn(msg)
 * Building sdist...
 /tmp/build-env-2u6q_udl/lib/python3.12/site-packages/setuptools/_distutils/extension.py:139: UserWarning: Unknown Extension options: 'headers'
   warnings.warn(msg)
 writing manifest file 'btrfsutil.egg-info/SOURCES.txt'
 warning: sdist: standard file not found: should have one of README, README.rst, README.txt, README.md

This patch fixes them by:

- Use MANIFEST.in to properly include the "btrfsutilpy.h"
- Remove unnecessary build options for C files
- Reuse the existing README.md by a softlink
  So that even in a virtual environment the README.md will still be
  properly copied.

TODO: Migrate the "python setup.py build" system to "python -m build"
for building and tox for tests.

Qu Wenruo (3):
  btrfs-progs: libbtrfsutil/python: use MANIFEST.in for headers
  btrfs-progs: libbtrfsutil/python: remove unnecessary build options
  btrfs-progs: libbtrfsutil/python: reuse existing README.md for long
    description

 libbtrfsutil/python/MANIFEST.in | 1 +
 libbtrfsutil/python/README.md   | 1 +
 libbtrfsutil/python/setup.py    | 7 ++-----
 3 files changed, 4 insertions(+), 5 deletions(-)
 create mode 100644 libbtrfsutil/python/MANIFEST.in
 create mode 120000 libbtrfsutil/python/README.md

--
2.46.1


