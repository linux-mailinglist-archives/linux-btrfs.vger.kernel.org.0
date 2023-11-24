Return-Path: <linux-btrfs+bounces-334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C297A7F69AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 01:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDF4281341
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 00:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC1039F;
	Fri, 24 Nov 2023 00:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dL9wOegh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199EDA3;
	Thu, 23 Nov 2023 16:07:47 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 8889921A42;
	Fri, 24 Nov 2023 00:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700784465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1DNz5BgB2a5NvbFDDyPXdhdKTF7wD1DOf5f/xYzwvXk=;
	b=dL9wOegh7D0O36IY8v+qmL0HoKCTPzy2FXmicKqpwvbgpJ63Ybz3WcvUPrlkHck3EIm4v9
	UyI75ToNfwHcn9JnpraG51D1dfrwXa/T2JfPDlpJg0iaFwgzN5ymFTeXT9QGVEDuQEk3sk
	k7Hc8IpZ9wrS0Ie5O+jFJ8OoO2Jm5kY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 7D58D2C15C;
	Fri, 24 Nov 2023 00:07:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 3A82BDA86C; Fri, 24 Nov 2023 01:00:36 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: fix 64bit compat send ioctl arguments not initializing version member
Date: Fri, 24 Nov 2023 01:00:34 +0100
Message-ID: <20231124000034.27522-1-dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [25.42 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 BAYES_SPAM(0.42)[73.10%];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_NO_TLS_LAST(0.10)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz]
X-Spam-Score: 25.42
X-Rspamd-Queue-Id: 8889921A42

When the send protocol versioning was added in 5.16 e77fbf990316
("btrfs: send: prepare for v2 protocol"), the 32/64bit compat code was
not updated (added by 2351f431f727 ("btrfs: fix send ioctl on 32bit with
64bit kernel")), missing the version struct member. The compat code is
probably rarely used, nobody reported any bugs.

Found by tool https://github.com/jirislaby/clang-struct .

Fixes: 2351f431f727 ("btrfs: fix send ioctl on 32bit with 64bit kernel")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dfe257e1845b..4e50b62db2a8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4356,6 +4356,7 @@ static int _btrfs_ioctl_send(struct inode *inode, void __user *argp, bool compat
 		arg->clone_sources = compat_ptr(args32.clone_sources);
 		arg->parent_root = args32.parent_root;
 		arg->flags = args32.flags;
+		arg->version = args32.version;
 		memcpy(arg->reserved, args32.reserved,
 		       sizeof(args32.reserved));
 #else
-- 
2.42.1


