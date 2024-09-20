Return-Path: <linux-btrfs+bounces-8138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE7997CFB2
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 02:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410FF1C22641
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Sep 2024 00:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9542F8F6C;
	Fri, 20 Sep 2024 00:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pIJ+opcg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OOHIiw5H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA6B644
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726792976; cv=none; b=EVE6hZWcefyua2xzLbkDRkFYXxToZ9hXerBBAdAJQMO3/WracIoFSAz0ombzKynWjIYbAIdgEN6t11xPkuP4tf4a9Me+vopXpeS5amx14WDRlgf2+Tr5Q8lxUsGh3LBq1b7Ch19HMnBz25S2j1pHQLJMx0fljhiFQKMY+ew7SBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726792976; c=relaxed/simple;
	bh=9sDI7WN6YCEezJ8iG90Idr6dreJ681Ppe3ckYD+0TY8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=r/8n3ketv9diPmlNGRXXvAPbzAdLT9LsQ9wrVwm099+3aIge9+JZST/rdfbaxU9RchRG5fbNaKdStDwsYUhazpfm/SqDe3ma+hH5a6N8kjQtxnDR2XiQoU8ZpsppiESpqEodsIMN8kccE0mK1k13dLDvWrMAofgOtQ/Zw1ZPU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pIJ+opcg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OOHIiw5H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 759DD1F7E8
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 00:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726792972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VWtG1TrCHAzahDdAnqenXqY3wEDiQ16mSsuyxM3Ywx8=;
	b=pIJ+opcgaHc3pkswZNsqZ5mW4HnMUbl6ZMVogxVMyUP5kuGb+7EX1rxp0p++nJJuUitsiP
	xFxM1qUeDvbVCzAUh85Z7hR57zvlZl5yT/P/QH+KFuhLIiSlu7i1CQ+I8SG9xlYXQuCPP0
	KKL7UgWuM8kpI9aB+69jySYSLJq+jBI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OOHIiw5H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726792971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VWtG1TrCHAzahDdAnqenXqY3wEDiQ16mSsuyxM3Ywx8=;
	b=OOHIiw5H6HpbmJV3XQjN5/shwAcrn3L1zO1u3Z9cS9H8FViKVTgJzyukKPYrckdJ4AwCKP
	GUhBt2iyM9U9msskIiycef8JGEmqeQTLAmpFIEgzdrjiO9kweSuxHFvvrXYKuWdIsCYodn
	9JH8DTG6V1ggDQpLrwVB9/bcHs795oM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE9EB13AA7
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 00:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZmPWGwrF7GZZbQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Sep 2024 00:42:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: libbtrfsutil: use package_data member for header files
Date: Fri, 20 Sep 2024 10:12:32 +0930
Message-ID: <b46c1f567043f90aeda59a65dc3f826914e85f51.1726792949.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 759DD1F7E8
X-Spam-Score: -3.00
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[setup.py:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
Currently with python3.12, the python bindding will always result the
following warning:

    [PY]     libbtrfsutil
/usr/lib/python3.12/site-packages/setuptools/_distutils/extension.py:134: UserWarning: Unknown Extension options: 'headers'
  warnings.warn(msg)

[CAUSE]
In the setup.py which specifies the files to be included into the
package, we use setuptools::Extension to specify the file lists and
include paths.

But there is no handling of Extension::headers member, thus resulting
the above warning.

[FIX]
Not an expert in python, but other packages like cffi are all using
`package_data` to include the headers, so just follow them to use
`package_data` member for headers.

Fixes: 87c3fb557ef2 ("libbtrfsutil: update python setup.py for distribution")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 libbtrfsutil/python/setup.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/libbtrfsutil/python/setup.py b/libbtrfsutil/python/setup.py
index 2b30174653da..0c64399d1c5e 100755
--- a/libbtrfsutil/python/setup.py
+++ b/libbtrfsutil/python/setup.py
@@ -128,9 +128,6 @@ module = Extension(
         'qgroup.c',
         'subvolume.c',
     ],
-    headers=[
-        'btrfsutilpy.h'
-    ],
     include_dirs=['..'],
     library_dirs=['../..'],
     libraries=['btrfsutil'],
@@ -144,6 +141,7 @@ setup(
     description='Library for managing Btrfs filesystems',
     long_description=read_readme(),
     long_description_content_type='text/markdown',
+	package_data = { "btrfstuil" : [ "btrfsutilpy.h" ] },
     url='https://github.com/kdave/btrfs-progs',
     license='LGPLv2+',
     cmdclass={'build_ext': my_build_ext},
-- 
2.46.0


