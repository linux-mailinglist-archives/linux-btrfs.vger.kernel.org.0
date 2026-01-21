Return-Path: <linux-btrfs+bounces-20851-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJXMCz0YcWmodQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20851-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:17:33 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F83F5B296
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 19:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29429A28621
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7364963DC;
	Wed, 21 Jan 2026 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fju4TvC/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE834963C6
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013061; cv=none; b=PFNmTRnSikmT4nxCYP2ak44couDRO/s5lvRJVPmumMxgNI4dI4uhMKQTe/dZE3O15aL4GnyhTtNlo2snkesosIgxIUZLVjDfJPf37SNkOlaJ2Cx16iosIFQ1ixMYutD69oxveHfRO7TO4OsdTC/8xvbL3+LjdkADoMVrwqm/nFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013061; c=relaxed/simple;
	bh=AFX21W9vR8YpM42S6GNoRm6OKklQMMJbuHfdq6MEIbU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcAi7xBWekxE1SDOg7Wqc2UewSjbujyE/FHSyOnVRXWH4PabRFn1DHn3UPyWuTlg2MZAEZhFIZdCs9+jQOczX8KyYFLuZiWrSQzYuYy8cvZKsLid5uqoXFYq8ZW1HIGWzM0w6wzIYXViJCwnUtCWK+c8j3Tbou+i0ZdzwyraehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fju4TvC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412C5C19421
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013058;
	bh=AFX21W9vR8YpM42S6GNoRm6OKklQMMJbuHfdq6MEIbU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fju4TvC/NICi00m1nm32HLeg0wSVL5tsMVMPwrJznoD0r7LHR+Hg7Oib0G+3vEnol
	 LfVKrCkL5yFIz6Yh24+sWrxdLCRw0EXy7NiAmtxVwdxKcmWGc6qnlsT56l5nQ8EAed
	 7bQAEifsTC74t8DEnGJwOk4J1pKm8HpTfnOuLGhNw+C5NtBvJScEBGwHOrnqWEGz+V
	 ROCKkVINuRxxIJht6S+Q38pmT2Ih/apa9GcTFuAHuOsCs7D7bahxyT0lnoVoSmwSt4
	 TpjwXDFOSz99wxYjJYzUyLScJDkn0K0mMKGboV4BucprMx58qEzqisJEcm137IkIxC
	 CF6HmhwnKiJ/Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/19] btrfs: remove out_failed label in find_lock_delalloc_range()
Date: Wed, 21 Jan 2026 16:30:37 +0000
Message-ID: <f48362da81ba92808783c06d91f07691f5da8741.1769012877.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1769012876.git.fdmanana@suse.com>
References: <cover.1769012876.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20851-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 8F83F5B296
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There is no point in having the label since all it does is return the
value in the 'found' variable. Instead make every goto return directly
and remove the label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dfc17c292217..3df399dc8856 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -440,8 +440,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 			loops = 1;
 			goto again;
 		} else {
-			found = false;
-			goto out_failed;
+			return false;
 		}
 	}
 
@@ -461,7 +460,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	}
 	*start = delalloc_start;
 	*end = delalloc_end;
-out_failed:
+
 	return found;
 }
 
-- 
2.47.2


