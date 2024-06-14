Return-Path: <linux-btrfs+bounces-5733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509E29082E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 06:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EE91C2180C
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 04:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCAC146D71;
	Fri, 14 Jun 2024 04:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jSZrCIEc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jSZrCIEc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4120C1459E0
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 04:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718338967; cv=none; b=SV3tpOsyBORQWftj+XxJeAPKB/vkdqZjOMZOdxbWgjjOFfZln8SQ7ZaJLCBrxsqEclR3o0xXp5yIGTZbjzh8uK+QQHYX2gfqteI0VWGY7aTM2jZXw1maaYfYgSS0rwr0/BgnshlXXItRMGS6n+LXqBctQJUEzZLt0IF674q+Tsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718338967; c=relaxed/simple;
	bh=4LuCjIQDIdZvh31pS90EbpdTesUdVwcRt4snbiBT7VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sj5EUxaSjeWLmT9CGm/nknRWe7OpFiAtI0S9S2z5rW5B5D1yeEWJNyigEFU+7708AIUGN+QW41Wtgu4DvvSQzB+y5rzDXAxjcO04D+chYEeMY4K9PW2Ywi7leZpB6KVBwIuHY4guHc8FWI+1LXvIFBC2hNwvAu1dEowAGT5Tfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jSZrCIEc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jSZrCIEc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 789091FFDA;
	Fri, 14 Jun 2024 04:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718338963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQFLSZgWMDMPwKksyNC4Z8tgp5h0uyq99Dumqvt07Ck=;
	b=jSZrCIEcgu4zehyTPnlgoUd+ZwPZZVMh2449smI+j8dQtUaRiQM/iVyq4efxE53ZPZPOha
	WuxYm17am9eYNIFUKH5wuON8VxoIc1ILr0YZi7UJLv7S6mpy2Xz7KcKWDZH+AlBU3IkPKU
	rK7bEP8c9VMrxHMIeBovy53CQZEyNSw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718338963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQFLSZgWMDMPwKksyNC4Z8tgp5h0uyq99Dumqvt07Ck=;
	b=jSZrCIEcgu4zehyTPnlgoUd+ZwPZZVMh2449smI+j8dQtUaRiQM/iVyq4efxE53ZPZPOha
	WuxYm17am9eYNIFUKH5wuON8VxoIc1ILr0YZi7UJLv7S6mpy2Xz7KcKWDZH+AlBU3IkPKU
	rK7bEP8c9VMrxHMIeBovy53CQZEyNSw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AC4813AAD;
	Fri, 14 Jun 2024 04:22:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sEniAJLFa2YBJQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 14 Jun 2024 04:22:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 2/4] btrfs: output the unrecognized super flags as hex
Date: Fri, 14 Jun 2024 13:52:29 +0930
Message-ID: <735947d2e7b9e112c3b9b1f33396144662ba3f8f.1718338860.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718338860.git.wqu@suse.com>
References: <cover.1718338860.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.23
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.23 / 50.00];
	BAYES_HAM(-2.43)[97.40%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

Most of the extra suepr flags are beyond 32bits (from CHANGING_FSID_V2
to CHANGING_*_CSUMS), thus using %llu is not only too long and pretty
hard to read.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5870e76d20e2..92661d8ebf76 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2347,7 +2347,7 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 	if (btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP) {
-		btrfs_err(fs_info, "unrecognized or unsupported super flag: %llu",
+		btrfs_err(fs_info, "unrecognized or unsupported super flag: 0x%llx",
 				btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP);
 		ret = -EINVAL;
 	}
-- 
2.45.2


